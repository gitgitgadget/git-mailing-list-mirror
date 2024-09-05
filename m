Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E21A08D7
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555477; cv=none; b=gOX2BVhcEbMjcFf0oEwlqDY3KseCXvP2rHfhhwNwMmv0cxfVPXt50bR0Tf2YdRNGyIICs6W9BFBAqSNpgJgXaUZUqe1NA/RlqydyB+Fl/zKTVwGvl4H/1K7Op+1M4gmQufs3C98r8hkRWJBmP5kOfvrpUQewLYr58fq0ZYDytsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555477; c=relaxed/simple;
	bh=lucANiGrlE7Nm4MtYPqt9SK+MVpkDWeWMiq0kssxGsw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mqvBVQfIY1yPoCzATZxQhCg/yQzypL+1f5HayPJqQdOBh9Yj6X1+jlMVJ84GC3MYZUmEGVJ2lZ67mYPWfwwWrFLRnkd+6RwZXY6vUStQTKljCMCFhDL6dvP6h/5AyLNhfd0EFjUPm/UEzqUGYLYO3w5PyM7R7YhT2BJPNTDAYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA/NVf36; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA/NVf36"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3cdba33b0so1145965a12.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725555473; x=1726160273; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9KuSqjpCUZRHaoM/jNNBpXqXkaT0VaOhflZ2gNuWwA=;
        b=ZA/NVf36DPNKozg9hsr3cIEPQwTV3AaWcscg8qFrenD2Zk2RVfeH53s6LOC+ttv4wQ
         imFazPahD5PnyDFfdGuWPaVSxJ2+XQN1xJZYPmhYwqt/obTih3a0D87Uek+nuNJxAuL5
         k7CEY5MQfgaRtYQh82+D6+GrOhi6yl+ggHEG83Hp2HAOmUkfw6dIhYxJNfqdwrG5OEkn
         R5cM52GlyRdqYFlcGuE1ikgAIGbpalZEbjyWc7Mqo0zggkqT4hjR0TEoWMHfS8PZt0xC
         va3lJvRG7Dllz4SQphpKzSETKdr7dFADcABE2KG++ZSlu4Ej2n1B454RBba3s4PFkH1U
         6Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725555473; x=1726160273;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9KuSqjpCUZRHaoM/jNNBpXqXkaT0VaOhflZ2gNuWwA=;
        b=Cu29M/1c4/th/ShwFEv8e8klwe7Lw+szDATjTUi1f4u7wssamBJcKtIgOAY3bfBAxE
         Xr+To7Pfa7aw6cK8SEBbAkaBYWXcfSG46u9DUe/gOif9H06fOxzV9bJsOU6idQdfK2xa
         S2etNqyNi8tqKWJX5ExNraeCeby/38XBANIkxeKKEjynJMIlT2owx/IoGeYgnmFs1Jjc
         XOBMdNSoEi+EcfTRX1P3b3iRf26t07TyFjtoacfRctR9joC4bu9f6k1HyyScIq/MpXHe
         H7MKL1CF1SYw4uQOhrfiIqXQYJFinhCJC3bXAwoTv57C0WBmSAcHWTMTJ+2686uEe23N
         0/xQ==
X-Gm-Message-State: AOJu0YxPLPmsTmpr2c/wun+xWdGdJPz+keBr+0UNtn7LM3R8iOsYlo+Z
	/LjoZ79Ipz/AguCZccNQYfvg3jfI5gEZFYrB9QThtyQ3VeOKTeN+WS+Qdg==
X-Google-Smtp-Source: AGHT+IF/iP5DJQ687E6oka8/lF6zQsz/a1jZZFU9qY63FeRlNLLaknykjLCch5FGBoisQALtj/9Zaw==
X-Received: by 2002:a50:8d8c:0:b0:5c2:5d34:a481 with SMTP id 4fb4d7f45d1cf-5c2757d6db0mr5088802a12.11.1725555472860;
        Thu, 05 Sep 2024 09:57:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc6985aasm1437570a12.70.2024.09.05.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:57:52 -0700 (PDT)
Message-Id: <bc9090469340fe2bead812918d149287dcda5609.1725555468.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 16:57:47 +0000
Subject: [PATCH 3/3] add: pass in repo variable instead of global
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

With the repository variable available in the builtin function as an
argument, pass this down into helper functions instead of using the
global the_repository.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/add.c    | 97 +++++++++++++++++++++++++-----------------------
 builtin/commit.c |  2 +-
 commit.h         |  3 +-
 3 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index dac832df3e7..a68fd7c8313 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -36,24 +36,27 @@ static int pathspec_file_nul;
 static int include_sparse;
 static const char *pathspec_from_file;
 
-static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
+static int chmod_pathspec(struct pathspec *pathspec,
+			  char flip,
+			  int show_only,
+			  struct repository *repo)
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
 
@@ -64,31 +67,31 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 	return ret;
 }
 
-static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
+static int renormalize_tracked_files(const struct pathspec *pathspec, int flags, struct repository *repo)
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
+static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec, int prefix, struct repository *repo)
 {
 	char *seen;
 	int i;
@@ -100,16 +103,16 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
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
+static int refresh(int verbose, const struct pathspec *pathspec, struct repository *repo)
 {
 	char *seen;
 	int i, ret = 0;
@@ -119,14 +122,14 @@ static int refresh(int verbose, const struct pathspec *pathspec)
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
@@ -147,7 +150,7 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 	return ret;
 }
 
-int interactive_add(const char **argv, const char *prefix, int patch)
+int interactive_add(const char **argv, const char *prefix, int patch, struct repository *repo)
 {
 	struct pathspec pathspec;
 	int ret;
@@ -159,15 +162,15 @@ int interactive_add(const char **argv, const char *prefix, int patch)
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
 
-static int edit_patch(int argc, const char **argv, const char *prefix)
+static int edit_patch(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
 	char *file = git_pathdup("ADD_EDIT.patch");
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -177,10 +180,10 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
-	if (repo_read_index(the_repository) < 0)
+	if (repo_read_index(repo) < 0)
 		die(_("could not read the index"));
 
-	repo_init_revisions(the_repository, &rev, prefix);
+	repo_init_revisions(repo, &rev, prefix);
 	rev.diffopt.context = 7;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
@@ -318,7 +321,7 @@ static void check_embedded_repo(const char *path)
 	strbuf_release(&name);
 }
 
-static int add_files(struct dir_struct *dir, int flags)
+static int add_files(struct dir_struct *dir, int flags, struct repository *repo)
 {
 	int i, exit_status = 0;
 	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
@@ -334,12 +337,12 @@ static int add_files(struct dir_struct *dir, int flags)
 
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
@@ -358,7 +361,7 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
-int cmd_add(int argc, const char **argv, const char *prefix, struct repository *repository UNUSED)
+int cmd_add(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
 	int exit_status = 0;
 	struct pathspec pathspec;
@@ -381,13 +384,13 @@ int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
 			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--interactive/--patch");
 		if (pathspec_from_file)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
-		exit(interactive_add(argv + 1, prefix, patch_interactive));
+		exit(interactive_add(argv + 1, prefix, patch_interactive, repo));
 	}
 
 	if (edit_interactive) {
 		if (pathspec_from_file)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--edit");
-		return(edit_patch(argc, argv, prefix));
+		return(edit_patch(argc, argv, prefix, repo));
 	}
 	argc--;
 	argv++;
@@ -410,10 +413,10 @@ int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
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
@@ -454,11 +457,11 @@ int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
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
@@ -470,13 +473,13 @@ int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
 		}
 
 		/* This picks up the paths that are not tracked */
-		baselen = fill_directory(&dir, the_repository->index, &pathspec);
+		baselen = fill_directory(&dir, repo->index, &pathspec);
 		if (pathspec.nr)
-			seen = prune_directory(&dir, &pathspec, baselen);
+			seen = prune_directory(&dir, &pathspec, baselen, repo);
 	}
 
 	if (refresh_only) {
-		exit_status |= refresh(verbose, &pathspec);
+		exit_status |= refresh(verbose, &pathspec, repo);
 		goto finish;
 	}
 
@@ -487,7 +490,7 @@ int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
 
 		if (!seen)
 			seen = find_pathspecs_matching_against_index(&pathspec,
-					the_repository->index, PS_IGNORE_SKIP_WORKTREE);
+					repo->index, PS_IGNORE_SKIP_WORKTREE);
 
 		/*
 		 * file_exists() assumes exact match
@@ -523,8 +526,8 @@ int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
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
@@ -547,9 +550,9 @@ int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
 
 	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_renormalize)
-		exit_status |= renormalize_tracked_files(&pathspec, flags);
+		exit_status |= renormalize_tracked_files(&pathspec, flags, repo);
 	else
-		exit_status |= add_files_to_cache(the_repository, prefix,
+		exit_status |= add_files_to_cache(repo, prefix,
 						  &pathspec, ps_matched,
 						  include_sparse, flags);
 
@@ -558,14 +561,14 @@ int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
 		exit(128);
 
 	if (add_new_files)
-		exit_status |= add_files(&dir, flags);
+		exit_status |= add_files(&dir, flags, repo);
 
 	if (chmod_arg && pathspec.nr)
-		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
+		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only, repo);
 	end_odb_transaction();
 
 finish:
-	if (write_locked_index(the_repository->index, &lock_file,
+	if (write_locked_index(repo->index, &lock_file,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write new index file"));
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 141c8d85620..d9ee6502448 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -396,7 +396,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
 		setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
-		if (interactive_add(argv, prefix, patch_interactive) != 0)
+		if (interactive_add(argv, prefix, patch_interactive, the_repository) != 0)
 			die(_("interactive add failed"));
 
 		the_repository->index_file = old_repo_index_file;
diff --git a/commit.h b/commit.h
index 0e5fce543c2..92fef717be1 100644
--- a/commit.h
+++ b/commit.h
@@ -2,6 +2,7 @@
 #define COMMIT_H
 
 #include "object.h"
+#include "repository.h"
 
 struct signature_check;
 struct strbuf;
@@ -253,7 +254,7 @@ struct oid_array;
 struct ref;
 int for_each_commit_graft(each_commit_graft_fn, void *);
 
-int interactive_add(const char **argv, const char *prefix, int patch);
+int interactive_add(const char **argv, const char *prefix, int patch, struct repository *repo);
 
 struct commit_extra_header {
 	struct commit_extra_header *next;
-- 
gitgitgadget
