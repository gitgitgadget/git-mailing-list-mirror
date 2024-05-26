Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58D8F66
	for <git@vger.kernel.org>; Sun, 26 May 2024 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716713076; cv=none; b=pLT49LdOoIm/zYZ5QYN/tNFIO+tEfLwztMG6BUYTutTJem1Ji2eLqAv7W3Zw6YWhMENsqnqpNw0E3zEBBR9adYlXZ9nbpp4YPaNw0+QqGOVAEf4e7lTum1H3xe3iV8a3SZAZ5RKLjg+czRQ2wgYMArt60BSAsaz6V6FgUBuDPmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716713076; c=relaxed/simple;
	bh=6HQHjW+N/3w5tEldAEVg/0IebLJd0EFrnxQfepAygqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiEaRHJ9z21GzPqaB5ELXRMeZ/2kNYjAWU54kxW5dwvKK69HGQCuTATjPn0RqIEQY5rXiOJ7fg7yEZiKTYUqWJaSB5UYX9zvpWpC2r9DmOJn8U7SqhTtLgxGzLJl58qunvez2QMdA5X9A0wnncae7gI7QhrW/1Jv5avh3UoTt7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZHykX9N; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZHykX9N"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f8ea2df4b3so1711944b3a.2
        for <git@vger.kernel.org>; Sun, 26 May 2024 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716713072; x=1717317872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAd+Gat3kCe+FrRUdxhA0S8JXk+VT8NM7ivA44jzlRA=;
        b=ZZHykX9NM2jL0krazZcx5kSpv+PSxkVhSFfy0f2vuZHwvs5r4vQdBtL/+jjZEVp/gY
         sGoGKbf4zFURxdeXI6EFfwvPwoOo5T38E122J6H5P5mJmY4DzY5w8ClEdGnrAX1E0FNN
         COZQrlyJjbDaBoy6+xK332MxNzFWdaahspKHuzrINgXfKBtMns+pqpz+/KF63F2R6H0W
         r9tGJJrJjxmaejIkqyjD5iNwioDUO5GtMCL2obP/FPSOPeKLMnKtP3URj2+f7468UCat
         u8JaFNTGaxILVpRwji4X6KPDk7Mka2mDeVcerapMNTT3QlCouiZ0V60AYC9TzJp+DVsc
         t7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716713072; x=1717317872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAd+Gat3kCe+FrRUdxhA0S8JXk+VT8NM7ivA44jzlRA=;
        b=J6zvYRyCu494tppg4zK1NruDWwxAhKwPjRFmsC5vAs3UBGqDQvuDIYZ6kFRZmAAxiT
         HraveMHab52BFRdMs285xBcAQlF/eo9Hkwmn+8rcCAbZ1Ed5jNpiTlUVLhpLgPDZt8wY
         BjAWUWFf5YmwNHLL0xmWyss+RFw1PePu8Hk0FAkOMdNtUCf1eBBpD/OZr0z9RdwvBRQz
         h3G0pNm55q4i8+Fm5eD30ff8d6UsLFLLQGzLUat6uz3RqZdOfrk8ZcvIUr7R+hoIE3i5
         tjHE7VOEcJK1vH0npsN/qMK69AC4xO3HMUjkgsJUC3WYsi2PMrddllyHm6Uw79+LMWY5
         WV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/v1N+Apy3p/3o6/BBe/yhstup7DKqivu//9wQM0ZqAMCfeBDBuTb1FHTA5D4wjGB9WRERQpDWTyZr/URGuAu8432h
X-Gm-Message-State: AOJu0YzKund7JtTj98+8NMwiCVsY6ScCoDn/M18y8c101K2nLoNJ2UHo
	I/kbeAnfdUGEn8VM+7ayGEp7xIMIGTDsP27j9V7K+T7gSwv8mo+3OSjX4sEp
X-Google-Smtp-Source: AGHT+IGPycVhXVEfSk7mJ/htInt+Ju1gtnyFjehxLduzxNo+bDyooJAFCkDXvcin3fgNjn6J+S+H0Q==
X-Received: by 2002:a05:6a00:8912:b0:6f9:9606:30da with SMTP id d2e1a72fcca58-6f99624bd73mr5259431b3a.31.1716713072130;
        Sun, 26 May 2024 01:44:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcfe64a4sm3274488b3a.158.2024.05.26.01.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 01:44:31 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: shyamthakkar001@gmail.com
Cc: ach.lumap@gmail.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im
Subject: [PATCH v4 1/2] strbuf: introduce strbuf_addstrings() to repeatedly add a string
Date: Sun, 26 May 2024 14:13:44 +0530
Message-ID: <20240526084345.24138-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240526084345.24138-1-shyamthakkar001@gmail.com>
References: <20240523235945.26833-1-shyamthakkar001@gmail.com>
 <20240526084345.24138-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit we are going to port code from
"t/helper/test-sha256.c", t/helper/test-hash.c and "t/t0015-hash.sh" to
a new "t/unit-tests/t-hash.c" file using the recently added unit test
framework.

To port code like: perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;"
we are going to need a new strbuf_addstrings() function that repeatedly
adds the same string a number of times to a buffer.

Such a strbuf_addstrings() function would already be useful in
"json-writer.c" and "builtin/submodule-helper.c" as both of these files
already have code that repeatedly adds the same string. So let's
introduce such a strbuf_addstrings() function in "strbuf.{c,h}" and use
it in both "json-writer.c" and "builtin/submodule-helper.c".

We use the "strbuf_addstrings" name as this way strbuf_addstr() and
strbuf_addstrings() would be similar for strings as strbuf_addch() and
strbuf_addchars() for characters.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-authored-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 builtin/submodule--helper.c | 4 +---
 json-writer.c               | 5 +----
 strbuf.c                    | 9 +++++++++
 strbuf.h                    | 5 +++++
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e604cb5ddb..5620a5bf67 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -256,11 +256,9 @@ static void module_list_active(struct module_list *list)
 
 static char *get_up_path(const char *path)
 {
-	int i;
 	struct strbuf sb = STRBUF_INIT;
 
-	for (i = count_slashes(path); i; i--)
-		strbuf_addstr(&sb, "../");
+	strbuf_addstrings(&sb, "../", count_slashes(path));
 
 	/*
 	 * Check if 'path' ends with slash or not
diff --git a/json-writer.c b/json-writer.c
index 005c820aa4..25b9201f9c 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -46,10 +46,7 @@ static void append_quoted_string(struct strbuf *out, const char *in)
 
 static void indent_pretty(struct json_writer *jw)
 {
-	int k;
-
-	for (k = 0; k < jw->open_stack.len; k++)
-		strbuf_addstr(&jw->json, "  ");
+	strbuf_addstrings(&jw->json, "  ", jw->open_stack.len);
 }
 
 /*
diff --git a/strbuf.c b/strbuf.c
index 0d929e4e19..e3ca9b1ee9 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -313,6 +313,15 @@ void strbuf_add(struct strbuf *sb, const void *data, size_t len)
 	strbuf_setlen(sb, sb->len + len);
 }
 
+void strbuf_addstrings(struct strbuf *sb, const char *s, size_t n)
+{
+	size_t len = strlen(s);
+
+	strbuf_grow(sb, st_mult(len, n));
+	for (size_t i = 0; i < n; i++)
+		strbuf_add(sb, s, len);
+}
+
 void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
 {
 	strbuf_grow(sb, sb2->len);
diff --git a/strbuf.h b/strbuf.h
index 97fa4a3d01..003f880ff7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -310,6 +310,11 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
 	strbuf_add(sb, s, strlen(s));
 }
 
+/**
+ * Add a NUL-terminated string the specified number of times to the buffer.
+ */
+void strbuf_addstrings(struct strbuf *sb, const char *s, size_t n);
+
 /**
  * Copy the contents of another buffer at the end of the current one.
  */
-- 
2.45.1

