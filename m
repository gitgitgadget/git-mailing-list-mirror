Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11437C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 13:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCHNt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 08:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCHNtW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 08:49:22 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486A37283
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 05:49:12 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t15so15420893wrz.7
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 05:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678283350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuWNRxbLYL/ICmf2/sEpOoJq+U7EQkMObU9K8rzZXc8=;
        b=JgB8jIfPUqsRuPBgR3+71ubvBbWy/3rYk3Hh90uOZdBaYvQD5TilPPwd0t5hHTIL7H
         Fl5WfiuyirRZcmckxE4SuYgFj8TeEarsex8+DGHswjPvW0OoXqoQXbc9Wq9x9jREgGzN
         6Ijx8AtTVQ6AOsVGArcg/m4UihAWTsKVRCgJw60fBtl4G525Me/GkkqGO/EFfrCB+Jiz
         ZYpujnwN6jgMLtqeLnOJt6a0UN1ft3s9L0fJygVry3kulh+a3hKp91C98Sm83pkTehKL
         PJvWKYOrS+/4GgaZWaqmqvrYoxqvY6PhU7dtQQzHuXWv3F7NBdiVgZ0msbItFz7+iKCC
         xLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678283350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuWNRxbLYL/ICmf2/sEpOoJq+U7EQkMObU9K8rzZXc8=;
        b=feGrYR//A5+MAgCowrUXQ+tYtivKlPURphfv3+AXCj+/u7Q2hRZ1wI+4tkPY+Aivf+
         7dtiF6fk2JXn556qsguc37GQFfshhvlH4Ux5S2LZJcLdtP2UQucwelOpiCLEjabI5vKc
         UVZearFqPrVt8sg8XDblWmomeVXXzpvdW2z8E41duGLHyT1uyvxnOwouaCVbNYekcMCy
         Y94yrxJAKAB0NSB6dxlt33rs8vTjA6AqCSB1ruLdJWpcQRCJvD4JXh8IyWa3gZNv9ARW
         0uQtvW+l3NnN88YJqzQIseb0fvP1J0h3z9BHXzzjtsmtojAttiOpD5u7q6617KZLcsKA
         +oyg==
X-Gm-Message-State: AO0yUKVP9+/Z0M14+JoUGRuggjxkYzo5BKIJuhN3YhezTm9+J/33+8Fg
        I6XlWZLjamFwfkuqd3me61bEiLQSmxU=
X-Google-Smtp-Source: AK7set8Pn84uXe6yE1B9Abn3vplHd5+qjOcfeuDJbtMwAu2HqU1wwGFo6jYmaxOM/uJ2mivqUbtsyg==
X-Received: by 2002:adf:ee4c:0:b0:2cd:8237:345b with SMTP id w12-20020adfee4c000000b002cd8237345bmr13596911wro.9.1678283350675;
        Wed, 08 Mar 2023 05:49:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b002c7107ce17fsm15455746wrq.3.2023.03.08.05.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:49:10 -0800 (PST)
Message-Id: <4b231e9beb43e4fac6457b9bf86e4c1db39c4238.1678283349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
From:   "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Mar 2023 13:49:08 +0000
Subject: [PATCH 1/2] builtin/sparse-checkout: remove NEED_WORK_TREE flag
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

