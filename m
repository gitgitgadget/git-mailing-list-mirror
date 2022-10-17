Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99F4C43217
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 02:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJQCXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJQCXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 22:23:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBF544563
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so9012771wmq.4
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wpn/YUgBa26+xjIpiTP0kqX7J5Xquv2lYGc9NSgjxTs=;
        b=mfgBT3uzNZXQiajoJXDSAmn+FRZeavp/HqQ09k8G3EEbrhz5dWhKazI2koDAXo+AzH
         Uvbbnz7JjUuNf6HuVGgaaFBuN7il2kH+ybCMbavBkZcso8nyJ4Hxzco5HfItf4MRleX9
         vTvICBn7/3AWgtOb3zf3vbtDJKaIiGozkMfUViF33nik7vrYUIfX4bFEgnprLr4MZ2Ha
         1H7WDoApa7aJh/QRDH6d5TQqV2GzlWno2kRnuW3w5TXh5VgA2Uj6kQXH+B0GME6pT87w
         NDR+uRAX0blBZdjfAVFJxHelifVx+nHqqaItKuNH+TNdcDIRHFnvJuiOXuHBAplKB0dv
         n0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wpn/YUgBa26+xjIpiTP0kqX7J5Xquv2lYGc9NSgjxTs=;
        b=eoDi1+8X6MwgQ6kcoYGiSm+e+5stB33uabgLNFDJH1GxKEkeueyEHtEDmdOHPCUuU9
         ZqVffI3WnFhvp6jS6jLpCjprmTbD2C1hbT4HJVExvIKSe+OyyLOqVKcUwbsVPMNWev/g
         5ioW1qiOGf16+cxT4fqjA9Wmd8czUdKmBIUkMjHqJrTXUxIIZiBCYHg0tXCmV5vkK9cB
         vBuJv9Ar71Z+nKgJ6txRcY8ZlS9Aj/WRDtRe73N/TE//Sw7CBm1oOkXRkn5sewUX2gjw
         IbtN//rQLHKNb4crwSfNUJ9VRT/++rkPjJYx1g04+YjOubsAQttTbaKIaVnvb8/Livbg
         1Yng==
X-Gm-Message-State: ACrzQf0cmtYShxhxoLUWPpRALcOXwOtxDh4A+uiUdrhq6gYD6tMaL/Lw
        c/pdNORrkInkRGpkmSylwOQq1xbbxs0=
X-Google-Smtp-Source: AMsMyM63iCoPVlh82VOFRjXvCQeYccHN2ETJrfZW0BCCjfTtaNxkLMb1Gff/J9RPdLUX3pI/+CjZvQ==
X-Received: by 2002:a05:600c:524e:b0:3c6:eb24:c05c with SMTP id fc14-20020a05600c524e00b003c6eb24c05cmr8236403wmb.100.1665973405921;
        Sun, 16 Oct 2022 19:23:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b003c6ee9e254dsm6167316wmo.32.2022.10.16.19.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:23:25 -0700 (PDT)
Message-Id: <9a07c6932f4c7ef844df1fc4f5b6b9feb1810135.1665973401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
From:   "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 02:23:15 +0000
Subject: [PATCH v3 3/9] tree: increase test coverage for tree.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heather Lapointe <alpha@alphaservcomputing.solutions>

This highlights some buggy behavior from read_tree for submodules that
was not being executed.

This introduces a test-tool tree-read-tree-at command
(the complex name is because it is not related to the read-tree command).

Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
---
 Makefile                          |  1 +
 t/helper/test-tool.c              |  1 +
 t/helper/test-tool.h              |  1 +
 t/helper/test-tree-read-tree-at.c | 40 +++++++++++++++++++
 t/t1023-tree-read-tree-at.sh      | 65 +++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+)
 create mode 100644 t/helper/test-tree-read-tree-at.c
 create mode 100755 t/t1023-tree-read-tree-at.sh

diff --git a/Makefile b/Makefile
index 6bfb62cbe94..52d17ca7276 100644
--- a/Makefile
+++ b/Makefile
@@ -788,6 +788,7 @@ TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-submodule.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-trace2.o
+TEST_BUILTINS_OBJS += test-tree-read-tree-at.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-userdiff.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index d1d013bcd92..a8a9bedec5f 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -82,6 +82,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
 	{ "trace2", cmd__trace2 },
+	{ "tree-read-tree-at", cmd__tree_read_tree_at },
 	{ "userdiff", cmd__userdiff },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "xml-encode", cmd__xml_encode },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 6b46b6444b6..409fddfaeb8 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -76,6 +76,7 @@ int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
+int cmd__tree_read_tree_at(int argc, const char **argv);
 int cmd__userdiff(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__xml_encode(int argc, const char **argv);
diff --git a/t/helper/test-tree-read-tree-at.c b/t/helper/test-tree-read-tree-at.c
new file mode 100644
index 00000000000..bba759bb264
--- /dev/null
+++ b/t/helper/test-tree-read-tree-at.c
@@ -0,0 +1,40 @@
+/* This tests tree.c's read_tree / read_tree_at.
+We call it tree-read-tree-at to disambiguate with the read-tree tool.
+*/
+#include "cache.h"
+#include "pathspec.h"
+#include "test-tool.h"
+#include "tree.h"
+
+static int test_handle_entry(const struct object_id *oid,
+		struct strbuf *base, const char *filename,
+		unsigned mode, void *context UNUSED) {
+	printf("%i %s %s%s\n", mode, oid_to_hex(oid), base->buf, filename);
+	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
+		return READ_TREE_RECURSIVE;
+	}
+	return 0;
+}
+
+int cmd__tree_read_tree_at(int argc UNUSED, const char **argv)
+{
+	struct pathspec pathspec;
+	struct tree *tree;
+	struct repository *repo;
+	struct object_id oid;
+
+	setup_git_directory();
+	repo = the_repository;
+	assert(repo);
+
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_FULL,
+		       "", argv);
+
+	assert(repo_get_oid(repo, "HEAD", &oid) == 0);
+	tree = repo_parse_tree_indirect(repo, &oid);
+	assert(tree);
+	pathspec.recurse_submodules = 1;
+	read_tree(repo, tree, &pathspec, test_handle_entry, NULL);
+	return 0;
+}
diff --git a/t/t1023-tree-read-tree-at.sh b/t/t1023-tree-read-tree-at.sh
new file mode 100755
index 00000000000..9e5ce3abb4b
--- /dev/null
+++ b/t/t1023-tree-read-tree-at.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+# tests for tree.c (not read-tree.c)
+test_description='Test read_tree / read_tree_at'
+. ./test-lib.sh
+
+test_expect_success 'read_tree basic' '
+	rm -rf walk_tree_basic &&
+	git init walk_tree_basic &&
+	(
+		cd walk_tree_basic &&
+		set -x &&
+
+		mkdir -p dir1/dirA &&
+		mkdir -p dir1/dirB &&
+		mkdir -p dir2 &&
+		echo "file1" > file1.txt &&
+		echo "file2" > file2.txt &&
+		# uncommitted
+		echo "file3" > file3.txt &&
+
+		echo "file1A1" > dir1/dirA/file1.txt &&
+		git add file1.txt file2.txt dir1/dirA/file1.txt &&
+		git commit -m "initial commit" &&
+
+		test-tool tree-read-tree-at . > walk1.txt &&
+		grep " file1.txt" walk1.txt &&
+		! grep " file3.txt" walk1.txt &&
+		! grep " dir1/dirB" walk1.txt &&
+		grep " dir1/dirA/file1.txt" walk1.txt
+	)
+'
+
+test_expect_success 'read_tree submodules' '
+	rm -rf walk_tree_submodules &&
+	git init submodule1 &&
+	(
+		cd submodule1 &&
+		mkdir -p dir1/dirA &&
+		echo "dir2/sub1/file1.txt" > file1.txt &&
+		echo "dir2/sub1/file1A1.txt" > dir1/dirA/file1.txt &&
+		git add file1.txt dir1/dirA/file1.txt &&
+		git commit -m "initial commit"
+	) &&
+	git init walk_tree_submodules &&
+	(
+		cd walk_tree_submodules &&
+
+		mkdir -p dir2 &&
+		echo "file1" > file1.txt &&
+		echo "dir2/file2" > dir2/file2.txt &&
+		git add file1.txt dir2/file2.txt &&
+		git commit -m "initial commit" &&
+
+		git submodule add ../submodule1 dir2/sub1 &&
+		git commit -m "add submodule1" &&
+
+		test-tool tree-read-tree-at . > walk2.txt &&
+		grep " file1.txt" walk2.txt &&
+		grep " dir2/sub1/file1.txt" walk2.txt &&
+		grep " dir2/sub1/dir1/dirA/file1.txt" walk2.txt
+	)
+'
+
+test_done
-- 
gitgitgadget

