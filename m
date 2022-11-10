Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F494C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 19:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKJTHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 14:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKJTH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 14:07:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E1C45A3B
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a14so3632936wru.5
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUClqX3IKAxBrK0tMJNFZwTqsCoVkCvWIzx7q84PLgM=;
        b=YwH3SQViyrTHOkAIE0Vh37epZmgcui5Dri1h3gXMrzkMV+9tcB7qsAQH6giqFWqAiO
         jp4Ctk+p/QBz/B2hZJTh6voAJe3XNwcZ2kkgfqvo068H4wmbzsHI53DGVQtLEV4IOgBW
         K64WVK8jiOESlDLVAAIsTito5EYxEOVOUFZ/OohS3eujnmRKJi3Ah7MHPBt2wN/I5GAj
         r0yzZTsOVy6wkxa2BquRDFT6XIiq5Ipj1VhOPp5M3OSEyLpb6dR1YHVK2bre2r3yoMfM
         JKZEHmsrFLsF2EsRluNo1XqU7zmRz7vqDyFADigmouLD2LgZn2ydiDUrgg0oPOuzzua/
         sUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUClqX3IKAxBrK0tMJNFZwTqsCoVkCvWIzx7q84PLgM=;
        b=yUtWTtCrpg7tSRF92lQdOSLcXXDIQcLM8IcWD1Do/w32oF0KS/LGN0nfjS/jcHE+9H
         cgGwEVLO/2vUPgtoqoCJ6qNzFBThtBkyH7VmQwkmxHDiHi9qbtyO1+7CXmiKq6h9go1F
         fIKijEy3SBPEtK6Hta6t5t8jbSkOwT7GB70wFd30cUJl5Cuq1RrtnzmMGwcJi0HuUwVl
         yqtM3th2i8jkhAdNTKGIbIy5Pq5lRQad9h9bU423eACWXGVxI7XEKWp+GJ537xb43iwF
         XNqFyupQUogEjGKAVsFggzDcc+BppK5lHImicfKKY4rldDPLnu5Ni8KIZQMO4sfHZEQZ
         paAw==
X-Gm-Message-State: ACrzQf2MoWodb/H3YfFEVNcIggOlEeqCXWy1O6JfjxLBirjwb9Kx+dSH
        lULE3PHXTi/f6LfHbj1batC441gdpXg=
X-Google-Smtp-Source: AMsMyM6gxNzBiOJqvWBxZJXhxdjxgIXX7+lvZ+Re0XF5V6QaWLM0NE3t5yC5hk+cMlQLSpqWzMfNbg==
X-Received: by 2002:a5d:60d1:0:b0:237:46c8:1f6d with SMTP id x17-20020a5d60d1000000b0023746c81f6dmr26938553wrt.232.1668107169086;
        Thu, 10 Nov 2022 11:06:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003b4a68645e9sm6870899wmq.34.2022.11.10.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:06:08 -0800 (PST)
Message-Id: <2b48a6841561c70221343e58251746a052957377.1668107165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
References: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
        <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 19:06:01 +0000
Subject: [PATCH v3 1/5] cache-tree: add perf test comparing update and prime
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        szeder.dev@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
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

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
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
index 00000000000..93051b25f56
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
+	argc = parse_options(argc, argv, NULL, options, test_cache_tree_usage, 0);
+
+	if (read_cache() < 0)
+		die(_("unable to read index file"));
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
+	if (argc != 1)
+		usage_with_options(test_cache_tree_usage, options);
+	else if (!strcmp(argv[0], "prime"))
+		prime_cache_tree(the_repository, &the_index, tree);
+	else if (!strcmp(argv[0], "update"))
+		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
+	/* use "control" subcommand to specify no-op */
+	else if (!!strcmp(argv[0], "control"))
+		die(_("Unhandled subcommand '%s'"), argv[0]);
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

