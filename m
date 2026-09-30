Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454693E410F
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761751; cv=none; b=lhzt5vp7rbCZQIJ+YL1d+Xcf/6V79PXUaAvdG+vBWpd55g4eu1Vi7Qbndbx5KmWLXI8WmjfHBPUwrS8zoJ+GImHJ41mIpZM533AaI5OfcKli2x0ZJetTeC3JTZlmK0niHujcGcgzOUcpd4L+pLQ7zRi2du44RPvuVDWHW8NjKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761751; c=relaxed/simple;
	bh=Mc2d5B3X58VI4HpTI02lq2w5GoTts1ljNFUTCO+hlFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oC2ok6x7wRaVJ8uBQhJ1nAyHd6r6UoSpyql82Vwu6M8qxdZnq1KbShDf5+99jtIaRSktB8SEcJvBLFFkj/mhqaQ5vA0rEMn6qFreyRfXHUdPRE2HQ8ns86h5AdbY9hcJVD3568VnNtMSj7HYcZbqQ/Ib39I3f3+/vwcQUBAKzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pESqCNj8; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pESqCNj8"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so29264775e9.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 02:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790761747; x=1791366547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fb8DZTtSTh/1ejEo9FjCszAGfaqxhgyfbO51h+y4kVQ=;
        b=pESqCNj8s0JEe5/eXC9MI0IwWtF80BQ6mJIHuXHIsclSc6ez0+Falb3Ss6KSLjYdku
         hT5yKRgmX14rB2i8j9K2iWsYuwVrFSn4QoPxU9MVEvwlGvHZFe8Shc4Q2oQM61aC5Zfy
         DQocXKNYfyRSp/0cVPfUGuT5S+3z5RZLqR2SGsZ9aP1moab7aviMmZeureNgHDsmxuzk
         21BW9TL86qd5uM8UPssgK7dRX4NzIQKWO3modOygyxvkzQNunWRo+O4ICoLva5e+ASO0
         5BJ2u7BsGlZng5LEQNqQ+W6yj3X+8s9OosQRZ5eDN7lfroGW2TvFHbbY4brZin+cvfrs
         3J5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790761747; x=1791366547;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fb8DZTtSTh/1ejEo9FjCszAGfaqxhgyfbO51h+y4kVQ=;
        b=0Mmu4Kb/qxoGMFgVErthhC1j5+HU15Ihzu0KMDzQZCvyesr67QNqoiUwMDdg1y1scd
         J8V+UfZg8w72atYPE8ut9fAEZF9C9mMXsag0CwODkT+TIXBtywsBa49E07iDh30ydAbf
         0ZdFuESZ6MKG9RxrDXZmVKOR+RIt8psztw/ww6SJ0QK7jOHpiSWfe8DAEwz3n93a8Vc1
         WTAyBC3G/vFyOoEb+g5B/x5GqmTdIR/ka3gTDSPr+UHc1+DiAIOAbpz965kruhF6mixH
         5jrXpVygrizmtUyPWhRtoLKKQYns8lhxAis08hRzdC6V0WjTojZllzAuJe9Ueo12m9yq
         F6sg==
X-Gm-Message-State: AFuF++ls6pRlTlC7do0+JgSsjuM1rZytpHqX8o+BgklIhRG8eWYcIXle
	A5Ad6N0bsSbztXBw9nx200X3kC71ZspPX2RqrafGy/d5Uai9RwjJA2r6AeOI4ikJ
X-Gm-Gg: AYBFou18LW/tZsMhbycSJG1cueNcoqAR07vR4FYVXsPgnJenMU4X5iBNGegVbK5G1r1
	HBkgysqsFDXnWxWPKbDozLcJyhJClq9xEB5r/G0Q3bictOtDiRuw81RYElZJD7N7XVm9Q7Nilh4
	/nvd19U/h25/0oGr8ds/aji6DNzvX97rwvjMTd/5hNYNDRd+z+aLFbpnbTQYU7CFRa+jLjC3+wF
	+IJBZgGt72mzfHeylTfuSFudQcPkd8gG+0TT7uYz4G6R7goISHRzKvZtiMYvoxC9hxu+NYC87lm
	Frrwqoq9wVwMrtt7jx7vgM3tfBLTYCLfk93Sd4sMZtq67aepn7LoOR+IJbii9kiErSiiWq228Q/
	LOGsLfDwzs4XV1MO3G7cQs7Sa3V4/o2imfjxIbR1iwe4+PSzXbICj2ILCr8EyY+8ngfPDLdYK2T
	LZ4/NLvM1LBMRASpgmJgthx4NE0Hv5q1AzXzSERTAMfzJOKKXKZZvfqU0DE306h9A4KwKmWXbsN
	dk=
X-Received: by 2002:a05:600c:8712:b0:49f:cc2a:f73a with SMTP id 5b1f17b1804b1-4a01b0117ffmr14542665e9.25.1790761747174;
        Wed, 30 Sep 2026 02:49:07 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0174e165fsm47632845e9.6.2026.09.30.02.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:49:06 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/2] merge: remember conflict labels
Date: Wed, 30 Sep 2026 10:48:49 +0100
Message-ID: <fdaf3da993366878b51bd0b2a950888710cafb8a.1790761727.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.rc0.210.gaf8b4f0d381
In-Reply-To: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When recreating merge conflicts with "git checkout -m <path>" the
original conflict labels are lost. For commands like "git merge" and
"git cherry-pick" we could use the presence of the related root
ref (MERGE_HEAD and CHERRY_PICK_HEAD respectively) to recreate the
labels. However, if the conflicts are from "git stash pop" or "git
checkout -m <branch>", then there is no ref to deduce the labels from. To
ensure the labels are always available, the merge machinery is updated to
write ".git/MERGE_LABELS" when it updates the worktree and
there are conflicts. The labels are then read from that file by "git
checkout -m <path>" when recreating the conflicts.

As "git checkout -m <branch>" calls remove_branch_state() which
ordinarily removes the labels file, we need to pass a flag down
to optionally prevent that so that the labels are available for any
subsequent "git checkout -m <path>". Note that merge_switch_to_result()
we assign "result->priv" to "opt->priv" and later clear "opt->priv" in
order to get a pointer to the private struct as result->priv is void*.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 branch.c           | 11 ++++++--
 branch.h           |  1 +
 builtin/checkout.c | 24 +++++++++++++++---
 builtin/commit.c   |  1 +
 merge-ort.c        | 19 ++++++++++++++
 merge.c            | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 merge.h            |  4 +++
 path.c             |  1 +
 path.h             |  1 +
 repository.c       |  1 +
 repository.h       |  1 +
 sequencer.c        |  1 +
 t/t7201-co.sh      | 21 ++++++++++++++++
 13 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index 8bc7a395a7..5bb1c28915 100644
--- a/branch.c
+++ b/branch.c
@@ -860,9 +860,11 @@ void create_branches_recursively(struct repository *r, const char *name,
 	free(branch_point);
 }
 
-void remove_merge_branch_state(struct repository *r)
+static void do_remove_merge_branch_state(struct repository *r, unsigned flags)
 {
 	unlink(git_path_merge_head(r));
+	if (!(flags & REMOVE_BRANCH_STATE_PRESERVE_CONFLICT_LABELS))
+		unlink(git_path_merge_labels(r));
 	unlink(git_path_merge_rr(r));
 	unlink(git_path_merge_msg(r));
 	unlink(git_path_merge_mode(r));
@@ -871,11 +873,16 @@ void remove_merge_branch_state(struct repository *r)
 	save_autostash_ref(r, "MERGE_AUTOSTASH");
 }
 
+void remove_merge_branch_state(struct repository *r)
+{
+	do_remove_merge_branch_state(r, 0);
+}
+
 void remove_branch_state(struct repository *r, unsigned flags)
 {
 	sequencer_post_commit_cleanup(r, flags & REMOVE_BRANCH_STATE_VERBOSE);
 	unlink(git_path_squash_msg(r));
-	remove_merge_branch_state(r);
+	do_remove_merge_branch_state(r, flags);
 }
 
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
diff --git a/branch.h b/branch.h
index 42d1b12918..95b2431f24 100644
--- a/branch.h
+++ b/branch.h
@@ -128,6 +128,7 @@ int validate_branchname(const char *name, struct strbuf *ref);
 int validate_new_branchname(const char *name, struct strbuf *ref, int force);
 
 #define REMOVE_BRANCH_STATE_VERBOSE (1u << 0)
+#define REMOVE_BRANCH_STATE_PRESERVE_CONFLICT_LABELS (1u << 1)
 /*
  * Remove information about the merge state on the current
  * branch. (E.g., MERGE_HEAD)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bdd2d816b6..295fe0e9fa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -15,6 +15,7 @@
 #include "hex.h"
 #include "hook.h"
 #include "merge-ll.h"
+#include "merge.h"
 #include "lockfile.h"
 #include "mem-pool.h"
 #include "object-file.h"
@@ -317,6 +318,7 @@ static int checkout_merged(int pos, const struct checkout *state,
 	struct cache_entry *ce = the_repository->index->cache[pos];
 	const char *path = ce->name;
 	mmfile_t ancestor, ours, theirs;
+	char *base_label, *ours_label, *theirs_label;
 	enum ll_merge_result merge_status;
 	int status;
 	struct object_id oid;
@@ -347,10 +349,19 @@ static int checkout_merged(int pos, const struct checkout *state,
 
 	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
 	ll_opts.renormalize = renormalize;
+	if (read_merge_labels(the_repository, &base_label, &ours_label,
+			      &theirs_label)) {
+		base_label = xstrdup("base");
+		ours_label = xstrdup("ours");
+		theirs_label = xstrdup("theirs");
+	}
 	ll_opts.conflict_style = conflict_style;
-	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
-				&ours, "ours", &theirs, "theirs",
+	merge_status = ll_merge(&result_buf, path, &ancestor, base_label,
+				&ours, ours_label, &theirs, theirs_label,
 				state->istate, &ll_opts);
+	free(base_label);
+	free(ours_label);
+	free(theirs_label);
 	free(ancestor.ptr);
 	free(ours.ptr);
 	free(theirs.ptr);
@@ -946,7 +957,8 @@ static void report_tracking(struct branch_info *new_branch_info)
 
 static void update_refs_for_switch(const struct checkout_opts *opts,
 				   struct branch_info *old_branch_info,
-				   struct branch_info *new_branch_info)
+				   struct branch_info *new_branch_info,
+				   bool merge_conflicts)
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc, *reflog_msg;
@@ -1048,6 +1060,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	}
 	if (!opts->quiet)
 		flags |= REMOVE_BRANCH_STATE_VERBOSE;
+	if (merge_conflicts)
+		flags |= REMOVE_BRANCH_STATE_PRESERVE_CONFLICT_LABELS;
 	remove_branch_state(the_repository, flags);
 	strbuf_release(&msg);
 	if (!opts->quiet &&
@@ -1262,7 +1276,9 @@ static int switch_branches(const struct checkout_opts *opts,
 
 	if (autostash_res == STASH_APPLY_CONFLICT && !opts->quiet)
 		fputc('\n', stderr);
-	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
+
+	update_refs_for_switch(opts, &old_branch_info, new_branch_info,
+			       autostash_res == STASH_APPLY_CONFLICT);
 
 	if (created_autostash) {
 		discard_index(the_repository->index);
diff --git a/builtin/commit.c b/builtin/commit.c
index 205fbd57e3..c374d5e0d5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1977,6 +1977,7 @@ int cmd_commit(int argc,
 
 	sequencer_post_commit_cleanup(the_repository, 0);
 	unlink(git_path_merge_head(the_repository));
+	unlink(git_path_merge_labels(the_repository));
 	unlink(git_path_merge_msg(the_repository));
 	unlink(git_path_merge_mode(the_repository));
 	unlink(git_path_squash_msg(the_repository));
diff --git a/merge-ort.c b/merge-ort.c
index c410a5d353..783e74c6e3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -35,6 +35,7 @@
 #include "hex.h"
 #include "entry.h"
 #include "merge-ll.h"
+#include "merge.h"
 #include "match-trees.h"
 #include "mem-pool.h"
 #include "object-file.h"
@@ -418,6 +419,9 @@ struct merge_options_internal {
 
 	/* field that holds submodule conflict information */
 	struct string_list conflicted_submodules;
+
+	/* Copies of the labels used for conflict markers */
+	char *labels[3];
 };
 
 struct conflicted_submodule_item {
@@ -4969,6 +4973,13 @@ void merge_switch_to_result(struct merge_options *opt,
 			return;
 		}
 		trace2_region_leave("merge", "write_auto_merge", opt->repo);
+
+		trace2_region_enter("merge", "write_merge_labels", opt->repo);
+		opt->priv = result->priv;
+		write_merge_labels(opt->repo, opt->priv->labels[0], opt->priv->labels[1],
+				   opt->priv->labels[2]);
+		opt->priv = NULL;
+		trace2_region_leave("merge", "write_merge_labels", opt->repo);
 	}
 	if (display_update_msgs)
 		merge_display_update_messages(opt, /* detailed */ 0, result);
@@ -5234,6 +5245,14 @@ static void move_opt_priv_to_result_priv(struct merge_options *opt,
 	 * to move it.
 	 */
 	assert(opt->priv && !result->priv);
+	if (!result->clean) {
+		opt->priv->labels[0] =
+			mem_pool_strdup(&opt->priv->pool, opt->ancestor);
+		opt->priv->labels[1] =
+			mem_pool_strdup(&opt->priv->pool, opt->branch1);
+		opt->priv->labels[2] =
+			mem_pool_strdup(&opt->priv->pool, opt->branch2);
+	}
 	result->priv = opt->priv;
 	result->_properly_initialized = RESULT_INITIALIZED;
 	opt->priv = NULL;
diff --git a/merge.c b/merge.c
index 0f5e823e63..95495ae1ba 100644
--- a/merge.c
+++ b/merge.c
@@ -8,6 +8,7 @@
 #include "merge.h"
 #include "commit.h"
 #include "repository.h"
+#include "path.h"
 #include "run-command.h"
 #include "resolve-undo.h"
 #include "tree.h"
@@ -111,3 +112,65 @@ int checkout_fast_forward(struct repository *r,
 		return error(_("unable to write new index file"));
 	return 0;
 }
+
+int write_merge_labels(struct repository *r, const char *base,
+			  const char *ours, const char *theirs)
+{
+	FILE *f = fopen_or_warn(git_path_merge_labels(r), "w");
+
+	if (!f)
+		return -1;
+
+	fprintf(f, "%s\n%s\n%s\n", base, ours, theirs);
+	if (fclose(f))
+		return error_errno("could not write '%s'",
+				   git_path_merge_labels(r));
+
+	return 0;
+}
+
+static int parse_merge_label_line(const char **p, char **line)
+{
+	const char *eol = strchr(*p, '\n');
+
+	if (!eol)
+		return -1;
+
+	*line = xmemdupz(*p, eol - *p);
+	*p = eol + 1;
+
+	return 0;
+}
+
+int read_merge_labels(struct repository *r,
+		      char **pbase, char** pours, char** ptheirs)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *p;
+	char *base = NULL, *ours = NULL, *theirs = NULL;
+	int ret = -1;
+
+	if (strbuf_read_file(&buf, git_path_merge_labels(r), 0) < 0)
+		return -1;
+
+	p = buf.buf;
+	if (parse_merge_label_line(&p, &base))
+		goto out;
+	if (parse_merge_label_line(&p, &ours))
+		goto out;
+	if (parse_merge_label_line(&p, &theirs))
+		goto out;
+	ret = 0;
+	*pbase = base;
+	*pours = ours;
+	*ptheirs = theirs;
+out:
+	if (ret) {
+		free(base);
+		free(ours);
+		free(theirs);
+	}
+	strbuf_release(&buf);
+
+	return ret;
+}
diff --git a/merge.h b/merge.h
index 21ac7ef2f1..0772737a87 100644
--- a/merge.h
+++ b/merge.h
@@ -13,5 +13,9 @@ int checkout_fast_forward(struct repository *r,
 			  const struct object_id *from,
 			  const struct object_id *to,
 			  int overwrite_ignore);
+int write_merge_labels(struct repository *r,
+		       const char *base, const char *ours, const char *theirs);
+int read_merge_labels(struct repository *r,
+		      char **base, char **ours, char **theirs);
 
 #endif /* MERGE_H */
diff --git a/path.c b/path.c
index c3a709a928..7965762602 100644
--- a/path.c
+++ b/path.c
@@ -1655,3 +1655,4 @@ REPO_GIT_PATH_FUNC(merge_mode, "MERGE_MODE")
 REPO_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
 REPO_GIT_PATH_FUNC(fetch_head, "FETCH_HEAD")
 REPO_GIT_PATH_FUNC(shallow, "shallow")
+REPO_GIT_PATH_FUNC(merge_labels, "MERGE_LABELS")
diff --git a/path.h b/path.h
index 7e7408dd05..8cd12ccfde 100644
--- a/path.h
+++ b/path.h
@@ -142,6 +142,7 @@ const char *git_path_merge_mode(struct repository *r);
 const char *git_path_merge_head(struct repository *r);
 const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
+const char *git_path_merge_labels(struct repository *r);
 
 int ends_with_path_components(const char *path, const char *components);
 
diff --git a/repository.c b/repository.c
index b857e1c580..210fb819b0 100644
--- a/repository.c
+++ b/repository.c
@@ -367,6 +367,7 @@ static void repo_clear_path_cache(struct repo_path_cache *cache)
 	FREE_AND_NULL(cache->merge_head);
 	FREE_AND_NULL(cache->fetch_head);
 	FREE_AND_NULL(cache->shallow);
+	FREE_AND_NULL(cache->merge_labels);
 }
 
 void repo_clear(struct repository *repo)
diff --git a/repository.h b/repository.h
index 11f5c2ed10..91b1f57db7 100644
--- a/repository.h
+++ b/repository.h
@@ -36,6 +36,7 @@ struct repo_path_cache {
 	char *merge_head;
 	char *fetch_head;
 	char *shallow;
+	char *merge_labels;
 };
 
 struct repository {
diff --git a/sequencer.c b/sequencer.c
index e25ef5eb61..0710aa6400 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5145,6 +5145,7 @@ static int pick_commits(struct repository *r,
 	unlink(rebase_path_stopped_sha());
 	unlink(rebase_path_amend());
 	unlink(rebase_path_patch());
+	unlink(git_path_merge_labels(r));
 
 	while (todo_list->current < todo_list->nr) {
 		struct todo_item *item = todo_list->items + todo_list->current;
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9ea9462914..7d0dcf8c8b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -183,6 +183,27 @@ test_expect_success 'format of merge conflict from checkout -m' '
 	d
 	>>>>>>> local
 	EOF
+	test_cmp expect two &&
+
+	test_path_is_file .git/MERGE_LABELS &&
+
+	git checkout --conflict=diff3 two &&
+	cat >expect <<-\EOF &&
+	<<<<<<< simple
+	a
+	c
+	e
+	||||||| main
+	a
+	b
+	c
+	d
+	e
+	=======
+	b
+	d
+	>>>>>>> local
+	EOF
 	test_cmp expect two
 '
 
-- 
2.56.0.rc2.84.gaf8b4f0d381

