Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9C1EB19A
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040220; cv=none; b=eRR/FJLoyZyi7Us5jRbHvrJ88mrmT3kueXcXSp6EHw0J9v3cfafwCh52JUkV8DxZqO51eg/ciVydujdXYv+QWpNQDzY9qoSF1+I+nLy41OxfLQEvYDIuegvKqxGiIfcSeYltb+XAP/a1DN575fsmo4hfeiSTmbfqpN7jkD0sdFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040220; c=relaxed/simple;
	bh=3Jq2RZvMnDlzpfaMH1TSZOQiU4+wNouwJS4B/hytduQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwob/heittn8pTKFvtbKyRYNm93btF18xa0qe09sUjCFSh/fTCkHQngs6ur55bkv3eX7v+Wcef3W1IFmM7G0Ju7BxTPRZ9KFKuKYbOcmBmuDAoFBYW6gbGlqis7JaJrUDPxAkv8fNxG/GF0IXUsO+7bs+/b4GSPuINKmKmqVYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt+L2gYW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt+L2gYW"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so138504966b.3
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 00:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740040217; x=1740645017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0saPmNXMvuBHkwP86QbxEMbqf8OPcq/bqWcgcbYAWc=;
        b=gt+L2gYWC7HKtTjNJiGNAbHLVUp2c/Tih0IpERUGOpMV6B62JElWA4LBfNPO6HdnyB
         QZ2K8d6/2l+3iV968vjXlc45b10cnsqUGigecDaw8dlP88GH4l1/x1l3+HNHluDdiipC
         +JxbI3D0bFiyrKErf7PtrFmpy6MLCS0LUPVeZY7Z0PCSNTvr4GV6BNgfkHIXFg1G/uJ5
         G+LnnQdc1Pd6rhOHcDrBBeu0LXrKLg9KQDNrhm9m6w0qX15K73QQDq3AbStRgjlVrJcO
         Q9UyGSmTHiTlNLHXU9ERyPgkvmWdQzDJi8aywUrAhwuhwkfVPYsaaIYLP9DdRdNv6uaO
         ElZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040217; x=1740645017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0saPmNXMvuBHkwP86QbxEMbqf8OPcq/bqWcgcbYAWc=;
        b=Rm7UjeQSXziO3UolpN3Bsw6F51hiG+6Bdf4rj5l24BWq4VuaeQiPmwyPDc+cse09nM
         BTT5D4niQgCnU2KRx5vdEblbAj640/k1XVDp6UheoKynipdMpjiE/LCLdwV6Fb8ut0o2
         xxgtwMFBU0FS3744+HahxN0YsWtCeCRTXY0xCANzQmTq9dqTyn04goxVxD/i6EhzN8jk
         6vBP9vw9kaIiTrnep+jAhemnFZ4U60cyFuP5U2W26ZiHnvmmAT1qBtHpIQNanT2/WpNV
         rFe2IywEEQELqO3ITjeE+HAW/hshxYsW1lGZ8l8HNdpZN7dghGKVukhQ+si6naa+dUe3
         ZeFg==
X-Gm-Message-State: AOJu0YwvoeblWG4VAOtCqX4Born+HPng8zPA5iU8XozaLPe/iKCCj/WL
	1puCPwoUCFX/ovSw2zx5WXLZljW6SXWpeolgPZU1ixfvtlROPVFBX4kiyfxnuWtlYA==
X-Gm-Gg: ASbGnctzv7wye/L2hEh67zYCHpx0hT52d090+5N/Nnio6X8VjpiCoFUk8COy3v7Lpmg
	rkSyrSHHFRp+oT4mlSAVA8aM7TM6ORC0k7vlZZEdoN75MRJRqp2BkHctosmIMSiM5oXY3KjzxqW
	dYvShuPTEXC1JWN1BslNzxmi0ItjwAAb7MYL/sYDgIn0rwKywVfr3A3ScZe5u+ItaEcsl0gdkbb
	B/u9dyXsLsRsdzlxSZdq0hG2XCBHH2EBP9PrBKGaLHUnM5/07FxHWh0rPzuRURA7lDfu6HIl3MY
	NcWxJmdFLxoOtC8IYbyiYVqIUdI=
X-Google-Smtp-Source: AGHT+IGUqIt7zxfZ0eGTL/O5mFiOfHSK7GFIYxrNthtxQG+90AUhhdIjjNeGjM6PmPK2yCxhDN6RgA==
X-Received: by 2002:a17:906:1bb2:b0:aba:f6ff:d38a with SMTP id a640c23a62f3a-abbccf0b152mr680303766b.29.1740040216551;
        Thu, 20 Feb 2025 00:30:16 -0800 (PST)
Received: from localhost.localdomain ([154.118.9.41])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abbdf53d765sm230533966b.39.2025.02.20.00.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:30:16 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 3/5] t/unit-tests: convert oidmap test to use clar
Date: Thu, 20 Feb 2025 09:29:57 +0100
Message-ID: <20250220082959.10854-4-kuforiji98@gmail.com>
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

Adapt oidmap test script to clar framework by using clar assertions
where necessary. `cl_parse_any_oid` handles the necessary checks needed
for the test to run smoothly.

Introduce 'test_oidmap__initialize` handles the to set up of the global
oidmap map with predefined key-value pairs, and `test_oidmap__cleanup`
frees the oidmap and its entries when all tests are completed.

This streamlines the test suite, making individual tests self-contained
and reducing redundant code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                |   2 +-
 t/meson.build                           |   2 +-
 t/unit-tests/{t-oidmap.c => u-oidmap.c} | 153 ++++++++----------------
 3 files changed, 54 insertions(+), 103 deletions(-)
 rename t/unit-tests/{t-oidmap.c => u-oidmap.c} (32%)

diff --git a/Makefile b/Makefile
index f8e061365b..58a6af1eb0 100644
--- a/Makefile
+++ b/Makefile
@@ -1357,6 +1357,7 @@ CLAR_TEST_SUITES += u-hash
 CLAR_TEST_SUITES += u-hashmap
 CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-oid-array
+CLAR_TEST_SUITES += u-oidmap
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
@@ -1367,7 +1368,6 @@ CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
-UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
diff --git a/t/meson.build b/t/meson.build
index 93410a8545..f9e0ae15df 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -5,6 +5,7 @@ clar_test_suites = [
   'unit-tests/u-hashmap.c',
   'unit-tests/u-mem-pool.c',
   'unit-tests/u-oid-array.c',
+  'unit-tests/u-oidmap.c',
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
@@ -49,7 +50,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-oidmap.c',
   'unit-tests/t-oidtree.c',
   'unit-tests/t-reftable-basics.c',
   'unit-tests/t-reftable-block.c',
diff --git a/t/unit-tests/t-oidmap.c b/t/unit-tests/u-oidmap.c
similarity index 32%
rename from t/unit-tests/t-oidmap.c
rename to t/unit-tests/u-oidmap.c
index b22e52d08b..e40740db5c 100644
--- a/t/unit-tests/t-oidmap.c
+++ b/t/unit-tests/u-oidmap.c
@@ -1,5 +1,4 @@
-#include "test-lib.h"
-#include "lib-oid.h"
+#include "unit-test.h"
 #include "oidmap.h"
 #include "hash.h"
 #include "hex.h"
@@ -18,102 +17,85 @@ static const char *const key_val[][2] = { { "11", "one" },
 					  { "22", "two" },
 					  { "33", "three" } };
 
-static void setup(void (*f)(struct oidmap *map))
+static struct oidmap map;
+
+void test_oidmap__initialize(void)
 {
-	struct oidmap map = OIDMAP_INIT;
-	int ret = 0;
+	oidmap_init(&map, 0);
 
 	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++){
 		struct test_entry *entry;
 
 		FLEX_ALLOC_STR(entry, name, key_val[i][1]);
-		if ((ret = get_oid_arbitrary_hex(key_val[i][0], &entry->entry.oid))) {
-			free(entry);
-			break;
-		}
-		entry = oidmap_put(&map, entry);
-		if (!check(entry == NULL))
-			free(entry);
+		cl_parse_any_oid(key_val[i][0], &entry->entry.oid);
+		cl_assert(oidmap_put(&map, entry) == NULL);
 	}
+}
 
-	if (!ret)
-		f(&map);
+void test_oidmap__cleanup(void)
+{
 	oidmap_free(&map, 1);
 }
 
-static void t_replace(struct oidmap *map)
+void test_oidmap__replace(void)
 {
 	struct test_entry *entry, *prev;
 
 	FLEX_ALLOC_STR(entry, name, "un");
-	if (get_oid_arbitrary_hex("11", &entry->entry.oid))
-		return;
-	prev = oidmap_put(map, entry);
-	if (!check(prev != NULL))
-		return;
-	check_str(prev->name, "one");
+	cl_parse_any_oid("11", &entry->entry.oid);
+	prev = oidmap_put(&map, entry);
+	cl_assert(prev != NULL);
+	cl_assert_equal_s(prev->name, "one");
 	free(prev);
 
 	FLEX_ALLOC_STR(entry, name, "deux");
-	if (get_oid_arbitrary_hex("22", &entry->entry.oid))
-		return;
-	prev = oidmap_put(map, entry);
-	if (!check(prev != NULL))
-		return;
-	check_str(prev->name, "two");
+	cl_parse_any_oid("22", &entry->entry.oid);
+	prev = oidmap_put(&map, entry);
+	cl_assert(prev != NULL);
+	cl_assert_equal_s(prev->name, "two");
 	free(prev);
 }
 
-static void t_get(struct oidmap *map)
+void test_oidmap__get(void)
 {
 	struct test_entry *entry;
 	struct object_id oid;
 
-	if (get_oid_arbitrary_hex("22", &oid))
-		return;
-	entry = oidmap_get(map, &oid);
-	if (!check(entry != NULL))
-		return;
-	check_str(entry->name, "two");
-
-	if (get_oid_arbitrary_hex("44", &oid))
-		return;
-	check(oidmap_get(map, &oid) == NULL);
-
-	if (get_oid_arbitrary_hex("11", &oid))
-		return;
-	entry = oidmap_get(map, &oid);
-	if (!check(entry != NULL))
-		return;
-	check_str(entry->name, "one");
+	cl_parse_any_oid("22", &oid);
+	entry = oidmap_get(&map, &oid);
+	cl_assert(entry != NULL);
+	cl_assert_equal_s(entry->name, "two");
+
+	cl_parse_any_oid("44", &oid);
+	cl_assert(oidmap_get(&map, &oid) == NULL);
+
+	cl_parse_any_oid("11", &oid);
+	entry = oidmap_get(&map, &oid);
+	cl_assert(entry != NULL);
+	cl_assert_equal_s(entry->name, "one");
 }
 
-static void t_remove(struct oidmap *map)
+void test_oidmap__remove(void)
 {
 	struct test_entry *entry;
 	struct object_id oid;
 
-	if (get_oid_arbitrary_hex("11", &oid))
-		return;
-	entry = oidmap_remove(map, &oid);
-	if (!check(entry != NULL))
-		return;
-	check_str(entry->name, "one");
-	check(oidmap_get(map, &oid) == NULL);
+	cl_parse_any_oid("11", &oid);
+	entry = oidmap_remove(&map, &oid);
+	cl_assert(entry != NULL);
+	cl_assert_equal_s(entry->name, "one");
+	cl_assert(oidmap_get(&map, &oid) == NULL);
 	free(entry);
 
-	if (get_oid_arbitrary_hex("22", &oid))
-		return;
-	entry = oidmap_remove(map, &oid);
-	if (!check(entry != NULL))
-		return;
-	check_str(entry->name, "two");
-	check(oidmap_get(map, &oid) == NULL);
+	cl_parse_any_oid("22", &oid);
+	entry = oidmap_remove(&map, &oid);
+	cl_assert(entry != NULL);
+	cl_assert_equal_s(entry->name, "two");
+	cl_assert(oidmap_get(&map, &oid) == NULL);
 	free(entry);
 
-	if (get_oid_arbitrary_hex("44", &oid))
-		return;
-	check(oidmap_remove(map, &oid) == NULL);
+	cl_parse_any_oid("44", &oid);
+	cl_assert(oidmap_remove(&map, &oid) == NULL);
 }
 
 static int key_val_contains(struct test_entry *entry, char seen[])
@@ -121,8 +103,7 @@ static int key_val_contains(struct test_entry *entry, char seen[])
 	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
 		struct object_id oid;
 
-		if (get_oid_arbitrary_hex(key_val[i][0], &oid))
-			return -1;
+		cl_parse_any_oid(key_val[i][0], &oid);
 
 		if (oideq(&entry->entry.oid, &oid)) {
 			if (seen[i])
@@ -134,48 +115,18 @@ static int key_val_contains(struct test_entry *entry, char seen[])
 	return 1;
 }
 
-static void t_iterate(struct oidmap *map)
+void test_oidmap__iterate(void)
 {
 	struct oidmap_iter iter;
 	struct test_entry *entry;
 	char seen[ARRAY_SIZE(key_val)] = { 0 };
 	int count = 0;
 
-	oidmap_iter_init(map, &iter);
+	oidmap_iter_init(&map, &iter);
 	while ((entry = oidmap_iter_next(&iter))) {
-		int ret;
-		if (!check_int((ret = key_val_contains(entry, seen)), ==, 0)) {
-			switch (ret) {
-			case -1:
-				break; /* error message handled by get_oid_arbitrary_hex() */
-			case 1:
-				test_msg("obtained entry was not given in the input\n"
-					 "  name: %s\n   oid: %s\n",
-					 entry->name, oid_to_hex(&entry->entry.oid));
-				break;
-			case 2:
-				test_msg("duplicate entry detected\n"
-					 "  name: %s\n   oid: %s\n",
-					 entry->name, oid_to_hex(&entry->entry.oid));
-				break;
-			default:
-				test_msg("BUG: invalid return value (%d) from key_val_contains()",
-					 ret);
-				break;
-			}
-		} else {
-			count++;
-		}
+		cl_assert_equal_i(key_val_contains(entry, seen), 0);
+		count++;
 	}
-	check_int(count, ==, ARRAY_SIZE(key_val));
-	check_int(hashmap_get_size(&map->map), ==, ARRAY_SIZE(key_val));
-}
-
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
-{
-	TEST(setup(t_replace), "replace works");
-	TEST(setup(t_get), "get works");
-	TEST(setup(t_remove), "remove works");
-	TEST(setup(t_iterate), "iterate works");
-	return test_done();
+	cl_assert_equal_i(count, ARRAY_SIZE(key_val));
+	cl_assert_equal_i(hashmap_get_size(&map.map), ARRAY_SIZE(key_val));
 }
-- 
2.47.0.86.g15030f9556

