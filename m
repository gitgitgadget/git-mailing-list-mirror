Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929FAEE14A8
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 15:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbjIFPXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239669AbjIFPXC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 11:23:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E301738
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 08:22:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50098cc8967so5938647e87.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694013775; x=1694618575; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSjQn7WT6eXQ8nUYAU03PNN8st5l9hFjKNVa6ZDh1YA=;
        b=k9jGXZSnZsBaC+brIUG+Z0RjFMLYxy4FcmJkhbLwUbIanWgYiowEqprBViFfEkMt7F
         vgNg5KiXAMJDNJs4cu5jb0D586Pt4o80/G0riMTp2gvmPPbTgN/ttCT6bGQ4NO5XjKK8
         WH38+uuKVaSPvx1O1CyCErdPpYfA4p5b/w0bDSWS6sbgm1h+U4qUccZx03TXeX+Pgqhz
         UqmfyV58p92R5I4vHr22aGR3BzSxBiUdFJt3BRH1PtrBaVk5KaUapJX5vE4aa4SJFU5C
         NzKdE/1Jj8xiDhtE9oTedb5p6ixrgJU4sdBo56Xa7np3wWcYYwrIccDAKPy1dpfFVeXi
         PbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694013775; x=1694618575;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSjQn7WT6eXQ8nUYAU03PNN8st5l9hFjKNVa6ZDh1YA=;
        b=PWF/P0bH+9ts7OFO9cK2NMWlJBJBcRMij73/5CfpVo1D4DhAZhRGkeKAyVzOBKdKgs
         z0MLGmLUWTf5QOLXy1susZ02+daX/aIFUYEvpJeELxQkJ2PLkRuAPZ+qrsjSJ6jakrO0
         IG+RIDA58j091DAJhuP/RKqikkmAFoYCizdBm2tRorC7c7NMd74nIaWIBXkXxXFNctc0
         fjkGEPd+aURzeoGkWn+khgS7PhJ9Hne2uwLB0vP157FIfE5KEEte4WMPUdcMjp49OrNf
         IwEiYBaTmtgWelf2XI52lVLFGGHHxzGzYMkYeYLWzaaLrFfOLVjM0rDtAiCQ8VKkMH1C
         sC6w==
X-Gm-Message-State: AOJu0YwTcnWosH6GzLhfjZAl1bYIk2o0gCEr+hIto+laWg9va5+L5GZL
        SPRes8OU0epbzF2YLuQCsKZhUYlaOZM=
X-Google-Smtp-Source: AGHT+IEl3qO14NgOy/0acyZNhB7KVHH3JlLyZTIvWdP9E3/2aTNcXAaPC8+YCHmKd51S5BX7OYjiEg==
X-Received: by 2002:a19:7712:0:b0:500:a3be:1ab6 with SMTP id s18-20020a197712000000b00500a3be1ab6mr2265479lfc.6.1694013774307;
        Wed, 06 Sep 2023 08:22:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bt12-20020a056000080c00b0031433443265sm15055423wrb.53.2023.09.06.08.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:22:53 -0700 (PDT)
Message-ID: <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
References: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Sep 2023 15:22:44 +0000
Subject: [PATCH v4 0/7] rebase -i: impove handling of failed commands
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

 sequencer.c                   | 182 ++++++++++++++++++----------------
 t/t3404-rebase-interactive.sh |  53 +++++++---
 t/t3418-rebase-continue.sh    |  18 ++++
 t/t3430-rebase-merges.sh      |  30 ++++--
 t/t5407-post-rewrite-hook.sh  |  48 +++++++++
 5 files changed, 228 insertions(+), 103 deletions(-)


base-commit: a80be152923a46f04a06bade7bcc72870e46ca09
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1492%2Fphillipwood%2Frebase-dont-write-done-when-rescheduling-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1492/phillipwood/rebase-dont-write-done-when-rescheduling-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1492

Range-diff vs v3:

 1:  1ab1ad2ef07 ! 1:  ae4f873b3d0 rebase -i: move unlink() calls
     @@ Metadata
       ## Commit message ##
          rebase -i: move unlink() calls
      
     -    At the start of each iteration the loop that picks commits removes
     -    state files from the previous pick. However some of these are only
     -    written if there are conflicts and so we break out of the loop after
     -    writing them. Therefore they only need to be removed when the rebase
     -    continues, not in each iteration.
     +    At the start of each iteration the loop that picks commits removes the
     +    state files from the previous pick. However some of these files are only
     +    written if there are conflicts in which case we exit the loop before the
     +    end of the loop body. Therefore they only need to be removed when the
     +    rebase continues, not at the start of each iteration.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
 2:  e2a758eb4a5 ! 2:  f540ed1d607 rebase -i: remove patch file after conflict resolution
     @@ Commit message
          now used in two different places rebase_path_patch() is added and used
          to obtain the path for the patch.
      
     +    To construct the path write_patch() previously used get_dir() which
     +    returns different paths depending on whether we're rebasing or
     +    cherry-picking/reverting. As this function is only called when
     +    rebasing it is safe to use a hard coded string for the directory
     +    instead. An assertion is added to make sure we don't starting calling
     +    this function when cherry-picking in the future.
     +
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## sequencer.c ##
     @@ sequencer.c: static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
        * For the post-rewrite hook, we make a list of rewritten commits and
        * their new sha1s.  The rewritten-pending list keeps the sha1s of
      @@ sequencer.c: static int make_patch(struct repository *r,
     + 	char hex[GIT_MAX_HEXSZ + 1];
     + 	int res = 0;
     + 
     ++	if (!is_rebase_i(opts))
     ++		BUG("make_patch should only be called when rebasing");
     ++
     + 	oid_to_hex_r(hex, &commit->object.oid);
     + 	if (write_message(hex, strlen(hex), rebase_path_stopped_sha(), 1) < 0)
       		return -1;
       	res |= write_rebase_head(&commit->object.oid);
       
 3:  8f6c0e40567 ! 3:  818bdaf772d sequencer: use rebase_path_message()
     @@ Commit message
          made function to get the path name instead. This was the last
          remaining use of the strbuf so remove it as well.
      
     +    As with the previous patch we now use a hard coded string rather than
     +    git_dir() when constructing the path. This is safe for the same
     +    reason (make_patch() is only called when rebasing) and is protected by
     +    the assertion added in the previous patch.
     +
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## sequencer.c ##
 4:  a1fad70f4b9 = 4:  bd67765a864 sequencer: factor out part of pick_commits()
 5:  df401945866 ! 5:  f6f330f7063 rebase: fix rewritten list for failed pick
     @@ Commit message
          disabled the user will see the messages from the merge machinery
          detailing the problem.
      
     -    To simplify writing REBASE_HEAD in this case pick_one_commit() is
     -    modified to avoid duplicating the code that adds the failed command
     -    back into the todo list.
     +    The code to add a failed command back into the todo list is duplicated
     +    between pick_one_commit() and the loop in pick_commits(). Both sites
     +    print advice about the command being rescheduled, decrement the current
     +    item and save the todo list. To avoid duplicating this code
     +    pick_one_commit() is modified to set a flag to indicate that the command
     +    should be rescheduled in the main loop. This simplifies things as only
     +    the remaining copy of the code needs to be modified to set REBASE_HEAD
     +    rather than calling error_with_patch().
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
 6:  2ed7cbe5fff = 6:  0ca5fccca17 rebase --continue: refuse to commit after failed command
 7:  bbe0afde512 = 7:  8d5f6d51e19 rebase -i: fix adding failed command to the todo list

-- 
gitgitgadget
