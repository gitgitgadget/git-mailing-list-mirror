Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63822C77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjEGDqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjEGDqD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:03 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDA144B2
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:45:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f19afc4fbfso32726285e9.2
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431157; x=1686023157;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7vB7OK1bCwUg02gAbjXun64s8+C19DR+pJ8kvk6V1M=;
        b=PcGYN9sOtgTKSUnEDgE+B7k+OF9w7NRoTkUSespWkklilL7+w9sOsEjxauhlgW4rSa
         Xtv1fVh3yrhe8/n2iUF9WOdpZ1pw7CbjkvG6k8M6uYO/Xm1J0LuNg+X/dR3TsZNPtb0e
         GksOrHdHB/xtKpJ+IvxARtCzcUh8ybkmCXjrAP/dfve1JAx/6uHphUoFZa90Vgiw2d1Z
         JUlRCd2JO27WmpKEzKxccTJ4czZbvrY5E57TA02QsfdZKG1wsAvxidpbYXc9q4oj1T6j
         7OKz9/86k2v0jTAypmZFU0LLxD4fAt/MoBv+ngv/6+jWUkFNSJWsMWgNCicQyoi11vrt
         HaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431157; x=1686023157;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7vB7OK1bCwUg02gAbjXun64s8+C19DR+pJ8kvk6V1M=;
        b=FUA2MViGv8yD28ghzzVyfpHUa+wy2Ah2+ieFB4Wox49jbQCcYRz4cSX7UBCXNZQ3lf
         /EUrOJKXUUDOavgnCc2hC8YsV6Xd8MJXlsa7lszYMoEHpm8GiKzb+Sp2cZH2qYEpDSQ3
         gs+xY6anxzUXg5fCP9/o+nEW26Hr5m4lu1KgRZidit3v8CqPfxif0fejB8Rg1yBjBmOv
         CZtfSX9d+E9CvC5uFZTtQcLC0JQEDRKuhfZWip6mNNrI0yzk100uzEX4cvGZMmmXqOQ8
         cre9IYn5Exhm8CKugTZzjByJhbbjqxc+/1ycmqfgC0xNmYjAVfXNwZ76hQEjkB8OP4rw
         Cddg==
X-Gm-Message-State: AC+VfDwCbJ9kj6sBxLm/ipr+23NhGRUt6EU9UKEl9vCvmtIRY9WZeFHN
        iYXX27nBE6mlGd/cpI7Jv3ndMjlK+Wo=
X-Google-Smtp-Source: ACHHUZ4x0DyzdoMxjtHOkFEbgjkbopSkhIRb7dpEFIX7Jqf55cpf3cBRIN7rA+yhhdRX1RD3fackbg==
X-Received: by 2002:a05:600c:3781:b0:3ee:36f:3485 with SMTP id o1-20020a05600c378100b003ee036f3485mr3987274wmr.8.1683431156846;
        Sat, 06 May 2023 20:45:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8-20020a1ccc08000000b003f17eaae2c9sm12520800wmb.1.2023.05.06.20.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:45:56 -0700 (PDT)
Message-Id: <dffbac9a49408620e49450600ffec13048b2cb4d.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:28 +0000
Subject: [PATCH 03/24] setup: adopt shared init-db & clone code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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
 builtin/init-db.c | 479 ----------------------------------------------
 cache.h           |   9 -
 setup.c           | 479 ++++++++++++++++++++++++++++++++++++++++++++++
 setup.h           |   9 +
 4 files changed, 488 insertions(+), 488 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0b30ea2d9ed..feb019a9dea 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -6,494 +6,15 @@
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
-	 *
-	 * Unfortunately, this location in the code is far too late to
-	 * allow this to happen; both builtin/init.db and
-	 * builtin/clone.c setup the new repository and call
-	 * set_git_work_tree() before this point.  (Note that both do
-	 * that repository setup before calling init_db(), which in
-	 * turn calls create_default_files().)  Fixing it would
-	 * require too much refactoring, and no one seems to have
-	 * wanted this behavior in 15+ years, so we'll continue
-	 * ignoring the config for now and just override
-	 * is_bare_repository_cfg unconditionally.
-	 */
-	is_bare_repository_cfg = is_bare_repository() || !work_tree;
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
index 59abc16ba6d..0c14a4fe765 100644
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
@@ -1706,3 +1710,478 @@ int daemonize(void)
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
+	 *
+	 * Unfortunately, this location in the code is far too late to
+	 * allow this to happen; both builtin/init.db and
+	 * builtin/clone.c setup the new repository and call
+	 * set_git_work_tree() before this point.  (Note that both do
+	 * that repository setup before calling init_db(), which in
+	 * turn calls create_default_files().)  Fixing it would
+	 * require too much refactoring, and no one seems to have
+	 * wanted this behavior in 15+ years, so we'll continue
+	 * ignoring the config for now and just override
+	 * is_bare_repository_cfg unconditionally.
+	 */
+	is_bare_repository_cfg = is_bare_repository() || !work_tree;
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

