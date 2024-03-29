Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F83C24
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746166; cv=none; b=PBT/ei27Kc2jKuSB8xMcgeOTFARfP2AccyjbrC93Zqogd9Pa4UVcuYyWhA7fg6jwevYmD4B/GwLzjOb+t3etzbHI/lGsM74lELs0arwv7r6EjIkgOLJG9yVnU4UwIJpL3MjLeEItkvcqMyuIbhnIODW0Lwa0uwULPH2gmO3P0ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746166; c=relaxed/simple;
	bh=l6JTq4tAOOpyT/FOn8kLTaTH0sE1w61Y98t/VbXB2LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHwryBq8CJfvJJ6GUXYVsC3a5w1+Ch0OGBii359/Umh17QweBgN4uX9N7bFwMJIoPHQgy3j8Fx7mUAWu65+EVA6vBsZGImvKA+LdOokH69ZE7WGGW9MfIh5QTkM+5UZVPdEQ+JOn5a+d9BBUmYu0RPFBrM2NnIBzf5bAkRN344g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnWa7IzC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnWa7IzC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0878b76f3so17585925ad.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711746164; x=1712350964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RawA0idWQKMHLdGni5AZRMluA05KB/Z9YAd40AJoXfk=;
        b=CnWa7IzClY8qyBO1z+vL4B9L7sdh0168cKVNz6HIZ0+6xX0Thd+02wsNEQZd5LiXBy
         m0ehOsZiO4okRV/c/ZxaicsjCxHn5JEvlEEx0U3p/m/oaVUMvSJ/67FADWq38mpS9PrY
         RqtGfPVg1SdI526DQe0mWWqxqs7CI9xL4B4MMuKx9JkPihA966ycGjPO9DkxVy4XcZ65
         cGSOB+hYMF2FkYeMie9AoSWrmIelFxleqA7cAnmNWZYUDKshDsIxqxmoSboJLrdQpvg2
         Yh3bR0E/uIqIMP1lbb3mP1p0PRDVIXel6PDPxppeFpJ8V61OavhEEQtoP5QK9bKQujHL
         MSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711746164; x=1712350964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RawA0idWQKMHLdGni5AZRMluA05KB/Z9YAd40AJoXfk=;
        b=J2uja/9QDy+fKsdzoo024EReGs+vrqtZVJame7ntMgBSvwW8Za4i7nrjeLLlWF9oQz
         BT2VzTNAHUPgrkQiMtv7bYDOGCz2Yr8ax4sELER0/lAote94RYtXgcs3tb4/xkzZFp1K
         JpzN3yT4IMfSZ4vixdAVNfeVsvpJ30aKCEY+ifn6VOil/rJU2b1R75gh6YQWfLV7kJlR
         QqnB9GVKMImVaiQE0mNf22usXMBhST0cI4i6zcN6uXGT3dSWQnqnWtSG6quN3mFhixLj
         TlkU2Qx5+nQvXCQt/YzWSI4WuNcGnssCWeKF+BFPAGc+mIArh0OZq+FafwYzqUDg7+1h
         ZUFA==
X-Gm-Message-State: AOJu0Yzk9V5eu1KMT7faUOzttkD9N88ZJnJgsErcyejcMY5KkR5oOY9y
	nW+1SoOQffYDJoXK0nNVqLmtNLiG+Oah4ocB9VRtHlgSYyk83ZpQ6F7go5NtGbI=
X-Google-Smtp-Source: AGHT+IGkJcf6BPGHMuB8so4xdpRIlq0ZbwZwlO3nlZzJbt/+lhDjEd1Q9TRrx+nYoVOSHUD/EU1kZw==
X-Received: by 2002:a17:902:e54c:b0:1e0:e650:5ab with SMTP id n12-20020a170902e54c00b001e0e65005abmr9379538plf.16.1711746163598;
        Fri, 29 Mar 2024 14:02:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001e020a47fe9sm3875327plr.261.2024.03.29.14.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 14:02:43 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 1/3] read-cache: optionally collect pathspec matching info
Date: Sat, 30 Mar 2024 02:26:19 +0530
Message-ID: <20240329205649.1483032-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318155219.494206-2-shyamthakkar001@gmail.com>
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The add_files_to_cache() adds files to the index. And
add_files_to_cache() in turn calls run_diff_files() to perform this
operation. The run_diff_files() uses ce_path_match() to match the
pathspec against cache entries. However, it is called with NULL value
for the seen parameter, which collects the pathspec matching
information.

Therefore, introduce a new parameter 'char *ps_matched' to 
add_files_to_cache() and in turn to run_diff_files(), to feed it to
ce_path_match() to optionally collect the pathspec matching
information. This will be helpful in reporting error in case of an
untracked path being passed when the expectation is a known path. Thus,
this will be used in the subsequent commits to fix 'commit -i' and 'add
-u' not erroring out when given untracked paths.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 add-interactive.c           | 2 +-
 builtin/add.c               | 6 +++---
 builtin/checkout.c          | 3 ++-
 builtin/commit.c            | 2 +-
 builtin/diff-files.c        | 2 +-
 builtin/diff.c              | 2 +-
 builtin/merge.c             | 2 +-
 builtin/stash.c             | 2 +-
 builtin/submodule--helper.c | 4 ++--
 diff-lib.c                  | 5 +++--
 diff.h                      | 3 ++-
 read-cache-ll.h             | 4 ++--
 read-cache.c                | 6 +++---
 wt-status.c                 | 6 +++---
 14 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 6bf87e7ae7..b33260a611 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -572,7 +572,7 @@ static int get_modified_files(struct repository *r,
 			run_diff_index(&rev, DIFF_INDEX_CACHED);
 		else {
 			rev.diffopt.flags.ignore_dirty_submodules = 1;
-			run_diff_files(&rev, 0);
+			run_diff_files(&rev, NULL, 0);
 		}
 
 		release_revisions(&rev);
diff --git a/builtin/add.c b/builtin/add.c
index 393c10cbcf..ffe5fd8d44 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -191,7 +191,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	out = xopen(file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	rev.diffopt.file = xfdopen(out, "w");
 	rev.diffopt.close_file = 1;
-	run_diff_files(&rev, 0);
+	run_diff_files(&rev, NULL, 0);
 
 	if (launch_editor(file, NULL, NULL))
 		die(_("editing patch failed"));
@@ -553,8 +553,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
 	else
 		exit_status |= add_files_to_cache(the_repository, prefix,
-						  &pathspec, include_sparse,
-						  flags);
+						  &pathspec, NULL,
+						  include_sparse, flags);
 
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 902c97ab23..02bd035081 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -876,7 +876,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * entries in the index.
 			 */
 
-			add_files_to_cache(the_repository, NULL, NULL, 0, 0);
+			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
+					   0);
 			init_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_in_core_index_as_tree(the_repository);
diff --git a/builtin/commit.c b/builtin/commit.c
index a91197245f..24efeaca98 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -444,7 +444,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
-				   &pathspec, 0, 0);
+				   &pathspec, NULL, 0, 0);
 		refresh_cache_or_die(refresh_flags);
 		cache_tree_update(&the_index, WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 018011f29e..8559aa254c 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -81,7 +81,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 
 	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0)
 		die_errno("repo_read_index_preload");
-	run_diff_files(&rev, options);
+	run_diff_files(&rev, NULL, options);
 	result = diff_result_code(&rev.diffopt);
 	release_revisions(&rev);
 	return result;
diff --git a/builtin/diff.c b/builtin/diff.c
index 6e196e0c7d..3e9b838bdd 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -283,7 +283,7 @@ static void builtin_diff_files(struct rev_info *revs, int argc, const char **arg
 				    0) < 0) {
 		die_errno("repo_read_index_preload");
 	}
-	run_diff_files(revs, options);
+	run_diff_files(revs, NULL, options);
 }
 
 struct symdiff {
diff --git a/builtin/merge.c b/builtin/merge.c
index a0ba1f9815..4b4c1d6a31 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -979,7 +979,7 @@ static int evaluate_result(void)
 		DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = count_diff_files;
 	rev.diffopt.format_callback_data = &cnt;
-	run_diff_files(&rev, 0);
+	run_diff_files(&rev, NULL, 0);
 
 	/*
 	 * Check how many unmerged entries are
diff --git a/builtin/stash.c b/builtin/stash.c
index 7fb355bff0..2c00026390 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1121,7 +1121,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 		goto done;
 	}
 
-	run_diff_files(&rev, 0);
+	run_diff_files(&rev, NULL, 0);
 	if (diff_result_code(&rev.diffopt)) {
 		ret = 1;
 		goto done;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fda50f2af1..e9047021e0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -667,7 +667,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.abbrev = 0;
 	setup_revisions(diff_files_args.nr, diff_files_args.v, &rev, &opt);
-	run_diff_files(&rev, 0);
+	run_diff_files(&rev, NULL, 0);
 
 	if (!diff_result_code(&rev.diffopt)) {
 		print_status(flags, ' ', path, ce_oid,
@@ -1141,7 +1141,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	if (diff_cmd == DIFF_INDEX)
 		run_diff_index(&rev, info->cached ? DIFF_INDEX_CACHED : 0);
 	else
-		run_diff_files(&rev, 0);
+		run_diff_files(&rev, NULL, 0);
 	prepare_submodule_summary(info, &list);
 cleanup:
 	strvec_clear(&diff_args);
diff --git a/diff-lib.c b/diff-lib.c
index 5e8717c774..2dc3864abd 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -101,7 +101,8 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 	return changed;
 }
 
-void run_diff_files(struct rev_info *revs, unsigned int option)
+void run_diff_files(struct rev_info *revs, char *ps_matched,
+		    unsigned int option)
 {
 	int entries, i;
 	int diff_unmerged_stage = revs->max_count;
@@ -127,7 +128,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
 
-		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
+		if (!ce_path_match(istate, ce, &revs->prune_data, ps_matched))
 			continue;
 
 		if (revs->diffopt.prefix &&
diff --git a/diff.h b/diff.h
index 66bd8aeb29..a01feaa586 100644
--- a/diff.h
+++ b/diff.h
@@ -638,7 +638,8 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb);
 #define DIFF_SILENT_ON_REMOVED 01
 /* report racily-clean paths as modified */
 #define DIFF_RACY_IS_MODIFIED 02
-void run_diff_files(struct rev_info *revs, unsigned int option);
+void run_diff_files(struct rev_info *revs, char *ps_matched,
+		    unsigned int option);
 
 #define DIFF_INDEX_CACHED 01
 #define DIFF_INDEX_MERGE_BASE 02
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 2a50a784f0..09414afd04 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -480,8 +480,8 @@ extern int verify_ce_order;
 int cmp_cache_name_compare(const void *a_, const void *b_);
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
-		       const struct pathspec *pathspec, int include_sparse,
-		       int flags);
+		       const struct pathspec *pathspec, char *ps_matched,
+		       int include_sparse, int flags);
 
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git a/read-cache.c b/read-cache.c
index f546cf7875..e179444445 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3958,8 +3958,8 @@ static void update_callback(struct diff_queue_struct *q,
 }
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
-		       const struct pathspec *pathspec, int include_sparse,
-		       int flags)
+		       const struct pathspec *pathspec, char *ps_matched,
+		       int include_sparse, int flags)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
@@ -3985,7 +3985,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * may not have their own transaction active.
 	 */
 	begin_odb_transaction();
-	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+	run_diff_files(&rev, ps_matched, DIFF_RACY_IS_MODIFIED);
 	end_odb_transaction();
 
 	release_revisions(&rev);
diff --git a/wt-status.c b/wt-status.c
index 2db4bb3a12..cf6d61e60c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -629,7 +629,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
-	run_diff_files(&rev, 0);
+	run_diff_files(&rev, NULL, 0);
 	release_revisions(&rev);
 }
 
@@ -1173,7 +1173,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 		setup_work_tree();
 		rev.diffopt.a_prefix = "i/";
 		rev.diffopt.b_prefix = "w/";
-		run_diff_files(&rev, 0);
+		run_diff_files(&rev, NULL, 0);
 	}
 	release_revisions(&rev);
 }
@@ -2594,7 +2594,7 @@ int has_unstaged_changes(struct repository *r, int ignore_submodules)
 	}
 	rev_info.diffopt.flags.quick = 1;
 	diff_setup_done(&rev_info.diffopt);
-	run_diff_files(&rev_info, 0);
+	run_diff_files(&rev_info, NULL, 0);
 	result = diff_result_code(&rev_info.diffopt);
 	release_revisions(&rev_info);
 	return result;
-- 
2.44.0

