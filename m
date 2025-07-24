Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C72E54AA
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367403; cv=none; b=fezMFQhA90xFYIkoW+LRNenh21mYB114UXUtrNy/3Ykqhg99ciKW1u9AolBnlZmNPJPNsGnsb/7F7Jk4ow3WYNi/RXJfMUg7aFxKtyQBKebUjC31Pd36lM2y7m+a94B/BgEeEYU01z3a4sKPrDNWNE7Z9pDt/Gq2PkCnd8EKydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367403; c=relaxed/simple;
	bh=nLkTdgK/R7Nc7fHXzm2sOWkfmxYDICoKZemYJW0EIBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOFozat4bqW4GHG3LURfdNonw0gskw5R6/3uR2tK9jeVL0CuAgqOFi+D5Tera3fTEqE1VJZ+qzM2iQRymEblj6fVRNdqO8Ez6I5ct/Eqeqj5T88XqumbJPsZLA46KTFrvu3P7/20tS2TgLtrqAGNEerwx8H3uj0tDHDOCCLnow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkMA3dQk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkMA3dQk"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45600581226so11112785e9.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753367399; x=1753972199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aYLPjoixFFMBoRkncrspzfWsVR2Eoyjrqop5vj7j1w=;
        b=LkMA3dQks/pXwGgnP+NfM2QIw8nhLKKUXHfrI7jVKDSmwe42oqx7bZTz8mUMuNj3Kz
         B/UxcywP7HlJ9ud6v4og3XZJ8UTMS6MCcCNh/DBqT5M8vw6Y5OfVucO6aVLjNrCPZilN
         ptFLpFUN4YvpIPWcnk2Fpgx43ON8za9k+LrvUHaCHseuN2CeeNWequO5heJghw4rYL+l
         ltBCy/Rdto/Eu07/+YdNQw26/nKfsU7JhYNJnK1ph+cEKYYzrP84wxGlAMo+YtLo1eVU
         Py/e5ocm8AT2LSVgsHwCt7JBB9yR5C7i0P6bN6fFFsHttH9QX2i1mCR0XauRE9G5BmCM
         Py0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367399; x=1753972199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aYLPjoixFFMBoRkncrspzfWsVR2Eoyjrqop5vj7j1w=;
        b=OETE+DnkyrufRwQsMJ+rxcv0uU5iHB3bza9NBi86gFGMbgGE0xKY6CCKCNEaED/t+N
         +f+6xevaTvSa7dsTR+dG3lR0yOaXrE4wEjYcWzp1O9iZK9WphvIUTAjpAo1wcrsyUkFI
         PUfytixLdutV2y0xm26815gjXqXleNw2hNvKBunD02KChQ6/GyvEeZcS4hoCk7QISVdX
         S3JpRE6W2sbwlCLq9yAl2x6KwCJucGifvpDv1i4DFLne/rp530N0rFo8No+6vtAPNuZR
         +XFHuebvxMCe5jz1cTXn+FuNj6jnbNds/DYZ9q69+plCLembx5PpmhCqkDHxw039U/Qw
         d+mA==
X-Gm-Message-State: AOJu0YzVzxqNRNJbVcixEcTHf6yN16zkmoY1KocX7PpEVTuZJaN2IrGB
	ky/ToXJcuDBsH9/rGk+RhoXwK6x14JiLDeoVXSs+GfyhExdW/2O59c3daCUREnhFShFfy4yK
X-Gm-Gg: ASbGncucCZpMuv801UQH65pX6t14CeTlbWpPFAHUa+n/95w4ruv5AeW/qfqz1xQxwHt
	QRfNRqH9J0Woc6bWNn1v7Oj+6hPr/g4C3MhovI7mFJ9bQ6TieodszrRWRRnfjZLyJpJdSKYshMT
	E5qEQU1s/lwswNYLi49C0U/leZkG+bEfrT6B260NxVTu/qCx2BMWZ9VLS+ihzMT0Ba/bkzlqKYU
	YuuMtPY2MH4E01Gp02E9Lh0Kp9UE4wxVMQOyNq/txmHT5epTc//kHvAW3VRTmttR1HTit+2tj/B
	Jhg+01+trPYU3bYZF7VQ+fx5XnC0JIqHvBEwxEJ9WH1gRKh41mXZdjqP8IBAipRWBEtLbWL/d6b
	0a4cdFPmjF5rV7UJt
X-Google-Smtp-Source: AGHT+IECyVBiDc9A/m0J2han2f1VPgvITT67v0wXKKN3MKVzqYtBiZ04PEBiyMdLpFtJOCeZg+AX4w==
X-Received: by 2002:a05:600c:8b46:b0:456:fd4:5322 with SMTP id 5b1f17b1804b1-45868c978cemr57603565e9.11.1753367399194;
        Thu, 24 Jul 2025 07:29:59 -0700 (PDT)
Received: from localhost.localdomain ([105.113.77.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586ec63d29sm22792135e9.1.2025.07.24.07.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:29:58 -0700 (PDT)
From: Seyi Kufoiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 02/10] t/unit-tests: convert reftable basics test to use clar test framework
Date: Thu, 24 Jul 2025 15:28:29 +0100
Message-ID: <20250724142837.67149-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724142837.67149-1-kuforiji98@gmail.com>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
 <20250724142837.67149-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kuforiji <kuforiji98@gmail.com>

Adapt reftable basics test file to clar by using clar assertions
where necessary.Break up test edge case to improve modularity and
clarity.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                         |   2 +-
 t/meson.build                    |   2 +-
 t/unit-tests/t-reftable-basics.c | 219 -----------------------------
 t/unit-tests/u-reftable-basics.c | 227 +++++++++++++++++++++++++++++++
 4 files changed, 229 insertions(+), 221 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-basics.c
 create mode 100644 t/unit-tests/u-reftable-basics.c

diff --git a/Makefile b/Makefile
index e4fa038508..a01103e3a6 100644
--- a/Makefile
+++ b/Makefile
@@ -1364,6 +1364,7 @@ CLAR_TEST_SUITES += u-oid-array
 CLAR_TEST_SUITES += u-oidmap
 CLAR_TEST_SUITES += u-oidtree
 CLAR_TEST_SUITES += u-prio-queue
+CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1377,7 +1378,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
 
-UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
diff --git a/t/meson.build b/t/meson.build
index f77f21536e..e00e8d41d6 100644
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
@@ -55,7 +56,6 @@ clar_unit_tests = executable('unit-tests',
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
index 0000000000..f105c22d15
--- /dev/null
+++ b/t/unit-tests/u-reftable-basics.c
@@ -0,0 +1,227 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "unit-test.h"
+#include "lib-reftable-clar.h"
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
+void test_reftable_basics__parse_names_drop_empty_string(void)
+{
+	char in[] = "a\n\nb\n";
+	char **out = parse_names(in, strlen(in));
+	cl_assert(out != NULL);
+	cl_assert_equal_s(out[0], "a");
+	/* simply '\n' should be dropped as empty string */
+	cl_assert_equal_s(out[1], "b");
+	cl_assert(out[2] == NULL);
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
+		cl_assert_equal_i(reftable_buf_addstr(&a, cases[i].a), 0);
+		cl_assert_equal_i(reftable_buf_addstr(&b, cases[i].b), 0);
+		cl_assert_equal_i(common_prefix_size(&a, &b), cases[i].want);
+		reftable_buf_reset(&a);
+		reftable_buf_reset(&b);
+	}
+	reftable_buf_release(&a);
+	reftable_buf_release(&b);
+}
+
+void test_reftable_basics__put_get_be64(void)
+{
+	uint64_t in = 0x1122334455667788;
+	uint8_t dest[8];
+	uint64_t out;
+	reftable_put_be64(dest, in);
+	out = reftable_get_be64(dest);
+	cl_assert(in == out);
+}
+
+void test_reftable_basics__put_get_be32(void)
+{
+	uint32_t in = 0x11223344;
+	uint8_t dest[4];
+	uint32_t out;
+	reftable_put_be32(dest, in);
+	out = reftable_get_be32(dest);
+	cl_assert_equal_i(in, out);
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
+void test_reftable_basics__alloc_grow(void)
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
+void test_reftable_basics__alloc_grow_or_null(void)
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

