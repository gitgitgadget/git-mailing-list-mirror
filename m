Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898E5C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjEPGeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjEPGeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEED52139
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f42d937d61so73779535e9.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218862; x=1686810862;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsLD4C7hi8J5boQ6DMB7EpgsdRU/CIOEytnjOOdqGSI=;
        b=CGpVKlRKovVKzbgz0G8uZEtwxhegdXNRBcncj/U29d/tgdI36ebrm2h+t2oQzZ+AfR
         4QQm/tZZLFYtUwbs2kWoou9AHLyMqOrlb34fAGjHSnbSFhdDNXex6HWpZzs0VSB5EHol
         Wn1MWueVtEgh/Rp4UjMnfo0QmGo1USTvwHl2TPrYrmfwHNpNbf59H4VoEMIKTGracMW1
         FTKEYqTnsN77FR9d6pvhGG+ucHigO4Rad032G7BgFggoGdUsSp4/45+zmAecWPI2OI3F
         DvQzx4kRLAsuHUNriTtdlL6bjRYUETNdiW+rptkWhsgD+2EED8dJL3dykUcyoDZU1CMm
         yF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218862; x=1686810862;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsLD4C7hi8J5boQ6DMB7EpgsdRU/CIOEytnjOOdqGSI=;
        b=WHOY9ek7p4lzbFCuiO64ePCujExKfKGoMgX3SbbLkz6Jrw/zCe1JLoyaucgYMoq0v9
         v+louaoeAIkfZgYxqbf+ySSkS76nJm1b/IRN+Vx52DRVt7j9vI+Xeo48o9NW6Qr+NBOh
         6eNBJfMQXo6FHnA2vjTJL8jSWAz0Prk7kYXXVBjrSOv7UKF21am7T49YeT56biBNqK0h
         flloNZyZS/P+bVTU3VnzE1mtWCKWWybByDHn3kC6i08Ydo7wb8slgcEbgtXYz/xehlgG
         Ph9W5Epa+lx6qckfN9aiDMEJMCHqjQBXlnCAzxMVa4wygo4zmYlK7+2UV0v9c+Bgypnb
         PCUg==
X-Gm-Message-State: AC+VfDxU9XnvNuEv8cYCwoMJSywDOnYjico8glO96qGEg3DymLHTklFu
        e2JTrNm31inUeXO5aw7SKXhYbl2iZwY=
X-Google-Smtp-Source: ACHHUZ6uCZU1XJoJQuTkBZR5QoBZOKZARfH8G4YtmbeKpKWZKGSAOtvJSbKrZv9hJI2Kx89jW71Lvw==
X-Received: by 2002:a05:6000:1081:b0:306:43bc:8067 with SMTP id y1-20020a056000108100b0030643bc8067mr26211318wrw.27.1684218861585;
        Mon, 15 May 2023 23:34:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb04000000b003079693eff2sm1377263wrr.41.2023.05.15.23.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:21 -0700 (PDT)
Message-Id: <fc1272c981ee124c64f779036dd6a1ffd5cfc37c.1684218851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:44 +0000
Subject: [PATCH v3 04/28] setup: adopt shared init-db & clone code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The functions init_db() and initialize_repository_version() were shared
by builtin/init-db.c and builtin/clone.c, and declared in cache.h.

Move these functions, plus their several helpers only used by these
functions, to setup.[ch].

Diff best viewed with `--color-moved`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/init-db.c | 496 ----------------------------------------------
 cache.h           |   9 -
 setup.c           | 496 ++++++++++++++++++++++++++++++++++++++++++++++
 setup.h           |   9 +
 4 files changed, 505 insertions(+), 505 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index ae0122534aa..feb019a9dea 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -6,511 +6,15 @@
 #include "cache.h"
 #include "abspath.h"
 #include "config.h"
-#include "copy.h"
 #include "environment.h"
 #include "gettext.h"
-#include "refs.h"
 #include "builtin.h"
-#include "exec-cmd.h"
 #include "object-file.h"
 #include "parse-options.h"
 #include "path.h"
 #include "setup.h"
-#include "worktree.h"
 #include "wrapper.h"
 
-#ifndef DEFAULT_GIT_TEMPLATE_DIR
-#define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
-#endif
-
-#ifdef NO_TRUSTABLE_FILEMODE
-#define TEST_FILEMODE 0
-#else
-#define TEST_FILEMODE 1
-#endif
-
-#define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
-
-static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
-			     DIR *dir)
-{
-	size_t path_baselen = path->len;
-	size_t template_baselen = template_path->len;
-	struct dirent *de;
-
-	/* Note: if ".git/hooks" file exists in the repository being
-	 * re-initialized, /etc/core-git/templates/hooks/update would
-	 * cause "git init" to fail here.  I think this is sane but
-	 * it means that the set of templates we ship by default, along
-	 * with the way the namespace under .git/ is organized, should
-	 * be really carefully chosen.
-	 */
-	safe_create_dir(path->buf, 1);
-	while ((de = readdir(dir)) != NULL) {
-		struct stat st_git, st_template;
-		int exists = 0;
-
-		strbuf_setlen(path, path_baselen);
-		strbuf_setlen(template_path, template_baselen);
-
-		if (de->d_name[0] == '.')
-			continue;
-		strbuf_addstr(path, de->d_name);
-		strbuf_addstr(template_path, de->d_name);
-		if (lstat(path->buf, &st_git)) {
-			if (errno != ENOENT)
-				die_errno(_("cannot stat '%s'"), path->buf);
-		}
-		else
-			exists = 1;
-
-		if (lstat(template_path->buf, &st_template))
-			die_errno(_("cannot stat template '%s'"), template_path->buf);
-
-		if (S_ISDIR(st_template.st_mode)) {
-			DIR *subdir = opendir(template_path->buf);
-			if (!subdir)
-				die_errno(_("cannot opendir '%s'"), template_path->buf);
-			strbuf_addch(path, '/');
-			strbuf_addch(template_path, '/');
-			copy_templates_1(path, template_path, subdir);
-			closedir(subdir);
-		}
-		else if (exists)
-			continue;
-		else if (S_ISLNK(st_template.st_mode)) {
-			struct strbuf lnk = STRBUF_INIT;
-			if (strbuf_readlink(&lnk, template_path->buf,
-					    st_template.st_size) < 0)
-				die_errno(_("cannot readlink '%s'"), template_path->buf);
-			if (symlink(lnk.buf, path->buf))
-				die_errno(_("cannot symlink '%s' '%s'"),
-					  lnk.buf, path->buf);
-			strbuf_release(&lnk);
-		}
-		else if (S_ISREG(st_template.st_mode)) {
-			if (copy_file(path->buf, template_path->buf, st_template.st_mode))
-				die_errno(_("cannot copy '%s' to '%s'"),
-					  template_path->buf, path->buf);
-		}
-		else
-			error(_("ignoring template %s"), template_path->buf);
-	}
-}
-
-static void copy_templates(const char *template_dir, const char *init_template_dir)
-{
-	struct strbuf path = STRBUF_INIT;
-	struct strbuf template_path = STRBUF_INIT;
-	size_t template_len;
-	struct repository_format template_format = REPOSITORY_FORMAT_INIT;
-	struct strbuf err = STRBUF_INIT;
-	DIR *dir;
-	char *to_free = NULL;
-
-	if (!template_dir)
-		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
-	if (!template_dir)
-		template_dir = init_template_dir;
-	if (!template_dir)
-		template_dir = to_free = system_path(DEFAULT_GIT_TEMPLATE_DIR);
-	if (!template_dir[0]) {
-		free(to_free);
-		return;
-	}
-
-	strbuf_addstr(&template_path, template_dir);
-	strbuf_complete(&template_path, '/');
-	template_len = template_path.len;
-
-	dir = opendir(template_path.buf);
-	if (!dir) {
-		warning(_("templates not found in %s"), template_dir);
-		goto free_return;
-	}
-
-	/* Make sure that template is from the correct vintage */
-	strbuf_addstr(&template_path, "config");
-	read_repository_format(&template_format, template_path.buf);
-	strbuf_setlen(&template_path, template_len);
-
-	/*
-	 * No mention of version at all is OK, but anything else should be
-	 * verified.
-	 */
-	if (template_format.version >= 0 &&
-	    verify_repository_format(&template_format, &err) < 0) {
-		warning(_("not copying templates from '%s': %s"),
-			  template_dir, err.buf);
-		strbuf_release(&err);
-		goto close_free_return;
-	}
-
-	strbuf_addstr(&path, get_git_common_dir());
-	strbuf_complete(&path, '/');
-	copy_templates_1(&path, &template_path, dir);
-close_free_return:
-	closedir(dir);
-free_return:
-	free(to_free);
-	strbuf_release(&path);
-	strbuf_release(&template_path);
-	clear_repository_format(&template_format);
-}
-
-/*
- * If the git_dir is not directly inside the working tree, then git will not
- * find it by default, and we need to set the worktree explicitly.
- */
-static int needs_work_tree_config(const char *git_dir, const char *work_tree)
-{
-	if (!strcmp(work_tree, "/") && !strcmp(git_dir, "/.git"))
-		return 0;
-	if (skip_prefix(git_dir, work_tree, &git_dir) &&
-	    !strcmp(git_dir, "/.git"))
-		return 0;
-	return 1;
-}
-
-void initialize_repository_version(int hash_algo, int reinit)
-{
-	char repo_version_string[10];
-	int repo_version = GIT_REPO_VERSION;
-
-	if (hash_algo != GIT_HASH_SHA1)
-		repo_version = GIT_REPO_VERSION_READ;
-
-	/* This forces creation of new config file */
-	xsnprintf(repo_version_string, sizeof(repo_version_string),
-		  "%d", repo_version);
-	git_config_set("core.repositoryformatversion", repo_version_string);
-
-	if (hash_algo != GIT_HASH_SHA1)
-		git_config_set("extensions.objectformat",
-			       hash_algos[hash_algo].name);
-	else if (reinit)
-		git_config_set_gently("extensions.objectformat", NULL);
-}
-
-static int create_default_files(const char *template_path,
-				const char *original_git_dir,
-				const char *initial_branch,
-				const struct repository_format *fmt,
-				int prev_bare_repository,
-				int init_shared_repository,
-				int quiet)
-{
-	struct stat st1;
-	struct strbuf buf = STRBUF_INIT;
-	char *path;
-	char junk[2];
-	int reinit;
-	int filemode;
-	struct strbuf err = STRBUF_INIT;
-	const char *init_template_dir = NULL;
-	const char *work_tree = get_git_work_tree();
-
-	/*
-	 * First copy the templates -- we might have the default
-	 * config file there, in which case we would want to read
-	 * from it after installing.
-	 *
-	 * Before reading that config, we also need to clear out any cached
-	 * values (since we've just potentially changed what's available on
-	 * disk).
-	 */
-	git_config_get_pathname("init.templatedir", &init_template_dir);
-	copy_templates(template_path, init_template_dir);
-	free((char *)init_template_dir);
-	git_config_clear();
-	reset_shared_repository();
-	git_config(git_default_config, NULL);
-
-	/*
-	 * We must make sure command-line options continue to override any
-	 * values we might have just re-read from the config.
-	 */
-	if (init_shared_repository != -1)
-		set_shared_repository(init_shared_repository);
-	/*
-	 * TODO: heed core.bare from config file in templates if no
-	 *       command-line override given
-	 */
-	is_bare_repository_cfg = prev_bare_repository || !work_tree;
-	/* TODO (continued):
-	 *
-	 * Unfortunately, the line above is equivalent to
-	 *    is_bare_repository_cfg = !work_tree;
-	 * which ignores the config entirely even if no `--[no-]bare`
-	 * command line option was present.
-	 *
-	 * To see why, note that before this function, there was this call:
-	 *    prev_bare_repository = is_bare_repository()
-	 * expanding the right hand side:
-	 *                 = is_bare_repository_cfg && !get_git_work_tree()
-	 *                 = is_bare_repository_cfg && !work_tree
-	 * note that the last simplification above is valid because nothing
-	 * calls repo_init() or set_git_work_tree() between any of the
-	 * relevant calls in the code, and thus the !get_git_work_tree()
-	 * calls will return the same result each time.  So, what we are
-	 * interested in computing is the right hand side of the line of
-	 * code just above this comment:
-	 *     prev_bare_repository || !work_tree
-	 *        = is_bare_repository_cfg && !work_tree || !work_tree
-	 *        = !work_tree
-	 * because "A && !B || !B == !B" for all boolean values of A & B.
-	 */
-
-	/*
-	 * We would have created the above under user's umask -- under
-	 * shared-repository settings, we would need to fix them up.
-	 */
-	if (get_shared_repository()) {
-		adjust_shared_perm(get_git_dir());
-	}
-
-	/*
-	 * We need to create a "refs" dir in any case so that older
-	 * versions of git can tell that this is a repository.
-	 */
-	safe_create_dir(git_path("refs"), 1);
-	adjust_shared_perm(git_path("refs"));
-
-	if (refs_init_db(&err))
-		die("failed to set up refs db: %s", err.buf);
-
-	/*
-	 * Point the HEAD symref to the initial branch with if HEAD does
-	 * not yet exist.
-	 */
-	path = git_path_buf(&buf, "HEAD");
-	reinit = (!access(path, R_OK)
-		  || readlink(path, junk, sizeof(junk)-1) != -1);
-	if (!reinit) {
-		char *ref;
-
-		if (!initial_branch)
-			initial_branch = git_default_branch_name(quiet);
-
-		ref = xstrfmt("refs/heads/%s", initial_branch);
-		if (check_refname_format(ref, 0) < 0)
-			die(_("invalid initial branch name: '%s'"),
-			    initial_branch);
-
-		if (create_symref("HEAD", ref, NULL) < 0)
-			exit(1);
-		free(ref);
-	}
-
-	initialize_repository_version(fmt->hash_algo, 0);
-
-	/* Check filemode trustability */
-	path = git_path_buf(&buf, "config");
-	filemode = TEST_FILEMODE;
-	if (TEST_FILEMODE && !lstat(path, &st1)) {
-		struct stat st2;
-		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
-				!lstat(path, &st2) &&
-				st1.st_mode != st2.st_mode &&
-				!chmod(path, st1.st_mode));
-		if (filemode && !reinit && (st1.st_mode & S_IXUSR))
-			filemode = 0;
-	}
-	git_config_set("core.filemode", filemode ? "true" : "false");
-
-	if (is_bare_repository())
-		git_config_set("core.bare", "true");
-	else {
-		git_config_set("core.bare", "false");
-		/* allow template config file to override the default */
-		if (log_all_ref_updates == LOG_REFS_UNSET)
-			git_config_set("core.logallrefupdates", "true");
-		if (needs_work_tree_config(original_git_dir, work_tree))
-			git_config_set("core.worktree", work_tree);
-	}
-
-	if (!reinit) {
-		/* Check if symlink is supported in the work tree */
-		path = git_path_buf(&buf, "tXXXXXX");
-		if (!close(xmkstemp(path)) &&
-		    !unlink(path) &&
-		    !symlink("testing", path) &&
-		    !lstat(path, &st1) &&
-		    S_ISLNK(st1.st_mode))
-			unlink(path); /* good */
-		else
-			git_config_set("core.symlinks", "false");
-
-		/* Check if the filesystem is case-insensitive */
-		path = git_path_buf(&buf, "CoNfIg");
-		if (!access(path, F_OK))
-			git_config_set("core.ignorecase", "true");
-		probe_utf8_pathname_composition();
-	}
-
-	strbuf_release(&buf);
-	return reinit;
-}
-
-static void create_object_directory(void)
-{
-	struct strbuf path = STRBUF_INIT;
-	size_t baselen;
-
-	strbuf_addstr(&path, get_object_directory());
-	baselen = path.len;
-
-	safe_create_dir(path.buf, 1);
-
-	strbuf_setlen(&path, baselen);
-	strbuf_addstr(&path, "/pack");
-	safe_create_dir(path.buf, 1);
-
-	strbuf_setlen(&path, baselen);
-	strbuf_addstr(&path, "/info");
-	safe_create_dir(path.buf, 1);
-
-	strbuf_release(&path);
-}
-
-static void separate_git_dir(const char *git_dir, const char *git_link)
-{
-	struct stat st;
-
-	if (!stat(git_link, &st)) {
-		const char *src;
-
-		if (S_ISREG(st.st_mode))
-			src = read_gitfile(git_link);
-		else if (S_ISDIR(st.st_mode))
-			src = git_link;
-		else
-			die(_("unable to handle file type %d"), (int)st.st_mode);
-
-		if (rename(src, git_dir))
-			die_errno(_("unable to move %s to %s"), src, git_dir);
-		repair_worktrees(NULL, NULL);
-	}
-
-	write_file(git_link, "gitdir: %s", git_dir);
-}
-
-static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash)
-{
-	const char *env = getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
-	/*
-	 * If we already have an initialized repo, don't allow the user to
-	 * specify a different algorithm, as that could cause corruption.
-	 * Otherwise, if the user has specified one on the command line, use it.
-	 */
-	if (repo_fmt->version >= 0 && hash != GIT_HASH_UNKNOWN && hash != repo_fmt->hash_algo)
-		die(_("attempt to reinitialize repository with different hash"));
-	else if (hash != GIT_HASH_UNKNOWN)
-		repo_fmt->hash_algo = hash;
-	else if (env) {
-		int env_algo = hash_algo_by_name(env);
-		if (env_algo == GIT_HASH_UNKNOWN)
-			die(_("unknown hash algorithm '%s'"), env);
-		repo_fmt->hash_algo = env_algo;
-	}
-}
-
-int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, int hash, const char *initial_branch,
-	    int init_shared_repository, unsigned int flags)
-{
-	int reinit;
-	int exist_ok = flags & INIT_DB_EXIST_OK;
-	char *original_git_dir = real_pathdup(git_dir, 1);
-	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	int prev_bare_repository;
-
-	if (real_git_dir) {
-		struct stat st;
-
-		if (!exist_ok && !stat(git_dir, &st))
-			die(_("%s already exists"), git_dir);
-
-		if (!exist_ok && !stat(real_git_dir, &st))
-			die(_("%s already exists"), real_git_dir);
-
-		set_git_dir(real_git_dir, 1);
-		git_dir = get_git_dir();
-		separate_git_dir(git_dir, original_git_dir);
-	}
-	else {
-		set_git_dir(git_dir, 1);
-		git_dir = get_git_dir();
-	}
-	startup_info->have_repository = 1;
-
-	/* Ensure `core.hidedotfiles` is processed */
-	git_config(platform_core_config, NULL);
-
-	safe_create_dir(git_dir, 0);
-
-	prev_bare_repository = is_bare_repository();
-
-	/* Check to see if the repository version is right.
-	 * Note that a newly created repository does not have
-	 * config file, so this will not fail.  What we are catching
-	 * is an attempt to reinitialize new repository with an old tool.
-	 */
-	check_repository_format(&repo_fmt);
-
-	validate_hash_algorithm(&repo_fmt, hash);
-
-	reinit = create_default_files(template_dir, original_git_dir,
-				      initial_branch, &repo_fmt,
-				      prev_bare_repository,
-				      init_shared_repository,
-				      flags & INIT_DB_QUIET);
-	if (reinit && initial_branch)
-		warning(_("re-init: ignored --initial-branch=%s"),
-			initial_branch);
-
-	create_object_directory();
-
-	if (get_shared_repository()) {
-		char buf[10];
-		/* We do not spell "group" and such, so that
-		 * the configuration can be read by older version
-		 * of git. Note, we use octal numbers for new share modes,
-		 * and compatibility values for PERM_GROUP and
-		 * PERM_EVERYBODY.
-		 */
-		if (get_shared_repository() < 0)
-			/* force to the mode value */
-			xsnprintf(buf, sizeof(buf), "0%o", -get_shared_repository());
-		else if (get_shared_repository() == PERM_GROUP)
-			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_GROUP);
-		else if (get_shared_repository() == PERM_EVERYBODY)
-			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
-		else
-			BUG("invalid value for shared_repository");
-		git_config_set("core.sharedrepository", buf);
-		git_config_set("receive.denyNonFastforwards", "true");
-	}
-
-	if (!(flags & INIT_DB_QUIET)) {
-		int len = strlen(git_dir);
-
-		if (reinit)
-			printf(get_shared_repository()
-			       ? _("Reinitialized existing shared Git repository in %s%s\n")
-			       : _("Reinitialized existing Git repository in %s%s\n"),
-			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
-		else
-			printf(get_shared_repository()
-			       ? _("Initialized empty shared Git repository in %s%s\n")
-			       : _("Initialized empty Git repository in %s%s\n"),
-			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
-	}
-
-	free(original_git_dir);
-	return 0;
-}
-
 static int guess_repository_type(const char *git_dir)
 {
 	const char *slash;
diff --git a/cache.h b/cache.h
index 2bc1cd77d9b..8b2eb52f04e 100644
--- a/cache.h
+++ b/cache.h
@@ -322,15 +322,6 @@ void prefetch_cache_entries(const struct index_state *istate,
 extern struct index_state the_index;
 #endif
 
-#define INIT_DB_QUIET 0x0001
-#define INIT_DB_EXIST_OK 0x0002
-
-int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, int hash_algo,
-	    const char *initial_branch, int init_shared_repository,
-	    unsigned int flags);
-void initialize_repository_version(int hash_algo, int reinit);
-
 /* Initialize and use the cache information */
 struct lock_file;
 void preload_index(struct index_state *index,
diff --git a/setup.c b/setup.c
index 59abc16ba6d..1cc1f3b3978 100644
--- a/setup.c
+++ b/setup.c
@@ -1,8 +1,11 @@
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "copy.h"
 #include "environment.h"
+#include "exec-cmd.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "refs.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
@@ -12,6 +15,7 @@
 #include "promisor-remote.h"
 #include "quote.h"
 #include "trace2.h"
+#include "worktree.h"
 #include "wrapper.h"
 
 static int inside_git_dir = -1;
@@ -1706,3 +1710,495 @@ int daemonize(void)
 	return 0;
 #endif
 }
+
+#ifndef DEFAULT_GIT_TEMPLATE_DIR
+#define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
+#endif
+
+#ifdef NO_TRUSTABLE_FILEMODE
+#define TEST_FILEMODE 0
+#else
+#define TEST_FILEMODE 1
+#endif
+
+#define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
+
+static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
+			     DIR *dir)
+{
+	size_t path_baselen = path->len;
+	size_t template_baselen = template_path->len;
+	struct dirent *de;
+
+	/* Note: if ".git/hooks" file exists in the repository being
+	 * re-initialized, /etc/core-git/templates/hooks/update would
+	 * cause "git init" to fail here.  I think this is sane but
+	 * it means that the set of templates we ship by default, along
+	 * with the way the namespace under .git/ is organized, should
+	 * be really carefully chosen.
+	 */
+	safe_create_dir(path->buf, 1);
+	while ((de = readdir(dir)) != NULL) {
+		struct stat st_git, st_template;
+		int exists = 0;
+
+		strbuf_setlen(path, path_baselen);
+		strbuf_setlen(template_path, template_baselen);
+
+		if (de->d_name[0] == '.')
+			continue;
+		strbuf_addstr(path, de->d_name);
+		strbuf_addstr(template_path, de->d_name);
+		if (lstat(path->buf, &st_git)) {
+			if (errno != ENOENT)
+				die_errno(_("cannot stat '%s'"), path->buf);
+		}
+		else
+			exists = 1;
+
+		if (lstat(template_path->buf, &st_template))
+			die_errno(_("cannot stat template '%s'"), template_path->buf);
+
+		if (S_ISDIR(st_template.st_mode)) {
+			DIR *subdir = opendir(template_path->buf);
+			if (!subdir)
+				die_errno(_("cannot opendir '%s'"), template_path->buf);
+			strbuf_addch(path, '/');
+			strbuf_addch(template_path, '/');
+			copy_templates_1(path, template_path, subdir);
+			closedir(subdir);
+		}
+		else if (exists)
+			continue;
+		else if (S_ISLNK(st_template.st_mode)) {
+			struct strbuf lnk = STRBUF_INIT;
+			if (strbuf_readlink(&lnk, template_path->buf,
+					    st_template.st_size) < 0)
+				die_errno(_("cannot readlink '%s'"), template_path->buf);
+			if (symlink(lnk.buf, path->buf))
+				die_errno(_("cannot symlink '%s' '%s'"),
+					  lnk.buf, path->buf);
+			strbuf_release(&lnk);
+		}
+		else if (S_ISREG(st_template.st_mode)) {
+			if (copy_file(path->buf, template_path->buf, st_template.st_mode))
+				die_errno(_("cannot copy '%s' to '%s'"),
+					  template_path->buf, path->buf);
+		}
+		else
+			error(_("ignoring template %s"), template_path->buf);
+	}
+}
+
+static void copy_templates(const char *template_dir, const char *init_template_dir)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf template_path = STRBUF_INIT;
+	size_t template_len;
+	struct repository_format template_format = REPOSITORY_FORMAT_INIT;
+	struct strbuf err = STRBUF_INIT;
+	DIR *dir;
+	char *to_free = NULL;
+
+	if (!template_dir)
+		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
+	if (!template_dir)
+		template_dir = init_template_dir;
+	if (!template_dir)
+		template_dir = to_free = system_path(DEFAULT_GIT_TEMPLATE_DIR);
+	if (!template_dir[0]) {
+		free(to_free);
+		return;
+	}
+
+	strbuf_addstr(&template_path, template_dir);
+	strbuf_complete(&template_path, '/');
+	template_len = template_path.len;
+
+	dir = opendir(template_path.buf);
+	if (!dir) {
+		warning(_("templates not found in %s"), template_dir);
+		goto free_return;
+	}
+
+	/* Make sure that template is from the correct vintage */
+	strbuf_addstr(&template_path, "config");
+	read_repository_format(&template_format, template_path.buf);
+	strbuf_setlen(&template_path, template_len);
+
+	/*
+	 * No mention of version at all is OK, but anything else should be
+	 * verified.
+	 */
+	if (template_format.version >= 0 &&
+	    verify_repository_format(&template_format, &err) < 0) {
+		warning(_("not copying templates from '%s': %s"),
+			  template_dir, err.buf);
+		strbuf_release(&err);
+		goto close_free_return;
+	}
+
+	strbuf_addstr(&path, get_git_common_dir());
+	strbuf_complete(&path, '/');
+	copy_templates_1(&path, &template_path, dir);
+close_free_return:
+	closedir(dir);
+free_return:
+	free(to_free);
+	strbuf_release(&path);
+	strbuf_release(&template_path);
+	clear_repository_format(&template_format);
+}
+
+/*
+ * If the git_dir is not directly inside the working tree, then git will not
+ * find it by default, and we need to set the worktree explicitly.
+ */
+static int needs_work_tree_config(const char *git_dir, const char *work_tree)
+{
+	if (!strcmp(work_tree, "/") && !strcmp(git_dir, "/.git"))
+		return 0;
+	if (skip_prefix(git_dir, work_tree, &git_dir) &&
+	    !strcmp(git_dir, "/.git"))
+		return 0;
+	return 1;
+}
+
+void initialize_repository_version(int hash_algo, int reinit)
+{
+	char repo_version_string[10];
+	int repo_version = GIT_REPO_VERSION;
+
+	if (hash_algo != GIT_HASH_SHA1)
+		repo_version = GIT_REPO_VERSION_READ;
+
+	/* This forces creation of new config file */
+	xsnprintf(repo_version_string, sizeof(repo_version_string),
+		  "%d", repo_version);
+	git_config_set("core.repositoryformatversion", repo_version_string);
+
+	if (hash_algo != GIT_HASH_SHA1)
+		git_config_set("extensions.objectformat",
+			       hash_algos[hash_algo].name);
+	else if (reinit)
+		git_config_set_gently("extensions.objectformat", NULL);
+}
+
+static int create_default_files(const char *template_path,
+				const char *original_git_dir,
+				const char *initial_branch,
+				const struct repository_format *fmt,
+				int prev_bare_repository,
+				int init_shared_repository,
+				int quiet)
+{
+	struct stat st1;
+	struct strbuf buf = STRBUF_INIT;
+	char *path;
+	char junk[2];
+	int reinit;
+	int filemode;
+	struct strbuf err = STRBUF_INIT;
+	const char *init_template_dir = NULL;
+	const char *work_tree = get_git_work_tree();
+
+	/*
+	 * First copy the templates -- we might have the default
+	 * config file there, in which case we would want to read
+	 * from it after installing.
+	 *
+	 * Before reading that config, we also need to clear out any cached
+	 * values (since we've just potentially changed what's available on
+	 * disk).
+	 */
+	git_config_get_pathname("init.templatedir", &init_template_dir);
+	copy_templates(template_path, init_template_dir);
+	free((char *)init_template_dir);
+	git_config_clear();
+	reset_shared_repository();
+	git_config(git_default_config, NULL);
+
+	/*
+	 * We must make sure command-line options continue to override any
+	 * values we might have just re-read from the config.
+	 */
+	if (init_shared_repository != -1)
+		set_shared_repository(init_shared_repository);
+	/*
+	 * TODO: heed core.bare from config file in templates if no
+	 *       command-line override given
+	 */
+	is_bare_repository_cfg = prev_bare_repository || !work_tree;
+	/* TODO (continued):
+	 *
+	 * Unfortunately, the line above is equivalent to
+	 *    is_bare_repository_cfg = !work_tree;
+	 * which ignores the config entirely even if no `--[no-]bare`
+	 * command line option was present.
+	 *
+	 * To see why, note that before this function, there was this call:
+	 *    prev_bare_repository = is_bare_repository()
+	 * expanding the right hand side:
+	 *                 = is_bare_repository_cfg && !get_git_work_tree()
+	 *                 = is_bare_repository_cfg && !work_tree
+	 * note that the last simplification above is valid because nothing
+	 * calls repo_init() or set_git_work_tree() between any of the
+	 * relevant calls in the code, and thus the !get_git_work_tree()
+	 * calls will return the same result each time.  So, what we are
+	 * interested in computing is the right hand side of the line of
+	 * code just above this comment:
+	 *     prev_bare_repository || !work_tree
+	 *        = is_bare_repository_cfg && !work_tree || !work_tree
+	 *        = !work_tree
+	 * because "A && !B || !B == !B" for all boolean values of A & B.
+	 */
+
+	/*
+	 * We would have created the above under user's umask -- under
+	 * shared-repository settings, we would need to fix them up.
+	 */
+	if (get_shared_repository()) {
+		adjust_shared_perm(get_git_dir());
+	}
+
+	/*
+	 * We need to create a "refs" dir in any case so that older
+	 * versions of git can tell that this is a repository.
+	 */
+	safe_create_dir(git_path("refs"), 1);
+	adjust_shared_perm(git_path("refs"));
+
+	if (refs_init_db(&err))
+		die("failed to set up refs db: %s", err.buf);
+
+	/*
+	 * Point the HEAD symref to the initial branch with if HEAD does
+	 * not yet exist.
+	 */
+	path = git_path_buf(&buf, "HEAD");
+	reinit = (!access(path, R_OK)
+		  || readlink(path, junk, sizeof(junk)-1) != -1);
+	if (!reinit) {
+		char *ref;
+
+		if (!initial_branch)
+			initial_branch = git_default_branch_name(quiet);
+
+		ref = xstrfmt("refs/heads/%s", initial_branch);
+		if (check_refname_format(ref, 0) < 0)
+			die(_("invalid initial branch name: '%s'"),
+			    initial_branch);
+
+		if (create_symref("HEAD", ref, NULL) < 0)
+			exit(1);
+		free(ref);
+	}
+
+	initialize_repository_version(fmt->hash_algo, 0);
+
+	/* Check filemode trustability */
+	path = git_path_buf(&buf, "config");
+	filemode = TEST_FILEMODE;
+	if (TEST_FILEMODE && !lstat(path, &st1)) {
+		struct stat st2;
+		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
+				!lstat(path, &st2) &&
+				st1.st_mode != st2.st_mode &&
+				!chmod(path, st1.st_mode));
+		if (filemode && !reinit && (st1.st_mode & S_IXUSR))
+			filemode = 0;
+	}
+	git_config_set("core.filemode", filemode ? "true" : "false");
+
+	if (is_bare_repository())
+		git_config_set("core.bare", "true");
+	else {
+		git_config_set("core.bare", "false");
+		/* allow template config file to override the default */
+		if (log_all_ref_updates == LOG_REFS_UNSET)
+			git_config_set("core.logallrefupdates", "true");
+		if (needs_work_tree_config(original_git_dir, work_tree))
+			git_config_set("core.worktree", work_tree);
+	}
+
+	if (!reinit) {
+		/* Check if symlink is supported in the work tree */
+		path = git_path_buf(&buf, "tXXXXXX");
+		if (!close(xmkstemp(path)) &&
+		    !unlink(path) &&
+		    !symlink("testing", path) &&
+		    !lstat(path, &st1) &&
+		    S_ISLNK(st1.st_mode))
+			unlink(path); /* good */
+		else
+			git_config_set("core.symlinks", "false");
+
+		/* Check if the filesystem is case-insensitive */
+		path = git_path_buf(&buf, "CoNfIg");
+		if (!access(path, F_OK))
+			git_config_set("core.ignorecase", "true");
+		probe_utf8_pathname_composition();
+	}
+
+	strbuf_release(&buf);
+	return reinit;
+}
+
+static void create_object_directory(void)
+{
+	struct strbuf path = STRBUF_INIT;
+	size_t baselen;
+
+	strbuf_addstr(&path, get_object_directory());
+	baselen = path.len;
+
+	safe_create_dir(path.buf, 1);
+
+	strbuf_setlen(&path, baselen);
+	strbuf_addstr(&path, "/pack");
+	safe_create_dir(path.buf, 1);
+
+	strbuf_setlen(&path, baselen);
+	strbuf_addstr(&path, "/info");
+	safe_create_dir(path.buf, 1);
+
+	strbuf_release(&path);
+}
+
+static void separate_git_dir(const char *git_dir, const char *git_link)
+{
+	struct stat st;
+
+	if (!stat(git_link, &st)) {
+		const char *src;
+
+		if (S_ISREG(st.st_mode))
+			src = read_gitfile(git_link);
+		else if (S_ISDIR(st.st_mode))
+			src = git_link;
+		else
+			die(_("unable to handle file type %d"), (int)st.st_mode);
+
+		if (rename(src, git_dir))
+			die_errno(_("unable to move %s to %s"), src, git_dir);
+		repair_worktrees(NULL, NULL);
+	}
+
+	write_file(git_link, "gitdir: %s", git_dir);
+}
+
+static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash)
+{
+	const char *env = getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
+	/*
+	 * If we already have an initialized repo, don't allow the user to
+	 * specify a different algorithm, as that could cause corruption.
+	 * Otherwise, if the user has specified one on the command line, use it.
+	 */
+	if (repo_fmt->version >= 0 && hash != GIT_HASH_UNKNOWN && hash != repo_fmt->hash_algo)
+		die(_("attempt to reinitialize repository with different hash"));
+	else if (hash != GIT_HASH_UNKNOWN)
+		repo_fmt->hash_algo = hash;
+	else if (env) {
+		int env_algo = hash_algo_by_name(env);
+		if (env_algo == GIT_HASH_UNKNOWN)
+			die(_("unknown hash algorithm '%s'"), env);
+		repo_fmt->hash_algo = env_algo;
+	}
+}
+
+int init_db(const char *git_dir, const char *real_git_dir,
+	    const char *template_dir, int hash, const char *initial_branch,
+	    int init_shared_repository, unsigned int flags)
+{
+	int reinit;
+	int exist_ok = flags & INIT_DB_EXIST_OK;
+	char *original_git_dir = real_pathdup(git_dir, 1);
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	int prev_bare_repository;
+
+	if (real_git_dir) {
+		struct stat st;
+
+		if (!exist_ok && !stat(git_dir, &st))
+			die(_("%s already exists"), git_dir);
+
+		if (!exist_ok && !stat(real_git_dir, &st))
+			die(_("%s already exists"), real_git_dir);
+
+		set_git_dir(real_git_dir, 1);
+		git_dir = get_git_dir();
+		separate_git_dir(git_dir, original_git_dir);
+	}
+	else {
+		set_git_dir(git_dir, 1);
+		git_dir = get_git_dir();
+	}
+	startup_info->have_repository = 1;
+
+	/* Ensure `core.hidedotfiles` is processed */
+	git_config(platform_core_config, NULL);
+
+	safe_create_dir(git_dir, 0);
+
+	prev_bare_repository = is_bare_repository();
+
+	/* Check to see if the repository version is right.
+	 * Note that a newly created repository does not have
+	 * config file, so this will not fail.  What we are catching
+	 * is an attempt to reinitialize new repository with an old tool.
+	 */
+	check_repository_format(&repo_fmt);
+
+	validate_hash_algorithm(&repo_fmt, hash);
+
+	reinit = create_default_files(template_dir, original_git_dir,
+				      initial_branch, &repo_fmt,
+				      prev_bare_repository,
+				      init_shared_repository,
+				      flags & INIT_DB_QUIET);
+	if (reinit && initial_branch)
+		warning(_("re-init: ignored --initial-branch=%s"),
+			initial_branch);
+
+	create_object_directory();
+
+	if (get_shared_repository()) {
+		char buf[10];
+		/* We do not spell "group" and such, so that
+		 * the configuration can be read by older version
+		 * of git. Note, we use octal numbers for new share modes,
+		 * and compatibility values for PERM_GROUP and
+		 * PERM_EVERYBODY.
+		 */
+		if (get_shared_repository() < 0)
+			/* force to the mode value */
+			xsnprintf(buf, sizeof(buf), "0%o", -get_shared_repository());
+		else if (get_shared_repository() == PERM_GROUP)
+			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_GROUP);
+		else if (get_shared_repository() == PERM_EVERYBODY)
+			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
+		else
+			BUG("invalid value for shared_repository");
+		git_config_set("core.sharedrepository", buf);
+		git_config_set("receive.denyNonFastforwards", "true");
+	}
+
+	if (!(flags & INIT_DB_QUIET)) {
+		int len = strlen(git_dir);
+
+		if (reinit)
+			printf(get_shared_repository()
+			       ? _("Reinitialized existing shared Git repository in %s%s\n")
+			       : _("Reinitialized existing Git repository in %s%s\n"),
+			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+		else
+			printf(get_shared_repository()
+			       ? _("Initialized empty shared Git repository in %s%s\n")
+			       : _("Initialized empty Git repository in %s%s\n"),
+			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+	}
+
+	free(original_git_dir);
+	return 0;
+}
diff --git a/setup.h b/setup.h
index 4c1ca9d0c94..58fd2605dd2 100644
--- a/setup.h
+++ b/setup.h
@@ -140,6 +140,15 @@ int verify_repository_format(const struct repository_format *format,
  */
 void check_repository_format(struct repository_format *fmt);
 
+#define INIT_DB_QUIET 0x0001
+#define INIT_DB_EXIST_OK 0x0002
+
+int init_db(const char *git_dir, const char *real_git_dir,
+	    const char *template_dir, int hash_algo,
+	    const char *initial_branch, int init_shared_repository,
+	    unsigned int flags);
+void initialize_repository_version(int hash_algo, int reinit);
+
 /*
  * NOTE NOTE NOTE!!
  *
-- 
gitgitgadget

