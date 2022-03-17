Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4EEC433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 19:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiCQTzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 15:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCQTzN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 15:55:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E665214176
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 12:53:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso3728051wmz.4
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 12:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jsSQnjdZkBzLgKanK/3fgpZm0Tym1Vh4uzNo64bXnhU=;
        b=UgjlzmoYLQvIQPxl2H1mbLd8Yo8CbXSBw+vcrni4bu7XZz8pYvZd85btzvn/QP5mh8
         mxTS1MyHX9Q3z58dUfPLKwFWmG+dPvGDw5T6jkxFWITZimN8CB1Le43vupfRRVIjopHm
         5ssprncn7qHKfUC3leOzJthHNu6PZyjduZkuNcDBDf0zlSDIDBDyYK42prd5A8nTVDlP
         qD4osBqra5C3iIyntQnqUV8I5pBTuLuTN8A7UvUZIFJ4xRIN5M8+BHXajPkJHiA61BuZ
         mGHheefWFZsM7zS7DwgbYUePqvTerB8MS9LObUYC/kWXNbAXCNlEHtCBN8+LK/KDOugJ
         atSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jsSQnjdZkBzLgKanK/3fgpZm0Tym1Vh4uzNo64bXnhU=;
        b=XdxqB8aLet24BxO3+otRw1vhSY/4tn8+ZRrmMpuGLGW7GCSrbIPn8PYqR+t/QAx9iA
         7kQnMn+GtED34X/w8CaROYpNWSI7juN8MwoJC7R89oZiTkuaoOFb3EkZ/8tvaZexpSOv
         Qd4xRjiM0iRBONiU2hje92VT3vmL5j7mEoXUri2bBmc18GoVh8LjDye++Wbi/z0wP5kP
         KYwrFBsscFH8RmIg19kzhFW7gGXMrDI6q45hlengRhq1JUKWDmoIb3+b+ptvoXvGAKLU
         Knb7M5r97VbII1lxlYrEciyPI6g9nF1oNDOjuj6M5grRsXsKrBxhpOul3aqZXcFUQUXB
         /TXg==
X-Gm-Message-State: AOAM5339+6b7hqWHp0lTWxJw56etdNOW6wdfdaspj0ZaNdwSRWDEUasI
        t6twSoCu/MLnivpB60PFdU3NJ2VVdro=
X-Google-Smtp-Source: ABdhPJypShHmi1J63Uxbr28/F6xWCfK0izo3zMa5a1x5Q4ZBldFgKKl0yLbp/d0wFkWg8oGlGeuqQg==
X-Received: by 2002:a1c:f30b:0:b0:380:e444:86b9 with SMTP id q11-20020a1cf30b000000b00380e44486b9mr5514115wmq.81.1647546829413;
        Thu, 17 Mar 2022 12:53:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020adfec92000000b00203f04ed4a8sm1348239wrn.13.2022.03.17.12.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 12:53:48 -0700 (PDT)
Message-Id: <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
References: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 19:53:45 +0000
Subject: [PATCH v4 0/3] rebase: update HEAD when is an oid
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes a bug [1] reported by Michael McClimon where rebase with oids will
erroneously update the branch HEAD points to.

 1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/

This patch has three parts:

 * a test to show the incorrect buggy behavior of rebase with a non-branch
   argument
 * updates rebase setup test to add some tags we will use, while swapping
   out manual commit creation with the test_commit helper
 * sets RESET_HARD_DETACH flag if branch is not a valid refname

changes since v3:

 * fixed typos in commit message
 * added a test assertion to show bug behavior
 * included more replacements with test_commit

changes since v2:

 * remove BUG assertion

changes since v1:

 * only set RESET_HEAD_DETACH if is not a valid branch
 * updated tests to use existing setup

John Cai (3):
  rebase: test showing bug in rebase with non-branch
  rebase: use test_commit helper in setup
  rebase: set REF_HEAD_DETACH in checkout_up_to_date()

 builtin/rebase.c  |  2 ++
 t/t3400-rebase.sh | 27 +++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)


base-commit: b896f729e240d250cf56899e6a0073f6aa469f5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1226%2Fjohn-cai%2Fjc%2Ffix-rebase-oids-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1226/john-cai/jc/fix-rebase-oids-v4
Pull-Request: https://github.com/git/git/pull/1226

Range-diff vs v3:

 -:  ----------- > 1:  cac51a949ee rebase: test showing bug in rebase with non-branch
 1:  f658eb00bcd ! 2:  5c40e116eba rebase: use test_commit helper in setup
     @@ t/t3400-rebase.sh: test_expect_success 'prepare repository with topic branches'
       	git checkout -f main &&
       	echo Third >>A &&
       	git update-index A &&
     + 	git commit -m "Modify A." &&
     + 	git checkout -b side my-topic-branch &&
     +-	echo Side >>C &&
     +-	git add C &&
     +-	git commit -m "Add C" &&
     ++	test_commit --no-tag "Add C" C Side &&
     + 	git checkout -f my-topic-branch &&
     + 	git tag topic
     + '
     +@@ t/t3400-rebase.sh: test_expect_success 'rebase off of the previous branch using "-"' '
     + test_expect_success 'rebase a single mode change' '
     + 	git checkout main &&
     + 	git branch -D topic &&
     +-	echo 1 >X &&
     +-	git add X &&
     +-	test_tick &&
     +-	git commit -m prepare &&
     ++	test_commit prepare X 1 &&
     + 	git checkout -b modechange HEAD^ &&
     + 	echo 1 >X &&
     + 	git add X &&
 2:  bd1c9537ffc ! 3:  13c5955c317 rebase: set REF_HEAD_DETACH in checkout_up_to_date()
     @@ Commit message
          cmd_rebase() -> checkout_up_to_date() -> reset_head() -> update_refs()
           -> update_ref()
      
     -    When <branch> is not a valid branch but a sha, rebase sets the head_name
     +    When <branch> is not a valid branch but an oid, rebase sets the head_name
          of rebase_options to NULL. This value gets passed down this call chain
          through the branch member of reset_head_opts also getting set to NULL
     -    all the way to update_refs(). update_refs() checks ropts.branch to
     -    decide whether or not to switch brancheds. If ropts.branch is NULL, it
     -    calls update_ref() to update HEAD. At this point however, from rebase's
     -    point of view, we want a detached HEAD. But, since checkout_up_to_date()
     -    does not set the RESET_HEAD_DETACH flag, the update_ref() call will
     -    deference HEAD and update the branch its pointing to, which in the above
     -    example is main.
     +    all the way to update_refs().
     +
     +    Then update_refs() checks ropts.branch to decide whether or not to switch
     +    branches. If ropts.branch is NULL, it calls update_ref() to update HEAD.
     +    At this point however, from rebase's point of view, we want a detached
     +    HEAD. But, since checkout_up_to_date() does not set the RESET_HEAD_DETACH
     +    flag, the update_ref() call will deference HEAD and update the branch its
     +    pointing to, which in the above example is main.
      
          The correct behavior is that git rebase should update HEAD to $(git
          rev-parse topic) without dereferencing it.
     @@ Commit message
          HEAD directly intead of deferencing it and updating the branch that HEAD
          points to.
      
     -    Also add a test to ensure this behavior.
     +    Also add a test to ensure the correct behavior.
      
          1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/
      
     -    Reported-by: Michael McClimon <michael@mcclimon.org>
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: static int checkout_up_to_date(struct rebase_options *options)
     - 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
     - 		    options->switch_to);
       	ropts.oid = &options->orig_head;
     --	ropts.branch = options->head_name;
     + 	ropts.branch = options->head_name;
       	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
     -+	if (options->head_name)
     -+		ropts.branch = options->head_name;
     -+	else
     ++	if (!ropts.branch)
      +		ropts.flags |=  RESET_HEAD_DETACH;
       	ropts.head_msg = buf.buf;
       	if (reset_head(the_repository, &ropts) < 0)
     @@ t/t3400-rebase.sh: test_expect_success 'switch to branch not checked out' '
       	git rebase main other
       '
       
     +-test_expect_success 'switch to non-branch changes branch HEAD points to' '
      +test_expect_success 'switch to non-branch detaches HEAD' '
     -+	git checkout main &&
     -+	old_main=$(git rev-parse HEAD) &&
     -+	git rebase First Second^0 &&
     + 	git checkout main &&
     + 	old_main=$(git rev-parse HEAD) &&
     + 	git rebase First Second^0 &&
     +-	test_cmp_rev HEAD main &&
     +-	test_cmp_rev main $(git rev-parse Second) &&
     +-	git symbolic-ref HEAD
      +	test_cmp_rev HEAD Second &&
      +	test_cmp_rev main $old_main &&
      +	test_must_fail git symbolic-ref HEAD
     -+'
     -+
     + '
     + 
       test_expect_success 'refuse to switch to branch checked out elsewhere' '
     - 	git checkout main &&
     - 	git worktree add wt &&

-- 
gitgitgadget
