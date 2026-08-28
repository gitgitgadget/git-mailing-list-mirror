Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2E3DDB1E
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903102; cv=none; b=ggUAsQ84olHWV5JPjs8VsxFgGJtf+rcQRjf1lWkCFzsEF2gi4f2z2VgxvnJh4pkLpgllu40mB365UkT3rrs3il8TXISZdn1ZwCmv68Ex6tuVbSfTmqc+iD0TivavHpJctY1Nb1taf0ShgFR/cjZtZ9bDudaSb/PML6MhEaCMshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903102; c=relaxed/simple;
	bh=ruvkBjTnSRBxF2Kl0+B8ha0RutkvM+hqeOkajRFDbDM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u0XJweojpMW2VBGutBrQqiPcyjfD4VqCKxc3YWjIkYUeliGsW+p6oLZ0UKTIQk9TSXLDdBH4VVzlW9fDBxU8mRAWpeA3Zh4vmbGEpdtPe4bUQAeoW9OY6vC+/ETwDQ3KjtRNekn/sSO/VU/cT3EZB1z3fnsOAlNK1mhERNeffFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7Hacc16; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7Hacc16"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb787dec99so450847a34.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 00:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787903100; x=1788507900; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hbkV2vI/YiyjLxtvTGYNnvL0F3hUbU9o/AqHB0LQpYA=;
        b=D7Hacc16b4YEqabVDFxq0Y5i6SjwnRjrGB7+LFJdhYlC8b/523KiOt+2g4sgQ7dGXO
         rN15SmrNyK8eA5lVpAvn2JxxKORiP5HWGCkhkU8+U+chWbkZrs7Ys8QZ8WmM9DUymVQ7
         JRd5A66ujH4X70P2mW/AaCCNbJueeGBTntpEmx1JZswqZC3zG4rlflgTU9AeSx6Xe2Ei
         IHt6TCrY6+9NVVpk/l0wruFFKqu83vIoNLHMsAL21DyQe2dQ5Bt5ZcxNQaEU3jPtFCXv
         PPccKAUySb2ZnFsdoXJwi/tTvcB3f+kZpGDSs2DGZyxfzAUF4/lH7f782jQkSZz2ZGIe
         owhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903100; x=1788507900;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hbkV2vI/YiyjLxtvTGYNnvL0F3hUbU9o/AqHB0LQpYA=;
        b=cFR3hhq53DxsfL64sVQuds+5zZFFZQBAGCdQ/WwVlLNbKAc/tUkNPAG5LWj0ze6rV8
         YPTq32JWagmhFadqmI65cBVrSrnLaVD/x6X98iSUMd2zaC8fAiqwy35XwgpBQitSntLz
         sjb2kyrwWMOnRcQZ8iNaT0in5r41AKW800bPLFqL/I8kVY46UaE26zk0EAhxj68TkvEL
         zs2Xj94iWFMuYNxyllERtayueL4bJVciW252May7RSBo9PUkTv3vhxr/M7nhoPZi3hQL
         nOTH0pZDmOhJ3w7tMu7DNY842FNoD39/68sQ200YyOfwHop4NJf3lU8nfs0o6wI/ijNF
         iAmw==
X-Gm-Message-State: AFuF++kPG99PKZdM96ugGEN5bdLEqO0kXH95zJEIBPAgzddE5vPgP0X3
	/wW8XBnYKUbYS4sVun4/BxAp2Rdkof8Y+cXc68n6s2S1h9f9MaT8q+4PQtB2H0TN
X-Gm-Gg: AR+sD10s98cvuovkE3zwk6VPJCkWZ67FyzLWnDwKy7lG21BB+ta7u/kQBktcOK5Ztks
	CYqyZDuJn4Z778kjUnLbN38Tws8oG/zz1C4bKwh0pxIQ30X5lNm9IobfZXSS8S3iubsIEokUsHS
	hWQYR0A9Yaba35YRwEX1VV/TFAwRvXusSHK2qQCWhG1Yv/izLdcAvsNrCGTUkuRqr7aCoHNp+uq
	r0h4RqMd15OOj9djx98DECAzgQHl0SPOYQFNwB4Mbu5uLo5T21PNOtvQZN0luqsfI+yWTpr04ZY
	oc1c5us7Lo4xRJFdTtwejU1xwhL78G7cre1V9tAcFAnDRMdXTVSbRenJpxOA6o73YOsDFBL+knN
	WvtR6AoYCY/IBPPK4qK1b0vnlRbXMp2SlepCelxOGxAJchYfBobzpmkbAtET9xuFVT57Omuuxow
	WvdVyLAmr50g7MCutNpLd5dorknindHbQA9h/LNOxGT97jceHkCAicpmM6uGb+2GfXvkINNMRX
X-Received: by 2002:a4a:e3c7:0:b0:6ae:4d93:cdc2 with SMTP id 006d021491bc7-6b1c63fdbeamr3567412eaf.5.1787903099702;
        Fri, 28 Aug 2026 00:44:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.202.78.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa7f028esm724484a34.12.2026.08.28.00.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:44:59 -0700 (PDT)
Message-Id: <050b9e8a52e531bcb17f483d0d574aaca3875adf.1787903085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 07:44:45 +0000
Subject: [PATCH v3 5/5] commit: refuse partial commits during conflict
 resolution
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

Similar to the previous commit, just as `git commit --amend` is a
foot-gun during conflict resolution, so is a partial commit (`git commit
<paths>`).  Recording a conflict resolution is about capturing the state
of the entire tree on top of HEAD, not a subset of paths.  For many years
we have rejected partial commits in the middle of
  - a merge
  - a cherry-pick

but, just like amending, this was never extended to the other operations
that can also leave conflicts to resolve:
  - an `am` operation
  - a revert
  - a rebase that stopped for conflict resolution

Reuse sequencer_ongoing_operation(), introduced for the analogous
`--amend` check, to detect these and refuse the partial commit.  A rebase
that stopped because a pick became empty is not conflict resolution and,
as an earlier patch established, is deliberately left permitted.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit.c                | 24 ++++++++++++++++++-----
 sequencer.h                     |  5 +++--
 t/t3404-rebase-interactive.sh   | 34 +++++++++++++++++++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 11 +++++++++++
 t/t4151-am-abort.sh             | 11 +++++++++++
 5 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 83ea8619d6..e96c663bd5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -515,11 +515,25 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 */
 	commit_style = COMMIT_PARTIAL;
 
-	if (whence != FROM_COMMIT) {
-		if (whence == FROM_MERGE)
-			die(_("cannot do a partial commit during a merge."));
-		else if (is_from_cherry_pick(whence))
-			die(_("cannot do a partial commit during a cherry-pick."));
+	switch (sequencer_ongoing_operation(the_repository, whence)) {
+	case ONGOING_NONE:
+		break;
+	case ONGOING_MERGE:
+		die(_("cannot do a partial commit during a merge."));
+	case ONGOING_CHERRY_PICK:
+		die(_("cannot do a partial commit during a cherry-pick."));
+	case ONGOING_REBASE_EMPTY:
+		/*
+		 * A pick that became empty is not a conflict, and creating
+		 * a new commit (partial or not) poses no problem.
+		 */
+		break;
+	case ONGOING_REVERT:
+		die(_("cannot do a partial commit during a revert."));
+	case ONGOING_AM:
+		die(_("cannot do a partial commit during an am session."));
+	case ONGOING_REBASE_CONFLICT:
+		die(_("cannot do a partial commit while resolving conflicts during a rebase."));
 	}
 
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
diff --git a/sequencer.h b/sequencer.h
index 3a4bd97db1..634d1ddcb3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -279,8 +279,9 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
 
 /*
  * An in-progress operation that records its result (often a conflict
- * resolution) as a new commit on top of HEAD, during which amending
- * HEAD via "git commit --amend" is almost always a mistake.
+ * resolution) as a new commit on top of HEAD.  Some ways of invoking
+ * "git commit" -- amending HEAD, or a partial commit -- are almost
+ * always a mistake during such an operation.
  */
 enum ongoing_operation {
 	ONGOING_NONE = 0,
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4e6c3e2f19..8c63682b7f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1970,6 +1970,40 @@ test_expect_success 'commit --amend is refused at an apply-backend conflict stop
 	)
 '
 
+test_expect_success 'partial commit is refused at a rebase conflict stop' '
+	test_when_finished "git rebase --abort" &&
+	git checkout --detach conflict-branch &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 3" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i A
+	) &&
+	echo resolved >conflict &&
+	git add conflict &&
+	test_must_fail git commit conflict 2>err &&
+	test_grep "cannot do a partial commit while resolving conflicts during a rebase." err
+'
+
+test_expect_success 'partial commit is refused at an apply-backend conflict stop' '
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
+		echo resolved >file &&
+		git add file &&
+		test_must_fail git commit file 2>err &&
+		test_grep "cannot do a partial commit while resolving conflicts during a rebase." err
+	)
+'
+
 test_expect_success 'todo has correct onto hash' '
 	GIT_SEQUENCE_EDITOR=cat git rebase -i no-conflict-branch~4 no-conflict-branch >actual &&
 	onto=$(git rev-parse --short HEAD~4) &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 42de398f76..c3d024c97f 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -375,6 +375,17 @@ test_expect_success 'commit --amend of revert fails' '
 	test_grep "in the middle of a revert -- cannot amend." err
 '
 
+test_expect_success 'partial commit during a revert fails' '
+	pristine_detach initial &&
+
+	test_must_fail git revert picked &&
+	echo resolved >foo &&
+	git add foo &&
+	test_must_fail git commit foo 2>err &&
+
+	test_grep "cannot do a partial commit during a revert." err
+'
+
 test_expect_success 'successful revert does not set REVERT_HEAD' '
 	pristine_detach base &&
 	git revert base &&
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 9313a074b2..c80269e015 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -74,6 +74,17 @@ test_expect_success 'commit --amend during a failed am fails' '
 	git am --abort
 '
 
+test_expect_success 'partial commit during a failed am fails' '
+	git reset --hard initial &&
+	cp file-2-expect file-2 &&
+	test_must_fail git am 000[1245]-*.patch &&
+	echo resolved >file-1 &&
+	git add file-1 &&
+	test_must_fail git commit file-1 2>err &&
+	test_grep "cannot do a partial commit during an am session." err &&
+	git am --abort
+'
+
 test_expect_success 'am -3 --skip removes otherfile-4' '
 	git reset --hard initial &&
 	test_must_fail git am -3 0003-*.patch &&
-- 
gitgitgadget
