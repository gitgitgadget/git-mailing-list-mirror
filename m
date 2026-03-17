Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E018787A
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740149; cv=none; b=jc3t9/njYy2oR1tmaXwoq17+5horXnktoZAvPDn4madF/ctAvSdiog2wePys/xVkbVmogdp0ffWDI/STbRWRFbL7YJrpP3XLE8kWT0VluD9dUvQBkWEeMrIZY0O3r38czGIFxbv52r4rJem/wg6lF+vYvXnjbcvhyA4qXqiOeaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740149; c=relaxed/simple;
	bh=53GZTW36BW97EGvOtl8+o28HNLgPHjOkTIZ3qi5Y7sc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nNxl87M3aq2t9opfXp8gvqdhx+VP+8Rj4/CpJKJKttFcmy5iuWJ8GhVT80vN4+pp3YDrvyoI+3sSqVvwfA4IS4/GiXDv5cfKtnOZmnDfheL3LggHgX72Q8m4p95YQXs1vsmUuEC9h1vuJ8PDfLe6NaCEv22YBqDe0MzhHE6kQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sq0WNalH; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq0WNalH"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c739d32b72cso3869821a12.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773740146; x=1774344946; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsgnBal+swVJkLU/NZenFA3G/sYIZnfHOUnc9N+I7nM=;
        b=Sq0WNalHW6z7geJ8RQCNMKdPnTqcf2Zf1tXUSvbAvT93Xb3+lYoNJZHjjxUIloD6Ia
         Z83O4UgDGxUrlCi/dr+ugukUVMD7Y+U4AWwlQj6E9ytrPAFMFfLshyGhHCbfP9gqDxRc
         acr8WUYQCgb2IQKT3Ubobvij/ssldHCOPmi8Qk7t3yqg8I+MatukGj5Azlm5lxK6+s4N
         geAn5IeR2eDL2SSNvFal/4xNyhpawLGhMouZEFsG+AnN584ZJ/Q9itvAIHJINXKBx/HJ
         MXar2P//yPRWIAppUACpDpD6iqxODlzc89KbuwhDVYfppjkNyXAig6g1fZ7rC+jjiPc+
         RM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740146; x=1774344946;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CsgnBal+swVJkLU/NZenFA3G/sYIZnfHOUnc9N+I7nM=;
        b=TzFxYm4gwKcZHDIP1qdqSM1kI5KBJACX+/l8RaBuhvRokyrpeKGXm9snwND5pqHD/G
         CavT4EIIaViGcF03MQPUoBzjo/lqLSJ2XHaxw3QSi6sRBo4nLVXBFyetyKGlhUWFQF1M
         TfuXAMR15eqz/j4kqwZNxG0WE28IROq0xRRWkxf88nLFtZAkMuxXbII6eEPfzfuYT+q5
         aNTeNYZ36PHjIcKC+4detp2O+XxkrQRL8gSgHtxnh2XK97XSun+FmaTyokXR11l3DRbP
         qttQsAT+kChHDq2dX4VzGRd6Fi0EKh2bE193ai7ke3JMX5qS8ggAO0SVCELarnB5LRbI
         /VwA==
X-Gm-Message-State: AOJu0YyTi+q2RT2GjAmscdHSElT+dmgo31GYal9pIyNwKYFPr8BtBpkN
	2shtpNsnqvSrb/t84Fz+AobJMO9tzCvEtwUgqjtCb2sIHZ3sGKufJHWGF9TNCw==
X-Gm-Gg: ATEYQzzKQIQ1jG67IBVLj3CgsJfMCznrzd/MdC5jQ0/FIDZwKP9HumE6ApbxuN+iMVq
	+LnIJCewnRalDHZ7wgFdrHizv3sb6QRAdaKqETfr227iWpGk9O6juV/f1WboWfDNieKDswEuG8b
	WZA2CfFFepccQleZNX/AkJJy3u/ixE1/Y1wZ/SJt27IVHjp9yH9Sl2kSu6ZWphOHD4UjxO84qH0
	RPkqTGyP78HED/9TXyVxKN9aqf8ixHOL/gv4SOn3drkj2lePz9o7sWfcpHzW9w1CERbQX+eaOkO
	3hLRdD5hqt5H7g8Nmh+3QWB8QiDPdQ/n5lBP7U2I1x6Z7zeWDIh1+4QLPZx6T0MW2y5OjuFfPoX
	nmMYB7PhRwtTYB+v2km9GvQRrT148EhvPYzUqLL4jHhw30R5+aNAqTi2tPdRPmN1altSGMGfu4k
	bwYRLZmIJPWWHa7hZPHa1poCk=
X-Received: by 2002:a17:902:ecd0:b0:2b0:63b6:dfd2 with SMTP id d9443c01a7336-2b063b6e1b8mr27987435ad.0.1773740146137;
        Tue, 17 Mar 2026 02:35:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.3.221.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece80a3a0sm131160695ad.65.2026.03.17.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 02:35:45 -0700 (PDT)
Message-Id: <7ecb0835b7680f21b1a69d33c8d33f87ce2e48b6.1773740139.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
References: <pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
	<pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 09:35:39 +0000
Subject: [PATCH v6 4/4] checkout: -m (--merge) uses autostash when switching
 branches
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

When switching branches with "git checkout -m", local modifications
can block the switch.  Teach the -m flow to create a temporary stash
before switching and reapply it after.  On success, only "Applied
autostash." is shown.  If reapplying causes conflicts, the stash is
kept and the user is told they can resolve and run "git stash drop",
or run "git reset --hard" and later "git stash pop" to recover their
changes.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-checkout.adoc |  58 ++++++------
 Documentation/git-switch.adoc   |  27 +++---
 builtin/checkout.c              | 137 ++++++++++++---------------
 builtin/stash.c                 |  30 ++++--
 sequencer.c                     |  18 +++-
 t/t3420-rebase-autostash.sh     |  24 +++--
 t/t7201-co.sh                   | 160 ++++++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 +++
 xdiff-interface.h               |   1 +
 10 files changed, 332 insertions(+), 137 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..18022e610e 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -251,20 +251,19 @@ working tree, by copying them from elsewhere, extracting a tarball, etc.
 	are different between the current branch and the branch to
 	which you are switching, the command refuses to switch
 	branches in order to preserve your modifications in context.
-	However, with this option, a three-way merge between the current
-	branch, your working tree contents, and the new branch
-	is done, and you will be on the new branch.
-+
-When a merge conflict happens, the index entries for conflicting
-paths are left unmerged, and you need to resolve the conflicts
-and mark the resolved paths with `git add` (or `git rm` if the merge
-should result in deletion of the path).
+	With this option, the conflicting local changes are
+	automatically stashed before the switch and reapplied
+	afterwards.  If the local changes do not overlap with the
+	differences between branches, the switch proceeds without
+	stashing.  If reapplying the stash results in conflicts, the
+	entry is saved to the stash list.  Resolve the conflicts
+	and run `git stash drop` when done, or clear the working
+	tree (e.g. with `git reset --hard`) before running `git stash
+	pop` later to re-apply your changes.
 +
 When checking out paths from the index, this option lets you recreate
 the conflicted merge in the specified paths.  This option cannot be
 used when checking out paths from a tree-ish.
-+
-When switching branches with `--merge`, staged changes may be lost.
 
 `--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
@@ -578,39 +577,44 @@ $ git checkout mytopic
 error: You have local changes to 'frotz'; not switching branches.
 ------------
 
-You can give the `-m` flag to the command, which would try a
-three-way merge:
+You can give the `-m` flag to the command, which would carry your local
+changes to the new branch:
 
 ------------
 $ git checkout -m mytopic
-Auto-merging frotz
+Switched to branch 'mytopic'
 ------------
 
-After this three-way merge, the local modifications are _not_
+After the switch, the local modifications are reapplied and are _not_
 registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
 === 3. Merge conflict
 
-When a merge conflict happens during switching branches with
-the `-m` option, you would see something like this:
+When the `--merge` (`-m`) option is in effect and the locally
+modified files overlap with files that need to be updated by the
+branch switch, the changes are stashed and reapplied after the
+switch.  If the stash application results in conflicts, they are not
+resolved and the stash is saved to the stash list:
 
 ------------
 $ git checkout -m mytopic
-Auto-merging frotz
-ERROR: Merge conflict in frotz
-fatal: merge program failed
-------------
+Your local changes are stashed, however, applying it to carry
+forward your local changes resulted in conflicts:
 
-At this point, `git diff` shows the changes cleanly merged as in
-the previous example, as well as the changes in the conflicted
-files.  Edit and resolve the conflict and mark it resolved with
-`git add` as usual:
+ - You can try resolving them now.  If you resolved them
+   successfully, discard the stash entry with "git stash drop".
 
+ - Alternatively you can "git reset --hard" if you do not want
+   to deal with them right now, and later "git stash pop" to
+   recover your local changes.
 ------------
-$ edit frotz
-$ git add frotz
-------------
+
+You can try resolving the conflicts now.  Edit the conflicting files
+and mark them resolved with `git add` as usual, then run `git stash
+drop` to discard the stash entry.  Alternatively, you can clear the
+working tree with `git reset --hard` and recover your local changes
+later with `git stash pop`.
 
 CONFIGURATION
 -------------
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 87707e9265..3147023dc3 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -126,15 +126,16 @@ variable.
 	If you have local modifications to one or more files that are
 	different between the current branch and the branch to which
 	you are switching, the command refuses to switch branches in
-	order to preserve your modifications in context.  However,
-	with this option, a three-way merge between the current
-	branch, your working tree contents, and the new branch is
-	done, and you will be on the new branch.
-+
-When a merge conflict happens, the index entries for conflicting
-paths are left unmerged, and you need to resolve the conflicts
-and mark the resolved paths with `git add` (or `git rm` if the merge
-should result in deletion of the path).
+	order to preserve your modifications in context.  With this
+	option, the conflicting local changes are automatically
+	stashed before the switch and reapplied afterwards.  If the
+	local changes do not overlap with the differences between
+	branches, the switch proceeds without stashing.  If
+	reapplying the stash results in conflicts, the entry is
+	saved to the stash list.  Resolve the conflicts and run
+	`git stash drop` when done, or clear the working tree
+	(e.g. with `git reset --hard`) before running `git stash pop`
+	later to re-apply your changes.
 
 `--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
@@ -217,15 +218,15 @@ $ git switch mytopic
 error: You have local changes to 'frotz'; not switching branches.
 ------------
 
-You can give the `-m` flag to the command, which would try a three-way
-merge:
+You can give the `-m` flag to the command, which would carry your local
+changes to the new branch:
 
 ------------
 $ git switch -m mytopic
-Auto-merging frotz
+Switched to branch 'mytopic'
 ------------
 
-After this three-way merge, the local modifications are _not_
+After the switch, the local modifications are reapplied and are _not_
 registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1d1667fa4c..dc935d6bcb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -17,7 +17,6 @@
 #include "merge-ll.h"
 #include "lockfile.h"
 #include "mem-pool.h"
-#include "merge-ort-wrappers.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
@@ -30,6 +29,7 @@
 #include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
+#include "sequencer.h"
 #include "setup.h"
 #include "submodule.h"
 #include "symlinks.h"
@@ -783,8 +783,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	struct tree *new_tree;
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
-	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
+	if (repo_read_index_preload(the_repository, NULL, 0) < 0) {
+		rollback_lock_file(&lock_file);
 		return error(_("index file corrupt"));
+	}
 
 	resolve_undo_clear_index(the_repository->index);
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
@@ -797,14 +799,18 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	} else {
 		new_tree = repo_get_commit_tree(the_repository,
 						new_branch_info->commit);
-		if (!new_tree)
+		if (!new_tree) {
+			rollback_lock_file(&lock_file);
 			return error(_("unable to read tree (%s)"),
 				     oid_to_hex(&new_branch_info->commit->object.oid));
+		}
 	}
 	if (opts->discard_changes) {
 		ret = reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
-		if (ret)
+		if (ret) {
+			rollback_lock_file(&lock_file);
 			return ret;
+		}
 	} else {
 		struct tree_desc trees[2];
 		struct tree *tree;
@@ -814,6 +820,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
 
 		if (unmerged_index(the_repository->index)) {
+			rollback_lock_file(&lock_file);
 			error(_("you need to resolve your current index first"));
 			return 1;
 		}
@@ -846,81 +853,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		ret = unpack_trees(2, trees, &topts);
 		clear_unpack_trees_porcelain(&topts);
 		if (ret == -1) {
-			/*
-			 * Unpack couldn't do a trivial merge; either
-			 * give up or do a real merge, depending on
-			 * whether the merge flag was used.
-			 */
-			struct tree *work;
-			struct tree *old_tree;
-			struct merge_options o;
-			struct strbuf sb = STRBUF_INIT;
-			struct strbuf old_commit_shortname = STRBUF_INIT;
-
-			if (!opts->merge)
-				return 1;
-
-			/*
-			 * Without old_branch_info->commit, the below is the same as
-			 * the two-tree unpack we already tried and failed.
-			 */
-			if (!old_branch_info->commit)
-				return 1;
-			old_tree = repo_get_commit_tree(the_repository,
-							old_branch_info->commit);
-
-			if (repo_index_has_changes(the_repository, old_tree, &sb))
-				die(_("cannot continue with staged changes in "
-				      "the following files:\n%s"), sb.buf);
-			strbuf_release(&sb);
-
-			/* Do more real merge */
-
-			/*
-			 * We update the index fully, then write the
-			 * tree from the index, then merge the new
-			 * branch with the current tree, with the old
-			 * branch as the base. Then we reset the index
-			 * (but not the working tree) to the new
-			 * branch, leaving the working tree as the
-			 * merged version, but skipping unmerged
-			 * entries in the index.
-			 */
-
-			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
-					0, 0);
-			init_ui_merge_options(&o, the_repository);
-			o.verbosity = 0;
-			work = write_in_core_index_as_tree(the_repository);
-
-			ret = reset_tree(new_tree,
-					 opts, 1,
-					 writeout_error, new_branch_info);
-			if (ret)
-				return ret;
-			o.ancestor = old_branch_info->name;
-			if (!old_branch_info->name) {
-				strbuf_add_unique_abbrev(&old_commit_shortname,
-							 &old_branch_info->commit->object.oid,
-							 DEFAULT_ABBREV);
-				o.ancestor = old_commit_shortname.buf;
-			}
-			o.branch1 = new_branch_info->name;
-			o.branch2 = "local";
-			o.conflict_style = opts->conflict_style;
-			ret = merge_ort_nonrecursive(&o,
-						     new_tree,
-						     work,
-						     old_tree);
-			if (ret < 0)
-				die(NULL);
-			ret = reset_tree(new_tree,
-					 opts, 0,
-					 writeout_error, new_branch_info);
-			strbuf_release(&o.obuf);
-			strbuf_release(&old_commit_shortname);
-			if (ret)
-				return ret;
+			rollback_lock_file(&lock_file);
+			return 1;
 		}
 	}
 
@@ -1165,6 +1099,9 @@ static int switch_branches(const struct checkout_opts *opts,
 	struct object_id rev;
 	int flag, writeout_error = 0;
 	int do_merge = 1;
+	int created_autostash = 0;
+	struct strbuf old_commit_shortname = STRBUF_INIT;
+	const char *stash_label_ancestor = NULL;
 
 	trace2_cmd_mode("branch");
 
@@ -1202,10 +1139,31 @@ static int switch_branches(const struct checkout_opts *opts,
 			do_merge = 0;
 	}
 
+	if (old_branch_info.name)
+		stash_label_ancestor = old_branch_info.name;
+	else if (old_branch_info.commit) {
+		strbuf_add_unique_abbrev(&old_commit_shortname,
+					 &old_branch_info.commit->object.oid,
+					 DEFAULT_ABBREV);
+		stash_label_ancestor = old_commit_shortname.buf;
+	}
+
 	if (do_merge) {
 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
+		if (ret && opts->merge) {
+			create_autostash_ref_silent(the_repository,
+						   "CHECKOUT_AUTOSTASH");
+			created_autostash = 1;
+			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
+		}
 		if (ret) {
+			apply_autostash_ref_with_labels(the_repository,
+						       "CHECKOUT_AUTOSTASH",
+						       new_branch_info->name,
+						       "local",
+						       stash_label_ancestor);
 			branch_info_release(&old_branch_info);
+			strbuf_release(&old_commit_shortname);
 			return ret;
 		}
 	}
@@ -1215,8 +1173,29 @@ static int switch_branches(const struct checkout_opts *opts,
 
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
+	if (opts->conflict_style >= 0) {
+		struct strbuf cfg = STRBUF_INIT;
+		strbuf_addf(&cfg, "merge.conflictStyle=%s",
+			    conflict_style_name(opts->conflict_style));
+		git_config_push_parameter(cfg.buf);
+		strbuf_release(&cfg);
+	}
+	apply_autostash_ref_with_labels(the_repository, "CHECKOUT_AUTOSTASH",
+				       new_branch_info->name, "local",
+				       stash_label_ancestor);
+
+	discard_index(the_repository->index);
+	if (repo_read_index(the_repository) < 0)
+		die(_("index file corrupt"));
+
+	if (created_autostash && !opts->discard_changes && !opts->quiet &&
+	    new_branch_info->commit)
+		show_local_changes(&new_branch_info->commit->object,
+				   &opts->diff_options);
+
 	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
 	branch_info_release(&old_branch_info);
+	strbuf_release(&old_commit_shortname);
 
 	return ret || writeout_error;
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index 252e4df3a9..ab9c1359b1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -590,8 +590,11 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 		die(_("could not write index"));
 }
 
-static int do_apply_stash(const char *prefix, struct stash_info *info,
-			  int index, int quiet)
+static int do_apply_stash_with_labels(const char *prefix,
+				      struct stash_info *info,
+				      int index, int quiet,
+				      const char *label1, const char *label2,
+				      const char *label_ancestor)
 {
 	int clean, ret;
 	int has_index = index;
@@ -643,9 +646,9 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
 	init_ui_merge_options(&o, the_repository);
 
-	o.branch1 = "Updated upstream";
-	o.branch2 = "Stashed changes";
-	o.ancestor = "Stash base";
+	o.branch1 = label1 ? label1 : "Updated upstream";
+	o.branch2 = label2 ? label2 : "Stashed changes";
+	o.ancestor = label_ancestor ? label_ancestor : "Stash base";
 
 	if (oideq(&info->b_tree, &c_tree))
 		o.branch1 = "Version stash was based on";
@@ -717,17 +720,31 @@ restore_untracked:
 	return ret;
 }
 
+static int do_apply_stash(const char *prefix, struct stash_info *info,
+			  int index, int quiet)
+{
+	return do_apply_stash_with_labels(prefix, info, index, quiet,
+					  NULL, NULL, NULL);
+}
+
 static int apply_stash(int argc, const char **argv, const char *prefix,
 		       struct repository *repo UNUSED)
 {
 	int ret = -1;
 	int quiet = 0;
 	int index = use_index;
+	const char *label1 = NULL, *label2 = NULL, *label_ancestor = NULL;
 	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "index", &index,
 			 N_("attempt to recreate the index")),
+		OPT_STRING(0, "ours-label", &label1, N_("label"),
+			   N_("label for the upstream side in conflict markers")),
+		OPT_STRING(0, "theirs-label", &label2, N_("label"),
+			   N_("label for the stashed side in conflict markers")),
+		OPT_STRING(0, "base-label", &label_ancestor, N_("label"),
+			   N_("label for the base in diff3 conflict markers")),
 		OPT_END()
 	};
 
@@ -737,7 +754,8 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
 	if (get_stash_info(&info, argc, argv))
 		goto cleanup;
 
-	ret = do_apply_stash(prefix, &info, index, quiet);
+	ret = do_apply_stash_with_labels(prefix, &info, index, quiet,
+					 label1, label2, label_ancestor);
 cleanup:
 	free_stash_info(&info);
 	return ret;
diff --git a/sequencer.c b/sequencer.c
index 080a25820a..53e04d8a94 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4741,15 +4741,23 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 		strvec_push(&store.args, stash_oid);
 		if (run_command(&store))
 			ret = error(_("cannot store %s"), stash_oid);
+		else if (attempt_apply)
+			fprintf(stderr,
+				_("Your local changes are stashed, however, applying it to carry\n"
+				  "forward your local changes resulted in conflicts:\n"
+				  "\n"
+				  " - You can try resolving them now.  If you resolved them\n"
+				  "   successfully, discard the stash entry with \"git stash drop\".\n"
+				  "\n"
+				  " - Alternatively you can \"git reset --hard\" if you do not want\n"
+				  "   to deal with them right now, and later \"git stash pop\" to\n"
+				  "   recover your local changes.\n"));
 		else
 			fprintf(stderr,
-				_("%s\n"
+				_("Autostash exists; creating a new stash entry.\n"
 				  "Your changes are safe in the stash.\n"
 				  "You can run \"git stash pop\" or"
-				  " \"git stash drop\" at any time.\n"),
-				attempt_apply ?
-				_("Applying autostash resulted in conflicts.") :
-				_("Autostash exists; creating a new stash entry."));
+				  " \"git stash drop\" at any time.\n"));
 	}
 
 	return ret;
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index ad3ba6a984..e4e2cb19ce 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -61,18 +61,30 @@ create_expected_failure_apply () {
 	First, rewinding head to replay your work on top of it...
 	Applying: second commit
 	Applying: third commit
-	Applying autostash resulted in conflicts.
-	Your changes are safe in the stash.
-	You can run "git stash pop" or "git stash drop" at any time.
+	Your local changes are stashed, however, applying it to carry
+	forward your local changes resulted in conflicts:
+
+	 - You can try resolving them now.  If you resolved them
+	   successfully, discard the stash entry with "git stash drop".
+
+	 - Alternatively you can "git reset --hard" if you do not want
+	   to deal with them right now, and later "git stash pop" to
+	   recover your local changes.
 	EOF
 }
 
 create_expected_failure_merge () {
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
-	Applying autostash resulted in conflicts.
-	Your changes are safe in the stash.
-	You can run "git stash pop" or "git stash drop" at any time.
+	Your local changes are stashed, however, applying it to carry
+	forward your local changes resulted in conflicts:
+
+	 - You can try resolving them now.  If you resolved them
+	   successfully, discard the stash entry with "git stash drop".
+
+	 - Alternatively you can "git reset --hard" if you do not want
+	   to deal with them right now, and later "git stash pop" to
+	   recover your local changes.
 	Successfully rebased and updated refs/heads/rebased-feature-branch.
 	EOF
 }
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9bcf7c0b40..f4fea7bb7a 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -210,6 +210,166 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 	test_cmp expect two
 '
 
+test_expect_success 'checkout --merge --conflict=zdiff3 <branch>' '
+	git checkout -f main &&
+	git reset --hard &&
+	git clean -f &&
+
+	fill a b X d e >two &&
+	git checkout --merge --conflict=zdiff3 simple &&
+
+	cat <<-EOF >expect &&
+	a
+	<<<<<<< simple
+	c
+	||||||| main
+	b
+	c
+	d
+	=======
+	b
+	X
+	d
+	>>>>>>> local
+	e
+	EOF
+	test_cmp expect two
+'
+
+test_expect_success 'checkout -m respects merge.conflictStyle config' '
+	git checkout -f main &&
+	git reset --hard &&
+	git clean -f &&
+
+	test_config merge.conflictStyle diff3 &&
+	fill b d >two &&
+	git checkout -m simple &&
+
+	cat <<-EOF >expect &&
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
+	test_cmp expect two
+'
+
+test_expect_success 'checkout -m skips stash when no conflict' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 0 x y z >same &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	fill 0 x y z >expect &&
+	test_cmp expect same
+'
+
+test_expect_success 'checkout -m skips stash with non-conflicting dirty index' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 0 x y z >same &&
+	git add same &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	fill 0 x y z >expect &&
+	test_cmp expect same
+'
+
+test_expect_success 'checkout -m stashes and applies on conflicting changes' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 1 2 3 4 5 6 7 >one &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	fill 1 2 3 4 5 6 7 >expect &&
+	test_cmp expect one
+'
+
+test_expect_success 'checkout -m with mixed staged and unstaged changes' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 0 x y z >same &&
+	git add same &&
+	fill 1 2 3 4 5 6 7 >one &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	test_grep "Applied autostash" actual &&
+	fill 0 x y z >expect &&
+	test_cmp expect same &&
+	fill 1 2 3 4 5 6 7 >expect &&
+	test_cmp expect one
+'
+
+test_expect_success 'checkout -m stashes on truly conflicting changes' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 1 2 3 4 5 >one &&
+	test_must_fail git checkout side 2>stderr &&
+	test_grep "Your local changes" stderr &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	test_grep "resulted in conflicts" actual &&
+	test_grep "git stash drop" actual &&
+	git stash drop &&
+	git reset --hard
+'
+
+test_expect_success 'checkout -m produces usable stash on conflict' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 1 2 3 4 5 >one &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep "recover your local changes" actual &&
+	git checkout -f main &&
+	git stash pop &&
+	fill 1 2 3 4 5 >expect &&
+	test_cmp expect one
+'
+
+test_expect_success 'checkout -m stashes on staged conflicting changes' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 1 2 3 4 5 >one &&
+	git add one &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	test_grep "resulted in conflicts" actual &&
+	test_grep "git stash drop" actual &&
+	git stash drop &&
+	git reset --hard
+'
+
+test_expect_success 'checkout -m -b skips stash with dirty tree' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 0 x y z >same &&
+	git checkout -m -b newbranch >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	fill 0 x y z >expect &&
+	test_cmp expect same &&
+	git checkout main &&
+	git branch -D newbranch
+'
+
 test_expect_success 'switch to another branch while carrying a deletion' '
 	git checkout -f main &&
 	git reset --hard &&
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9838094b66..cbef8a534e 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -914,7 +914,7 @@ test_expect_success 'merge with conflicted --autostash changes' '
 	git diff >expect &&
 	test_when_finished "test_might_fail git stash drop" &&
 	git merge --autostash c3 2>err &&
-	test_grep "Applying autostash resulted in conflicts." err &&
+	test_grep "your local changes resulted in conflicts" err &&
 	git show HEAD:file >merge-result &&
 	test_cmp result.1-9 merge-result &&
 	git stash show -p >actual &&
diff --git a/xdiff-interface.c b/xdiff-interface.c
index f043330f2a..5ee2b96d0a 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -325,6 +325,18 @@ int parse_conflict_style_name(const char *value)
 		return -1;
 }
 
+const char *conflict_style_name(int style)
+{
+	switch (style) {
+	case XDL_MERGE_DIFF3:
+		return "diff3";
+	case XDL_MERGE_ZEALOUS_DIFF3:
+		return "zdiff3";
+	default:
+		return "merge";
+	}
+}
+
 int git_xmerge_style = -1;
 
 int git_xmerge_config(const char *var, const char *value,
diff --git a/xdiff-interface.h b/xdiff-interface.h
index fbc4ceec40..ce54e1c0e0 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -55,6 +55,7 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
 void xdiff_clear_find_func(xdemitconf_t *xecfg);
 struct config_context;
 int parse_conflict_style_name(const char *value);
+const char *conflict_style_name(int style);
 int git_xmerge_config(const char *var, const char *value,
 		      const struct config_context *ctx, void *cb);
 extern int git_xmerge_style;
-- 
gitgitgadget
