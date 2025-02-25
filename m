Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C842144BF
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478369; cv=none; b=mOSsM9jwwCLvj2pyJs/ffDEeLSp9uosk5dVLL+0WJ8QjBtGkdhShsadzvSGFrwH40C3MOr0TnI4/WX0FpndiySrcVuM5YUi6qmxkeBKlV5wM0V5gzz8nI8eKdc1Ca9o7bIRGxWLwZor5/R43Ky+Obm6i+t/eGMbalwsn4DdM9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478369; c=relaxed/simple;
	bh=z/7qh82HOxr+eTGS8LG2e7fRjIhCK+gtZkezu3nPB6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK7IYA8nJzWnKA80WMJ6eR/vSFxCqg8uQtihNcSxQH7MSPmUPE9Nf3CwmF0vNVjQQOQok3hkWFDi4h1opUy+UGHQYh2Rk65l4ljgpx0ZXHF8Rnl4x6KIF7i3+SbRqomYFdHXPhUxnUOfly/bM+RPw4IP9xCEL/CWOu+m64sAVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtna9pXQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtna9pXQ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaec111762bso282896966b.2
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 02:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740478365; x=1741083165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1rDoIkE5BaBfNgNXuAus4sQ3UcMOZiG7yh9Co8hrVQ=;
        b=Wtna9pXQxMbGa7O4A1Fq5L4EVocJDOBN8HDIcIfHI+vCsye23xScb4H71DD2mAyT7S
         YZ593dc3UAoXE01EKm2p8PjRmEAKR+t/vyGAJyqcOA6z5zu2JfU9EEnHPrKb+VqRMDz6
         m6T9QzOFLUZQTgusb++W82HhIMDMAwyIzdos1uZEX1ePL0JTi7bgZtV/Z7iQQDdIYMnQ
         nEkMKdVBQbCHiV7SuLHCGVd2qJ8spAl2JJp0RNZ1thzKXyZ2ZcyZxUNgS7cjL7tve3sO
         easZv6Gjv0+eERQDRg2o9y0MqNVubK371lOXjEAMwZVOWv9ztaS5AxqHZIcQw92a2rxw
         u15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478365; x=1741083165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1rDoIkE5BaBfNgNXuAus4sQ3UcMOZiG7yh9Co8hrVQ=;
        b=SOTGo73uD3ovZo1XnX6lepWJcFMDngNDsT7SCFgUVIG1KxbEcQcKbnxdlKFsabnxyT
         K87gXbRtVwoPu6G83VSyxiAa3CB7yjB/RDQO3EFAxREi6KfuUgNDWldF0MDHSyKn10br
         Mgem8PJtIQPRk0aTt4VbX46mo+hr5lNAavUPjzsT1kxMuMr5sJm0mhB+aAPuOqcGVRIn
         NRX4OtYjvGGx+9ZLP35XuhJy7NKQqdiw1qjsFpZKvHDM1zU85BOpOJ/FQovWDVCxc8wA
         YU2jkv3ca0mC/9tiGJyz0T3cJ40EO+36VtbyZ/BOg9+RZmSPCbgCdbtT3EYb0WGWj0PV
         d8Ig==
X-Gm-Message-State: AOJu0YxALjAGpvhhlbJmX8j+7LRwXpZYQkJ4EBhz20Eh/FHiRsvMFc++
	AMaUpR8nJOy1yrf2m1vgVIKmsMRt987x49oMRHoGYIXErKguYFBIDs19iGWBgZ0HZw==
X-Gm-Gg: ASbGncs8Q8xaC5phWZD0k9oEDdT/1d+LTg8dcsLXNGELXqRzR99Isl71BqK9yDbi2qz
	LZOaOD+cGDQ36LIuUKQhe275f2gAX9/RnYONQoKO43yWThvfvOZ9tmx3luILrUJSKn3x2fxunEq
	DZdzBajRMocHVbBern5DZHAryQhSfRTcnZwMr/tVcdusbbwjGyH+stf/QiFzWrdoYFBXlB24h5F
	Qq/886oBfSFLd6+6NqJgjMYBI8Rsz4udN1Zujhc/HU6106r/8UFcm10nuX8hMCYrqoNmEwyqxQi
	7ZCZsUbRwMkglFIk5QyZPqgcrfDKjq/UZ7QcOSk=
X-Google-Smtp-Source: AGHT+IEtTDVxi/qh/mNGQO4TpLjShToHaujX32vNcHJQGGSSr/CyOcUIa+BdXtwg4Vi1mInrmtTdOQ==
X-Received: by 2002:a17:906:32db:b0:abb:b092:dae0 with SMTP id a640c23a62f3a-abc099debf0mr1478238666b.11.1740478365087;
        Tue, 25 Feb 2025 02:12:45 -0800 (PST)
Received: from localhost.localdomain ([41.217.53.197])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abed20b7513sm115120566b.177.2025.02.25.02.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:12:44 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 1/4] t/unit-tests: implement clar specific oid helper functions
Date: Tue, 25 Feb 2025 11:10:41 +0100
Message-ID: <20250225101044.84210-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250225101044.84210-1-kuforiji98@gmail.com>
References: <20250224152704.70289-1-kuforiji98@gmail.com>
 <20250225101044.84210-1-kuforiji98@gmail.com>
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
 t/unit-tests/lib-oid.c   | 32 +++++++++++---------------------
 t/unit-tests/lib-oid.h   |  9 ++++++---
 t/unit-tests/unit-test.c |  2 ++
 5 files changed, 21 insertions(+), 26 deletions(-)

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
index 8f0ccac532..e0b3180f23 100644
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
 
@@ -11,42 +11,32 @@ int init_hash_algo(void)
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
-	int ret;
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

