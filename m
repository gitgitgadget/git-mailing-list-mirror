Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6501EB9ED
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040219; cv=none; b=UpUcJ35lrRZzIfv6/sIaN5Sk3JEIZCftwGpX5o1q9FJykVCLf04hv4Ykhs9KBxiCjw4jQOAPEt0YzC8DKVxyiNwwgSAvZQfjzWZvVIPX4nnXFKmVb8S//hm6VoNqh5f2fJIYz2EqTNpDtYnYHe+83CWxdndM6DKerJUiml3iYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040219; c=relaxed/simple;
	bh=Be3KJTWu3uvyXcSjaqWEvMLRjjdwMqKHoc/BlKEw/Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sceJ+ytQ4x/liIBBtzv60q/cfjFLJKULsero+xaFBjWdeWStKfCHRnqzQ2zoNwYD0aoFxTu4tlvwQy6CLt5mNMg5zXvO50qhKtJ6f1SMf9tPFc7I/MjfGR7bRqhf3gY82mMcIsaIzlWw6d6JJvEPJ/y4JuDMHlTOYIdYARC/vqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2talzlS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2talzlS"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso865890a12.1
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 00:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740040213; x=1740645013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtN+XstNeI7gMandsxKaPbJcGHFunT4zd9h1h42MJ+A=;
        b=X2talzlSjMJqs6eq3btSyGWmVcduBz3uDNt8aNhFZa2GII/4rWO64ORq1zXEQycUO8
         AvZ2cOFaOGxiE/+Vv2/TuShWA9yi2asVoI1VVcR1OddTL4H9lnl39ZoN/Vdf4p90IEUF
         W/stS8st1yqEhZDJosAdNkOY6k3iXutLlf6QJTwzXuh2UO7AAkqF4AhVZ30OiVjvMJWc
         ZoB1wOkF6I/X/rfFXbNEqVT62VFrm+3Y8T40CB+oPKfDFJ92Y5qx7SD6xXyi0P51j8CC
         Ttwqf4mqDJARNOJm1avMTM0udtwAVd3hLJPr30UbJtNK9IExV7hnFFRQeIl9IHQ2/5Sd
         NCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040213; x=1740645013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtN+XstNeI7gMandsxKaPbJcGHFunT4zd9h1h42MJ+A=;
        b=rZbgxgLmYMj5UZtpVBkq8j2a1f5P79uuG2+Tbf6EUOkGw7UIA66p92TUfFFQHR4a3g
         nwyLpj9+psmjiltZMEggCUikqCSmzbz9/Uxw6cIM1BcF2MmGOUabjD7xBPKaU5tWjB0N
         3X52j+rgLKW+FzzenrJX83L2JSXCljDdUzcx7uba1XFLnXZSyRsqWvOXGJjJV4jbY78e
         MM4xk0UWO84PxI39u4963J44ecdM2CMRx9OptfwM5hq0BRvKMyXAiAs/dpfJX5cCL2Ie
         kg1PFC2eFw/xJlnaNbqYZ6mZkudw63zstsvlrOg4DNwWM+lc6HiH/64FqO66M2jKgtqG
         7j4g==
X-Gm-Message-State: AOJu0Yz98VsyVW63Z8rG6sSkeVBC3xHcwzlHWuG8rZ3yhtUY0RJUNyDn
	omlJP1eYXs+YurBzlu4hPZy2hX6GiYVwNvHUM9HqA0D7KvXaPqeKQlnkMF0IUGo81w==
X-Gm-Gg: ASbGncv7z98ygoGSZq/ZzrMi5U79jc9+Ra9Yw1Tk/xa6u6Jbvpkot61Xuo9WFWSlpUD
	5mrgDXmepYFI3wyq7lJnk93Hf50Jr/Y3T1M5U+1qrlRBvRF6zyFwQnFO8IcI3xMXsofvlbgys1N
	To5z3OTdh4e0PAFXBw3KKhAdIl1Z5WYDyzfDE6TM9H6ix978rB/dSeGI5kzNilYVwY0X3kTpFjs
	Wvx2JwdCePkc5Pp+PycK5XCNY9mj9iG7KwVTYqA35GPc444X+ouTZZ1m7m6BZ2+IhhRrSRZxDgb
	zzpTweG0B2VdPqu910b2CKmAYz8=
X-Google-Smtp-Source: AGHT+IF0YLhABO9SfXLxGvbrnIi0C4GwW568u0utQdHBc3WPn2dq+Ue198PmYcg07tn3ZxqQkuEvWg==
X-Received: by 2002:a17:907:d204:b0:abb:b249:4410 with SMTP id a640c23a62f3a-abbb249464amr1247096966b.39.1740040212987;
        Thu, 20 Feb 2025 00:30:12 -0800 (PST)
Received: from localhost.localdomain ([154.118.9.41])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abbdf53d765sm230533966b.39.2025.02.20.00.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:30:12 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 2/5] t/unit-tests: convert oid-array test to use clar
Date: Thu, 20 Feb 2025 09:29:56 +0100
Message-ID: <20250220082959.10854-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250220082959.10854-1-kuforiji98@gmail.com>
References: <20250220082959.10854-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt oid-array test script to clar framework by using clar assertions
where necessary. Remove descriptions from macros to reduce
redundancy, and move test input arrays to global scope for reuse across
multiple test functions. Introduce `test_oid_array__initialize()` to
explicitly initialize the hash algorithm.

These changes streamline the test suite, making individual tests
self-contained and reducing redundant code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                      |   2 +-
 t/meson.build                                 |   2 +-
 t/unit-tests/{t-oid-array.c => u-oid-array.c} | 123 +++++++++---------
 3 files changed, 65 insertions(+), 62 deletions(-)
 rename t/unit-tests/{t-oid-array.c => u-oid-array.c} (35%)

diff --git a/Makefile b/Makefile
index bcf5ed3f85..f8e061365b 100644
--- a/Makefile
+++ b/Makefile
@@ -1356,6 +1356,7 @@ CLAR_TEST_SUITES += u-example-decorate
 CLAR_TEST_SUITES += u-hash
 CLAR_TEST_SUITES += u-hashmap
 CLAR_TEST_SUITES += u-mem-pool
+CLAR_TEST_SUITES += u-oid-array
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
@@ -1366,7 +1367,6 @@ CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
-UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-reftable-basics
diff --git a/t/meson.build b/t/meson.build
index 780939d49f..93410a8545 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -4,6 +4,7 @@ clar_test_suites = [
   'unit-tests/u-hash.c',
   'unit-tests/u-hashmap.c',
   'unit-tests/u-mem-pool.c',
+  'unit-tests/u-oid-array.c',
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
@@ -48,7 +49,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-oid-array.c',
   'unit-tests/t-oidmap.c',
   'unit-tests/t-oidtree.c',
   'unit-tests/t-reftable-basics.c',
diff --git a/t/unit-tests/t-oid-array.c b/t/unit-tests/u-oid-array.c
similarity index 35%
rename from t/unit-tests/t-oid-array.c
rename to t/unit-tests/u-oid-array.c
index 45b59a2a51..6d173dc004 100644
--- a/t/unit-tests/t-oid-array.c
+++ b/t/unit-tests/u-oid-array.c
@@ -1,22 +1,18 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
-#include "test-lib.h"
-#include "lib-oid.h"
+#include "unit-test.h"
 #include "oid-array.h"
 #include "hex.h"
 
-static int fill_array(struct oid_array *array, const char *hexes[], size_t n)
+static void fill_array(struct oid_array *array, const char *hexes[], size_t n)
 {
 	for (size_t i = 0; i < n; i++) {
 		struct object_id oid;
 
-		if (!check_int(get_oid_arbitrary_hex(hexes[i], &oid), ==, 0))
-			return -1;
+		cl_parse_any_oid(hexes[i], &oid);
 		oid_array_append(array, &oid);
 	}
-	if (!check_uint(array->nr, ==, n))
-		return -1;
-	return 0;
+	cl_assert_equal_i(array->nr, n);
 }
 
 static int add_to_oid_array(const struct object_id *oid, void *data)
@@ -34,30 +30,22 @@ static void t_enumeration(const char **input_args, size_t input_sz,
 			 actual = OID_ARRAY_INIT;
 	size_t i;
 
-	if (fill_array(&input, input_args, input_sz))
-		return;
-	if (fill_array(&expect, expect_args, expect_sz))
-		return;
+	fill_array(&input, input_args, input_sz);
+	fill_array(&expect, expect_args, expect_sz);
 
 	oid_array_for_each_unique(&input, add_to_oid_array, &actual);
-	if (!check_uint(actual.nr, ==, expect.nr))
-		return;
-
-	for (i = 0; i < actual.nr; i++) {
-		if (!check(oideq(&actual.oid[i], &expect.oid[i])))
-			test_msg("expected: %s\n       got: %s\n     index: %" PRIuMAX,
-				 oid_to_hex(&expect.oid[i]), oid_to_hex(&actual.oid[i]),
-				 (uintmax_t)i);
-	}
+	cl_assert_equal_i(actual.nr, expect.nr);
+
+	for (i = 0; i < actual.nr; i++)
+		cl_assert(oideq(&actual.oid[i], &expect.oid[i]));
 
 	oid_array_clear(&actual);
 	oid_array_clear(&input);
 	oid_array_clear(&expect);
 }
 
-#define TEST_ENUMERATION(input, expect, desc)                                     \
-	TEST(t_enumeration(input, ARRAY_SIZE(input), expect, ARRAY_SIZE(expect)), \
-			   desc " works")
+#define TEST_ENUMERATION(input, expect)                                     \
+	t_enumeration(input, ARRAY_SIZE(input), expect, ARRAY_SIZE(expect));
 
 static void t_lookup(const char **input_hexes, size_t n, const char *query_hex,
 		     int lower_bound, int upper_bound)
@@ -66,61 +54,76 @@ static void t_lookup(const char **input_hexes, size_t n, const char *query_hex,
 	struct object_id oid_query;
 	int ret;
 
-	if (!check_int(get_oid_arbitrary_hex(query_hex, &oid_query), ==, 0))
-		return;
-	if (fill_array(&array, input_hexes, n))
-		return;
+	cl_parse_any_oid(query_hex, &oid_query);
+	fill_array(&array, input_hexes, n);
 	ret = oid_array_lookup(&array, &oid_query);
 
-	if (!check_int(ret, <=, upper_bound) ||
-	    !check_int(ret, >=, lower_bound))
-		test_msg("oid query for lookup: %s", oid_to_hex(&oid_query));
+	cl_assert(ret <= upper_bound);
+	cl_assert(ret >= lower_bound);
 
 	oid_array_clear(&array);
 }
 
-#define TEST_LOOKUP(input_hexes, query, lower_bound, upper_bound, desc) \
-	TEST(t_lookup(input_hexes, ARRAY_SIZE(input_hexes), query,      \
-		      lower_bound, upper_bound),                        \
-	     desc " works")
+#define TEST_LOOKUP(input_hexes, query, lower_bound, upper_bound) \
+	t_lookup(input_hexes, ARRAY_SIZE(input_hexes), query,      \
+		      lower_bound, upper_bound);
 
-static void setup(void)
+void test_oid_array__initialize(void)
 {
 	/* The hash algo is used by oid_array_lookup() internally */
 	int algo = init_hash_algo();
-	if (check_int(algo, !=, GIT_HASH_UNKNOWN))
-		repo_set_hash_algo(the_repository, algo);
+	cl_assert(algo != GIT_HASH_UNKNOWN);
+	repo_set_hash_algo(the_repository, algo);
 }
 
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
+static const char *arr_input[] = { "88", "44", "aa", "55" };
+static const char *arr_input_dup[] = { "88", "44", "aa", "55",
+				       "88", "44", "aa", "55",
+				       "88", "44", "aa", "55" };
+static const char *res_sorted[] = { "44", "55", "88", "aa" };
+
+void test_oid_array__enumerate_unique(void)
 {
-	const char *arr_input[] = { "88", "44", "aa", "55" };
-	const char *arr_input_dup[] = { "88", "44", "aa", "55",
-					"88", "44", "aa", "55",
-					"88", "44", "aa", "55" };
-	const char *res_sorted[] = { "44", "55", "88", "aa" };
-	const char *nearly_55;
+	TEST_ENUMERATION(arr_input, res_sorted);
+}
+
+void test_oid_array__enumerate_duplicate(void)
+{
+	TEST_ENUMERATION(arr_input_dup, res_sorted);
+}
+
+void test_oid_array__lookup(void)
+{
+	TEST_LOOKUP(arr_input, "55", 1, 1);
+}
 
-	if (!TEST(setup(), "setup"))
-		test_skip_all("hash algo initialization failed");
+void test_oid_array__lookup_non_existent(void)
+{
+	TEST_LOOKUP(arr_input, "33", INT_MIN, -1);
+}
+
+void test_oid_array__lookup_duplicates(void)
+{
+	TEST_LOOKUP(arr_input_dup, "55", 3, 5);
+}
 
-	TEST_ENUMERATION(arr_input, res_sorted, "ordered enumeration");
-	TEST_ENUMERATION(arr_input_dup, res_sorted,
-			 "ordered enumeration with duplicate suppression");
+void test_oid_array__lookup_non_existent_dup(void)
+{
+	TEST_LOOKUP(arr_input_dup, "66", INT_MIN, -1);
+}
 
-	TEST_LOOKUP(arr_input, "55", 1, 1, "lookup");
-	TEST_LOOKUP(arr_input, "33", INT_MIN, -1, "lookup non-existent entry");
-	TEST_LOOKUP(arr_input_dup, "55", 3, 5, "lookup with duplicates");
-	TEST_LOOKUP(arr_input_dup, "66", INT_MIN, -1,
-		    "lookup non-existent entry with duplicates");
+void test_oid_array__lookup_almost_dup(void)
+{
+	const char *nearly_55;
 
 	nearly_55 = init_hash_algo() == GIT_HASH_SHA1 ?
 			"5500000000000000000000000000000000000001" :
 			"5500000000000000000000000000000000000000000000000000000000000001";
-	TEST_LOOKUP(((const char *[]){ "55", nearly_55 }), "55", 0, 0,
-		    "lookup with almost duplicate values");
-	TEST_LOOKUP(((const char *[]){ "55", "55" }), "55", 0, 1,
-		    "lookup with single duplicate value");
 
-	return test_done();
+	TEST_LOOKUP(((const char *[]){ "55", nearly_55 }), "55", 0, 0);
+}
+
+void test_oid_array__lookup_single_dup(void)
+{
+	TEST_LOOKUP(((const char *[]){ "55", "55" }), "55", 0, 1);
 }
-- 
2.47.0.86.g15030f9556

