Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB154F81
	for <git@vger.kernel.org>; Thu, 29 May 2025 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557137; cv=none; b=a8bfNsuAVv8aU4ueg9fghtboUYy9B21PbRlVpYZgoQLfGCAUDNcmPTjTfwg66k52CWDrFK2TAd2oT+CHinufPzwKCpF5/nEmZT1jF5BpQsN6hZQon7PD4OfZWLZFTFmplFx77jQsA6Sw8EUqdrXC5hamOyGHFOgOlfExLBclyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557137; c=relaxed/simple;
	bh=WzWmmVVkmpjQtD9oau0qu3mLe0qAINbbnvB4MOb1M5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4HfLNFpPUaWNrduXOgHDcJ9fk6b31jqwpy+o+r7psW/e550j90pc53xCdv8EHnWDcIrp97l89UdM5+HtdTJTD1M1MR7QTeFnOi88vw8pPWtD7sAM/hHOSJTp98KUSD7XwRiUPE8ri1AZ8sGpL0WlqUAs4UzuYaAtvSTfLT7D1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSGgRfS0; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSGgRfS0"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e45ebe7ac1so371396137.2
        for <git@vger.kernel.org>; Thu, 29 May 2025 15:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748557132; x=1749161932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R2WBJMim0d1QVHRyjjRScHcAenvsfs93Mo3b/0EUJU=;
        b=cSGgRfS08py1Y81vITVhBZlHS/WpFf59c++jfHgwc462MYHPY8m89V5/SQTMcQU34Z
         vasjkZUijSXZ9+dLQEizU9z6n8A5koGhc5DWmJGxzksLRICwfjvSfVxI4ppUEKO7PgmT
         IV4ybVmQPwpLqFzc5Zn0pstPrIzCWeQKAjLFc98jGCf0fmTpxf7eIDcd/S/BIPdW+OYh
         j3SP/d/xKPxLKa2h0Mv2oDDU8kFwRd0L5vS26WnlyRKBoI9xA+RkbMyq/VD+P0how8Hg
         t9nfh607Z6hbplW/1bRaK/OxcfP3f65xr9VAt0spIMDyQ/dumtoFG7kqaqtav8oQZHyw
         ymng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557132; x=1749161932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R2WBJMim0d1QVHRyjjRScHcAenvsfs93Mo3b/0EUJU=;
        b=AvTntkcrLGlkVWQzG3ailxtcBnEvdPdUad81Xncp0yLNot2tvE2yS5gF+h6C/7gA/B
         wSpLFJom4AdqszxeX9tuvfLJQ3aUDA2D4o4T3KXUEkBmrqYNmUkH/rFDRnxBD46BdFPH
         CZv48IJwdq2KHIDoE0RLo1zRQPHo/c29WOJgloElU2pG7D5jFCm1WoEfrix5mffwm3Ix
         5ybwaa3fjXh0C4krak4UmaMHbkcTiT5Ekb6Wo+UXUjMGM8jVap3rsuK5gsMXhLpg6T0E
         OFA3wqMKHjNisHKPk0nx6/Lwr1pRLJWwHurIoH29TFszKtOcsVc4xYCsBPbqD8pP5C0q
         xEPg==
X-Gm-Message-State: AOJu0YzNMik4Bv0p9QWhFJzsCBifVFsw5NfUWsxVoiqYhbLFQl0AcjNH
	cpWEx/4OOHAgzcWbnyZm6z0vvfq3O7uVxKsukqRFgJX5Rt+W1TqlLz1z1kXPXg==
X-Gm-Gg: ASbGncvlCHLGwl8Dq+lUT5QMgrgmTU4Pa7kJFqFduR1/RTNexX8cCbzPHQjVbCC6i1C
	aPAR0KUr443DDzCd/BAH5kxyajX7nUuKGi3ucyhHUiRNtnMQqHBYygkFN/EQX8foEuDvQDJqMOW
	wFibCawGQXKhNz5N93ftiY9PI9MPzmW8vEZDnL1WW391ZIgK/RtkScKeIME/2cyWIcDxt1RTb8A
	ViYTf10gNf4UbFpKl+exTykOzcXGPmssEDz4al+v2oucZ0YofDMtRV1l+xVEJBI6crkID0fAv6T
	K0Glsv7GK3a2n7K0demRA+HC9Vv3yOqoi2dXlsjhcyP9/5Kvx81B1dSFA4wbPHzqozut0qE8
X-Google-Smtp-Source: AGHT+IHc40+fDS/xaSy2hyHIYfOKIiK7f+qIgds//qJXg5/zw57eh9kuPen6vUI1BYI1R164J5ZLuA==
X-Received: by 2002:a05:6102:c53:b0:4e2:ecd8:a27 with SMTP id ada2fe7eead31-4e6e40d8c1amr1586579137.4.1748557132615;
        Thu, 29 May 2025 15:18:52 -0700 (PDT)
Received: from rodrigo-pc.. ([179.99.7.58])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a3b68acsm1792663241.33.2025.05.29.15.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 15:18:52 -0700 (PDT)
From: Rodrigo Carvalho <rodrigorsdc@gmail.com>
To: git@vger.kernel.org
Cc: Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH v2] userdiff: add support for R programming language
Date: Thu, 29 May 2025 19:16:41 -0300
Message-ID: <20250529221805.97036-1-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525210236.116342-1-rodrigorsdc@gmail.com>
References: <20250525210236.116342-1-rodrigorsdc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch appends userdiff.c file in order to support R programming
language function header. This will be useful for those who use Git
for versioning .R files.

Also, add three userdiff tests for R programming language
files. These files define simple function and nested function,
with and without indentation.

Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
---
Changes in v2:
- Add support for function defined by '='
- Replace word regex to '[^ \t']
- Add new test that handles with nested function

 t/t4018/r-indent        |  6 ++++++
 t/t4018/r-indent-nested | 10 ++++++++++
 t/t4018/r-noindent      |  6 ++++++
 userdiff.c              |  4 ++++
 4 files changed, 26 insertions(+)
 create mode 100644 t/t4018/r-indent
 create mode 100644 t/t4018/r-indent-nested
 create mode 100644 t/t4018/r-noindent

diff --git a/t/t4018/r-indent b/t/t4018/r-indent
new file mode 100644
index 0000000000..9df440f2a4
--- /dev/null
+++ b/t/t4018/r-indent
@@ -0,0 +1,6 @@
+RIGHT <- function(a, b) {
+    c = mean(a, b)
+    d = c + 2
+    ChangeMe()
+    return (d)
+}
diff --git a/t/t4018/r-indent-nested b/t/t4018/r-indent-nested
new file mode 100644
index 0000000000..30412e6c79
--- /dev/null
+++ b/t/t4018/r-indent-nested
@@ -0,0 +1,10 @@
+LEFT = function(a, b) {
+    c = mean(a, b)
+    RIGHT = function(d, e) {
+        f = var(d, e)
+        g = f + 1
+        ChangeMe()
+        return (g)
+    }
+    return (RIGHT(2, 3))
+}
diff --git a/t/t4018/r-noindent b/t/t4018/r-noindent
new file mode 100644
index 0000000000..6d9b01ffe3
--- /dev/null
+++ b/t/t4018/r-noindent
@@ -0,0 +1,6 @@
+RIGHT <- function(a, b) {
+c = mean(a, b)
+d = c + 2
+ChangeMe()
+return (c)
+}
diff --git a/userdiff.c b/userdiff.c
index da75625020..64e5005682 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -317,6 +317,10 @@ PATTERNS("python",
 	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
 	 /* -- */
+PATTERNS("r",
+	"^[ \t]*([a-zA-z][a-zA-Z0-9_.]*[ \t]*(<-|=)[ \t]*function.*)$",
+	/* -- */
+	"[^ \t]+"),
 PATTERNS("ruby",
 	 "^[ \t]*((class|module|def)[ \t].*)$",
 	 /* -- */
-- 
2.43.0

