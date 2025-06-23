Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE822FF22
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669574; cv=none; b=oYFw1EmyVt/McGm7GhbZkVcAZz9Fee448LhWRlyND5AMJ0TTbF/HC1eUlTgADe56QbrwIRCeNXdqILxSdnT0OWaIBW1QILIa5afDicSCuwcgeU+19kVH7wG1tdGej8HrszhbL2AGjNQXM8+tRhBtxW6ajNHoN+JuUBvErdwrSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669574; c=relaxed/simple;
	bh=yseaYF5PBdhiei4LAsX44NHWgcQPt4kouyr4tkrZEXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftNy6BJo20DbOo0L7M80qrVyA/XQMGCX4b0M8u7tEFu/3lKrf6IQ/WPlPFfAMY1rkTHKkEw1BrL7qFGSzuJxXKgBTMWyA2T+9fnlibm32KOCCNzCKOx08mON50R9GI5GxyAu/x/upRM7eYwcm2zjHeUKbk+LbGPU4vC2ezNpoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA9tl4rf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA9tl4rf"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fc7506d4so2942208b3a.0
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750669571; x=1751274371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agx5SJKxHYSvEEuujGIornbbh0naPi2D7hhWb7DBQM4=;
        b=BA9tl4rfr/5PBCeka0eETT0u5t3mZKY6UB8SdiPht6UNT4c3w5oowfjoAygvkp5nUV
         d81qL0717totBsuLMhOC8BNareC0YqSsSRDXsy08Kfpbm3/scasEuVHukVTmprpsa7/a
         V3H1JrztvFOy8RjMVYR5dOZgfwK/paSAK4T3m1Jc//23X113FTKjXb9Y80AYJUBM7jF4
         Thrh3QTe6pY3bYb3Ty5eWxOSvJB5McZFkCI8PgpDL7D8j1DLMWp79JARSr9fz16OwhCG
         LcFhGXtRF9SwMAZMXwLC+zcqJk3oBBf8iz5e+oj0SJX3uYztooSJ2BnR/0haH6oK8Zf7
         nB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669571; x=1751274371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agx5SJKxHYSvEEuujGIornbbh0naPi2D7hhWb7DBQM4=;
        b=KuURnvxJlm/FCML4sfx4cSjpN5u8U9d4/kID/S6PrIjZCoITwHNfbKUKlBpT81+5bq
         zUg0ORAUKm26NmcTEEm2vAgHHOGWW+6R4R3d+flzdjPc2T66tZ4Wv8de6kg7SP9RrTFc
         gJW/Qxs5jyBWax72BfozbP3SnO8lRtF45HxCZAaBcqJtdL9fAULxT+udwUm2m0kxXJr5
         W3WlbvRvdbTptQiXgRvyWHl4O0krevKdv8Bp48JGKPcSQoor529n0I+izRP4TVmr+ZX3
         3yuDl9r/x0tiUWpFlCgzIapP1g++3KKconwhYB1QLs9luUQJY/BTVAcBIFrPfci/6c1n
         uTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcydwKll+GA5eJzjYlgbTIYXgOWQNFyYwE6FtqHlQ/E9dBdxQR8mG62D5Os25K9y3JvzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa0ImgAmoRZ5eyqybx3FsOIgTsSB64z5IWhYQlhXyisIXcbFgZ
	Mt6GfLAqqExzCuY7Pz/oEg6q6pBaX7xjRoroKb79rNZe/s2zGR18NNJe
X-Gm-Gg: ASbGncvUHeYZE3CZMq0daG4W07GF8rQPPyfpsk+aji+GeFOuaxlvC75AKtXCAwTQLBn
	psoHfZXGJEjG1yQx1rg/Emc9XHkU+nWb+8tVoS+GrF8YoswA/LupDvoI+rQZiH0PXGTIz7xL8JO
	dm0BJOCzZQMfbohYlsMCYPiDWupw7Vqm4m3ISBsm/zQL0WV/fW1d9m8mhnuUEvHLAr2EVdqTqK6
	28fY5PrbBsgsClxFWCVAz2Iyi1BxaIIrdm+HcI6B84tPxiPCyaCyPQ3pjT6Ey+zjbYhJA2srUwN
	eg0ToQRTcX2qXHTuHdsE0muNvZ1++Cyi9WHwKbBxxocdCpfou/QlFf1vSRW7uqicql5P15X/yUV
	kfvUVa3ojwdzwQfT1HG45YwmN6oN9cNSb
X-Google-Smtp-Source: AGHT+IHnPS/jSuUahT7OpzEEy/WFWlBY8pwFMx/Oaq4YttqMxIA7WwDXo7C6BOyJVaVllSt4fzlqNA==
X-Received: by 2002:a05:6a00:2e99:b0:748:f854:b765 with SMTP id d2e1a72fcca58-7490d757251mr17672732b3a.4.1750669571015;
        Mon, 23 Jun 2025 02:06:11 -0700 (PDT)
Received: from dwmfdoom.tail99f6b6.ts.net ([177.33.100.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a623e8csm7779179b3a.83.2025.06.23.02.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:06:10 -0700 (PDT)
From: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
To: j6t@kdbg.org
Cc: derick.william.moraes@gmail.com,
	git@vger.kernel.org
Subject: [PATCH v2 4/4] t4018: add tests for javascript export type function declarations
Date: Mon, 23 Jun 2025 03:35:49 -0300
Message-ID: <20250623090538.154858-5-derick.william.moraes@gmail.com>
X-Mailer: git-send-email 2.50.0.rc0.62.g658f0ae201.dirty
In-Reply-To: <20250623090538.154858-1-derick.william.moraes@gmail.com>
References: <4deb24c2-98f2-40f8-b50c-c74485ebc10d@kdbg.org>
 <20250623090538.154858-1-derick.william.moraes@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for javascript export function declarations as in ECMAScript ES6 and CommonJS.

Signed-off-by: Derick W. de M. Frias <derick.william.moraes@gmail.com>
---
 t/t4018/javascript-dotexpors-async-anonymous-function       | 3 +++
 t/t4018/javascript-dotexports-anonymous-function            | 3 +++
 t/t4018/javascript-dotexports-arrow-function                | 4 ++++
 t/t4018/javascript-dotexports-arrow-function-2              | 4 ++++
 t/t4018/javascript-dotexports-arrow-function-3              | 1 +
 t/t4018/javascript-dotexports-assigned-function             | 1 +
 t/t4018/javascript-dotexports-async-arrow-function          | 3 +++
 t/t4018/javascript-dotexports-async-arrow-function-2        | 4 ++++
 t/t4018/javascript-dotexports-async-arrow-function-3        | 1 +
 t/t4018/javascript-dotexports-async-function                | 4 ++++
 ...javascript-dotexports-async-generator-anonymous-function | 5 +++++
 ...vascript-dotexports-async-generator-anonymous-function-2 | 5 +++++
 t/t4018/javascript-dotexports-async-generator-function      | 5 +++++
 t/t4018/javascript-dotexports-async-generator-function-2    | 5 +++++
 t/t4018/javascript-dotexports-function                      | 4 ++++
 t/t4018/javascript-dotexports-generator-anonymous-function  | 5 +++++
 .../javascript-dotexports-generator-anonymous-function-2    | 5 +++++
 t/t4018/javascript-dotexports-generator-function            | 5 +++++
 t/t4018/javascript-dotexports-generator-function-2          | 5 +++++
 t/t4018/javascript-export-arrow-function                    | 4 ++++
 t/t4018/javascript-export-async-anonymous-assigned-function | 4 ++++
 t/t4018/javascript-export-async-arrow-function              | 4 ++++
 t/t4018/javascript-export-async-function                    | 4 ++++
 ...cript-export-async-generator-anonymous-assigned-function | 4 ++++
 ...ipt-export-async-generator-anonymous-assigned-function-2 | 4 ++++
 t/t4018/javascript-export-async-generator-assigned-function | 5 +++++
 .../javascript-export-async-generator-assigned-function-2   | 5 +++++
 t/t4018/javascript-export-async-generator-function          | 5 +++++
 t/t4018/javascript-export-async-generator-function-2        | 5 +++++
 t/t4018/javascript-export-function                          | 4 ++++
 t/t4018/javascript-export-generator-assigned-function       | 6 ++++++
 t/t4018/javascript-export-generator-assigned-function-2     | 6 ++++++
 t/t4018/javascript-export-generator-function                | 5 +++++
 t/t4018/javascript-export-generator-function-2              | 5 +++++
 t/t4018/javascript-module-dotexports-anonymous-function     | 3 +++
 t/t4018/javascript-module-dotexports-arrow-function         | 4 ++++
 t/t4018/javascript-module-dotexports-arrow-function-2       | 4 ++++
 t/t4018/javascript-module-dotexports-arrow-function-3       | 1 +
 t/t4018/javascript-module-dotexports-assigned-function      | 1 +
 t/t4018/javascript-module-dotexports-async-arrow-function   | 3 +++
 t/t4018/javascript-module-dotexports-async-arrow-function-2 | 4 ++++
 t/t4018/javascript-module-dotexports-async-arrow-function-3 | 1 +
 t/t4018/javascript-module-dotexports-async-function         | 4 ++++
 ...ipt-module-dotexports-async-generator-anonymous-function | 5 +++++
 ...t-module-dotexports-async-generator-anonymous-function-2 | 5 +++++
 .../javascript-module-dotexports-async-generator-function   | 5 +++++
 .../javascript-module-dotexports-async-generator-function-2 | 5 +++++
 t/t4018/javascript-module-dotexports-function               | 4 ++++
 ...avascript-module-dotexports-generator-anonymous-function | 5 +++++
 ...ascript-module-dotexports-generator-anonymous-function-2 | 5 +++++
 t/t4018/javascript-module-dotexports-generator-function     | 5 +++++
 t/t4018/javascript-module-dotexports-generator-function-2   | 5 +++++
 52 files changed, 211 insertions(+)
 create mode 100644 t/t4018/javascript-dotexpors-async-anonymous-function
 create mode 100644 t/t4018/javascript-dotexports-anonymous-function
 create mode 100644 t/t4018/javascript-dotexports-arrow-function
 create mode 100644 t/t4018/javascript-dotexports-arrow-function-2
 create mode 100644 t/t4018/javascript-dotexports-arrow-function-3
 create mode 100644 t/t4018/javascript-dotexports-assigned-function
 create mode 100644 t/t4018/javascript-dotexports-async-arrow-function
 create mode 100644 t/t4018/javascript-dotexports-async-arrow-function-2
 create mode 100644 t/t4018/javascript-dotexports-async-arrow-function-3
 create mode 100644 t/t4018/javascript-dotexports-async-function
 create mode 100644 t/t4018/javascript-dotexports-async-generator-anonymous-function
 create mode 100644 t/t4018/javascript-dotexports-async-generator-anonymous-function-2
 create mode 100644 t/t4018/javascript-dotexports-async-generator-function
 create mode 100644 t/t4018/javascript-dotexports-async-generator-function-2
 create mode 100644 t/t4018/javascript-dotexports-function
 create mode 100644 t/t4018/javascript-dotexports-generator-anonymous-function
 create mode 100644 t/t4018/javascript-dotexports-generator-anonymous-function-2
 create mode 100644 t/t4018/javascript-dotexports-generator-function
 create mode 100644 t/t4018/javascript-dotexports-generator-function-2
 create mode 100644 t/t4018/javascript-export-arrow-function
 create mode 100644 t/t4018/javascript-export-async-anonymous-assigned-function
 create mode 100644 t/t4018/javascript-export-async-arrow-function
 create mode 100644 t/t4018/javascript-export-async-function
 create mode 100644 t/t4018/javascript-export-async-generator-anonymous-assigned-function
 create mode 100644 t/t4018/javascript-export-async-generator-anonymous-assigned-function-2
 create mode 100644 t/t4018/javascript-export-async-generator-assigned-function
 create mode 100644 t/t4018/javascript-export-async-generator-assigned-function-2
 create mode 100644 t/t4018/javascript-export-async-generator-function
 create mode 100644 t/t4018/javascript-export-async-generator-function-2
 create mode 100644 t/t4018/javascript-export-function
 create mode 100644 t/t4018/javascript-export-generator-assigned-function
 create mode 100644 t/t4018/javascript-export-generator-assigned-function-2
 create mode 100644 t/t4018/javascript-export-generator-function
 create mode 100644 t/t4018/javascript-export-generator-function-2
 create mode 100644 t/t4018/javascript-module-dotexports-anonymous-function
 create mode 100644 t/t4018/javascript-module-dotexports-arrow-function
 create mode 100644 t/t4018/javascript-module-dotexports-arrow-function-2
 create mode 100644 t/t4018/javascript-module-dotexports-arrow-function-3
 create mode 100644 t/t4018/javascript-module-dotexports-assigned-function
 create mode 100644 t/t4018/javascript-module-dotexports-async-arrow-function
 create mode 100644 t/t4018/javascript-module-dotexports-async-arrow-function-2
 create mode 100644 t/t4018/javascript-module-dotexports-async-arrow-function-3
 create mode 100644 t/t4018/javascript-module-dotexports-async-function
 create mode 100644 t/t4018/javascript-module-dotexports-async-generator-anonymous-function
 create mode 100644 t/t4018/javascript-module-dotexports-async-generator-anonymous-function-2
 create mode 100644 t/t4018/javascript-module-dotexports-async-generator-function
 create mode 100644 t/t4018/javascript-module-dotexports-async-generator-function-2
 create mode 100644 t/t4018/javascript-module-dotexports-function
 create mode 100644 t/t4018/javascript-module-dotexports-generator-anonymous-function
 create mode 100644 t/t4018/javascript-module-dotexports-generator-anonymous-function-2
 create mode 100644 t/t4018/javascript-module-dotexports-generator-function
 create mode 100644 t/t4018/javascript-module-dotexports-generator-function-2

diff --git a/t/t4018/javascript-dotexpors-async-anonymous-function b/t/t4018/javascript-dotexpors-async-anonymous-function
new file mode 100644
index 0000000000..9f970a2343
--- /dev/null
+++ b/t/t4018/javascript-dotexpors-async-anonymous-function
@@ -0,0 +1,3 @@
+exports.RIGHT = async function(a, b) {
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-dotexports-anonymous-function b/t/t4018/javascript-dotexports-anonymous-function
new file mode 100644
index 0000000000..2fa9775c95
--- /dev/null
+++ b/t/t4018/javascript-dotexports-anonymous-function
@@ -0,0 +1,3 @@
+exports.RIGHT = function(a, b) {
+    return a + b; //ChangeMe
+};
diff --git a/t/t4018/javascript-dotexports-arrow-function b/t/t4018/javascript-dotexports-arrow-function
new file mode 100644
index 0000000000..a7d9741e90
--- /dev/null
+++ b/t/t4018/javascript-dotexports-arrow-function
@@ -0,0 +1,4 @@
+exports.RIGHT = (a, b) => {	
+
+    return a+b; //ChangeMe
+};
diff --git a/t/t4018/javascript-dotexports-arrow-function-2 b/t/t4018/javascript-dotexports-arrow-function-2
new file mode 100644
index 0000000000..f9cd237bb8
--- /dev/null
+++ b/t/t4018/javascript-dotexports-arrow-function-2
@@ -0,0 +1,4 @@
+exports.RIGHT = a => {	
+
+    return a+1; //ChangeMe
+};
diff --git a/t/t4018/javascript-dotexports-arrow-function-3 b/t/t4018/javascript-dotexports-arrow-function-3
new file mode 100644
index 0000000000..cc3f1ec017
--- /dev/null
+++ b/t/t4018/javascript-dotexports-arrow-function-3
@@ -0,0 +1 @@
+exports.RIGHT = a => a+1; //ChangeMe
diff --git a/t/t4018/javascript-dotexports-assigned-function b/t/t4018/javascript-dotexports-assigned-function
new file mode 100644
index 0000000000..308cc37095
--- /dev/null
+++ b/t/t4018/javascript-dotexports-assigned-function
@@ -0,0 +1 @@
+exports.RIGHT = PreviousFunction; //ChangeMe
diff --git a/t/t4018/javascript-dotexports-async-arrow-function b/t/t4018/javascript-dotexports-async-arrow-function
new file mode 100644
index 0000000000..01df800f19
--- /dev/null
+++ b/t/t4018/javascript-dotexports-async-arrow-function
@@ -0,0 +1,3 @@
+exports.RIGHT = async (a, b) => {
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-dotexports-async-arrow-function-2 b/t/t4018/javascript-dotexports-async-arrow-function-2
new file mode 100644
index 0000000000..453da8fcb4
--- /dev/null
+++ b/t/t4018/javascript-dotexports-async-arrow-function-2
@@ -0,0 +1,4 @@
+exports.RIGHT = async a => {
+    
+    return a + 1; // ChangeMe
+};
diff --git a/t/t4018/javascript-dotexports-async-arrow-function-3 b/t/t4018/javascript-dotexports-async-arrow-function-3
new file mode 100644
index 0000000000..74b028cf1c
--- /dev/null
+++ b/t/t4018/javascript-dotexports-async-arrow-function-3
@@ -0,0 +1 @@
+exports.RIGHT = async a => a + 1; // ChangeMe
diff --git a/t/t4018/javascript-dotexports-async-function b/t/t4018/javascript-dotexports-async-function
new file mode 100644
index 0000000000..88b3539544
--- /dev/null
+++ b/t/t4018/javascript-dotexports-async-function
@@ -0,0 +1,4 @@
+exports.RIGHT = async function ChangeMe(a, b) {
+    
+    return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-dotexports-async-generator-anonymous-function b/t/t4018/javascript-dotexports-async-generator-anonymous-function
new file mode 100644
index 0000000000..9e90bdf489
--- /dev/null
+++ b/t/t4018/javascript-dotexports-async-generator-anonymous-function
@@ -0,0 +1,5 @@
+exports.RIGHT = async function* () {
+    
+    yield 1;
+    yield 2; // ChangeMe
+};
diff --git a/t/t4018/javascript-dotexports-async-generator-anonymous-function-2 b/t/t4018/javascript-dotexports-async-generator-anonymous-function-2
new file mode 100644
index 0000000000..efe2abe4f7
--- /dev/null
+++ b/t/t4018/javascript-dotexports-async-generator-anonymous-function-2
@@ -0,0 +1,5 @@
+exports.RIGHT = async function *() {
+    
+    yield 1;
+    yield 2; // ChangeMe
+};
diff --git a/t/t4018/javascript-dotexports-async-generator-function b/t/t4018/javascript-dotexports-async-generator-function
new file mode 100644
index 0000000000..5d352b5f29
--- /dev/null
+++ b/t/t4018/javascript-dotexports-async-generator-function
@@ -0,0 +1,5 @@
+exports.RIGHT = async function* ChangeMe() {
+    
+    yield 1;
+    yield 2;
+}
diff --git a/t/t4018/javascript-dotexports-async-generator-function-2 b/t/t4018/javascript-dotexports-async-generator-function-2
new file mode 100644
index 0000000000..cddc4f9628
--- /dev/null
+++ b/t/t4018/javascript-dotexports-async-generator-function-2
@@ -0,0 +1,5 @@
+exports.RIGHT = async function *ChangeMe() {
+    
+    yield 1;
+    yield 2;
+}
diff --git a/t/t4018/javascript-dotexports-function b/t/t4018/javascript-dotexports-function
new file mode 100644
index 0000000000..4c0c622d13
--- /dev/null
+++ b/t/t4018/javascript-dotexports-function
@@ -0,0 +1,4 @@
+exports.RIGHT = function ChangeMe(a, b) {
+    
+    return a + b; 
+};
diff --git a/t/t4018/javascript-dotexports-generator-anonymous-function b/t/t4018/javascript-dotexports-generator-anonymous-function
new file mode 100644
index 0000000000..4899abbb7b
--- /dev/null
+++ b/t/t4018/javascript-dotexports-generator-anonymous-function
@@ -0,0 +1,5 @@
+exports.RIGHT = function* () {
+    
+    yield 1;
+    yield 2; // ChangeMe
+}
diff --git a/t/t4018/javascript-dotexports-generator-anonymous-function-2 b/t/t4018/javascript-dotexports-generator-anonymous-function-2
new file mode 100644
index 0000000000..1f1e9995b2
--- /dev/null
+++ b/t/t4018/javascript-dotexports-generator-anonymous-function-2
@@ -0,0 +1,5 @@
+exports.RIGHT = function *() {
+    
+    yield 1;
+    yield 2; // ChangeMe
+};
diff --git a/t/t4018/javascript-dotexports-generator-function b/t/t4018/javascript-dotexports-generator-function
new file mode 100644
index 0000000000..837646cacc
--- /dev/null
+++ b/t/t4018/javascript-dotexports-generator-function
@@ -0,0 +1,5 @@
+exports.RIGHT = function* ChangeMe() {
+
+    yield 1;
+    yield 2;
+}
diff --git a/t/t4018/javascript-dotexports-generator-function-2 b/t/t4018/javascript-dotexports-generator-function-2
new file mode 100644
index 0000000000..0cc3729220
--- /dev/null
+++ b/t/t4018/javascript-dotexports-generator-function-2
@@ -0,0 +1,5 @@
+exports.RIGHT = function *ChangeMe() {
+
+    yield 1;
+    yield 2;
+}
diff --git a/t/t4018/javascript-export-arrow-function b/t/t4018/javascript-export-arrow-function
new file mode 100644
index 0000000000..098b457924
--- /dev/null
+++ b/t/t4018/javascript-export-arrow-function
@@ -0,0 +1,4 @@
+export const RIGHT = (a, b) => {
+    
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-export-async-anonymous-assigned-function b/t/t4018/javascript-export-async-anonymous-assigned-function
new file mode 100644
index 0000000000..0a36b97838
--- /dev/null
+++ b/t/t4018/javascript-export-async-anonymous-assigned-function
@@ -0,0 +1,4 @@
+export const RIGHT = async function(a, b) {
+    
+    return a + b; //ChangeMe
+};
diff --git a/t/t4018/javascript-export-async-arrow-function b/t/t4018/javascript-export-async-arrow-function
new file mode 100644
index 0000000000..557bcd1c23
--- /dev/null
+++ b/t/t4018/javascript-export-async-arrow-function
@@ -0,0 +1,4 @@
+export const RIGHT = async (a, b) => {
+    
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-export-async-function b/t/t4018/javascript-export-async-function
new file mode 100644
index 0000000000..169f4eeed3
--- /dev/null
+++ b/t/t4018/javascript-export-async-function
@@ -0,0 +1,4 @@
+export async function RIGHT(a, b) {
+
+    return a + b; // ChangeMe
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-export-async-generator-anonymous-assigned-function b/t/t4018/javascript-export-async-generator-anonymous-assigned-function
new file mode 100644
index 0000000000..11ee37b2bc
--- /dev/null
+++ b/t/t4018/javascript-export-async-generator-anonymous-assigned-function
@@ -0,0 +1,4 @@
+export const RIGHT = async function* () {
+    yield 1;
+    yield 2; // ChangeMe
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-export-async-generator-anonymous-assigned-function-2 b/t/t4018/javascript-export-async-generator-anonymous-assigned-function-2
new file mode 100644
index 0000000000..6bff23ed2b
--- /dev/null
+++ b/t/t4018/javascript-export-async-generator-anonymous-assigned-function-2
@@ -0,0 +1,4 @@
+export const RIGHT = async function *() {
+    yield 1;
+    yield 2; // ChangeMe
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-export-async-generator-assigned-function b/t/t4018/javascript-export-async-generator-assigned-function
new file mode 100644
index 0000000000..3d5b1e0879
--- /dev/null
+++ b/t/t4018/javascript-export-async-generator-assigned-function
@@ -0,0 +1,5 @@
+export const RIGHT = async function* ChangeMe() {
+
+    yield 1;
+    yield 2;
+};
diff --git a/t/t4018/javascript-export-async-generator-assigned-function-2 b/t/t4018/javascript-export-async-generator-assigned-function-2
new file mode 100644
index 0000000000..31c674f150
--- /dev/null
+++ b/t/t4018/javascript-export-async-generator-assigned-function-2
@@ -0,0 +1,5 @@
+export const RIGHT = async function *ChangeMe() {
+    
+    yield 1;
+    yield 2;
+};
diff --git a/t/t4018/javascript-export-async-generator-function b/t/t4018/javascript-export-async-generator-function
new file mode 100644
index 0000000000..548589e597
--- /dev/null
+++ b/t/t4018/javascript-export-async-generator-function
@@ -0,0 +1,5 @@
+export async function* RIGHT() {
+    
+    yield 1;
+    yield 2; // ChangeMe
+}
diff --git a/t/t4018/javascript-export-async-generator-function-2 b/t/t4018/javascript-export-async-generator-function-2
new file mode 100644
index 0000000000..99167142d7
--- /dev/null
+++ b/t/t4018/javascript-export-async-generator-function-2
@@ -0,0 +1,5 @@
+export async function *RIGHT() {
+
+    yield 1;
+    yield 2; // ChangeMe
+}
diff --git a/t/t4018/javascript-export-function b/t/t4018/javascript-export-function
new file mode 100644
index 0000000000..32f38c36c6
--- /dev/null
+++ b/t/t4018/javascript-export-function
@@ -0,0 +1,4 @@
+export function RIGHT(a, b) {
+
+    return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-export-generator-assigned-function b/t/t4018/javascript-export-generator-assigned-function
new file mode 100644
index 0000000000..30398cd805
--- /dev/null
+++ b/t/t4018/javascript-export-generator-assigned-function
@@ -0,0 +1,6 @@
+export const RIGHT = function* () {
+
+    yield 1;
+    yield 2; // ChangeMe
+    
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-export-generator-assigned-function-2 b/t/t4018/javascript-export-generator-assigned-function-2
new file mode 100644
index 0000000000..04d2021af5
--- /dev/null
+++ b/t/t4018/javascript-export-generator-assigned-function-2
@@ -0,0 +1,6 @@
+export const RIGHT = function *() {
+
+    yield 1;
+    yield 2; // ChangeMe
+    
+};
\ No newline at end of file
diff --git a/t/t4018/javascript-export-generator-function b/t/t4018/javascript-export-generator-function
new file mode 100644
index 0000000000..2ad38ff088
--- /dev/null
+++ b/t/t4018/javascript-export-generator-function
@@ -0,0 +1,5 @@
+export function* RIGHT() {
+
+    yield 1;
+    yield 2; // ChangeMe
+}
diff --git a/t/t4018/javascript-export-generator-function-2 b/t/t4018/javascript-export-generator-function-2
new file mode 100644
index 0000000000..56709a8ae9
--- /dev/null
+++ b/t/t4018/javascript-export-generator-function-2
@@ -0,0 +1,5 @@
+export function *RIGHT() {
+    
+    yield 1;
+    yield 2; // ChangeMe
+}
diff --git a/t/t4018/javascript-module-dotexports-anonymous-function b/t/t4018/javascript-module-dotexports-anonymous-function
new file mode 100644
index 0000000000..56c1641edb
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-anonymous-function
@@ -0,0 +1,3 @@
+module.exports.RIGHT = function(a, b) {
+    return a + b; //ChangeMe
+};
diff --git a/t/t4018/javascript-module-dotexports-arrow-function b/t/t4018/javascript-module-dotexports-arrow-function
new file mode 100644
index 0000000000..32dc4f865d
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-arrow-function
@@ -0,0 +1,4 @@
+module.exports.RIGHT = (a, b) => {	
+
+    return a+b; //ChangeMe
+};
diff --git a/t/t4018/javascript-module-dotexports-arrow-function-2 b/t/t4018/javascript-module-dotexports-arrow-function-2
new file mode 100644
index 0000000000..24d35f8d9e
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-arrow-function-2
@@ -0,0 +1,4 @@
+module.exports.RIGHT = a => {	
+
+    return a+1; //ChangeMe
+};
diff --git a/t/t4018/javascript-module-dotexports-arrow-function-3 b/t/t4018/javascript-module-dotexports-arrow-function-3
new file mode 100644
index 0000000000..333b6c6ff4
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-arrow-function-3
@@ -0,0 +1 @@
+module.exports.RIGHT = a => a+1; //ChangeMe
diff --git a/t/t4018/javascript-module-dotexports-assigned-function b/t/t4018/javascript-module-dotexports-assigned-function
new file mode 100644
index 0000000000..fc43431c77
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-assigned-function
@@ -0,0 +1 @@
+module.exports.RIGHT = PreviousFunction; //ChangeMe
diff --git a/t/t4018/javascript-module-dotexports-async-arrow-function b/t/t4018/javascript-module-dotexports-async-arrow-function
new file mode 100644
index 0000000000..b7e3341c93
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-async-arrow-function
@@ -0,0 +1,3 @@
+module.exports.RIGHT = async (a, b) => {
+    return a + b; // ChangeMe
+};
diff --git a/t/t4018/javascript-module-dotexports-async-arrow-function-2 b/t/t4018/javascript-module-dotexports-async-arrow-function-2
new file mode 100644
index 0000000000..715d3e9560
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-async-arrow-function-2
@@ -0,0 +1,4 @@
+module.exports.RIGHT = async a => {
+    
+    return a + 1; // ChangeMe
+};
diff --git a/t/t4018/javascript-module-dotexports-async-arrow-function-3 b/t/t4018/javascript-module-dotexports-async-arrow-function-3
new file mode 100644
index 0000000000..3a8ec728a9
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-async-arrow-function-3
@@ -0,0 +1 @@
+module.exports.RIGHT = async a => a + 1; // ChangeMe
diff --git a/t/t4018/javascript-module-dotexports-async-function b/t/t4018/javascript-module-dotexports-async-function
new file mode 100644
index 0000000000..b931331c1b
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-async-function
@@ -0,0 +1,4 @@
+module.exports.RIGHT = async function ChangeMe(a, b) {
+    
+    return a + b; // ChangeMe
+}
diff --git a/t/t4018/javascript-module-dotexports-async-generator-anonymous-function b/t/t4018/javascript-module-dotexports-async-generator-anonymous-function
new file mode 100644
index 0000000000..66e0acf178
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-async-generator-anonymous-function
@@ -0,0 +1,5 @@
+module.exports.RIGHT = async function* () {
+    
+    yield 1;
+    yield 2; // ChangeMe
+};
diff --git a/t/t4018/javascript-module-dotexports-async-generator-anonymous-function-2 b/t/t4018/javascript-module-dotexports-async-generator-anonymous-function-2
new file mode 100644
index 0000000000..c1cc0c1fce
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-async-generator-anonymous-function-2
@@ -0,0 +1,5 @@
+module.exports.RIGHT = async function *() {
+    
+    yield 1;
+    yield 2; // ChangeMe
+};
diff --git a/t/t4018/javascript-module-dotexports-async-generator-function b/t/t4018/javascript-module-dotexports-async-generator-function
new file mode 100644
index 0000000000..9e1dbb5b65
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-async-generator-function
@@ -0,0 +1,5 @@
+module.exports.RIGHT = async function* ChangeMe() {
+    
+    yield 1;
+    yield 2;
+}
diff --git a/t/t4018/javascript-module-dotexports-async-generator-function-2 b/t/t4018/javascript-module-dotexports-async-generator-function-2
new file mode 100644
index 0000000000..c886c6357b
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-async-generator-function-2
@@ -0,0 +1,5 @@
+module.exports.RIGHT = async function *ChangeMe() {
+    
+    yield 1;
+    yield 2;
+}
diff --git a/t/t4018/javascript-module-dotexports-function b/t/t4018/javascript-module-dotexports-function
new file mode 100644
index 0000000000..6b30d5ea98
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-function
@@ -0,0 +1,4 @@
+module.exports.RIGHT = function ChangeMe(a, b) {
+    
+    return a + b; 
+};
diff --git a/t/t4018/javascript-module-dotexports-generator-anonymous-function b/t/t4018/javascript-module-dotexports-generator-anonymous-function
new file mode 100644
index 0000000000..c77f32ac64
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-generator-anonymous-function
@@ -0,0 +1,5 @@
+module.exports.RIGHT = function* () {
+    
+    yield 1;
+    yield 2; // ChangeMe
+}
diff --git a/t/t4018/javascript-module-dotexports-generator-anonymous-function-2 b/t/t4018/javascript-module-dotexports-generator-anonymous-function-2
new file mode 100644
index 0000000000..318be0c172
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-generator-anonymous-function-2
@@ -0,0 +1,5 @@
+module.exports.RIGHT = function *() {
+    
+    yield 1;
+    yield 2; // ChangeMe
+};
diff --git a/t/t4018/javascript-module-dotexports-generator-function b/t/t4018/javascript-module-dotexports-generator-function
new file mode 100644
index 0000000000..839a6f16dc
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-generator-function
@@ -0,0 +1,5 @@
+module.exports.RIGHT = function* ChangeMe() {
+
+    yield 1;
+    yield 2;
+}
\ No newline at end of file
diff --git a/t/t4018/javascript-module-dotexports-generator-function-2 b/t/t4018/javascript-module-dotexports-generator-function-2
new file mode 100644
index 0000000000..a70100a26b
--- /dev/null
+++ b/t/t4018/javascript-module-dotexports-generator-function-2
@@ -0,0 +1,5 @@
+module.exports.RIGHT = function *ChangeMe() {
+
+    yield 1;
+    yield 2;
+}
-- 
2.50.0.rc0.62.g658f0ae201.dirty

