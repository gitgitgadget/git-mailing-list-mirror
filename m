Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B32C77B75
	for <git@archiver.kernel.org>; Tue, 23 May 2023 23:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbjEWXR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 19:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjEWXR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 19:17:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6E6E5
        for <git@vger.kernel.org>; Tue, 23 May 2023 16:17:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30957dd7640so49302f8f.3
        for <git@vger.kernel.org>; Tue, 23 May 2023 16:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684883875; x=1687475875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs7p0Nag3jIiOU4LLHI6E7XSTdiOeb9XVB0S30Xsu+w=;
        b=SbkpCmRbDn3hCdmaNqgDAJXA/aOLJ1eJjfVafyqRDapDSZBnU/JzLHTI58SGBJTS2V
         4CBijoqoPkJMfqVlvqnlUQE6+KzqncKiYPe1gX02uTSGu5lR1c1qI+GTB8VMzcRbM1ev
         ifGuZGpATkgqd7+RfPey1r5ekiaI3XbNP4dckZc9tYe7r1+y3c3u765ZgqWAYkFa7gXE
         bH1lpRYOxf74F3RFYJVcS6dLfdQzsUTKoRia/ojMZmxlxKljbp0zt1YYjxG2S7Yh0OR9
         4Mnb3kjqUD12T5XbM++3b1LjmNCipG0zC+++znyLUrdjVjyGNy2LLcZB8zfdlhL19ytl
         vIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684883875; x=1687475875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs7p0Nag3jIiOU4LLHI6E7XSTdiOeb9XVB0S30Xsu+w=;
        b=CE75Ypp/7iYEO8ytc1QAIS/WqWu02rBiOxDlDPgbEPeiOtYZn7LYO1ehcCG5AQ4uZF
         rJfSBhMKfiY5rtBchOlqMdGeepeaBxPjGwjDy2LE8IUhjdh6dEEHOrSUlSTNB/LL5E2e
         tAfE5HwDRTWgfEVmjTDmv1dNr5D9mTdz24Kfl8crrQU2WulOApYP3XhfwOp+8RLxB2c+
         z2orNJxPkgDcwiX1bS3PkhwUeHhSr+ND29ReuksNY/6lZvGCXVdxtsTFq9AmcfhxzKQ8
         o9U9TTfbizc/igp6C7TuZAccEPeAR29Uat3/OQrsRMbeMItQSl2UCgws6T9ZrkR/Zdwh
         7mBA==
X-Gm-Message-State: AC+VfDyBRZfNLgnQA9MfnRm3lx0vNSOFtFV5uuGI1BVoVYVSOyn9pH6H
        fIA7rdGVtnOr9B7tsO/XicFMQ6V6reA=
X-Google-Smtp-Source: ACHHUZ7KBvdJzCI68HWmYhnAmI1o9cV/h37D/Ba29rquhZwDSDG6Cvg6JrhmYL7t05qkdcWY2Hs9lg==
X-Received: by 2002:a5d:49cd:0:b0:309:507a:3f5b with SMTP id t13-20020a5d49cd000000b00309507a3f5bmr10956521wrs.8.1684883874558;
        Tue, 23 May 2023 16:17:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003f423dfc686sm259498wmc.45.2023.05.23.16.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 16:17:54 -0700 (PDT)
Message-Id: <aead2fe1ce162949fb313a92fe960e5a64512f60.1684883872.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 May 2023 23:17:51 +0000
Subject: [PATCH 1/2] config: use gitdir to get worktree config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, chooglen@google.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update 'do_git_config_sequence()' to read the worktree config from
'config.worktree' in 'opts->git_dir' rather than the gitdir of
'the_repository'.

The worktree config is loaded from the path returned by
'git_pathdup("config.worktree")', the 'config.worktree' relative to the
gitdir of 'the_repository'. If loading the config for a submodule, this path
is incorrect, since 'the_repository' is the super project. Conversely,
'opts->git_dir' is the gitdir of the submodule being configured, so the
config file in that location should be read instead.

To ensure the use of 'opts->git_dir' is safe, require that 'opts->git_dir'
is set if-and-only-if 'opts->commondir' is set (rather than "only-if" as it
is now). In all current usage of 'config_options', these values are set
together, so the stricter check does not change any behavior.

Finally, add tests to 't3007-ls-files-recurse-submodules.sh' to demonstrate
the corrected config loading behavior. Note that behavior still isn't ideal
because 'extensions.worktreeConfig' in the super project controls whether or
not the worktree config is used in the submodule. This will be fixed in a
later patch.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 config.c                               | 28 +++++++++++++++++---------
 t/t3007-ls-files-recurse-submodules.sh | 23 +++++++++++++++++++++
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/config.c b/config.c
index b79baf83e35..a93f7bfa3aa 100644
--- a/config.c
+++ b/config.c
@@ -2200,14 +2200,24 @@ static int do_git_config_sequence(struct config_reader *reader,
 	char *xdg_config = NULL;
 	char *user_config = NULL;
 	char *repo_config;
+	char *worktree_config;
 	enum config_scope prev_parsing_scope = reader->parsing_scope;
 
-	if (opts->commondir)
+	/*
+	 * Ensure that either:
+	 * - the git_dir and commondir are both set, or
+	 * - the git_dir and commondir are both NULL
+	 */
+	if (!opts->git_dir != !opts->commondir)
+		BUG("only one of commondir and git_dir is non-NULL");
+
+	if (opts->commondir) {
 		repo_config = mkpathdup("%s/config", opts->commondir);
-	else if (opts->git_dir)
-		BUG("git_dir without commondir");
-	else
+		worktree_config = mkpathdup("%s/config.worktree", opts->git_dir);
+	} else {
 		repo_config = NULL;
+		worktree_config = NULL;
+	}
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_SYSTEM);
 	if (git_config_system() && system_config &&
@@ -2230,11 +2240,10 @@ static int do_git_config_sequence(struct config_reader *reader,
 		ret += git_config_from_file(fn, repo_config, data);
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
-	if (!opts->ignore_worktree && repository_format_worktree_config) {
-		char *path = git_pathdup("config.worktree");
-		if (!access_or_die(path, R_OK, 0))
-			ret += git_config_from_file(fn, path, data);
-		free(path);
+	if (!opts->ignore_worktree && worktree_config &&
+	    repository_format_worktree_config &&
+	    !access_or_die(worktree_config, R_OK, 0)) {
+		ret += git_config_from_file(fn, worktree_config, data);
 	}
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_COMMAND);
@@ -2246,6 +2255,7 @@ static int do_git_config_sequence(struct config_reader *reader,
 	free(xdg_config);
 	free(user_config);
 	free(repo_config);
+	free(worktree_config);
 	return ret;
 }
 
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index dd7770e85de..e35c203241f 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -299,6 +299,29 @@ test_expect_success '--recurse-submodules does not support --error-unmatch' '
 	test_i18ngrep "does not support --error-unmatch" actual
 '
 
+test_expect_success '--recurse-submodules parses submodule repo config' '
+	test_when_finished "git -C submodule config --unset feature.experimental" &&
+	git -C submodule config feature.experimental "invalid non-boolean value" &&
+	test_must_fail git ls-files --recurse-submodules 2>err &&
+	grep "bad boolean config value" err
+'
+
+test_expect_success '--recurse-submodules parses submodule worktree config' '
+	test_when_finished "git -C submodule config --unset extensions.worktreeConfig" &&
+	test_when_finished "git -C submodule config --worktree --unset feature.experimental" &&
+	test_when_finished "git config --unset extensions.worktreeConfig" &&
+
+	git -C submodule config extensions.worktreeConfig true &&
+	git -C submodule config --worktree feature.experimental "invalid non-boolean value" &&
+
+	# NEEDSWORK: the extensions.worktreeConfig is set globally based on super
+	# project, so we need to enable it in the super project.
+	git config extensions.worktreeConfig true &&
+
+	test_must_fail git ls-files --recurse-submodules 2>err &&
+	grep "bad boolean config value" err
+'
+
 test_incompatible_with_recurse_submodules () {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
 		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
-- 
gitgitgadget

