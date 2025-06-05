Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4A1C861D
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132445; cv=none; b=px3/yZps1GhocYEFp6elDBZP1TLMicPsiQIqywTP3mpeob0PZz+VJ1Wl7bzHdTXAvdYxw43z9sZf3qYrGvWjjpaYf/LQHlCOZ7RtcuzNshBLRFSVKTP0xI8OvCKlU8AJ/1v64D0L/4OQgeSVp/H6fVauZpIsGUEHROh1SFd3Xbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132445; c=relaxed/simple;
	bh=3+A8BzM0uBf0uEYzHTL5WmmHOpD0ePZaD/3XGdKg/kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeX41I3ok3GOms/7PIKa00tNEPkKqipK7pJS8CQalH7SX08VNN3xruWPR0T9Eynu05OAKlo0+NJYef/odnHGRgy2uYskc7dGXaXPokXZhJEz967FZWIjlIFJ+GyUFWdOZWdr4tfCXGWLyi6yCJNOMUr9jOFFrLzWRDDMgGa/xcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWW2Pig3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWW2Pig3"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a5096158dcso865951f8f.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749132442; x=1749737242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ltA86cQmItPVlSGbUVUduOQrIjILZWgU1C57GOqHIY=;
        b=hWW2Pig3OuZCbm7y+I/HnP9GZfTE3w04zjKP+Pf2hit9jx/jKMCPGBJYFh5xoiqkH9
         jfTrVaR9ni0IPrAiYFHEAbaavcIupkH6HXZc1Qj4KqvWlBT2+mrV2wMJeDL03XLjp6+b
         hmzjl7YzLpPKWfPISg6SK/ZmF4aMyXRWL6rAZ/rJNeT3jqc6kxztKLGqBngfqinCz5Pt
         xiM3++iM1Sl8J8bujDgWbbfkxJ4KZgZKZLEfM+VybcJNUdZwWkpgqn6h0yKYox2hFsnK
         hXxx8P07gC/3kLHbmGLH+yhImrPWY0YXsB0G6l9LeF9ZUHaO1WZvc8ndFlFyh6kB97iD
         tcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749132442; x=1749737242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ltA86cQmItPVlSGbUVUduOQrIjILZWgU1C57GOqHIY=;
        b=KfEsLtDB0x8+6JOrVzglPlbHev70uJB1WntYuUDm2U2jI79pmIzPIJls81VU3iv9X6
         BvlDKtQhAhzfrglEtuRZllB7O+aOr/kJuRHjQq7coN/d9qvZlbjhUY0Wke3ZUazmonGS
         0DL7Wtd1Ipt9rnBmdnKu7Bh4pqHo70X75SHi2ldtbvjU78cpabpKupiJNMRlJ2fAQE1G
         gcfk8YDNSw9pG9U+0MJ2GwTvFcJ1hmYtQC4wo4CyUCu6TvAz1CJ6mlPzEi3rV85kyqrf
         vAp07qm8r0Rz/38w+BaPi4mdlmisdsw1/UDvDAi5s/pdbnxC9MTRkyOSdNKO2wYdeELL
         i6qQ==
X-Gm-Message-State: AOJu0YyQnxiE5QP6CLIaDzk1VBruHMYxFvPlLziKbpF6aDuRbLYb14+M
	iQxiY8HyZwMAxm99t3pFt98AL2f+QfuknC6oBQpfcY1E4Lu/YaAJ+SGLUA5wFdzBU1o=
X-Gm-Gg: ASbGncuR9XHP7Qi7EvH5T5dsJjzj4VqvN37QboFlFR+mpkQq6VdMO462q+E2Fui0DB1
	1uIzXh3gY3x6SZyaWHLEDOep+YzpEntqeQd2tgwvwFiUZ+xtXY3RXFquLnfaJBQ2HqQgBTAG6e8
	bonTEkn0puEGXUOq1XhWifas5nk3eaR6bqjbZSLseHQwJS1KjzyDKA2PVB6pQTJm3dMfeQAuRQa
	l0zz0xLJ3jIwB+vF5Joy13qrrGEye1h1WPyCashECzu7TaYL4HcbfUHMZIQm24stpuOMBVQ1PO8
	kk4zqVmUKexPzJ9teCGShoE32uraI8XHP93saSxixzS/uFW/7/goaKmH
X-Google-Smtp-Source: AGHT+IFndGaQKT/nASt8FGtBpbJJvboNTPlffrXM/wD1Ts2g3kyGAtZt5NlyM+Lm08/V9BW+SiIFuQ==
X-Received: by 2002:a05:6000:3102:b0:3a4:f744:e01b with SMTP id ffacd0b85a97d-3a51d97fb2fmr5355525f8f.39.1749132441286;
        Thu, 05 Jun 2025 07:07:21 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fe39fc52sm8827305e9.27.2025.06.05.07.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:07:20 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v4 02/10] t/unit-tests: convert reftable basics test to use clar test framework
Date: Thu,  5 Jun 2025 15:06:36 +0100
Message-ID: <20250605140644.239199-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605140644.239199-1-kuforiji98@gmail.com>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
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

