Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F556248897
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410893; cv=none; b=QNC8dR0HwPydnkY03N3mXfZeYjpEYrkJEM5mAq/LTxcchjPpjxshFTF60X4rZttE5IihJCen0ismFQ9gR5BuxH8n+rCDWFPfrROB0M4ryGO3NGY/02+3AVJjNYjBrDhYjcWkA5r22hucdcSlRmi/gS+2oftiL1PnUhMKJfxf8Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410893; c=relaxed/simple;
	bh=Jy8UAsmv0M9Ianz70QW37WeM/FMtgRFue80XQrAXUSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrV53LGDvR4uoV5s/Rf7zNZSxyh+kvLT9Z0KzErECIuN0C5Io1j9qdqsfLo+LukqoMmJfHHcxsi4kvC2zEcymbW0kkxhqWdPDPCJ+XpUrYVPPVodMohx/3Q5N/uCcRZdMfcvAkVYSzq98216ZfeILyPdl//MfbaKwGt6tG/FsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiygDa0W; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiygDa0W"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so43490845e9.1
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 07:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740410889; x=1741015689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NgQ/SeUGRi4k7g9nIO1t+BNpYgEGEVWcRY2g0N2lSM=;
        b=JiygDa0WclWj2o2QnTIb3UnbB3V9K8nj8ERHhaiYkZvySNPP4TisA2+N49jFVoxByz
         M64lgD95D2ON+HVILIwzAOxzoSQ8r8ybILD7WIu3asZRV01+iDPb0yWwtqex8FgCXAdG
         fxNrx4x/byNzsaMJoEnPJ0ug1Laq1Vsu0j6hv3pWDPd5X/WsLVERnfMHw/ZzRCucwOGN
         HtTTpB7SkhyvYT6krOQHr4CXSSwfys++DGUYMgJQUry4bye+7+DSdDVomlHhQKQs01h2
         CEVoXePaZ6u1WDAGUloEsFWuUhXo+Ba8FvbPKwfJABbcKj/TqSUYHXOaNOwyrrYlFTy5
         PiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410889; x=1741015689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NgQ/SeUGRi4k7g9nIO1t+BNpYgEGEVWcRY2g0N2lSM=;
        b=MXxL9OkP5pb9saboKSk8OrcD/PcGwmQ73y49lr+pUJWaVT9hCbdVZCdPoX+NYJAUUm
         yYi8R8d4TFFBvF1xIDRbYcf865jBDlSQhUPAEgkRq3729g+B/7xG+5wP4q5SubgQF5CU
         oEQQ0xFUnR7x7XvSt2CHV48cjB8QQJjwfjXQzNftGfQurJsRiUm8/tfluw34BZRK1zPJ
         RjuQOXGNmhiDiQlnpIannMdzexASrFmxk0BQer0B4rAEMQeKV9W2n7+Q4UcGYc0hdPk1
         7GYHNSVsQRoYK1N/b45fpeGJVj8D37Hj+uVTlw+bHF7depdsOgwVQRhs8akse82jes7M
         HlGg==
X-Gm-Message-State: AOJu0Yw2526qOl8xdaTsaXp5re6Tv3Is9QgKFk4Wi9FPWY7j8jQiFPPz
	yzDxix9ArYbaLpl4tS7RiyG2EnYOal6eCg3mjlbqGtuqE3fGoMKAxm8zKjCDKCNCUg==
X-Gm-Gg: ASbGncv5ONUCX7lZM+5jpQopo2jkH2X+pO/lgjWYYdaIXuWcp8FM/HsbnhtgOP8Rmy/
	yBd+r9B4UoxpXhJkatVcIznaF0GSzCn5l4bC2dQ9GIpNyYRRFgMaVf64uaI5WEvjEtCxCSXIbIb
	q7tLVK5bJycilev+T3XpqfRJKQygVGqPSV97I6bp6rwuc9OIMcwRFfgNK83G5YZib/lSwy/DCWF
	jBtjMZ1avfhIFck4bJ4L5ZZZrQ5wTxVVfvZygtllXAP2iMme0wCZ30W8uHjYmQ0qFARCutlhPr5
	qyQ9qiCoLNrLN7zZKDcA5JNvNRpWTiTGNE9rdR8=
X-Google-Smtp-Source: AGHT+IGh5ovlNNy7phMH4cEZc7HlhmERnxDvU5C0EYu1n6vgUkUjwUvAVxCbsFszo0stOgMmXixBaA==
X-Received: by 2002:a05:600c:1910:b0:439:98f6:8bc8 with SMTP id 5b1f17b1804b1-439aebcf61dmr101985245e9.26.1740410888835;
        Mon, 24 Feb 2025 07:28:08 -0800 (PST)
Received: from localhost.localdomain ([41.217.53.197])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-439b02e425esm109048915e9.17.2025.02.24.07.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:28:08 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 4/4] t/unit-tests: convert oidtree test to use clar test framework
Date: Mon, 24 Feb 2025 16:27:04 +0100
Message-ID: <20250224152704.70289-5-kuforiji98@gmail.com>
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

Adapt oidtree test script to clar framework by using clar assertions
where necessary. `cl_parse_any_oid()` ensures the hash algorithm is set
before parsing. This prevents issues from an uninitialized or invalid
hash algorithm.

Introduce 'test_oidtree__initialize` handles the to set up of the global
oidtree variable and `test_oidtree__cleanup` frees the oidtree when all
tests are completed.

With this change, `check_each` stops at the first error encountered,
making it easier to address it.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                  |  2 +-
 t/meson.build                             |  2 +-
 t/unit-tests/{t-oidtree.c => u-oidtree.c} | 79 +++++++++--------------
 3 files changed, 34 insertions(+), 49 deletions(-)
 rename t/unit-tests/{t-oidtree.c => u-oidtree.c} (45%)

diff --git a/Makefile b/Makefile
index e4e85e6007..2b134efc70 100644
--- a/Makefile
+++ b/Makefile
@@ -1358,6 +1358,7 @@ CLAR_TEST_SUITES += u-hashmap
 CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-oid-array
 CLAR_TEST_SUITES += u-oidmap
+CLAR_TEST_SUITES += u-oidtree
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
@@ -1369,7 +1370,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
-UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
diff --git a/t/meson.build b/t/meson.build
index d5b83cdb72..91699917ff 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -6,6 +6,7 @@ clar_test_suites = [
   'unit-tests/u-mem-pool.c',
   'unit-tests/u-oid-array.c',
   'unit-tests/u-oidmap.c',
+  'unit-tests/u-oidtree.c',
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
@@ -51,7 +52,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-oidtree.c',
   'unit-tests/t-reftable-basics.c',
   'unit-tests/t-reftable-block.c',
   'unit-tests/t-reftable-merged.c',
diff --git a/t/unit-tests/t-oidtree.c b/t/unit-tests/u-oidtree.c
similarity index 45%
rename from t/unit-tests/t-oidtree.c
rename to t/unit-tests/u-oidtree.c
index a38754b066..e6eede2740 100644
--- a/t/unit-tests/t-oidtree.c
+++ b/t/unit-tests/u-oidtree.c
@@ -1,10 +1,12 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "lib-oid.h"
 #include "oidtree.h"
 #include "hash.h"
 #include "hex.h"
 #include "strvec.h"
 
+static struct oidtree ot;
+
 #define FILL_TREE(tree, ...)                                       \
 	do {                                                       \
 		const char *hexes[] = { __VA_ARGS__ };             \
@@ -16,8 +18,7 @@ static int fill_tree_loc(struct oidtree *ot, const char *hexes[], size_t n)
 {
 	for (size_t i = 0; i < n; i++) {
 		struct object_id oid;
-		if (!check_int(get_oid_arbitrary_hex(hexes[i], &oid), ==, 0))
-			return -1;
+		cl_parse_any_oid(hexes[i], &oid);
 		oidtree_insert(ot, &oid);
 	}
 	return 0;
@@ -27,10 +28,8 @@ static void check_contains(struct oidtree *ot, const char *hex, int expected)
 {
 	struct object_id oid;
 
-	if (!check_int(get_oid_arbitrary_hex(hex, &oid), ==, 0))
-		return;
-	if (!check_int(oidtree_contains(ot, &oid), ==, expected))
-		test_msg("oid: %s", oid_to_hex(&oid));
+	cl_parse_any_oid(hex, &oid);
+	cl_assert_equal_i(oidtree_contains(ot, &oid), expected);
 }
 
 struct expected_hex_iter {
@@ -44,19 +43,11 @@ static enum cb_next check_each_cb(const struct object_id *oid, void *data)
 	struct expected_hex_iter *hex_iter = data;
 	struct object_id expected;
 
-	if (!check_int(hex_iter->i, <, hex_iter->expected_hexes.nr)) {
-		test_msg("error: extraneous callback for query: ('%s'), object_id: ('%s')",
-			 hex_iter->query, oid_to_hex(oid));
-		return CB_BREAK;
-	}
-
-	if (!check_int(get_oid_arbitrary_hex(hex_iter->expected_hexes.v[hex_iter->i],
-					     &expected), ==, 0))
-		; /* the data is bogus and cannot be used */
-	else if (!check(oideq(oid, &expected)))
-		test_msg("expected: %s\n       got: %s\n     query: %s",
-			 oid_to_hex(&expected), oid_to_hex(oid), hex_iter->query);
+	cl_assert(hex_iter->i < hex_iter->expected_hexes.nr);
 
+	cl_parse_any_oid(hex_iter->expected_hexes.v[hex_iter->i],
+			 &expected);
+	cl_assert_equal_s(oid_to_hex(oid), oid_to_hex(&expected));
 	hex_iter->i += 1;
 	return CB_CONTINUE;
 }
@@ -75,48 +66,42 @@ static void check_each(struct oidtree *ot, const char *query, ...)
 		strvec_push(&hex_iter.expected_hexes, arg);
 	va_end(hex_args);
 
-	if (!check_int(get_oid_arbitrary_hex(query, &oid), ==, 0))
-		return;
+	cl_parse_any_oid(query, &oid);
 	oidtree_each(ot, &oid, strlen(query), check_each_cb, &hex_iter);
 
-	if (!check_int(hex_iter.i, ==, hex_iter.expected_hexes.nr))
-		test_msg("error: could not find some 'object_id's for query ('%s')", query);
+	if (hex_iter.i != hex_iter.expected_hexes.nr)
+		cl_failf("error: could not find some 'object_id's for query ('%s')", query);
+
 	strvec_clear(&hex_iter.expected_hexes);
 }
 
-static void setup(void (*f)(struct oidtree *ot))
+void test_oidtree__initialize(void)
 {
-	struct oidtree ot;
-
 	oidtree_init(&ot);
-	f(&ot);
-	oidtree_clear(&ot);
 }
 
-static void t_contains(struct oidtree *ot)
+void test_oidtree__cleanup(void)
 {
-	FILL_TREE(ot, "444", "1", "2", "3", "4", "5", "a", "b", "c", "d", "e");
-	check_contains(ot, "44", 0);
-	check_contains(ot, "441", 0);
-	check_contains(ot, "440", 0);
-	check_contains(ot, "444", 1);
-	check_contains(ot, "4440", 1);
-	check_contains(ot, "4444", 0);
+	oidtree_clear(&ot);
 }
 
-static void t_each(struct oidtree *ot)
+void test_oidtree__contains(void)
 {
-	FILL_TREE(ot, "f", "9", "8", "123", "321", "320", "a", "b", "c", "d", "e");
-	check_each(ot, "12300", "123", NULL);
-	check_each(ot, "3211", NULL); /* should not reach callback */
-	check_each(ot, "3210", "321", NULL);
-	check_each(ot, "32100", "321", NULL);
-	check_each(ot, "32", "320", "321", NULL);
+	FILL_TREE(&ot, "444", "1", "2", "3", "4", "5", "a", "b", "c", "d", "e");
+	check_contains(&ot, "44", 0);
+	check_contains(&ot, "441", 0);
+	check_contains(&ot, "440", 0);
+	check_contains(&ot, "444", 1);
+	check_contains(&ot, "4440", 1);
+	check_contains(&ot, "4444", 0);
 }
 
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
+void test_oidtree__each(void)
 {
-	TEST(setup(t_contains), "oidtree insert and contains works");
-	TEST(setup(t_each), "oidtree each works");
-	return test_done();
+	FILL_TREE(&ot, "f", "9", "8", "123", "321", "320", "a", "b", "c", "d", "e");
+	check_each(&ot, "12300", "123", NULL);
+	check_each(&ot, "3211", NULL); /* should not reach callback */
+	check_each(&ot, "3210", "321", NULL);
+	check_each(&ot, "32100", "321", NULL);
+	check_each(&ot, "32", "320", "321", NULL);
 }
-- 
2.47.0.86.g15030f9556

