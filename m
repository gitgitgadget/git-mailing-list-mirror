Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449F847B
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722691378; cv=none; b=PNl1CEtMo/D/eMeUI6ndka2ybKRNBHuLiAJxeAryMLg3QW67xR4wAnXHSTZhOqCb8o/rAkuKBILIyGXyaPc7p0YC5JuEhPDry434SbETi/gMJgmzTN8PZj/11bGfO7W+d9OBMG4E7b4UqcQVgEmZk9I2UE65e+wOUp5g4j3KLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722691378; c=relaxed/simple;
	bh=GputoBb9LoOLGf8OKRpPK3FUdIXG7F2u0ToarPH1I2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMasOrlB9+U9yiOt9GRNc22bF6rkpJ4dpX9NqaKeHaRey6ne8rnHHovSzamPEQRq7jDvNcDHs2E1jm+oZVRLm45SgIQdOtQ06keQs0IUKPi+Y82/Rw2biNhcMLp5Kx+Zo6tuGRVSyLZ8UfSTCJVKvJoebhGSnfsLVpqC1n+wFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHwe4EjR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHwe4EjR"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d316f0060so2773853b3a.1
        for <git@vger.kernel.org>; Sat, 03 Aug 2024 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722691376; x=1723296176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpzU0KSOtMsQvjRNB3cvVXM3G9Og31Yo6y1srdjMGjo=;
        b=YHwe4EjRWEyBx8jyojnZkJQqDjw5SzhxNm1dkU9Hif2if2kElUNvkLGlzVsuacSH/K
         sEeXj3dD1gMTNWZv6wyOJ96IOEMm8x+RuDXTavYqO74j+ZPbdEQSat+svzxRjWXqzpyD
         Sh/clTayN9WD+FAHgYOkuAMz1gnALWCGovkPVhl+Zpjq5wb955FQ3VmXDJ54xnzknb3Y
         0E+cG6sFlBw2UQ3q92FKGl2AXm3MPqVZKsBvBF74Jc+tdRpTTCwA9haZ9jiHfPkr8h3a
         T8+5wZVmnr53mmkib1ZQ0HIJO9VX4HJwsvgeB7zvX+o3yZt3xKPTaYZFh7sS8ASaOHPU
         3K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722691376; x=1723296176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpzU0KSOtMsQvjRNB3cvVXM3G9Og31Yo6y1srdjMGjo=;
        b=hc5sU4gi/OQfv89RZY8qcC/bPXSRGml6a2iAHyUHKs1bHm/S+8202C60uXak4YiTlB
         cWjgCx2FhU0oFSq5vIreubgN6boSUqHqOmhaIu2A7Eyt8POGGIKbS0nqaAQB158sz14f
         WVdVfahxSzd/xzqPlaYLzP0Ox8lGh4ph1EZH6Tt6I0XF9ZTNj0poj0V71/+uul95dspM
         aQ5KuHQLW4sK591Dpj06A3FBKgfZdcyYbDQftVzZMuF/vrociZBTK5tcg5DuNVLUdxkW
         +iU2ff6UR9EcqApmyElgbMMPTdede902LeAk93fj1XuXCJsCmRYa4OwQrgvlyn+z1Ueb
         XXVQ==
X-Gm-Message-State: AOJu0YwNK++nI/Ic1odUDNQLw0BuWhs9cZzDjDdAalxcr1KZoZdyW1sR
	BKMw4VRAnN2IZptt+Qdp7JmSJahO+EMr9qNCvIqcnBNCG2bM46VQ6lsU7M263lQ=
X-Google-Smtp-Source: AGHT+IETkPLnXbTlKTsQI0iiuMv8afoVJKnghZY0r8FNDFGuGnyw2O2I/MeSwhipMnMxohWVMoqXDg==
X-Received: by 2002:a05:6a20:a8a2:b0:1c6:ac08:8aeb with SMTP id adf61e73a8af0-1c6ac088d0bmr2583604637.8.1722691375324;
        Sat, 03 Aug 2024 06:22:55 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed2d056sm2736657b3a.204.2024.08.03.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 06:22:54 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [GSoC][PATCH v2] t: port helper/test-oid-array.c to unit-tests/t-oid-array.c
Date: Sat,  3 Aug 2024 18:51:52 +0530
Message-ID: <20240803132206.72166-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240703034638.8019-2-shyamthakkar001@gmail.com>
References: <20240703034638.8019-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

helper/test-oid-array.c along with t0064-oid-array.sh test the
oid-array.h library, which provides storage and processing
efficiency over large lists of object identifiers.

Migrate them to the unit testing framework for better runtime
performance and efficiency. Also 'the_hash_algo' is used internally in
oid_array_lookup(), but we do not initialize a repository directory,
therefore initialize the_hash_algo manually. And
init_hash_algo():lib-oid.c can aid in this process, so make it public.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
Changes in v2:
- removed the use of internal test__run_*() functions.
- TEST_LOOKUP() is entirely changed where it now accepts a lower bound
  and an upper bound for checking return values of oid_array_lookup(),
  instead of passing the condition as a whole literal. (i.e.
   v1: TEST_LOOKUP(..., ret < 0, ...)
   v2: TEST_LOOKUP(..., INT_MIN, -1, ...)
  )
- TEST_ENUMERATION() remains unchanged.

I didn't include the range-diff because the TEST_LOOKUP() has changed
quite a lot, so it would have to be reviewed from the beginning
anyways and I also rebased it on top of latest master since the last
version was sent 2 months ago.

Thanks.

 Makefile                   |   2 +-
 t/helper/test-oid-array.c  |  49 --------------
 t/helper/test-tool.c       |   1 -
 t/helper/test-tool.h       |   1 -
 t/t0064-oid-array.sh       | 122 ----------------------------------
 t/unit-tests/lib-oid.c     |   2 +-
 t/unit-tests/lib-oid.h     |   6 ++
 t/unit-tests/t-oid-array.c | 132 +++++++++++++++++++++++++++++++++++++
 8 files changed, 140 insertions(+), 175 deletions(-)
 delete mode 100644 t/helper/test-oid-array.c
 delete mode 100755 t/t0064-oid-array.sh
 create mode 100644 t/unit-tests/t-oid-array.c

diff --git a/Makefile b/Makefile
index d6479092a0..c6f11dc453 100644
--- a/Makefile
+++ b/Makefile
@@ -808,7 +808,6 @@ TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
-TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
@@ -1336,6 +1335,7 @@ UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-mem-pool
+UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
deleted file mode 100644
index 076b849cbf..0000000000
--- a/t/helper/test-oid-array.c
+++ /dev/null
@@ -1,49 +0,0 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
-#include "test-tool.h"
-#include "hex.h"
-#include "oid-array.h"
-#include "setup.h"
-#include "strbuf.h"
-
-static int print_oid(const struct object_id *oid, void *data UNUSED)
-{
-	puts(oid_to_hex(oid));
-	return 0;
-}
-
-int cmd__oid_array(int argc UNUSED, const char **argv UNUSED)
-{
-	struct oid_array array = OID_ARRAY_INIT;
-	struct strbuf line = STRBUF_INIT;
-	int nongit_ok;
-
-	setup_git_directory_gently(&nongit_ok);
-	if (nongit_ok)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
-
-	while (strbuf_getline(&line, stdin) != EOF) {
-		const char *arg;
-		struct object_id oid;
-
-		if (skip_prefix(line.buf, "append ", &arg)) {
-			if (get_oid_hex(arg, &oid))
-				die("not a hexadecimal oid: %s", arg);
-			oid_array_append(&array, &oid);
-		} else if (skip_prefix(line.buf, "lookup ", &arg)) {
-			if (get_oid_hex(arg, &oid))
-				die("not a hexadecimal oid: %s", arg);
-			printf("%d\n", oid_array_lookup(&array, &oid));
-		} else if (!strcmp(line.buf, "clear"))
-			oid_array_clear(&array);
-		else if (!strcmp(line.buf, "for_each_unique"))
-			oid_array_for_each_unique(&array, print_oid, NULL);
-		else
-			die("unknown command: %s", line.buf);
-	}
-
-	strbuf_release(&line);
-	oid_array_clear(&array);
-
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index da3e69128a..353d2aaaa4 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -43,7 +43,6 @@ static struct test_cmd cmds[] = {
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
-	{ "oid-array", cmd__oid_array },
 	{ "online-cpus", cmd__online_cpus },
 	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 642a34578c..d3d8aa28e0 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -64,7 +64,6 @@ int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sha1_is_sha1dc(int argc, const char **argv);
-int cmd__oid_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__simple_ipc(int argc, const char **argv);
diff --git a/t/t0064-oid-array.sh b/t/t0064-oid-array.sh
deleted file mode 100755
index de74b692d0..0000000000
--- a/t/t0064-oid-array.sh
+++ /dev/null
@@ -1,122 +0,0 @@
-#!/bin/sh
-
-test_description='basic tests for the oid array implementation'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-echoid () {
-	prefix="${1:+$1 }"
-	shift
-	while test $# -gt 0
-	do
-		echo "$prefix$ZERO_OID" | sed -e "s/00/$1/g"
-		shift
-	done
-}
-
-test_expect_success 'without repository' '
-	cat >expect <<-EOF &&
-	4444444444444444444444444444444444444444
-	5555555555555555555555555555555555555555
-	8888888888888888888888888888888888888888
-	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-	EOF
-	cat >input <<-EOF &&
-	append 4444444444444444444444444444444444444444
-	append 5555555555555555555555555555555555555555
-	append 8888888888888888888888888888888888888888
-	append aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-	for_each_unique
-	EOF
-	nongit test-tool oid-array <input >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'ordered enumeration' '
-	echoid "" 44 55 88 aa >expect &&
-	{
-		echoid append 88 44 aa 55 &&
-		echo for_each_unique
-	} | test-tool oid-array >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'ordered enumeration with duplicate suppression' '
-	echoid "" 44 55 88 aa >expect &&
-	{
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echo for_each_unique
-	} | test-tool oid-array >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'lookup' '
-	{
-		echoid append 88 44 aa 55 &&
-		echoid lookup 55
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -eq 1
-'
-
-test_expect_success 'lookup non-existing entry' '
-	{
-		echoid append 88 44 aa 55 &&
-		echoid lookup 33
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -lt 0
-'
-
-test_expect_success 'lookup with duplicates' '
-	{
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echoid lookup 55
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -ge 3 &&
-	test "$n" -le 5
-'
-
-test_expect_success 'lookup non-existing entry with duplicates' '
-	{
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echoid lookup 66
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -lt 0
-'
-
-test_expect_success 'lookup with almost duplicate values' '
-	# n-1 5s
-	root=$(echoid "" 55) &&
-	root=${root%5} &&
-	{
-		id1="${root}5" &&
-		id2="${root}f" &&
-		echo "append $id1" &&
-		echo "append $id2" &&
-		echoid lookup 55
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -eq 0
-'
-
-test_expect_success 'lookup with single duplicate value' '
-	{
-		echoid append 55 55 &&
-		echoid lookup 55
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -ge 0 &&
-	test "$n" -le 1
-'
-
-test_done
diff --git a/t/unit-tests/lib-oid.c b/t/unit-tests/lib-oid.c
index 37105f0a8f..8f0ccac532 100644
--- a/t/unit-tests/lib-oid.c
+++ b/t/unit-tests/lib-oid.c
@@ -3,7 +3,7 @@
 #include "strbuf.h"
 #include "hex.h"
 
-static int init_hash_algo(void)
+int init_hash_algo(void)
 {
 	static int algo = -1;
 
diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
index 8d2acca768..011a2d88de 100644
--- a/t/unit-tests/lib-oid.h
+++ b/t/unit-tests/lib-oid.h
@@ -13,5 +13,11 @@
  * environment variable.
  */
 int get_oid_arbitrary_hex(const char *s, struct object_id *oid);
+/*
+ * Returns one of GIT_HASH_{SHA1, SHA256, UNKNOWN} based on the value of
+ * GIT_TEST_DEFAULT_HASH. The fallback value in case of absence of
+ * GIT_TEST_DEFAULT_HASH is GIT_HASH_SHA1.
+ */
+int init_hash_algo(void);
 
 #endif /* LIB_OID_H */
diff --git a/t/unit-tests/t-oid-array.c b/t/unit-tests/t-oid-array.c
new file mode 100644
index 0000000000..baa7c68d7b
--- /dev/null
+++ b/t/unit-tests/t-oid-array.c
@@ -0,0 +1,132 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-lib.h"
+#include "lib-oid.h"
+#include "oid-array.h"
+#include "hex.h"
+
+static inline size_t test_min(size_t a, size_t b)
+{
+	return a <= b ? a : b;
+}
+
+static int fill_array(struct oid_array *array, const char *hexes[], size_t n)
+{
+	for (size_t i = 0; i < n; i++) {
+		struct object_id oid;
+
+		if (!check_int(get_oid_arbitrary_hex(hexes[i], &oid), ==, 0))
+			return -1;
+		oid_array_append(array, &oid);
+	}
+	if (!check_uint(array->nr, ==, n))
+		return -1;
+	return 0;
+}
+
+static int add_to_oid_array(const struct object_id *oid, void *data)
+{
+	struct oid_array *array = data;
+
+	oid_array_append(array, oid);
+	return 0;
+}
+
+static void t_enumeration(const char **input_args, size_t input_sz,
+			  const char **result, size_t result_sz)
+{
+	struct oid_array input = OID_ARRAY_INIT, expect = OID_ARRAY_INIT,
+			 actual = OID_ARRAY_INIT;
+	size_t i;
+
+	if (fill_array(&input, input_args, input_sz))
+		return;
+	if (fill_array(&expect, result, result_sz))
+		return;
+
+	oid_array_for_each_unique(&input, add_to_oid_array, &actual);
+	check_uint(actual.nr, ==, expect.nr);
+
+	for (i = 0; i < test_min(actual.nr, expect.nr); i++) {
+		if (!check(oideq(&actual.oid[i], &expect.oid[i])))
+			test_msg("expected: %s\n       got: %s\n     index: %" PRIuMAX,
+				 oid_to_hex(&expect.oid[i]), oid_to_hex(&actual.oid[i]),
+				 (uintmax_t)i);
+	}
+	check_uint(i, ==, result_sz);
+
+	oid_array_clear(&actual);
+	oid_array_clear(&input);
+	oid_array_clear(&expect);
+}
+
+#define TEST_ENUMERATION(input, result, desc)                                     \
+	TEST(t_enumeration(input, ARRAY_SIZE(input), result, ARRAY_SIZE(result)), \
+			   desc " works")
+
+static void t_lookup(const char **input_hexes, size_t n, const char *query_hex,
+		     int lower_bound, int upper_bound)
+{
+	struct oid_array array = OID_ARRAY_INIT;
+	struct object_id oid_query;
+	int ret;
+
+	if (get_oid_arbitrary_hex(query_hex, &oid_query))
+		return;
+	if (fill_array(&array, input_hexes, n))
+		return;
+	ret = oid_array_lookup(&array, &oid_query);
+
+	if (!check_int(ret, <=, upper_bound) ||
+	    !check_int(ret, >=, lower_bound))
+		test_msg("oid query for lookup: %s", oid_to_hex(&oid_query));
+
+	oid_array_clear(&array);
+}
+
+#define TEST_LOOKUP(input_hexes, query, lower_bound, upper_bound, desc) \
+	TEST(t_lookup(input_hexes, ARRAY_SIZE(input_hexes), query,      \
+		      lower_bound, upper_bound),                        \
+	     desc " works")
+
+static void setup(void)
+{
+	int algo = init_hash_algo();
+	/* because the_hash_algo is used by oid_array_lookup() internally */
+	if (check_int(algo, !=, GIT_HASH_UNKNOWN))
+		repo_set_hash_algo(the_repository, algo);
+}
+
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
+{
+	const char *arr_input[] = { "88", "44", "aa", "55" };
+	const char *arr_input_dup[] = { "88", "44", "aa", "55",
+					"88", "44", "aa", "55",
+					"88", "44", "aa", "55" };
+	const char *res_sorted[] = { "44", "55", "88", "aa" };
+	const char *nearly_55;
+
+	if (!TEST(setup(), "setup"))
+		test_skip_all("hash algo initialization failed");
+
+	TEST_ENUMERATION(arr_input, res_sorted, "ordered enumeration");
+	TEST_ENUMERATION(arr_input_dup, res_sorted,
+			 "ordered enumeration with duplicate suppression");
+
+	/* ret is the return value of oid_array_lookup() */
+	TEST_LOOKUP(arr_input, "55", 1, 1, "lookup");
+	TEST_LOOKUP(arr_input, "33", INT_MIN, -1, "lookup non-existent entry");
+	TEST_LOOKUP(arr_input_dup, "55", 3, 5, "lookup with duplicates");
+	TEST_LOOKUP(arr_input_dup, "66", INT_MIN, -1,
+		    "lookup non-existent entry with duplicates");
+
+	nearly_55 = init_hash_algo() == GIT_HASH_SHA1 ?
+			"5500000000000000000000000000000000000001" :
+			"5500000000000000000000000000000000000000000000000000000000000001";
+	TEST_LOOKUP(((const char *[]){ "55", nearly_55 }), "55", 0, 0,
+		    "lookup with almost duplicate values");
+	TEST_LOOKUP(((const char *[]){ "55", "55" }), "55", 0, 1,
+		    "lookup with single duplicate value");
+
+	return test_done();
+}
-- 
2.46.0

