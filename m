Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4F51F461
	for <e@80x24.org>; Tue,  2 Jul 2019 09:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfGBJOb (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 05:14:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37810 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfGBJOb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 05:14:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so56953plb.4
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 02:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7y/kL5Nok/GYir2EOd9bxMuhqFh5Z185neSHy7az5fM=;
        b=XCcvhQ7Slq0RvZ4SVY5VfSpg+4fQH6te6q7ytYVDodc5ztvXSEZuziZDqN3pu4xWor
         BTcFRD8dNtpJHxp2Ko06iHJEq48ozK08Tpvs8kCPBKzqutvTiuJjG289hP3DL5XGA8FZ
         R/sT1DcCOLwyP5nWcAsk8uVQ25eD9G/cZRxNjzKKAPXQ0Y6uUjtrRx7xSMN2s9HOlKxz
         g+geJ2+/WzNNwjI7zlepQxC7m5y0yJc4a+UGVhIq27UuJe87pjpuW4Y4epYnqw8COTNE
         m25x61V3PnxzA3ngg7HiVDyEMDcwt5uBbuum0aJ/lFD5QlgbdquQ8TEQ86M1WCj7fn/E
         0LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7y/kL5Nok/GYir2EOd9bxMuhqFh5Z185neSHy7az5fM=;
        b=pJyncUwtlchVcHrkAawBqh2xBIuK5gL6KK7A1dqzG0cjb80IMGIjBp0pvUM83HKEd4
         /2Jddc36l035KUMt9C0MGmqkcDBKI4ulJNU2A2YUSfxlNIUfiMWoNxpD7yS2t5LDHEyw
         uFJCDJNHuwVYU1nH/Zbd9DPQzAQlfjtHf55vFSgs2HCcFe2WD6U3IYOLMZxTQC7Z9e89
         L9wJgaF/9psWjH8xpGbVUtrUunsVqRUBNLRX3fFk4XqXvRn1DpRtm8YKCQJ6F+nXGntY
         HNb2dKx/DivcOdk2R1jVE8Wtd48FItoDjpUkehE5/8W6g3mCbBK7WOhau0OM0obQ8GKK
         M/gg==
X-Gm-Message-State: APjAAAVIoYIOEp/l1KXNsCUYZVjuPj7kEFfmJyzT6jrYVf+d7eKOVeni
        C/jNaxOH+OqEOIpV3zwh2R8=
X-Google-Smtp-Source: APXvYqy/qEFWv1MKD0O4JeapBTihlSzzNktUy5SRsjsGXQyMxuhyXVAhTAbifZ77gNyiV2wN9v0hvA==
X-Received: by 2002:a17:902:424:: with SMTP id 33mr34154037ple.151.1562058869552;
        Tue, 02 Jul 2019 02:14:29 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id q198sm20499178pfq.155.2019.07.02.02.14.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 02:14:28 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com
Subject: [GSoC][PATCH v8 4/5] cherry-pick/revert: add --skip option
Date:   Tue,  2 Jul 2019 14:41:28 +0530
Message-Id: <20190702091129.7531-5-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702091129.7531-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190702091129.7531-1-rohit.ashiwal265@gmail.com>
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
the process of teaching revert and cherry-pick "how to skip commits".

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-cherry-pick.txt |   4 +-
 Documentation/git-revert.txt      |   4 +-
 Documentation/sequencer.txt       |   4 ++
 builtin/revert.c                  |   5 ++
 sequencer.c                       |  73 +++++++++++++++++++++
 sequencer.h                       |   1 +
 t/t3510-cherry-pick-sequence.sh   | 102 ++++++++++++++++++++++++++++++
 7 files changed, 187 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 754b16ce0c..83ce51aedf 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -10,9 +10,7 @@ SYNOPSIS
 [verse]
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
 		  [-S[<keyid>]] <commit>...
-'git cherry-pick' --continue
-'git cherry-pick' --quit
-'git cherry-pick' --abort
+'git cherry-pick' (--continue | --skip | --abort | --quit)
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 0c82ca5bc0..665e065ee3 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -9,9 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
-'git revert' --continue
-'git revert' --quit
-'git revert' --abort
+'git revert' (--continue | --skip | --abort | --quit)
 
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
index 70efe36ee8..f5e3d60878 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2762,6 +2762,15 @@ static int rollback_single_pick(struct repository *r)
 	return reset_merge(&head_oid);
 }
 
+static int skip_single_pick(void)
+{
+	struct object_id head;
+
+	if (read_ref_full("HEAD", 0, &head, NULL))
+		return error(_("cannot resolve HEAD"));
+	return reset_merge(&head);
+}
+
 int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 {
 	FILE *f;
@@ -2811,6 +2820,70 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 	return -1;
 }
 
+int sequencer_skip(struct repository *r, struct replay_opts *opts)
+{
+	enum replay_action action = -1;
+	sequencer_get_last_command(r, &action);
+
+	/*
+	 * Check whether the subcommand requested to skip the commit is actually
+	 * in progress and that it's safe to skip the commit.
+	 *
+	 * opts->action tells us which subcommand requested to skip the commit.
+	 * If the corresponding .git/<ACTION>_HEAD exists, we know that the
+	 * action is in progress and we can skip the commit.
+	 *
+	 * Otherwise we check that the last instruction was related to the
+	 * particular subcommand we're trying to execute and barf if that's not
+	 * the case.
+	 *
+	 * Finally we check that the rollback is "safe", i.e., has the HEAD
+	 * moved? In this case, it doesn't make sense to "reset the merge" and
+	 * "skip the commit" as the user already handled this by committing. But
+	 * we'd not want to barf here, instead give advice on how to proceed. We
+	 * only need to check that when .git/<ACTION>_HEAD doesn't exist because
+	 * it gets removed when the user commits, so if it still exists we're
+	 * sure the user can't have committed before.
+	 */
+	switch (opts->action) {
+	case REPLAY_REVERT:
+		if (!file_exists(git_path_revert_head(r))) {
+			if (action != REPLAY_REVERT)
+				return error(_("no revert in progress"));
+			if (!rollback_is_safe())
+				goto give_advice;
+		}
+		break;
+	case REPLAY_PICK:
+		if (!file_exists(git_path_cherry_pick_head(r))) {
+			if (action != REPLAY_PICK)
+				return error(_("no cherry-pick in progress"));
+			if (!rollback_is_safe())
+				goto give_advice;
+		}
+		break;
+	default:
+		BUG("unexpected action in sequencer_skip");
+	}
+
+	if (skip_single_pick())
+		return error(_("failed to skip the commit"));
+	if (!is_directory(git_path_seq_dir()))
+		return 0;
+
+	return sequencer_continue(r, opts);
+
+give_advice:
+	error(_("there is nothing to skip"));
+
+	if (advice_resolve_conflict) {
+		advise(_("have you committed already?\n"
+			 "try \"git %s --continue\""),
+			 action == REPLAY_REVERT ? "revert" : "cherry-pick");
+	}
+	return -1;
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
index 941d5026da..20515ea37b 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -93,6 +93,108 @@ test_expect_success 'cherry-pick cleans up sequencer state upon success' '
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
+	error: there is nothing to skip
+	hint: have you committed already?
+	hint: try "git cherry-pick --continue"
+	fatal: cherry-pick failed
+	EOF
+	test_must_fail git cherry-pick base..yetanotherpick &&
+	echo c >foo &&
+	git commit -a &&
+	test_path_is_missing .git/CHERRY_PICK_HEAD &&
+	test_must_fail git cherry-pick --skip 2>advice &&
+	test_i18ncmp expect advice
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
+	test_i18ncmp expect advice
+'
+
+test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
+	pristine_detach initial &&
+	git rm --cached unrelated &&
+	git commit -m "untrack unrelated" &&
+	test_must_fail git cherry-pick initial base &&
+	test_path_is_missing .git/CHERRY_PICK_HEAD &&
+	git cherry-pick --skip
+'
+
 test_expect_success '--quit does not complain when no cherry-pick is in progress' '
 	pristine_detach initial &&
 	git cherry-pick --quit
-- 
2.21.0

