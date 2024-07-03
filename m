Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC71799F
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 03:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978512; cv=none; b=RagHyxT+Oxee7WdupcZ9H27aNmELw1PX4RB2NRYoeEtwUYgRV32nYvL0mHA1nQt3vufEb/h54c2Xoqpyv0q8uWO/9ILTLRo28TEA+qomr+9lbZ44sO0wWM8zfUhFYhSWnq09mE6Kw7FoCpwIGUMSamwj10wBSmcB9MRI9GDKb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978512; c=relaxed/simple;
	bh=1/ZHjEHjq1uZKSSmhurKbDbeY3023IOpxS4hpbdlZHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYrWQdTLukY9knAz0+aTm/1hgOsQ2oK7aZ7lRGJBZ+dSCcTFzS8q9DPOYrkOhDHtKHbc2AUfQ+NeBsMXKT5SfneyYPDQL2E7efUxU3d342vZAKzBz8GN+x2BL7yxVVli/KygGstTt3gQBRSu/3HBF8gdDySHTuZVilrfRbczJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrLrIDLi; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrLrIDLi"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-382458be739so622885ab.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 20:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719978509; x=1720583309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sjS0lECFRmJLdtCOdNAmv58WdH4XlUfPWeepUQEnW6c=;
        b=WrLrIDLihGMW7EAUUBc2DUe70GR+iPi4CqqmYBiz9xsug0aRqhtioPwnVh91z2FrCH
         KCLXwwoFEvOFTILxtF7fWJgGA23tjx/4S4gjX+dbtLTgIrMmhyrlKV8MLHegTevreR60
         3ZtzPLEe18rGfeTH6a9Xg3H9tjHbkZwWIWRKHWjG+OWdrW1lrNIrMBfRMGV29CDYLemE
         qMZcgXXbMsUcPUujsj9SNHIfxYOleUEPlPkEZzAKSoqNVlhcfoRJQthMnD6zMei0cppy
         COK1GTA8OaAThHaSj3KKrrQKmP4E3P9BR0Y2isvADTEZCzByZp/tn9v1sCbJ5d8hI53C
         UqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719978509; x=1720583309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjS0lECFRmJLdtCOdNAmv58WdH4XlUfPWeepUQEnW6c=;
        b=Ql0LuClUjEfjZFb+vKvS7zUKLWQCB1h68D+AlQFeR2hqwGeny0uLMW8+CiTq19JmKp
         ttb6jQ1VI+9tbDLqT66HlrrSWzG9EUPgmX+aUgPZ9UbdrXQE/hHnjYlr71uTkCJzhoPO
         JlIvUE20BU+Dz4RUrDstJi+vp4k9LXG5RdGctPFt+qyQKHidjtYNy8g33jVAY9RAngJr
         5DOj/an6n5JNrbAsgoaRiCq/mznK/Aw8ViaHX6zM0yc20o13lVoRx69J2bZR5xnsh/cL
         sLrJbWVb6uwrPBY5H74e/LWIVWgjuFskmds/g8IbppssTUHww00fReJH/WrRIzyF/whm
         hZdQ==
X-Gm-Message-State: AOJu0Yx4eY7axDlbtJ+uQDOz/LyxpqX12QUigsrTsxkrTjjJiBrbenxm
	PBbAtyD4ngJdCnOQTSGtwEtdG4SO7yU8URR8eg7iOyuYw8b9yqWMO9M1Ipd3
X-Google-Smtp-Source: AGHT+IEXjVQ/RYFk7O0u8hZnyCUQ8KaiDddQUCrkQpMiU3Xj2NUCVtmbN+TCbAwp8WmxxQFw6lm5bQ==
X-Received: by 2002:a05:6e02:20c5:b0:381:5590:756f with SMTP id e9e14a558f8ab-38155907694mr27771635ab.23.1719978508985;
        Tue, 02 Jul 2024 20:48:28 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080498a00bsm9314529b3a.201.2024.07.02.20.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 20:48:28 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC][PATCH] t: port helper/test-oid-array.c to unit-tests/t-oid-array.c
Date: Wed,  3 Jul 2024 09:16:33 +0530
Message-ID: <20240703034638.8019-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.2
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
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
Note: Once 'rs/unit-tests-test-run' is merged to atleast next, I plan to
replace these internal function used in TEST_LOOKUP() with TEST_RUN().

 Makefile                   |   2 +-
 t/helper/test-oid-array.c  |  49 -------------
 t/helper/test-tool.c       |   1 -
 t/helper/test-tool.h       |   1 -
 t/t0064-oid-array.sh       | 122 --------------------------------
 t/unit-tests/lib-oid.c     |   2 +-
 t/unit-tests/lib-oid.h     |   6 ++
 t/unit-tests/t-oid-array.c | 138 +++++++++++++++++++++++++++++++++++++
 8 files changed, 146 insertions(+), 175 deletions(-)
 delete mode 100644 t/helper/test-oid-array.c
 delete mode 100755 t/t0064-oid-array.sh
 create mode 100644 t/unit-tests/t-oid-array.c

diff --git a/Makefile b/Makefile
index 3eab701b10..26a521c027 100644
--- a/Makefile
+++ b/Makefile
@@ -808,7 +808,6 @@ TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
-TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
@@ -1337,6 +1336,7 @@ UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-mem-pool
+UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
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
index 93436a82ae..fdbf755fb0 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -43,7 +43,6 @@ static struct test_cmd cmds[] = {
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
-	{ "oid-array", cmd__oid_array },
 	{ "oidmap", cmd__oidmap },
 	{ "online-cpus", cmd__online_cpus },
 	{ "pack-mtimes", cmd__pack_mtimes },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index d9033d14e1..0d9b9f6583 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -65,7 +65,6 @@ int cmd__scrap_cache_tree(int argc, const char **argv);
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
index 0000000000..0a506fab07
--- /dev/null
+++ b/t/unit-tests/t-oid-array.c
@@ -0,0 +1,138 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-lib.h"
+#include "lib-oid.h"
+#include "oid-array.h"
+#include "hex.h"
+
+static inline int test_min(int a, int b)
+{
+	return a <= b ? a : b;
+}
+
+static int fill_array(struct oid_array *array, const char *hexes[], size_t n)
+{
+	for (size_t i = 0; i < n; i++) {
+		struct object_id oid;
+
+		if (get_oid_arbitrary_hex(hexes[i], &oid))
+			return -1;
+		oid_array_append(array, &oid);
+	}
+	if (!check_int(array->nr, ==, n))
+		return -1;
+	return 0;
+}
+
+static int add_to_oid_array(const struct object_id *oid, void *data)
+{
+	struct oid_array *array = data;
+	oid_array_append(array, oid);
+	return 0;
+}
+
+static void t_enumeration(const char *input_args[], size_t input_sz,
+			  const char *result[], size_t result_sz)
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
+	check_int(actual.nr, ==, expect.nr);
+
+	for (i = 0; i < test_min(actual.nr, expect.nr); i++) {
+		if (!check(oideq(&actual.oid[i], &expect.oid[i])))
+			test_msg("expected: %s\n       got: %s\n     index: %" PRIuMAX,
+				 oid_to_hex(&expect.oid[i]), oid_to_hex(&actual.oid[i]),
+				 (uintmax_t)i);
+	}
+	check_int(i, ==, result_sz);
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
+static int t_lookup(struct object_id *oid_query, const char *query,
+		    const char *hexes[], size_t n)
+{
+	struct oid_array array = OID_ARRAY_INIT;
+	int ret;
+
+	if (get_oid_arbitrary_hex(query, oid_query))
+		return INT_MIN;
+	if (fill_array(&array, hexes, n))
+		return INT_MIN;
+	ret = oid_array_lookup(&array, oid_query);
+
+	oid_array_clear(&array);
+	return ret;
+}
+
+#define TEST_LOOKUP(input_args, query, condition, desc)                   \
+	do {                                                              \
+		int skip = test__run_begin();                             \
+		if (!skip) {                                              \
+			struct object_id oid_query;                       \
+			int ret = t_lookup(&oid_query, query, input_args, \
+					   ARRAY_SIZE(input_args));       \
+                                                                          \
+			if (ret != INT_MIN && !check(condition))          \
+				test_msg("oid query for lookup: %s",      \
+					 oid_to_hex(&oid_query));         \
+		}                                                         \
+		test__run_end(!skip, TEST_LOCATION(), desc " works");     \
+	} while (0)
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
+
+	if (!TEST(setup(), "setup"))
+		test_skip_all("hash algo initialization failed");
+
+	TEST_ENUMERATION(arr_input, res_sorted, "ordered enumeration");
+	TEST_ENUMERATION(arr_input_dup, res_sorted,
+			 "ordered enumeration with duplicate suppression");
+
+	/* ret is the return value of oid_array_lookup() */
+	TEST_LOOKUP(arr_input, "55", ret == 1, "lookup");
+	TEST_LOOKUP(arr_input, "33", ret < 0, "lookup non-existent entry");
+	TEST_LOOKUP(arr_input_dup, "55", ret >= 3 && ret <= 5,
+		    "lookup with duplicates");
+	TEST_LOOKUP(arr_input_dup, "66", ret < 0,
+		    "lookup non-existent entry with duplicates");
+
+	TEST_LOOKUP(((const char *[]){
+		    "55",
+		    init_hash_algo() == GIT_HASH_SHA1 ?
+				"5500000000000000000000000000000000000001" :
+				"5500000000000000000000000000000000000000000000000000000000000001" }),
+		    "55", ret == 0, "lookup with almost duplicate values");
+	TEST_LOOKUP(((const char *[]){ "55", "55" }), "55",
+		    ret >= 0 && ret <= 1, "lookup with single duplicate value");
+
+	return test_done();
+}
-- 
2.45.2

