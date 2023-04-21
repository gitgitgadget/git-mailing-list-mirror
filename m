Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1362C77B7D
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjDUO6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjDUO6B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 10:58:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D89A118C9
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:57:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2fa47de5b04so1790568f8f.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682089077; x=1684681077;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnH233iOb15vAKvo5GfLFnOU+j0e+Tx6pU5LGae1FJ0=;
        b=Vl3h+CygRk7tzrnoIc22coSYRJNAiWGwxuMfWaHnMm2CGQUxiGOLBiirMKxj5z967O
         DHrbhNX0koQ94dP4JwzQbJpRZwzLUtCRF/hE/tSxcTWPNK7kze5FJeEoeYwxUtY2zffx
         pgzGUGYiPPMoQaB7/hoeTzTSmp5BqWB0IOio59xXcYaOWh9auivdt7feSeMXG0n3MUvJ
         4oxVJHE77hkn/6h0qeQaAbVcuHaD/HphohS5tzoC/1Enw7BKTOR6AZBNXuvMVz3sw7Hp
         wQu1Pvy/kQ9qNMImm09ylKb6UMbm6QkS/faUezaZfNjJ3F6mjixhgDQxT59r3IdUczhA
         fE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089077; x=1684681077;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnH233iOb15vAKvo5GfLFnOU+j0e+Tx6pU5LGae1FJ0=;
        b=HFLL0vVA8t3a91S5gmRNFIt5jU6JWIEC4mhNjacMTZCQ87r1r7XiLWH4gURD3L1JWL
         EJnNZnWZMXoLIMxE3wBF1FXG+u26f+ANcSazcsoEJlOTXM4qJ4hyX9Ll4ne0vY/xvEf2
         MsIPRoBRzH9DMadi0GFYeglkyWQX/OCqfZSaqn1SExP2ge8O8l7+/RqqY8wGH+kQadTc
         cN/oeczr+LF9O8WgKBBb0Gp964K3gD36dSQ3OtllWJP5asEe0gza8g9e4tnFPXDKJ6kJ
         X44yV3oFxUFsx9a+CHzpY+KAREuIOmtKUb59iKBa7kQ6RNkRKG3FR+319xw8wNluZU1a
         AXJA==
X-Gm-Message-State: AAQBX9fVKDSwXTkl4/AaxV+K9PWoQpC487giGL2PaRJWxappRVwaG/9u
        H91MZtdgN2TUPuJ5ZqXGBibo0hf0hNE=
X-Google-Smtp-Source: AKy350aIMNJaIWc0bBfG81XkHd/FLIULIa28lEKBe40Y1Qs5HunsIo2NUAfKBYrnwPMtzuOPw/wZ4g==
X-Received: by 2002:adf:f24b:0:b0:2ff:f37:9d0e with SMTP id b11-20020adff24b000000b002ff0f379d0emr3870212wrp.61.1682089076644;
        Fri, 21 Apr 2023 07:57:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d6910000000b002efdf3e5be0sm4593719wru.44.2023.04.21.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:57:56 -0700 (PDT)
Message-Id: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 14:57:48 +0000
Subject: [PATCH v2 0/6] rebase -i: impove handling of failed commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
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

Phillip Wood (6):
  rebase -i: move unlink() calls
  rebase -i: remove patch file after conflict resolution
  sequencer: factor out part of pick_commits()
  rebase --continue: refuse to commit after failed command
  rebase: fix rewritten list for failed pick
  rebase -i: fix adding failed command to the todo list

 sequencer.c                   | 170 ++++++++++++++++++----------------
 t/t3404-rebase-interactive.sh |  49 +++++++---
 t/t3430-rebase-merges.sh      |  35 +++++--
 t/t5407-post-rewrite-hook.sh  |  11 +++
 4 files changed, 165 insertions(+), 100 deletions(-)


base-commit: 9c6990cca24301ae8f82bf6291049667a0aef14b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1492%2Fphillipwood%2Frebase-dont-write-done-when-rescheduling-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1492/phillipwood/rebase-dont-write-done-when-rescheduling-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1492

Range-diff vs v1:

 -:  ----------- > 1:  3dfb2c6903b rebase -i: move unlink() calls
 -:  ----------- > 2:  227aea031b5 rebase -i: remove patch file after conflict resolution
 -:  ----------- > 3:  31bb644e769 sequencer: factor out part of pick_commits()
 -:  ----------- > 4:  9356d14b09a rebase --continue: refuse to commit after failed command
 -:  ----------- > 5:  f8e64c1b631 rebase: fix rewritten list for failed pick
 1:  dc51a7499bc ! 6:  a836b049b90 rebase -i: do not update "done" when rescheduling command
     @@ Metadata
      Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Commit message ##
     -    rebase -i: do not update "done" when rescheduling command
     +    rebase -i: fix adding failed command to the todo list
      
     -    As the sequencer executes todo commands it appends them to
     -    .git/rebase-merge/done. This file is used by "git status" to show the
     -    recently executed commands. Unfortunately when a command is rescheduled
     +    When rebasing commands are moved from the todo list in "git-rebase-todo"
     +    to the "done" file (which is used by "git status" to show the recently
     +    executed commands) just before they are executed. This means that if a
     +    command fails because it would overwrite an untracked file it has to be
     +    added back into the todo list before the rebase stops for the user to
     +    fix the problem.
     +
     +    Unfortunately when a failed command is added back into the todo list
          the command preceding it is erroneously appended to the "done" file.
     -    This means that when rebase stops after rescheduling "pick B" the "done"
     +    This means that when rebase stops after "pick B" fails the "done"
          file contains
      
                  pick A
     @@ Commit message
                  pick A
                  pick B
      
     -    Fix this by not updating the "done" file when adding a rescheduled
     -    command back into the "todo" file. A couple of the existing tests are
     +    Fix this by not updating the "done" file when adding a failed command
     +    back into the "git-rebase-todo" file. A couple of the existing tests are
          modified to improve their coverage as none of them trigger this bug or
          check the "done" file.
      
     -    Note that the rescheduled command will still be appended to the "done"
     -    file again when it is successfully executed. Arguably it would be better
     -    not to do that but fixing it would be more involved.
     -
          Reported-by: Stefan Haller <lists@haller-berlin.de>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ sequencer.c: static int pick_commits(struct repository *r,
       		int check_todo = 0;
       
      -		if (save_todo(todo_list, opts))
     -+		if (save_todo(todo_list, opts, 0))
     ++		if (save_todo(todo_list, opts, reschedule))
       			return -1;
       		if (is_rebase_i(opts)) {
       			if (item->command != TODO_COMMENT) {
     -@@ sequencer.c: static int pick_commits(struct repository *r,
     - 							    todo_list->current),
     - 				       get_item_line(todo_list,
     - 						     todo_list->current));
     --				todo_list->current--;
     --				if (save_todo(todo_list, opts))
     -+				if (save_todo(todo_list, opts, 1))
     - 					return -1;
     - 			}
     - 			if (item->command == TODO_EDIT) {
      @@ sequencer.c: static int pick_commits(struct repository *r,
       			       get_item_line_length(todo_list,
       						    todo_list->current),
       			       get_item_line(todo_list, todo_list->current));
      -			todo_list->current--;
      -			if (save_todo(todo_list, opts))
     -+			if (save_todo(todo_list, opts, 1))
     ++			if (save_todo(todo_list, opts, reschedule))
       				return -1;
       			if (item->commit)
     - 				return error_with_patch(r,
     + 				write_rebase_head(&item->commit->object.oid);
      
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'todo count' '
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'todo count' '
      +	head -n3 todo >expect &&
      +	test_cmp expect .git/rebase-merge/done &&
      +	rm file2 &&
     + 	test_path_is_missing .git/rebase-merge/author-script &&
     + 	test_path_is_missing .git/rebase-merge/patch &&
     + 	test_path_is_missing .git/MERGE_MSG &&
     +@@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
     + 	grep "error: you have staged changes in your working tree" err &&
     + 	git reset --hard HEAD &&
       	git rebase --continue &&
      -	test_cmp_rev HEAD I
      +	test_cmp_rev HEAD D &&

-- 
gitgitgadget
