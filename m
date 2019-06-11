Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB22F1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 07:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404156AbfFKHe0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 03:34:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46468 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403920AbfFKHeY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 03:34:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so6846513pfy.13
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+iAHIr+E1dcYhn+BBWErzuNLUNafU6VSnp5CIjdcQRg=;
        b=ZEik3TJEa2BFnRMDTXQn0iO7Ku1/mSSgiDmfYRkbo11jkgSXcfgI1o+sZ8GMiglvoA
         DBYm1iJ3vdFf3wK2n85vpTXFS5hUuYG3Kuq80ZMvYlbkTx3pAnwdeGTvMD429lhRBUsQ
         qwOMs5LIPmKpi/uUt8sFlxC6kT/6hTwXYX+4pEqyw2Bqz3JRNn+GGtHEnYsNb27xE+IU
         KT2FjX5DL56IEB6Gzsl6B7lHI6tv2fzyoPbhEq/YNrKPkhG89GI52tf02g6S+p2Mo0mE
         KFnj9Dv7jV7z7M/Vqovds88a8pvW7AezyqV5Iz7f99dla6KZNjoKCEHUkK9Giv9d/GQ5
         BXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+iAHIr+E1dcYhn+BBWErzuNLUNafU6VSnp5CIjdcQRg=;
        b=lIwkQSDOhYEvi3XE0XI2b79YGu0KZaJTve6UUprhUQETp1+CDsf30N42nHzsLZ/3z2
         C6kP5ZWAqJuX+bxjOU6Xd4cobO53SPJKF2eVf64oZY0ntlj+wc2deC8AXREmc8HX4BAf
         wMvKcV7S390C67RETt3choBaNomtOwwIia3Sbl0zHirVR/5LjYhw2fbIdMG/BO1x3oMc
         wYhEVgs11DnOuiU2jHqYtZRJSb+L4Vr1EYTwtU0LmkoBv8UvMzJabX+drZpKdEB6XgTR
         P4cgOJioyu49zz3sqizkUxk4qsbS15wuYOeLOTBt6H31/eCJ8lMq+6kdbM671N+M+6T9
         4Sww==
X-Gm-Message-State: APjAAAXeVhi1nLTAw126gkcTn8hRs0GJQikPyyI0RrkKmWdFN9pmzuI7
        +tHz61OK3LaGHhV5/W8yaaA=
X-Google-Smtp-Source: APXvYqwfiLrnZE15d6MTgiyiielPYr4BugG62IEoCWpL5vHTNcjSG379Ah+Exo+qwH28NhO9wOD+LQ==
X-Received: by 2002:a17:90a:374f:: with SMTP id u73mr1040088pjb.4.1560238463122;
        Tue, 11 Jun 2019 00:34:23 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:310c:9b37:39e2:17f3:788e:3d39])
        by smtp.gmail.com with ESMTPSA id m16sm7166022pfd.127.2019.06.11.00.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 00:34:22 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v2 2/3] cherry-pick/revert: add --skip option
Date:   Tue, 11 Jun 2019 13:01:51 +0530
Message-Id: <20190611073152.12214-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611073152.12214-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190611073152.12214-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git am or rebase have a --skip flag to skip the current commit if the
user wishes to do so. During a cherry-pick or revert a user could
likewise skip a commit, but needs to use 'git reset' (or in the case
of conflicts 'git reset --merge'), followed by 'git (cherry-pick |
revert) --continue' to skip the commit. This is more annoying and
sometimes confusing on the users' part. Add a `--skip` option to make
skipping commits easier for the user and to make the commands more
consistent.

In the next commit, we will change the advice messages hence finishing
the process of teaching revert and cherry-pick "how to skip commits."

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
I was not able to think what should I change in 'skip a commit and check
if rest of sequence is correct' test. Please suggest how shall I fix this.
But I think test is fine as it is now (because I wrote it and have been
looking at it for a long time that I am out of ideas).

changes since last revision:
    - introduce new function `reset_merge` which will eliminate the problem
      of wrong error "cannot abort from a branch yet to be born" which occurs
      when head is NULL, but we still can skip (but not abort)
    - `sequencer_skip` now calls `reset_merge` instead of `rollback_single_pick`
    - add more tests

 Documentation/git-cherry-pick.txt |   4 +-
 Documentation/git-revert.txt      |   4 +-
 Documentation/sequencer.txt       |   4 ++
 builtin/revert.c                  |   5 ++
 sequencer.c                       |  56 ++++++++++++++++
 sequencer.h                       |   1 +
 t/t3510-cherry-pick-sequence.sh   | 104 ++++++++++++++++++++++++++++++
 7 files changed, 172 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 754b16ce0c..955880ab88 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -10,9 +10,7 @@ SYNOPSIS
 [verse]
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
 		  [-S[<keyid>]] <commit>...
-'git cherry-pick' --continue
-'git cherry-pick' --quit
-'git cherry-pick' --abort
+'git cherry-pick' --continue | --skip | --abort | --quit
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 0c82ca5bc0..ffce98099c 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -9,9 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
-'git revert' --continue
-'git revert' --quit
-'git revert' --abort
+'git revert' --continue | --skip | --abort | --quit
 
 DESCRIPTION
 -----------
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
index 5a57c4a407..3bceb56474 100644
--- a/Documentation/sequencer.txt
+++ b/Documentation/sequencer.txt
@@ -3,6 +3,10 @@
 	`.git/sequencer`.  Can be used to continue after resolving
 	conflicts in a failed cherry-pick or revert.
 
+--skip::
+	Skip the current commit and continue with the rest of the
+	sequence.
+
 --quit::
 	Forget about the current operation in progress.  Can be used
 	to clear the sequencer state after a failed cherry-pick or
diff --git a/builtin/revert.c b/builtin/revert.c
index d4dcedbdc6..5dc5891ea2 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -102,6 +102,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
+		OPT_CMDMODE(0, "skip", &cmd, N_("skip current commit and continue"), 's'),
 		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
@@ -151,6 +152,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			this_operation = "--quit";
 		else if (cmd == 'c')
 			this_operation = "--continue";
+		else if (cmd == 's')
+			this_operation = "--skip";
 		else {
 			assert(cmd == 'a');
 			this_operation = "--abort";
@@ -210,6 +213,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		return sequencer_continue(the_repository, opts);
 	if (cmd == 'a')
 		return sequencer_rollback(the_repository, opts);
+	if (cmd == 's')
+		return sequencer_skip(the_repository, opts);
 	return sequencer_pick_revisions(the_repository, opts);
 }
 
diff --git a/sequencer.c b/sequencer.c
index ffb0257f0f..93284cd7dd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2724,6 +2724,16 @@ static int rollback_is_safe(void)
 	return oideq(&actual_head, &expected_head);
 }
 
+static int reset_merge(void) {
+	const char *argv[3];
+
+	argv[0] = "reset";
+	argv[1] = "--merge";
+	argv[2] = NULL;
+
+	return run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
 static int reset_for_rollback(const struct object_id *oid)
 {
 	const char *argv[4];	/* reset --merge <arg> + NULL */
@@ -2798,6 +2808,52 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 	return -1;
 }
 
+int sequencer_skip(struct repository *r, struct replay_opts *opts)
+{
+	enum replay_action action = -1;
+	sequencer_get_last_command(r, &action);
+
+	switch (opts->action) {
+	case REPLAY_REVERT:
+		if (!file_exists(git_path_revert_head(r))) {
+			if (action == REPLAY_REVERT) {
+				if (!rollback_is_safe())
+					goto give_advice;
+				else
+					break;
+			}
+			return error(_("no revert in progress"));
+		}
+		break;
+	case REPLAY_PICK:
+		if (!file_exists(git_path_cherry_pick_head(r))) {
+			if (action == REPLAY_PICK) {
+				if (!rollback_is_safe())
+					goto give_advice;
+				else
+					break;
+			}
+			return error(_("no cherry-pick in progress"));
+		}
+		break;
+	default:
+		BUG("the control must not reach here");
+	}
+
+	if (reset_merge())
+		return error(_("failed to skip the commit"));
+	if (!is_directory(git_path_seq_dir()))
+		return 0;
+
+	return sequencer_continue(r, opts);
+
+give_advice:
+	advise(_("have you committed already?\n"
+		 "try \"git %s --continue\""),
+		 action == REPLAY_REVERT ? "revert" : "cherry-pick");
+	return error(_("there is nothing to skip"));
+}
+
 static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 {
 	struct lock_file todo_lock = LOCK_INIT;
diff --git a/sequencer.h b/sequencer.h
index 0c494b83d4..731b9853eb 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -129,6 +129,7 @@ int sequencer_pick_revisions(struct repository *repo,
 			     struct replay_opts *opts);
 int sequencer_continue(struct repository *repo, struct replay_opts *opts);
 int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
+int sequencer_skip(struct repository *repo, struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
 #define TODO_LIST_KEEP_EMPTY (1U << 0)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 941d5026da..6c1903a735 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -93,6 +93,110 @@ test_expect_success 'cherry-pick cleans up sequencer state upon success' '
 	test_path_is_missing .git/sequencer
 '
 
+test_expect_success 'cherry-pick --skip requires cherry-pick in progress' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --skip
+'
+
+test_expect_success 'revert --skip requires revert in progress' '
+	pristine_detach initial &&
+	test_must_fail git revert --skip
+'
+
+test_expect_success 'cherry-pick --skip to skip commit' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick anotherpick &&
+	test_must_fail git revert --skip &&
+	git cherry-pick --skip &&
+	test_cmp_rev initial HEAD &&
+	test_path_is_missing .git/CHERRY_PICK_HEAD
+'
+
+test_expect_success 'revert --skip to skip commit' '
+	pristine_detach anotherpick &&
+	test_must_fail git revert anotherpick~1 &&
+	test_must_fail git cherry-pick --skip &&
+	git revert --skip &&
+	test_cmp_rev anotherpick HEAD
+'
+
+test_expect_success 'skip "empty" commit' '
+	pristine_detach picked &&
+	test_commit dummy foo d &&
+	test_must_fail git cherry-pick anotherpick &&
+	git cherry-pick --skip &&
+	test_cmp_rev dummy HEAD
+'
+
+test_expect_success 'skip a commit and check if rest of sequence is correct' '
+	pristine_detach initial &&
+	echo e >expect &&
+	cat >expect.log <<-EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	unrelated
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_must_fail git cherry-pick base..yetanotherpick &&
+	test_must_fail git cherry-pick --skip &&
+	echo d >foo &&
+	git add foo &&
+	git cherry-pick --continue &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$OID_REGEX/OBJID/g"
+	} >actual.log &&
+	test_cmp expect foo &&
+	test_cmp expect.log actual.log
+'
+
+test_expect_success 'check advice when we move HEAD by committing' '
+	pristine_detach initial &&
+	cat >expect <<-EOF &&
+	hint: have you committed already?
+	hint: try "git cherry-pick --continue"
+	error: there is nothing to skip
+	fatal: cherry-pick failed
+	EOF
+	test_must_fail git cherry-pick base..yetanotherpick &&
+	echo c >foo &&
+	git commit -a &&
+	test_path_is_missing .git/CHERRY_PICK_HEAD &&
+	test_must_fail git cherry-pick --skip 2>advice &&
+	test_cmp expect advice
+'
+
+test_expect_success 'allow skipping commit but not abort for a new history' '
+	pristine_detach initial &&
+	cat >expect <<-EOF &&
+	error: cannot abort from a branch yet to be born
+	fatal: cherry-pick failed
+	EOF
+	git checkout --orphan new_disconnected &&
+	git reset --hard &&
+	test_must_fail git cherry-pick anotherpick &&
+	test_must_fail git cherry-pick --abort 2>advice &&
+	git cherry-pick --skip &&
+	test_cmp expect advice
+'
+
+test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
+	pristine_detach initial &&
+	git checkout --orphan new_disconnected &&
+	git reset --hard &&
+	test_commit new_disconnected foo a &&
+	echo unrelated >unrelated &&
+	test_must_fail git cherry-pick new_disconnected..base &&
+	test_path_is_missing .git/CHERRY_PICK_HEAD &&
+	git cherry-pick --skip
+'
+
 test_expect_success '--quit does not complain when no cherry-pick is in progress' '
 	pristine_detach initial &&
 	git cherry-pick --quit
-- 
2.21.0

