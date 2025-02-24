Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280C23BCED
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410881; cv=none; b=hhUbbnG3mH76mpPbQ8BWC0wJz3RKIpdnJorZl1w3RseUgAkFGUd8PG2eM9jpbLfE7EHoLsEZL6ZjHQ9XUbnbDZf2Q5T9FgcHL34Y8JvuMYslmPSlHwsd05/yhpMEAw+kBtafiP1FZzNGUo0/XpXdYpvIzd6CygtGqtHs4nyL9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410881; c=relaxed/simple;
	bh=A01EJzzZiByvriqE51xBYmWYBxsYKlH+ASS/hzAjoro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfccnJw3Ebwh2tn/+PUBK9mAUkiYC9P1b1lHRMg2WsVf9nZtV8iSgAeFog13BfruuZ5vDKWptzlHQfp1L26UYsgYBkHI9WJFlrkSbbXV415dtnjcHPS6Jh/bAHaX6tVBqpRqHL4nB+GHTk/4OqxkfQxlXevlTS8sJXRbECdkRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX6blCDl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX6blCDl"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f406e9f80so4248585f8f.2
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740410878; x=1741015678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO1c+28Pbxy1nqeTNAkDEuYLGqNpuqYXvjNj66FccDg=;
        b=TX6blCDlREQAiC5Qt/1NAgnOQZOlkuWRWNE5Ztjd4imlzE15VjuqdRYjUmRciwfGID
         +CyiDESJFr1kLR1N7GyObLV8lUy6oZdzQcn5SCMabTU8D/ej2pRHy9KeSm8U5Ho17HAR
         FmNjpFUgND2hHvOZ4EpEC1pXZPLrI0TIC+9BCwpHjgOcwL58FVAGkk4BZ/cp4v280aP7
         D+Kq/netuttV9ilNMFsWoDIbAkF0FF5+m9CwY1/+Xi5zC90Oo4U/mJ801B2mEFsdC3Z9
         eJO0Wmf5UF9LxwAN8bQLhN2Kxe2P5DwSLzkMaOUZN6HpnWkI5kdqjia/p1LN7e2dKLPV
         N1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410878; x=1741015678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WO1c+28Pbxy1nqeTNAkDEuYLGqNpuqYXvjNj66FccDg=;
        b=leA7YbzjgorrF0kBZ+n1yxmiiHkU1x/DfwrUXldzsfvaRPlPcmlvPAv+JlqxFKzphp
         SUfknf7pLoGDIj2RFAG6RWTGvyGsbm5/UNa8SnPlLKoWYnttQ9kA42J/xXmojzonCJmC
         ug0lXbduy7jfBNThCYDA41HdUyKocXy071OA520VyJVkg7rRUv193a4NJBC3ZB9DChoW
         Bqh/FtyexywGyiaV47rWCl3ce2AJ333dDpjCf17Oipj4GGXMjRY9PAPORDTxj+jAIPmf
         dV9+SGZzAmeW2+pHUWxHYLHt1Iwb1LJ/J8wVjkuQoeg4T2Mk8cjUyOqwqFKbGx5vIcF7
         SJAQ==
X-Gm-Message-State: AOJu0Yxp8JU4KfWnKIhIT09WTteB72lEBG2nyaJPrKMTunUDvqiQ8J9Z
	sCPA1xoXQMh8recMltrKiPyW5f5QvZ7LygiC0trNt8qiPRfmIVg2s++3RyPIc6F42g==
X-Gm-Gg: ASbGnctK1TOLTC0WtNuSzWbhC+aljbAxmTg9buPIfXjXYCAlx0ChE5x87y3HD89Pq+d
	+tDGbWBVJtMonsedRyN84pUljqqxc6fT4actPRpkuQS1C5xK8//m17QOGxql3UonV7tqdu/VjGs
	5ny1XSOCm9cVhNJb9ZUcS+yyAsKBg6qXK7xFzj0Muxid8NKIKeN9QXw2vXD1Vd0qpL/SFruyvZL
	K1AMNuq85FuYic/2JF9HIrFwfxi1FywH3RV2ukXd8B5oSK87fOc5rvI6YoIinHDHYy1UNseyDrW
	W1mkMNbAQqKH+QgTVGSZHWmsiBlstUexM8BZpbs=
X-Google-Smtp-Source: AGHT+IEugPWIBUa/jXqqUelsH7ybiuIdHImy6cT1mmfIvBL5B4RRPH0wR9jU0S4UPCwNVusHiOrRPg==
X-Received: by 2002:a5d:64c9:0:b0:38f:465d:fdf5 with SMTP id ffacd0b85a97d-38f6e97a12emr10322050f8f.26.1740410877611;
        Mon, 24 Feb 2025 07:27:57 -0800 (PST)
Received: from localhost.localdomain ([41.217.53.197])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-439b02e425esm109048915e9.17.2025.02.24.07.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:27:57 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 2/4] t/unit-tests: convert oid-array test to use clar test framework
Date: Mon, 24 Feb 2025 16:27:02 +0100
Message-ID: <20250224152704.70289-3-kuforiji98@gmail.com>
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
 t/unit-tests/{t-oid-array.c => u-oid-array.c} | 125 +++++++++---------
 3 files changed, 66 insertions(+), 63 deletions(-)
 rename t/unit-tests/{t-oid-array.c => u-oid-array.c} (34%)

diff --git a/Makefile b/Makefile
index 81799488f0..c9b0320fcb 100644
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
@@ -1367,7 +1368,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
-UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-reftable-basics
diff --git a/t/meson.build b/t/meson.build
index 862cf1cfd4..1b17a53acc 100644
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
@@ -49,7 +50,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-oid-array.c',
   'unit-tests/t-oidmap.c',
   'unit-tests/t-oidtree.c',
   'unit-tests/t-reftable-basics.c',
diff --git a/t/unit-tests/t-oid-array.c b/t/unit-tests/u-oid-array.c
similarity index 34%
rename from t/unit-tests/t-oid-array.c
rename to t/unit-tests/u-oid-array.c
index 45b59a2a51..e48a433f21 100644
--- a/t/unit-tests/t-oid-array.c
+++ b/t/unit-tests/u-oid-array.c
@@ -1,22 +1,19 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
-#include "test-lib.h"
+#include "unit-test.h"
 #include "lib-oid.h"
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
@@ -34,30 +31,22 @@ static void t_enumeration(const char **input_args, size_t input_sz,
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
@@ -66,61 +55,75 @@ static void t_lookup(const char **input_hexes, size_t n, const char *query_hex,
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
-	int algo = init_hash_algo();
-	if (check_int(algo, !=, GIT_HASH_UNKNOWN))
-		repo_set_hash_algo(the_repository, algo);
+	int algo = cl_setup_hash_algo();
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
 
-	nearly_55 = init_hash_algo() == GIT_HASH_SHA1 ?
+	nearly_55 = cl_setup_hash_algo() == GIT_HASH_SHA1 ?
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

