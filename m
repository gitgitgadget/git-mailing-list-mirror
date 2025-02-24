Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E967DA7F
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410876; cv=none; b=SY2e6qkUWOe8gBwfhllKSKsHCftHy/y8OWEkQbdstNjH5lQ8Cph8/sEVDBNglk+g+ytNYwJttl7Xg4qGAhjdIQqHwQy7R+4eXcGLBT5fIvIIs7j1pzyDQP9UpQfJlOYhwvo5M14bmaVv2PjQpffKMpBw7AsbNWYK3VmKMCyABMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410876; c=relaxed/simple;
	bh=QFRjOlzRq5DY/Xu9KebYSiPvF4g4mGUOpvrXSwGq/Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/QvbVl1Qe9DMzmRRHqQdjX8nqWe+PgMm2DKMTMwNnhLMwuhG9QZj7AqTraTvuVIIkuCSoe4qfgfQNIhtY77U2b2vEjZ/bb9AyolNvFR9u9oqwTjKf71HZ2bGfREGIrGC6pq8GEKcKu/BkuPIdm6+dxQb3JDXOlRE1Qcsdx+JDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3EjcJHh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3EjcJHh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4397dff185fso39874155e9.2
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 07:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740410872; x=1741015672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3BxshT2jsCWCs6KcKUYJB0MFdzxLIb2ESWXfh/Cuqc=;
        b=Q3EjcJHhE5fSiNq/jkUbn1y+hMOT/JXTPOgS1th+gCyzU+Y/DTB40TUabuunSIlavB
         DLJrRGcK6eMEtYWKoisnXPS4VtsuwRXFApTC3UZTeT5jDnFrfpawSKiYN78qduUAUYTL
         RVZ7OioTe1btnyHKrSB8qkVqh0xrrX76JA4gVE//BNtdK2kI7Qv9TS7Y9QrVbzCYBhKx
         DzEoggWDp/uyJ7CTb2W16YTMdqF8lCzPC9UI0o990Qlt8r7q19ttKV9308t6qMosJqAP
         +kj12umjhkWGobBg8XAsF7gZUy6ict1H2FjgK4Dua8vIuYXnwy9fNSu5rN8XAX4hekys
         P4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410872; x=1741015672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3BxshT2jsCWCs6KcKUYJB0MFdzxLIb2ESWXfh/Cuqc=;
        b=UdF3kfnBncMZj5K3uuKIyO3IY7FgfecA5WRh0PysQt5weLwh1R+YMX3fLxFOsiOClB
         unBUPZEdmd6b8GubuTjDaLK0Hpta/7UJ+z9OHRpRubKW6KC2r136r1Di+QTRwWOQ/UoH
         /BXQh1Nmj8ad6wUb8eYkeOp6d/PTQ+7Z+NtVTOg88b3WQvHvrTciJ50tVpV+MmzcISPk
         mcjttqiL/xxePBDlyAI2hoUPxsY2x2jp2E8vHOibSmcvvUOMdgRC0tiGiX8uS6iCyVB9
         y3NWOqqrm8bHdJFTtS8DSx1pNe2XpUIVULa3ck2vsApDcPG845kXraTpibM0YLXZs+uj
         yLnw==
X-Gm-Message-State: AOJu0YwRpEwdcjY413gft2MJchD2E5MpDgab9HtiUDvP3lGU+9YLMZA7
	dSqctw0ZRQRWFKQeOyxbb1ntzPcEXCIj4DoQPwn6ggHBJe4Iz6qWYI62J6oSZ6fcuw==
X-Gm-Gg: ASbGnctm7VSda53/5ZlbqfCgqG8cotmtN6WryiXl5hreLLzm4nPCJXbBlo2hkZu6x4v
	Q6U7l/beLkU28GYQdrnZaZb+PRY+vCPSay1sPaOfSZq8NLhrjetzEgxidp5d86q2gokD8Lgg1YA
	0OjxbTI15y9VzNqJTlAHPgprgUVkRR3y4q7Fre0JZa9YFB91N+slHFB7fpVr8OSnib/qo2FyhGf
	+BukBWeNn+kSvRmSe8uuJ8UBIOTajiVNmet6qRukcEADD5caQauHjx2KTDuP31MGwMfIRu+XeKS
	+Z8JP3DJTdgVYqhGuuQMuP8aB9CKg1po4cJGY9U=
X-Google-Smtp-Source: AGHT+IHsOboEGh+VAb+pOCD6o9MpatKCpCBE7oJDLStYLwZBGW+yTeo4sOcrgfHsKkwY5kiH3pXQLw==
X-Received: by 2002:a05:600c:548a:b0:439:4700:9eb3 with SMTP id 5b1f17b1804b1-439ae1d7ebfmr110160435e9.3.1740410871574;
        Mon, 24 Feb 2025 07:27:51 -0800 (PST)
Received: from localhost.localdomain ([41.217.53.197])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-439b02e425esm109048915e9.17.2025.02.24.07.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:27:51 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 1/4] t/unit-tests: implement clar specific oid helper functions
Date: Mon, 24 Feb 2025 16:27:01 +0100
Message-ID: <20250224152704.70289-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250224152704.70289-1-kuforiji98@gmail.com>
References: <20250220082959.10854-1-kuforiji98@gmail.com>
 <20250224152704.70289-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`get_oid_arbitrary_hex()` and `init_hash_algo()` are both required for
oid-related tests to run without errors. In the current implementation,
both functions are defined and declared in the
`t/unit-tests/lib-oid.{c,h}` which is utilized by oid-related tests in
the homegrown unit tests structure.

Adapt functions in lib-oid.{c,h} to use clar. Both these functions
become available for oid-related test files implemented using the clar
testing framework, which requires them. This will be used by subsequent
commits.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                 |  2 +-
 t/meson.build            |  2 +-
 t/unit-tests/lib-oid.c   | 31 +++++++++++--------------------
 t/unit-tests/lib-oid.h   |  9 ++++++---
 t/unit-tests/unit-test.c |  2 ++
 5 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/Makefile b/Makefile
index bcf5ed3f85..81799488f0 100644
--- a/Makefile
+++ b/Makefile
@@ -1365,6 +1365,7 @@ CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
+CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
 UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidmap
@@ -1381,7 +1382,6 @@ UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGRAMS += t-urlmatch-normalization
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
-UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
diff --git a/t/meson.build b/t/meson.build
index 780939d49f..862cf1cfd4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -14,6 +14,7 @@ clar_test_suites = [
 clar_sources = [
   'unit-tests/clar/clar.c',
   'unit-tests/unit-test.c',
+  'unit-tests/lib-oid.c'
 ]
 
 clar_decls_h = custom_target(
@@ -68,7 +69,6 @@ foreach unit_test_program : unit_test_programs
   unit_test = executable(unit_test_name,
     sources: [
       'unit-tests/test-lib.c',
-      'unit-tests/lib-oid.c',
       'unit-tests/lib-reftable.c',
       unit_test_program,
     ],
diff --git a/t/unit-tests/lib-oid.c b/t/unit-tests/lib-oid.c
index 8f0ccac532..8bf09ea1cb 100644
--- a/t/unit-tests/lib-oid.c
+++ b/t/unit-tests/lib-oid.c
@@ -1,9 +1,9 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "lib-oid.h"
 #include "strbuf.h"
 #include "hex.h"
 
-int init_hash_algo(void)
+int cl_setup_hash_algo(void)
 {
 	static int algo = -1;
 
@@ -11,42 +11,33 @@ int init_hash_algo(void)
 		const char *algo_name = getenv("GIT_TEST_DEFAULT_HASH");
 		algo = algo_name ? hash_algo_by_name(algo_name) : GIT_HASH_SHA1;
 
-		if (!check(algo != GIT_HASH_UNKNOWN))
-			test_msg("BUG: invalid GIT_TEST_DEFAULT_HASH value ('%s')",
-				 algo_name);
+		cl_assert(algo != GIT_HASH_UNKNOWN);
 	}
 	return algo;
 }
 
-static int get_oid_arbitrary_hex_algop(const char *hex, struct object_id *oid,
+static void cl_parse_oid(const char *hex, struct object_id *oid,
 				       const struct git_hash_algo *algop)
 {
 	int ret;
 	size_t sz = strlen(hex);
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!check(sz <= algop->hexsz)) {
-		test_msg("BUG: hex string (%s) bigger than maximum allowed (%lu)",
-			 hex, (unsigned long)algop->hexsz);
-		return -1;
-	}
+	cl_assert(sz <= algop->hexsz);
 
 	strbuf_add(&buf, hex, sz);
 	strbuf_addchars(&buf, '0', algop->hexsz - sz);
 
-	ret = get_oid_hex_algop(buf.buf, oid, algop);
-	if (!check_int(ret, ==, 0))
-		test_msg("BUG: invalid hex input (%s) provided", hex);
+	cl_assert_equal_i(get_oid_hex_algop(buf.buf, oid, algop), 0);
 
 	strbuf_release(&buf);
-	return ret;
 }
 
-int get_oid_arbitrary_hex(const char *hex, struct object_id *oid)
+
+void cl_parse_any_oid(const char *hex, struct object_id *oid)
 {
-	int hash_algo = init_hash_algo();
+	int hash_algo = cl_setup_hash_algo();
 
-	if (!check_int(hash_algo, !=, GIT_HASH_UNKNOWN))
-		return -1;
-	return get_oid_arbitrary_hex_algop(hex, oid, &hash_algos[hash_algo]);
+	cl_assert(hash_algo != GIT_HASH_UNKNOWN);
+	cl_parse_oid(hex, oid, &hash_algos[hash_algo]);
 }
diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
index 4e77c04bd2..4031775104 100644
--- a/t/unit-tests/lib-oid.h
+++ b/t/unit-tests/lib-oid.h
@@ -5,6 +5,7 @@
 
 /*
  * Convert arbitrary hex string to object_id.
+ *
  * For example, passing "abc12" will generate
  * "abc1200000000000000000000000000000000000" hex of length 40 for SHA-1 and
  * create object_id with that.
@@ -12,14 +13,16 @@
  * algo is not allowed. The hash algo is decided based on GIT_TEST_DEFAULT_HASH
  * environment variable.
  */
-int get_oid_arbitrary_hex(const char *s, struct object_id *oid);
+
+void cl_parse_any_oid (const char *s, struct object_id *oid);
 /*
  * Returns one of GIT_HASH_{SHA1, SHA256, UNKNOWN} based on the value of
  * GIT_TEST_DEFAULT_HASH environment variable. The fallback value in the
  * absence of GIT_TEST_DEFAULT_HASH is GIT_HASH_SHA1. It also uses
- * check(algo != GIT_HASH_UNKNOWN) before returning to verify if the
+ * cl_assert(algo != GIT_HASH_UNKNOWN) before returning to verify if the
  * GIT_TEST_DEFAULT_HASH's value is valid or not.
  */
-int init_hash_algo(void);
+
+int cl_setup_hash_algo(void);
 
 #endif /* LIB_OID_H */
diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index fa8818842a..5af645048a 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -1,5 +1,7 @@
 #include "unit-test.h"
+#include "hex.h"
 #include "parse-options.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "strvec.h"
 
-- 
2.47.0.86.g15030f9556

