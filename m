Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFD1AAE35
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001982; cv=none; b=ah2VNBpkfL9qbamMwNoBcjrkOgEqn8CxwM2l5Eta5qukN8u5t6mbqK9BNEgaeA0NNohxta0iw2nHsKq+xKJTv3us8z+t8CFEzTo7VBJZ/+d55ZV22an8qBlBaF/7JkWRzB4sJgdmbbcJAmLUV0LdMx8balyTIl98+ZYyCAKDkjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001982; c=relaxed/simple;
	bh=rM3H9wMgmlcOcG/csq1Iq0gNTi102gSbqH4PPVCKvaE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kBE/YwG8F+QKhK1Twy6qqnbMPX7DDCygcn++oxSaje4KVGuoP5nv2EqqRG70T52samLmAdnHV0oZAMZzwNHFrLjSyT//bQhYUMkw647NJvs5qdZUHJUe0y5LB6Mm/ld/IC0kFHRuhkR/zNUwK/y9AdU45RECqWmUJQMZFF+WiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap2f7+ZJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap2f7+ZJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c84dcc64so4678122f8f.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726001978; x=1726606778; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S11BAx/O3MrmNkoorl+ZI7ccQKlhTiKvG5amsOEysN8=;
        b=ap2f7+ZJohrJQbEOjze29sB/sOrYu6z3/l13AFkdK8jQeVfhyqVJAAdRjbYSWmN1Sb
         3/5yYmpOOvKGp4O1PRwY9OmPr6nEXs2C6h741tP/NbjYcgyDe9QbhhokyV4WpksczNE6
         R6hhYISLhP82JgmQY2SYNHjGLVKvfEEq7APWpnJm7+Edzkg90LVvAzkCdVGEqKD2Ul7D
         haaFb3Y9D4wKIlDjmPw6qQx3hUFFkPOxkL6M913ana+4UkAy31p7VNSLxPGraupIo6MP
         XDZ9fhLbAxtc99Tz1JgAmz9PunGNNFcEvC+RiVjgiSsqwaYT24830Og57Oj0YAXh2YPv
         hZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726001978; x=1726606778;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S11BAx/O3MrmNkoorl+ZI7ccQKlhTiKvG5amsOEysN8=;
        b=iMPqiKwUOBJaWPlpVYj5Q6waVbyZ3M8VerhkARD4Ka5dHlc3xEKnd1QlSEYqydjX1F
         YMWXHdIw4U9qhW170tLzQzL64m8MuqU9fMaY6/xFLGZZGWsTjWx15QZhkgop2tRKDL36
         kxWa5wZ8tttKyEE9uThK442rqFjT4zIYHy3ZoywT0v89mjq0vkkwNedgmBh7LHReZl3K
         1thfHgOqJxN9bc0b2Jbq9CDEvhf5QZbNUcz4Z1fEe5ZDsgqN7VKrcgnZ6EBdwsyKaOCL
         iiNcDS69ANV4XRUHfe7tOtyjJFa2mBRdQOo/EVOfIyoH/1ns1m6+rd0s5vGJtnaR778C
         1q7A==
X-Gm-Message-State: AOJu0Yzog8Ni++BDRbEt0ph9H/TYQQxl9DmNnZwYNwaWMxuC8bHX5wqw
	ug1LhXIYZO5rvVd+vZb8BGC/+MMUuQkvtWlSKhBzuc31sAmjZu183ruJ/A==
X-Google-Smtp-Source: AGHT+IERaFhtImstxz2lloCOFMgBoJ+H3agll/sl97zqBUhdJxMZ9xjRQLkmq7llBiog+oEN8z0VXg==
X-Received: by 2002:a05:6000:d0:b0:378:8f2f:905f with SMTP id ffacd0b85a97d-3789229b892mr10286084f8f.11.1726001978008;
        Tue, 10 Sep 2024 13:59:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72e71sm522341966b.139.2024.09.10.13.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 13:59:37 -0700 (PDT)
Message-Id: <6956d3fe8971475dde87909bb6b9760be6964488.1726001963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
	<pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 20:59:20 +0000
Subject: [PATCH v2 3/3] add: pass in repo variable instead of global
 the_repository
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

With the repository variable available in the builtin function as an
argument, pass this down into helper functions instead of using the
global the_repository.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/add.c    | 116 +++++++++++++++++++++++++----------------------
 builtin/commit.c |   2 +-
 commit.h         |   5 +-
 3 files changed, 68 insertions(+), 55 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c893ff48d26..773b7224a49 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) 2006 Linus Torvalds
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
@@ -35,24 +34,27 @@ static int pathspec_file_nul;
 static int include_sparse;
 static const char *pathspec_from_file;
 
-static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
+static int chmod_pathspec(struct repository *repo,
+			  struct pathspec *pathspec,
+			  char flip,
+			  int show_only)
 {
 	int i, ret = 0;
 
-	for (i = 0; i < the_repository->index->cache_nr; i++) {
-		struct cache_entry *ce = the_repository->index->cache[i];
+	for (i = 0; i < repo->index->cache_nr; i++) {
+		struct cache_entry *ce = repo->index->cache[i];
 		int err;
 
 		if (!include_sparse &&
 		    (ce_skip_worktree(ce) ||
-		     !path_in_sparse_checkout(ce->name, the_repository->index)))
+		     !path_in_sparse_checkout(ce->name, repo->index)))
 			continue;
 
-		if (pathspec && !ce_path_match(the_repository->index, ce, pathspec, NULL))
+		if (pathspec && !ce_path_match(repo->index, ce, pathspec, NULL))
 			continue;
 
 		if (!show_only)
-			err = chmod_index_entry(the_repository->index, ce, flip);
+			err = chmod_index_entry(repo->index, ce, flip);
 		else
 			err = S_ISREG(ce->ce_mode) ? 0 : -1;
 
@@ -63,31 +65,36 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 	return ret;
 }
 
-static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
+static int renormalize_tracked_files(struct repository *repo,
+				     const struct pathspec *pathspec,
+				     int flags)
 {
 	int i, retval = 0;
 
-	for (i = 0; i < the_repository->index->cache_nr; i++) {
-		struct cache_entry *ce = the_repository->index->cache[i];
+	for (i = 0; i < repo->index->cache_nr; i++) {
+		struct cache_entry *ce = repo->index->cache[i];
 
 		if (!include_sparse &&
 		    (ce_skip_worktree(ce) ||
-		     !path_in_sparse_checkout(ce->name, the_repository->index)))
+		     !path_in_sparse_checkout(ce->name, repo->index)))
 			continue;
 		if (ce_stage(ce))
 			continue; /* do not touch unmerged paths */
 		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
 			continue; /* do not touch non blobs */
-		if (pathspec && !ce_path_match(the_repository->index, ce, pathspec, NULL))
+		if (pathspec && !ce_path_match(repo->index, ce, pathspec, NULL))
 			continue;
-		retval |= add_file_to_index(the_repository->index, ce->name,
+		retval |= add_file_to_index(repo->index, ce->name,
 					    flags | ADD_CACHE_RENORMALIZE);
 	}
 
 	return retval;
 }
 
-static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec, int prefix)
+static char *prune_directory(struct repository *repo,
+			     struct dir_struct *dir,
+			     struct pathspec *pathspec,
+			     int prefix)
 {
 	char *seen;
 	int i;
@@ -99,16 +106,16 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
 	i = dir->nr;
 	while (--i >= 0) {
 		struct dir_entry *entry = *src++;
-		if (dir_path_match(the_repository->index, entry, pathspec, prefix, seen))
+		if (dir_path_match(repo->index, entry, pathspec, prefix, seen))
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
-	add_pathspec_matches_against_index(pathspec, the_repository->index, seen,
+	add_pathspec_matches_against_index(pathspec, repo->index, seen,
 					   PS_IGNORE_SKIP_WORKTREE);
 	return seen;
 }
 
-static int refresh(int verbose, const struct pathspec *pathspec)
+static int refresh(struct repository *repo, int verbose, const struct pathspec *pathspec)
 {
 	char *seen;
 	int i, ret = 0;
@@ -118,14 +125,14 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 		    (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
 
 	seen = xcalloc(pathspec->nr, 1);
-	refresh_index(the_repository->index, flags, pathspec, seen,
+	refresh_index(repo->index, flags, pathspec, seen,
 		      _("Unstaged changes after refreshing the index:"));
 	for (i = 0; i < pathspec->nr; i++) {
 		if (!seen[i]) {
 			const char *path = pathspec->items[i].original;
 
 			if (matches_skip_worktree(pathspec, i, &skip_worktree_seen) ||
-			    !path_in_sparse_checkout(path, the_repository->index)) {
+			    !path_in_sparse_checkout(path, repo->index)) {
 				string_list_append(&only_match_skip_worktree,
 						   pathspec->items[i].original);
 			} else {
@@ -146,7 +153,10 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 	return ret;
 }
 
-int interactive_add(const char **argv, const char *prefix, int patch)
+int interactive_add(struct repository *repo,
+		    const char **argv,
+		    const char *prefix,
+		    int patch)
 {
 	struct pathspec pathspec;
 	int ret;
@@ -158,31 +168,31 @@ int interactive_add(const char **argv, const char *prefix, int patch)
 		       prefix, argv);
 
 	if (patch)
-		ret = !!run_add_p(the_repository, ADD_P_ADD, NULL, &pathspec);
+		ret = !!run_add_p(repo, ADD_P_ADD, NULL, &pathspec);
 	else
-		ret = !!run_add_i(the_repository, &pathspec);
+		ret = !!run_add_i(repo, &pathspec);
 
 	clear_pathspec(&pathspec);
 	return ret;
 }
 
-static int edit_patch(int argc,
+static int edit_patch(struct repository *repo,
+		      int argc,
 		      const char **argv,
-		      const char *prefix,
-		      struct repository *repo UNUSED)
+		      const char *prefix)
 {
-	char *file = git_pathdup("ADD_EDIT.patch");
+	char *file = repo_git_path(repo, "ADD_EDIT.patch");
 	struct child_process child = CHILD_PROCESS_INIT;
 	struct rev_info rev;
 	int out;
 	struct stat st;
 
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+	repo_config(repo, git_diff_basic_config, NULL);
 
-	if (repo_read_index(the_repository) < 0)
+	if (repo_read_index(repo) < 0)
 		die(_("could not read the index"));
 
-	repo_init_revisions(the_repository, &rev, prefix);
+	repo_init_revisions(repo, &rev, prefix);
 	rev.diffopt.context = 7;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
@@ -320,7 +330,7 @@ static void check_embedded_repo(const char *path)
 	strbuf_release(&name);
 }
 
-static int add_files(struct dir_struct *dir, int flags)
+static int add_files(struct repository *repo, struct dir_struct *dir, int flags)
 {
 	int i, exit_status = 0;
 	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
@@ -336,12 +346,12 @@ static int add_files(struct dir_struct *dir, int flags)
 
 	for (i = 0; i < dir->nr; i++) {
 		if (!include_sparse &&
-		    !path_in_sparse_checkout(dir->entries[i]->name, the_repository->index)) {
+		    !path_in_sparse_checkout(dir->entries[i]->name, repo->index)) {
 			string_list_append(&matched_sparse_paths,
 					   dir->entries[i]->name);
 			continue;
 		}
-		if (add_file_to_index(the_repository->index, dir->entries[i]->name, flags)) {
+		if (add_file_to_index(repo->index, dir->entries[i]->name, flags)) {
 			if (!ignore_add_errors)
 				die(_("adding files failed"));
 			exit_status = 1;
@@ -363,7 +373,7 @@ static int add_files(struct dir_struct *dir, int flags)
 int cmd_add(int argc,
 	    const char **argv,
 	    const char *prefix,
-	    struct repository *repo UNUSED)
+	    struct repository *repo)
 {
 	int exit_status = 0;
 	struct pathspec pathspec;
@@ -375,7 +385,7 @@ int cmd_add(int argc,
 	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
 
-	git_config(add_config, NULL);
+	repo_config(repo, add_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
@@ -386,13 +396,13 @@ int cmd_add(int argc,
 			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--interactive/--patch");
 		if (pathspec_from_file)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
-		exit(interactive_add(argv + 1, prefix, patch_interactive));
+		exit(interactive_add(repo, argv + 1, prefix, patch_interactive));
 	}
 
 	if (edit_interactive) {
 		if (pathspec_from_file)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--edit");
-		return(edit_patch(argc, argv, prefix, the_repository));
+		return(edit_patch(repo, argc, argv, prefix));
 	}
 	argc--;
 	argv++;
@@ -415,10 +425,10 @@ int cmd_add(int argc,
 	add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
 	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
 
-	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
 
 	/*
 	 * Check the "pathspec '%s' did not match any files" block
@@ -459,11 +469,11 @@ int cmd_add(int argc,
 		 (!(addremove || take_worktree_changes)
 		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
-	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
+	if (repo_read_index_preload(repo, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
 
-	die_in_unpopulated_submodule(the_repository->index, prefix);
-	die_path_inside_submodule(the_repository->index, &pathspec);
+	die_in_unpopulated_submodule(repo->index, prefix);
+	die_path_inside_submodule(repo->index, &pathspec);
 
 	if (add_new_files) {
 		int baselen;
@@ -475,13 +485,13 @@ int cmd_add(int argc,
 		}
 
 		/* This picks up the paths that are not tracked */
-		baselen = fill_directory(&dir, the_repository->index, &pathspec);
+		baselen = fill_directory(&dir, repo->index, &pathspec);
 		if (pathspec.nr)
-			seen = prune_directory(&dir, &pathspec, baselen);
+			seen = prune_directory(repo, &dir, &pathspec, baselen);
 	}
 
 	if (refresh_only) {
-		exit_status |= refresh(verbose, &pathspec);
+		exit_status |= refresh(repo, verbose, &pathspec);
 		goto finish;
 	}
 
@@ -492,7 +502,7 @@ int cmd_add(int argc,
 
 		if (!seen)
 			seen = find_pathspecs_matching_against_index(&pathspec,
-					the_repository->index, PS_IGNORE_SKIP_WORKTREE);
+					repo->index, PS_IGNORE_SKIP_WORKTREE);
 
 		/*
 		 * file_exists() assumes exact match
@@ -528,8 +538,8 @@ int cmd_add(int argc,
 			    !file_exists(path)) {
 				if (ignore_missing) {
 					int dtype = DT_UNKNOWN;
-					if (is_excluded(&dir, the_repository->index, path, &dtype))
-						dir_add_ignored(&dir, the_repository->index,
+					if (is_excluded(&dir, repo->index, path, &dtype))
+						dir_add_ignored(&dir, repo->index,
 								path, pathspec.items[i].len);
 				} else
 					die(_("pathspec '%s' did not match any files"),
@@ -552,9 +562,9 @@ int cmd_add(int argc,
 
 	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_renormalize)
-		exit_status |= renormalize_tracked_files(&pathspec, flags);
+		exit_status |= renormalize_tracked_files(repo, &pathspec, flags);
 	else
-		exit_status |= add_files_to_cache(the_repository, prefix,
+		exit_status |= add_files_to_cache(repo, prefix,
 						  &pathspec, ps_matched,
 						  include_sparse, flags);
 
@@ -563,14 +573,14 @@ int cmd_add(int argc,
 		exit(128);
 
 	if (add_new_files)
-		exit_status |= add_files(&dir, flags);
+		exit_status |= add_files(repo, &dir, flags);
 
 	if (chmod_arg && pathspec.nr)
-		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
+		exit_status |= chmod_pathspec(repo, &pathspec, chmod_arg[0], show_only);
 	end_odb_transaction();
 
 finish:
-	if (write_locked_index(the_repository->index, &lock_file,
+	if (write_locked_index(repo->index, &lock_file,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write new index file"));
 
diff --git a/builtin/commit.c b/builtin/commit.c
index fd1cc42c5a6..6c79923ee04 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -395,7 +395,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
 		setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
-		if (interactive_add(argv, prefix, patch_interactive) != 0)
+		if (interactive_add(the_repository, argv, prefix, patch_interactive) != 0)
 			die(_("interactive add failed"));
 
 		the_repository->index_file = old_repo_index_file;
diff --git a/commit.h b/commit.h
index 0e5fce543c2..c3ddaaf30f9 100644
--- a/commit.h
+++ b/commit.h
@@ -253,7 +253,10 @@ struct oid_array;
 struct ref;
 int for_each_commit_graft(each_commit_graft_fn, void *);
 
-int interactive_add(const char **argv, const char *prefix, int patch);
+int interactive_add(struct repository *repo,
+		    const char **argv,
+		    const char *prefix,
+		    int patch);
 
 struct commit_extra_header {
 	struct commit_extra_header *next;
-- 
gitgitgadget
