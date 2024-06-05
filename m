Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FBE19D8BB
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595083; cv=none; b=QRbz8Uw21N0J4il/QJWCLC7Hi1pFdoBcfEbRf7fxCO1lqvKM/BgeYiUV5eJ6xdnhvOFednQQiVEPUDXgXhrJgZgUsV2YlFxLkUWIsydHxlAHDQXT1lb4Qn5GJd2EWm/Qn/SDtH5YYVbx9i/93O7rFdrjKHWXak2BLF5iTGExzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595083; c=relaxed/simple;
	bh=D6qqCesG5eiOFkYhanxLQNnZxYnEgXY9atPZ9qfrfOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQtz5+qbOjGE/RnS/6zE0T/1Akki8GEIlnIrFlmmbj6QZB7oYgG9EWJfIsxXsveJl78vdMcXOnyCyaUV6LOp1L6tli72iaXfOwT7XeCf6+ke4bcZmbtHWopQSxYj1QcUZ6mVcCmL7cyQsq5NQTIVdg7B4EkX4cvsAC0mMCrAvnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvLZLZZS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvLZLZZS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b42d1caso53048555ad.0
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717595081; x=1718199881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TAeYXrkU8YBE2Lqq7lzgo869eVKXo6bfRn3EibBk430=;
        b=dvLZLZZSS//QdCOjzrpESiZycQcf87VOwbmil8FL3+UacDO/9YIgPFk5onu7J6QUX4
         xOp/1Ha7Ungq+wB7rRNpfviDg82jK4Isvs4f89tXzBUCKzNMZbDoaCv1PbsdLnM4Dx1j
         ZOK9yc9NOgKXHZooO/hHX7RDXJC/1uBu9VAsBJhHK8DXjEfZ9cDEowtN5XkKzZ6IOU2K
         HsqRJgcxBfXT2LYARzVjXZCVs94/JmdnC3453EPGsUP5arwEtw5s9oxwGA9NTJ/Y3sIa
         qAwl00vagubAO44Bcou46ibRj0h4xqJpSrQMz0+kU8bp0fLoFqWXCb2I4JUqTzvAyyuz
         de+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717595081; x=1718199881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAeYXrkU8YBE2Lqq7lzgo869eVKXo6bfRn3EibBk430=;
        b=QGglN3ou9IpcleScLxJJcoNcBDd8nVuwkSmYpsCWSuH3kk66yC5tLSwg2j5NrbCP1U
         SkT/IroXDR+EfIFBZ6HVRy7r6U+ahW4aZ6lssrdWo+wZnODZfoN7cNmis6tjHhubt/Vv
         ZJZuRYSBMCUkkPiSr2eZutoHeEnG2bciXBtMUCXone7eqDV4JUTkF91uDv4fzAn/7l4B
         hc569pMgv1N6K5fAFjpAs/HWwnKfgn9iBpbNyHX2QT+xYMGdLTe6YtRQ2P6Bvuzulb//
         aTqhDZqKnnfe0gNDXZ0QLcJ66sLaQi1jExVFt+LhjPMSoQCa8S35zHsavNhZG1vh5gQN
         34+A==
X-Gm-Message-State: AOJu0YxbqidmrvBmf7CbiGU8BsmiTLjKf0Nehc0aiOEXaufyG91mmGLx
	zoJRXfb4h3Ms1xKffaB0fAOhOi0fjXVXheYUQ+Tho6FyKue/HS7S1HrwSKdJZS2DVg==
X-Google-Smtp-Source: AGHT+IFdn057U39km6nVQcMM/7BSReH3v8eIXT4Iga81H+DXLy7y0d4Ydkv+T78kEiS759tQ5kGgKQ==
X-Received: by 2002:a17:902:dcd4:b0:1f6:7e02:7ab8 with SMTP id d9443c01a7336-1f6a5a8529emr18477045ad.68.1717595080754;
        Wed, 05 Jun 2024 06:44:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6881bb4dcsm47103535ad.236.2024.06.05.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:44:40 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC][PATCH] t/: migrate helper/test-oidtree.c to unit-tests/t-oidtree.c
Date: Wed,  5 Jun 2024 19:13:52 +0530
Message-ID: <20240605134400.37309-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

helper/test-oidtree.c along with t0069-oidtree.sh test the oidtree.h
library, which is a wrapper around crit-bit tree. Migrate them to
the unit testing framework for better debugging and runtime
performance.

To achieve this, introduce a new library called 'lib-oid.h'
exclusively for the unit tests to use. It currently mainly includes
utility to generate object_id from an arbitrary hex string
(i.e. '12a' -> '12a0000000000000000000000000000000000000').
This will also be helpful when we port other unit tests such
as oid-array, oidset etc.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 Makefile                 |  8 +++-
 t/helper/test-oidtree.c  | 54 ------------------------
 t/helper/test-tool.c     |  1 -
 t/helper/test-tool.h     |  1 -
 t/t0069-oidtree.sh       | 50 ----------------------
 t/unit-tests/lib-oid.c   | 52 +++++++++++++++++++++++
 t/unit-tests/lib-oid.h   | 17 ++++++++
 t/unit-tests/t-oidtree.c | 91 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 166 insertions(+), 108 deletions(-)
 delete mode 100644 t/helper/test-oidtree.c
 delete mode 100755 t/t0069-oidtree.sh
 create mode 100644 t/unit-tests/lib-oid.c
 create mode 100644 t/unit-tests/lib-oid.h
 create mode 100644 t/unit-tests/t-oidtree.c

diff --git a/Makefile b/Makefile
index 59d98ba688..6c9927afae 100644
--- a/Makefile
+++ b/Makefile
@@ -811,7 +811,6 @@ TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-oidmap.o
-TEST_BUILTINS_OBJS += test-oidtree.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
@@ -1335,6 +1334,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-mem-pool
+UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
@@ -1342,6 +1342,7 @@ UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
+UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
@@ -3882,7 +3883,10 @@ $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
 		-Wl,--allow-multiple-definition \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 
-$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS
+$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
+	$(UNIT_TEST_DIR)/test-lib.o \
+	$(UNIT_TEST_DIR)/lib-oid.o \
+	$(GITLIBS) GIT-LDFLAGS
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
deleted file mode 100644
index c7a1d4c642..0000000000
--- a/t/helper/test-oidtree.c
+++ /dev/null
@@ -1,54 +0,0 @@
-#include "test-tool.h"
-#include "hex.h"
-#include "oidtree.h"
-#include "setup.h"
-#include "strbuf.h"
-
-static enum cb_next print_oid(const struct object_id *oid, void *data UNUSED)
-{
-	puts(oid_to_hex(oid));
-	return CB_CONTINUE;
-}
-
-int cmd__oidtree(int argc UNUSED, const char **argv UNUSED)
-{
-	struct oidtree ot;
-	struct strbuf line = STRBUF_INIT;
-	int nongit_ok;
-	int algo = GIT_HASH_UNKNOWN;
-
-	oidtree_init(&ot);
-	setup_git_directory_gently(&nongit_ok);
-
-	while (strbuf_getline(&line, stdin) != EOF) {
-		const char *arg;
-		struct object_id oid;
-
-		if (skip_prefix(line.buf, "insert ", &arg)) {
-			if (get_oid_hex_any(arg, &oid) == GIT_HASH_UNKNOWN)
-				die("insert not a hexadecimal oid: %s", arg);
-			algo = oid.algo;
-			oidtree_insert(&ot, &oid);
-		} else if (skip_prefix(line.buf, "contains ", &arg)) {
-			if (get_oid_hex(arg, &oid))
-				die("contains not a hexadecimal oid: %s", arg);
-			printf("%d\n", oidtree_contains(&ot, &oid));
-		} else if (skip_prefix(line.buf, "each ", &arg)) {
-			char buf[GIT_MAX_HEXSZ + 1] = { '0' };
-			memset(&oid, 0, sizeof(oid));
-			memcpy(buf, arg, strlen(arg));
-			buf[hash_algos[algo].hexsz] = '\0';
-			get_oid_hex_any(buf, &oid);
-			oid.algo = algo;
-			oidtree_each(&ot, &oid, strlen(arg), print_oid, NULL);
-		} else if (!strcmp(line.buf, "clear")) {
-			oidtree_clear(&ot);
-		} else {
-			die("unknown command: %s", line.buf);
-		}
-	}
-
-	strbuf_release(&line);
-
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 7ad7d07018..253324a06b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -46,7 +46,6 @@ static struct test_cmd cmds[] = {
 	{ "mktemp", cmd__mktemp },
 	{ "oid-array", cmd__oid_array },
 	{ "oidmap", cmd__oidmap },
-	{ "oidtree", cmd__oidtree },
 	{ "online-cpus", cmd__online_cpus },
 	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index d14b3072bd..460dd7d260 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -39,7 +39,6 @@ int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__oidmap(int argc, const char **argv);
-int cmd__oidtree(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
diff --git a/t/t0069-oidtree.sh b/t/t0069-oidtree.sh
deleted file mode 100755
index 889db50818..0000000000
--- a/t/t0069-oidtree.sh
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/bin/sh
-
-test_description='basic tests for the oidtree implementation'
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-maxhexsz=$(test_oid hexsz)
-echoid () {
-	prefix="${1:+$1 }"
-	shift
-	while test $# -gt 0
-	do
-		shortoid="$1"
-		shift
-		difference=$(($maxhexsz - ${#shortoid}))
-		printf "%s%s%0${difference}d\\n" "$prefix" "$shortoid" "0"
-	done
-}
-
-test_expect_success 'oidtree insert and contains' '
-	cat >expect <<-\EOF &&
-		0
-		0
-		0
-		1
-		1
-		0
-	EOF
-	{
-		echoid insert 444 1 2 3 4 5 a b c d e &&
-		echoid contains 44 441 440 444 4440 4444 &&
-		echo clear
-	} | test-tool oidtree >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'oidtree each' '
-	echoid "" 123 321 321 >expect &&
-	{
-		echoid insert f 9 8 123 321 a b c d e &&
-		echo each 12300 &&
-		echo each 3211 &&
-		echo each 3210 &&
-		echo each 32100 &&
-		echo clear
-	} | test-tool oidtree >actual &&
-	test_cmp expect actual
-'
-
-test_done
diff --git a/t/unit-tests/lib-oid.c b/t/unit-tests/lib-oid.c
new file mode 100644
index 0000000000..37105f0a8f
--- /dev/null
+++ b/t/unit-tests/lib-oid.c
@@ -0,0 +1,52 @@
+#include "test-lib.h"
+#include "lib-oid.h"
+#include "strbuf.h"
+#include "hex.h"
+
+static int init_hash_algo(void)
+{
+	static int algo = -1;
+
+	if (algo < 0) {
+		const char *algo_name = getenv("GIT_TEST_DEFAULT_HASH");
+		algo = algo_name ? hash_algo_by_name(algo_name) : GIT_HASH_SHA1;
+
+		if (!check(algo != GIT_HASH_UNKNOWN))
+			test_msg("BUG: invalid GIT_TEST_DEFAULT_HASH value ('%s')",
+				 algo_name);
+	}
+	return algo;
+}
+
+static int get_oid_arbitrary_hex_algop(const char *hex, struct object_id *oid,
+				       const struct git_hash_algo *algop)
+{
+	int ret;
+	size_t sz = strlen(hex);
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!check(sz <= algop->hexsz)) {
+		test_msg("BUG: hex string (%s) bigger than maximum allowed (%lu)",
+			 hex, (unsigned long)algop->hexsz);
+		return -1;
+	}
+
+	strbuf_add(&buf, hex, sz);
+	strbuf_addchars(&buf, '0', algop->hexsz - sz);
+
+	ret = get_oid_hex_algop(buf.buf, oid, algop);
+	if (!check_int(ret, ==, 0))
+		test_msg("BUG: invalid hex input (%s) provided", hex);
+
+	strbuf_release(&buf);
+	return ret;
+}
+
+int get_oid_arbitrary_hex(const char *hex, struct object_id *oid)
+{
+	int hash_algo = init_hash_algo();
+
+	if (!check_int(hash_algo, !=, GIT_HASH_UNKNOWN))
+		return -1;
+	return get_oid_arbitrary_hex_algop(hex, oid, &hash_algos[hash_algo]);
+}
diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
new file mode 100644
index 0000000000..bfde639190
--- /dev/null
+++ b/t/unit-tests/lib-oid.h
@@ -0,0 +1,17 @@
+#ifndef LIB_OID_H
+#define LIB_OID_H
+
+#include "hash-ll.h"
+
+/*
+ * Convert arbitrary hex string to object_id.
+ * For example, passing "abc12" will generate
+ * "abc1200000000000000000000000000000000000" hex of length 40 for SHA-1 and
+ * create object_id with that.
+ * WARNING: passing a string of length more than the hexsz of respective hash
+ * algo is not allowed. The hash algo is decided based on GIT_TEST_DEFAULT_HASH
+ * environment variable.
+ */
+int get_oid_arbitrary_hex(const char *s, struct object_id *oid);
+
+#endif /* LIB_OID_H */
diff --git a/t/unit-tests/t-oidtree.c b/t/unit-tests/t-oidtree.c
new file mode 100644
index 0000000000..0ebe17d2b9
--- /dev/null
+++ b/t/unit-tests/t-oidtree.c
@@ -0,0 +1,91 @@
+#include "test-lib.h"
+#include "lib-oid.h"
+#include "oidtree.h"
+#include "hash.h"
+#include "hex.h"
+
+#define FILL_TREE(tree, ...)                                       \
+	do {                                                       \
+		const char *hexes[] = { __VA_ARGS__ };             \
+		if (fill_tree_loc(tree, hexes, ARRAY_SIZE(hexes))) \
+			return;                                    \
+	} while (0)
+
+static int fill_tree_loc(struct oidtree *ot, const char *hexes[], int n)
+{
+	for (size_t i = 0; i < n; i++) {
+		struct object_id oid;
+		if (!check_int(get_oid_arbitrary_hex(hexes[i], &oid), ==, 0))
+			return -1;
+		oidtree_insert(ot, &oid);
+	}
+	return 0;
+}
+
+static void check_contains(struct oidtree *ot, const char *hex, int expected)
+{
+	struct object_id oid;
+
+	if (!check_int(get_oid_arbitrary_hex(hex, &oid), ==, 0))
+		return;
+	if (!check_int(oidtree_contains(ot, &oid), ==, expected))
+		test_msg("oid: %s", oid_to_hex(&oid));
+}
+
+static enum cb_next check_each_cb(const struct object_id *oid, void *data)
+{
+	const char *hex = data;
+	struct object_id expected;
+
+	if (!check_int(get_oid_arbitrary_hex(hex, &expected), ==, 0))
+		return CB_CONTINUE;
+	if (!check(oideq(oid, &expected)))
+		test_msg("expected: %s\n       got: %s",
+			 hash_to_hex(expected.hash), hash_to_hex(oid->hash));
+	return CB_CONTINUE;
+}
+
+static void check_each(struct oidtree *ot, char *hex, char *expected)
+{
+	struct object_id oid;
+
+	if (!check_int(get_oid_arbitrary_hex(hex, &oid), ==, 0))
+		return;
+	oidtree_each(ot, &oid, 40, check_each_cb, expected);
+}
+
+static void setup(void (*f)(struct oidtree *ot))
+{
+	struct oidtree ot;
+
+	oidtree_init(&ot);
+	f(&ot);
+	oidtree_clear(&ot);
+}
+
+static void t_contains(struct oidtree *ot)
+{
+	FILL_TREE(ot, "444", "1", "2", "3", "4", "5", "a", "b", "c", "d", "e");
+	check_contains(ot, "44", 0);
+	check_contains(ot, "441", 0);
+	check_contains(ot, "440", 0);
+	check_contains(ot, "444", 1);
+	check_contains(ot, "4440", 1);
+	check_contains(ot, "4444", 0);
+}
+
+static void t_each(struct oidtree *ot)
+{
+	FILL_TREE(ot, "f", "9", "8", "123", "321", "a", "b", "c", "d", "e");
+	check_each(ot, "12300", "123");
+	check_each(ot, "3211", ""); /* should not reach callback */
+	check_each(ot, "3210", "321");
+	check_each(ot, "32100", "321");
+}
+
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
+{
+	TEST(setup(t_contains), "oidtree insert and contains works");
+	TEST(setup(t_each), "oidtree each works");
+	return test_done();
+}
-- 
2.45.2

