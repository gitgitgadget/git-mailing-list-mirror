Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E75C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D44961BFA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhKQBAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKQBAK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 20:00:10 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3B9C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:12 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w7-20020aa78587000000b004a28bb92381so614899pfn.22
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rSinrMgceDslMqmJ+qn19OGG4hWxi78pYt4JlcuHWfE=;
        b=Z3+wndM3sBdGVWtyvN5MglRMV9feBXzSRWCG0/68SDiLB7yMYgAa8UDOv2gtB53TVi
         Lhh6NYAZlz7MkXcMZHlqklJ2T6BUZfwxlmYlEsqHPitk0Brd4rX84G9wSXnLsuoEypH5
         /Bac20bLnz+c4wuOG0++i+83K1o3K8/vbl6lLpIB9khKEvMx/28gXst+9yEcuGvv6BWL
         7NpvGX6tdLzbwXjWwD5sw46BnmNmahL/NsPjPHlLMnkCiL5KYR2gEBCH31XplCM0uANC
         mP2lkDBownaJkX3GwaeGOMlvmQe+p5M2gMw1o3qYWZwJQF4yk/8g0gPQxoYTOT0cM0/K
         8cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rSinrMgceDslMqmJ+qn19OGG4hWxi78pYt4JlcuHWfE=;
        b=fCybcE+JaVawT3ufgi7efuqBc7Qa4fiv2ZN7bsjdaR4c/zdVhT5t70dY1R23pSzY5O
         IUmRe1HUUTR/nE/B+wdF2D8X4S69dxzYKej/MdNjGbcFagt1WxVep0RFLvBWvcMn5Are
         FiDyNQzBcI1qSBVQx2AjMnXKb3nFm9Wq90lGaKQuqGg3tv738SMCJ4HVR6SdxNSc2QPU
         LI30D1og9xgb/S2ecZCYaGIJSVBOP7peJhHbUBnjkCavw8az/NBSMzANa8x76aq7CVau
         ucGhYAPSX8TCc+RFiT9yp0fdlqQS2Gv81oa1ljzQWypYzg32F3NMqxLv7W6ve6sQSCd8
         5XvQ==
X-Gm-Message-State: AOAM5321qpwze7mDwOkeB42OdALTDE67jM4wWCaLvOJz3KnITJWeoIza
        rFzO7yuoFqa+gRMPYagIYIWC4y9MhCYjINPsn7vNSpMYOolpf3eBgdSAIIC8VYxS6hJUoZm4uVJ
        XF203KUUUlynA0l2CVXuZ/89dCb9jfAeiMF82fG9IOqCdgbs/fJKNEeyeOw2j9bZBoHUPPoYh1A
        ==
X-Google-Smtp-Source: ABdhPJyUDtApRb6ZQUx+mJXv+ohkIVXc1h0uoqBvxxyeiKfUY8VtdkDxOmTeFooc06vyUqInCvEDb0SrCtjzLa35TNg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:205d:7edd:a3da:3608])
 (user=emilyshaffer job=sendgmr) by 2002:a17:90b:1b4b:: with SMTP id
 nv11mr4348277pjb.131.1637110632346; Tue, 16 Nov 2021 16:57:12 -0800 (PST)
Date:   Tue, 16 Nov 2021 16:56:59 -0800
In-Reply-To: <20211117005701.371808-1-emilyshaffer@google.com>
Message-Id: <20211117005701.371808-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211117005701.371808-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v6 3/5] submodule: record superproject gitdir during absorbgitdirs
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Already during 'git submodule add' we record a pointer to the
superproject's gitdir. However, this doesn't help brand-new
submodules created with 'git init' and later absorbed with 'git
submodule absorbgitdirs'. Let's start adding that pointer during 'git
submodule absorbgitdirs' too.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 submodule.c                        | 23 +++++++++
 t/t7412-submodule-absorbgitdirs.sh | 82 +++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index c689070524..d7395c7551 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2097,6 +2097,9 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
 	const struct submodule *sub;
+	struct config_set sub_cs;
+	struct strbuf config_path = STRBUF_INIT, sb = STRBUF_INIT;
+	int tmp;
 
 	if (submodule_uses_worktrees(path))
 		die(_("relocate_gitdir for submodule '%s' with "
@@ -2127,6 +2130,26 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
 
+	/*
+	 * Note location of superproject's gitdir. Because the submodule already
+	 * has a gitdir and local config, we can store this pointer from
+	 * worktree config to worktree config, if the submodule has
+	 * extensions.worktreeConfig set.
+	 */
+	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
+	git_configset_init(&sub_cs);
+	git_configset_add_file(&sub_cs, config_path.buf);
+	/* return 0 indicates config was found - we have a worktree config */
+	if (!git_configset_get_bool(&sub_cs, "extensions.worktreeConfig", &tmp))
+		strbuf_addstr(&config_path, ".worktree");
+
+	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
+			       relative_path(absolute_path(get_git_dir()),
+					     real_new_git_dir, &sb));
+
+	git_configset_clear(&sub_cs);
+	strbuf_release(&config_path);
+	strbuf_release(&sb);
 	free(old_git_dir);
 	free(real_old_git_dir);
 	free(real_new_git_dir);
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 1cfa150768..5753f90268 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -30,7 +30,17 @@ test_expect_success 'absorb the git dir' '
 	git status >actual.1 &&
 	git -C sub1 rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	# make sure the submodule cached the superproject gitdir correctly
+	submodule_gitdir="$(git -C sub1 rev-parse --path-format=absolute --git-common-dir)" &&
+	superproject_gitdir="$(git rev-parse --path-format=absolute --git-common-dir)" &&
+
+	test-tool path-utils relative_path "$superproject_gitdir" \
+		"$submodule_gitdir" >expect &&
+	git -C sub1 config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual
 '
 
 test_expect_success 'absorbing does not fail for deinitialized submodules' '
@@ -61,7 +71,16 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	sub1_gitdir="$(git -C sub1 rev-parse --path-format=absolute --git-common-dir)" &&
+	sub1_nested_gitdir="$(git -C sub1/nested rev-parse --path-format=absolute --git-common-dir)" &&
+
+	test-tool path-utils relative_path "$sub1_gitdir" "$sub1_nested_gitdir" \
+		>expect &&
+	git -C sub1/nested config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual
 '
 
 test_expect_success 're-setup nested submodule' '
@@ -130,4 +149,63 @@ test_expect_success 'absorbing fails for a submodule with multiple worktrees' '
 	test_i18ngrep "not supported" error
 '
 
+test_expect_success 'absorbgitdirs works when called from a superproject worktree' '
+	# set up a worktree of the superproject
+	git worktree add wt &&
+	(
+	cd wt &&
+
+	# create a new unembedded git dir
+	git init sub4 &&
+	test_commit -C sub4 first &&
+	git submodule add ./sub4 &&
+	test_tick &&
+
+	# absorb the git dir
+	git submodule absorbgitdirs sub4 &&
+
+	# make sure the submodule noted the superproject gitdir correctly
+	submodule_gitdir="$(git -C sub4 rev-parse --absolute-git-dir)" &&
+	superproject_gitdir="$(git rev-parse --absolute-git-dir)" &&
+
+	test-tool path-utils relative_path "$superproject_gitdir" \
+		"$submodule_gitdir" >expect &&
+	git -C sub4 config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'absorbgitdirs works with a submodule with worktree config' '
+	# reuse the worktree of the superproject
+	(
+	cd wt &&
+
+	# create a new unembedded git dir
+	git init sub5 &&
+	test_commit -C sub5 first &&
+	git submodule add ./sub5 &&
+	test_tick &&
+
+	# turn on worktree configs for submodule
+	git -C sub5 config extensions.worktreeConfig true &&
+
+	# absorb the git dir
+	git submodule absorbgitdirs sub5 &&
+
+	# make sure the submodule noted the superproject gitdir correctly
+	submodule_gitdir="$(git -C sub5 rev-parse --absolute-git-dir)" &&
+	superproject_gitdir="$(git rev-parse --absolute-git-dir)" &&
+
+	test-tool path-utils relative_path "$superproject_gitdir" \
+		"$submodule_gitdir" >expect &&
+	git -C sub5 config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual &&
+
+	# make sure the config went into the submodule config.worktree
+	test_file_not_empty "$submodule_gitdir/config.worktree"
+	)
+'
+
 test_done
-- 
2.34.0.rc1.387.gb447b232ab-goog

