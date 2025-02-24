Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B41FAC52
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410887; cv=none; b=m/QIR843AQ11/2hODt9pamhd2gd4hptFFivdTzbEohLGW5PbAsWsFGgDi3pxg51xMr6laRMiSH29aV71yPBFi4ah8cUEuGYE483lQeVrNrE1y/OVfvXiMtkk8GT5ZX8nNkVlcxCmIxukEmeuDRYsUgJdGdQcGZMWwC1Y51UgyZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410887; c=relaxed/simple;
	bh=2I3Sxy0+gRaej2+g2kj7a9a7YacCAzgqKhviw2Gw+iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/BiCwOEJPbuzwd/azlqXHea2MnWG+NIcYKI0CyiHL8FFMIkr4f8HtlPMpspYFwqNIC+wuA7weJNtSIhHA2pvtRQeksvn84pxuXv6z/n6SECMhUbQcvpF2DGX+9OtxalHghkod6rxyTtHF4Q41cUMpfRCIUo/pg6z0hVhB4K5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSDoGzJm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSDoGzJm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so5441525e9.2
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 07:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740410883; x=1741015683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52pGapUxpqKwFzQKL/kANoHc4ZzG6RaXxnCvaVWUCvI=;
        b=iSDoGzJmaIZQhp/Jkk6RlieBxKJj0+e5M4rtNc2Q6VwXgGOVV/IPzTTD0ZdeHrhteL
         064s6ZHoUQrQygiGurHFL/FNS2pAdYQ8FsYJ6q/gjhI6s56C8Oduat23ZlBNvmS3ZOPG
         N5QabFdDrbsugIxufutYeBnnm9Xmnj3R6XU8+teZI8c5l6u3O9+Vq6z4Xu20CQfeBAit
         zuw5/4JkS3uPQw/OlFuX0i5azoYSgTWi6Ygz9GxfPahhgUiVqUq86WD8QwwO4GfPxccB
         94sNLV2k8CFGN9sTW/LiaT8+QDQ6MwuXlPWsPCrRrG496VC8PSXLH03NpmNYZPuXOSsQ
         BpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410883; x=1741015683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52pGapUxpqKwFzQKL/kANoHc4ZzG6RaXxnCvaVWUCvI=;
        b=W+o6Cmctk9LmMc9gzQvTrP1Pb5RvmHAZ2Q9z54nxG3e1KClHQ+r5xArxNaMzKrhsBf
         AHLkcafnLVuU7/hHn6ft+t7VIlJgD5HCpWyo8WKEcCWI2bj6TJeh0NuvPkf7pEr3riI2
         HM/k3IerUf5v3mZN8Pv/WNSUHjO22ZSR/rzjhwEIpAA4tF7ciKJ6ZH2EnCjsGILDFb9v
         W7o+m2R1M73mJhkE6pwfYgGlAUXw8HAjXTv5MxVSsNJAobqU3akPc9O8D6snjakKS3ua
         X8w8v3h1LsxjUiVJXtVaz+KZlT6qZs7lpIUAl0+gzezxTt8c34RZbvGnvS+zzu6PGpDI
         6ixA==
X-Gm-Message-State: AOJu0Yx1PJ/frW+dpQz7xnvhmBUyv3riWpJf9rAIzA5UDV1Laq9ZqdFe
	GUcgxw2NZBKp0j+uYMm257xQgwDdbMxunDb70/i9lNQBhInPqmF+LPU9kRsZZaf0ow==
X-Gm-Gg: ASbGncss6DWetKAHpfkjSb5VW04EoeFdj3TPOOxQmHWu5eCZRjG25EaRYS6wirVPd8t
	1w/5Thjk5Y9HtsU11j/LEX1+Tx/EtzFn2OHcn7WkigCMieGu1GTVXM3qfZlmPVHV9/HNEs+wZI4
	UEqq5dWXxAabGc8w73Vh2By3rxHmLOwDzG4vEdx8o8PcWB6a7wgQlvegmPncGoCEcFVJtbMwZ5E
	7eYyCw7sDxZ5r4g3AZ9iGVfuzeRXDpVtmmvEjjavGoSsuBb1mI3zmmKSKflgQ5gVQioQj0xtCVe
	qYoMOY9iQTiTpm88sVQ6Q8ZbsLgypdvSp6A4pGM=
X-Google-Smtp-Source: AGHT+IGf8xZoK6mr+/PFSvSiBzyHo2Gp0+x6G9zy3JD+g6FQkj12SeFv+Bw+FUC/kgTcbLbxMQ4/QA==
X-Received: by 2002:a05:600c:3150:b0:439:955d:7adb with SMTP id 5b1f17b1804b1-439ae222a7amr141485965e9.30.1740410882723;
        Mon, 24 Feb 2025 07:28:02 -0800 (PST)
Received: from localhost.localdomain ([41.217.53.197])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-439b02e425esm109048915e9.17.2025.02.24.07.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:28:02 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 3/4] t/unit-tests: convert oidmap test to use clar test framework
Date: Mon, 24 Feb 2025 16:27:03 +0100
Message-ID: <20250224152704.70289-4-kuforiji98@gmail.com>
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

Adapt oidmap test script to clar framework by using clar assertions
where necessary. `cl_parse_any_oid()` ensures the hash algorithm is set
before parsing. This prevents issues from an uninitialized or invalid
hash algorithm.

Introduce 'test_oidmap__initialize` handles the to set up of the global
oidmap map with predefined key-value pairs, and `test_oidmap__cleanup`
frees the oidmap and its entries when all tests are completed.

The test loops through all entries to detect multiple errors. With this
change, it stops at the first error encountered, making it easier to
address it.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                |   2 +-
 t/meson.build                           |   2 +-
 t/unit-tests/{t-oidmap.c => u-oidmap.c} | 153 +++++++++---------------
 3 files changed, 56 insertions(+), 101 deletions(-)
 rename t/unit-tests/{t-oidmap.c => u-oidmap.c} (32%)

diff --git a/Makefile b/Makefile
index c9b0320fcb..e4e85e6007 100644
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
@@ -1368,7 +1369,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
-UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
diff --git a/t/meson.build b/t/meson.build
index 1b17a53acc..d5b83cdb72 100644
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
@@ -50,7 +51,6 @@ clar_unit_tests = executable('unit-tests',
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
index b22e52d08b..dc805b7e3c 100644
--- a/t/unit-tests/t-oidmap.c
+++ b/t/unit-tests/u-oidmap.c
@@ -1,4 +1,4 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "lib-oid.h"
 #include "oidmap.h"
 #include "hash.h"
@@ -18,102 +18,85 @@ static const char *const key_val[][2] = { { "11", "one" },
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
@@ -121,8 +104,7 @@ static int key_val_contains(struct test_entry *entry, char seen[])
 	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
 		struct object_id oid;
 
-		if (get_oid_arbitrary_hex(key_val[i][0], &oid))
-			return -1;
+		cl_parse_any_oid(key_val[i][0], &oid);
 
 		if (oideq(&entry->entry.oid, &oid)) {
 			if (seen[i])
@@ -134,48 +116,21 @@ static int key_val_contains(struct test_entry *entry, char seen[])
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
+		if (key_val_contains(entry, seen) != 0) {
+			cl_failf("Unexpected entry: name = %s, oid = %s",
+				 entry->name, oid_to_hex(&entry->entry.oid));
 		}
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

