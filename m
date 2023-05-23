Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBC2C77B75
	for <git@archiver.kernel.org>; Tue, 23 May 2023 23:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbjEWXSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 19:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjEWXSA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 19:18:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13394E9
        for <git@vger.kernel.org>; Tue, 23 May 2023 16:17:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3093eb8cd1fso54359f8f.1
        for <git@vger.kernel.org>; Tue, 23 May 2023 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684883875; x=1687475875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQrqKfjkJ4uQQG0O3wyp/hiyhmvOwDd2fcmsQawXdxI=;
        b=Daq6Un1ELxWVqGCKIT7wcF1yU2gKttFye55X3vMyI6WgNKmAy8YAewUDEH56+UfCkY
         FbtJ6kELJ4zefK6H8Ge47UVUNtBbvW/8jQ3UW4rnvhdoKiZh0IuED+cgiGgyeIyWLDeC
         yuOiXe3FEN0jFPJQaxX6QySprO8SvwM309NJj/OK72r4SUnVN0hpBSqhUoOqGFkJ3mXa
         1TJxYhGlsTp42OLC3fNdDxtT8YF9eSudjzU/MhgE8CyXU01Px7ozYHokrGfFMD3thrKq
         5kWaJJJ/fuBToZEXkJZexGrTSVobdBgQ5O1Qcg5dn98uBah/QYWUYzK7aJQN56bDYAJq
         cwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684883875; x=1687475875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQrqKfjkJ4uQQG0O3wyp/hiyhmvOwDd2fcmsQawXdxI=;
        b=M7plZqw3oCP3nsjjKIRY4ywojIoz8qCHcwuSQafk8MFxKYVl3Tp6g0ZvtNJZPladU/
         sfCJ2fMUIP6eMiooT9OBwgJ/1VIihOkF+u2pnCLDOrgprLh5q0qdh6S0HuxAaWVQ5+y0
         99/PNrGnz2y9wOHgqlXi+co4Gq3VuQ/qGTheOQCXLAApwy89+vsmWv9j4wy2YzbcrES+
         uZJNZivtUIbIdvQqeEwwNFamCwPLL1mdWjjV+mbAyVhpqJIuYT+t4jQj4Y+Q5Pk9poGS
         /+AzgVT6vKnhoDu3LdsLcJo2OjKOccx+v/nPPLFDEU3mKYWo/4Wrxn79fU4rtcqVBtYx
         aVBw==
X-Gm-Message-State: AC+VfDzXEWzxdiysvupdIzwqLa5M7Ob1YJiV/3n/oO918iMfwQNdLbTf
        dh2AozYHjCGy/qutLMoitxu9HzdCGW8=
X-Google-Smtp-Source: ACHHUZ49i4dl1pYFpduSN7Vu7yySTh43nQlNIipY6VVut77Hiqdv3l6mHRMh/IBrBEhh/4hxSC9D+w==
X-Received: by 2002:a5d:494b:0:b0:307:8b3e:2858 with SMTP id r11-20020a5d494b000000b003078b3e2858mr10575111wrs.45.1684883875121;
        Tue, 23 May 2023 16:17:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d4b0f000000b00307a86a4bcesm12255280wrq.35.2023.05.23.16.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 16:17:54 -0700 (PDT)
Message-Id: <5ed9100a7707a529b309005419244d083cdc85ba.1684883872.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 May 2023 23:17:52 +0000
Subject: [PATCH 2/2] repository: move 'repository_format_worktree_config' to
 repo scope
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

Move 'repository_format_worktree_config' out of the global scope and into
the 'repository' struct. This change is similar to how
'repository_format_partial_clone' was moved in ebaf3bcf1ae (repository: move
global r_f_p_c to repo struct, 2021-06-17), adding to the 'repository'
struct and updating 'setup.c' & 'repository.c' functions to assign the value
appropriately. In addition, update usage of the setting to reference the
relevant context's repo or, as a fallback, 'the_repository'.

The primary goal of this change is to be able to load worktree config for a
submodule depending on whether that submodule - not the super project - has
'extensions.worktreeConfig' enabled. To ensure 'do_git_config_sequence()'
has access to the newly repo-scoped configuration:

- update 'repo_read_config()' to create a 'config_source' to hold the
  repo instance
- add a 'repo' argument to 'do_git_config_sequence()'
- update 'config_with_options' to call 'do_git_config_sequence()' with
  'config_source.repo', or 'the_repository' as a fallback

Finally, add/update tests in 't3007-ls-files-recurse-submodules.sh' to
verify 'extensions.worktreeConfig' is read an used independently by super
projects and submodules.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/config.c                       |  3 ++-
 builtin/worktree.c                     |  2 +-
 config.c                               | 16 +++++++++++-----
 environment.c                          |  1 -
 environment.h                          |  1 -
 repository.c                           |  1 +
 repository.h                           |  1 +
 setup.c                                | 10 ++++++++--
 t/t3007-ls-files-recurse-submodules.sh | 21 ++++++++++++++++-----
 worktree.c                             |  4 ++--
 10 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ff2fe8ef125..5e352117c7a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -5,6 +5,7 @@
 #include "color.h"
 #include "editor.h"
 #include "environment.h"
+#include "repository.h"
 #include "gettext.h"
 #include "ident.h"
 #include "parse-options.h"
@@ -713,7 +714,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		given_config_source.scope = CONFIG_SCOPE_LOCAL;
 	} else if (use_worktree_config) {
 		struct worktree **worktrees = get_worktrees();
-		if (repository_format_worktree_config)
+		if (the_repository->repository_format_worktree_config)
 			given_config_source.file = git_pathdup("config.worktree");
 		else if (worktrees[0] && worktrees[1])
 			die(_("--worktree cannot be used with multiple "
diff --git a/builtin/worktree.c b/builtin/worktree.c
index f3180463be2..60e389aaedb 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -483,7 +483,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * values from the current worktree into the new one, that way the
 	 * new worktree behaves the same as this one.
 	 */
-	if (repository_format_worktree_config)
+	if (the_repository->repository_format_worktree_config)
 		copy_filtered_worktree_config(sb_repo.buf);
 
 	strvec_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
diff --git a/config.c b/config.c
index a93f7bfa3aa..9ce2ffff5e1 100644
--- a/config.c
+++ b/config.c
@@ -2193,6 +2193,7 @@ int git_config_system(void)
 
 static int do_git_config_sequence(struct config_reader *reader,
 				  const struct config_options *opts,
+				  const struct repository *repo,
 				  config_fn_t fn, void *data)
 {
 	int ret = 0;
@@ -2241,7 +2242,7 @@ static int do_git_config_sequence(struct config_reader *reader,
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
 	if (!opts->ignore_worktree && worktree_config &&
-	    repository_format_worktree_config &&
+	    repo && repo->repository_format_worktree_config &&
 	    !access_or_die(worktree_config, R_OK, 0)) {
 		ret += git_config_from_file(fn, worktree_config, data);
 	}
@@ -2277,7 +2278,7 @@ int config_with_options(config_fn_t fn, void *data,
 		data = &inc;
 	}
 
-	if (config_source)
+	if (config_source && config_source->scope != CONFIG_SCOPE_UNKNOWN)
 		config_reader_set_scope(&the_reader, config_source->scope);
 
 	/*
@@ -2294,7 +2295,9 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 						data);
 	} else {
-		ret = do_git_config_sequence(&the_reader, opts, fn, data);
+		struct repository *repo = config_source && config_source->repo ?
+			config_source->repo : the_repository;
+		ret = do_git_config_sequence(&the_reader, opts, repo, fn, data);
 	}
 
 	if (inc.remote_urls) {
@@ -2667,11 +2670,14 @@ static void repo_read_config(struct repository *repo)
 {
 	struct config_options opts = { 0 };
 	struct configset_add_data data = CONFIGSET_ADD_INIT;
+	struct git_config_source config_source = { 0 };
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
 	opts.git_dir = repo->gitdir;
 
+	config_source.repo = repo;
+
 	if (!repo->config)
 		CALLOC_ARRAY(repo->config, 1);
 	else
@@ -2681,7 +2687,7 @@ static void repo_read_config(struct repository *repo)
 	data.config_set = repo->config;
 	data.config_reader = &the_reader;
 
-	if (config_with_options(config_set_callback, &data, NULL, &opts) < 0)
+	if (config_with_options(config_set_callback, &data, &config_source, &opts) < 0)
 		/*
 		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
@@ -3337,7 +3343,7 @@ int repo_config_set_worktree_gently(struct repository *r,
 				    const char *key, const char *value)
 {
 	/* Only use worktree-specific config if it is already enabled. */
-	if (repository_format_worktree_config) {
+	if (r->repository_format_worktree_config) {
 		char *file = repo_git_path(r, "config.worktree");
 		int ret = git_config_set_multivar_in_file_gently(
 					file, key, value, NULL, 0);
diff --git a/environment.c b/environment.c
index 28d18eaca8e..6bd001efbde 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,6 @@ int is_bare_repository_cfg = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int repository_format_precious_objects;
-int repository_format_worktree_config;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 char *apply_default_whitespace;
diff --git a/environment.h b/environment.h
index 30cb7e0fa34..e6668079269 100644
--- a/environment.h
+++ b/environment.h
@@ -197,7 +197,6 @@ extern char *notes_ref_name;
 extern int grafts_replace_parents;
 
 extern int repository_format_precious_objects;
-extern int repository_format_worktree_config;
 
 /*
  * Create a temporary file rooted in the object database directory, or
diff --git a/repository.c b/repository.c
index c53e480e326..104960f8f59 100644
--- a/repository.c
+++ b/repository.c
@@ -182,6 +182,7 @@ int repo_init(struct repository *repo,
 		goto error;
 
 	repo_set_hash_algo(repo, format.hash_algo);
+	repo->repository_format_worktree_config = format.worktree_config;
 
 	/* take ownership of format.partial_clone */
 	repo->repository_format_partial_clone = format.partial_clone;
diff --git a/repository.h b/repository.h
index 1a13ff28677..74ae26635a4 100644
--- a/repository.h
+++ b/repository.h
@@ -163,6 +163,7 @@ struct repository {
 	struct promisor_remote_config *promisor_remote_config;
 
 	/* Configurations */
+	int repository_format_worktree_config;
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
diff --git a/setup.c b/setup.c
index 458582207ea..d8663954350 100644
--- a/setup.c
+++ b/setup.c
@@ -650,11 +650,10 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	}
 
 	repository_format_precious_objects = candidate->precious_objects;
-	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
 	string_list_clear(&candidate->v1_only_extensions, 0);
 
-	if (repository_format_worktree_config) {
+	if (candidate->worktree_config) {
 		/*
 		 * pick up core.bare and core.worktree from per-worktree
 		 * config if present
@@ -1423,6 +1422,9 @@ int discover_git_directory(struct strbuf *commondir,
 		return -1;
 	}
 
+	the_repository->repository_format_worktree_config =
+		candidate.worktree_config;
+
 	/* take ownership of candidate.partial_clone */
 	the_repository->repository_format_partial_clone =
 		candidate.partial_clone;
@@ -1560,6 +1562,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+			the_repository->repository_format_worktree_config =
+				repo_fmt.worktree_config;
 			/* take ownership of repo_fmt.partial_clone */
 			the_repository->repository_format_partial_clone =
 				repo_fmt.partial_clone;
@@ -1651,6 +1655,8 @@ void check_repository_format(struct repository_format *fmt)
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository = 1;
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
+	the_repository->repository_format_worktree_config =
+		fmt->worktree_config;
 	the_repository->repository_format_partial_clone =
 		xstrdup_or_null(fmt->partial_clone);
 	clear_repository_format(&repo_fmt);
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index e35c203241f..6d0bacef4de 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -309,19 +309,30 @@ test_expect_success '--recurse-submodules parses submodule repo config' '
 test_expect_success '--recurse-submodules parses submodule worktree config' '
 	test_when_finished "git -C submodule config --unset extensions.worktreeConfig" &&
 	test_when_finished "git -C submodule config --worktree --unset feature.experimental" &&
-	test_when_finished "git config --unset extensions.worktreeConfig" &&
 
 	git -C submodule config extensions.worktreeConfig true &&
 	git -C submodule config --worktree feature.experimental "invalid non-boolean value" &&
 
-	# NEEDSWORK: the extensions.worktreeConfig is set globally based on super
-	# project, so we need to enable it in the super project.
-	git config extensions.worktreeConfig true &&
-
 	test_must_fail git ls-files --recurse-submodules 2>err &&
 	grep "bad boolean config value" err
 '
 
+test_expect_success '--recurse-submodules submodules ignore super project worktreeConfig extension' '
+	test_when_finished "git config --unset extensions.worktreeConfig" &&
+
+	# Enable worktree config in both super project & submodule, set an
+	# invalid config in the submodule worktree config, then disable worktree
+	# config in the submodule. The invalid worktree config should not be
+	# picked up.
+	git config extensions.worktreeConfig true &&
+	git -C submodule config extensions.worktreeConfig true &&
+	git -C submodule config --worktree feature.experimental "invalid non-boolean value" &&
+	git -C submodule config --unset extensions.worktreeConfig &&
+
+	git ls-files --recurse-submodules 2>err &&
+	! grep "bad boolean config value" err
+'
+
 test_incompatible_with_recurse_submodules () {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
 		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
diff --git a/worktree.c b/worktree.c
index b5ee71c5ebd..c448fecd4b3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -806,7 +806,7 @@ int init_worktree_config(struct repository *r)
 	 * If the extension is already enabled, then we can skip the
 	 * upgrade process.
 	 */
-	if (repository_format_worktree_config)
+	if (r->repository_format_worktree_config)
 		return 0;
 	if ((res = git_config_set_gently("extensions.worktreeConfig", "true")))
 		return error(_("failed to set extensions.worktreeConfig setting"));
@@ -846,7 +846,7 @@ int init_worktree_config(struct repository *r)
 	 * Ensure that we use worktree config for the remaining lifetime
 	 * of the current process.
 	 */
-	repository_format_worktree_config = 1;
+	r->repository_format_worktree_config = 1;
 
 cleanup:
 	git_configset_clear(&cs);
-- 
gitgitgadget
