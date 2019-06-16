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
	by dcvr.yhbt.net (Postfix) with ESMTP id 446951F462
	for <e@80x24.org>; Sun, 16 Jun 2019 08:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfFPIXq (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 04:23:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39151 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfFPIXq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 04:23:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so4046025pgc.6
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 01:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTg9S4fcy1AKCCedENSZDDSE41b1F9LwF70DmKcEYnY=;
        b=jrttvmsgZqXgmDbmXYXKN3Qz77Sfa+zRwFCecwatMIrq2CWW8iXNZR34wfyszKoCUb
         y0YlWNdIekG1i50souRy2qzhm50hrCNzidzh8/6cNqhPRn6ffs8uxsGsz99ULX0oStAI
         v8rI2xs/g85m9PzqFCYE8byT58FdFuBUY4dNpP+XYvRfg9aVjeM8LNka2MXlJmTO1oXT
         wIfiFxC5U0hmfT0RZfKye1UmZ5Sk6rj4z7CTf+C/xiOKWSMj3NZd/nMhTNLISPN9brtw
         8uvkpwpcc4VZPYGWz6iCCiospdr03oVzIyNJLg/hMxyjQtKr3rdt39hSKPtzi4LxtXy8
         HpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTg9S4fcy1AKCCedENSZDDSE41b1F9LwF70DmKcEYnY=;
        b=GbfpQYD+cuB9qiRiWzRecHCx9xsA8QzFgaGZacBB7GqxwXJLtz/3fCq2WVCMKEWBw5
         cWCMznIkOjpMQkhJpHvE8hd3zAGYuDRXubtxKHELdxLdAqGC0bIIN20ed7XRcREDIbum
         73YGNM8mP92uSIEwYbfW1qtQZTrJlCNwXi5YPfMROARRcJcTGrfNrsnXkRDoNJEDlNFF
         vPvZruaNi/qrNLPLtomCfyPLKe0QAlhlHk98JhftOpagFXFNDf0GgWhmx7hEGXjT59Wz
         xgWuud1nwwsT+rk96XoOATn52xdNSphpI8ywP1O4zCyTT689Sr/Z3kOUxOKmR/UYdykc
         W+wg==
X-Gm-Message-State: APjAAAX0N7fWLOr2KUTaIuAjUylk0O0zYw+YJYqoG2FPowbzvH5vR8/l
        8hjABxph+hAYVbyQv2/VobXO4Fcc+/ul3w==
X-Google-Smtp-Source: APXvYqypI2hJRtElu8uqZscffJPwuwnY2AzPe7WTbYzAzTaB5lciKxPn/OPxMLRbgngV4WfAD/J2ww==
X-Received: by 2002:a17:90a:8415:: with SMTP id j21mr19885283pjn.21.1560673424891;
        Sun, 16 Jun 2019 01:23:44 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3105:6dd7:b496:8be7:332f:b415])
        by smtp.gmail.com with ESMTPSA id x128sm1471972pfd.17.2019.06.16.01.23.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:23:44 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v4 3/4] cherry-pick/revert: add --skip option
Date:   Sun, 16 Jun 2019 13:50:39 +0530
Message-Id: <20190616082040.9440-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
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

In the next commit, we will change the advice messages and some tests
hence finishing the process of teaching revert and cherry-pick
"how to skip commits".

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
changes:
    - Introduce '('s around documentation/help
    - Introduce a wrapper function skip_single_pick to reset_merge
    - Add comments to sequencer_skip
    - Change tests to use test_i18ncmp instead of test_cmp to not fail under
      GETTEXT_POISON

 Documentation/git-cherry-pick.txt |   4 +-
 Documentation/git-revert.txt      |   4 +-
 Documentation/sequencer.txt       |   4 ++
 builtin/revert.c                  |   5 ++
 sequencer.c                       |  94 +++++++++++++++++++++++++--
 sequencer.h                       |   1 +
 t/t3510-cherry-pick-sequence.sh   | 102 ++++++++++++++++++++++++++++++
 7 files changed, 202 insertions(+), 12 deletions(-)

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
index 408643f88a..95fa19a118 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2733,13 +2733,18 @@ static int rollback_is_safe(void)
 
 static int reset_merge(const struct object_id *oid)
 {
-	const char *argv[4];	/* reset --merge <arg> + NULL */
+	int ret;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	argv[0] = "reset";
-	argv[1] = "--merge";
-	argv[2] = oid_to_hex(oid);
-	argv[3] = NULL;
-	return run_command_v_opt(argv, RUN_GIT_CMD);
+	argv_array_pushl(&argv, "reset", "--merge", NULL);
+
+	if (!is_null_oid(oid))
+		argv_array_push(&argv, oid_to_hex(oid));
+
+	ret = run_command_v_opt(argv.argv, RUN_GIT_CMD);
+	argv_array_clear(&argv);
+
+	return ret;
 }
 
 static int rollback_single_pick(struct repository *r)
@@ -2756,6 +2761,15 @@ static int rollback_single_pick(struct repository *r)
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
@@ -2805,6 +2819,74 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 	return -1;
 }
 
+int sequencer_skip(struct repository *r, struct replay_opts *opts)
+{
+	enum replay_action action = -1;
+	sequencer_get_last_command(r, &action);
+
+	/*
+	 * opts->action tells us which subcommand requested to skip
+	 * the commit.
+	 */
+	switch (opts->action) {
+	case REPLAY_REVERT:
+		/*
+		 * If .git/REVERT_HEAD exists then we are sure that we are in
+		 * the middle of a revert and we allow to skip the commit.
+		 */
+		if (!file_exists(git_path_revert_head(r))) {
+			/*
+			 * Check if the last instruction executed was related to
+			 * revert. If so, we are sure that a revert is in progress.
+			 *
+			 * NB: single commit revert is also counted in this
+			 * definition of "progress" (and was dealt with in the
+			 * previous check).
+			 */
+			if (action == REPLAY_REVERT) {
+				/*
+				 * Check if the user has moved the HEAD, i.e.,
+				 * already committed. In this case, we would like
+				 * to advise instead of skipping.
+				 */
+				if (!rollback_is_safe())
+					goto give_advice;
+				else
+					/* skip commit :) */
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
index 941d5026da..dc0ac8343c 100755
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

