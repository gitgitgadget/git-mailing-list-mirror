Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6D2B2DA
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949223; cv=none; b=uoAMGbCon1O/Wc+SYM9ZHf5LG1N1WdZZvgfrJ1tL3VQGxl5UWbQrMHYikUtOv8p0hmRGns9Eu9XFj2xKJYaVsnisr3j29AFE384B2Pj9X+RfiBT3XrP2voRAgrZb3PTwF/PrZ0uVUL4k3uqeJS4ELicTRAZgLkYazJZas05WWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949223; c=relaxed/simple;
	bh=q3uGrDcAXXxd+5ht59WbPHHqMp8V5BPD4M0QMrQDphc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbJTjKbvhVRzJIkw97EnOAsDF3kjCO76MZlD3Toj9b+pYXBi9B+ZUk1kVF2TX8IfCd/1Mo7HeI3wg90TMUFXgTu3OxCIl+UFVH3m3RKQiBy0g9Ji0hM3x3EL2rIk1MKp2exGgdCOpiBWFSNG2VTHG/eGynBhYK9wnN19WcTzPiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBEIF3iS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBEIF3iS"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913b539aabso3471324f8f.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745949219; x=1746554019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxgRYOxI2MbvbCYg7EQ5daRFUpIA8e8EZjInb5s88XU=;
        b=CBEIF3iSjpN9A+Bh5yiFSap5BDwCjoFAzrSDAsULDzqBAIo7kADyiTGTqArnvSZe2w
         FMPijJsBANKxK7rPMrEWFiDH1J3mq3pIciocdlRdgZHZNbkQjhz4PJi2FQHextdUBKD0
         L2Td+MeKRnlHehseAZB/W0lj8hHc+lYI1nzZA5VIZkvyA9GKcDN5UzUJm0oD5cT88rP1
         n3s+i9YcbaVH7EzuTtRblKYMmSu7liKrJcBkHloZGqiPOcjokgAogG6NuHGE+qzl2n8g
         JMgVhG3v5ux3T6h9RIBQT4PGHDVTeDdgOjv1rYq0hZaFbstCULiaFk5wUS7mt5Smauk9
         bI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949219; x=1746554019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxgRYOxI2MbvbCYg7EQ5daRFUpIA8e8EZjInb5s88XU=;
        b=hbllTWVWhyhMyktASFS+shYTbgjfZY43Id2vPKzaTw5TJRgIlr4/pyhc/xA7adOp8g
         TTRPp1c/69h3lRwTwCKPNFUPaQnhDUUEfclAD7XMDkNeRj0W07/CSCw9UTgs19j0BAkc
         v6Usyx28Fzgp0JBf5pP8VEW5awnvzCJUUmx/MDhdG//+c+Uq/jM69lcH/97bOfV8FY4d
         hcB68deieGhia2WQ3+wCPspmdJ/GxKk6Yk1Ulzp5PwmTKLg6RBHMomDL7UkjTEj1JBTk
         lu8VgbMC3K1pdQTMd9cH+tdyZYOcc18xpERm2E15iD8uW0nSl2bNmBw6+M6BqXDRw71x
         7vyg==
X-Gm-Message-State: AOJu0Yxn1CCYdbwobIXciHw/AdmGFI129C37Sl3AJtoxogsMy+7jyH+v
	dBMgFrtscqjk/yxUVOa/c2AzcgMTzRYx8lKZapCzsNAgJ395BbToaZxiypq9xcSfBA==
X-Gm-Gg: ASbGncuMUCmVEnU/vL3XKcz1e3ioNjbRSV3XSR1pM8W3LMKseX3lUQktH0jDFtSNdel
	sbBo/L5AirkdMVzaIbtmRyW9M2StGVES5/Ruojw86EKqHv0k3TsGx+4pC5cAj8RtyRJoUMY9P9A
	zzS+APSsFt4QTe8HvPdzXJR0EtvDka2efRPPJfu4qiqSr3boZ0o3V3bR6mLNcKcFKkp+hvJ5Xfh
	2/BZYRT5/od15o7SmsnzfgrLkoHRt+TNQDX8fbumWfnHHuKpVV+YEa3o84AEmQ7YBtBJPFCrELm
	ML57XBg79v4+Cl+gK2dumHXsI6NokoFMAf0=
X-Google-Smtp-Source: AGHT+IEBJckvJvSLGFdQCIsVriMglNIBLv0Ez+7hSKDW1vFCKy3xIp357W9ChCK6udoZAXJrv26wTQ==
X-Received: by 2002:a5d:47c5:0:b0:39c:30c9:822 with SMTP id ffacd0b85a97d-3a08f77c202mr240454f8f.30.1745949219355;
        Tue, 29 Apr 2025 10:53:39 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm14261782f8f.26.2025.04.29.10.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:53:38 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 02/10] t/unit-tests: convert reftable basics test to use clar test framework
Date: Tue, 29 Apr 2025 18:52:54 +0100
Message-ID: <20250429175302.23724-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429175302.23724-1-kuforiji98@gmail.com>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt reftable basics test file to clar by using clar assertions
where necessary.Break up test edge case to improve modularity and
clarity.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                         |   2 +-
 t/meson.build                    |   2 +-
 t/unit-tests/t-reftable-basics.c | 219 -------------------------------
 t/unit-tests/u-reftable-basics.c | 195 +++++++++++++++++++++++++++
 4 files changed, 197 insertions(+), 221 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-basics.c
 create mode 100644 t/unit-tests/u-reftable-basics.c

diff --git a/Makefile b/Makefile
index 13f9062a05..7b12bb078c 100644
--- a/Makefile
+++ b/Makefile
@@ -1362,6 +1362,7 @@ CLAR_TEST_SUITES += u-oid-array
 CLAR_TEST_SUITES += u-oidmap
 CLAR_TEST_SUITES += u-oidtree
 CLAR_TEST_SUITES += u-prio-queue
+CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1374,7 +1375,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
-UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
diff --git a/t/meson.build b/t/meson.build
index bfb744e886..8a42b595d9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -8,6 +8,7 @@ clar_test_suites = [
   'unit-tests/u-oidmap.c',
   'unit-tests/u-oidtree.c',
   'unit-tests/u-prio-queue.c',
+  'unit-tests/u-reftable-basics.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -54,7 +55,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-basics.c',
   'unit-tests/t-reftable-block.c',
   'unit-tests/t-reftable-merged.c',
   'unit-tests/t-reftable-pq.c',
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
deleted file mode 100644
index c9e751e49e..0000000000
--- a/t/unit-tests/t-reftable-basics.c
+++ /dev/null
@@ -1,219 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "test-lib.h"
-#include "reftable/basics.h"
-
-struct integer_needle_lesseq_args {
-	int needle;
-	int *haystack;
-};
-
-static int integer_needle_lesseq(size_t i, void *_args)
-{
-	struct integer_needle_lesseq_args *args = _args;
-	return args->needle <= args->haystack[i];
-}
-
-static void *realloc_stub(void *p UNUSED, size_t size UNUSED)
-{
-	return NULL;
-}
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	if_test ("binary search with binsearch works") {
-		int haystack[] = { 2, 4, 6, 8, 10 };
-		struct {
-			int needle;
-			size_t expected_idx;
-		} testcases[] = {
-			{-9000, 0},
-			{-1, 0},
-			{0, 0},
-			{2, 0},
-			{3, 1},
-			{4, 1},
-			{7, 3},
-			{9, 4},
-			{10, 4},
-			{11, 5},
-			{9000, 5},
-		};
-
-		for (size_t i = 0; i < ARRAY_SIZE(testcases); i++) {
-			struct integer_needle_lesseq_args args = {
-				.haystack = haystack,
-				.needle = testcases[i].needle,
-			};
-			size_t idx;
-
-			idx = binsearch(ARRAY_SIZE(haystack),
-					&integer_needle_lesseq, &args);
-			check_int(idx, ==, testcases[i].expected_idx);
-		}
-	}
-
-	if_test ("names_length returns size of a NULL-terminated string array") {
-		const char *a[] = { "a", "b", NULL };
-		check_int(names_length(a), ==, 2);
-	}
-
-	if_test ("names_equal compares NULL-terminated string arrays") {
-		const char *a[] = { "a", "b", "c", NULL };
-		const char *b[] = { "a", "b", "d", NULL };
-		const char *c[] = { "a", "b", NULL };
-
-		check(names_equal(a, a));
-		check(!names_equal(a, b));
-		check(!names_equal(a, c));
-	}
-
-	if_test ("parse_names works for basic input") {
-		char in1[] = "line\n";
-		char in2[] = "a\nb\nc";
-		char **out = parse_names(in1, strlen(in1));
-		check(out != NULL);
-		check_str(out[0], "line");
-		check(!out[1]);
-		free_names(out);
-
-		out = parse_names(in2, strlen(in2));
-		check(out != NULL);
-		check_str(out[0], "a");
-		check_str(out[1], "b");
-		check_str(out[2], "c");
-		check(!out[3]);
-		free_names(out);
-	}
-
-	if_test ("parse_names drops empty string") {
-		char in[] = "a\n\nb\n";
-		char **out = parse_names(in, strlen(in));
-		check(out != NULL);
-		check_str(out[0], "a");
-		/* simply '\n' should be dropped as empty string */
-		check_str(out[1], "b");
-		check(!out[2]);
-		free_names(out);
-	}
-
-	if_test ("common_prefix_size works") {
-		struct reftable_buf a = REFTABLE_BUF_INIT;
-		struct reftable_buf b = REFTABLE_BUF_INIT;
-		struct {
-			const char *a, *b;
-			int want;
-		} cases[] = {
-			{"abcdef", "abc", 3},
-			{ "abc", "ab", 2 },
-			{ "", "abc", 0 },
-			{ "abc", "abd", 2 },
-			{ "abc", "pqr", 0 },
-		};
-
-		for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
-			check(!reftable_buf_addstr(&a, cases[i].a));
-			check(!reftable_buf_addstr(&b, cases[i].b));
-			check_uint(common_prefix_size(&a, &b), ==, cases[i].want);
-			reftable_buf_reset(&a);
-			reftable_buf_reset(&b);
-		}
-		reftable_buf_release(&a);
-		reftable_buf_release(&b);
-	}
-
-	if_test ("reftable_put_be64 and reftable_get_be64 work") {
-		uint64_t in = 0x1122334455667788;
-		uint8_t dest[8];
-		uint64_t out;
-		reftable_put_be64(dest, in);
-		out = reftable_get_be64(dest);
-		check_int(in, ==, out);
-	}
-
-	if_test ("reftable_put_be32 and reftable_get_be32 work") {
-		uint32_t in = 0x11223344;
-		uint8_t dest[4];
-		uint32_t out;
-		reftable_put_be32(dest, in);
-		out = reftable_get_be32(dest);
-		check_int(in, ==, out);
-	}
-
-	if_test ("reftable_put_be24 and reftable_get_be24 work") {
-		uint32_t in = 0x112233;
-		uint8_t dest[3];
-		uint32_t out;
-		reftable_put_be24(dest, in);
-		out = reftable_get_be24(dest);
-		check_int(in, ==, out);
-	}
-
-	if_test ("put_be16 and get_be16 work") {
-		uint32_t in = 0xfef1;
-		uint8_t dest[3];
-		uint32_t out;
-		reftable_put_be16(dest, in);
-		out = reftable_get_be16(dest);
-		check_int(in, ==, out);
-	}
-
-	if_test ("REFTABLE_ALLOC_GROW works") {
-		int *arr = NULL, *old_arr;
-		size_t alloc = 0, old_alloc;
-
-		check(!REFTABLE_ALLOC_GROW(arr, 1, alloc));
-		check(arr != NULL);
-		check_uint(alloc, >=, 1);
-		arr[0] = 42;
-
-		old_alloc = alloc;
-		old_arr = arr;
-		reftable_set_alloc(NULL, realloc_stub, NULL);
-		check(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
-		check(arr == old_arr);
-		check_uint(alloc, ==, old_alloc);
-
-		old_alloc = alloc;
-		reftable_set_alloc(NULL, NULL, NULL);
-		check(!REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
-		check(arr != NULL);
-		check_uint(alloc, >, old_alloc);
-		arr[alloc - 1] = 42;
-
-		reftable_free(arr);
-	}
-
-	if_test ("REFTABLE_ALLOC_GROW_OR_NULL works") {
-		int *arr = NULL;
-		size_t alloc = 0, old_alloc;
-
-		REFTABLE_ALLOC_GROW_OR_NULL(arr, 1, alloc);
-		check(arr != NULL);
-		check_uint(alloc, >=, 1);
-		arr[0] = 42;
-
-		old_alloc = alloc;
-		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
-		check(arr != NULL);
-		check_uint(alloc, >, old_alloc);
-		arr[alloc - 1] = 42;
-
-		old_alloc = alloc;
-		reftable_set_alloc(NULL, realloc_stub, NULL);
-		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
-		check(arr == NULL);
-		check_uint(alloc, ==, 0);
-		reftable_set_alloc(NULL, NULL, NULL);
-
-		reftable_free(arr);
-	}
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
new file mode 100644
index 0000000000..63dd568faf
--- /dev/null
+++ b/t/unit-tests/u-reftable-basics.c
@@ -0,0 +1,195 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "unit-test.h"
+#include "reftable/basics.h"
+
+struct integer_needle_lesseq_args {
+	int needle;
+	int *haystack;
+};
+
+static int integer_needle_lesseq(size_t i, void *_args)
+{
+	struct integer_needle_lesseq_args *args = _args;
+	return args->needle <= args->haystack[i];
+}
+
+static void *realloc_stub(void *p UNUSED, size_t size UNUSED)
+{
+	return NULL;
+}
+
+void test_reftable_basics__binsearch(void)
+{
+	int haystack[] = { 2, 4, 6, 8, 10 };
+	struct {
+		int needle;
+		size_t expected_idx;
+	} testcases[] = {
+		{-9000, 0},
+		{-1, 0},
+		{0, 0},
+		{2, 0},
+		{3, 1},
+		{4, 1},
+		{7, 3},
+		{9, 4},
+		{10, 4},
+		{11, 5},
+		{9000, 5},
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(testcases); i++) {
+		struct integer_needle_lesseq_args args = {
+			.haystack = haystack,
+			.needle = testcases[i].needle,
+		};
+		size_t idx;
+
+		idx = binsearch(ARRAY_SIZE(haystack),
+				&integer_needle_lesseq, &args);
+		cl_assert_equal_i(idx, testcases[i].expected_idx);
+	}
+
+}
+
+void test_reftable_basics__names_length(void)
+{
+	const char *a[] = { "a", "b", NULL };
+	cl_assert_equal_i(names_length(a), 2);
+}
+
+void test_reftable_basics__names_equal(void)
+{
+	const char *a[] = { "a", "b", "c", NULL };
+	const char *b[] = { "a", "b", "d", NULL };
+	const char *c[] = { "a", "b", NULL };
+
+	cl_assert(names_equal(a, a));
+	cl_assert(!names_equal(a, b));
+	cl_assert(!names_equal(a, c));
+}
+
+void test_reftable_basics__parse_names(void)
+{
+	char in1[] = "line\n";
+	char in2[] = "a\nb\nc";
+	char **out = parse_names(in1, strlen(in1));
+	cl_assert(out != NULL);
+	cl_assert_equal_s(out[0], "line");
+	cl_assert(!out[1]);
+	free_names(out);
+
+	out = parse_names(in2, strlen(in2));
+	cl_assert(out != NULL);
+	cl_assert_equal_s(out[0], "a");
+	cl_assert_equal_s(out[1], "b");
+	cl_assert_equal_s(out[2], "c");
+	cl_assert(!out[3]);
+	free_names(out);
+}
+
+void test_reftable_basics__common_prefix_size(void)
+{
+	struct reftable_buf a = REFTABLE_BUF_INIT;
+	struct reftable_buf b = REFTABLE_BUF_INIT;
+	struct {
+		const char *a, *b;
+		int want;
+	} cases[] = {
+		{"abcdef", "abc", 3},
+		{ "abc", "ab", 2 },
+		{ "", "abc", 0 },
+		{ "abc", "abd", 2 },
+		{ "abc", "pqr", 0 },
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
+		reftable_buf_reset(&a);
+		reftable_buf_reset(&b);
+		cl_assert_equal_i(reftable_buf_addstr(&a, cases[i].a), 0);
+		cl_assert_equal_i(reftable_buf_addstr(&b, cases[i].b), 0);
+		cl_assert_equal_i(common_prefix_size(&a, &b), cases[i].want);
+	}
+	reftable_buf_release(&a);
+	reftable_buf_release(&b);
+}
+
+void test_reftable_basics__put_get_be24(void)
+{
+	uint32_t in = 0x112233;
+	uint8_t dest[3];
+	uint32_t out;
+	reftable_put_be24(dest, in);
+	out = reftable_get_be24(dest);
+	cl_assert_equal_i(in, out);
+}
+
+void test_reftable_basics__put_get_be16(void)
+{
+	uint32_t in = 0xfef1;
+	uint8_t dest[3];
+	uint32_t out;
+	reftable_put_be16(dest, in);
+	out = reftable_get_be16(dest);
+	cl_assert_equal_i(in, out);
+}
+
+void test_reftable_basics__grow_alloc(void)
+{
+	int *arr = NULL, *old_arr;
+	size_t alloc = 0, old_alloc;
+
+	cl_assert_equal_i(REFTABLE_ALLOC_GROW(arr, 1, alloc), 0);
+	cl_assert(arr != NULL);
+	cl_assert(alloc >= 1);
+	arr[0] = 42;
+
+	old_alloc = alloc;
+	old_arr = arr;
+	reftable_set_alloc(NULL, realloc_stub, NULL);
+	cl_assert(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
+	cl_assert(arr == old_arr);
+	cl_assert_equal_i(alloc, old_alloc);
+
+	old_alloc = alloc;
+	reftable_set_alloc(NULL, NULL, NULL);
+	cl_assert_equal_i(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc), 0);
+	cl_assert(arr != NULL);
+	cl_assert(alloc > old_alloc);
+	arr[alloc - 1] = 42;
+
+	reftable_free(arr);
+}
+
+void test_reftable_basics__grow_alloc_or_null(void)
+{
+	int *arr = NULL;
+	size_t alloc = 0, old_alloc;
+
+	REFTABLE_ALLOC_GROW_OR_NULL(arr, 1, alloc);
+	cl_assert(arr != NULL);
+	cl_assert(alloc >= 1);
+	arr[0] = 42;
+
+	old_alloc = alloc;
+	REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
+	cl_assert(arr != NULL);
+	cl_assert(alloc > old_alloc);
+	arr[alloc - 1] = 42;
+
+	old_alloc = alloc;
+	reftable_set_alloc(NULL, realloc_stub, NULL);
+	REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
+	cl_assert(arr == NULL);
+	cl_assert_equal_i(alloc, 0);
+	reftable_set_alloc(NULL, NULL, NULL);
+
+	reftable_free(arr);
+}
-- 
2.43.0

