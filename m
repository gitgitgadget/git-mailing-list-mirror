Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F257C77B7A
	for <git@archiver.kernel.org>; Fri, 26 May 2023 01:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbjEZBdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 21:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbjEZBdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 21:33:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C64C125
        for <git@vger.kernel.org>; Thu, 25 May 2023 18:33:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so1396925e9.2
        for <git@vger.kernel.org>; Thu, 25 May 2023 18:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685064785; x=1687656785;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo4CMUwe7SuXuNnxUFCBybaxtaKoPLzgZSQP50aHvKA=;
        b=mgiq/HiC0Ds2yhjRFeGC3QRHY/FKLK14TgOKe7zjDP3o+xxRhw/Y4ReW2GKnsgsO/i
         5fK1U7qSu65P7QuZ/0tqijRUQsFRwJWQOWzztLFVg7Tk9cniYtT9WuzB3U24Xn3EY0kT
         U032jqELqJMyvlSL4J+rkQRKpp58p7lyGVuvyOjkv9VkdwdMy4EdmpgUsw3VB2Ro9gag
         TRgRWJRnCXQ/4nYFCFSnHSA2EDyQS1sDQofNUZmPjq5vchbCCCalGnsUc9oOqPnoJWnE
         WIBc20IpmFhMVN3Pm+wgC+cOgoIm+JqBEU2/RB0u91rAukLPcpTgbaBsgVaOL/bCX4B7
         0oCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685064785; x=1687656785;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo4CMUwe7SuXuNnxUFCBybaxtaKoPLzgZSQP50aHvKA=;
        b=U/+vBcjgMZKuiIfSNbmBCW2UmjtpxiWHKLmZFiFvn9yoBa9r7OxGMjOgTuGCO7bYNG
         DTfAgSpH9PlVYNHm60CZWA5maXTkQY9rkAxVhl6TUQOKdcruV5WvaHrSqs834Er0VndC
         aP61YGewYelxclAQpv87wN+4lClSXU0LL+3yIpPggXoZJfaF9UKvyk+KTvCfeJA6uEtm
         dSvUGdUkeuqz7jo6+VkL/45vuCqLOUmyOWN4g9W0pIAn/zXIJrY0lPfFYshEISKX+yq2
         JiKCiNvRkJpX5lku52mi9P4dJ+DbABRLmE8aEWW127OMfp8mQ4Co5lHJx6XF9knV6U8y
         omkA==
X-Gm-Message-State: AC+VfDzwFYY07fBjXtLr+RPa1jf0jMA/oGu0j+wXjd2DmAa4X2dM4pb/
        GKKGBqkXbaj9+FeqDalYQ/gc5GsYWqU=
X-Google-Smtp-Source: ACHHUZ7OzEOn411EZ7NySKZzHnGbDD6xWsItRXd0t/P9rGJ5QtgFWEjlM/tzaph51z6WT+lPTnTwyg==
X-Received: by 2002:a7b:c006:0:b0:3f6:389:73b1 with SMTP id c6-20020a7bc006000000b003f6038973b1mr226917wmb.6.1685064784661;
        Thu, 25 May 2023 18:33:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003f42d8dd7ffsm3611731wmd.19.2023.05.25.18.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:33:04 -0700 (PDT)
Message-Id: <506a2cf8c73549bc8f9761b56532ef08ed220da4.1685064781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
        <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 May 2023 01:33:00 +0000
Subject: [PATCH v2 3/3] repository: move 'repository_format_worktree_config'
 to repo scope
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

Move 'repository_format_worktree_config' out of the global scope and into
the 'repository' struct. This change is similar to how
'repository_format_partial_clone' was moved in ebaf3bcf1ae (repository: move
global r_f_p_c to repo struct, 2021-06-17), adding it to the 'repository'
struct and updating 'setup.c' & 'repository.c' functions to assign the value
appropriately.

The primary goal of this change is to be able to load the worktree config of
a submodule depending on whether that submodule - not its superproject - has
'extensions.worktreeConfig' enabled. To ensure 'do_git_config_sequence()'
has access to the newly repo-scoped configuration, add a 'struct repository'
argument to 'do_git_config_sequence()' and pass it the 'repo' value from
'config_with_options()'.

Finally, add/update tests in 't3007-ls-files-recurse-submodules.sh' to
verify 'extensions.worktreeConfig' is read an used independently by
superprojects and submodules.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/config.c                       |  3 ++-
 builtin/worktree.c                     |  2 +-
 config.c                               |  7 ++++---
 environment.c                          |  1 -
 environment.h                          |  1 -
 repository.c                           |  1 +
 repository.h                           |  1 +
 setup.c                                | 10 ++++++++--
 t/t3007-ls-files-recurse-submodules.sh | 23 +++++++++++++++++++----
 worktree.c                             |  4 ++--
 10 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8fc90288f9e..d40fddb042a 100644
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
@@ -717,7 +718,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
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
index 67e60e131c2..f5bdac0aeed 100644
--- a/config.c
+++ b/config.c
@@ -2195,6 +2195,7 @@ int git_config_system(void)
 
 static int do_git_config_sequence(struct config_reader *reader,
 				  const struct config_options *opts,
+				  const struct repository *repo,
 				  config_fn_t fn, void *data)
 {
 	int ret = 0;
@@ -2243,7 +2244,7 @@ static int do_git_config_sequence(struct config_reader *reader,
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
 	if (!opts->ignore_worktree && worktree_config &&
-	    repository_format_worktree_config &&
+	    repo && repo->repository_format_worktree_config &&
 	    !access_or_die(worktree_config, R_OK, 0)) {
 		ret += git_config_from_file(fn, worktree_config, data);
 	}
@@ -2296,7 +2297,7 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 						data);
 	} else {
-		ret = do_git_config_sequence(&the_reader, opts, fn, data);
+		ret = do_git_config_sequence(&the_reader, opts, repo, fn, data);
 	}
 
 	if (inc.remote_urls) {
@@ -3339,7 +3340,7 @@ int repo_config_set_worktree_gently(struct repository *r,
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
index a3e26751427..7308a3d4e25 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -309,14 +309,29 @@ test_expect_success '--recurse-submodules parses submodule worktree config' '
 	test_config -C submodule extensions.worktreeConfig true &&
 	test_config -C submodule --worktree index.sparse "invalid non-boolean value" &&
 
-	# NEEDSWORK: the extensions.worktreeConfig is set globally based on
-	# superproject, so we need to enable it in the superproject.
-	test_config extensions.worktreeConfig true &&
-
 	test_must_fail git ls-files --recurse-submodules 2>err &&
 	grep "bad boolean config value" err
 '
 
+test_expect_success '--recurse-submodules submodules ignore super project worktreeConfig extension' '
+	# Enable worktree config in both super project & submodule, set an
+	# invalid config in the submodule worktree config
+	test_config extensions.worktreeConfig true &&
+	test_config -C submodule extensions.worktreeConfig true &&
+	test_config -C submodule --worktree index.sparse "invalid non-boolean value" &&
+
+	# Now, disable the worktree config in the submodule. Note that we need
+	# to manually re-enable extensions.worktreeConfig when the test is
+	# finished, otherwise the test_unconfig of index.sparse will not work.
+	test_unconfig -C submodule extensions.worktreeConfig &&
+	test_when_finished "git -C submodule config extensions.worktreeConfig true" &&
+
+	# With extensions.worktreeConfig disabled in the submodule, the invalid
+	# worktree config is not picked up.
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
