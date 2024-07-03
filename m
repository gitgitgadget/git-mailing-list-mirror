Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034A1DA336
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988280; cv=none; b=OrVfhc7JZrx1dKTLdmwrPfWC8ps8c47d1HxrMecV7WYklEA9ObXROgguBZw2h0dKWTztb6r7PXb7v1QhtFJDtjtMl1CiRjfMLC8Rp5R1e0miNZ7T+L7t5Yrrl3Mu3D9IKLLaXX0bETRkGA7y1zatK1ypjOiQZ7w4OaWIjnr3w70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988280; c=relaxed/simple;
	bh=9BY2OvOIfXeVNoH6EbMMJJ2iUJkG2YZf61X23m5eegQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMDC9exHf16p5Vyh/h1cOmNqIXXb2Uxzw5cr6GUOsd+2R6k3LidkouYTw4Z+cHxdOYIUFcNaIISUfj0b6Pd466gYaNpA3BKkbuPZsTVc2AxVrZM+uvY6IEEYfxjZrZUq2vcpwC6uSQkRg7Z0uPGRVbPlV1UQifApuATGtLAz8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCcCP5IS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCcCP5IS"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7163489149eso3321797a12.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 23:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719988277; x=1720593077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnLkj3jhTnve9cpAac7o41L78/mMhDKQrfVtmet4ocE=;
        b=UCcCP5ISPbFTIzfoiYWcXYAPhXZdLerlf6oWg3BoIj2XlkisdavF2wt2+9Nxu33u9R
         wHOSmeED32bP3Oxcq24fkN28vT0sv7+mpbIpTd/j7Gc5eeiw7Nhq/+MgIFFZ6CC9qfvT
         nI8e1/j9fIIzelUb5JjxYLcsq0Fl/Xjz5mL81wAeL8aK3TI8LuUYSms0sA/sLdEu26cd
         lZW9PDaxrddTwoE4Wl9EQqeqxD3FK6iDMMPxig3QICzSMCD9rV1OszLspzGS4srEVa3r
         7XjZeh7LDzcTACArXYpRs0qiznpteLsSRurnS3FrU9zMz3mtljcQTM8oe8vpNdxkJ1uz
         Uglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719988277; x=1720593077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnLkj3jhTnve9cpAac7o41L78/mMhDKQrfVtmet4ocE=;
        b=lx9/yNmpV6nGUscxx1Cfxbditi4Bni8QdcBhQl/dszj7UQchEZRl/IEBbh2yN4Jd7f
         7Yh4v0zhSEclProD/mC8roJvbaAdBW5xAt5E0zJqgXtoEwH3o1UWUAN2/QWIVWPVZFsX
         Ed//TIy4IyvbhC/mGCCY6+zjqgyyJPXrADTyDRhePxKzWO6Ss8CIpvf2F9sZm+8jUKhQ
         favxWVEynQ+bWI9vK4fNKcRj5eOShNUWGQQ0mMSejQHD7nT1zWBdzu6OebUgSDDBfqzB
         7gwgIUi6dN/CS2JqFqWatGFNI7nv5l24kT3luiDXaKxh9WzFjM8MRP7BaT+2iiscqXRB
         FToQ==
X-Gm-Message-State: AOJu0YwWsPs5sjSYWhOgVNLh1XcdI38EXvqLba28IsVo1pOuPdQ/FxAR
	hBbGcXYCz5Xvoi96fuVy9E1rXGrmAB3tTAuKWEEcHmrLFVCn1KQLwsGg/Vng
X-Google-Smtp-Source: AGHT+IHn7OsjCRNDdjB7K1QdnMfuVoMAmDdlvEfTQbL0DZjC9spYveRTyf7SptLH836Miv7m1zWp6A==
X-Received: by 2002:a17:90a:8a82:b0:2c9:754d:2cba with SMTP id 98e67ed59e1d1-2c9754d2d7emr953592a91.3.1719988276908;
        Tue, 02 Jul 2024 23:31:16 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3b9c1dsm9886702a91.45.2024.07.02.23.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 23:31:16 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC][PATCH v3] t: migrate helper/test-oidmap.c to unit-tests/t-oidmap.c
Date: Wed,  3 Jul 2024 11:59:53 +0530
Message-ID: <20240703062958.23262-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
library which is built on top of hashmap.h.

Migrate them to the unit testing framework for better performance,
concise code and better debugging. Along with the migration also plug
memory leaks and make the test logic independent for all the tests.
The migration removes 'put' tests from t0016, because it is used as
setup to all the other tests, so testing it separately does not yield
any benefit.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Reviewed-by: Josh Steadmon <steadmon@google.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
Changes in v3:
- use 'count' to check if we iterated over all the entries (Phillip's
  suggestion)
- use 'seen' array instead of modifying the global array (Junio's
  review)

Range-diff against v2:
1:  cc0c4c3b0a ! 1:  bdb3c8ebe4 t: migrate helper/test-oidmap.c to unit-tests/t-oidmap.c
    @@ Commit message
         setup to all the other tests, so testing it separately does not yield
         any benefit.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    @@ t/unit-tests/t-oidmap.c (new)
     +	char name[FLEX_ARRAY];
     +};
     +
    -+static const char *key_val[][2] = { { "11", "one" },
    -+				    { "22", "two" },
    -+				    { "33", "three" } };
    ++static const char *const key_val[][2] = { { "11", "one" },
    ++					  { "22", "two" },
    ++					  { "33", "three" } };
     +
     +static void setup(void (*f)(struct oidmap *map))
     +{
    @@ t/unit-tests/t-oidmap.c (new)
     +	check(oidmap_remove(map, &oid) == NULL);
     +}
     +
    -+static int key_val_contains(struct test_entry *entry)
    ++static int key_val_contains(struct test_entry *entry, char seen[])
     +{
     +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
     +		struct object_id oid;
    @@ t/unit-tests/t-oidmap.c (new)
     +			return -1;
     +
     +		if (oideq(&entry->entry.oid, &oid)) {
    -+			if (!strcmp(key_val[i][1], "USED"))
    ++			if (seen[i])
     +				return 2;
    -+			key_val[i][1] = "USED";
    ++			seen[i] = 1;
     +			return 0;
     +		}
     +	}
    @@ t/unit-tests/t-oidmap.c (new)
     +{
     +	struct oidmap_iter iter;
     +	struct test_entry *entry;
    ++	char seen[ARRAY_SIZE(key_val)] = { 0 };
    ++	int count = 0;
     +
     +	oidmap_iter_init(map, &iter);
     +	while ((entry = oidmap_iter_next(&iter))) {
     +		int ret;
    -+		if (!check_int((ret = key_val_contains(entry)), ==, 0)) {
    ++		if (!check_int((ret = key_val_contains(entry, seen)), ==, 0)) {
     +			switch (ret) {
     +			case -1:
     +				break; /* error message handled by get_oid_arbitrary_hex() */
    @@ t/unit-tests/t-oidmap.c (new)
     +					 ret);
     +				break;
     +			}
    ++		} else {
    ++			count++;
     +		}
     +	}
    ++	check_int(count, ==, ARRAY_SIZE(key_val));
     +	check_int(hashmap_get_size(&map->map), ==, ARRAY_SIZE(key_val));
     +}
     +

 Makefile                |   2 +-
 t/helper/test-oidmap.c  | 123 ---------------------------
 t/helper/test-tool.c    |   1 -
 t/helper/test-tool.h    |   1 -
 t/t0016-oidmap.sh       | 112 -------------------------
 t/unit-tests/t-oidmap.c | 181 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 182 insertions(+), 238 deletions(-)
 delete mode 100644 t/helper/test-oidmap.c
 delete mode 100755 t/t0016-oidmap.sh
 create mode 100644 t/unit-tests/t-oidmap.c

diff --git a/Makefile b/Makefile
index 3eab701b10..2a5c70d218 100644
--- a/Makefile
+++ b/Makefile
@@ -809,7 +809,6 @@ TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-oid-array.o
-TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
@@ -1337,6 +1336,7 @@ UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-mem-pool
+UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
deleted file mode 100644
index bd30244a54..0000000000
--- a/t/helper/test-oidmap.c
+++ /dev/null
@@ -1,123 +0,0 @@
-#include "test-tool.h"
-#include "hex.h"
-#include "object-name.h"
-#include "oidmap.h"
-#include "repository.h"
-#include "setup.h"
-#include "strbuf.h"
-#include "string-list.h"
-
-/* key is an oid and value is a name (could be a refname for example) */
-struct test_entry {
-	struct oidmap_entry entry;
-	char name[FLEX_ARRAY];
-};
-
-#define DELIM " \t\r\n"
-
-/*
- * Read stdin line by line and print result of commands to stdout:
- *
- * hash oidkey -> sha1hash(oidkey)
- * put oidkey namevalue -> NULL / old namevalue
- * get oidkey -> NULL / namevalue
- * remove oidkey -> NULL / old namevalue
- * iterate -> oidkey1 namevalue1\noidkey2 namevalue2\n...
- *
- */
-int cmd__oidmap(int argc UNUSED, const char **argv UNUSED)
-{
-	struct string_list parts = STRING_LIST_INIT_NODUP;
-	struct strbuf line = STRBUF_INIT;
-	struct oidmap map = OIDMAP_INIT;
-
-	setup_git_directory();
-
-	/* init oidmap */
-	oidmap_init(&map, 0);
-
-	/* process commands from stdin */
-	while (strbuf_getline(&line, stdin) != EOF) {
-		char *cmd, *p1, *p2;
-		struct test_entry *entry;
-		struct object_id oid;
-
-		/* break line into command and up to two parameters */
-		string_list_setlen(&parts, 0);
-		string_list_split_in_place(&parts, line.buf, DELIM, 2);
-		string_list_remove_empty_items(&parts, 0);
-
-		/* ignore empty lines */
-		if (!parts.nr)
-			continue;
-		if (!*parts.items[0].string || *parts.items[0].string == '#')
-			continue;
-
-		cmd = parts.items[0].string;
-		p1 = parts.nr >= 1 ? parts.items[1].string : NULL;
-		p2 = parts.nr >= 2 ? parts.items[2].string : NULL;
-
-		if (!strcmp("put", cmd) && p1 && p2) {
-
-			if (repo_get_oid(the_repository, p1, &oid)) {
-				printf("Unknown oid: %s\n", p1);
-				continue;
-			}
-
-			/* create entry with oid_key = p1, name_value = p2 */
-			FLEX_ALLOC_STR(entry, name, p2);
-			oidcpy(&entry->entry.oid, &oid);
-
-			/* add / replace entry */
-			entry = oidmap_put(&map, entry);
-
-			/* print and free replaced entry, if any */
-			puts(entry ? entry->name : "NULL");
-			free(entry);
-
-		} else if (!strcmp("get", cmd) && p1) {
-
-			if (repo_get_oid(the_repository, p1, &oid)) {
-				printf("Unknown oid: %s\n", p1);
-				continue;
-			}
-
-			/* lookup entry in oidmap */
-			entry = oidmap_get(&map, &oid);
-
-			/* print result */
-			puts(entry ? entry->name : "NULL");
-
-		} else if (!strcmp("remove", cmd) && p1) {
-
-			if (repo_get_oid(the_repository, p1, &oid)) {
-				printf("Unknown oid: %s\n", p1);
-				continue;
-			}
-
-			/* remove entry from oidmap */
-			entry = oidmap_remove(&map, &oid);
-
-			/* print result and free entry*/
-			puts(entry ? entry->name : "NULL");
-			free(entry);
-
-		} else if (!strcmp("iterate", cmd)) {
-
-			struct oidmap_iter iter;
-			oidmap_iter_init(&map, &iter);
-			while ((entry = oidmap_iter_next(&iter)))
-				printf("%s %s\n", oid_to_hex(&entry->entry.oid), entry->name);
-
-		} else {
-
-			printf("Unknown command %s\n", cmd);
-
-		}
-	}
-
-	string_list_clear(&parts, 0);
-	strbuf_release(&line);
-	oidmap_free(&map, 1);
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 93436a82ae..da3e69128a 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -44,7 +44,6 @@ static struct test_cmd cmds[] = {
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
 	{ "oid-array", cmd__oid_array },
-	{ "oidmap", cmd__oidmap },
 	{ "online-cpus", cmd__online_cpus },
 	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index d9033d14e1..642a34578c 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -37,7 +37,6 @@ int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
-int cmd__oidmap(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
deleted file mode 100755
index 0faef1f4f1..0000000000
--- a/t/t0016-oidmap.sh
+++ /dev/null
@@ -1,112 +0,0 @@
-#!/bin/sh
-
-test_description='test oidmap'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-# This purposefully is very similar to t0011-hashmap.sh
-
-test_oidmap () {
-	echo "$1" | test-tool oidmap $3 >actual &&
-	echo "$2" >expect &&
-	test_cmp expect actual
-}
-
-
-test_expect_success 'setup' '
-
-	test_commit one &&
-	test_commit two &&
-	test_commit three &&
-	test_commit four
-
-'
-
-test_expect_success 'put' '
-
-test_oidmap "put one 1
-put two 2
-put invalidOid 4
-put three 3" "NULL
-NULL
-Unknown oid: invalidOid
-NULL"
-
-'
-
-test_expect_success 'replace' '
-
-test_oidmap "put one 1
-put two 2
-put three 3
-put invalidOid 4
-put two deux
-put one un" "NULL
-NULL
-NULL
-Unknown oid: invalidOid
-2
-1"
-
-'
-
-test_expect_success 'get' '
-
-test_oidmap "put one 1
-put two 2
-put three 3
-get two
-get four
-get invalidOid
-get one" "NULL
-NULL
-NULL
-2
-NULL
-Unknown oid: invalidOid
-1"
-
-'
-
-test_expect_success 'remove' '
-
-test_oidmap "put one 1
-put two 2
-put three 3
-remove one
-remove two
-remove invalidOid
-remove four" "NULL
-NULL
-NULL
-1
-2
-Unknown oid: invalidOid
-NULL"
-
-'
-
-test_expect_success 'iterate' '
-	test-tool oidmap >actual.raw <<-\EOF &&
-	put one 1
-	put two 2
-	put three 3
-	iterate
-	EOF
-
-	# sort "expect" too so we do not rely on the order of particular oids
-	sort >expect <<-EOF &&
-	NULL
-	NULL
-	NULL
-	$(git rev-parse one) 1
-	$(git rev-parse two) 2
-	$(git rev-parse three) 3
-	EOF
-
-	sort <actual.raw >actual &&
-	test_cmp expect actual
-'
-
-test_done
diff --git a/t/unit-tests/t-oidmap.c b/t/unit-tests/t-oidmap.c
new file mode 100644
index 0000000000..b22e52d08b
--- /dev/null
+++ b/t/unit-tests/t-oidmap.c
@@ -0,0 +1,181 @@
+#include "test-lib.h"
+#include "lib-oid.h"
+#include "oidmap.h"
+#include "hash.h"
+#include "hex.h"
+
+/*
+ * Elements we will put in oidmap structs are made of a key: the entry.oid
+ * field, which is of type struct object_id, and a value: the name field (could
+ * be a refname for example).
+ */
+struct test_entry {
+	struct oidmap_entry entry;
+	char name[FLEX_ARRAY];
+};
+
+static const char *const key_val[][2] = { { "11", "one" },
+					  { "22", "two" },
+					  { "33", "three" } };
+
+static void setup(void (*f)(struct oidmap *map))
+{
+	struct oidmap map = OIDMAP_INIT;
+	int ret = 0;
+
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++){
+		struct test_entry *entry;
+
+		FLEX_ALLOC_STR(entry, name, key_val[i][1]);
+		if ((ret = get_oid_arbitrary_hex(key_val[i][0], &entry->entry.oid))) {
+			free(entry);
+			break;
+		}
+		entry = oidmap_put(&map, entry);
+		if (!check(entry == NULL))
+			free(entry);
+	}
+
+	if (!ret)
+		f(&map);
+	oidmap_free(&map, 1);
+}
+
+static void t_replace(struct oidmap *map)
+{
+	struct test_entry *entry, *prev;
+
+	FLEX_ALLOC_STR(entry, name, "un");
+	if (get_oid_arbitrary_hex("11", &entry->entry.oid))
+		return;
+	prev = oidmap_put(map, entry);
+	if (!check(prev != NULL))
+		return;
+	check_str(prev->name, "one");
+	free(prev);
+
+	FLEX_ALLOC_STR(entry, name, "deux");
+	if (get_oid_arbitrary_hex("22", &entry->entry.oid))
+		return;
+	prev = oidmap_put(map, entry);
+	if (!check(prev != NULL))
+		return;
+	check_str(prev->name, "two");
+	free(prev);
+}
+
+static void t_get(struct oidmap *map)
+{
+	struct test_entry *entry;
+	struct object_id oid;
+
+	if (get_oid_arbitrary_hex("22", &oid))
+		return;
+	entry = oidmap_get(map, &oid);
+	if (!check(entry != NULL))
+		return;
+	check_str(entry->name, "two");
+
+	if (get_oid_arbitrary_hex("44", &oid))
+		return;
+	check(oidmap_get(map, &oid) == NULL);
+
+	if (get_oid_arbitrary_hex("11", &oid))
+		return;
+	entry = oidmap_get(map, &oid);
+	if (!check(entry != NULL))
+		return;
+	check_str(entry->name, "one");
+}
+
+static void t_remove(struct oidmap *map)
+{
+	struct test_entry *entry;
+	struct object_id oid;
+
+	if (get_oid_arbitrary_hex("11", &oid))
+		return;
+	entry = oidmap_remove(map, &oid);
+	if (!check(entry != NULL))
+		return;
+	check_str(entry->name, "one");
+	check(oidmap_get(map, &oid) == NULL);
+	free(entry);
+
+	if (get_oid_arbitrary_hex("22", &oid))
+		return;
+	entry = oidmap_remove(map, &oid);
+	if (!check(entry != NULL))
+		return;
+	check_str(entry->name, "two");
+	check(oidmap_get(map, &oid) == NULL);
+	free(entry);
+
+	if (get_oid_arbitrary_hex("44", &oid))
+		return;
+	check(oidmap_remove(map, &oid) == NULL);
+}
+
+static int key_val_contains(struct test_entry *entry, char seen[])
+{
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
+		struct object_id oid;
+
+		if (get_oid_arbitrary_hex(key_val[i][0], &oid))
+			return -1;
+
+		if (oideq(&entry->entry.oid, &oid)) {
+			if (seen[i])
+				return 2;
+			seen[i] = 1;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static void t_iterate(struct oidmap *map)
+{
+	struct oidmap_iter iter;
+	struct test_entry *entry;
+	char seen[ARRAY_SIZE(key_val)] = { 0 };
+	int count = 0;
+
+	oidmap_iter_init(map, &iter);
+	while ((entry = oidmap_iter_next(&iter))) {
+		int ret;
+		if (!check_int((ret = key_val_contains(entry, seen)), ==, 0)) {
+			switch (ret) {
+			case -1:
+				break; /* error message handled by get_oid_arbitrary_hex() */
+			case 1:
+				test_msg("obtained entry was not given in the input\n"
+					 "  name: %s\n   oid: %s\n",
+					 entry->name, oid_to_hex(&entry->entry.oid));
+				break;
+			case 2:
+				test_msg("duplicate entry detected\n"
+					 "  name: %s\n   oid: %s\n",
+					 entry->name, oid_to_hex(&entry->entry.oid));
+				break;
+			default:
+				test_msg("BUG: invalid return value (%d) from key_val_contains()",
+					 ret);
+				break;
+			}
+		} else {
+			count++;
+		}
+	}
+	check_int(count, ==, ARRAY_SIZE(key_val));
+	check_int(hashmap_get_size(&map->map), ==, ARRAY_SIZE(key_val));
+}
+
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
+{
+	TEST(setup(t_replace), "replace works");
+	TEST(setup(t_get), "get works");
+	TEST(setup(t_remove), "remove works");
+	TEST(setup(t_iterate), "iterate works");
+	return test_done();
+}
-- 
2.45.2

