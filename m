Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232F11F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 09:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438519AbfJXJ1y (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 05:27:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53520 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391315AbfJXJ1y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 05:27:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id n7so1137596wmc.3
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPpLnEf/6Fisje5dFjMbIU3XhbfCRKON5cbvArx9mmE=;
        b=Ink1LnODF4NdUGyuYPemZyB0f1lLG4RjQPfgP94Wahm0XNAnU1QGc9WnixwX6WSLqN
         Rh21sY42AlE8Rks6+U0yp9gRp6zsvsSB+4gAaGrW6sAU1Vh5XhUQPKZVxw1mtWXpgc2J
         E9iDQ7H0EJrNVdk2Ph78/FMXKeHJJld96BXVOwtzDxC/0+Dt2yDc8T0UDZpvQCtAyrJV
         K1kNSpu4MXBniY7HgVfkRoyoA+yc7o/Qw4wMU52OI4rWmNkdTQWOUMSzNYG12ogXaGAv
         SGaOCMfFmeURBqvoZPZ4Pdhcl/a4DEfsFIeuhwWY9VkTqHUb9jBXGwHpEYnPOrrDPfFn
         47NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPpLnEf/6Fisje5dFjMbIU3XhbfCRKON5cbvArx9mmE=;
        b=LFKqEGJ6lFW9XKugOjp+Gazxe79KQnq2siQKCzJ0KGUsHAAnxyXHQ6jOUMdgHpEVE2
         aS+GT+RLDVlpK8dLK0KWcIO/xfxB76DhAhpMUYl3fY1InA6X3LHaKl0tGx8V57lFb6wS
         iF0fe5VvQMm/fgmxFyLgVLlf3RYYdpnFLbI6b1dUicDWTBq8CrB8ikvALAaMrGwqjmu9
         FfGDswDhKegJvN99BeK9ws8/ma6ogDG0seBMe8Cd/DfkeJCoSzL2Gu7QAr3aHxCPxSYE
         ramZcALRnCsUN9WymB8QJ19gpOTu4+xzUc/qhtLS9CteyMew9SWru1vySSeLK+SXYHZN
         StgA==
X-Gm-Message-State: APjAAAWo5no1x3wFQOidNTbrKrPJ7YGhxO1h9xvwUEHRPY4MWgi7A/fF
        fH20OwfdZJfhqe/54zs0x/atjbeM
X-Google-Smtp-Source: APXvYqwe4efuUQwpOcpKmIJ5+F9ggshBcSYgmeyjlHiZaWn+z+BvazKP0i5BfPamVBJTmU0L9qIkTA==
X-Received: by 2002:a1c:8189:: with SMTP id c131mr3902524wmd.151.1571909269803;
        Thu, 24 Oct 2019 02:27:49 -0700 (PDT)
Received: from localhost.localdomain ([139.47.116.239])
        by smtp.gmail.com with ESMTPSA id v10sm18110431wrm.26.2019.10.24.02.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 02:27:49 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and `is_directory()`
Date:   Thu, 24 Oct 2019 11:27:45 +0200
Message-Id: <20191024092745.97035-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dir_exists() function in builtin/clone.c is marked as static, so
nobody can use it outside builtin/clone.c.

There is also is_directory() which obviously tries to do the very same, but it uses a name that few developers will think of when they see file_exists() and look for the equivalent function to see whether a given directory exists.

Let's reconcile these functions by renaming is_directory() to dir_exists() and using it also in builtin/clone.c.

Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 abspath.c                   |  2 +-
 builtin/am.c                |  2 +-
 builtin/clone.c             |  6 ------
 builtin/mv.c                |  2 +-
 builtin/rebase.c            | 10 +++++-----
 builtin/submodule--helper.c |  4 ++--
 builtin/worktree.c          |  6 +++---
 cache.h                     |  2 +-
 compat/mingw.c              |  2 +-
 daemon.c                    |  2 +-
 diff-no-index.c             |  4 ++--
 dir.c                       |  2 +-
 gettext.c                   |  2 +-
 rerere.c                    |  2 +-
 sequencer.c                 |  2 +-
 sha1-file.c                 |  8 ++++----
 submodule.c                 |  4 ++--
 trace2/tr2_dst.c            |  2 +-
 worktree.c                  |  2 +-
 19 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/abspath.c b/abspath.c
index 9857985329..13bd92eca5 100644
--- a/abspath.c
+++ b/abspath.c
@@ -5,7 +5,7 @@
  * symlink to a directory, we do not want to say it is a directory when
  * dealing with tracked content in the working tree.
  */
-int is_directory(const char *path)
+int dir_exists(const char *path)
 {
 	struct stat st;
 	return (!stat(path, &st) && S_ISDIR(st.st_mode));
diff --git a/builtin/am.c b/builtin/am.c
index 8181c2aef3..f872125fc7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -576,7 +576,7 @@ static int detect_patch_format(const char **paths)
 	/*
 	 * We default to mbox format if input is from stdin and for directories
 	 */
-	if (!*paths || !strcmp(*paths, "-") || is_directory(*paths))
+	if (!*paths || !strcmp(*paths, "-") || dir_exists(*paths))
 		return PATCH_FORMAT_MBOX;
 
 	/*
diff --git a/builtin/clone.c b/builtin/clone.c
index c46ee29f0a..f89938bf94 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -899,12 +899,6 @@ static void dissociate_from_references(void)
 	free(alternates);
 }
 
-static int dir_exists(const char *path)
-{
-	struct stat sb;
-	return !stat(path, &sb);
-}
-
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
diff --git a/builtin/mv.c b/builtin/mv.c
index be15ba7044..194e1618a0 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -152,7 +152,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	 * "git mv directory no-such-dir/".
 	 */
 	flags = KEEP_TRAILING_SLASH;
-	if (argc == 1 && is_directory(argv[0]) && !is_directory(argv[1]))
+	if (argc == 1 && dir_exists(argv[0]) && !dir_exists(argv[1]))
 		flags = 0;
 	dest_path = internal_prefix_pathspec(prefix, argv + argc, 1, flags);
 	submodule_gitfile = xcalloc(argc, sizeof(char *));
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4a20582e72..c66cdf729b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -275,7 +275,7 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 {
 	FILE *interactive;
 
-	if (!is_directory(merge_dir()) && mkdir_in_gitdir(merge_dir()))
+	if (!dir_exists(merge_dir()) && mkdir_in_gitdir(merge_dir()))
 		return error_errno(_("could not create temporary %s"), merge_dir());
 
 	delete_reflog("REBASE_HEAD");
@@ -1068,7 +1068,7 @@ static int run_am(struct rebase_options *opts)
 		return move_to_original_branch(opts);
 	}
 
-	if (is_directory(opts->state_dir))
+	if (dir_exists(opts->state_dir))
 		rebase_write_basic_state(opts);
 
 	return status;
@@ -1529,13 +1529,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if(file_exists(buf.buf))
 		die(_("It looks like 'git am' is in progress. Cannot rebase."));
 
-	if (is_directory(apply_dir())) {
+	if (dir_exists(apply_dir())) {
 		options.type = REBASE_AM;
 		options.state_dir = apply_dir();
-	} else if (is_directory(merge_dir())) {
+	} else if (dir_exists(merge_dir())) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s/rewritten", merge_dir());
-		if (is_directory(buf.buf)) {
+		if (dir_exists(buf.buf)) {
 			options.type = REBASE_PRESERVE_MERGES;
 			options.flags |= REBASE_INTERACTIVE_EXPLICIT;
 		} else {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2c2395a620..8df36e06b4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1096,7 +1096,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	displaypath = get_submodule_displaypath(path, prefix);
 
 	/* remove the submodule work tree (unless the user already did it) */
-	if (is_directory(path)) {
+	if (dir_exists(path)) {
 		struct strbuf sb_rm = STRBUF_INIT;
 		const char *format;
 
@@ -1105,7 +1105,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 		 * NEEDSWORK: instead of dying, automatically call
 		 * absorbgitdirs and (possibly) warn.
 		 */
-		if (is_directory(sub_git_dir))
+		if (dir_exists(sub_git_dir))
 			die(_("Submodule work tree '%s' contains a .git "
 			      "directory (use 'rm -rf' if you really want "
 			      "to remove it including all of its history)"),
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4de44f579a..a69a1e5612 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -75,7 +75,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	size_t len;
 	ssize_t read_result;
 
-	if (!is_directory(git_path("worktrees/%s", id))) {
+	if (!dir_exists(git_path("worktrees/%s", id))) {
 		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"), id);
 		return 1;
 	}
@@ -738,7 +738,7 @@ static void validate_no_submodules(const struct worktree *wt)
 	struct strbuf path = STRBUF_INIT;
 	int i, found_submodules = 0;
 
-	if (is_directory(worktree_git_path(wt, "modules"))) {
+	if (dir_exists(worktree_git_path(wt, "modules"))) {
 		/*
 		 * There could be false positives, e.g. the "modules"
 		 * directory exists but is empty. But it's a rare case and
@@ -799,7 +799,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("'%s' is a main working tree"), av[0]);
-	if (is_directory(dst.buf)) {
+	if (dir_exists(dst.buf)) {
 		const char *sep = find_last_dir_sep(wt->path);
 
 		if (!sep)
diff --git a/cache.h b/cache.h
index 04cabaac11..596de2db38 100644
--- a/cache.h
+++ b/cache.h
@@ -1274,7 +1274,7 @@ static inline int is_absolute_path(const char *path)
 {
 	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
 }
-int is_directory(const char *);
+int dir_exists(const char *);
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
 const char *real_path(const char *path);
diff --git a/compat/mingw.c b/compat/mingw.c
index 6b765d936c..9e391a2a74 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2352,7 +2352,7 @@ static void setup_windows_environment(void)
 			strbuf_addstr(&buf, tmp);
 			if ((tmp = getenv("HOMEPATH"))) {
 				strbuf_addstr(&buf, tmp);
-				if (is_directory(buf.buf))
+				if (dir_exists(buf.buf))
 					setenv("HOME", buf.buf, 1);
 				else
 					tmp = NULL; /* use $USERPROFILE */
diff --git a/daemon.c b/daemon.c
index 9d2e0d20ef..050c1ffacf 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1455,7 +1455,7 @@ int cmd_main(int argc, const char **argv)
 	if (strict_paths && (!ok_paths || !*ok_paths))
 		die("option --strict-paths requires a whitelist");
 
-	if (base_path && !is_directory(base_path))
+	if (base_path && !dir_exists(base_path))
 		die("base-path '%s' does not exist or is not a directory",
 		    base_path);
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 7814eabfe0..7f6e17fc76 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -221,8 +221,8 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 	if (path[0] == file_from_standard_input ||
 	    path[1] == file_from_standard_input)
 		return;
-	isdir0 = is_directory(path[0]);
-	isdir1 = is_directory(path[1]);
+	isdir0 = dir_exists(path[0]);
+	isdir1 = dir_exists(path[1]);
 	if (isdir0 == isdir1)
 		return;
 	if (isdir0) {
diff --git a/dir.c b/dir.c
index 61f559f980..fd22bc1866 100644
--- a/dir.c
+++ b/dir.c
@@ -2100,7 +2100,7 @@ static int treat_leading_path(struct dir_struct *dir,
 			baselen = cp - path;
 		strbuf_setlen(&sb, 0);
 		strbuf_add(&sb, path, baselen);
-		if (!is_directory(sb.buf))
+		if (!dir_exists(sb.buf))
 			break;
 		if (simplify_away(sb.buf, sb.len, pathspec))
 			break;
diff --git a/gettext.c b/gettext.c
index 35d2c1218d..c02f6675fa 100644
--- a/gettext.c
+++ b/gettext.c
@@ -183,7 +183,7 @@ void git_setup_gettext(void)
 
 	use_gettext_poison(); /* getenv() reentrancy paranoia */
 
-	if (!is_directory(podir)) {
+	if (!dir_exists(podir)) {
 		free(p);
 		return;
 	}
diff --git a/rerere.c b/rerere.c
index 3e51fdfe58..1d6a4b8df2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -873,7 +873,7 @@ static int is_rerere_enabled(void)
 	if (!rerere_enabled)
 		return 0;
 
-	rr_cache_exists = is_directory(git_path_rr_cache());
+	rr_cache_exists = dir_exists(git_path_rr_cache());
 	if (rerere_enabled < 0)
 		return rr_cache_exists;
 
diff --git a/sequencer.c b/sequencer.c
index 9d5964fd81..ee27b7b1cd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2813,7 +2813,7 @@ int sequencer_skip(struct repository *r, struct replay_opts *opts)
 
 	if (skip_single_pick())
 		return error(_("failed to skip the commit"));
-	if (!is_directory(git_path_seq_dir()))
+	if (!dir_exists(git_path_seq_dir()))
 		return 0;
 
 	return sequencer_continue(r, opts);
diff --git a/sha1-file.c b/sha1-file.c
index 188de57634..7fcf89d431 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -448,7 +448,7 @@ static int alt_odb_usable(struct raw_object_store *o,
 	struct object_directory *odb;
 
 	/* Detect cases where alternate disappeared */
-	if (!is_directory(path->buf)) {
+	if (!dir_exists(path->buf)) {
 		error(_("object directory %s does not exist; "
 			"check .git/objects/info/alternates"),
 		      path->buf);
@@ -699,11 +699,11 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 		ref_git = xstrdup(repo);
 	}
 
-	if (!repo && is_directory(mkpath("%s/.git/objects", ref_git))) {
+	if (!repo && dir_exists(mkpath("%s/.git/objects", ref_git))) {
 		char *ref_git_git = mkpathdup("%s/.git", ref_git);
 		free(ref_git);
 		ref_git = ref_git_git;
-	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
+	} else if (!dir_exists(mkpath("%s/objects", ref_git))) {
 		struct strbuf sb = STRBUF_INIT;
 		seen_error = 1;
 		if (get_common_dir(&sb, ref_git)) {
@@ -821,7 +821,7 @@ static int refs_from_alternate_cb(struct object_directory *e,
 
 	/* Is this a git repository with refs? */
 	strbuf_addstr(&path, "/refs");
-	if (!is_directory(path.buf))
+	if (!dir_exists(path.buf))
 		goto out;
 	strbuf_setlen(&path, base_len);
 
diff --git a/submodule.c b/submodule.c
index 0f199c5137..870f35cd56 100644
--- a/submodule.c
+++ b/submodule.c
@@ -174,7 +174,7 @@ int add_submodule_odb(const char *path)
 	ret = strbuf_git_path_submodule(&objects_directory, path, "objects/");
 	if (ret)
 		goto done;
-	if (!is_directory(objects_directory.buf)) {
+	if (!dir_exists(objects_directory.buf)) {
 		ret = -1;
 		goto done;
 	}
@@ -1647,7 +1647,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	if (!git_dir)
 		git_dir = buf.buf;
 	if (!is_git_directory(git_dir)) {
-		if (is_directory(git_dir))
+		if (dir_exists(git_dir))
 			die(_("'%s' not recognized as a git repository"), git_dir);
 		strbuf_release(&buf);
 		/* The submodule is not checked out, so it is not modified */
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index ae052a07fe..fe0b4d94ff 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -337,7 +337,7 @@ int tr2_dst_get_trace_fd(struct tr2_dst *dst)
 	}
 
 	if (is_absolute_path(tgt_value)) {
-		if (is_directory(tgt_value))
+		if (dir_exists(tgt_value))
 			return tr2_dst_try_auto_path(dst, tgt_value);
 		else
 			return tr2_dst_try_path(dst, tgt_value);
diff --git a/worktree.c b/worktree.c
index 5b4793caa3..e2d2e2dbf1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -290,7 +290,7 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 	strbuf_addf(&wt_path, "%s/.git", wt->path);
 
 	if (is_main_worktree(wt)) {
-		if (is_directory(wt_path.buf)) {
+		if (dir_exists(wt_path.buf)) {
 			ret = 0;
 			goto done;
 		}
-- 
2.21.0 (Apple Git-122)

