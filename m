Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5607BC77B7C
	for <git@archiver.kernel.org>; Sun, 28 May 2023 09:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjE1JIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 May 2023 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjE1JIP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2023 05:08:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF595C3
        for <git@vger.kernel.org>; Sun, 28 May 2023 02:08:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3078cc99232so2094888f8f.3
        for <git@vger.kernel.org>; Sun, 28 May 2023 02:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685264891; x=1687856891;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJoERykN9R8iIyRzUYs4xObJFGSHz3GzNJjmFzeENOs=;
        b=VtkpcttlxW6ytoO/D7cCg31PKdhQqviLF9d1mBhgrCP5ca2WQqnTf4PjqLS3d18xlf
         CfvvRgcYkXzd6soJuAdP/F1cdIHLrJjpB4MoSs6MCIXACp9qoLl54Jst9Y8eDN0fs7Ii
         DlXdnaA4uvaLZy3Aw777mHq5GPjGzxtWRds0NK8106oOh6uTkeL5A6LZOGGoUR9a5xfI
         rUZKREeXFEIZB9QAQhAFz6WPFMSATA3oKYjifVNzDVPzsiDNM9CZ2HOxptf8i0yqcq9r
         6EJ8ClHQIa0ea2vVrp6bviAsGNNL5j80tvMriie4sbKPDwi61rzLPlh62XDx/fKoyEgq
         hTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685264891; x=1687856891;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJoERykN9R8iIyRzUYs4xObJFGSHz3GzNJjmFzeENOs=;
        b=jM6L2qnNTt4PS1OIFd4sybiWrbT3LTn8baUUmpJg0dUbXasQmq2AVpL3l8uyCm/+bJ
         Rxb36xOxs+h8FyGdChfBTkgYOThTyQTuwCWQTCLYecM8BELcIaUwF3grb8Ydru2nbTqT
         4fqWrw2uTE2NxZOOpLa9fLOkYp7tpNeiJ9/plDCuXU43uQtEBvZ4EfR8H7ZMpbXg3rIn
         6kx5KKkAq4L9cpkUmHMCgkT7sekwYHF8pLxXy1PN1oTXlI2AA903u1iIjGv3N0lQ3fb+
         CRe05yWOiR4GqrQQ2KAialLjo7FB1xOETiYPsIfB6p1w5WPTPBj34x4JTeStDR0wqmvY
         0ckg==
X-Gm-Message-State: AC+VfDy1AzREWz8cc5QNoK+GpJn/BnnoMbKPMj8RGeI00z+cWOt95aJP
        oAjXVbfoqlZy7jHQ+xUddisjHYiUhpk=
X-Google-Smtp-Source: ACHHUZ6iLMXbWr84EF63D8DM0R1CLRxWoPNwijrY/JKK3JywYXBTih7O66C2FXtAMicma5aPd/FzkA==
X-Received: by 2002:a5d:54c2:0:b0:306:2cf5:79dc with SMTP id x2-20020a5d54c2000000b003062cf579dcmr6392710wrv.35.1685264890856;
        Sun, 28 May 2023 02:08:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c378b00b003f195d540d9sm14244488wmr.14.2023.05.28.02.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 02:08:10 -0700 (PDT)
Message-Id: <pull.1535.v2.git.1685264889088.gitgitgadget@gmail.com>
In-Reply-To: <pull.1535.git.1684830767336.gitgitgadget@gmail.com>
References: <pull.1535.git.1684830767336.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 May 2023 09:08:08 +0000
Subject: [PATCH v2] cherry-pick: refuse cherry-pick sequence if index is dirty
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

Cherry-pick, like merge or rebase, refuses to run when there are changes
in the index. However, if a cherry-pick sequence is requested, this
refusal happens "too late": when the cherry-pick sequence has already
started, and an "--abort" or "--quit" is needed to resume normal
operation.

Normally, when an operation is "in-progress" and you want to go back to
where you were before, "--abort" is the right thing to run. If you run
"git cherry-pick --abort" in this specific situation, however, your
staged changes are destroyed as part of the abort! Generally speaking,
the abort process assumes any changes in the index are part of the
operation to be aborted.

Add an earlier check in the cherry-pick sequence process to ensure that
the index is clean, introducing a new general "quit if index dirty" function
derived from the existing worktree-level function used in rebase and pull.
Also add a test.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    cherry-pick: refuse cherry-pick sequence if index is dirty
    
    V2: In the first version I had reused the require_clean_work_tree()
    function, which meant I accidentally tightened the requirements for
    sequence cherry-pick, from "no staged changes" to "no staged or
    uncommitted changes".
    
    I've now introduced a new function require_clean_index() reusing the
    existing code.
    
    In the thread, Junio suggested it might make sense to make the
    requirements for sequence-cherry-pick the same as rebase - either to
    tighten them as I accidentally did before, or relax rebase to match the
    existing behavior of merge and cherry-pick. I am not sure the right way
    to make such changes would be, I think it might warrant a new
    configuration option, but I definitely think it is beyond the scope of
    this simple bugfix.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1535%2FTaoK%2Ftao-cherry-pick-sequence-safety-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1535/TaoK/tao-cherry-pick-sequence-safety-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1535

Range-diff vs v1:

 1:  ed225309835 ! 1:  be9a592a34a cherry-pick: refuse cherry-pick sequence if index is dirty
     @@ Commit message
          operation to be aborted.
      
          Add an earlier check in the cherry-pick sequence process to ensure that
     -    the index is clean, reusing the already-generalized method used for
     -    rebase. Also add a test.
     +    the index is clean, introducing a new general "quit if index dirty" function
     +    derived from the existing worktree-level function used in rebase and pull.
     +    Also add a test.
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
     - ## builtin/revert.c ##
     -@@ builtin/revert.c: static int run_sequencer(int argc, const char **argv, const char *prefix,
     - 		return sequencer_rollback(the_repository, opts);
     - 	if (cmd == 's')
     - 		return sequencer_skip(the_repository, opts);
     --	return sequencer_pick_revisions(the_repository, opts);
     -+	return sequencer_pick_revisions(the_repository, opts, me);
     - }
     - 
     - int cmd_revert(int argc, const char **argv, const char *prefix)
     -
       ## sequencer.c ##
      @@ sequencer.c: static int walk_revs_populate_todo(struct todo_list *todo_list,
       	return 0;
       }
       
      -static int create_seq_dir(struct repository *r)
     -+static int create_seq_dir(struct repository *r, const char *requested_action)
     ++static const char *cherry_pick_action_name(enum replay_action action) {
     ++	switch (action) {
     ++	case REPLAY_REVERT:
     ++		return "revert";
     ++		break;
     ++	case REPLAY_PICK:
     ++		return "cherry-pick";
     ++		break;
     ++	default:
     ++		BUG("unexpected action in cherry_pick_action_name");
     ++	}
     ++}
     ++
     ++static int create_seq_dir(struct repository *r, enum replay_action requested_action)
       {
     - 	enum replay_action action;
     +-	enum replay_action action;
     ++	enum replay_action in_progress_action;
     ++	const char *in_progress_action_name = NULL;
       	const char *in_progress_error = NULL;
     -@@ sequencer.c: static int create_seq_dir(struct repository *r)
     + 	const char *in_progress_advice = NULL;
     ++	const char *requested_action_name = NULL;
     + 	unsigned int advise_skip =
     + 		refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") ||
     + 		refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD");
     + 
     +-	if (!sequencer_get_last_command(r, &action)) {
     +-		switch (action) {
     +-		case REPLAY_REVERT:
     +-			in_progress_error = _("revert is already in progress");
     +-			in_progress_advice =
     +-			_("try \"git revert (--continue | %s--abort | --quit)\"");
     +-			break;
     +-		case REPLAY_PICK:
     +-			in_progress_error = _("cherry-pick is already in progress");
     +-			in_progress_advice =
     +-			_("try \"git cherry-pick (--continue | %s--abort | --quit)\"");
     +-			break;
     +-		default:
     +-			BUG("unexpected action in create_seq_dir");
     +-		}
     ++	if (!sequencer_get_last_command(r, &in_progress_action)) {
     ++		in_progress_action_name = cherry_pick_action_name(in_progress_action);
     ++		in_progress_error = _("%s is already in progress");
     ++		in_progress_advice =
     ++		_("try \"git %s (--continue | %s--abort | --quit)\"");
     + 	}
     + 	if (in_progress_error) {
     +-		error("%s", in_progress_error);
     ++		error(in_progress_error, in_progress_action_name);
     + 		if (advice_enabled(ADVICE_SEQUENCER_IN_USE))
     + 			advise(in_progress_advice,
     ++				in_progress_action_name,
       				advise_skip ? "--skip | " : "");
       		return -1;
       	}
     -+	if (require_clean_work_tree(r, requested_action,
     ++	requested_action_name = cherry_pick_action_name(requested_action);
     ++	if (require_clean_index(r, requested_action_name,
      +				    _("Please commit or stash them."), 1, 1))
      +		return -1;
       	if (mkdir(git_path_seq_dir(), 0777) < 0)
       		return error_errno(_("could not create sequencer directory '%s'"),
       				   git_path_seq_dir());
     -@@ sequencer.c: static int single_pick(struct repository *r,
     - }
     - 
     - int sequencer_pick_revisions(struct repository *r,
     --			     struct replay_opts *opts)
     -+			     struct replay_opts *opts,
     -+			     const char *action)
     - {
     - 	struct todo_list todo_list = TODO_LIST_INIT;
     - 	struct object_id oid;
      @@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
       
       	/*
     @@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
      +	 * first, make sure that the index is clean and that
      +	 * an existing one isn't in progress.
       	 */
     - 
     +-
       	if (walk_revs_populate_todo(&todo_list, opts) ||
      -			create_seq_dir(r) < 0)
     -+			create_seq_dir(r, action) < 0)
     ++			create_seq_dir(r, opts->action) < 0)
       		return -1;
       	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT))
       		return error(_("can't revert as initial commit"));
      
     - ## sequencer.h ##
     -@@ sequencer.h: void todo_list_filter_update_refs(struct repository *r,
     - /* Call this to setup defaults before parsing command line options */
     - void sequencer_init_config(struct replay_opts *opts);
     - int sequencer_pick_revisions(struct repository *repo,
     --			     struct replay_opts *opts);
     -+			     struct replay_opts *opts,
     -+			     const char *action);
     - int sequencer_continue(struct repository *repo, struct replay_opts *opts);
     - int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
     - int sequencer_skip(struct repository *repo, struct replay_opts *opts);
     -
       ## t/t3510-cherry-pick-sequence.sh ##
      @@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'cherry-pick persists data on failure' '
       	test_path_is_file .git/sequencer/opts
     @@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'cherry-pick persists data
       test_expect_success 'cherry-pick mid-cherry-pick-sequence' '
       	pristine_detach initial &&
       	test_must_fail git cherry-pick base..anotherpick &&
     +
     + ## wt-status.c ##
     +@@ wt-status.c: int has_uncommitted_changes(struct repository *r,
     + 	return result;
     + }
     + 
     +-/**
     +- * If the work tree has unstaged or uncommitted changes, dies with the
     +- * appropriate message.
     +- */
     +-int require_clean_work_tree(struct repository *r,
     +-			    const char *action,
     +-			    const char *hint,
     +-			    int ignore_submodules,
     +-			    int gently)
     ++static int require_clean_index_or_work_tree(struct repository *r,
     ++				     const char *action,
     ++				     const char *hint,
     ++				     int ignore_submodules,
     ++				     int check_index_only,
     ++				     int gently)
     + {
     + 	struct lock_file lock_file = LOCK_INIT;
     + 	int err = 0, fd;
     +@@ wt-status.c: int require_clean_work_tree(struct repository *r,
     + 		repo_update_index_if_able(r, &lock_file);
     + 	rollback_lock_file(&lock_file);
     + 
     +-	if (has_unstaged_changes(r, ignore_submodules)) {
     +-		/* TRANSLATORS: the action is e.g. "pull with rebase" */
     +-		error(_("cannot %s: You have unstaged changes."), _(action));
     +-		err = 1;
     ++	if (!check_index_only) {
     ++		if (has_unstaged_changes(r, ignore_submodules)) {
     ++			/* TRANSLATORS: the action is e.g. "pull with rebase" */
     ++			error(_("cannot %s: You have unstaged changes."), _(action));
     ++			err = 1;
     ++		}
     + 	}
     + 
     + 	if (has_uncommitted_changes(r, ignore_submodules)) {
     +@@ wt-status.c: int require_clean_work_tree(struct repository *r,
     + 
     + 	return err;
     + }
     ++
     ++/**
     ++ * If the work tree has unstaged or uncommitted changes, dies with the
     ++ * appropriate message.
     ++ */
     ++int require_clean_work_tree(struct repository *r,
     ++			    const char *action,
     ++			    const char *hint,
     ++			    int ignore_submodules,
     ++			    int gently)
     ++{
     ++	return require_clean_index_or_work_tree(r,
     ++						action,
     ++						hint,
     ++						ignore_submodules,
     ++						0,
     ++						gently);
     ++}
     ++
     ++/**
     ++ * If the work tree has uncommitted changes, dies with the appropriate
     ++ * message.
     ++ */
     ++int require_clean_index(struct repository *r,
     ++			const char *action,
     ++			const char *hint,
     ++			int ignore_submodules,
     ++			int gently)
     ++{
     ++	return require_clean_index_or_work_tree(r,
     ++						action,
     ++						hint,
     ++						ignore_submodules,
     ++						1,
     ++						gently);
     ++}
     +
     + ## wt-status.h ##
     +@@ wt-status.h: int require_clean_work_tree(struct repository *repo,
     + 			    const char *hint,
     + 			    int ignore_submodules,
     + 			    int gently);
     ++int require_clean_index(struct repository *repo,
     ++			    const char *action,
     ++			    const char *hint,
     ++			    int ignore_submodules,
     ++			    int gently);
     + 
     + #endif /* STATUS_H */


 sequencer.c                     | 53 ++++++++++++++++------------
 t/t3510-cherry-pick-sequence.sh | 10 ++++++
 wt-status.c                     | 61 ++++++++++++++++++++++++++-------
 wt-status.h                     |  5 +++
 4 files changed, 94 insertions(+), 35 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b553b49fbb6..ea1c34045d3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3162,38 +3162,48 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	return 0;
 }
 
-static int create_seq_dir(struct repository *r)
+static const char *cherry_pick_action_name(enum replay_action action) {
+	switch (action) {
+	case REPLAY_REVERT:
+		return "revert";
+		break;
+	case REPLAY_PICK:
+		return "cherry-pick";
+		break;
+	default:
+		BUG("unexpected action in cherry_pick_action_name");
+	}
+}
+
+static int create_seq_dir(struct repository *r, enum replay_action requested_action)
 {
-	enum replay_action action;
+	enum replay_action in_progress_action;
+	const char *in_progress_action_name = NULL;
 	const char *in_progress_error = NULL;
 	const char *in_progress_advice = NULL;
+	const char *requested_action_name = NULL;
 	unsigned int advise_skip =
 		refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") ||
 		refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD");
 
-	if (!sequencer_get_last_command(r, &action)) {
-		switch (action) {
-		case REPLAY_REVERT:
-			in_progress_error = _("revert is already in progress");
-			in_progress_advice =
-			_("try \"git revert (--continue | %s--abort | --quit)\"");
-			break;
-		case REPLAY_PICK:
-			in_progress_error = _("cherry-pick is already in progress");
-			in_progress_advice =
-			_("try \"git cherry-pick (--continue | %s--abort | --quit)\"");
-			break;
-		default:
-			BUG("unexpected action in create_seq_dir");
-		}
+	if (!sequencer_get_last_command(r, &in_progress_action)) {
+		in_progress_action_name = cherry_pick_action_name(in_progress_action);
+		in_progress_error = _("%s is already in progress");
+		in_progress_advice =
+		_("try \"git %s (--continue | %s--abort | --quit)\"");
 	}
 	if (in_progress_error) {
-		error("%s", in_progress_error);
+		error(in_progress_error, in_progress_action_name);
 		if (advice_enabled(ADVICE_SEQUENCER_IN_USE))
 			advise(in_progress_advice,
+				in_progress_action_name,
 				advise_skip ? "--skip | " : "");
 		return -1;
 	}
+	requested_action_name = cherry_pick_action_name(requested_action);
+	if (require_clean_index(r, requested_action_name,
+				    _("Please commit or stash them."), 1, 1))
+		return -1;
 	if (mkdir(git_path_seq_dir(), 0777) < 0)
 		return error_errno(_("could not create sequencer directory '%s'"),
 				   git_path_seq_dir());
@@ -5223,12 +5233,11 @@ int sequencer_pick_revisions(struct repository *r,
 
 	/*
 	 * Start a new cherry-pick/ revert sequence; but
-	 * first, make sure that an existing one isn't in
-	 * progress
+	 * first, make sure that the index is clean and that
+	 * an existing one isn't in progress.
 	 */
-
 	if (walk_revs_populate_todo(&todo_list, opts) ||
-			create_seq_dir(r) < 0)
+			create_seq_dir(r, opts->action) < 0)
 		return -1;
 	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT))
 		return error(_("can't revert as initial commit"));
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3b0fa66c33d..e8f4138bf89 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -47,6 +47,16 @@ test_expect_success 'cherry-pick persists data on failure' '
 	test_path_is_file .git/sequencer/opts
 '
 
+test_expect_success 'cherry-pick sequence refuses to run on dirty index' '
+	pristine_detach initial &&
+	touch localindexchange &&
+	git add localindexchange &&
+	echo picking &&
+	test_must_fail git cherry-pick initial..picked &&
+	test_path_is_missing .git/sequencer &&
+	test_must_fail git cherry-pick --abort
+'
+
 test_expect_success 'cherry-pick mid-cherry-pick-sequence' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&
diff --git a/wt-status.c b/wt-status.c
index 068b76ef6d9..e6ecb3fa606 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2616,15 +2616,12 @@ int has_uncommitted_changes(struct repository *r,
 	return result;
 }
 
-/**
- * If the work tree has unstaged or uncommitted changes, dies with the
- * appropriate message.
- */
-int require_clean_work_tree(struct repository *r,
-			    const char *action,
-			    const char *hint,
-			    int ignore_submodules,
-			    int gently)
+static int require_clean_index_or_work_tree(struct repository *r,
+				     const char *action,
+				     const char *hint,
+				     int ignore_submodules,
+				     int check_index_only,
+				     int gently)
 {
 	struct lock_file lock_file = LOCK_INIT;
 	int err = 0, fd;
@@ -2635,10 +2632,12 @@ int require_clean_work_tree(struct repository *r,
 		repo_update_index_if_able(r, &lock_file);
 	rollback_lock_file(&lock_file);
 
-	if (has_unstaged_changes(r, ignore_submodules)) {
-		/* TRANSLATORS: the action is e.g. "pull with rebase" */
-		error(_("cannot %s: You have unstaged changes."), _(action));
-		err = 1;
+	if (!check_index_only) {
+		if (has_unstaged_changes(r, ignore_submodules)) {
+			/* TRANSLATORS: the action is e.g. "pull with rebase" */
+			error(_("cannot %s: You have unstaged changes."), _(action));
+			err = 1;
+		}
 	}
 
 	if (has_uncommitted_changes(r, ignore_submodules)) {
@@ -2659,3 +2658,39 @@ int require_clean_work_tree(struct repository *r,
 
 	return err;
 }
+
+/**
+ * If the work tree has unstaged or uncommitted changes, dies with the
+ * appropriate message.
+ */
+int require_clean_work_tree(struct repository *r,
+			    const char *action,
+			    const char *hint,
+			    int ignore_submodules,
+			    int gently)
+{
+	return require_clean_index_or_work_tree(r,
+						action,
+						hint,
+						ignore_submodules,
+						0,
+						gently);
+}
+
+/**
+ * If the work tree has uncommitted changes, dies with the appropriate
+ * message.
+ */
+int require_clean_index(struct repository *r,
+			const char *action,
+			const char *hint,
+			int ignore_submodules,
+			int gently)
+{
+	return require_clean_index_or_work_tree(r,
+						action,
+						hint,
+						ignore_submodules,
+						1,
+						gently);
+}
diff --git a/wt-status.h b/wt-status.h
index ab9cc9d8f03..9f424d7c16c 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -181,5 +181,10 @@ int require_clean_work_tree(struct repository *repo,
 			    const char *hint,
 			    int ignore_submodules,
 			    int gently);
+int require_clean_index(struct repository *repo,
+			    const char *action,
+			    const char *hint,
+			    int ignore_submodules,
+			    int gently);
 
 #endif /* STATUS_H */

base-commit: 4a714b37029a4b63dbd22f7d7ed81f7a0d693680
-- 
gitgitgadget
