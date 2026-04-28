create database SalesManagement;
use SalesManagement;
create table products (
	id int primary key auto_increment,
    product_name varchar (30) not null,
    hang_san_xuat varchar (30) not null,
    price int not null,
    stock int default 0
);

create table customers (
	id int primary key auto_increment,
    customer_name varchar (30) not null,
    email varchar (30) not null unique,
    phone varchar (15),
    address varchar (50) not null
);

create table orders (
	id int primary key auto_increment,
    created_at timestamp default current_timestamp(),
    total_amount int,
    customer_id int not null,
    constraint fk_customer_id 
		foreign key (customer_id)
        references customers (id)
);

create table order_details (
	order_id int not null,
    product_id int not null,
    quantity int not null check (quantity >0),
    sale_price int not null,
    primary key (order_id, product_id),
    constraint fk_order_id
		foreign key (order_id)
		references orders(id) on delete cascade,
	constraint fk_product_id
		foreign key (product_id)
        references products(id)
);

alter table orders add column note text;
alter table products change column hang_san_xuat nha_san_xuat varchar(50) not null;

drop table order_details;
drop table orders;
-- Phải xóa bảng order_details trước tại vì có ràng buộc khóa ngoại.

insert into products (product_name, nha_san_xuat, price, stock) 
values ('Macbook Air M2', 'Apple', 26000000, 50),
('Lenovo khung', 'LOQ', 30000000, 20),
('Iphone 17 pro max', 'Apple', 35000000, 100),
('Xiaomi note 14t Pro', 'Xiaomi', 14000000, 20),
('Kính cường lực Kingkong', 'Xiaomi', 100000, 1000)
;
insert into customers (customer_name, email, phone, address) 
values ('Hoang Duong Nam', 'hoangduongpb.2k6@gmail.com' , '0899769862', 'Đường Man Thiện'),
('Lê Hà Thanh Sang', 'LHTS@gmail.com' , '0987654321', 'Đường Lê Văn Việt'),
('Lu Nhựt Đình', 'LND@gmail.com' , '0987789654', 'Quận 8'),
('Huỳnh La Tiến Lộc', 'HLTL@gmail.com' , '0123456987', 'Đường Lò Lu'),
('Hồ Quốc Khải', 'HQK@gmail.com' , '0918273645', 'Quận Tân Bình')
;

insert into customers (customer_name, email, address)
values ('Lộc Lê', 'LL@gmail.com' , 'Quận Tân Bình')
;
insert into orders (customer_id, total_amount) 
values (1, 26000000),
(2, 100000),
(3, 14000000),
(4, 30000000),
(5, 35000000)
;

insert into order_details (order_id, product_id, quantity, sale_price) 
values (1, 1, 1, 26000000),
(2, 5, 1, 100000),
(3, 4, 1, 14000000),
(4, 2, 1, 30000000),
(5, 3, 1, 35000000)
;

update products 
set price = price * 1.1
where nha_san_xuat = 'apple';

delete from customers 
where phone is null;

select * from products 
where price between 10000000 and 20000000;

SELECT p.product_name
FROM products p
JOIN order_details od ON p.id = od.product_id
WHERE od.order_id = 1;

SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_details od ON o.id = od.order_id
JOIN products p ON od.product_id = p.id
WHERE p.product_name = 'Macbook Air M2';