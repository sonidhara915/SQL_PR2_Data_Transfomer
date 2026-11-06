CREATE DATABASE data_t;

USE data_t;


DROP TABLE Customers;

CREATE TABLE Customers(
    Customer_id INT PRIMARY KEY,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Email VARCHAR(50),
    Registration_date DATE
);


INSERT INTO customers VALUES
    (101, 'Aarav', 'Patel', 'aarav21@gmail.com', '2026-02-05'),
    (102, 'Nisha', 'Desai', 'nisha45@gmail.com', '2026-02-08'),
    (103, 'Yash', 'Shah', 'yash19@gmail.com', '2026-02-11'),
    (104, 'Riya', 'Mehta', 'riya32@gmail.com', '2026-02-14'),
    (105, 'Dev', 'Joshi', 'dev56@gmail.com', '2026-02-17');


CREATE TABLE `Order` (
    Order_id INT PRIMARY KEY,
    Customer_id INT,
    Order_date DATE,
    Total_amount DECIMAL(10,2), 
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
);
-- SQLBook: Code

INSERT INTO `Order` (Order_id, Customer_id, Order_date, Total_amount) VALUES
(501, 101, '2026-01-06', 150.50),
(502, 102, '2026-01-08', 45.00),
(503, 103, '2026-01-10', 899.99),
(504, 104, '2026-01-12', 25.75),
(505, 105, '2026-01-14', 120.00);

CREATE TABLE Employees(
    Employee_id INT PRIMARY KEY,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Department VARCHAR(50), 
    Hire_date DATE,
    Salary DECIMAL
);
-- SQLBook: Code
INSERT INTO Employees (Employee_id, First_name, Last_name, Department, Hire_date, Salary) VALUES
(1001, 'Aarav', 'Sharma', 'IT', '2023-03-15', 75000),
(1002, 'Diya', 'Patel', 'HR', '2024-01-10', 62000),
(1003, 'Kabir', 'Mehta', 'Finance', '2022-11-01', 88000),
(1004, 'Ananya', 'Joshi', 'Marketing', '2025-05-18', 55000),
(1005, 'Vivaan', 'Shah', 'IT', '2023-08-22', 78000);

--- 1 INNER JOIN - Retrive all order and customer details Where Oredr Exist.

SELECT o.Order_id, o.Order_date, o.Total_amount, c.Customer_id, c.First_name, c.Last_name
FROM `Order` o
INNER JOIN Customers c ON o.Customer_id = c.Customer_id;


-- 2 LEFT JOIN - Retrive all customers and Thire correcpanding Orders (If Any).            


SELECT c.Customer_id, c.First_name, c.Last_name, o.Order_id, o.Order_date, o.Total_amount
FROM Customers c
LEFT JOIN `Order` o ON c.Customer_id = o.Customer_id;


-- 3 RIGHT JOIN - Retrive all Order and thire corresponding customers (if any).

SELECT o.Order_id, o.Order_date, o.Total_amount, c.Customer_id, c.First_name, c.Last_name
FROM `Order` o
RIGHT JOIN Customers c ON o.Customer_id = c.Customer_id;
  

-- 4 FULL OUTER JOIN - Retrive all customers and all orders, regardless of matching.

SELECT c.Customer_id, c.First_name, c.Last_name, o.Order_id, o.Order_date, o.Total_amount
FROM Customers c
LEFT JOIN `Order` o ON c.Customer_id = o.Customer_id

UNION

SELECT c.Customer_id, c.First_name, c.Last_name, o.Order_id, o.Order_date, o.Total_amount
FROM Customers c
RIGHT JOIN `Order` o ON c.Customer_id = o.Customer_id;


-- 5 Subquery to find customers who have placed orders Worth more than Average Amount


SELECT * FROM Customers
WHERE Customer_id IN (
    SELECT Customer_id FROM `Order` 
    WHERE Total_amount > (SELECT AVG(Total_amount) FROM `Order`)
);

-- 6  Subquery to find Employees with salaries above the average Salary.

SELECT Employee_id , First_name , Last_name , Department , Total_salary
FROM Employees
WHERE Total_salary >= AVG(Total_salary)
FROM Employees;

-- 7 Extract the year and Month from the Order Date

SELECT 
    YEAR(Order_date) AS Order_Year,
    MONTH(Order_date) AS Order_Month
FROM `Order`;

-- 8 Calculate the differebce in days between two date

SELECT 
    Order_date,
    DATEDIFF(CURDATE(), Order_date) AS Days_deffrience
FROM `Order`;

-- 9 Format the Orderdate to a more readable format (DD-MM-YYYY)

SELECT 
    DATE_FORMAT(Order_date, '%d-%m-%Y') AS Formated_date
FROM `Order`;

-- 10 Convert FirstName and LastName to form a fullname

SELECT 
    TRIM(First_name) AS CleanedFirst,
    TRIM(Last_name) AS CleanedLast,
    CONCAT(TRIM(First_name), ' ', TRIM(Last_name)) AS Full_name
FROM Employees;

-- 11 Replace Part of a string



-- 12 Convert Firstname To Uppercase and Lastname to lowercase 


-- 13 Tirm extra spaces from the Email field



-- 14 Calculate the running total of Total Amount For each order

SELECT 
    Order_id, 
    Total_amount,
    SUM(Total_amount) OVER(ORDER BY Order_date, Order_id) AS Running_total
FROM `Order`;

-- 15 Rank order based on Total Amount using the RANK() Function 

SELECT 
    Order_id, 
    Total_amount,
    RANK() OVER(ORDER BY Total_amount DESC) AS OrderRank
FROM `Order`;

-- 16 Assign a discount based on Total Amount in Order

SELECT 
    Order_id,
    Customer_id,
    Order_date,
    Total_amount,
    CASE 
        WHEN Total_amount >= 900 THEN '15% Discount'
        WHEN Total_amount >= 500  THEN '10% Discount'
        WHEN Total_amount >= 100  THEN '5% Discount'
        ELSE 'No Discount'
    END AS Discount_Persentage
FROM `Order`;

-- 17 Categorize employees salaries as high . medium or Low.

SELECT Employee_id ,
    First_name ,
    Last_name ,
    Salary,           
    CASE 
        WHEN Salary <= 50000 THEN 'Low'
        WHEN Salary <= 75000 THEN 'Medium'
        ELSE 'High'
    END AS Salary_Level
FROM employees;


