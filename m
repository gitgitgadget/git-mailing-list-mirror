Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFB2D540D
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760590; cv=none; b=FkjUPCDSntdDGtXzFbgzOVDORSlgFemwI7Hs86/Is+h/wDDfzuV+4HhcB9xadKa0PEdef4yLRk4IA66IpR2Psf6WKAlEGApyca6bAhu+UycWpYUZ/Y2fUQdJrMEs/3kMwahzb386PvtEMMbqJj8Zkmu8UyduAjTSDVdxw+b4oeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760590; c=relaxed/simple;
	bh=vajzF7gR5nafo2oxwHjDspAaXQSIcSzrCP+wtXDSp7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2wLNyGOp/u0brQa+MBHoLQXgubNTEPs+X7zdIgt/DyEVLA7SXuh4KjSRZzAe7ff3GBHvQ/DHvEXovypu/4lMcgFcxNg+4I8tua8kl8KahxYf2RGW9BQrp5VZQtwZqs7AzYq3RH4HnJAV4eQeccxbxw3LeeSpRe5oXD88QO3G3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTPtmTwE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTPtmTwE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso32416965e9.3
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760586; x=1760365386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZulA/Nl8RAZOdFaT1Hp0Rr0e1j2BhSBKgui2uzZ1Gs=;
        b=FTPtmTwEphehclilFWIfGF0OBhWmm9It9Lr/OjbKIS+GcE4FHV9MhllUtCW02cRXZW
         GIf4jzlxpmJ9ZFdZG9Byc33LWV/u71O2nzFSYWorUqRnomP9obfOZWga+utIDN2s8/KV
         MTzJuTeOX9wtVTKVAoGxgUq/lnDSXSsLIFCTc+jKuT+FMf+vtOSEb5AwG+qxA10hkk+K
         czDLszb/b9vJsW9I1IHnLgOGefRkudTYwFTugN3x9KeMaYg0NT7XMM29aDwYDxpWQPds
         96Te4Qte8NoIfIjjCZVGaVHamTHPZZrHnVVAKmwvFMxyedEeOcaiTrX0BeGACMPEuS70
         JADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760586; x=1760365386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZulA/Nl8RAZOdFaT1Hp0Rr0e1j2BhSBKgui2uzZ1Gs=;
        b=aBPRfaZqB2XRg07ejoa1p1W2biJ/lu5Y3OkzI4jPxxc16QntqR9hZz/UFTmFHTuF0L
         3fc9utJ4YBo25NueJ3P/ky9N0Y1wJz8aJb9yLNMthLqLDgsY1baSDX0XwM9ctHUZajfJ
         yD1v1+ODcYCcEjK+3PzGQ+h7xs3JDPhxDPAQX1DkyKSsBG1uIPHOGm3JaCRAGSSY/RxE
         +IYJkYWhYCIpNGIJWCf9pB6f1THKCkvwBdaG7YFqh9mmlZPotRLXg/81lMnIk8EYOZLb
         8GCQnMtTTUu+WFR4RxB0s9+9YVAljOYQYHjI2HBsByWY2chhYsuvO88RqPiGa2tQCNy6
         VnKA==
X-Gm-Message-State: AOJu0YysrpfnySPRgc8ag0APVQWOOPdW6rsYesRdwhG8mBayYydadQ72
	1tPVbTJYMa8H0D1eymFLtryF5JcrZYLvVttLzYMVh9TYYDbbOPCBtsSlTL52GTXs
X-Gm-Gg: ASbGncumkbpRiEkXP3sIEWivlnPTyPToHgYk9GwhLhFGJDovHRPHI34b2nqBgLMcwKZ
	+LdTUv0U0YgUfViXhoJ7ZN2c/iCY0bReKAbIh2KORgtOIxjCmB0L0R9medTCVmnkSinFXp3frjJ
	DOP7Uw+ZuKa+stsmfintn7ztGhpStUlpOOozWxr0Fd2O0YgvELM6VgP3XlJtDlF/iGguJykFt49
	IQOb+ETBTaNW7ogSDP+83v/6Wl6BqN5XNstM9bYmlsZEkiYkuPCJ7p1Z/CxyQ+nAm2AvdCPUtxv
	Or1x6o+fNzZO8U1I9C/EXtN1z78/2o7G84Hm0Ivo+dXSwBf4mMYSQnozD3i3UG5/ZD620ivvSjz
	CasDrs2zj+UZMUTrq1w/Dymv+KraDFMD6vbvjrYyjJQSHBQ==
X-Google-Smtp-Source: AGHT+IG0LSHDQvddlOeQ5AeP1iIotzPTBdy3+nZbkMIl2a2TTYbLbtXo7jO/F6uKzRNd87KW8DBp4Q==
X-Received: by 2002:a05:600c:a319:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-46e74cc4609mr65588425e9.17.1759760586377;
        Mon, 06 Oct 2025 07:23:06 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234f547sm171237555e9.9.2025.10.06.07.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:23:05 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 06 Oct 2025 16:23:01 +0200
Subject: [PATCH v5 3/7] reftable: check for trailing newline in
 'tables.list'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-228-reftable-introduce-consistency-checks-v5-3-f196d386214f@gmail.com>
References: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
In-Reply-To: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5359; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=vajzF7gR5nafo2oxwHjDspAaXQSIcSzrCP+wtXDSp7o=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjj0MbpxMjkmsGgLKcz3RZt9ML3z0HLQO8rR
 ZfUkj0G/Y+0tYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo49DGAAoJED7VnySO
 Rox/K/EL+we/LrNTQLfKUCgFp6Kg4KPrGoLu2jvMaef7vEs7aGDvc/AGpkvM6ngeA/h2glpzp07
 lP9951yJ/xFlXyWw2poa4oZWDzlb2PHXyhZ2omWZY0Dv3vP/Fu7clszCgLyqcikIZ127wQZXsBF
 0/Lh5KR2KFIGWO3eE9otKBx7vNUF3J6LDGdoqxPj3VPwbRXr2Vi0l3UE+qwdctkk8J6/Y73roDt
 QzgFjhLP/TgCVh4qaZI3VwZ4UoafVlkeAsv4llcmOJO424O0IsY/0ff/wbIL8kKqMjRNh4htmuw
 V5M74hBxKMo8EX6bN4f7j0jZqPqg0Zz1do8asJfeh5iyicqFFbUNIzTwW+HnassrYAPrFznjUfp
 Q8PCg+Iqrpf0Og5qUTl003wOR8S2cocVyv8Pb3PTG90S2KPubFy0fM2taYvcZ3kGBhFh6gdLliR
 VHPOpFDxELrrx3f8Dmu1aKSJ2TYqahTHqp7cu7E2Qi2KdNdmZ0fcI8v3Xc0wEhnnzEgli11Aop9
 nE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the reftable format, the 'tables.list' file contains a
newline separated list of tables. While we parse this file, we do not
check or care about the last newline. Tighten the parser in
`parse_names()` to return an appropriate error if the last newline is
missing.

This requires modification to `parse_names()` to now return the error
while accepting the output as a third argument.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/basics.c                | 37 ++++++++++++++++++++++++-------------
 reftable/basics.h                |  7 ++++---
 reftable/stack.c                 |  7 +------
 t/unit-tests/u-reftable-basics.c | 24 ++++++++++++++++++++----
 4 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 9988ebd635..e969927b61 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -195,44 +195,55 @@ size_t names_length(const char **names)
 	return p - names;
 }
 
-char **parse_names(char *buf, int size)
+int parse_names(char *buf, int size, char ***out)
 {
 	char **names = NULL;
 	size_t names_cap = 0;
 	size_t names_len = 0;
 	char *p = buf;
 	char *end = buf + size;
+	int err = 0;
 
 	while (p < end) {
 		char *next = strchr(p, '\n');
-		if (next && next < end) {
-			*next = 0;
+		if (!next) {
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
+		} else if (next < end) {
+			*next = '\0';
 		} else {
 			next = end;
 		}
+
 		if (p < next) {
 			if (REFTABLE_ALLOC_GROW(names, names_len + 1,
-						names_cap))
-				goto err;
+						names_cap)) {
+				err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto done;
+			}
 
 			names[names_len] = reftable_strdup(p);
-			if (!names[names_len++])
-				goto err;
+			if (!names[names_len++]) {
+				err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto done;
+			}
 		}
 		p = next + 1;
 	}
 
-	if (REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap))
-		goto err;
+	if (REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap)) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 	names[names_len] = NULL;
 
-	return names;
-
-err:
+	*out = names;
+	return 0;
+done:
 	for (size_t i = 0; i < names_len; i++)
 		reftable_free(names[i]);
 	reftable_free(names);
-	return NULL;
+	return err;
 }
 
 int names_equal(const char **a, const char **b)
diff --git a/reftable/basics.h b/reftable/basics.h
index 7d22f96261..e4b83b2b03 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -167,10 +167,11 @@ void free_names(char **a);
 
 /*
  * Parse a newline separated list of names. `size` is the length of the buffer,
- * without terminating '\0'. Empty names are discarded. Returns a `NULL`
- * pointer when allocations fail.
+ * without terminating '\0'. Empty names are discarded.
+ *
+ * Returns 0 on success, a reftable error code on error.
  */
-char **parse_names(char *buf, int size);
+int parse_names(char *buf, int size, char ***out);
 
 /* compares two NULL-terminated arrays of strings. */
 int names_equal(const char **a, const char **b);
diff --git a/reftable/stack.c b/reftable/stack.c
index f91ce50bcd..65d89820bd 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -109,12 +109,7 @@ static int fd_read_lines(int fd, char ***namesp)
 	}
 	buf[size] = 0;
 
-	*namesp = parse_names(buf, size);
-	if (!*namesp) {
-		err = REFTABLE_OUT_OF_MEMORY_ERROR;
-		goto done;
-	}
-
+	err = parse_names(buf, size, namesp);
 done:
 	reftable_free(buf);
 	return err;
diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
index a0471083e7..73566ed0eb 100644
--- a/t/unit-tests/u-reftable-basics.c
+++ b/t/unit-tests/u-reftable-basics.c
@@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
 #include "unit-test.h"
 #include "lib-reftable.h"
 #include "reftable/basics.h"
+#include "reftable/reftable-error.h"
 
 struct integer_needle_lesseq_args {
 	int needle;
@@ -79,14 +80,18 @@ void test_reftable_basics__names_equal(void)
 void test_reftable_basics__parse_names(void)
 {
 	char in1[] = "line\n";
-	char in2[] = "a\nb\nc";
-	char **out = parse_names(in1, strlen(in1));
+	char in2[] = "a\nb\nc\n";
+	char **out = NULL;
+	int err = parse_names(in1, strlen(in1), &out);
+	cl_assert(err == 0);
 	cl_assert(out != NULL);
 	cl_assert_equal_s(out[0], "line");
 	cl_assert(!out[1]);
 	free_names(out);
 
-	out = parse_names(in2, strlen(in2));
+	out = NULL;
+	err = parse_names(in2, strlen(in2), &out);
+	cl_assert(err == 0);
 	cl_assert(out != NULL);
 	cl_assert_equal_s(out[0], "a");
 	cl_assert_equal_s(out[1], "b");
@@ -95,10 +100,21 @@ void test_reftable_basics__parse_names(void)
 	free_names(out);
 }
 
+void test_reftable_basics__parse_names_missing_newline(void)
+{
+	char in1[] = "line\nline2";
+	char **out = NULL;
+	int err = parse_names(in1, strlen(in1), &out);
+	cl_assert(err == REFTABLE_FORMAT_ERROR);
+	cl_assert(out == NULL);
+}
+
 void test_reftable_basics__parse_names_drop_empty_string(void)
 {
 	char in[] = "a\n\nb\n";
-	char **out = parse_names(in, strlen(in));
+	char **out = NULL;
+	int err = parse_names(in, strlen(in), &out);
+	cl_assert(err == 0);
 	cl_assert(out != NULL);
 	cl_assert_equal_s(out[0], "a");
 	/* simply '\n' should be dropped as empty string */

-- 
2.51.0

