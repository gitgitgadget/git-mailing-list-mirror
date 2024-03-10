Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A01427B
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710100267; cv=none; b=J5FSxFOpvR6ywQtbwF67KyW3EnSisZZ4V7B1/fFJgeDfDEze6aMVwvnIqWw2rPA5u9yUgwZVqFMFgNZI1GYPqYHuPBJDNo0cBQjHh2CcTvtfqRmonmh8AuodbGYM1+rXqg5Zh2pB4JQia3oz8zIlAkBrVAtGPBPS5NC8SrfsLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710100267; c=relaxed/simple;
	bh=WNPdgGBqD0rVBH//xc1G5EVmBdn570F/8I5ZbdLb6HM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G59OGUQEeG8/aT4pKr6POEN7Qa8WY0fXU1aE8Zum6sT7P40u3ybdK45UXzyA7e/51Iiqb5ajtuIVAdnyQMyeqP0sZ38B+fJhMrTR5b25IputIdEZ8CGaj7mxkkiBfD45t2ACZXp0/v3TVliXRbkKhezMjNyp7UuHzFIoRED5KpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gz2qpW1p; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz2qpW1p"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e98610a6dso354f8f.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710100263; x=1710705063; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be+RUHPK4vw64fNhMqkfmafjmbfKnAnU+47o6L6uMW8=;
        b=Gz2qpW1p10sHH70PdptdX6IA/hl1bNErJHBEONdQSN/rdAPUKGrbJtH56IYQJ7lVwR
         PjBosLcifA6g/9AzDpq4ryibessSB4W3yTjQJckxrUrx3GCeylFjAV/U/emV3kHujUS3
         6/wMgvl3GF49BPTg8f85uOWLIcM/3hojxO5tlXsfM4g/oULk118048+KEbZI2j4OLsHm
         8QlBLq81iv03elPNn7apxCo1iAhgMwCxAEQh8nXAxmJj+B5SQNsXrHHcc/7Z+hwXNpLU
         7JbbGJj7Q0DV79QzG1L2bAojgCGDDhxuLvY86O4f5iXTQQ/6mrhEYZcM6PgmBDi0Nu1o
         OCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710100263; x=1710705063;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Be+RUHPK4vw64fNhMqkfmafjmbfKnAnU+47o6L6uMW8=;
        b=Xm0kpGVqy3+4ltaJKe9ArmoalTOUzUBHdzxgExLIZZnIo6iVlK7WjgedMwx9LpVrTN
         p0fY9NcBAe/TIjHdfJMqIiZKPPw4BxzAqjXEANgazQ56DAo2xJ0ZjYRyNhHnXTJjIe3h
         LSphu6Bs9dmzdgNyMyI8OdfT1P4iC/gatDr59EagAN8gZkjkBf4uDSR2NxWQI1OPo8J3
         DlTUpr7FMSG7BeCX3IAcHcNYOVFfkyajI00ps5HQxTUbuP0X9uqYCIjrH3RwawKwGuA2
         nFUY7wACYCsVXZs+whcZ/h6c563fzvfNlEtKa9/dXZNRJ4RLtpwG7aWkKkIHOH3gxmHR
         8JXg==
X-Gm-Message-State: AOJu0YxlAk1Tkn1aLxDN4kQqyu6V018RB/MpBY0W58D8s64MpAR8+AXI
	J5YjCvEaCos6MJrGPtaeQu/SCr74iyEyh6MrblRU8siks7vi3566EOH8Kp6C
X-Google-Smtp-Source: AGHT+IHQKhAvpiu3Luy/7+7RK7zoad3GzRGH9nfJbk2Jdq+z9/H5nOyfuWfRLn/Qm2xds4OxkNDq/Q==
X-Received: by 2002:a5d:4a05:0:b0:33e:774f:e3ca with SMTP id m5-20020a5d4a05000000b0033e774fe3camr3045378wrq.64.1710100262637;
        Sun, 10 Mar 2024 12:51:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay5-20020a05600c1e0500b0041327ac5dbesm2462732wmb.48.2024.03.10.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:51:02 -0700 (PDT)
Message-ID: <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
In-Reply-To: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Mar 2024 19:50:59 +0000
Subject: [PATCH v2 0/2] Allow disabling advice shown after merge conflicts
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    ZheNing Hu <adlternative@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

This series introduces a new config 'advice.mergeConflict' and uses it to
allow disabling the advice shown when 'git rebase', 'git cherry-pick', 'git
revert', 'git rebase --apply' and 'git am' stop because of conflicts.

Changes since v1:

 * renamed the new advice to 'advice.mergeConflict' to make it non-sequencer
   specific
 * added 2/2 which uses the advice in builtin/am, which covers 'git rebase
   --apply' and 'git am'

Note that the code path where 'git rebase --apply' stops because of
conflicts is not covered by the tests but I tested it manually using this
diff:

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 47534f1062..34eac2e6f4 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -374,7 +374,7 @@ test_pull_autostash_fail ()
     echo conflicting >>seq.txt &&
     test_tick &&
     git commit -m "Create conflict" seq.txt &&
-	test_must_fail git pull --rebase . seq 2>err >out &&
+	test_must_fail git -c rebase.backend=apply pull --rebase . seq 2>err >out &&
     test_grep "Resolve all conflicts manually" err
 '


Philippe Blain (2):
  sequencer: allow disabling conflict advice
  builtin/am: allow disabling conflict advice

 Documentation/config/advice.txt |  2 ++
 advice.c                        |  1 +
 advice.h                        |  1 +
 builtin/am.c                    | 14 +++++++++-----
 sequencer.c                     | 33 ++++++++++++++++++---------------
 t/t3501-revert-cherry-pick.sh   |  1 +
 t/t3507-cherry-pick-conflict.sh |  2 ++
 t/t4150-am.sh                   |  8 ++++----
 t/t4254-am-corrupt.sh           |  2 +-
 9 files changed, 39 insertions(+), 25 deletions(-)


base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1682%2Fphil-blain%2Fsequencer-conflict-advice-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1682/phil-blain/sequencer-conflict-advice-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1682

Range-diff vs v1:

 1:  e929d3381cf ! 1:  a2ce6fd24c2 sequencer: allow disabling conflict advice
     @@ Commit message
          sequencer: allow disabling conflict advice
      
          Allow disabling the advice shown when a squencer operation results in a
     -    merge conflict through a new config 'advice.sequencerConflict'.
     +    merge conflict through a new config 'advice.mergeConflict', which is
     +    named generically such that it can be used by other commands eventually.
     +
     +    Note that we use 'advise_if_enabled' for each message in the second hunk
     +    in sequencer.c, instead of using 'if (show_hints &&
     +    advice_enabled(...)', because the former instructs the user how to
     +    disable the advice, which is more user-friendly.
      
          Update the tests accordingly. Note that the body of the second test in
          t3507-cherry-pick-conflict.sh is enclosed in double quotes, so we must
     @@ Commit message
      
       ## Documentation/config/advice.txt ##
      @@ Documentation/config/advice.txt: advice.*::
     - 	rmHints::
     - 		In case of failure in the output of linkgit:git-rm[1],
     - 		show directions on how to proceed from the current state.
     -+	sequencerConflict::
     -+		Advice shown when a sequencer operation stops because
     -+		of conflicts.
     - 	sequencerInUse::
     - 		Advice shown when a sequencer command is already in progress.
     - 	skippedCherryPicks::
     + 		Advice on how to set your identity configuration when
     + 		your information is guessed from the system username and
     + 		domain name.
     ++	mergeConflict::
     ++		Advice shown when various commands stop because of conflicts.
     + 	nestedTag::
     + 		Advice shown if a user attempts to recursively tag a tag object.
     + 	pushAlreadyExists::
      
       ## advice.c ##
      @@ advice.c: static struct {
     - 	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh" },
     - 	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict" },
     - 	[ADVICE_RM_HINTS]				= { "rmHints" },
     -+	[ADVICE_SEQUENCER_CONFLICT]                     = { "sequencerConflict" },
     - 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
     - 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
     - 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
     + 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
     + 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook" },
     + 	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity" },
     ++	[ADVICE_MERGE_CONFLICT]				= { "mergeConflict" },
     + 	[ADVICE_NESTED_TAG]				= { "nestedTag" },
     + 	[ADVICE_OBJECT_NAME_WARNING]			= { "objectNameWarning" },
     + 	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists" },
      
       ## advice.h ##
      @@ advice.h: enum advice_type {
     - 	ADVICE_RESOLVE_CONFLICT,
     - 	ADVICE_RM_HINTS,
     - 	ADVICE_SEQUENCER_IN_USE,
     -+	ADVICE_SEQUENCER_CONFLICT,
     - 	ADVICE_SET_UPSTREAM_FAILURE,
     - 	ADVICE_SKIPPED_CHERRY_PICKS,
     - 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
     + 	ADVICE_IGNORED_HOOK,
     + 	ADVICE_IMPLICIT_IDENTITY,
     + 	ADVICE_NESTED_TAG,
     ++	ADVICE_MERGE_CONFLICT,
     + 	ADVICE_OBJECT_NAME_WARNING,
     + 	ADVICE_PUSH_ALREADY_EXISTS,
     + 	ADVICE_PUSH_FETCH_FIRST,
      
       ## sequencer.c ##
      @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
     @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
       
       	if (msg) {
      -		advise("%s\n", msg);
     -+		advise_if_enabled(ADVICE_SEQUENCER_CONFLICT, "%s\n", msg);
     ++		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s\n", msg);
       		/*
       		 * A conflict has occurred but the porcelain
       		 * (typically rebase --interactive) wants to take care
     @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
       		if (opts->no_commit)
      -			advise(_("after resolving the conflicts, mark the corrected paths\n"
      -				 "with 'git add <paths>' or 'git rm <paths>'"));
     -+			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
     ++			advise_if_enabled(ADVICE_MERGE_CONFLICT,
      +					  _("after resolving the conflicts, mark the corrected paths\n"
      +					    "with 'git add <paths>' or 'git rm <paths>'"));
       		else if (opts->action == REPLAY_PICK)
     @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
      -				 "You can instead skip this commit with \"git cherry-pick --skip\".\n"
      -				 "To abort and get back to the state before \"git cherry-pick\",\n"
      -				 "run \"git cherry-pick --abort\"."));
     -+			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
     ++			advise_if_enabled(ADVICE_MERGE_CONFLICT,
      +					  _("After resolving the conflicts, mark them with\n"
      +					    "\"git add/rm <pathspec>\", then run\n"
      +					    "\"git cherry-pick --continue\".\n"
     @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
      -				 "You can instead skip this commit with \"git revert --skip\".\n"
      -				 "To abort and get back to the state before \"git revert\",\n"
      -				 "run \"git revert --abort\"."));
     -+			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
     ++			advise_if_enabled(ADVICE_MERGE_CONFLICT,
      +					  _("After resolving the conflicts, mark them with\n"
      +					    "\"git add/rm <pathspec>\", then run\n"
      +					    "\"git revert --continue\".\n"
     @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'advice from failed revert' '
       	hint: You can instead skip this commit with "git revert --skip".
       	hint: To abort and get back to the state before "git revert",
       	hint: run "git revert --abort".
     -+	hint: Disable this message with "git config advice.sequencerConflict false"
     ++	hint: Disable this message with "git config advice.mergeConflict false"
       	EOF
       	test_commit --append --no-tag "double-add dream" dream dream &&
       	test_must_fail git revert HEAD^ 2>actual &&
     @@ t/t3507-cherry-pick-conflict.sh: test_expect_success 'advice from failed cherry-
       	hint: You can instead skip this commit with "git cherry-pick --skip".
       	hint: To abort and get back to the state before "git cherry-pick",
       	hint: run "git cherry-pick --abort".
     -+	hint: Disable this message with "git config advice.sequencerConflict false"
     ++	hint: Disable this message with "git config advice.mergeConflict false"
       	EOF
       	test_must_fail git cherry-pick picked 2>actual &&
       
     @@ t/t3507-cherry-pick-conflict.sh: test_expect_success 'advice from failed cherry-
       	error: could not apply \$picked... picked
       	hint: after resolving the conflicts, mark the corrected paths
       	hint: with 'git add <paths>' or 'git rm <paths>'
     -+	hint: Disable this message with \"git config advice.sequencerConflict false\"
     ++	hint: Disable this message with \"git config advice.mergeConflict false\"
       	EOF
       	test_must_fail git cherry-pick --no-commit picked 2>actual &&
       
 -:  ----------- > 2:  3235542cc6f builtin/am: allow disabling conflict advice

-- 
gitgitgadget
