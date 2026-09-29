Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46B39936D
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667035; cv=none; b=nCsH0SUyvb95GM5ZF5Lq8uny5BvIA2FetWDOt7vyS1UrTXj+gbINQXOT3NkdHSouvpF1A/IPrlktjuu4QFlDPzCYgXdnUr3d9zaw6w015pfpKQoZVH+jlL2AOSo4QLoic+VgSopHmaeU/uYztLeWFrYXhAE8Wy9RB1JVOh4LUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667035; c=relaxed/simple;
	bh=iduN5N+/ShQ9D3Edhg99wR2VnqKy4tAOwCOA7apJr2w=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=upcxiPHMNubbtvptaZydrUz8Xzj+GjyULz3K6NyiSPWouZL4xgAZknmNaLjjcROe8Mmr0JnjALdSOP/uiG+NlYW4iF8Ljv0/JU+sKrh9QNtP4DThyVWy2kYd9YWpS8u9yitGL5YXYVPgt2ICXUhoDLPZjRxwhzGeq1w79Ugll3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvQw70eJ; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvQw70eJ"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2ad8bf95bso10800105ad.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790667033; x=1791271833; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L2FlFgyvZwyPcjMUxmGd7bLmAAtRzHWcG4Fs0ylmrxY=;
        b=JvQw70eJm35uyJb6gZlnSDXnUHvHpWHoCp46E9gOJhA1j3glsmEAxqHv4Q6Z8cffyW
         NifkAGxbSMoebXtzAb1M+gJAZbWfAuTsz7WtjXTWjvLGSksBbJGvE5R1ClBAdtPvO8Ev
         zkwYEWHlrJEu56xzWerALE519uNFwRifZMmySjs4PCr0J2O2HOAk6sD/VaZfgvDoRra9
         dq98qBRK17fUDgjBIm/hSGwYDxnlJ+DBm4SzWB0tfTZ0Ah29rYVsd2PnLehBbr1Flhoc
         rg7+8y8+xYqTbQWVh7c3bLzqEKVjow110DQPqseKEzvHJDxLWF2hAQOSHv/HiGHvOxsC
         YdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667033; x=1791271833;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L2FlFgyvZwyPcjMUxmGd7bLmAAtRzHWcG4Fs0ylmrxY=;
        b=IlxL2dW8KuZWHkBA6BWtKTx8TMKiWrAi/l96uH1vyUsrkYLLFdGx/asre6mivbZC48
         PN+CgANsafrS/wBkX4jdePI4e5AqNDcVbMsMPFNrnlfUMOdXVQLiSswq/QQ4eUX+w0cs
         nMSOlea6gyEIckliTR9NXb5Ekt1wj3D6JFf4H9PLnQSKhjKfOz4vkyjTN6C37sCFjlYr
         PPJNhjZK3VOWYZeWIueuD538xYYCRVp8dNrySkxXuhOqVCdvjjjciDtfFXms/Hja8rCl
         egagu46Az542i8Sdhb/ceN6/23zn/8s9oR7VcjDirXJUiYRZIrKa2rUTGcGNvkOTJzGz
         RzlQ==
X-Gm-Message-State: AFq9FYI135ezJWtjXYA3RHFkkNy676HRH00SXiIvmdXY9+yAODuwrnFW
	/wrz/y5Fl306xMAOfsmZBDxchtDg9HQTcMQ3twbcPrOCKtFXQg/lbVeVEmVSdA==
X-Gm-Gg: AYBFou3T/7uEdT3BryUDEhSMqvK9ffPucR8XD8ctcxalKcE0vwEAbXi8q2EOYS9QImF
	/dWuXI7aqVOZQerY+x77t7zQaj4r4r4Wq0AS5aS6z4vAHJk/AdBNIAIiPqKbUwD8jw28dzvtfD4
	H9W7ePr/Jj0hRaIV42a9ofMeRhYBUQ9O/JgTF9CscW47S6Rt7mgfG6r55Y+KvLxewe9k110Dk4B
	hjI0uCNAbVEL5QIoud/y+QlBbKimYiA5c4sOGsnG/+oa6EQnJJuIl0qdHc1ppLi0wDgqeC5dGL8
	iiiw7i6Ay3P0iXPeXUgzmQfr/ZRo4PR1uGBeKxo8oleqxkhsPZ0qfNdqvphc+iLa0kVwDZd0SGi
	OhyyT7SMyWRYWZYd0FvCkZZ3YcnaECqvDM/mHd354VmVTUjx0+fmtyL9oxoh5AbKgnxHl43yyjp
	b/TDYpqEnYv++0etm7wCQ+3ovs91W+AUjpLgoxXfubnCEnBs4uvx7dTminY4zsIvi3h0xQl1Zhl
	g==
X-Received: by 2002:a17:903:2303:b0:2dd:c053:9c70 with SMTP id d9443c01a7336-2df94b92b78mr89978685ad.38.1790667032775;
        Tue, 29 Sep 2026 00:30:32 -0700 (PDT)
Received: from [127.0.0.1] ([4.149.237.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dfa60bfb1csm38209595ad.48.2026.09.29.00.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:30:31 -0700 (PDT)
Message-Id: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 07:30:30 +0000
Subject: [PATCH] branch: let --delete-merged find squash merged branches
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Branches merged on GitHub with "Squash and merge" or "Rebase and
merge" are never deleted by "git branch --delete-merged". The upstream
holds a rewritten copy of their work, so their tips are not reachable
from it and they look unmerged forever.

Treat such a branch as merged when some upstream commit since the fork
point contains all of its changes, so that merging the branch into
that commit would change nothing. Name that commit in the output so
the user can see where the work went:

    Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).

The first upstream commit that contains the changes is used, so the
branch is deleted even if upstream later reverted or reworked them.
Nothing is lost, since that commit keeps them in the upstream history.
A branch whose changes only partly landed is kept.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    branch: let --delete-merged find squash merged branches
    
    Branches merged on GitHub with "Squash and merge" or "Rebase and merge"
    are never deleted by git branch --delete-merged, because their tips are
    not reachable from the upstream. This treats such a branch as merged
    when some upstream commit contains all of its changes, and names that
    commit in the output:
    
    Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).
    
    
    After the release of 2.56, I saw people liking the --delete-merged
    feature, but asking for this. A lot of people, me included prefer
    squash-merge and it currently doesn't work with --delete-merged.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2425%2FHaraldNordgren%2Fbranch-delete-squashed-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2425/HaraldNordgren/branch-delete-squashed-v1
Pull-Request: https://github.com/git/git/pull/2425

 Documentation/git-branch.adoc |  15 +--
 builtin/branch.c              | 183 ++++++++++++++++++++++++++++++++--
 t/t3200-branch.sh             |  74 ++++++++++++++
 3 files changed, 259 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index bfdf459329..0427324de1 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -204,12 +204,15 @@ This option is only applicable in non-verbose mode.
 
 `--delete-merged <pattern>`::
 	Delete local branches whose configured upstream matches
-	_<pattern>_, but only when their tip is reachable from that
-	upstream. In other words, the work on the branch has already
-	landed on the upstream it tracks, so the local copy is no longer
-	needed. _<pattern>_ may name a ref, a remote (using the branch its
-	`HEAD` points at), or a shell-style glob. The option can be
-	repeated to widen the upstream match.
+	_<pattern>_, but only when their work has already landed on that
+	upstream, so the local copy is no longer needed. This is the case
+	when their tip is reachable from the upstream, or when some
+	upstream commit contains all of their changes, as happens after
+	a squash or rebase merge, even if those changes were later
+	reverted. The message for such a branch names the first upstream
+	commit that contains its changes. _<pattern>_ may name a ref, a
+	remote (using the branch its `HEAD` points at), or a shell-style
+	glob. The option can be repeated to widen the upstream match.
 	Optional _<branch-pattern>_ arguments limit which local branches
 	are considered, e.g. `git branch --delete-merged 'origin/*'
 	'topic-*'`.
diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..982a8abe24 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -29,6 +29,13 @@
 #include "help.h"
 #include "advice.h"
 #include "commit-reach.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "hex.h"
+#include "merge-ll.h"
+#include "revision.h"
+#include "tree-walk.h"
+#include "xdiff-interface.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
@@ -236,7 +243,7 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int kinds,
-			   unsigned int flags)
+			   unsigned int flags, struct strmap *landed_commits)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -334,6 +341,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		}
 
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		    !(landed_commits &&
+		      strmap_contains(landed_commits, bname.buf)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
 			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
@@ -357,15 +366,33 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
+		struct commit *landed = landed_commits ?
+			strmap_get(landed_commits, name + branch_name_pos) : NULL;
+		const char *landed_abbrev = landed ?
+			repo_find_unique_abbrev(the_repository,
+						&landed->object.oid,
+						DEFAULT_ABBREV) : NULL;
+
 		if (flags & DELETE_BRANCH_DRY_RUN) {
-			if (!(flags & DELETE_BRANCH_QUIET))
+			if (flags & DELETE_BRANCH_QUIET)
+				;
+			else if (landed)
+				printf(_("Would delete branch %s (was %s, landed as %s).\n"),
+				       name + branch_name_pos, describe_ref,
+				       landed_abbrev);
+			else
 				printf(remote_branch
 					? _("Would delete remote-tracking branch %s (was %s).\n")
 					: _("Would delete branch %s (was %s).\n"),
 					name + branch_name_pos, describe_ref);
 		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
-			if (!(flags & DELETE_BRANCH_QUIET))
+			if (flags & DELETE_BRANCH_QUIET)
+				;
+			else if (landed)
+				printf(_("Deleted branch %s (was %s, landed as %s).\n"),
+				       refname, describe_ref, landed_abbrev);
+			else
 				printf(remote_branch
 					? _("Deleted remote-tracking branch %s (was %s).\n")
 					: _("Deleted branch %s (was %s).\n"),
@@ -824,6 +851,134 @@ static int branch_pushes_to_upstream(struct branch *branch,
 	return ret;
 }
 
+struct branch_change {
+	char *path;
+	struct object_id base_oid, branch_oid;
+	unsigned short branch_mode;
+};
+
+static void collect_branch_changes(struct commit *base, struct commit *rev,
+				   struct branch_change **changes,
+				   size_t *nr, size_t *alloc)
+{
+	struct diff_options opt;
+
+	repo_diff_setup(the_repository, &opt);
+	opt.flags.recursive = 1;
+	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&opt);
+	diff_tree_oid(get_commit_tree_oid(base), get_commit_tree_oid(rev),
+		      "", &opt);
+	for (int i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+		struct branch_change *change;
+
+		ALLOC_GROW(*changes, *nr + 1, *alloc);
+		change = &(*changes)[(*nr)++];
+		change->path = xstrdup(p->two->path);
+		oidcpy(&change->base_oid, DIFF_FILE_VALID(p->one) ?
+		       &p->one->oid : null_oid(the_hash_algo));
+		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
+		       &p->two->oid : null_oid(the_hash_algo));
+		change->branch_mode = p->two->mode;
+	}
+	diff_flush(&opt);
+}
+
+static int merge_keeps_upstream(const struct branch_change *change,
+				const struct object_id *upstream_oid)
+{
+	mmfile_t base, upstream, branch;
+	mmbuffer_t result = { 0 };
+	int ret;
+
+	read_mmblob(&base, the_repository->objects, &change->base_oid);
+	read_mmblob(&upstream, the_repository->objects, upstream_oid);
+	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
+	ret = ll_merge(&result, change->path, &base, "base",
+		       &upstream, "upstream", &branch, "branch",
+		       the_repository->index, NULL) == LL_MERGE_OK &&
+	      result.size == upstream.size &&
+	      !memcmp(result.ptr, upstream.ptr, upstream.size);
+
+	free(base.ptr);
+	free(upstream.ptr);
+	free(branch.ptr);
+	free(result.ptr);
+	return ret;
+}
+
+static int change_landed(const struct branch_change *change,
+			 struct commit *commit)
+{
+	struct object_id oid;
+	unsigned short mode;
+
+	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
+			   change->path, &oid, &mode))
+		return is_null_oid(&change->branch_oid);
+	if (oideq(&oid, &change->branch_oid))
+		return mode == change->branch_mode;
+	if (is_null_oid(&change->base_oid) ||
+	    is_null_oid(&change->branch_oid) ||
+	    oideq(&oid, &change->base_oid) ||
+	    mode != change->branch_mode || !S_ISREG(mode))
+		return 0;
+	return merge_keeps_upstream(change, &oid);
+}
+
+static struct commit *find_landed_commit(struct commit *rev,
+					 struct commit *upstream)
+{
+	struct commit_list *merge_bases = NULL;
+	struct branch_change *changes = NULL;
+	size_t changes_nr = 0, changes_alloc = 0;
+	struct commit *commit, *landed = NULL;
+	struct strvec args = STRVEC_INIT;
+	struct rev_info revs;
+
+	if (repo_get_merge_bases(the_repository, upstream, rev,
+				 &merge_bases) < 0)
+		exit(128);
+	if (!merge_bases)
+		return NULL;
+	collect_branch_changes(merge_bases->item, rev, &changes,
+			       &changes_nr, &changes_alloc);
+	commit_list_free(merge_bases);
+	if (!changes_nr)
+		return NULL;
+
+	strvec_pushl(&args, "rev-list", "--reverse",
+		     oid_to_hex(&upstream->object.oid), NULL);
+	strvec_pushf(&args, "^%s", oid_to_hex(&rev->object.oid));
+	strvec_push(&args, "--");
+	for (size_t i = 0; i < changes_nr; i++)
+		strvec_pushf(&args, ":(literal)%s", changes[i].path);
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+	while (!landed && (commit = get_revision(&revs))) {
+		size_t i;
+
+		for (i = 0; i < changes_nr; i++)
+			if (!change_landed(&changes[i], commit))
+				break;
+		if (i == changes_nr)
+			landed = commit;
+	}
+	release_revisions(&revs);
+	clear_commit_marks(upstream, ALL_REV_FLAGS);
+	clear_commit_marks(rev, ALL_REV_FLAGS);
+	strvec_clear(&args);
+
+	for (size_t i = 0; i < changes_nr; i++)
+		free(changes[i].path);
+	free(changes);
+	return landed;
+}
+
 static int delete_merged_branches(const struct strvec *upstreams,
 				 const char **argv, unsigned int flags)
 {
@@ -832,6 +987,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct ref_array candidates = { 0 };
 	struct strset deletable_branch_names = STRSET_INIT;
 	struct strset protected_branch_names = STRSET_INIT;
+	struct strmap landed_commits = STRMAP_INIT;
 	struct strvec branches_to_delete = STRVEC_INIT;
 	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
@@ -852,6 +1008,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
+		struct commit *landed = NULL;
 		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
@@ -867,8 +1024,17 @@ static int delete_merged_branches(const struct strvec *upstreams,
 			continue;
 		if (check_branch_commit(branch_name, branch_name,
 					&candidates.items[i]->objectname, NULL,
-					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
-			continue;
+					FILTER_REFS_BRANCHES,
+					DELETE_BRANCH_SKIP_UNMERGED)) {
+			struct commit *rev = lookup_commit_reference(
+				the_repository, &candidates.items[i]->objectname);
+			struct commit *upstream = lookup_commit_reference_by_name(
+				upstream_refname);
+
+			if (!rev || !upstream ||
+			    !(landed = find_landed_commit(rev, upstream)))
+				continue;
+		}
 
 		strbuf_reset(&key);
 		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
@@ -882,6 +1048,8 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		}
 
 		strset_add(&deletable_branch_names, branch_name);
+		if (landed)
+			strmap_put(&landed_commits, branch_name, landed);
 	}
 
 	protect_stacked_branch_bases(refs, &deletable_branch_names,
@@ -895,7 +1063,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_SKIP_UNMERGED |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      flags);
+				      flags, &landed_commits);
 
 	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
 		clear_deleted_upstreams(&protected_branch_names,
@@ -903,6 +1071,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 
 	strbuf_release(&key);
 	strvec_clear(&branches_to_delete);
+	strmap_clear(&landed_commits, 0);
 	strset_clear(&protected_branch_names);
 	strset_clear(&deletable_branch_names);
 	ref_array_clear(&candidates);
@@ -1135,7 +1304,7 @@ int cmd_branch(int argc,
 			die(_("branch name required"));
 		ret = delete_branches(argc, argv, filter.kind,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
-				      (quiet ? DELETE_BRANCH_QUIET : 0));
+				      (quiet ? DELETE_BRANCH_QUIET : 0), NULL);
 		goto out;
 	} else if (delete_merged.nr) {
 		ret = delete_merged_branches(&delete_merged, argv,
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdb6c6a634..3b05718bab 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1979,6 +1979,80 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
 	)
 '
 
+push_topic () {
+	branch=$1 &&
+	shift &&
+	(
+		cd repo &&
+		git checkout -b "$branch" --track origin/next &&
+		for commit in "$@"
+		do
+			test_commit "$commit" || return 1
+		done &&
+		git push origin "$branch" &&
+		git checkout --detach
+	)
+}
+
+squash_merge_upstream () {
+	(
+		cd upstream &&
+		git checkout next &&
+		git merge --squash "$1" &&
+		git commit -m "Squash merge of $1" &&
+		git checkout main
+	)
+}
+
+test_expect_success '--delete-merged deletes a squash merged branch' '
+	setup_repo_for_delete_merged &&
+	push_topic squashed squashed-one squashed-two &&
+	push_topic partial partial-landed partial-pending &&
+	squash_merge_upstream partial~1 &&
+	squash_merge_upstream squashed &&
+	squash=$(git -C upstream rev-parse --short next) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short squashed) &&
+
+		git branch --delete-merged origin/next >actual 2>&1 &&
+		echo "Deleted branch squashed (was $sha, landed as $squash)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		partial
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged deletes a squash merged branch that was reverted' '
+	setup_repo_for_delete_merged &&
+	push_topic reverted reverted-work &&
+	squash_merge_upstream reverted &&
+	squash=$(git -C upstream rev-parse --short next) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		git revert --no-edit HEAD &&
+		git checkout main
+	) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short reverted) &&
+
+		git branch --delete-merged origin/next >actual 2>&1 &&
+		echo "Deleted branch reverted (was $sha, landed as $squash)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
 test_expect_success '--delete-merged keeps main despite a different default push remote' '
 	setup_repo_for_delete_merged &&
 	create_merged_branch on-next &&

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
