Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB64FC001DF
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 15:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjHAPXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjHAPXn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 11:23:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D942107
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 08:23:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso26022915e9.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690903415; x=1691508215;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ULhGv1ALF+TVaS25FAi0R7mDKXH6HYAor5EiHPyrQk=;
        b=GN0b7ECZDr6m/w2d21xBE3N69BHAeMvm1lYWs1IZDQy9xpYQSAvVuCfsilPGZf2JAL
         grAopYdo/K9XhbNjp9nQGA428mbVpb3i3S0JhhgEv2GWwlyg2kAkDlY/l4EzyWl4cVWZ
         XXCAkYkCKlvQo2sxtiyBFqDLeuRGgNZQJ08QvA5e+WFTNJkWI5DCFpMdtVFZQPdZdmIM
         K2yjWOCR6gRhlmdYofjKAuZ7XojSW1Lf0jLUxMoLk9RbwzbyeNYraPueU0em7jbmQGWK
         tcz3hlqwwuO0uRSQwxMu2Bu5wNzaI+gkwRnyvo81gtb7BCv9cONNkZG4WYQhg4/sepCO
         UIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690903415; x=1691508215;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ULhGv1ALF+TVaS25FAi0R7mDKXH6HYAor5EiHPyrQk=;
        b=bpQNVQcD5JocYn82IEI8f0aTv8MwdUWOItpkOIpc9kG0QB2MUoCABXQaBWhYwGvHvP
         D6LjDBGS6WV7L1+aCF3e9Fn19FrZN6oH3PhYwtzeIixn/kXoTOodLta89xeHVn2MLSVb
         fVQlOeiq5ekl9mZEM6z2Fk2RGvMIqsf2tdtT3Y0uqpUS8IDZFdc3lrDPhAwrof4EUE77
         aho1UK3JKOHgbH/1LNf77C2iJYUoAg2cH62r1Wtz/EmHf1U85Cf5prqbH8iAmCaP1cwS
         VMQphqIjT3jMpljwRQuwUgpw5eSJ2/PxMBwtqaJ/Ypap8GZD10amSVA55s9iXS15pHZ7
         cNVQ==
X-Gm-Message-State: ABy/qLZyam5JX9d00p2q5MkU6V6NusrCmmk8vKtITIn1SZtqdAxvpdU8
        Do6StfjHifzLgf6v3ZJpHx9vKcbkqMA=
X-Google-Smtp-Source: APBJJlGKJzwwjzsonoShYn7nQRIfAnvjxDEJIaEYQ+rWtiuJer0x4qn3OBMqHxKrEuBtTyd02x3E4w==
X-Received: by 2002:a05:600c:257:b0:3fe:2120:a87a with SMTP id 23-20020a05600c025700b003fe2120a87amr2734857wmj.37.1690903414610;
        Tue, 01 Aug 2023 08:23:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f25-20020a1c6a19000000b003fe24da493dsm3978896wmc.41.2023.08.01.08.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:23:34 -0700 (PDT)
Message-ID: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Aug 2023 15:23:25 +0000
Subject: [PATCH v3 0/7] rebase -i: impove handling of failed commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes several bugs in the way we handle a commit cannot be
picked because it would overwrite an untracked file.

 * after a failed pick "git rebase --continue" will happily commit any
   staged changes even though no commit was picked.

 * the commit of the failed pick is recorded as rewritten even though no
   commit was picked.

 * the "done" file used by "git status" to show the recently executed
   commands contains an incorrect entry.

Thanks to Eric, Glen and Junio for their comments on v2. Here are the
changes since v2:

Patch 1 - Reworded the commit message.

Patch 2 - Reworded the commit message, added a test and fixed error message
pointed out by Glen.

Patch 3 - New cleanup.

Patch 4 - Reworded the commit message, now only increments
todo_list->current if there is no error.

Patch 5 - Swapped with next patch. Reworded the commit message, stopped
testing implementation (suggested by Glen). Expanded post-rewrite hook test.

Patch 6 - Reworded the commit message, now uses the message file rather than
the author script to check if "rebase --continue" should commit staged
changes. Junio suggested using a separate file for this but I think that
would end up being more involved as we'd need to be careful about creating
and removing it.

Patch 7 - Reworded the commit message.

Thanks for the comments on V1, this series has now grown somewhat.
Previously I was worried that refactoring would change the behavior, but
having thought about it the current behavior is wrong and should be changed.

Changes since V1:

Rebased onto master to avoid a conflict with
ab/remove-implicit-use-of-the-repository

 * Patches 1-3 are new preparatory changes
 * Patches 4 & 5 are new and fix the first two issues listed above.
 * Patch 6 is the old patch 1 which has been rebased and the commit message
   reworded. It fixes the last issues listed above.

Phillip Wood (7):
  rebase -i: move unlink() calls
  rebase -i: remove patch file after conflict resolution
  sequencer: use rebase_path_message()
  sequencer: factor out part of pick_commits()
  rebase: fix rewritten list for failed pick
  rebase --continue: refuse to commit after failed command
  rebase -i: fix adding failed command to the todo list

 sequencer.c                   | 179 ++++++++++++++++++----------------
 t/t3404-rebase-interactive.sh |  53 +++++++---
 t/t3418-rebase-continue.sh    |  18 ++++
 t/t3430-rebase-merges.sh      |  30 ++++--
 t/t5407-post-rewrite-hook.sh  |  48 +++++++++
 5 files changed, 225 insertions(+), 103 deletions(-)


base-commit: a80be152923a46f04a06bade7bcc72870e46ca09
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1492%2Fphillipwood%2Frebase-dont-write-done-when-rescheduling-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1492/phillipwood/rebase-dont-write-done-when-rescheduling-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1492

Range-diff vs v2:

 1:  3dfb2c6903b ! 1:  1ab1ad2ef07 rebase -i: move unlink() calls
     @@ Commit message
      
          At the start of each iteration the loop that picks commits removes
          state files from the previous pick. However some of these are only
     -    written if there are conflicts so only need to be removed before
     -    starting the loop, not in each iteration.
     +    written if there are conflicts and so we break out of the loop after
     +    writing them. Therefore they only need to be removed when the rebase
     +    continues, not in each iteration.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
 2:  227aea031b5 ! 2:  e2a758eb4a5 rebase -i: remove patch file after conflict resolution
     @@ Metadata
       ## Commit message ##
          rebase -i: remove patch file after conflict resolution
      
     -    When rebase stops for the user to resolve conflicts it writes a patch
     -    for the conflicting commit to .git/rebase-merge/patch. This file
     -    should be deleted when the rebase continues. As the path is now used
     -    in two different places rebase_path_patch() is added and used to
     -    obtain the path for the patch.
     +    When a rebase stops for the user to resolve conflicts it writes a patch
     +    for the conflicting commit to .git/rebase-merge/patch. This file has
     +    been written since the introduction of "git-rebase-interactive.sh" in
     +    1b1dce4bae7 (Teach rebase an interactive mode, 2007-06-25). I assume the
     +    idea was to enable the user inspect the conflicting commit in the same
     +    way as they could for the patch based rebase. This file should be
     +    deleted when the rebase continues as if the rebase stops for a failed
     +    "exec" command or a "break" command it is confusing to the user if there
     +    is a stale patch lying around from an unrelated command. As the path is
     +    now used in two different places rebase_path_patch() is added and used
     +    to obtain the path for the patch.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ sequencer.c: static int make_patch(struct repository *r,
      +	log_tree_opt.diffopt.file = fopen(rebase_path_patch(), "w");
       	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
       	if (!log_tree_opt.diffopt.file)
     - 		res |= error_errno(_("could not open '%s'"), buf.buf);
     +-		res |= error_errno(_("could not open '%s'"), buf.buf);
     ++		res |= error_errno(_("could not open '%s'"),
     ++				   rebase_path_patch());
     + 	else {
     + 		res |= log_tree_commit(&log_tree_opt, commit);
     + 		fclose(log_tree_opt.diffopt.file);
     + 	}
     +-	strbuf_reset(&buf);
     + 
     + 	strbuf_addf(&buf, "%s/message", get_dir(opts));
     + 	if (!file_exists(buf.buf)) {
      @@ sequencer.c: static int pick_commits(struct repository *r,
       	unlink(rebase_path_message());
       	unlink(rebase_path_stopped_sha());
     @@ sequencer.c: static int pick_commits(struct repository *r,
       
       	while (todo_list->current < todo_list->nr) {
       		struct todo_item *item = todo_list->items + todo_list->current;
     +
     + ## t/t3418-rebase-continue.sh ##
     +@@ t/t3418-rebase-continue.sh: test_expect_success 'the todo command "break" works' '
     + 	test_path_is_file execed
     + '
     + 
     ++test_expect_success 'patch file is removed before break command' '
     ++	test_when_finished "git rebase --abort" &&
     ++	cat >todo <<-\EOF &&
     ++	pick commit-new-file-F2-on-topic-branch
     ++	break
     ++	EOF
     ++
     ++	(
     ++		set_replace_editor todo &&
     ++		test_must_fail git rebase -i --onto commit-new-file-F2 HEAD
     ++	) &&
     ++	test_path_is_file .git/rebase-merge/patch &&
     ++	echo 22>F2 &&
     ++	git add F2 &&
     ++	git rebase --continue &&
     ++	test_path_is_missing .git/rebase-merge/patch
     ++'
     ++
     + test_expect_success '--reschedule-failed-exec' '
     + 	test_when_finished "git rebase --abort" &&
     + 	test_must_fail git rebase -x false --reschedule-failed-exec HEAD^ &&
 -:  ----------- > 3:  8f6c0e40567 sequencer: use rebase_path_message()
 3:  31bb644e769 ! 4:  a1fad70f4b9 sequencer: factor out part of pick_commits()
     @@ Metadata
       ## Commit message ##
          sequencer: factor out part of pick_commits()
      
     -    This is simplifies a change in a later commit. If a pick fails we now
     -    return the error at then end of the loop body rather than returning
     -    early but there is no change in behavior.
     +    This simplifies the next commit. If a pick fails we now return the error
     +    at the end of the loop body rather than returning early, a successful
     +    "edit" command continues to return early. There are three things to
     +    check to ensure that removing the early return for an error does not
     +    change the behavior of the code:
     +
     +    (1) We could enter the block guarded by "if (reschedule)". This block
     +        is not entered because "reschedlue" is always zero when picking a
     +        commit.
     +
     +    (2) We could enter the block guarded by
     +        "else if (is_rebase_i(opts) &&  check_todo && !res)". This block is
     +        not entered when returning an error because "res" is non-zero in
     +        that case.
     +
     +    (3) todo_list->current could be incremented before returning. That is
     +        avoided by moving the increment which is of course a potential
     +        change in behavior itself. The move is safe because none of the
     +        callers look at todo_list after this function returns. Moving the
     +        increment makes it clear we only want to advance the current item
     +        if the command was successful.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ sequencer.c: static int pick_commits(struct repository *r,
       		} else if (item->command == TODO_EXEC) {
       			char *end_of_arg = (char *)(arg + item->arg_len);
       			int saved = *end_of_arg;
     +@@ sequencer.c: static int pick_commits(struct repository *r,
     + 			return -1;
     + 		}
     + 
     +-		todo_list->current++;
     + 		if (res)
     + 			return res;
     ++
     ++		todo_list->current++;
     + 	}
     + 
     + 	if (is_rebase_i(opts)) {
 5:  f8e64c1b631 ! 5:  df401945866 rebase: fix rewritten list for failed pick
     @@ Metadata
       ## Commit message ##
          rebase: fix rewritten list for failed pick
      
     -    When rebasing commands are moved from the todo list in "git-rebase-todo"
     -    to the "done" file just before they are executed. This means that if a
     -    command fails because it would overwrite an untracked file it has to be
     -    added back into the todo list before the rebase stops for the user to
     -    fix the problem. Unfortunately the way this is done results in the
     -    failed pick being recorded as rewritten.
     +    git rebase keeps a list that maps the OID of each commit before it was
     +    rebased to the OID of the equivalent commit after the rebase.  This list
     +    is used to drive the "post-rewrite" hook that is called at the end of a
     +    successful rebase. When a rebase stops for the user to resolve merge
     +    conflicts the OID of the commit being picked is written to
     +    ".git/rebase-merge/stopped-sha". Then when the rebase is continued that
     +    OID is added to the list of rewritten commits. Unfortunately if a commit
     +    cannot be picked because it would overwrite an untracked file we still
     +    write the "stopped-sha1" file. This means that when the rebase is
     +    continued the commit is added into the list of rewritten commits even
     +    though it has not been picked yet.
      
          Fix this by not calling error_with_patch() for failed commands. The pick
          has failed so there is nothing to commit and therefore we do not want to
     -    set up the message file for committing staged changes when the rebase
     +    set up the state files for committing staged changes when the rebase
          continues. This change means we no-longer write a patch for the failed
          command or display the error message printed by error_with_patch(). As
     -    the command has failed the patch isn't really useful in that case and
     -    REBASE_HEAD is still written so the user can inspect the commit
     -    associated with the failed command. Unless the user has disabled it we
     -    print an advice message that is more helpful than the message from
     -    error_with_patch(). If the advice is disabled the user will still see
     -    the messages from the merge machinery detailing the problem.
     +    the command has failed the patch isn't really useful and in any case the
     +    user can inspect the commit associated with the failed command by
     +    inspecting REBASE_HEAD. Unless the user has disabled it we already print
     +    an advice message that is more helpful than the message from
     +    error_with_patch() which the user will still see. Even if the advice is
     +    disabled the user will see the messages from the merge machinery
     +    detailing the problem.
      
          To simplify writing REBASE_HEAD in this case pick_one_commit() is
     -    modified to avoid duplicating the code that adds the failed command back
     -    into the todo list.
     +    modified to avoid duplicating the code that adds the failed command
     +    back into the todo list.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## sequencer.c ##
      @@ sequencer.c: static int do_merge(struct repository *r,
     + 	if (ret < 0) {
       		error(_("could not even attempt to merge '%.*s'"),
       		      merge_arg_len, arg);
     - 		unlink(rebase_path_author_script());
      +		unlink(git_path_merge_msg(r));
       		goto leave_merge;
       	}
     @@ sequencer.c: static int pick_commits(struct repository *r,
      
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
     + 	>file6 &&
     + 	test_must_fail git rebase --continue &&
       	test_cmp_rev HEAD F &&
     ++	test_cmp_rev REBASE_HEAD I &&
       	rm file6 &&
     - 	test_path_is_missing .git/rebase-merge/author-script &&
      +	test_path_is_missing .git/rebase-merge/patch &&
     -+	test_path_is_missing .git/MERGE_MSG &&
     -+	test_path_is_missing .git/rebase-merge/message &&
     -+	test_path_is_missing .git/rebase-merge/stopped-sha &&
     - 	echo changed >file1 &&
     - 	git add file1 &&
     - 	test_must_fail git rebase --continue 2>err &&
     + 	git rebase --continue &&
     + 	test_cmp_rev HEAD I
     + '
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
     + 	>file6 &&
     + 	test_must_fail git rebase --continue &&
       	test_cmp_rev HEAD F &&
     ++	test_cmp_rev REBASE_HEAD I &&
       	rm file6 &&
     - 	test_path_is_missing .git/rebase-merge/author-script &&
      +	test_path_is_missing .git/rebase-merge/patch &&
     -+	test_path_is_missing .git/MERGE_MSG &&
     -+	test_path_is_missing .git/rebase-merge/message &&
     -+	test_path_is_missing .git/rebase-merge/stopped-sha &&
       	git rebase --continue &&
       	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
       	git reset --hard original-branch2
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
     + 	>file6 &&
     + 	test_must_fail git rebase --continue &&
       	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
     ++	test_cmp_rev REBASE_HEAD I &&
       	rm file6 &&
     - 	test_path_is_missing .git/rebase-merge/author-script &&
      +	test_path_is_missing .git/rebase-merge/patch &&
     -+	test_path_is_missing .git/MERGE_MSG &&
     -+	test_path_is_missing .git/rebase-merge/message &&
     -+	test_path_is_missing .git/rebase-merge/stopped-sha &&
       	git rebase --continue &&
       	test $(git cat-file commit HEAD | sed -ne \$p) = I
       '
      
       ## t/t3430-rebase-merges.sh ##
      @@ t/t3430-rebase-merges.sh: test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
     + 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
     + 	test_tick &&
       	test_must_fail git rebase -ir HEAD &&
     ++	test_cmp_rev REBASE_HEAD H^0 &&
       	grep "^merge -C .* G$" .git/rebase-merge/done &&
       	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
      -	test_path_is_file .git/rebase-merge/patch &&
      +	test_path_is_missing .git/rebase-merge/patch &&
     - 	test_path_is_missing .git/rebase-merge/author-script &&
     -+	test_path_is_missing .git/MERGE_MSG &&
     -+	test_path_is_missing .git/rebase-merge/message &&
     -+	test_path_is_missing .git/rebase-merge/stopped-sha &&
       
       	: fail because of merge conflict &&
      -	rm G.t .git/rebase-merge/patch &&
       	git reset --hard conflicting-G &&
       	test_must_fail git rebase --continue &&
       	! grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
     - 	test_path_is_file .git/rebase-merge/patch &&
     --	test_path_is_file .git/rebase-merge/author-script
     -+	test_path_is_file .git/rebase-merge/author-script &&
     -+	test_path_is_file .git/MERGE_MSG &&
     -+	test_path_is_file .git/rebase-merge/message &&
     -+	test_path_is_file .git/rebase-merge/stopped-sha
     - '
     - 
     - test_expect_success 'failed `merge <branch>` does not crash' '
      
       ## t/t5407-post-rewrite-hook.sh ##
     +@@ t/t5407-post-rewrite-hook.sh: test_expect_success 'setup' '
     + 	git checkout A^0 &&
     + 	test_commit E bar E &&
     + 	test_commit F foo F &&
     ++	git checkout B &&
     ++	git merge E &&
     ++	git tag merge-E &&
     ++	test_commit G G &&
     ++	test_commit H H &&
     ++	test_commit I I &&
     + 	git checkout main &&
     + 
     + 	test_hook --setup post-rewrite <<-EOF
      @@ t/t5407-post-rewrite-hook.sh: test_fail_interactive_rebase () {
       	)
       }
       
      +test_expect_success 'git rebase with failed pick' '
     -+	test_fail_interactive_rebase "exec_>bar pick 1" --onto C A E &&
     ++	clear_hook_input &&
     ++	cat >todo <<-\EOF &&
     ++	exec >bar
     ++	merge -C merge-E E
     ++	exec >G
     ++	pick G
     ++	exec >H 2>I
     ++	pick H
     ++	fixup I
     ++	EOF
     ++
     ++	(
     ++		set_replace_editor todo &&
     ++		test_must_fail git rebase -i D D 2>err
     ++	) &&
     ++	grep "would be overwritten" err &&
      +	rm bar &&
     ++
     ++	test_must_fail git rebase --continue 2>err &&
     ++	grep "would be overwritten" err &&
     ++	rm G &&
     ++
     ++	test_must_fail git rebase --continue 2>err &&
     ++	grep "would be overwritten" err &&
     ++	rm H &&
     ++
     ++	test_must_fail git rebase --continue 2>err &&
     ++	grep "would be overwritten" err &&
     ++	rm I &&
     ++
      +	git rebase --continue &&
      +	echo rebase >expected.args &&
      +	cat >expected.data <<-EOF &&
     -+	$(git rev-parse E) $(git rev-parse HEAD)
     ++	$(git rev-parse merge-E) $(git rev-parse HEAD~2)
     ++	$(git rev-parse G) $(git rev-parse HEAD~1)
     ++	$(git rev-parse H) $(git rev-parse HEAD)
     ++	$(git rev-parse I) $(git rev-parse HEAD)
      +	EOF
      +	verify_hook_input
      +'
 4:  9356d14b09a ! 6:  2ed7cbe5fff rebase --continue: refuse to commit after failed command
     @@ Commit message
      
          If a commit cannot be picked because it would overwrite an untracked
          file then "git rebase --continue" should refuse to commit any staged
     -    changes as the commit was not picked. Do this by using the existing
     -    check for a missing author script in run_git_commit() which prevents
     -    "rebase --continue" from committing staged changes after failed exec
     -    commands.
     +    changes as the commit was not picked. This is implemented by refusing to
     +    commit if the message file is missing. The message file is chosen for
     +    this check because it is only written when "git rebase" stops for the
     +    user to resolve merge conflicts.
      
     -    When fast-forwarding it is not necessary to write the author script as
     -    we're reusing an existing commit, not creating a new one. If a
     -    fast-forwarded commit is modified by an "edit" or "reword" command then
     -    the modification is committed with "git commit --amend" which reuses the
     -    author of the commit being amended so the author script is not needed.
     -    baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when fast-forwarding,
     -    2021-08-20) changed run_git_commit() to allow a missing author script
     -    when rewording a commit. This changes extends that to allow a missing
     -    author script whenever the commit is being amended.
     +    Existing commands that refuse to commit staged changes when continuing
     +    such as a failed "exec" rely on checking for the absence of the author
     +    script in run_git_commit(). This prevents the staged changes from being
     +    committed but prints
      
     -    If we're not fast-forwarding then we must remove the author script if
     -    the pick fails.
     +        error: could not open '.git/rebase-merge/author-script' for
     +        reading
     +
     +    before the message about not being able to commit. This is confusing to
     +    users and so checking for the message file instead improves the user
     +    experience. The existing test for refusing to commit after a failed exec
     +    is updated to check that we do not print the error message about a
     +    missing author script anymore.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## sequencer.c ##
     -@@ sequencer.c: static int run_git_commit(const char *defmsg,
     +@@ sequencer.c: static int commit_staged_changes(struct repository *r,
       
     - 	if (is_rebase_i(opts) &&
     - 	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
     --	     !(!defmsg && (flags & AMEND_MSG))) &&
     -+	     !(flags & AMEND_MSG)) &&
     - 	    read_env_script(&cmd.env)) {
     - 		const char *gpg_opt = gpg_sign_opt_quoted(opts);
     + 	is_clean = !has_uncommitted_changes(r, 0);
       
     -@@ sequencer.c: static int do_pick_commit(struct repository *r,
     - 	if (opts->allow_ff && !is_fixup(command) &&
     - 	    ((parent && oideq(&parent->object.oid, &head)) ||
     - 	     (!parent && unborn))) {
     --		if (is_rebase_i(opts))
     --			write_author_script(msg.message);
     - 		res = fast_forward_to(r, &commit->object.oid, &head, unborn,
     - 			opts);
     - 		if (res || command != TODO_REWORD)
     -@@ sequencer.c: static int do_pick_commit(struct repository *r,
     - 		 command == TODO_REVERT) {
     - 		res = do_recursive_merge(r, base, next, base_label, next_label,
     - 					 &head, &msgbuf, opts);
     --		if (res < 0)
     -+		if (res < 0) {
     -+			unlink(rebase_path_author_script());
     - 			goto leave;
     --
     -+		}
     - 		res |= write_message(msgbuf.buf, msgbuf.len,
     - 				     git_path_merge_msg(r), 0);
     - 	} else {
     -@@ sequencer.c: static int do_merge(struct repository *r,
     - 	if (ret < 0) {
     - 		error(_("could not even attempt to merge '%.*s'"),
     - 		      merge_arg_len, arg);
     -+		unlink(rebase_path_author_script());
     - 		goto leave_merge;
     - 	}
     - 	/*
     ++	if (!is_clean && !file_exists(rebase_path_message())) {
     ++		const char *gpg_opt = gpg_sign_opt_quoted(opts);
     ++
     ++		return error(_(staged_changes_advice), gpg_opt, gpg_opt);
     ++	}
     + 	if (file_exists(rebase_path_amend())) {
     + 		struct strbuf rev = STRBUF_INIT;
     + 		struct object_id head, to_amend;
      
       ## t/t3404-rebase-interactive.sh ##
     +@@ t/t3404-rebase-interactive.sh: test_expect_success 'clean error after failed "exec"' '
     + 	echo "edited again" > file7 &&
     + 	git add file7 &&
     + 	test_must_fail git rebase --continue 2>error &&
     +-	test_i18ngrep "you have staged changes in your working tree" error
     ++	test_i18ngrep "you have staged changes in your working tree" error &&
     ++	test_i18ngrep ! "could not open.*for reading" error
     + '
     + 
     + test_expect_success 'rebase a detached HEAD' '
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
     - 	test_must_fail git rebase --continue &&
     - 	test_cmp_rev HEAD F &&
     + 	test_cmp_rev REBASE_HEAD I &&
       	rm file6 &&
     -+	test_path_is_missing .git/rebase-merge/author-script &&
     + 	test_path_is_missing .git/rebase-merge/patch &&
      +	echo changed >file1 &&
      +	git add file1 &&
      +	test_must_fail git rebase --continue 2>err &&
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i commits that overw
       	test_cmp_rev HEAD I
       '
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
     - 	test_must_fail git rebase --continue &&
     - 	test_cmp_rev HEAD F &&
     + 	test_cmp_rev REBASE_HEAD I &&
       	rm file6 &&
     -+	test_path_is_missing .git/rebase-merge/author-script &&
     + 	test_path_is_missing .git/rebase-merge/patch &&
     ++	echo changed >file1 &&
     ++	git add file1 &&
     ++	test_must_fail git rebase --continue 2>err &&
     ++	grep "error: you have staged changes in your working tree" err &&
     ++	git reset --hard HEAD &&
       	git rebase --continue &&
       	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
       	git reset --hard original-branch2
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
     - 	test_must_fail git rebase --continue &&
     - 	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
     + 	test_cmp_rev REBASE_HEAD I &&
       	rm file6 &&
     -+	test_path_is_missing .git/rebase-merge/author-script &&
     + 	test_path_is_missing .git/rebase-merge/patch &&
     ++	echo changed >file1 &&
     ++	git add file1 &&
     ++	test_must_fail git rebase --continue 2>err &&
     ++	grep "error: you have staged changes in your working tree" err &&
     ++	git reset --hard HEAD &&
       	git rebase --continue &&
       	test $(git cat-file commit HEAD | sed -ne \$p) = I
       '
     @@ t/t3430-rebase-merges.sh
      @@ t/t3430-rebase-merges.sh: test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
       	grep "^merge -C .* G$" .git/rebase-merge/done &&
       	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
     - 	test_path_is_file .git/rebase-merge/patch &&
     -+	test_path_is_missing .git/rebase-merge/author-script &&
     + 	test_path_is_missing .git/rebase-merge/patch &&
     ++	echo changed >file1 &&
     ++	git add file1 &&
     ++	test_must_fail git rebase --continue 2>err &&
     ++	grep "error: you have staged changes in your working tree" err &&
       
       	: fail because of merge conflict &&
     - 	rm G.t .git/rebase-merge/patch &&
       	git reset --hard conflicting-G &&
     - 	test_must_fail git rebase --continue &&
     - 	! grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
     --	test_path_is_file .git/rebase-merge/patch
     -+	test_path_is_file .git/rebase-merge/patch &&
     -+	test_path_is_file .git/rebase-merge/author-script
     - '
     - 
     - test_expect_success 'failed `merge <branch>` does not crash' '
 6:  a836b049b90 ! 7:  bbe0afde512 rebase -i: fix adding failed command to the todo list
     @@ Commit message
          added back into the todo list before the rebase stops for the user to
          fix the problem.
      
     -    Unfortunately when a failed command is added back into the todo list
     -    the command preceding it is erroneously appended to the "done" file.
     -    This means that when rebase stops after "pick B" fails the "done"
     -    file contains
     +    Unfortunately when a failed command is added back into the todo list the
     +    command preceding it is erroneously appended to the "done" file.  This
     +    means that when rebase stops after "pick B" fails the "done" file
     +    contains
      
                  pick A
                  pick B
     @@ Commit message
                  pick A
                  pick B
      
     -    Fix this by not updating the "done" file when adding a failed command
     +    This happens because save_todo() updates the "done" file with the
     +    previous command whenever "git-rebase-todo" is updated. When we add the
     +    failed pick back into "git-rebase-todo" we do not want to update
     +    "done". Fix this by adding a "reschedule" parameter to save_todo() which
     +    prevents the "done" file from being updated when adding a failed command
          back into the "git-rebase-todo" file. A couple of the existing tests are
          modified to improve their coverage as none of them trigger this bug or
          check the "done" file.
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'todo count' '
      -	>file6 &&
      -	test_must_fail git rebase --continue &&
      -	test_cmp_rev HEAD F &&
     +-	test_cmp_rev REBASE_HEAD I &&
      -	rm file6 &&
      +	test_cmp_rev HEAD B &&
     ++	test_cmp_rev REBASE_HEAD C &&
      +	head -n3 todo >expect &&
      +	test_cmp expect .git/rebase-merge/done &&
      +	rm file2 &&
     - 	test_path_is_missing .git/rebase-merge/author-script &&
       	test_path_is_missing .git/rebase-merge/patch &&
     - 	test_path_is_missing .git/MERGE_MSG &&
     + 	echo changed >file1 &&
     + 	git add file1 &&
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
       	grep "error: you have staged changes in your working tree" err &&
       	git reset --hard HEAD &&

-- 
gitgitgadget
