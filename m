Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9152E417
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717865939; cv=none; b=ZaO9tedgr8+106kuLK7f0DghbThWySYviCmeIiFcz+qx5n+9Ncho5lOJ5xKXQvYl/OWTmIMNEfmkwS1o/4yDkgbiMbDb9pInVnYH42eeWQGfvKf9vUgN/v3V23yb5n40iBgIkylWsmY9CPAlA3g6o5qIlDWpAGc98zlS3e/980A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717865939; c=relaxed/simple;
	bh=OF5cBOaQomwQXKpN/6sgSIS0gjtxXFCFwl/33dnFMuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DN/lms5BBTx6PMlrKw5NQOCACDMTTI/PjNs7IR1/q6MWY5RA6upo9yvslerFH/qqfineJiW7Y5zvwcC0hIsshYUSn3gCL0LnIBp5bfyKT0bHk3QA+ZSPQj6fMQep8Ig2bbPX+UVsiKs0uCACoLC2f3MLXW8eEzCIYBZ5w2xtoKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izVNM9jk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izVNM9jk"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7043102dcc1so179264b3a.2
        for <git@vger.kernel.org>; Sat, 08 Jun 2024 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717865937; x=1718470737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18GIOR9QQlQjRCuMPesPG0vh8rGTWuL/0z0JzSVErhI=;
        b=izVNM9jkKH59XRIhdtVR2vS5Nw4xcZAun5X7i+fkdABsmgKCeLd9YpEP9XFA4J/zsA
         PV83pcQ5JIWnJC3qBgC8e0jz1oSBZc+s1dJOzWK7I2ifrYUyXms6zZpHIBErWkOa2Srr
         Hc/CAzydbXyO56axLqFToDB4QwhnPoh0Pyq68rcenqmsIkJeuRy8tPiK5aUvJdeS0/yb
         /f5z3VHssGWpAfbPbaGcCqN02nj5E0iUun2FJ0Rwe+5Nb5Gl732ElKYQAc2mhPksmjUw
         g3+xU48REDCHiAyIa+t/rcpfE2JY+LRxstec2UtD5AtLfMQqEHXZbwvEu7ApcnF/htlO
         N9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717865937; x=1718470737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18GIOR9QQlQjRCuMPesPG0vh8rGTWuL/0z0JzSVErhI=;
        b=PDrG+my07zaZ2efbRa8njgfpcTepUP1E+IUjiMDDPHkXAa9jqDW3VgyDIV/sstwgYH
         QqqW8MWVH8p1hGyEv0BZl9iQ06mgjVvWN3VC8KV9YTSqDkbXHbMgqND+x6m5J0vWxp0V
         x/RlWHwFOwtNG8k1F77Ark0XsJhodNaoqW/Y7fpMssEDK78Vrv2n4pifSOP24o+2mCWF
         1FzMGgBek5GKiQmQSnrd/6HLNkSWIetzGlFQ8gqtiob8uR4BOvHCGxJ4yhUPukF0XndN
         d984Ja7NfJDBEBqGiip6bgxbGADi6dja3P8sssGdMfcpqO22kq4WXgCZawP1jokxpguC
         HhJw==
X-Gm-Message-State: AOJu0YydnbIRI9kgWJHY94ImmuS2GywUPTxAFsR1uXqQ3WAG+uxuqnqB
	QGKGfi/Ot2eZO0znu4Wop68QGW3Xbij8U5hBCkznziFw0cn1FwY51bFTXVzHRxs=
X-Google-Smtp-Source: AGHT+IEVkZhIqilBodBanL4NXd7HP514Yx+RAoiT0MNgcXp/hdnJtAKtW0NXu0XKMdxG2gig/ukpQQ==
X-Received: by 2002:a05:6a21:3287:b0:1b5:6b5e:c104 with SMTP id adf61e73a8af0-1b56b5ee0abmr2005980637.51.1717865936148;
        Sat, 08 Jun 2024 09:58:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704236597e8sm1456161b3a.141.2024.06.08.09.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 09:58:55 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC][PATCH v2] t/: migrate helper/test-oidtree.c to unit-tests/t-oidtree.c
Date: Sat,  8 Jun 2024 22:27:09 +0530
Message-ID: <20240608165731.29467-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605134400.37309-1-shyamthakkar001@gmail.com>
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
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
performance. Along with the migration, add an extra check for
oidtree_each() test, which showcases how multiple expected matches can
be given to check_each() helper.

To achieve this, introduce a new library called 'lib-oid.h'
exclusively for the unit tests to use. It currently mainly includes
utility to generate object_id from an arbitrary hex string
(i.e. '12a' -> '12a0000000000000000000000000000000000000'). This also
handles the hash algo selection based on GIT_TEST_DEFAULT_HASH.
This library will also be helpful when we port other unit tests such
as oid-array, oidset etc.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
Range-diff against v1:
1:  ee3df5db33 ! 1:  6d94be745a t/: migrate helper/test-oidtree.c to unit-tests/t-oidtree.c
    @@ Commit message
         helper/test-oidtree.c along with t0069-oidtree.sh test the oidtree.h
         library, which is a wrapper around crit-bit tree. Migrate them to
         the unit testing framework for better debugging and runtime
    -    performance.
    +    performance. Along with the migration, add an extra check for
    +    oidtree_each() test, which showcases how multiple expected matches can
    +    be given to check_each() helper.
     
         To achieve this, introduce a new library called 'lib-oid.h'
         exclusively for the unit tests to use. It currently mainly includes
         utility to generate object_id from an arbitrary hex string
    -    (i.e. '12a' -> '12a0000000000000000000000000000000000000').
    -    This will also be helpful when we port other unit tests such
    +    (i.e. '12a' -> '12a0000000000000000000000000000000000000'). This also
    +    handles the hash algo selection based on GIT_TEST_DEFAULT_HASH.
    +    This library will also be helpful when we port other unit tests such
         as oid-array, oidset etc.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
    @@ t/unit-tests/t-oidtree.c (new)
     +#include "oidtree.h"
     +#include "hash.h"
     +#include "hex.h"
    ++#include "strvec.h"
     +
     +#define FILL_TREE(tree, ...)                                       \
     +	do {                                                       \
    @@ t/unit-tests/t-oidtree.c (new)
     +			return;                                    \
     +	} while (0)
     +
    -+static int fill_tree_loc(struct oidtree *ot, const char *hexes[], int n)
    ++static int fill_tree_loc(struct oidtree *ot, const char *hexes[], size_t n)
     +{
     +	for (size_t i = 0; i < n; i++) {
     +		struct object_id oid;
    @@ t/unit-tests/t-oidtree.c (new)
     +		test_msg("oid: %s", oid_to_hex(&oid));
     +}
     +
    ++struct expected_hex_iter {
    ++	size_t i;
    ++	struct strvec expected_hexes;
    ++	const char *query;
    ++};
    ++
     +static enum cb_next check_each_cb(const struct object_id *oid, void *data)
     +{
    -+	const char *hex = data;
    ++	struct expected_hex_iter *hex_iter = data;
     +	struct object_id expected;
     +
    -+	if (!check_int(get_oid_arbitrary_hex(hex, &expected), ==, 0))
    -+		return CB_CONTINUE;
    -+	if (!check(oideq(oid, &expected)))
    -+		test_msg("expected: %s\n       got: %s",
    -+			 hash_to_hex(expected.hash), hash_to_hex(oid->hash));
    ++	if (!check_int(hex_iter->i, <, hex_iter->expected_hexes.nr)) {
    ++		test_msg("error: extraneous callback for query: ('%s'), object_id: ('%s')",
    ++			 hex_iter->query, oid_to_hex(oid));
    ++		return CB_BREAK;
    ++	}
    ++
    ++	if (!check_int(get_oid_arbitrary_hex(hex_iter->expected_hexes.v[hex_iter->i],
    ++					     &expected), ==, 0))
    ++		; /* the data is bogus and cannot be used */
    ++	else if (!check(oideq(oid, &expected)))
    ++		test_msg("expected: %s\n       got: %s\n     query: %s",
    ++			 oid_to_hex(&expected), oid_to_hex(oid), hex_iter->query);
    ++
    ++	hex_iter->i += 1;
     +	return CB_CONTINUE;
     +}
     +
    -+static void check_each(struct oidtree *ot, char *hex, char *expected)
    ++static void check_each(struct oidtree *ot, char *query, ...)
     +{
     +	struct object_id oid;
    ++	struct expected_hex_iter hex_iter = { .expected_hexes = STRVEC_INIT,
    ++					      .query = query };
    ++	const char *arg;
    ++	va_list hex_args;
     +
    -+	if (!check_int(get_oid_arbitrary_hex(hex, &oid), ==, 0))
    ++	va_start(hex_args, query);
    ++	while ((arg = va_arg(hex_args, const char *)))
    ++		strvec_push(&hex_iter.expected_hexes, arg);
    ++	va_end(hex_args);
    ++
    ++	if (!check_int(get_oid_arbitrary_hex(query, &oid), ==, 0))
     +		return;
    -+	oidtree_each(ot, &oid, 40, check_each_cb, expected);
    ++	oidtree_each(ot, &oid, strlen(query), check_each_cb, &hex_iter);
    ++
    ++	if (!check_int(hex_iter.i, ==, hex_iter.expected_hexes.nr))
    ++		test_msg("error: could not find some 'object_id's for query ('%s')", query);
    ++	strvec_clear(&hex_iter.expected_hexes);
     +}
     +
     +static void setup(void (*f)(struct oidtree *ot))
    @@ t/unit-tests/t-oidtree.c (new)
     +
     +static void t_each(struct oidtree *ot)
     +{
    -+	FILL_TREE(ot, "f", "9", "8", "123", "321", "a", "b", "c", "d", "e");
    -+	check_each(ot, "12300", "123");
    -+	check_each(ot, "3211", ""); /* should not reach callback */
    -+	check_each(ot, "3210", "321");
    -+	check_each(ot, "32100", "321");
    ++	FILL_TREE(ot, "f", "9", "8", "123", "321", "320", "a", "b", "c", "d", "e");
    ++	check_each(ot, "12300", "123", NULL);
    ++	check_each(ot, "3211", NULL); /* should not reach callback */
    ++	check_each(ot, "3210", "321", NULL);
    ++	check_each(ot, "32100", "321", NULL);
    ++	check_each(ot, "32", "320", "321", NULL);
     +}
     +
     +int cmd_main(int argc UNUSED, const char **argv UNUSED)

 Makefile                 |   8 ++-
 t/helper/test-oidtree.c  |  54 -----------------
 t/helper/test-tool.c     |   1 -
 t/helper/test-tool.h     |   1 -
 t/t0069-oidtree.sh       |  50 ----------------
 t/unit-tests/lib-oid.c   |  52 +++++++++++++++++
 t/unit-tests/lib-oid.h   |  17 ++++++
 t/unit-tests/t-oidtree.c | 121 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 196 insertions(+), 108 deletions(-)
 delete mode 100644 t/helper/test-oidtree.c
 delete mode 100755 t/t0069-oidtree.sh
 create mode 100644 t/unit-tests/lib-oid.c
 create mode 100644 t/unit-tests/lib-oid.h
 create mode 100644 t/unit-tests/t-oidtree.c

diff --git a/Makefile b/Makefile
index 2f5f16847a..03751e0fc0 100644
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
@@ -1343,6 +1343,7 @@ UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
+UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
@@ -3883,7 +3884,10 @@ $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
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
index 0000000000..80cbab0394
--- /dev/null
+++ b/t/unit-tests/t-oidtree.c
@@ -0,0 +1,121 @@
+#include "test-lib.h"
+#include "lib-oid.h"
+#include "oidtree.h"
+#include "hash.h"
+#include "hex.h"
+#include "strvec.h"
+
+#define FILL_TREE(tree, ...)                                       \
+	do {                                                       \
+		const char *hexes[] = { __VA_ARGS__ };             \
+		if (fill_tree_loc(tree, hexes, ARRAY_SIZE(hexes))) \
+			return;                                    \
+	} while (0)
+
+static int fill_tree_loc(struct oidtree *ot, const char *hexes[], size_t n)
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
+struct expected_hex_iter {
+	size_t i;
+	struct strvec expected_hexes;
+	const char *query;
+};
+
+static enum cb_next check_each_cb(const struct object_id *oid, void *data)
+{
+	struct expected_hex_iter *hex_iter = data;
+	struct object_id expected;
+
+	if (!check_int(hex_iter->i, <, hex_iter->expected_hexes.nr)) {
+		test_msg("error: extraneous callback for query: ('%s'), object_id: ('%s')",
+			 hex_iter->query, oid_to_hex(oid));
+		return CB_BREAK;
+	}
+
+	if (!check_int(get_oid_arbitrary_hex(hex_iter->expected_hexes.v[hex_iter->i],
+					     &expected), ==, 0))
+		; /* the data is bogus and cannot be used */
+	else if (!check(oideq(oid, &expected)))
+		test_msg("expected: %s\n       got: %s\n     query: %s",
+			 oid_to_hex(&expected), oid_to_hex(oid), hex_iter->query);
+
+	hex_iter->i += 1;
+	return CB_CONTINUE;
+}
+
+static void check_each(struct oidtree *ot, char *query, ...)
+{
+	struct object_id oid;
+	struct expected_hex_iter hex_iter = { .expected_hexes = STRVEC_INIT,
+					      .query = query };
+	const char *arg;
+	va_list hex_args;
+
+	va_start(hex_args, query);
+	while ((arg = va_arg(hex_args, const char *)))
+		strvec_push(&hex_iter.expected_hexes, arg);
+	va_end(hex_args);
+
+	if (!check_int(get_oid_arbitrary_hex(query, &oid), ==, 0))
+		return;
+	oidtree_each(ot, &oid, strlen(query), check_each_cb, &hex_iter);
+
+	if (!check_int(hex_iter.i, ==, hex_iter.expected_hexes.nr))
+		test_msg("error: could not find some 'object_id's for query ('%s')", query);
+	strvec_clear(&hex_iter.expected_hexes);
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
+	FILL_TREE(ot, "f", "9", "8", "123", "321", "320", "a", "b", "c", "d", "e");
+	check_each(ot, "12300", "123", NULL);
+	check_each(ot, "3211", NULL); /* should not reach callback */
+	check_each(ot, "3210", "321", NULL);
+	check_each(ot, "32100", "321", NULL);
+	check_each(ot, "32", "320", "321", NULL);
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

