Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE629BDBB
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301491; cv=none; b=F8B6/yliASBQYBh9MD4PfhkfVC5UdnhBr6CBJgoliwjKDR7vaSDI4dfp30EJl508F8Twztv/t4RKoCSGuRc7Jf4xRF3HkJ+MCREXG6drOqcP8kdqDW9RjXN6rC46P4pEGM8SnpkWqwPVidC98JiiLCBBk3ETPAdzFw0hLup4dYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301491; c=relaxed/simple;
	bh=4IPYl5mgmZH95vJQKDrXUlcvn3Jvg8y8+6+vTv4dOJA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ox3FhfEKUH6GvklR/yNzNyROYZv2A9bu9UKxktznJT3Ldw+wAnpTJ958q7YpA84cfRULgrshQP29GfRvyFrt1E0LL93dE+4BarG6PjW3OPYI3SHAwI7S9yGGgJfNOCpXuPCoVVln2kbyJ7InXqfGdpMEDIsSrHA8wbgzj/OuOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhM0TvBz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhM0TvBz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381b831d535so585775a91.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788301489; x=1788906289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sPyORiMLEP1dZIpp/QQ7zBGBHU4xWmAcX8QjPvyxANQ=;
        b=NhM0TvBztV5VnnqG3fnQaIFR3ijyTzLc1Ftnn5wuiP7aQwXUz3QjzHtOJO74KVGtLo
         lKGmuLprSsThIn5ZX03lDnBrJM487CU6VJil1++xh7utSL6iKBJ0ZWh6vybRbPYXMMzl
         4dK1eaSoJ0j2p62CKrxBB0/+PLMiB924FQ8cJoGL7/9XU34yOe8iFk+wUZgCAGEVdebA
         IftyAa3gYdWghmJ/nnmudb4yIXnXWIF0PNUV8EfV94VzZPwvcMhvYSHFHT1fjC+G8bTG
         5vVFaXZj9JyYsBP3FJfcj4rNQjg4a/h6nxqU4E2BW5S8zqNV2nD8EzKW9oqPkIq7vBn9
         v8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788301489; x=1788906289;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sPyORiMLEP1dZIpp/QQ7zBGBHU4xWmAcX8QjPvyxANQ=;
        b=cNocRQQBTNK0z0m/1IOYFbH8FqU51PAj2tt9DEp6W31zH/WkWSNEaA9kGx77PKRHOH
         jBMFeWwGnGQTcoWhzGDJpaMvijkNe5JT0AOG5pifqfbzhyrjkRXgSyrrLXKpCzQBm+7c
         NmXgs+HydDmhf4Vuc0G0s9G/gsR0zBVtT7tupwQZSbEQ+4A778l8bCS0oqt77UxnCAvz
         t/86zVNtaQwKuMoQEDco6wrYGZrVZdxNvM6CtaX9EcGCdiwFY7CjrZCs8meFG+bBaA3X
         yxzplJfGLDzfOyAONNqfR0id4ydJyYK28n9Ecb4XzYJCYBBQfWtpF87BB4NiTteutlMA
         4IJQ==
X-Gm-Message-State: AFuF++loF0NDhA30gUkq86ZSICqK868HRY1AUzAtmuiFwGeuHMaNj1Md
	3ut0eyF7pU5KbiHUb9D1okDFcYcC44uRugdyAfLMru1F6oOgt1pAAvXq1qOJSQ==
X-Gm-Gg: AYBFou05jZked0+lkqhB/ZX3fYXYneOGAax2h6pdT6itqGOBBy0ScHECaVbkMs0N2Qr
	8FBT2ID8Yvp6N4QVJdk0zcQzQcSxs/sXW3nAVX5lffco9Pm6nuwVicY2kpgF7JEdoVcyNJdPAMl
	1e7zUF3FQNRd3kB5DGZL8lBOtLLki7hdv2pWI950m7WG1aYasTsF/FmtyIggiovfXc9N67QTgRf
	HRazop/3hbZN/LSyXKzDSy1BxBZMHOYpbg5rNmn5yY/QcuPRU+dTH0M2E05eX67kHS2p5vCwfm1
	O69eLox0Jv6ZbwqkRezed5Owg27x6zVW6PNgYZTheLv8SZ6sEYoXl2CQ3pWNZvs7Xq9jWlJeKxE
	mAtCgZ1ayxx/2WOgg5v0kdFikfFFgJNdR4KZtAhJnX6xHD617NvEHYlKCFucylToLMqGRDMMR9c
	8Q7J3IBVStDp9p53JpAE3k00YLMINqGKHLsu5Ecm2NBzmqz/rVcYKhoy/UQ9yv
X-Received: by 2002:a17:90b:4a84:b0:396:61f1:da5c with SMTP id 98e67ed59e1d1-39aedf8cc03mr248858a91.4.1788301489003;
        Tue, 01 Sep 2026 15:24:49 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b7a175sm951223eec.17.2026.09.01.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:24:48 -0700 (PDT)
Message-Id: <e77b34c1cf414839d922d0ce252d4700a313c7bb.1788301481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 22:24:40 +0000
Subject: [PATCH v4 4/5] commit: refuse to amend during conflict resolution
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Running `git commit --amend` during conflict resolution is an ugly
foot-gun.  For many years, we have rejected amending during conflict
resolution in the middle of
  - a merge
  - a cherry-pick
However, this was never extended to other operations that can also
produce conflicts:
  - an `am` operation
  - a revert
  - a rebase

Extend it to handle these other cases now.

Extending to `am`, revert, and the apply backend of rebase are fairly
straightforward.  However, with the merge backend of rebase we have to
be more careful, since it powers interactive rebases and
  - the interactive machinery internally uses `git commit --amend` for
    `squash` and `reword` directives
  - users are expected to `git commit --amend` after hitting an `edit`
    or `break` directive
So, we need to be careful with rebase to only reject amending when doing
conflict resolution.

A few files under the rebase-merge/ directory provide us the necessary
information:

  - stopped-sha is written only when the rebase stops and hands control
    back to the user, so its presence marks a genuine stop -- as opposed
    to the sequencer's own internal `git commit --amend` while applying
    a squash, fixup, or reword, during which no stopped-sha exists.

  - amend is written only when the rebase stops with HEAD already
    pointing at the commit the user is meant to amend: a clean `edit`,
    or a fast-forward `reword`.  Its absence at a stop therefore means
    the commit did not apply, so HEAD is the previously-applied commit
    rather than the one being rebased -- exactly the case we refuse.

So for the merge backend we die when stopped-sha exists and amend does
not.  This covers a plain conflicted pick as well as a conflicted `edit`
(both leave HEAD on the previously-applied commit), while still allowing
a clean `edit` or `reword` stop and a `break` stop (no stopped-sha).
stopped-sha is unlinked at the start of the resume loop, so a resumed
squash's internal amend is unaffected.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit.c                | 27 +++++++---
 sequencer.c                     | 57 +++++++++++++++++++++
 sequencer.h                     | 23 +++++++++
 t/t3404-rebase-interactive.sh   | 87 +++++++++++++++++++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 11 +++++
 t/t4151-am-abort.sh             | 11 +++++
 6 files changed, 210 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9b6eaa3c72..284fc7fdc6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1324,15 +1324,30 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_editor = 0;
 
 	/* Sanity check options */
-	if (amend && !current_head)
-		die(_("You have nothing to amend."));
-	if (amend && whence != FROM_COMMIT) {
-		if (whence == FROM_MERGE)
+	if (amend) {
+		if (!current_head)
+			die(_("You have nothing to amend."));
+		/*
+		 * Refuse to amend in the middle of any operation that is
+		 * meant to record its result as a new commit on top of HEAD
+		 * rather than by rewriting HEAD.
+		 */
+		switch (sequencer_ongoing_operation(s->repo, whence)) {
+		case ONGOING_NONE:
+			break;
+		case ONGOING_MERGE:
 			die(_("You are in the middle of a merge -- cannot amend."));
-		else if (is_from_cherry_pick(whence))
+		case ONGOING_CHERRY_PICK:
 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
-		else if (is_from_rebase_now_empty(whence))
+		case ONGOING_REBASE_NOW_EMPTY:
 			die(_("The now-empty commit has been dropped -- cannot amend."));
+		case ONGOING_REVERT:
+			die(_("You are in the middle of a revert -- cannot amend."));
+		case ONGOING_AM:
+			die(_("You are in the middle of an am session -- cannot amend."));
+		case ONGOING_REBASE_CONFLICT:
+			die(_("You are resolving conflicts during a rebase -- cannot amend."));
+		}
 	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
diff --git a/sequencer.c b/sequencer.c
index d336c309ca..6a28e0dd9a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -142,6 +142,13 @@ static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
  * command is processed, this file is deleted.
  */
 static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
+/*
+ * The apply ("am") backend keeps its state in the rebase-apply directory;
+ * the "applying" file within it marks a plain `git am` (as opposed to an
+ * apply-based rebase).
+ */
+static GIT_PATH_FUNC(apply_dir, "rebase-apply")
+static GIT_PATH_FUNC(apply_path_applying, "rebase-apply/applying")
 /*
  * When we stop at a given patch via the "edit" command, this file contains
  * the commit object name of the corresponding patch.
@@ -6966,6 +6973,56 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
 	return 0;
 }
 
+enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
+						   enum commit_whence whence)
+{
+	/*
+	 * The merge, cherry-pick, and (empty) rebase-pick stops are already
+	 * distinguished by 'whence'.
+	 */
+	switch (whence) {
+	case FROM_MERGE:
+		return ONGOING_MERGE;
+	case FROM_CHERRY_PICK_SINGLE:
+	case FROM_CHERRY_PICK_MULTI:
+		return ONGOING_CHERRY_PICK;
+	case FROM_REBASE_NOW_EMPTY:
+		return ONGOING_REBASE_NOW_EMPTY;
+	case FROM_COMMIT:
+		break;
+	}
+
+	/*
+	 * 'whence' is FROM_COMMIT, but we may still be in the middle of an
+	 * operation that records its result on top of HEAD; detect those
+	 * from their on-disk state.
+	 */
+
+	/* In the middle of a revert? */
+	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
+		return ONGOING_REVERT;
+
+	/* In the middle of an `am`? */
+	if (file_exists(apply_path_applying()))
+		return ONGOING_AM;
+
+	/*
+	 * In the middle of a rebase that stopped for conflict resolution?
+	 * The apply backend only ever stops for conflicts, so the presence
+	 * of its state directory is enough.  The merge backend writes
+	 * stopped-sha whenever it hands control back to the user, but omits
+	 * `amend` unless it stopped with HEAD already pointing at the commit
+	 * to be amended (a clean edit/reword stop); its absence therefore
+	 * marks a conflicted stop.
+	 */
+	if (file_exists(apply_dir()) ||
+	    (file_exists(rebase_path_stopped_sha()) &&
+	     !file_exists(rebase_path_amend())))
+		return ONGOING_REBASE_CONFLICT;
+
+	return ONGOING_NONE;
+}
+
 int sequencer_get_update_refs_state(const char *wt_dir,
 				    struct string_list *refs)
 {
diff --git a/sequencer.h b/sequencer.h
index 64a9c7fb1b..fb4a744208 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -277,6 +277,29 @@ int sequencer_get_last_command(struct repository* r,
 			       enum replay_action *action);
 int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
 
+/*
+ * An in-progress operation that records its result (often a conflict
+ * resolution) as a new commit on top of HEAD, during which amending
+ * HEAD via "git commit --amend" is almost always a mistake.
+ */
+enum ongoing_operation {
+	ONGOING_NONE = 0,
+	ONGOING_MERGE,
+	ONGOING_CHERRY_PICK,
+	ONGOING_REBASE_NOW_EMPTY,
+	ONGOING_REVERT,
+	ONGOING_AM,
+	ONGOING_REBASE_CONFLICT
+};
+
+/*
+ * Return which in-progress operation, if any, is underway; see enum
+ * ongoing_operation.  'whence' is the origin already computed for the
+ * pending commit.
+ */
+enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
+						   enum commit_whence whence);
+
 /**
  * Append the set of ref-OID pairs that are currently stored for the 'git
  * rebase --update-refs' feature if such a rebase is currently happening.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 81f4844950..4e6c3e2f19 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1883,6 +1883,93 @@ test_expect_success 'correct error message for commit --amend after empty pick'
 	test_grep "now-empty commit has been dropped -- cannot amend." err
 '
 
+test_expect_success 'commit --amend is refused at a rebase conflict stop' '
+	test_when_finished "git rebase --abort" &&
+	git checkout --detach conflict-branch &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 3" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i A
+	) &&
+	test_path_is_file .git/rebase-merge/patch &&
+	test_path_is_missing .git/rebase-merge/amend &&
+	echo resolved >conflict &&
+	git add conflict &&
+	test_must_fail git commit --amend --no-edit 2>err &&
+	test_grep "You are resolving conflicts during a rebase -- cannot amend" err
+'
+
+test_expect_success 'commit --amend is refused when an "edit" pick conflicts' '
+	test_when_finished "git rebase --abort" &&
+	git checkout --detach conflict-branch &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 edit 3" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i A
+	) &&
+	test_path_is_file .git/rebase-merge/patch &&
+	test_path_is_missing .git/rebase-merge/amend &&
+	echo resolved >conflict &&
+	git add conflict &&
+	test_must_fail git commit --amend --no-edit 2>err &&
+	test_grep "You are resolving conflicts during a rebase -- cannot amend" err
+'
+
+test_expect_success 'commit --amend is allowed at a rebase edit stop' '
+	test_when_finished "git rebase --abort" &&
+	git checkout --detach no-conflict-branch &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1 2 3 4" &&
+		export FAKE_LINES &&
+		git rebase -i A
+	) &&
+	test_path_is_file .git/rebase-merge/amend &&
+	echo tweak >fileJ &&
+	git add fileJ &&
+	git commit --amend --no-edit
+'
+
+test_expect_success 'commit --amend is allowed at a rebase break stop' '
+	test_when_finished "git rebase --abort" &&
+	git checkout --detach no-conflict-branch &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="break 1 2 3 4" &&
+		export FAKE_LINES &&
+		git rebase -i A
+	) &&
+	test_must_fail git rev-parse --verify REBASE_HEAD &&
+	echo tweak >fileJ &&
+	git add fileJ &&
+	git commit --amend --no-edit
+'
+
+test_expect_success 'commit --amend is refused at an apply-backend conflict stop' '
+	test_when_finished "rm -rf apply-backend" &&
+	test_create_repo apply-backend &&
+	(
+		cd apply-backend &&
+		test_commit base file &&
+		git branch -M mainline &&
+		test_commit upstream file upstream &&
+		git checkout -b side mainline~1 &&
+		test_commit conflicting file side &&
+		test_commit unrelated other &&
+		test_must_fail git rebase --apply mainline &&
+		# the apply backend only ever stops for conflicts, and
+		# leaves HEAD on the previously-applied commit
+		test_path_is_dir .git/rebase-apply &&
+		test_path_is_missing .git/rebase-apply/applying &&
+		echo resolved >file &&
+		git add file &&
+		test_must_fail git commit --amend --no-edit 2>err &&
+		test_grep "You are resolving conflicts during a rebase -- cannot amend" err
+	)
+'
+
 test_expect_success 'todo has correct onto hash' '
 	GIT_SEQUENCE_EDITOR=cat git rebase -i no-conflict-branch~4 no-conflict-branch >actual &&
 	onto=$(git rev-parse --short HEAD~4) &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 44596cb1e8..42de398f76 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -364,6 +364,17 @@ test_expect_success 'failed revert sets REVERT_HEAD' '
 	test_cmp_rev picked REVERT_HEAD
 '
 
+test_expect_success 'commit --amend of revert fails' '
+	pristine_detach initial &&
+
+	test_must_fail git revert picked &&
+	echo resolved >foo &&
+	git add foo &&
+	test_must_fail git commit --amend 2>err &&
+
+	test_grep "in the middle of a revert -- cannot amend." err
+'
+
 test_expect_success 'successful revert does not set REVERT_HEAD' '
 	pristine_detach base &&
 	git revert base &&
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 8e1ecf8a68..9313a074b2 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -63,6 +63,17 @@ do
 
 done
 
+test_expect_success 'commit --amend during a failed am fails' '
+	git reset --hard initial &&
+	cp file-2-expect file-2 &&
+	test_must_fail git am 000[1245]-*.patch &&
+	echo resolved >file-1 &&
+	git add file-1 &&
+	test_must_fail git commit --amend 2>err &&
+	test_grep "in the middle of an am session -- cannot amend." err &&
+	git am --abort
+'
+
 test_expect_success 'am -3 --skip removes otherfile-4' '
 	git reset --hard initial &&
 	test_must_fail git am -3 0003-*.patch &&
-- 
gitgitgadget

