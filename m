Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1920DC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 01:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiKJB6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 20:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiKJB5u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 20:57:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB7F2DAA4
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 17:57:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a14so320876wru.5
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 17:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAYMusBKLV09FtvzEd0S4SeLiMFksBaCYaRVdFfaGk4=;
        b=L5He0z0UFvp2Wyj84gO0/3vW2+6DZFVoXcJPNmpxm3EdKecvlaLi1zltpiDWKFnH97
         D/WFAAfgtlCjn4Fq0rN56oQTmW/yiZ10dSX4uPK8DCFCpJk9c1tWtv24CCaSJ5cGp/eV
         22fcs8mc5YtJIEkY7grZrKmnwI4LcvABijFHEgIJF6RpFClyNFbMzlXfEJM8E6idh54V
         8h6c73uoyrd7FWY/3zuZYSFQRYR7ooXloMAJnBIXv4VWt82rmKwO9HI3e2rOfKv7XpNj
         3UexgD5PlA1JfHx7cuqsjO9dHFRS9Xz+ZAzQ3jvJfnaTiUAXE5JHkJQOGFjlnVJibBAP
         an4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAYMusBKLV09FtvzEd0S4SeLiMFksBaCYaRVdFfaGk4=;
        b=BLcaIoPpKqKGRG7DMujPp8Qr897de/UzJ4Psa5DDLG9K9F8SzXk0dKR90n+zjSRp0s
         x+Q0qCOl34kLiXiPpYTPxdVAojcr8OLL1leweIFtBCVQXr1mAuG9+f3NgQxwqiINKCs/
         tpuPCgrHQbSUdfdrIzmpp3qIeQyqRe6PK9TRFQrHyzyMDpNCMg09CsoStQCOxlRhOx96
         69ryWsu7QSbQUUj72bo9LS+WzwiPnm0VQxXdEtpr+1ID+Ne/A1mEOV2aLZK55DuXNL9P
         CxciRs4xlP53AAyNGqTPp/zNxSApJDgvEVOPEsbp7RPkrNsMCXWTtik1QdozsK4d+Q4O
         MotA==
X-Gm-Message-State: ACrzQf3rRkzBOZAbRt86AFED/CPXBbZfMh8PSVn/tZg/kgCwMP+gW0ti
        TcZ6nn7wKs6giD2Bmjqt13f4VH9++04=
X-Google-Smtp-Source: AMsMyM6GPJ7NK0h+tBzkDWo8wOEKglh1GEBEaMp8Ai8dhX5f7SsNYaZ96POc4O1vP+2WSP8PkkygFQ==
X-Received: by 2002:a05:6000:22e:b0:236:6e38:4d9b with SMTP id l14-20020a056000022e00b002366e384d9bmr41486211wrz.4.1668045440785;
        Wed, 09 Nov 2022 17:57:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12-20020adfeb0c000000b0023657e1b980sm14528390wrn.53.2022.11.09.17.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 17:57:20 -0800 (PST)
Message-Id: <833519d87c843eb8147a45b1ec2c1fd3f3c21905.1668045438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
        <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 01:57:13 +0000
Subject: [PATCH v2 1/5] cache-tree: add perf test comparing update and prime
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a performance test comparing the execution times of 'prime_cache_tree()'
and 'cache_tree_update(_, WRITE_TREE_SILENT | WRITE_TREE_REPAIR)'. The goal
of comparing these two is to identify which is the faster method for
rebuilding an invalid cache tree, ultimately to remove one when both are
(reundantly) called in immediate succession.

Both methods are fast, so the new tests in 'p0090-cache-tree.sh' must call
each tested function multiple times to ensure the reported times (to 0.01s
resolution) convey the differences between them.

The tests compare the timing of a 'test-tool cache-tree' run as a no-op (to
capture a baseline for the overhead associated with running the tool),
'cache_tree_update()', and 'prime_cache_tree()' on four scenarios:

- A completely valid cache tree
- A cache tree with 2 invalid paths
- A cache tree with 50 invalid paths
- A completely empty cache tree

Example results:

Test                                        this tree
-----------------------------------------------------------
0090.2: no-op, clean                        1.27(0.48+0.52)
0090.3: prime_cache_tree, clean             2.02(0.83+0.85)
0090.4: cache_tree_update, clean            1.30(0.49+0.54)
0090.5: no-op, invalidate 2                 1.29(0.48+0.54)
0090.6: prime_cache_tree, invalidate 2      1.98(0.81+0.83)
0090.7: cache_tree_update, invalidate 2     2.12(0.94+0.86)
0090.8: no-op, invalidate 50                1.32(0.50+0.55)
0090.9: prime_cache_tree, invalidate 50     2.10(0.86+0.89)
0090.10: cache_tree_update, invalidate 50   2.35(1.14+0.90)
0090.11: no-op, empty                       1.33(0.50+0.54)
0090.12: prime_cache_tree, empty            2.04(0.84+0.87)
0090.13: cache_tree_update, empty           2.51(1.27+0.92)

These timings show that, while 'cache_tree_update()' is faster when the
cache tree is completely valid, it is equal to or slower than
'prime_cache_tree()' when there are any invalid paths. Since the redundant
calls are mostly in scenarios where the cache tree will be at least
partially invalid (e.g., 'git reset --hard'), 'prime_cache_tree()' will
likely perform better than 'cache_tree_update()' in typical cases.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Makefile                   |  1 +
 t/helper/test-cache-tree.c | 64 ++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c       |  1 +
 t/helper/test-tool.h       |  1 +
 t/perf/p0090-cache-tree.sh | 36 +++++++++++++++++++++
 5 files changed, 103 insertions(+)
 create mode 100644 t/helper/test-cache-tree.c
 create mode 100755 t/perf/p0090-cache-tree.sh

diff --git a/Makefile b/Makefile
index 4927379184c..3639c7c2a94 100644
--- a/Makefile
+++ b/Makefile
@@ -723,6 +723,7 @@ TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-bitmap.o
 TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-bundle-uri.o
+TEST_BUILTINS_OBJS += test-cache-tree.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
new file mode 100644
index 00000000000..8d06039fb5c
--- /dev/null
+++ b/t/helper/test-cache-tree.c
@@ -0,0 +1,64 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "tree.h"
+#include "cache-tree.h"
+#include "parse-options.h"
+
+static char const * const test_cache_tree_usage[] = {
+	N_("test-tool cache-tree <options> (control|prime|update)"),
+	NULL
+};
+
+int cmd__cache_tree(int argc, const char **argv)
+{
+	struct object_id oid;
+	struct tree *tree;
+	int empty = 0;
+	int invalidate_qty = 0;
+	int i;
+
+	struct option options[] = {
+		OPT_BOOL(0, "empty", &empty,
+			 N_("clear the cache tree before each iteration")),
+		OPT_INTEGER_F(0, "invalidate", &invalidate_qty,
+			      N_("number of entries in the cache tree to invalidate (default 0)"),
+			      PARSE_OPT_NONEG),
+		OPT_END()
+	};
+
+	setup_git_directory();
+
+	parse_options(argc, argv, NULL, options, test_cache_tree_usage, 0);
+
+	if (read_cache() < 0)
+		die("unable to read index file");
+
+	oidcpy(&oid, &the_index.cache_tree->oid);
+	tree = parse_tree_indirect(&oid);
+	if (!tree)
+		die(_("not a tree object: %s"), oid_to_hex(&oid));
+
+	if (empty) {
+		/* clear the cache tree & allocate a new one */
+		cache_tree_free(&the_index.cache_tree);
+		the_index.cache_tree = cache_tree();
+	} else if (invalidate_qty) {
+		/* invalidate the specified number of unique paths */
+		float f_interval = (float)the_index.cache_nr / invalidate_qty;
+		int interval = f_interval < 1.0 ? 1 : (int)f_interval;
+		for (i = 0; i < invalidate_qty && i * interval < the_index.cache_nr; i++)
+			cache_tree_invalidate_path(&the_index, the_index.cache[i * interval]->name);
+	}
+
+	if (!argc)
+		die("Must specify subcommand");
+	else if (!strcmp(argv[0], "prime"))
+		prime_cache_tree(the_repository, &the_index, tree);
+	else if (!strcmp(argv[0], "update"))
+		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
+	/* use "control" subcommand to specify no-op */
+	else if (!!strcmp(argv[0], "control"))
+		die("Unknown command %s", argv[0]);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 01cda9358df..547a3be1c8b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -14,6 +14,7 @@ static struct test_cmd cmds[] = {
 	{ "bitmap", cmd__bitmap },
 	{ "bloom", cmd__bloom },
 	{ "bundle-uri", cmd__bundle_uri },
+	{ "cache-tree", cmd__cache_tree },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
 	{ "crontab", cmd__crontab },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ca2948066fd..e44e1d896d3 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -8,6 +8,7 @@ int cmd__advise_if_enabled(int argc, const char **argv);
 int cmd__bitmap(int argc, const char **argv);
 int cmd__bloom(int argc, const char **argv);
 int cmd__bundle_uri(int argc, const char **argv);
+int cmd__cache_tree(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__crontab(int argc, const char **argv);
diff --git a/t/perf/p0090-cache-tree.sh b/t/perf/p0090-cache-tree.sh
new file mode 100755
index 00000000000..a8eabca2c4d
--- /dev/null
+++ b/t/perf/p0090-cache-tree.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description="Tests performance of cache tree update operations"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+count=100
+
+test_expect_success 'setup cache tree' '
+	git write-tree
+'
+
+test_cache_tree () {
+	test_perf "$1, $3" "
+		for i in \$(test_seq $count)
+		do
+			test-tool cache-tree $4 $2
+		done
+	"
+}
+
+test_cache_tree_update_functions () {
+	test_cache_tree 'no-op' 'control' "$1" "$2"
+	test_cache_tree 'prime_cache_tree' 'prime' "$1" "$2"
+	test_cache_tree 'cache_tree_update' 'update' "$1" "$2"
+}
+
+test_cache_tree_update_functions "clean" ""
+test_cache_tree_update_functions "invalidate 2" "--invalidate 2"
+test_cache_tree_update_functions "invalidate 50" "--invalidate 50"
+test_cache_tree_update_functions "empty" "--empty"
+
+test_done
-- 
gitgitgadget

