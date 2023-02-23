Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0049CC636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjBWJPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjBWJPG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:15:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89353C7B3
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h14so1400428wru.4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u27gOH9RYe6QyCkl0ejZiHnwquTtRxgSgfFbllh58Y=;
        b=FTnbkWP/V0+7ylZ3VK3fAHe1yCmHWkMZbFyVi7WYrfyjYMN2ukRmAV1LWYZgAum+MS
         xM49hcWwOfliD0v+80CCr578z7gTER3uie45z+on+A2BDbH6gEhxmf3/oweRt6WPatvI
         9vimPu7V6dMSdkREyOny+mFiuU5L1IBNYsccMKpmTydbMUC33Ia0GvZZd7K+ckEHyLDh
         +sIlX5dplcmNmVP3gTzkKCNqxTKQbgXOA9cSQFI2csJps1gX6xKveR9Zznerp6mYBiAT
         98TklwC+//j39EWj/0UAQ+VbYJRBIyoqtNtCQnYY0yvZgVeCYUXqTv5AdKmzTVtbghiY
         kMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+u27gOH9RYe6QyCkl0ejZiHnwquTtRxgSgfFbllh58Y=;
        b=PUWYPe5jON+xYiXNgyBcIipGI0YS833ymFxtzMiUAVYOV4wS7xLaolQO/3RGm3BbN6
         GvTFTkF3uc5V9aSgpyxFdVJX0XzjQhF4qi1mKgHWci5OsywABJK2g10LxvsLIM5M8q7X
         gXufn6GGkkCj8ECrY5rG6DLF2gyY+sIxfkEN48qsiL9XgCtZFaijjwNzsW33ySbNUVkN
         FDQwcbukhBEQ/j9UgSFVIIv8RParxjTqRCfg9i5nsvM9WJSFcamDR4LF5NA1/ufuuIE8
         v/71Eov3bGQyUxWPyuEMze4FNMGxOPowPVs6e1qHVn8tcQ2GduyJmni7xZhJN3394pge
         +OqQ==
X-Gm-Message-State: AO0yUKVfBDNtRJLzi5+vYR7Zh34kFGlY9pPJWu5aBLIpthaoA48LNfin
        KemFUnlOztdc65LNcQjNx1ZFAZNWDws=
X-Google-Smtp-Source: AK7set/S4ebWSFpMQwqhUxKcxQOZ50QmCLN4pWfNIjJWAmZmQ+9w8n1kTHIbHGnC5+AzMNSFOipA8A==
X-Received: by 2002:a5d:6b4d:0:b0:2c6:67eb:a9d7 with SMTP id x13-20020a5d6b4d000000b002c667eba9d7mr11113016wrw.27.1677143701890;
        Thu, 23 Feb 2023 01:15:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2-20020adfed02000000b002c70851fdd8sm4913827wro.75.2023.02.23.01.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:15:01 -0800 (PST)
Message-Id: <7f59ad548d0cbeeffb3917765084418df520ec22.1677143700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 09:14:50 +0000
Subject: [PATCH 01/11] dir: separate public from internal portion of
 dir_struct
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

In order to make it clearer to callers what portions of dir_struct are
public API, and avoid errors from them setting fields that are meant as
internal API, split the fields used for internal implementation reasons
into a separate embedded struct.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 114 +++++++++++++++++++++++++++++-----------------------------
 dir.h |  86 +++++++++++++++++++++++---------------------
 2 files changed, 104 insertions(+), 96 deletions(-)

diff --git a/dir.c b/dir.c
index 4e99f0c868f..7adf242026e 100644
--- a/dir.c
+++ b/dir.c
@@ -1190,7 +1190,7 @@ struct pattern_list *add_pattern_list(struct dir_struct *dir,
 	struct pattern_list *pl;
 	struct exclude_list_group *group;
 
-	group = &dir->exclude_list_group[group_type];
+	group = &dir->internal.exclude_list_group[group_type];
 	ALLOC_GROW(group->pl, group->nr + 1, group->alloc);
 	pl = &group->pl[group->nr++];
 	memset(pl, 0, sizeof(*pl));
@@ -1211,7 +1211,7 @@ static void add_patterns_from_file_1(struct dir_struct *dir, const char *fname,
 	 * differently when dir->untracked is non-NULL.
 	 */
 	if (!dir->untracked)
-		dir->unmanaged_exclude_files++;
+		dir->internal.unmanaged_exclude_files++;
 	pl = add_pattern_list(dir, EXC_FILE, fname);
 	if (add_patterns(fname, "", 0, pl, NULL, 0, oid_stat) < 0)
 		die(_("cannot use %s as an exclude file"), fname);
@@ -1219,7 +1219,7 @@ static void add_patterns_from_file_1(struct dir_struct *dir, const char *fname,
 
 void add_patterns_from_file(struct dir_struct *dir, const char *fname)
 {
-	dir->unmanaged_exclude_files++; /* see validate_untracked_cache() */
+	dir->internal.unmanaged_exclude_files++; /* see validate_untracked_cache() */
 	add_patterns_from_file_1(dir, fname, NULL);
 }
 
@@ -1519,7 +1519,7 @@ static struct path_pattern *last_matching_pattern_from_lists(
 	struct exclude_list_group *group;
 	struct path_pattern *pattern;
 	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
-		group = &dir->exclude_list_group[i];
+		group = &dir->internal.exclude_list_group[i];
 		for (j = group->nr - 1; j >= 0; j--) {
 			pattern = last_matching_pattern_from_list(
 				pathname, pathlen, basename, dtype_p,
@@ -1545,20 +1545,20 @@ static void prep_exclude(struct dir_struct *dir,
 	struct untracked_cache_dir *untracked;
 	int current;
 
-	group = &dir->exclude_list_group[EXC_DIRS];
+	group = &dir->internal.exclude_list_group[EXC_DIRS];
 
 	/*
 	 * Pop the exclude lists from the EXCL_DIRS exclude_list_group
 	 * which originate from directories not in the prefix of the
 	 * path being checked.
 	 */
-	while ((stk = dir->exclude_stack) != NULL) {
+	while ((stk = dir->internal.exclude_stack) != NULL) {
 		if (stk->baselen <= baselen &&
-		    !strncmp(dir->basebuf.buf, base, stk->baselen))
+		    !strncmp(dir->internal.basebuf.buf, base, stk->baselen))
 			break;
-		pl = &group->pl[dir->exclude_stack->exclude_ix];
-		dir->exclude_stack = stk->prev;
-		dir->pattern = NULL;
+		pl = &group->pl[dir->internal.exclude_stack->exclude_ix];
+		dir->internal.exclude_stack = stk->prev;
+		dir->internal.pattern = NULL;
 		free((char *)pl->src); /* see strbuf_detach() below */
 		clear_pattern_list(pl);
 		free(stk);
@@ -1566,7 +1566,7 @@ static void prep_exclude(struct dir_struct *dir,
 	}
 
 	/* Skip traversing into sub directories if the parent is excluded */
-	if (dir->pattern)
+	if (dir->internal.pattern)
 		return;
 
 	/*
@@ -1574,12 +1574,12 @@ static void prep_exclude(struct dir_struct *dir,
 	 * memset(dir, 0, sizeof(*dir)) before use. Changing all of
 	 * them seems lots of work for little benefit.
 	 */
-	if (!dir->basebuf.buf)
-		strbuf_init(&dir->basebuf, PATH_MAX);
+	if (!dir->internal.basebuf.buf)
+		strbuf_init(&dir->internal.basebuf, PATH_MAX);
 
 	/* Read from the parent directories and push them down. */
 	current = stk ? stk->baselen : -1;
-	strbuf_setlen(&dir->basebuf, current < 0 ? 0 : current);
+	strbuf_setlen(&dir->internal.basebuf, current < 0 ? 0 : current);
 	if (dir->untracked)
 		untracked = stk ? stk->ucd : dir->untracked->root;
 	else
@@ -1599,32 +1599,33 @@ static void prep_exclude(struct dir_struct *dir,
 				die("oops in prep_exclude");
 			cp++;
 			untracked =
-				lookup_untracked(dir->untracked, untracked,
+				lookup_untracked(dir->untracked,
+						 untracked,
 						 base + current,
 						 cp - base - current);
 		}
-		stk->prev = dir->exclude_stack;
+		stk->prev = dir->internal.exclude_stack;
 		stk->baselen = cp - base;
 		stk->exclude_ix = group->nr;
 		stk->ucd = untracked;
 		pl = add_pattern_list(dir, EXC_DIRS, NULL);
-		strbuf_add(&dir->basebuf, base + current, stk->baselen - current);
-		assert(stk->baselen == dir->basebuf.len);
+		strbuf_add(&dir->internal.basebuf, base + current, stk->baselen - current);
+		assert(stk->baselen == dir->internal.basebuf.len);
 
 		/* Abort if the directory is excluded */
 		if (stk->baselen) {
 			int dt = DT_DIR;
-			dir->basebuf.buf[stk->baselen - 1] = 0;
-			dir->pattern = last_matching_pattern_from_lists(dir,
+			dir->internal.basebuf.buf[stk->baselen - 1] = 0;
+			dir->internal.pattern = last_matching_pattern_from_lists(dir,
 									istate,
-				dir->basebuf.buf, stk->baselen - 1,
-				dir->basebuf.buf + current, &dt);
-			dir->basebuf.buf[stk->baselen - 1] = '/';
-			if (dir->pattern &&
-			    dir->pattern->flags & PATTERN_FLAG_NEGATIVE)
-				dir->pattern = NULL;
-			if (dir->pattern) {
-				dir->exclude_stack = stk;
+				dir->internal.basebuf.buf, stk->baselen - 1,
+				dir->internal.basebuf.buf + current, &dt);
+			dir->internal.basebuf.buf[stk->baselen - 1] = '/';
+			if (dir->internal.pattern &&
+			    dir->internal.pattern->flags & PATTERN_FLAG_NEGATIVE)
+				dir->internal.pattern = NULL;
+			if (dir->internal.pattern) {
+				dir->internal.exclude_stack = stk;
 				return;
 			}
 		}
@@ -1647,15 +1648,15 @@ static void prep_exclude(struct dir_struct *dir,
 		      */
 		     !is_null_oid(&untracked->exclude_oid))) {
 			/*
-			 * dir->basebuf gets reused by the traversal, but we
-			 * need fname to remain unchanged to ensure the src
-			 * member of each struct path_pattern correctly
+			 * dir->internal.basebuf gets reused by the traversal,
+			 * but we need fname to remain unchanged to ensure the
+			 * src member of each struct path_pattern correctly
 			 * back-references its source file.  Other invocations
 			 * of add_pattern_list provide stable strings, so we
 			 * strbuf_detach() and free() here in the caller.
 			 */
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_addbuf(&sb, &dir->basebuf);
+			strbuf_addbuf(&sb, &dir->internal.basebuf);
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			pl->src = strbuf_detach(&sb, NULL);
 			add_patterns(pl->src, pl->src, stk->baselen, pl, istate,
@@ -1681,10 +1682,10 @@ static void prep_exclude(struct dir_struct *dir,
 			invalidate_gitignore(dir->untracked, untracked);
 			oidcpy(&untracked->exclude_oid, &oid_stat.oid);
 		}
-		dir->exclude_stack = stk;
+		dir->internal.exclude_stack = stk;
 		current = stk->baselen;
 	}
-	strbuf_setlen(&dir->basebuf, baselen);
+	strbuf_setlen(&dir->internal.basebuf, baselen);
 }
 
 /*
@@ -1704,8 +1705,8 @@ struct path_pattern *last_matching_pattern(struct dir_struct *dir,
 
 	prep_exclude(dir, istate, pathname, basename-pathname);
 
-	if (dir->pattern)
-		return dir->pattern;
+	if (dir->internal.pattern)
+		return dir->internal.pattern;
 
 	return last_matching_pattern_from_lists(dir, istate, pathname, pathlen,
 			basename, dtype_p);
@@ -1742,7 +1743,7 @@ static struct dir_entry *dir_add_name(struct dir_struct *dir,
 	if (index_file_exists(istate, pathname, len, ignore_case))
 		return NULL;
 
-	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
+	ALLOC_GROW(dir->entries, dir->nr+1, dir->internal.alloc);
 	return dir->entries[dir->nr++] = dir_entry_new(pathname, len);
 }
 
@@ -1753,7 +1754,7 @@ struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 	if (!index_name_is_other(istate, pathname, len))
 		return NULL;
 
-	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);
+	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->internal.ignored_alloc);
 	return dir->ignored[dir->ignored_nr++] = dir_entry_new(pathname, len);
 }
 
@@ -2569,7 +2570,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 
 	if (open_cached_dir(&cdir, dir, untracked, istate, &path, check_only))
 		goto out;
-	dir->visited_directories++;
+	dir->internal.visited_directories++;
 
 	if (untracked)
 		untracked->check_only = !!check_only;
@@ -2578,7 +2579,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* check how the file or directory should be treated */
 		state = treat_path(dir, untracked, &cdir, istate, &path,
 				   baselen, pathspec);
-		dir->visited_paths++;
+		dir->internal.visited_paths++;
 
 		if (state > dir_state)
 			dir_state = state;
@@ -2586,7 +2587,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* recurse into subdir if instructed by treat_path */
 		if (state == path_recurse) {
 			struct untracked_cache_dir *ud;
-			ud = lookup_untracked(dir->untracked, untracked,
+			ud = lookup_untracked(dir->untracked,
+					      untracked,
 					      path.buf + baselen,
 					      path.len - baselen);
 			subdir_state =
@@ -2846,7 +2848,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	 * condition also catches running setup_standard_excludes()
 	 * before setting dir->untracked!
 	 */
-	if (dir->unmanaged_exclude_files)
+	if (dir->internal.unmanaged_exclude_files)
 		return NULL;
 
 	/*
@@ -2875,7 +2877,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	 * EXC_CMDL is not considered in the cache. If people set it,
 	 * skip the cache.
 	 */
-	if (dir->exclude_list_group[EXC_CMDL].nr)
+	if (dir->internal.exclude_list_group[EXC_CMDL].nr)
 		return NULL;
 
 	if (!ident_in_untracked(dir->untracked)) {
@@ -2935,15 +2937,15 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 
 	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
 	root = dir->untracked->root;
-	if (!oideq(&dir->ss_info_exclude.oid,
+	if (!oideq(&dir->internal.ss_info_exclude.oid,
 		   &dir->untracked->ss_info_exclude.oid)) {
 		invalidate_gitignore(dir->untracked, root);
-		dir->untracked->ss_info_exclude = dir->ss_info_exclude;
+		dir->untracked->ss_info_exclude = dir->internal.ss_info_exclude;
 	}
-	if (!oideq(&dir->ss_excludes_file.oid,
+	if (!oideq(&dir->internal.ss_excludes_file.oid,
 		   &dir->untracked->ss_excludes_file.oid)) {
 		invalidate_gitignore(dir->untracked, root);
-		dir->untracked->ss_excludes_file = dir->ss_excludes_file;
+		dir->untracked->ss_excludes_file = dir->internal.ss_excludes_file;
 	}
 
 	/* Make sure this directory is not dropped out at saving phase */
@@ -2969,9 +2971,9 @@ static void emit_traversal_statistics(struct dir_struct *dir,
 	}
 
 	trace2_data_intmax("read_directory", repo,
-			   "directories-visited", dir->visited_directories);
+			   "directories-visited", dir->internal.visited_directories);
 	trace2_data_intmax("read_directory", repo,
-			   "paths-visited", dir->visited_paths);
+			   "paths-visited", dir->internal.visited_paths);
 
 	if (!dir->untracked)
 		return;
@@ -2993,8 +2995,8 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 	struct untracked_cache_dir *untracked;
 
 	trace2_region_enter("dir", "read_directory", istate->repo);
-	dir->visited_paths = 0;
-	dir->visited_directories = 0;
+	dir->internal.visited_paths = 0;
+	dir->internal.visited_directories = 0;
 
 	if (has_symlink_leading_path(path, len)) {
 		trace2_region_leave("dir", "read_directory", istate->repo);
@@ -3342,14 +3344,14 @@ void setup_standard_excludes(struct dir_struct *dir)
 		excludes_file = xdg_config_home("ignore");
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 		add_patterns_from_file_1(dir, excludes_file,
-					 dir->untracked ? &dir->ss_excludes_file : NULL);
+					 dir->untracked ? &dir->internal.ss_excludes_file : NULL);
 
 	/* per repository user preference */
 	if (startup_info->have_repository) {
 		const char *path = git_path_info_exclude();
 		if (!access_or_warn(path, R_OK, 0))
 			add_patterns_from_file_1(dir, path,
-						 dir->untracked ? &dir->ss_info_exclude : NULL);
+						 dir->untracked ? &dir->internal.ss_info_exclude : NULL);
 	}
 }
 
@@ -3405,7 +3407,7 @@ void dir_clear(struct dir_struct *dir)
 	struct dir_struct new = DIR_INIT;
 
 	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
-		group = &dir->exclude_list_group[i];
+		group = &dir->internal.exclude_list_group[i];
 		for (j = 0; j < group->nr; j++) {
 			pl = &group->pl[j];
 			if (i == EXC_DIRS)
@@ -3422,13 +3424,13 @@ void dir_clear(struct dir_struct *dir)
 	free(dir->ignored);
 	free(dir->entries);
 
-	stk = dir->exclude_stack;
+	stk = dir->internal.exclude_stack;
 	while (stk) {
 		struct exclude_stack *prev = stk->prev;
 		free(stk);
 		stk = prev;
 	}
-	strbuf_release(&dir->basebuf);
+	strbuf_release(&dir->internal.basebuf);
 
 	memcpy(dir, &new, sizeof(*dir));
 }
diff --git a/dir.h b/dir.h
index 8acfc044181..33fd848fc8d 100644
--- a/dir.h
+++ b/dir.h
@@ -215,14 +215,9 @@ struct dir_struct {
 	/* The number of members in `entries[]` array. */
 	int nr;
 
-	/* Internal use; keeps track of allocation of `entries[]` array.*/
-	int alloc;
-
 	/* The number of members in `ignored[]` array. */
 	int ignored_nr;
 
-	int ignored_alloc;
-
 	/* bit-field of options */
 	enum {
 
@@ -296,51 +291,62 @@ struct dir_struct {
 	 */
 	struct dir_entry **ignored;
 
+	/* Enable/update untracked file cache if set */
+	struct untracked_cache *untracked;
+
 	/**
 	 * The name of the file to be read in each directory for excluded files
 	 * (typically `.gitignore`).
 	 */
 	const char *exclude_per_dir;
 
-	/*
-	 * We maintain three groups of exclude pattern lists:
-	 *
-	 * EXC_CMDL lists patterns explicitly given on the command line.
-	 * EXC_DIRS lists patterns obtained from per-directory ignore files.
-	 * EXC_FILE lists patterns from fallback ignore files, e.g.
-	 *   - .git/info/exclude
-	 *   - core.excludesfile
-	 *
-	 * Each group contains multiple exclude lists, a single list
-	 * per source.
-	 */
+	struct dir_struct_internal {
+		/* Keeps track of allocation of `entries[]` array.*/
+		int alloc;
+
+		/* Keeps track of allocation of `ignored[]` array. */
+		int ignored_alloc;
+
+		/*
+		 * We maintain three groups of exclude pattern lists:
+		 *
+		 * EXC_CMDL lists patterns explicitly given on the command line.
+		 * EXC_DIRS lists patterns obtained from per-directory ignore
+		 *          files.
+		 * EXC_FILE lists patterns from fallback ignore files, e.g.
+		 *   - .git/info/exclude
+		 *   - core.excludesfile
+		 *
+		 * Each group contains multiple exclude lists, a single list
+		 * per source.
+		 */
 #define EXC_CMDL 0
 #define EXC_DIRS 1
 #define EXC_FILE 2
-	struct exclude_list_group exclude_list_group[3];
-
-	/*
-	 * Temporary variables which are used during loading of the
-	 * per-directory exclude lists.
-	 *
-	 * exclude_stack points to the top of the exclude_stack, and
-	 * basebuf contains the full path to the current
-	 * (sub)directory in the traversal. Exclude points to the
-	 * matching exclude struct if the directory is excluded.
-	 */
-	struct exclude_stack *exclude_stack;
-	struct path_pattern *pattern;
-	struct strbuf basebuf;
-
-	/* Enable untracked file cache if set */
-	struct untracked_cache *untracked;
-	struct oid_stat ss_info_exclude;
-	struct oid_stat ss_excludes_file;
-	unsigned unmanaged_exclude_files;
+		struct exclude_list_group exclude_list_group[3];
 
-	/* Stats about the traversal */
-	unsigned visited_paths;
-	unsigned visited_directories;
+		/*
+		 * Temporary variables which are used during loading of the
+		 * per-directory exclude lists.
+		 *
+		 * exclude_stack points to the top of the exclude_stack, and
+		 * basebuf contains the full path to the current
+		 * (sub)directory in the traversal. Exclude points to the
+		 * matching exclude struct if the directory is excluded.
+		 */
+		struct exclude_stack *exclude_stack;
+		struct path_pattern *pattern;
+		struct strbuf basebuf;
+
+		/* Additional metadata related to 'untracked' */
+		struct oid_stat ss_info_exclude;
+		struct oid_stat ss_excludes_file;
+		unsigned unmanaged_exclude_files;
+
+		/* Stats about the traversal */
+		unsigned visited_paths;
+		unsigned visited_directories;
+	} internal;
 };
 
 #define DIR_INIT { 0 }
-- 
gitgitgadget

