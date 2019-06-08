Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038351F462
	for <e@80x24.org>; Sat,  8 Jun 2019 19:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfFHTXE (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 15:23:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44571 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfFHTXE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 15:23:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so2997144pfe.11
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 12:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4fjB/g/lkb/lzkq6ZOhBnL47PPp1oSX8U0IqDIEQ9dA=;
        b=TQ3c0NHsPLNOsi0I/wv6zo8nVhaczp/184i9LI9ALYeskbbNotajC99lgRYPek87lH
         WueCA0wBTkXQioNgDIarauYD/bUQPMZE8PqAtkhAi1VFYR8x0WLwzm2QZ2UymE8amUUI
         08jaIce8uKzMUvlw8HSk0fIvPr9BjcHjR7eIS1KzI+LfVwUaph+F1jZNhlgob/tGfOdb
         Lg/zAEa6qZD5Y1B3wz6rJT0Nf9oq7qpJrukzQ375IzSp54+0T9FYwAPACm84WOW5qeVB
         3gEVu9ntJ76sExoiCPx8NexUwj+hvL3odYUcZUGcBpIqeSsqQXzjZ6sVnTQa2JcLr3Ug
         TFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fjB/g/lkb/lzkq6ZOhBnL47PPp1oSX8U0IqDIEQ9dA=;
        b=Htoo8HyGZ13Gs1JHMPt5bGqlDTcrzWbraWcm4Z79r19L4CM4NP4106q8ZXdLr4JTwV
         TXYXwjhiQzdw8yNKPTTmPlJFjQdDYbz9n8nw77FNBD4djVrhNhnm33FDHdu6cYvEfTtX
         bgyqS1KTljtmXh6V+i9jNXJ37TwJEgJwS1viuoi+u3gQKBtNrNxPPkMYdXhnmT7smIK0
         EzYMcAklvLu9tf8bbo8QSRoNEYe9fqkQDUDzv1xKIIwaBYKcdBfG1/tTufe6PwxTtwJp
         ONg/e1tLQYDk1vnClbHyY0SyK6yctHJ/TkmwGMSghbiN1KV1uRnbEGKkpMb8wAN3KK7v
         hLVg==
X-Gm-Message-State: APjAAAXGrOsa1PaCzVCIBMbcoR3zruo0EOVipiK3WE75/eeBvIhToFec
        +p/BbD+zjHpkvBeBgw066h9qAMoW6hA=
X-Google-Smtp-Source: APXvYqyQ0SPmphaLyxQv/4ggvJRdQzmxOCDhmcbeZNrxdjN7aVmQ/zEPcxYuD711d26XhVE408aQBg==
X-Received: by 2002:a63:1e59:: with SMTP id p25mr8493821pgm.270.1560021782532;
        Sat, 08 Jun 2019 12:23:02 -0700 (PDT)
Received: from ar135.iitr.local ([223.188.32.84])
        by smtp.gmail.com with ESMTPSA id o126sm6186290pfb.134.2019.06.08.12.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 12:23:01 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, t.gummerer@gmail.com,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCH 2/3] cherry-pick/revert: add --skip option
Date:   Sun,  9 Jun 2019 00:49:57 +0530
Message-Id: <20190608191958.4593-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git am or rebase advise the user to use `git (am | rebase) --skip` to
skip the commit. cherry-pick and revert also have this concept of
skipping commits but they advise the user to use `git reset` (or in
case of a patch which had conflicts, `git reset --merge`) which on the
user's part is annoying and sometimes confusing. Add a `--skip` option
to make these commands more consistent.

In the next commit, we will change the advice messages hence finishing
the process of teaching revert and cherry-pick "how to skip commits".

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-cherry-pick.txt |  4 +-
 Documentation/git-revert.txt      |  4 +-
 Documentation/sequencer.txt       |  4 ++
 builtin/revert.c                  |  5 +++
 sequencer.c                       | 23 +++++++++++
 sequencer.h                       |  1 +
 t/t3510-cherry-pick-sequence.sh   | 63 +++++++++++++++++++++++++++++++
 7 files changed, 98 insertions(+), 6 deletions(-)

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
index 9c561a041b..f586e677d3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2784,6 +2784,29 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 	return -1;
 }
 
+int sequencer_skip(struct repository *r, struct replay_opts *opts)
+{
+	switch (opts->action) {
+	case REPLAY_REVERT:
+		if (!file_exists(git_path_revert_head(r)))
+			return error(_("no revert in progress"));
+		break;
+	case REPLAY_PICK:
+		if (!file_exists(git_path_cherry_pick_head(r)))
+			return error(_("no cherry-pick in progress"));
+		break;
+	default:
+		BUG("the control must not reach here.");
+	}
+
+	if (rollback_single_pick(r))
+		return error(_("failed to skip the commit"));
+	if (!is_directory(git_path_seq_dir()))
+		return 0;
+
+	return sequencer_continue(r, opts);
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
index 941d5026da..48cc9f13ee 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -93,6 +93,69 @@ test_expect_success 'cherry-pick cleans up sequencer state upon success' '
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
 test_expect_success '--quit does not complain when no cherry-pick is in progress' '
 	pristine_detach initial &&
 	git cherry-pick --quit
-- 
2.21.0

