Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11F374F6
	for <git@vger.kernel.org>; Wed, 29 May 2024 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969657; cv=none; b=TBpZskKlnc5ga7lwDxz64E0TLPzYAmAUFRlwxytjzo1qAKOQeuOK3uW0QxBOOTzHKjf1UNpJi7nSCiblpWOPBqyGoYZ9E5bb1HpgEOgNm5ogQqGtVP3qx9DMkpFsPLT6suMAVB2gkSS7C1aOoCs5ZpHYFCxwlsOZee4pcRPJNNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969657; c=relaxed/simple;
	bh=6HQHjW+N/3w5tEldAEVg/0IebLJd0EFrnxQfepAygqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUG7wA5CRvOesACh7Wh3zIsti5NKqI1se91N2YfMFaBt9aTeS1vXU2TET3mOtfz7JeOJ+UcidnjkWdE2vmQEOt58+viJa2sE+e33Sh+vfLDTpxVNT1aqYCuRPh+zq7+1KmzEKzYkgRLXoqnC91W/E9/p0YiGBGXX85oUxF8rGJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrPlMcR+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrPlMcR+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f8e9555eabso1430743b3a.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716969655; x=1717574455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAd+Gat3kCe+FrRUdxhA0S8JXk+VT8NM7ivA44jzlRA=;
        b=IrPlMcR+2VGEOyywlZR9WnLVFT5dli/mAa6BpAjR7Jscb1M67ZNBSDM+oH2BziaIHg
         esMF4cdmWbMhZyrAnJq3Lelqbv9mhhRaUbPl7ZoVo9fI7r4skLlglkCr1hw1RFQAy/jV
         6VtiJJLA3wnrjzKAP3+rmS3HGWc0GUwJnxNLXZabowtkE08RqT/tAbIjQ/zXazijVxs4
         lvZ0BhGsMOudSHmnW9bm0s/HV7mZyZnz5M818WfwZXkhdBeKnlVU5GMhUI4VaWZe8q1q
         LZVtyBeBqgw9mbAqNPm5K7zxDWaHhOUZxBu3vupr4Wv4UrB4nZRWNtacfiZ9o/UKeMQY
         vRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716969655; x=1717574455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAd+Gat3kCe+FrRUdxhA0S8JXk+VT8NM7ivA44jzlRA=;
        b=E847caG24yFhGbz2oyqK0uCakZBzHFTeFp3awzAQ8x+JGegT74A/feyVf/MMm4ERYK
         9wkTbXZ+8pSqe/BTRlDjxGg6C2F3iSL155wR1oVZ2jgo91bcmwh8tg8msWhCR53qkZ6n
         xZW9fSdjcP4LhROeUL6vDCMyKojAv/XH3+BGC8/4rX53+XT5DLXHAhdkg9TszyxphAvA
         qznLokKzp1vb11h9bDdn9oaWRBY+bYz8T2KSR6bWrLhqBUS881WwbDpZUy96Vu/qI5V0
         TmeH2bbAN2DP+L1oR8e63XI8JK+0l7GcJCRUqBBLiNb8DIrxaoxz+OdM0HzuUlMYvhcG
         Q81A==
X-Forwarded-Encrypted: i=1; AJvYcCWhUiYQE7sVdO73zOu/vWtF1AN3V9uxYJtFdHZyyyrtgYEkrr06GNiL3CfLS8BcR0OJO5qK+R+l7AKElAGl0oVDocdy
X-Gm-Message-State: AOJu0YztcmnoJjQsZQEEirT6vR66lyUAhH8vxM6QTVRePB0Dx5P9Dy8d
	IjjzBsFFEIPhbWPE6FQdacB/4BNLhee41Ig0Ot3yAGs0mksQbI01
X-Google-Smtp-Source: AGHT+IG7Jp46PAqeFJXs40qYlYYCw2tmTDY0wgST0ZTly77E62j22n246P8oirIElt0lAYDagGkEgw==
X-Received: by 2002:a05:6a21:189:b0:1b2:2e3e:42e1 with SMTP id adf61e73a8af0-1b22e3e43b0mr10219523637.34.1716969654919;
        Wed, 29 May 2024 01:00:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f478a651f6sm68290875ad.101.2024.05.29.01.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:00:54 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: shyamthakkar001@gmail.com
Cc: ach.lumap@gmail.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im
Subject: [PATCH v5 1/2] strbuf: introduce strbuf_addstrings() to repeatedly add a string
Date: Wed, 29 May 2024 13:30:29 +0530
Message-ID: <20240529080030.64410-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529080030.64410-1-shyamthakkar001@gmail.com>
References: <20240526084345.24138-1-shyamthakkar001@gmail.com>
 <20240529080030.64410-1-shyamthakkar001@gmail.com>
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

