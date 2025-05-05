-- Create Database
CREATE DATABASE ClinicDB;
USE ClinicDB;

-- Departments Table
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Patients Table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Treatments Table
CREATE TABLE Treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    cost DECIMAL(10, 2) NOT NULL
);

-- Appointment_Treatments (Many-to-Many)
CREATE TABLE Appointment_Treatments (
    appointment_id INT,
    treatment_id INT,
    PRIMARY KEY (appointment_id, treatment_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id),
    FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id)
);

-- Prescriptions Table (1-to-1 with Appointment)
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE,
    notes TEXT,
    prescribed_date DATE DEFAULT CURDATE(),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Sample Data
INSERT INTO Departments (name) VALUES
('Cardiology'), ('Neurology'), ('Pediatrics');

INSERT INTO Doctors (name, specialization, department_id) VALUES
('Dr. John Smith', 'Cardiologist', 1),
('Dr. Alice Brown', 'Neurologist', 2),
('Dr. Mark Green', 'Pediatrician', 3);

INSERT INTO Patients (name, dob, gender, phone) VALUES
('Jane Doe', '1990-04-15', 'Female', '0700123456'),
('Bob Johnson', '1985-11-23', 'Male', '0700789456');

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-05-10 09:00:00', 'Scheduled'),
(2, 2, '2025-05-11 10:30:00', 'Completed');

INSERT INTO Treatments (name, cost) VALUES
('ECG', 1500.00),
('MRI Scan', 5000.00),
('Vaccination', 800.00);

INSERT INTO Appointment_Treatments (appointment_id, treatment_id) VALUES
(1, 1),
(2, 2),
(2, 3);

INSERT INTO Prescriptions (appointment_id, notes) VALUES
(2, 'Patient to take pain relief tablets twice a day for one week.');
