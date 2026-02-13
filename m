Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A823164BA
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984397; cv=none; b=F2JY97gd4g557y9TIcqmm3EDN4LCDg6u+hYszcvnSmP3Ux4EHvrL4ZxGxcjtqZRKfp/acEuNzao+Akso6lF1yjOl3iWuo5KsFKh0Gf72f5dq2R1jrRG0KN6MxxIpAqdVQreMiIx3X/gtxYooWM1TFEPPn9evOJDZHjh8T+0dmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984397; c=relaxed/simple;
	bh=km4KMEIJ/kkDvW3U7p8gqL83wJ5fmQGPB4mxtmsfojA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnXLgifbMD5PaBXSbEuSCk+egeEKSik4KkSVAY1dx254ZsfKNSYWHgoYWSwAENiUHlUnGhF1V6HaTiky1ALBJj5BCrUUvWdWpuEkHzRRKl/hcre7UbOTByQo4KYwo7LLkbWIB66PjSaBvzJyB5u+r25H2gAeWr8FarDtileOswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWA4H16C; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWA4H16C"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-81df6a302b1so875554b3a.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 04:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770984395; x=1771589195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEyd6GCmoeQVBOVQZeoj1qURH5/92poDIgjBDrRBthY=;
        b=NWA4H16Cmz09LvoQr4fBqZ350vithhfhZX59w95z/SuKebVPdY/utWya74FSLqmxQ6
         0iXo2+8wf5MUHXnSKMN6A2JLX8GPxh1RZJ2ee0ZOgz4wjZli5QJHusYlwG6xa2U76ZFa
         EGp3AP1/qR3s5GWDwKIld5r7WfTedSxbcwa9apaMeOq4PH2BhZtbXBnwzmpvbXaV00tE
         uIJzX39lo1m4VkuNDHmOvnTSmd5fpjMohf5uicvULxhHht2VMIDLyLronsizm7nWZaZi
         11PtX6My5q6SgZOP+c45djbYCTwA57ka+RZiQAqHAiB793GxTIB2O8BXMDEPagHRL2nS
         mAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770984395; x=1771589195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OEyd6GCmoeQVBOVQZeoj1qURH5/92poDIgjBDrRBthY=;
        b=lxQTdet/Qund3cxHhWOLVBwE6iGGb+rUc9NvhDSY/chjbc7fKDAsWMKGo3EEAJjXSU
         KwX7v1RwF8/d3Xl+/mhFv9Zo2pmpOnBaMppEh/u+AsXS0ToOpFF0M7lSAghQC18/IESM
         c12++Mo4jMz9UDelz3A1Ta6ujgogeYYmtJ7sBqCMOtAwlLr39SrnudMd7b/mHPm88mq0
         iOVxXlWgINMGNOcTl0C8L8i1axrf/SlSEqEpLWx7lIGzG+nuHIbWZ72/H2P3Cbd/i1wP
         d6Kay6zqezPExo6p3NCh7/F19rIVSvruOnFVdzFnV6BvNX2ziqW4QQm36zYQRDN5en0L
         orjg==
X-Gm-Message-State: AOJu0Yz2JiwOPCpuiIKFGdLcLMShtA8McVLCD1iJf0m+lSk5KckqJ4LB
	2V4agqEc3zbAMfE03zjPXaFqA+rOOjhW0ZggKo96daCS4M3k2vg3ctPvYUgQ95oi
X-Gm-Gg: AZuq6aJxES2oQWM3eYC6Ui1ANS2txzE8saw4XAO+wvueMpjmycuIZMErmXoCqHhTGgj
	oHO82xuGc0C4LP02xQ5T07WUWjkb1FaJwyQn/TTFUYAN/KUHavxyqPLpXw6ra2nmtAX7rJGVYWn
	L/yrkvJin544fKV+NDI3sa0sRcdP5UhbMa2hlPvorpru0ZmBlxgjCUt5GjJgKoa/zJokVp8AEiT
	ttpHsyQaQGePJaiXH8DSlMX8z+qEUs4yKfSUYENBR3F/RbeVLmUt6LQm4zJvkQ/TJ9rT11k90zY
	fG4C5vW7pd9BbcFP5uMuMKA8Eipg6tMQmqKnR4i8IR9UvMS4eS85uWD1H/CFcchVYgawnh1sqjV
	VpLeW2YoH4ntVz0/21mrs3RSezeCczKc0VH0j2lAqbizz++YukohHivSLmQWeyepicVI+Fipzk/
	fI682gWcClAwxPxDGh462vYkMYwhNv5gkozvaqcelwjRFXlqP2js5qSMahQ+U=
X-Received: by 2002:a05:6a00:813:b0:7ef:3f4e:9176 with SMTP id d2e1a72fcca58-824c95da14cmr1732458b3a.49.1770984394925;
        Fri, 13 Feb 2026 04:06:34 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:8f0a:9a89:5610:9cd3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a0c3sm2303078b3a.51.2026.02.13.04.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 04:06:34 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [RFC][PATCH 2/2] worktree: stop passing NULL as primary worktree
Date: Fri, 13 Feb 2026 17:29:54 +0530
Message-ID: <20260213120529.15475-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions like repo_git_pathv() in path.c, wt_status_check_rebase()
and wt_status_check_bisect() in wt-status.c, get_worktree_git_dir() in
builtin/worktree.c are called with a NULL worktree. This makes it difficult
to access fields like `wt->repo` and add extra handling for checking wt is
defined.

Add a helper function of get_worktrees_internal() as get_worktrees_repo()
and pass struct repository down the callstack to get_main_worktree()
function so that the primary worktree of a specific repository can be
accessed instead of just the_repository.

Access the primary worktree by the help of get_worktrees_repo() and pass it
to the functions as struct worktree instead of passing NULL.

Further `worktree_git_path()` no longer needs a separate
`struct repository *` parameter. Use `wt->repo` instead and update its
callers accordingly.

while at, replace any unecessary checks for wt to be defined with
is_main_worktree(wt).

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 builtin/fsck.c     |  2 +-
 builtin/worktree.c | 10 +++++++---
 path.c             | 27 +++++++++++++--------------
 path.h             |  9 +++------
 refs.c             |  4 ++--
 revision.c         |  6 ++++--
 worktree.c         | 29 ++++++++++++++++-------------
 worktree.h         |  7 +++++++
 wt-status.c        | 22 ++++++++++++----------
 9 files changed, 65 insertions(+), 51 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0512f78a87..42ba0afb91 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1137,7 +1137,7 @@ int cmd_fsck(int argc,
 			 * and may get overwritten by other calls
 			 * while we're examining the index.
 			 */
-			path = xstrdup(worktree_git_path(the_repository, wt, "index"));
+			path = xstrdup(worktree_git_path(wt, "index"));
 			wt_gitdir = get_worktree_git_dir(wt);
 
 			read_index_from(&istate, path, wt_gitdir);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..27c5889c89 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -328,6 +328,8 @@ static void check_candidate_path(const char *path,
 	wt = find_worktree_by_path(worktrees, path);
 	if (!wt)
 		return;
+	if(is_main_worktree(wt))
+		die(_("'%s' is the main worktree"), path);
 
 	locked = !!worktree_lock_reason(wt);
 	if ((!locked && force) || (locked && force > 1)) {
@@ -660,7 +662,8 @@ static int can_use_local_refs(const struct add_opts *opts)
 		if (!opts->quiet) {
 			struct strbuf path = STRBUF_INIT;
 			struct strbuf contents = STRBUF_INIT;
-			char *wt_gitdir = get_worktree_git_dir(NULL);
+			struct worktree **worktrees = get_worktrees_repo(the_repository);
+			char *wt_gitdir = get_worktree_git_dir(worktrees[0]);
 
 			strbuf_add_real_path(&path, wt_gitdir);
 			strbuf_addstr(&path, "/HEAD");
@@ -675,6 +678,7 @@ static int can_use_local_refs(const struct add_opts *opts)
 			strbuf_release(&path);
 			strbuf_release(&contents);
 			free(wt_gitdir);
+			free_worktrees(worktrees);
 		}
 		return 1;
 	}
@@ -1191,14 +1195,14 @@ static void validate_no_submodules(const struct worktree *wt)
 
 	wt_gitdir = get_worktree_git_dir(wt);
 
-	if (is_directory(worktree_git_path(the_repository, wt, "modules"))) {
+	if (is_directory(worktree_git_path(wt, "modules"))) {
 		/*
 		 * There could be false positives, e.g. the "modules"
 		 * directory exists but is empty. But it's a rare case and
 		 * this simpler check is probably good enough for now.
 		 */
 		found_submodules = 1;
-	} else if (read_index_from(&istate, worktree_git_path(the_repository, wt, "index"),
+	} else if (read_index_from(&istate, worktree_git_path(wt, "index"),
 				   wt_gitdir) > 0) {
 		for (i = 0; i < istate.cache_nr; i++) {
 			struct cache_entry *ce = istate.cache[i];
diff --git a/path.c b/path.c
index d726537622..4ac86e1e58 100644
--- a/path.c
+++ b/path.c
@@ -408,9 +408,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
 				   const struct repository *repo,
 				   const struct worktree *wt)
 {
-	if (!wt)
-		strbuf_addstr(buf, repo->gitdir);
-	else if (!wt->id)
+	if (is_main_worktree(wt))
 		strbuf_addstr(buf, repo->commondir);
 	else
 		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
@@ -426,7 +424,7 @@ static void repo_git_pathv(struct repository *repo,
 		strbuf_addch(buf, '/');
 	gitdir_len = buf->len;
 	strbuf_vaddf(buf, fmt, args);
-	if (!wt)
+	if (is_main_worktree(wt))
 		adjust_git_path(repo, buf, gitdir_len);
 	strbuf_cleanup_path(buf);
 }
@@ -437,8 +435,10 @@ char *repo_git_path(struct repository *repo,
 	struct strbuf path = STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	repo_git_pathv(repo, NULL, &path, fmt, args);
+	struct worktree **worktrees = get_worktrees_repo(repo);
+	repo_git_pathv(repo, worktrees[0], &path, fmt, args);
 	va_end(args);
+	free_worktrees(worktrees);
 	return strbuf_detach(&path, NULL);
 }
 
@@ -448,8 +448,10 @@ const char *repo_git_path_append(struct repository *repo,
 {
 	va_list args;
 	va_start(args, fmt);
-	repo_git_pathv(repo, NULL, sb, fmt, args);
+	struct worktree **worktrees = get_worktrees_repo(repo);
+	repo_git_pathv(repo, worktrees[0], sb, fmt, args);
 	va_end(args);
+	free_worktrees(worktrees);
 	return sb->buf;
 }
 
@@ -460,8 +462,10 @@ const char *repo_git_path_replace(struct repository *repo,
 	va_list args;
 	strbuf_reset(sb);
 	va_start(args, fmt);
-	repo_git_pathv(repo, NULL, sb, fmt, args);
+	struct worktree **worktrees = get_worktrees_repo(repo);
+	repo_git_pathv(repo, worktrees[0], sb, fmt, args);
 	va_end(args);
+	free_worktrees(worktrees);
 	return sb->buf;
 }
 
@@ -486,17 +490,12 @@ const char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname->buf);
 }
 
-const char *worktree_git_path(struct repository *r,
-			      const struct worktree *wt, const char *fmt, ...)
+const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
 {
 	struct strbuf *pathname = get_pathname();
 	va_list args;
-
-	if (wt && wt->repo != r)
-		BUG("worktree not connected to expected repository");
-
 	va_start(args, fmt);
-	repo_git_pathv(r, wt, pathname, fmt, args);
+	repo_git_pathv(wt->repo, wt, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
diff --git a/path.h b/path.h
index 0ec95a0b07..54e09b2883 100644
--- a/path.h
+++ b/path.h
@@ -66,13 +66,10 @@ const char *repo_git_path_replace(struct repository *repo,
 
 /*
  * Similar to repo_git_path() but can produce paths for a specified
- * worktree instead of current one. When no worktree is given, then the path is
- * computed relative to main worktree of the given repository.
+ * worktree instead of current one.
  */
-const char *worktree_git_path(struct repository *r,
-			      const struct worktree *wt,
-			      const char *fmt, ...)
-	__attribute__((format (printf, 3, 4)));
+const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
 
 /*
  * The `repo_worktree_path` family of functions will construct a path into a
diff --git a/refs.c b/refs.c
index 627b7f8698..98df2235e7 100644
--- a/refs.c
+++ b/refs.c
@@ -2324,12 +2324,12 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 	if (wt->is_current)
 		return get_main_ref_store(wt->repo);
 
-	id = wt->id ? wt->id : "/";
+	id = wt->id;
 	refs = lookup_ref_store_map(&wt->repo->worktree_ref_stores, id);
 	if (refs)
 		return refs;
 
-	if (wt->id) {
+	if (!is_main_worktree(wt)) {
 		struct strbuf common_path = STRBUF_INIT;
 		repo_common_path_append(wt->repo, &common_path,
 					"worktrees/%s", wt->id);
diff --git a/revision.c b/revision.c
index 9b131670f7..a9d4f796ed 100644
--- a/revision.c
+++ b/revision.c
@@ -1730,12 +1730,14 @@ void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
-	cb.wt = NULL;
+	struct worktree **worktrees = get_worktrees_repo(the_repository);
+	cb.wt = worktrees[0];
 	refs_for_each_reflog(get_main_ref_store(the_repository),
 			     handle_one_reflog, &cb);
 
 	if (!revs->single_worktree)
 		add_other_reflogs_to_pending(&cb);
+	free_worktrees(worktrees);
 }
 
 static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
@@ -1847,7 +1849,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 		wt_gitdir = get_worktree_git_dir(wt);
 
 		if (read_index_from(&istate,
-				    worktree_git_path(the_repository, wt, "index"),
+				    worktree_git_path(wt, "index"),
 				    wt_gitdir) > 0)
 			do_add_index_objects_to_pending(revs, &istate, flags);
 
diff --git a/worktree.c b/worktree.c
index b29934407f..1059c18115 100644
--- a/worktree.c
+++ b/worktree.c
@@ -91,16 +91,16 @@ static int is_main_worktree_bare(struct repository *repo)
 /**
  * get the main worktree
  */
-static struct worktree *get_main_worktree(int skip_reading_head)
+static struct worktree *get_main_worktree(struct repository *repo, int skip_reading_head)
 {
 	struct worktree *worktree = NULL;
 	struct strbuf worktree_path = STRBUF_INIT;
 
-	strbuf_add_real_path(&worktree_path, repo_get_common_dir(the_repository));
+	strbuf_add_real_path(&worktree_path, repo_get_common_dir(repo));
 	strbuf_strip_suffix(&worktree_path, "/.git");
 
 	CALLOC_ARRAY(worktree, 1);
-	worktree->repo = the_repository;
+	worktree->repo = repo;
 	worktree->id = xstrdup("/");
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->is_current = is_current_worktree(worktree);
@@ -112,7 +112,7 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 		 * This check is unnecessary if we're currently in the main worktree,
 		 * as prior checks already consulted all configs of the current worktree.
 		 */
-		(!worktree->is_current && is_main_worktree_bare(the_repository));
+		(!worktree->is_current && is_main_worktree_bare(repo));
 
 	if (!skip_reading_head)
 		add_head_info(worktree);
@@ -165,7 +165,7 @@ struct worktree *get_linked_worktree(const char *id,
  * retrieving worktree metadata that could be used when the worktree is known
  * to not be in a healthy state, e.g. when creating or repairing it.
  */
-static struct worktree **get_worktrees_internal(int skip_reading_head)
+static struct worktree **get_worktrees_internal(struct repository *repo, int skip_reading_head)
 {
 	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -175,9 +175,9 @@ static struct worktree **get_worktrees_internal(int skip_reading_head)
 
 	ALLOC_ARRAY(list, alloc);
 
-	list[counter++] = get_main_worktree(skip_reading_head);
+	list[counter++] = get_main_worktree(repo, skip_reading_head);
 
-	strbuf_addf(&path, "%s/worktrees", repo_get_common_dir(the_repository));
+	strbuf_addf(&path, "%s/worktrees", repo_get_common_dir(repo));
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (dir) {
@@ -199,12 +199,15 @@ static struct worktree **get_worktrees_internal(int skip_reading_head)
 
 struct worktree **get_worktrees(void)
 {
-	return get_worktrees_internal(0);
+	return get_worktrees_repo(the_repository);
+}
+struct worktree **get_worktrees_repo(struct repository *repo)
+{
+	return get_worktrees_internal(repo, 0);
 }
-
 struct worktree **get_worktrees_without_reading_head(void)
 {
-	return get_worktrees_internal(1);
+	return get_worktrees_internal(the_repository, 1);
 }
 
 char *get_worktree_git_dir(const struct worktree *wt)
@@ -289,7 +292,7 @@ const char *worktree_lock_reason(struct worktree *wt)
 	if (!wt->lock_reason_valid) {
 		struct strbuf path = STRBUF_INIT;
 
-		strbuf_addstr(&path, worktree_git_path(the_repository, wt, "locked"));
+		strbuf_addstr(&path, worktree_git_path(wt, "locked"));
 		if (file_exists(path.buf)) {
 			struct strbuf lock_reason = STRBUF_INIT;
 			if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
@@ -690,7 +693,7 @@ static void repair_noop(int iserr UNUSED,
 
 void repair_worktrees(worktree_repair_fn fn, void *cb_data, int use_relative_paths)
 {
-	struct worktree **worktrees = get_worktrees_internal(1);
+	struct worktree **worktrees = get_worktrees_internal(the_repository, 1);
 	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
 
 	if (!fn)
@@ -735,7 +738,7 @@ void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path
 
 void repair_worktrees_after_gitdir_move(const char *old_path)
 {
-	struct worktree **worktrees = get_worktrees_internal(1);
+	struct worktree **worktrees = get_worktrees_internal(the_repository, 1);
 	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
 
 	for (; *wt; wt++)
diff --git a/worktree.h b/worktree.h
index e4bcccdc0a..fc5f87b5b1 100644
--- a/worktree.h
+++ b/worktree.h
@@ -30,6 +30,13 @@ struct worktree {
  */
 struct worktree **get_worktrees(void);
 
+/*
+ * Like `get_worktrees`, but it returns the worktrees for the given repository.
+ * This is useful for cases where local repository context is used rather than
+ * the_repository global.
+ */
+struct worktree **get_worktrees_repo(struct repository *repo);
+
 /*
  * Like `get_worktrees`, but does not read HEAD. Skip reading HEAD allows to
  * get the worktree without worrying about failures pertaining to parsing
diff --git a/wt-status.c b/wt-status.c
index e12adb26b9..11aea61c81 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1624,7 +1624,7 @@ static char *get_branch(const struct worktree *wt, const char *path)
 	struct object_id oid;
 	const char *branch_name;
 
-	if (strbuf_read_file(&sb, worktree_git_path(the_repository, wt, "%s", path), 0) <= 0)
+	if (strbuf_read_file(&sb, worktree_git_path(wt, "%s", path), 0) <= 0)
 		goto got_nothing;
 
 	while (sb.len && sb.buf[sb.len - 1] == '\n')
@@ -1723,18 +1723,18 @@ int wt_status_check_rebase(const struct worktree *wt,
 {
 	struct stat st;
 
-	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
-		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
+	if (!stat(worktree_git_path(wt, "rebase-apply"), &st)) {
+		if (!stat(worktree_git_path(wt, "rebase-apply/applying"), &st)) {
 			state->am_in_progress = 1;
-			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), &st) && !st.st_size)
+			if (!stat(worktree_git_path(wt, "rebase-apply/patch"), &st) && !st.st_size)
 				state->am_empty_patch = 1;
 		} else {
 			state->rebase_in_progress = 1;
 			state->branch = get_branch(wt, "rebase-apply/head-name");
 			state->onto = get_branch(wt, "rebase-apply/onto");
 		}
-	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
-		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
+	} else if (!stat(worktree_git_path(wt, "rebase-merge"), &st)) {
+		if (!stat(worktree_git_path(wt, "rebase-merge/interactive"), &st))
 			state->rebase_interactive_in_progress = 1;
 		else
 			state->rebase_in_progress = 1;
@@ -1750,7 +1750,7 @@ int wt_status_check_bisect(const struct worktree *wt,
 {
 	struct stat st;
 
-	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
+	if (!stat(worktree_git_path(wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress = 1;
 		state->bisecting_from = get_branch(wt, "BISECT_START");
 		return 1;
@@ -1795,18 +1795,19 @@ void wt_status_get_state(struct repository *r,
 	struct stat st;
 	struct object_id oid;
 	enum replay_action action;
+	struct worktree **worktrees = get_worktrees_repo(r);
 
 	if (!stat(git_path_merge_head(r), &st)) {
-		wt_status_check_rebase(NULL, state);
+		wt_status_check_rebase(worktrees[0], state);
 		state->merge_in_progress = 1;
-	} else if (wt_status_check_rebase(NULL, state)) {
+	} else if (wt_status_check_rebase(worktrees[0], state)) {
 		;		/* all set */
 	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
 		   !repo_get_oid(r, "CHERRY_PICK_HEAD", &oid)) {
 		state->cherry_pick_in_progress = 1;
 		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
-	wt_status_check_bisect(NULL, state);
+	wt_status_check_bisect(worktrees[0], state);
 	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
 	    !repo_get_oid(r, "REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
@@ -1824,6 +1825,7 @@ void wt_status_get_state(struct repository *r,
 	if (get_detached_from)
 		wt_status_get_detached_from(r, state);
 	wt_status_check_sparse_checkout(r, state);
+	free_worktrees(worktrees);
 }
 
 static void wt_longstatus_print_state(struct wt_status *s)
-- 
2.53.0

