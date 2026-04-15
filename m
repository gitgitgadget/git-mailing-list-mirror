Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C060314B9A
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270272; cv=none; b=o6yiBjp4IIqX2J7g+Sk7Wy9NMoqEyVHNNDW257MFPNwRakcv+mXIZrNMcp3AHWtTS+q9L4Fnz+u99hYeY6nrZFJ24tDme+fhsdoZmxvBxHA7KYHotwg1xYuL42uwbmmHdaDs31k/WWw60jMZmSfw6LFT8EgKcvVf0phidRLbDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270272; c=relaxed/simple;
	bh=lcJn5ca0Oci8WM6NcotNa+LQYLj1MflA5IDEqBbEUUg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IUK5FFDCwILi2d/cb+3r//CPH9y19zrZBEby7vJ/aZTsyadXWnSBm4Q5HyJvFD2pr/aQWBzobMI3mZ+3trics8FOq3TF8zdIdIBgl6NkNoOuogT0w6BHvf6rEyGdoqHLNOMDPn8f6aivI1bITlYg3rfteNm/XuXmlQs8KnRCiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFcu2Fuo; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFcu2Fuo"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-467e8aaa865so3995593b6e.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776270269; x=1776875069; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFQ6zyUhtkrTIUcKXMtPvvM6bBx1zltsummrVNyjCb0=;
        b=ZFcu2FuoQeybEhQu/SX7Zp+OtqC9vfOhc+e9vVereheYe1K/0TIfQccrVenk99g2hG
         hIwkRP12UQqNQKVnwP8dLBWhmKb5aBWrhkhQMQmDkQUrhE46fwb4RFFtQNxyLpM/NSTs
         S3Sp/jq702AOnIt19fFULOM0loWj0cSg0QMrqfLZxf/yK4nLKpq7E59SDosGn1tmezsz
         mkJHJB21kn64Z+lFOz0cZcVbPsShmtX1lOVCFRN79yiBAgJjhNjCgj7GM8alkPv1G0qJ
         erNlHUnL6POY0VK3C4M1J9B2z+dNhU3wPxU9dVpa1NRVEgrjTlKQr1zjDOccIY+x2Mv+
         xsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776270269; x=1776875069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tFQ6zyUhtkrTIUcKXMtPvvM6bBx1zltsummrVNyjCb0=;
        b=oB4LRat+0Vc+q5DthVZQlmo7+dk3hZTiu3hPNbzx0CuK6Lk2VX8AUoqmmkHLq+vxc8
         HhhP+nGneRqTtN0VHr5H5kCV/HkUwxB8huyoBXnERpflBCJGlxU40ktOQcXBewqCw+sM
         3wPcZkhMq4rBLq2Ed0DfYn089wiLwo+FsdETB433Xu2JSpahKZ9jVYct15nSFutJBuOM
         GGuq+Un/vi6x+WZ7uHRFeB48DDPvtYhWI5jjxdiEbsn3YzVh0W1CKS85kIr42bimwKxp
         5pa6FZUS6FDEaVYk7sbeUab9BPgKfiEnqlhsEo9BE45FQ0SW8ner1UIMhncpEbLh15ka
         M3Nw==
X-Gm-Message-State: AOJu0YyM3dCPGB+30oozQMPh0FaMAgmAK3wWIeNEpGt9PFqNfnrhSFeG
	79rNco3R06fbJzvErTJZJnIUTE1xJXe0eV7DQIHvBWJhHEYkqsWLPK3gDuanjA==
X-Gm-Gg: AeBDiev3toWX207rwgYnsBRZ7CmN5gSSlcaMbqRfqpmpHwd2YkjL2KcNCj4QSxOV2JU
	MgQuaReb2fFFONbTRjAQOzbV3C4Cp7DII6Q6RzshuOCTrfvLbHrHsUyyWD0JhR0bckFzMoSUVrZ
	nMQDulkKzx1kx2Ut2gjTAOL/5914R7Xq7rljrOr0GcfV4PUk23/XU6gw1W95hfNitwt53E5b03d
	PnHKA7W+C90k2UFdKieh/ie4JErUjnHEDkWVfyvMRIFIoM4u4lHdK1Cx64h3gx/e6DmsoGukcHY
	+u8xb06ahOnQkLA8xf/o/GoA9O35mJEXJlmRpERBluzdT5d4eNCEFrUnlpflN9oaxu2y1Z/+wYE
	f5Yv75pEfUN3r+Fl/CjTSl6G0tpNTKNyl1fh1ROOgDOyS++abAsQnPvSqNKbju6eU9gjpEOeWqY
	LX4TyqfganRyqRtSOZR6Q96nyg
X-Received: by 2002:a05:6808:2383:b0:463:faa3:8dda with SMTP id 5614622812f47-4789f00c84dmr12231716b6e.13.1776270269006;
        Wed, 15 Apr 2026 09:24:29 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.21.53])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4797a515a27sm1149680b6e.14.2026.04.15.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:24:28 -0700 (PDT)
Message-Id: <86f33df1eb043d92cc626092d512aec670c89bdb.1776270259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
References: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
	<pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 16:24:19 +0000
Subject: [PATCH v14 5/5] checkout -m: autostash when switching branches
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When switching branches with "git checkout -m", the attempted merge
of local modifications may cause conflicts with the changes made on
the other branch, which the user may not want to (or may not be able
to) resolve right now.  Because there is no easy way to recover from
this situation, we discouraged users from using "checkout -m" unless
they are certain their changes are trivial and within their ability
to resolve conflicts.

Teach the -m flow to create a temporary stash before switching and
reapply it after.  On success, the stash is silently applied and
the list of locally modified paths is shown, same as a successful
"git checkout" without "-m".

If reapplying causes conflicts, the stash is kept and the user is
told they can resolve and run "git stash drop", or run "git reset
--hard" and later "git stash pop" to recover their changes.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-checkout.adoc |  58 ++++-----
 Documentation/git-switch.adoc   |  33 ++---
 builtin/checkout.c              | 144 +++++++++-------------
 sequencer.c                     |  18 ++-
 t/t3420-rebase-autostash.sh     |  24 +++-
 t/t7201-co.sh                   | 208 ++++++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 ++
 xdiff-interface.h               |   1 +
 9 files changed, 359 insertions(+), 141 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..70dd211ee3 100644
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
+switch.  If this process results in conflicts, a stash entry is saved
+and made available in `git stash list`:
 
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
index 87707e9265..ee58a4d0fd 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -123,18 +123,19 @@ variable.
 
 `-m`::
 `--merge`::
-	If you have local modifications to one or more files that are
-	different between the current branch and the branch to which
-	you are switching, the command refuses to switch branches in
-	order to preserve your modifications in context.  However,
-	with this option, a three-way merge between the current
-	branch, your working tree contents, and the new branch is
-	done, and you will be on the new branch.
-+
-When a merge conflict happens, the index entries for conflicting
-paths are left unmerged, and you need to resolve the conflicts
-and mark the resolved paths with `git add` (or `git rm` if the merge
-should result in deletion of the path).
+	If you have local modifications to one or more files that
+	are different between the current branch and the branch to
+	which you are switching, the command normally refuses to
+	switch branches in order to preserve your modifications in
+	context.  However, with this option, the conflicting local
+	changes are automatically stashed before the switch and
+	reapplied afterwards.  If the local changes do not overlap
+	with the differences between branches, the switch proceeds
+	without stashing.  If reapplying the stash results in
+	conflicts, the entry is saved to the stash list.  Resolve
+	the conflicts and run `git stash drop` when done, or clear
+	the working tree (e.g. with `git reset --hard`) before
+	running `git stash pop` later to re-apply your changes.
 
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
index c80c62b37b..55c4db04c6 100644
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
@@ -853,90 +853,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
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
-			if (!opts->merge) {
-				rollback_lock_file(&lock_file);
-				return 1;
-			}
-
-			/*
-			 * Without old_branch_info->commit, the below is the same as
-			 * the two-tree unpack we already tried and failed.
-			 */
-			if (!old_branch_info->commit) {
-				rollback_lock_file(&lock_file);
-				return 1;
-			}
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
-			work = write_in_core_index_as_tree(the_repository,
-							   the_repository->index);
-
-			ret = reset_tree(new_tree,
-					 opts, 1,
-					 writeout_error, new_branch_info);
-			if (ret) {
-				rollback_lock_file(&lock_file);
-				return ret;
-			}
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
-			if (ret) {
-				rollback_lock_file(&lock_file);
-				return ret;
-			}
+			rollback_lock_file(&lock_file);
+			return ret;
 		}
 	}
 
@@ -1181,6 +1099,10 @@ static int switch_branches(const struct checkout_opts *opts,
 	struct object_id rev;
 	int flag, writeout_error = 0;
 	int do_merge = 1;
+	int created_autostash = 0;
+	struct strbuf old_commit_shortname = STRBUF_INIT;
+	struct strbuf autostash_msg = STRBUF_INIT;
+	const char *stash_label_base = NULL;
 
 	trace2_cmd_mode("branch");
 
@@ -1218,11 +1140,39 @@ static int switch_branches(const struct checkout_opts *opts,
 			do_merge = 0;
 	}
 
+	if (old_branch_info.name)
+		stash_label_base = old_branch_info.name;
+	else if (old_branch_info.commit) {
+		strbuf_add_unique_abbrev(&old_commit_shortname,
+					 &old_branch_info.commit->object.oid,
+					 DEFAULT_ABBREV);
+		stash_label_base = old_commit_shortname.buf;
+	}
+
 	if (do_merge) {
 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
+		if (ret == -1 && opts->merge) {
+			strbuf_addf(&autostash_msg,
+				    "autostash while switching to '%s'",
+				    new_branch_info->name);
+			create_autostash_ref(the_repository,
+					     "CHECKOUT_AUTOSTASH_HEAD",
+					     autostash_msg.buf, true);
+			created_autostash = 1;
+			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
+		}
 		if (ret) {
+			if (created_autostash)
+				apply_autostash_ref(the_repository,
+						    "CHECKOUT_AUTOSTASH_HEAD",
+						    new_branch_info->name,
+						    "local",
+						    stash_label_base,
+						    autostash_msg.buf);
 			branch_info_release(&old_branch_info);
-			return ret;
+			strbuf_release(&old_commit_shortname);
+			strbuf_release(&autostash_msg);
+			return ret < 0 ? 1 : ret;
 		}
 	}
 
@@ -1231,8 +1181,30 @@ static int switch_branches(const struct checkout_opts *opts,
 
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
+	if (opts->conflict_style >= 0) {
+		struct strbuf cfg = STRBUF_INIT;
+		strbuf_addf(&cfg, "merge.conflictStyle=%s",
+			    conflict_style_name(opts->conflict_style));
+		git_config_push_parameter(cfg.buf);
+		strbuf_release(&cfg);
+	}
+	apply_autostash_ref(the_repository, "CHECKOUT_AUTOSTASH_HEAD",
+			    new_branch_info->name, "local",
+			    stash_label_base,
+			    autostash_msg.buf);
+
+	discard_index(the_repository->index);
+	if (repo_read_index(the_repository) < 0)
+		die(_("index file corrupt"));
+
+	if (created_autostash && !opts->quiet && new_branch_info->commit)
+		show_local_changes(&new_branch_info->commit->object,
+				   &opts->diff_options);
+
 	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
 	branch_info_release(&old_branch_info);
+	strbuf_release(&old_commit_shortname);
+	strbuf_release(&autostash_msg);
 
 	return ret || writeout_error;
 }
diff --git a/sequencer.c b/sequencer.c
index 7c0376d9e4..480e8e6c0b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4765,15 +4765,23 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
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
index 9bcf7c0b40..c474c6759f 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -210,6 +210,214 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
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
+	git stash list >stash-before &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep ! "Created autostash" actual &&
+	git stash list >stash-after &&
+	test_cmp stash-before stash-after &&
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
+test_expect_success 'checkout -m autostash message includes target branch' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 1 2 3 4 5 >one &&
+	git checkout -m side >actual 2>&1 &&
+	git stash list >stash-list &&
+	test_grep "autostash while switching to .side." stash-list &&
+	git stash drop &&
+	git checkout -f main &&
+	git reset --hard
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
+test_expect_success 'checkout -m applies stash cleanly with non-overlapping changes in same file' '
+	git checkout -f main &&
+	git reset --hard &&
+	git clean -f &&
+
+	git checkout -b nonoverlap_base &&
+	fill a b c d >file &&
+	git add file &&
+	git commit -m "add file" &&
+
+	git checkout -b nonoverlap_child &&
+	fill a b c INSERTED d >file &&
+	git commit -a -m "insert line near end of file" &&
+
+	fill DIRTY a b c INSERTED d >file &&
+
+	git stash list >stash-before &&
+	git checkout -m nonoverlap_base 2>stderr &&
+	test_grep "Applied autostash" stderr &&
+	test_grep ! "resulted in conflicts" stderr &&
+
+	git stash list >stash-after &&
+	test_cmp stash-before stash-after &&
+
+	fill DIRTY a b c d >expect &&
+	test_cmp expect file &&
+
+	git checkout -f main &&
+	git branch -D nonoverlap_base &&
+	git branch -D nonoverlap_child
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
