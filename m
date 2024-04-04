Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A51B948
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248737; cv=none; b=s+CvL0xFCNgUlN8acug6SXZ7LM7X2BWXFgILlrZg9jEujCsQvamZVch8XyBuo7Iq7rgy3CLDIk/giOsrKdXLALgbeH+TPUbnLr3WoiTMVU8DifDI1VKJmJs85NUCdjkFVY3nDNJvenpIZCr3bl/XPq9uxg3zvQEN/QKM/hgHM78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248737; c=relaxed/simple;
	bh=Pe6PbA3YDtIXHj8T4tzwRt2kA2Vu6eCWdvgLPaOdE90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCg4XvRWfYpixooZo8en18UNqSfgTiYHjFX+9HyrXbJTEMyJcXNEWk8y/bVhvG5GfAu3mEpR94/XJAhKWn//1qH0p5csT8I+Q9QRGR7cVSi9AGlLiOmCAXxDzOwXBnyih5YobNoJimfqht5kgDBG+Fz+RAbkE/ahD5ja2Mp3f7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf2Bhrsh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf2Bhrsh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0411c0a52so11314515ad.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712248734; x=1712853534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5GIIXMr/9Zl7YM2h/EjXpqSKjn99AeaJZAN1uCYgCY=;
        b=Xf2BhrshRyQId06ZdaIQvVgHXyBJDyYEDf8FHiSqJXk2gCl4hd7LT+P28ywbufWkh2
         13nLG8cCfMihWvJPKgc3cXYqP57/wTx2aqSVXakiOdVPLBQrJFF50H0Fhx7ahAE6VjwN
         XDz8+hoDp6uJ1TgZty71+F09XmqBz6Y9pMW92cZTYMyAt+kqXWIpFdhKMBqax02P3cmN
         atc1GRtJf6GJBcEfLjIlZLzwjEEnGj+1AuNxoQOfcCEye7axFQy5HK301MaMxRk0d9dY
         qJ1+3x5f6LofXJEURS+6svwGu/GaQchSeZZ4kIMu442pp7hEPJyBeKTbfgZCRqM7NFPh
         794w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248734; x=1712853534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5GIIXMr/9Zl7YM2h/EjXpqSKjn99AeaJZAN1uCYgCY=;
        b=qJVUUQGtc4yivQpg2BmKqacL4uBE0KGVPEEvLuRGkF2YcAAsMoD5iDBQWV5foxYOk4
         4BsTtxr/m2+JIq0djO4agfHrniET8Fr7EWUbYelbHvvPJWQGOsAE8dZI2sNHdux9IiHt
         CUP9CmFdKxbUG25IAD9gJsIwTwFHQ/UVFq4LqnEPG4lsJ9ZzdnnG6fVtB+h0U0jWUjuG
         NxFj/NatY+ebgCJYYbQPY3s8ez4D10Lb5TgpV4IpvRm+RYFKyMcG8pegKUxyFAimQotE
         vAYfe83tftobjniog+6EcuXVEQXsNuLaULBzYWYSi7oX8sGXf9Fglm1YozRdtWtBxn4p
         yujQ==
X-Gm-Message-State: AOJu0YxWfyIYWSLY6RiKBPbHpbPYlCLA75w1XhzdwblNK4DUCqDD2EyC
	GkPVLugWexzB9y0U9A4JdyiEne5jymVVAHsmAGQ3I18ooKe8w7al1u0hDwKp
X-Google-Smtp-Source: AGHT+IG+IQRDa2Zsef5K2kTi7SUiT/TeYm8ChQF6OVZgWuho5Qw/N4WDHLsjUQP6m3pAcCx840+TYw==
X-Received: by 2002:a17:902:f343:b0:1e0:fcf9:95e0 with SMTP id q3-20020a170902f34300b001e0fcf995e0mr26374ple.20.1712248734513;
        Thu, 04 Apr 2024 09:38:54 -0700 (PDT)
Received: from localhost.localdomain ([152.59.32.175])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001e0b5fd3c95sm15777901plg.259.2024.04.04.09.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 09:38:53 -0700 (PDT)
From: Utsav Parmar <utsavp0213@gmail.com>
To: utsavp0213@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH v2] userdiff: add builtin driver for typescript language
Date: Thu,  4 Apr 2024 22:08:27 +0530
Message-Id: <20240404163827.5855-1-utsavp0213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240324174423.55508-1-utsavp0213@gmail.com>
References: <20240324174423.55508-1-utsavp0213@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Utsav Parmar <utsavp0213@gmail.com>
---
 Documentation/gitattributes.txt          |  2 ++
 t/t4018/typescript-arrow-function        |  4 +++
 t/t4018/typescript-class-member-function |  7 +++++
 t/t4018/typescript-enum                  |  6 +++++
 t/t4018/typescript-function              |  4 +++
 t/t4018/typescript-function-assignment   |  4 +++
 t/t4018/typescript-interface             |  4 +++
 t/t4018/typescript-type                  |  4 +++
 t/t4034-diff-words.sh                    |  1 +
 t/t4034/typescript/expect                | 33 ++++++++++++++++++++++++
 t/t4034/typescript/post                  | 16 ++++++++++++
 t/t4034/typescript/pre                   | 16 ++++++++++++
 userdiff.c                               | 16 ++++++++++++
 13 files changed, 117 insertions(+)
 create mode 100644 t/t4018/typescript-arrow-function
 create mode 100644 t/t4018/typescript-class-member-function
 create mode 100644 t/t4018/typescript-enum
 create mode 100644 t/t4018/typescript-function
 create mode 100644 t/t4018/typescript-function-assignment
 create mode 100644 t/t4018/typescript-interface
 create mode 100644 t/t4018/typescript-type
 create mode 100644 t/t4034/typescript/expect
 create mode 100644 t/t4034/typescript/post
 create mode 100644 t/t4034/typescript/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 4338d023d9..4461c41054 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -902,6 +902,8 @@ patterns are available:
 
 - `tex` suitable for source code for LaTeX documents.
 
+- `typescript` suitable for source code for TypeScript language.
+
 
 Customizing word diff
 ^^^^^^^^^^^^^^^^^^^^^
diff --git a/t/t4018/typescript-arrow-function b/t/t4018/typescript-arrow-function
new file mode 100644
index 0000000000..85a3d9cd6b
--- /dev/null
+++ b/t/t4018/typescript-arrow-function
@@ -0,0 +1,4 @@
+const RIGHT = (one) => {
+    someMethodCall();
+    return ChangeMe;
+}
diff --git a/t/t4018/typescript-class-member-function b/t/t4018/typescript-class-member-function
new file mode 100644
index 0000000000..f34b0a2bac
--- /dev/null
+++ b/t/t4018/typescript-class-member-function
@@ -0,0 +1,7 @@
+class Test {
+	var one;
+	function RIGHT(two: string) {
+		someMethodCall();
+		return ChangeMe;
+	}
+}
diff --git a/t/t4018/typescript-enum b/t/t4018/typescript-enum
new file mode 100644
index 0000000000..8c045a45ec
--- /dev/null
+++ b/t/t4018/typescript-enum
@@ -0,0 +1,6 @@
+enum RIGHT {
+    ONE = 1,
+    TWO,
+    THREE,
+    ChangeMe
+}
diff --git a/t/t4018/typescript-function b/t/t4018/typescript-function
new file mode 100644
index 0000000000..62cf63f669
--- /dev/null
+++ b/t/t4018/typescript-function
@@ -0,0 +1,4 @@
+function RIGHT<Type implements AnotherType>(one: number): Type {
+    someMethodCall();
+    return ChangeMe;
+}
diff --git a/t/t4018/typescript-function-assignment b/t/t4018/typescript-function-assignment
new file mode 100644
index 0000000000..49c528713e
--- /dev/null
+++ b/t/t4018/typescript-function-assignment
@@ -0,0 +1,4 @@
+const RIGHT = function(one: number): Type {
+    someMethodCall();
+    return ChangeMe;
+}
diff --git a/t/t4018/typescript-interface b/t/t4018/typescript-interface
new file mode 100644
index 0000000000..6f3665c2af
--- /dev/null
+++ b/t/t4018/typescript-interface
@@ -0,0 +1,4 @@
+interface RIGHT {
+  one?: string;
+  [propName: ChangeMe]: any;
+}
\ No newline at end of file
diff --git a/t/t4018/typescript-type b/t/t4018/typescript-type
new file mode 100644
index 0000000000..e1bb2d8371
--- /dev/null
+++ b/t/t4018/typescript-type
@@ -0,0 +1,4 @@
+type RIGHT = {
+  one: number,
+  ChangeMe: CustomType
+}
\ No newline at end of file
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 74586f3813..4e3cf415c2 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -338,6 +338,7 @@ test_language_driver python
 test_language_driver ruby
 test_language_driver scheme
 test_language_driver tex
+test_language_driver typescript
 
 test_expect_success 'word-diff with diff.sbe' '
 	cat >pre <<-\EOF &&
diff --git a/t/t4034/typescript/expect b/t/t4034/typescript/expect
new file mode 100644
index 0000000000..19605fec4d
--- /dev/null
+++ b/t/t4034/typescript/expect
@@ -0,0 +1,33 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index e4a51a2..9c56465 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,16 +1,16 @@<RESET>
+log("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>) u<RESET>'<RED>x<RESET><GREEN>y<RESET>'
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>&<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>^<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>|<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>&&<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>||<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b
<RESET>
+<RED>a<RESET><GREEN>y
<RESET>
+<GREEN>x<RESET>,y
diff --git a/t/t4034/typescript/post b/t/t4034/typescript/post
new file mode 100644
index 0000000000..b1b03a7666
--- /dev/null
+++ b/t/t4034/typescript/post
@@ -0,0 +1,16 @@
+log("Hello World?")
+(1) (-1e10) (0xabcdef) u'y'
+!x ~x x++ x-- x*y x&y
+x*y x/y x%y
+x+y x-y
+x<<y x>>y
+x<y x<=y x>y x>=y
+x==y x!=y
+x&y
+x^y
+x|y
+x&&y
+x||y
+x?y:z
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
diff --git a/t/t4034/typescript/pre b/t/t4034/typescript/pre
new file mode 100644
index 0000000000..13a0b2138c
--- /dev/null
+++ b/t/t4034/typescript/pre
@@ -0,0 +1,16 @@
+log("Hello World!\n")
+1 -1e10 0xabcdef 'x'
+!a ~a a++ a-- a*b a&b
+a*b a/b a%b
+a+b a-b
+a<<b a>>b
+a<b a<=b a>b a>=b
+a==b a!=b
+a&b
+a^b
+a|b
+a&&b
+a||b
+a?b:z
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a,y
diff --git a/userdiff.c b/userdiff.c
index 92ef649c99..dbb5d7c072 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -297,6 +297,22 @@ PATTERNS("scheme",
 	 "|([^][)(}{[ \t])+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
+PATTERNS("typescript",
+         "^[ \t]*((enum|interface|type)[ \t]+([a-zA-Z][a-zA-Z0-9]*)+.*)$\n"
+         /* Method definitions */
+         "^[ \t]*[a-z]+[ \t]+([A-Za-z_][A-Za-z_0-9]*)+([ \t]*=[ \t]*(function)?)?([ \t]*[A-Za-z_<>&][?&<>|.,A-Za-z_]*[ \t]*)*[ \t]*\\([^;]*$",
+         /* -- */
+         "[a-zA-Z_][a-zA-Z0-9_]*"
+         /* Integers and floats */
+         "|[-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?"
+         /* Binary */
+         "|0[bB][01]+"
+         /* Hexadecimals */
+         "|0[xX][0-9a-fA-F]+"
+         /* Floats starting with a decimal point */
+         "|[-+]?([0-9]*\\.?[0-9]+|[0-9]+\\.?[0-9]*)([eE][-+]?[0-9]+)?"
+         /* Operators */
+         "[-+*/%&|^!=<>]=?|===|!==|<<=?|>>=?|&&|\\|\\||\\?\\?|\\+\\+|--|~"),
 { "default", NULL, NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
-- 
2.34.1

