Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED718C7EE29
	for <git@archiver.kernel.org>; Fri, 26 May 2023 01:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbjEZBdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 21:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbjEZBdH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 21:33:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245681A6
        for <git@vger.kernel.org>; Thu, 25 May 2023 18:33:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f68fc6b479so2477625e9.2
        for <git@vger.kernel.org>; Thu, 25 May 2023 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685064783; x=1687656783;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G3Uo2cbV1+ZjFQKxtrn4gBRYpw6WcCzG/Ywg/svfzs=;
        b=rmgOLxAmYIZXerO95E8CFcPx3SHqYM0cvr/etDiBQUZokEEjtMBLTyESCUxDRu4ZrL
         n9/xpTWFytD2VTXSoNKCibkWl9oT/BcYWzo79MXdBbvUExDQpwKcwB6uRvNB9LPGTOii
         3hWfr45iGZYLykVsBcJ5HawWpljnwDTYiaB3fh/BljhRftxyUzz7LH8G/a4WZL6UBCY1
         Zc/JVbMzCV9IimTIfOnZoskTGqqykm/YPFXqzY+rI5juXOoBlJpgjF1IDSJyV6xMj9Ws
         VtkboppkzszSpIQjZHlqg3qJx72xBgGqfi3kCKdU8fEjtORQ516kLwc+V5tDtLx0qBPy
         M/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685064783; x=1687656783;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8G3Uo2cbV1+ZjFQKxtrn4gBRYpw6WcCzG/Ywg/svfzs=;
        b=gdmHQM9RpNSo5zw0yUkw8Y8WyCvtWy5vQUO9lTaq3X87Fk5OK8wY5U+a3rrmSgLMhT
         RPIZJIcejh/MZLMc6KeeFfzRW4zbpOTFRVxtxPMWCPY6Gces/24TB7mIMh5Czpp586FQ
         iwnmb8Zf2OGT3Nke2v/tdxrOWs35s0SWh6WayYHAKlmhR3WxjIf66t4gGJ50GTZKVJya
         20t7SJHk5G0VuFuOv0QpQA7lOHxRc7rSFWWpPn9AbFuGfdbHKK2Wz9Q0YzSJ1TcBWpko
         aZdJHxUVRQWhobGe13kM9jZNwtlfqsuzFxvkuhm/I/PqVjyltxLnSBG+p6Rf7r27gSwZ
         5XFw==
X-Gm-Message-State: AC+VfDzEa1Dagqgy4wwgUKVMiXRNNg30rHuESkw7+ulUO4kuJH0uneaW
        6BzU4rgQ8OUWjlmCxHjRSL5hvifJ+Nw=
X-Google-Smtp-Source: ACHHUZ63aQ/HDQyMF+/xSDCWgUErVxbkvBcXmIsNpC6YF6sDYXHu1WyDGsFco6kwiogr97Fz0P5fag==
X-Received: by 2002:a05:600c:2308:b0:3f6:1377:8b15 with SMTP id 8-20020a05600c230800b003f613778b15mr225878wmo.21.1685064783313;
        Thu, 25 May 2023 18:33:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c354100b003f61177faffsm11488184wmq.0.2023.05.25.18.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:33:03 -0700 (PDT)
Message-Id: <fb597cdfeb033478103c81143e1b16dec957e0a4.1685064781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
        <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 May 2023 01:32:58 +0000
Subject: [PATCH v2 1/3] config: use gitdir to get worktree config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, chooglen@google.com, gitster@pobox.com,
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
is incorrect, since 'the_repository' is the superproject. 'opts->git_dir' is
the gitdir of the submodule being configured, so the config file in that
location should be read instead.

To ensure the use of 'opts->git_dir' is safe, require that 'opts->git_dir'
is set if-and-only-if 'opts->commondir' is set (rather than "only-if" as it
is now). In all current usage of 'config_options', these values are set
together, so the stricter check does not change any behavior.

Finally, add tests to 't3007-ls-files-recurse-submodules.sh' to verify the
corrected config is loaded. Use 'ls-files' to test this because, unlike some
other '--recurse-submodules' commands, 'ls-files' parses the config of the
submodule in the same process as the superproject (via 'show_submodule()' ->
'repo_read_index()' -> 'prepare_repo_settings()'). As a result,
'the_repository' points to the config of the superproject but the
commondir/gitdir in the config sequence will be that of the submodule,
providing the exact scenario needed to verify this patch.

The first test ('--recurse-submodules parses submodule repo config') checks
that the submodule's *repo* config is read when running 'ls-files' on the
superproject; this confirms already-working behavior, serving as a reference
for how worktree config parsing should behave. The second test
('--recurse-submodules parses submodule worktree config') tests the same
scenario as the previous but instead using the *worktree* config,
demonstrating the corrected behavior. The 'test_config' helper is extended
for this case so that it properly applies the '--worktree' option to the
configure/unconfigure operations it performs.

Note that, although the submodule worktree config is now parsed instead of
the superproject's, 'extensions.worktreeConfig' in the superproject still
controls whether or not the worktree config is enabled at all in the
submodule. This will be fixed in a later patch.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 config.c                               | 28 +++++++++++++++++---------
 t/t3007-ls-files-recurse-submodules.sh | 18 +++++++++++++++++
 t/test-lib-functions.sh                | 13 ++++++++++--
 3 files changed, 48 insertions(+), 11 deletions(-)

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
index dd7770e85de..a3e26751427 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -299,6 +299,24 @@ test_expect_success '--recurse-submodules does not support --error-unmatch' '
 	test_i18ngrep "does not support --error-unmatch" actual
 '
 
+test_expect_success '--recurse-submodules parses submodule repo config' '
+	test_config -C submodule index.sparse "invalid non-boolean value" &&
+	test_must_fail git ls-files --recurse-submodules 2>err &&
+	grep "bad boolean config value" err
+'
+
+test_expect_success '--recurse-submodules parses submodule worktree config' '
+	test_config -C submodule extensions.worktreeConfig true &&
+	test_config -C submodule --worktree index.sparse "invalid non-boolean value" &&
+
+	# NEEDSWORK: the extensions.worktreeConfig is set globally based on
+	# superproject, so we need to enable it in the superproject.
+	test_config extensions.worktreeConfig true &&
+
+	test_must_fail git ls-files --recurse-submodules 2>err &&
+	grep "bad boolean config value" err
+'
+
 test_incompatible_with_recurse_submodules () {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
 		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6e19ebc922a..b3864e22e9a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -542,8 +542,17 @@ test_config () {
 		config_dir=$1
 		shift
 	fi
-	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} '$1'" &&
-	git ${config_dir:+-C "$config_dir"} config "$@"
+
+	# If --worktree is provided, use it to configure/unconfigure
+	is_worktree=
+	if test "$1" = --worktree
+	then
+		is_worktree=1
+		shift
+	fi
+
+	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} ${is_worktree:+--worktree} '$1'" &&
+	git ${config_dir:+-C "$config_dir"} config ${is_worktree:+--worktree} "$@"
 }
 
 test_config_global () {
-- 
gitgitgadget

