Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB237C76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 07:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjC0HzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjC0HzI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 03:55:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7EB10F1
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 00:55:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so4541287wmq.3
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679903705;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuWNRxbLYL/ICmf2/sEpOoJq+U7EQkMObU9K8rzZXc8=;
        b=gGjHpDopdixXOT16kkshqxja5hTZ20ZnR0IAlBvLYKC0/BoyLqVg1b+GlmsoqJuXNZ
         25v2rkKTYddXN4GVTAZ92FJRMDZ1H9Qmd3o1D/D/wv7lhq7YCHMzBeA/6WpW7T3ncVew
         dEbqWIFw4if0LF08J97GtT+I7FbwJH9uPejldAaGFAXWtdLYuGjg0BRdhXOcdioj5Dge
         TTYH9kzwW/eTTr0uXg27wf01WnzZuGzaYGI5pnLCYkaAzF5zYHjN92+fL5HXkGa4XF1p
         HFjq+1DK2ifc1xu9nEpk+1v7IX6I3UzYdzdwlt0/w3/2gnH1L6t+06fCe/gvUv0K61N6
         iW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679903705;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuWNRxbLYL/ICmf2/sEpOoJq+U7EQkMObU9K8rzZXc8=;
        b=wff9BUdT8jPr5O2GYf+0gHF5Wi4u6Y/c8nAHs+XI+QNbdJp4b19Uqvr3UOO67seqXd
         d2sQBeNbQ+LVEk2wACbbtSeuCr1IX91Q9YLPS72A+RyuVW3c6rPZGj2eXfdMMwvnWfU2
         qQUrJL5FkE/ySQuVpwddr121aHCxlh7RH7eZuApnqEJ2NKVpKLXBIoizI881YzYiSBTn
         ipdWHwgmdeZUg/tqmknI80EZu5RxYJwm8aRRwFqfuLyYSpgSwbGTTxcYTa7zSfQhqYKw
         FP5HLvpHR2fOuXh4iaAIvYn+LSxBJPuRK+CnYcar5+NmU++UJWYIpSxaWSKKndfXs79y
         bUjA==
X-Gm-Message-State: AO0yUKXI3AB8tQ8p12LXLv8UQN/ns95kP9CGa90ZhDm9xSBCzhMJNDTk
        glML4pCHfSxirh21rFW2sOj9cQWTkk4=
X-Google-Smtp-Source: AK7set8i3gkgJbHpYUMcyRSOdFy1tVcrYjTA+gwbxATnjtu4RDiry2RF9OcDTA6wivDgOWy9q7ZBXw==
X-Received: by 2002:a05:600c:3595:b0:3ee:f91:19aa with SMTP id p21-20020a05600c359500b003ee0f9119aamr10793040wmq.0.1679903705026;
        Mon, 27 Mar 2023 00:55:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b003ee6aa4e6a9sm7917647wmp.5.2023.03.27.00.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 00:55:04 -0700 (PDT)
Message-Id: <4b231e9beb43e4fac6457b9bf86e4c1db39c4238.1679903703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1488.v2.git.1679903703.gitgitgadget@gmail.com>
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
        <pull.1488.v2.git.1679903703.gitgitgadget@gmail.com>
From:   "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Mar 2023 07:55:02 +0000
Subject: [PATCH v2 1/2] builtin/sparse-checkout: remove NEED_WORK_TREE flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>,
        William Sprent <williams@unity3d.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Sprent <williams@unity3d.com>

In preparation for adding a sub-command to 'sparse-checkout' that can be
run in a bare repository, remove the 'NEED_WORK_TREE' flag from its
entry in the 'commands' array of 'git.c'.

To avoid that this changes any behaviour, add calls to
'setup_work_tree()' to all of the 'sparse-checkout' sub-commands and add
tests that verify that 'sparse-checkout <cmd>' still fail with a clear
error message telling the user that the command needs a work tree.

Signed-off-by: William Sprent <williams@unity3d.com>
---
 builtin/sparse-checkout.c          |  6 ++++++
 git.c                              |  2 +-
 t/t1091-sparse-checkout-builtin.sh | 33 ++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index c3738154918..5fdc3d9aab5 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -57,6 +57,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 	char *sparse_filename;
 	int res;
 
+	setup_work_tree();
 	if (!core_apply_sparse_checkout)
 		die(_("this worktree is not sparse"));
 
@@ -448,6 +449,7 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	setup_work_tree();
 	repo_read_index(the_repository);
 
 	init_opts.cone_mode = -1;
@@ -760,6 +762,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	setup_work_tree();
 	if (!core_apply_sparse_checkout)
 		die(_("no sparse-checkout to add to"));
 
@@ -806,6 +809,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	setup_work_tree();
 	repo_read_index(the_repository);
 
 	set_opts.cone_mode = -1;
@@ -855,6 +859,7 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 		OPT_END(),
 	};
 
+	setup_work_tree();
 	if (!core_apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
@@ -898,6 +903,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	 * forcibly return to a dense checkout regardless of initial state.
 	 */
 
+	setup_work_tree();
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_disable_options,
 			     builtin_sparse_checkout_disable_usage, 0);
diff --git a/git.c b/git.c
index 6171fd6769d..5adc835cf10 100644
--- a/git.c
+++ b/git.c
@@ -583,7 +583,7 @@ static struct cmd_struct commands[] = {
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-index", cmd_show_index, RUN_SETUP_GENTLY },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
-	{ "sparse-checkout", cmd_sparse_checkout, RUN_SETUP | NEED_WORK_TREE },
+	{ "sparse-checkout", cmd_sparse_checkout, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 627267be153..7216267aec7 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -882,4 +882,37 @@ test_expect_success 'by default, non-cone mode will warn on individual files' '
 	grep "pass a leading slash before paths.*if you want a single file" warning
 '
 
+test_expect_success 'setup bare repo' '
+	git clone --bare "file://$(pwd)/repo" bare
+'
+test_expect_success 'list fails outside work tree' '
+	test_must_fail git -C bare sparse-checkout list 2>err &&
+	test_i18ngrep "this operation must be run in a work tree" err
+'
+
+test_expect_success 'add fails outside work tree' '
+	test_must_fail git -C bare sparse-checkout add deeper 2>err &&
+	test_i18ngrep "this operation must be run in a work tree" err
+'
+
+test_expect_success 'set fails outside work tree' '
+	test_must_fail git -C bare sparse-checkout set deeper 2>err &&
+	test_i18ngrep "this operation must be run in a work tree" err
+'
+
+test_expect_success 'init fails outside work tree' '
+	test_must_fail git -C bare sparse-checkout init 2>err &&
+	test_i18ngrep "this operation must be run in a work tree" err
+'
+
+test_expect_success 'reapply fails outside work tree' '
+	test_must_fail git -C bare sparse-checkout reapply 2>err &&
+	test_i18ngrep "this operation must be run in a work tree" err
+'
+
+test_expect_success 'disable fails outside work tree' '
+	test_must_fail git -C bare sparse-checkout disable 2>err &&
+	test_i18ngrep "this operation must be run in a work tree" err
+'
+
 test_done
-- 
gitgitgadget

