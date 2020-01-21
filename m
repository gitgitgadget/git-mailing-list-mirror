Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227C0C33CB8
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5BC21569
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9FW+o1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAUPB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:01:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52429 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgAUPBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 10:01:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so3295848wmc.2
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 07:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HRhh9nsI1RkER8ktNSUEKKsOyxqCQRUifyulxr+NX3c=;
        b=a9FW+o1LzQekfAitFZBcSyx+PxKVxCkg2SMlqFtgeqyOYDF74sXj/lkAu+gGDz+J5s
         wJ9WM4jF99I1V0zwLwdJq22C+zh9lSY560bnL2+ZzOdlkMGVnyNMY5/HgNSMXq5SXDya
         kgJut2E6XnoA9LBfNaFl3uVoz2q2YRIO7OFONPWjOvv2CFgf4Ek8dwx9mdiLOxVUSERA
         ElPA6jgiQZN1LI5cGKffygng0ctOQ/Xu6QFJys93OFcSw2D4ZS6hrW71unzODer5e8wD
         81t4Nb88vBWpCjgxyWbcAQymP6lwiziTU+aBY1RN55kKPB/NVYFsN8aeeNbIQeX1j7AJ
         UrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HRhh9nsI1RkER8ktNSUEKKsOyxqCQRUifyulxr+NX3c=;
        b=G82H3CSOnQvgTy5L2CBcuJ4AxRB2gd3vmrEFTrKB3YSvNgEkaZiXPS8YbpjLx2qIzH
         e/dmUDSYkvEakmfYrdul4uGbtVDLLt3N7JgQsvKs+QKNdZx6ME0G34wrOQ6y4FWmRCwt
         qI1+WVkUaCUVLnEhlsC/A+LDvp03mTQtDt1QuIYSj1YkNIvNjT8bcPyQcL0zYwhmzKFp
         2uot+jq/dKHXhL7YNJ32AjDWUZLUs9YC6tKwAo4I6VDw8/PNzVJNkaFmywRLgl393rdr
         8hF9vnNpSwO+xY551nMXxOb2p1ohhPkuYKL5gaLpdyZbdWBaxPb+nlGS7Alg53De28P2
         GdZw==
X-Gm-Message-State: APjAAAXtTBBdUTpksfzU4AvRjQDHnl+XKf9ibzOOm9nzTyGG8PM7ER9+
        e8vFlMII1egmF9KjJCU6kDS4rNC9
X-Google-Smtp-Source: APXvYqxYQJNVSWDWgRb8UpXwkW1QiTXMEjIx1wigP8LY+GinrPTD1v/Lu1dNRB9IWsUyHmQaaMUxtw==
X-Received: by 2002:a1c:988e:: with SMTP id a136mr4865493wme.181.1579618882819;
        Tue, 21 Jan 2020 07:01:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm53377303wra.83.2020.01.21.07.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 07:01:21 -0800 (PST)
Message-Id: <614bccd31b8edb6cf7c0ae53b70680e0a18bdd7e.1579618877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
        <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 15:01:17 +0000
Subject: [PATCH v2 4/4] submodule.c: use get_git_dir() instead of
 get_git_common_dir()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Ever since df56607dff (git-common-dir: make "modules/"
per-working-directory directory, 2014-11-30), submodules in linked worktrees
are cloned to $GIT_DIR/modules, i.e. $GIT_COMMON_DIR/worktrees/<name>/modules.

However, this convention was not followed when the worktree updater commands
checkout, reset and read-tree learned to recurse into submodules. Specifically,
submodule.c::submodule_move_head, introduced in 6e3c1595c6 (update submodules:
add submodule_move_head, 2017-03-14) and submodule.c::submodule_unset_core_worktree,
(re)introduced in 898c2e65b7 (submodule: unset core.worktree if no working tree
is present, 2018-12-14) use get_git_common_dir() instead of get_git_dir()
to get the path of the submodule repository.

This means that, for example, 'git checkout --recurse-submodules <branch>'
in a linked worktree will correctly checkout <branch>, detach the submodule's HEAD
at the commit recorded in <branch> and update the submodule working tree, but the
submodule HEAD that will be moved is the one in $GIT_COMMON_DIR/modules/<name>/,
i.e. the submodule repository of the main superproject working tree.
It will also rewrite the gitfile in the submodule working tree of the linked worktree
to point to $GIT_COMMON_DIR/modules/<name>/.
This leads to an incorrect (and confusing!) state in the submodule working tree
of the main superproject worktree.

Additionally, if switching to a commit where the submodule is not present,
submodule_unset_core_worktree will be called and will incorrectly remove
'core.wortree' from the config file of the submodule in the main superproject worktree,
$GIT_COMMON_DIR/modules/<name>/config.

Fix this by constructing the path to the submodule repository using get_git_dir()
in both submodule_move_head and submodule_unset_core_worktree.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 submodule.c                   |  6 +++---
 t/t2405-worktree-submodule.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 9da7181321..5d19ec48a6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1811,7 +1811,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 void submodule_unset_core_worktree(const struct submodule *sub)
 {
 	char *config_path = xstrfmt("%s/modules/%s/config",
-				    get_git_common_dir(), sub->name);
+				    get_git_dir(), sub->name);
 
 	if (git_config_set_in_file_gently(config_path, "core.worktree", NULL))
 		warning(_("Could not unset core.worktree setting in submodule '%s'"),
@@ -1914,7 +1914,7 @@ int submodule_move_head(const char *path,
 					ABSORB_GITDIR_RECURSE_SUBMODULES);
 		} else {
 			char *gitdir = xstrfmt("%s/modules/%s",
-				    get_git_common_dir(), sub->name);
+				    get_git_dir(), sub->name);
 			connect_work_tree_and_git_dir(path, gitdir, 0);
 			free(gitdir);
 
@@ -1924,7 +1924,7 @@ int submodule_move_head(const char *path,
 
 		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
 			char *gitdir = xstrfmt("%s/modules/%s",
-				    get_git_common_dir(), sub->name);
+				    get_git_dir(), sub->name);
 			connect_work_tree_and_git_dir(path, gitdir, 1);
 			free(gitdir);
 		}
diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index d0830058fd..e1b2bfd87e 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -10,6 +10,7 @@ test_expect_success 'setup: create origin repos'  '
 	git init origin/sub &&
 	test_commit -C origin/sub file1 &&
 	git init origin/main &&
+	test_commit -C origin/main first &&
 	git -C origin/main submodule add ../sub &&
 	git -C origin/main commit -m "add sub" &&
 	test_commit -C origin/sub "file1 updated" file1 file1updated file1updated &&
@@ -54,4 +55,36 @@ test_expect_success 'submodule is checked out after manually adding submodule wo
 	grep "file1 updated" out
 '
 
+test_expect_success 'checkout --recurse-submodules uses $GIT_DIR for submodules in a linked worktree' '
+	git -C main worktree add "$base_path/checkout-recurse" --detach  &&
+	git -C checkout-recurse submodule update --init &&
+	echo "gitdir: ../../main/.git/worktrees/checkout-recurse/modules/sub" >expect-gitfile &&
+	cat checkout-recurse/sub/.git >actual-gitfile &&
+	test_cmp expect-gitfile actual-gitfile &&
+	git -C main/sub rev-parse HEAD >expect-head-main &&
+	git -C checkout-recurse checkout --recurse-submodules HEAD~1 &&
+	cat checkout-recurse/sub/.git >actual-gitfile &&
+	git -C main/sub rev-parse HEAD >actual-head-main &&
+	test_cmp expect-gitfile actual-gitfile &&
+	test_cmp expect-head-main actual-head-main
+'
+
+test_expect_success 'core.worktree is removed in $GIT_DIR/modules/<name>/config, not in $GIT_COMMON_DIR/modules/<name>/config' '
+	echo "../../../sub" >expect-main &&
+	git -C main/sub config --get core.worktree >actual-main &&
+	test_cmp expect-main actual-main &&
+	echo "../../../../../../checkout-recurse/sub" >expect-linked &&
+	git -C checkout-recurse/sub config --get core.worktree >actual-linked &&
+	test_cmp expect-linked actual-linked &&
+	git -C checkout-recurse checkout --recurse-submodules first &&
+	test_expect_code 1 git -C main/.git/worktrees/checkout-recurse/modules/sub config --get core.worktree >linked-config &&
+	test_must_be_empty linked-config &&
+	git -C main/sub config --get core.worktree >actual-main &&
+	test_cmp expect-main actual-main
+'
+
+test_expect_success 'unsetting core.worktree does not prevent running commands directly against the submodule repository' '
+	git -C main/.git/worktrees/checkout-recurse/modules/sub log
+'
+
 test_done
-- 
gitgitgadget
