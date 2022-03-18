Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE2CC433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 13:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiCRNz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbiCRNzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 09:55:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1EE192351
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 06:54:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x15so11814827wru.13
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PkeNNtiwyEVUvBuw2hjXETLUTevr8F9q+F0X4AE/cmM=;
        b=YPm792RrpxZwaea2bZl6ODtaRxLoFuClWUfxoDyhF2n+LeDPTpr85FwE3O0qFpQg23
         I7cy7mYg+X+Il/YNfAUstOlW3VID5gNBVWtH3AFG/EjznYNmtFnOQC2OqKaVPW7cyMwK
         Cd5xgybZWAWyzYzDtmemctM8KlIg2YwEOV5JNEaqFItNZBlkY4yW3/WyChcrVFmO2VuX
         IVZBwrIh/g4u3jZ65Iy/unGdXIXKSJ1m4eoALwrEkypphS0c1NSG8VxeAPUzbSvKubl1
         v7WotyhF++eFvBMakk40ZCM2G94zZq2e/Wtwd8vj3sscXG6uzQs0RGVx5/IUMGehzxT7
         9GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PkeNNtiwyEVUvBuw2hjXETLUTevr8F9q+F0X4AE/cmM=;
        b=OjAoNGNDAPlbiUc9zsJpQkwMqUJMIkk8qKQFZXHaJ6Bw9xkzu8OGjYn5ife9FBZ8vr
         HAAqbsSxJttE4BnX1wmIKpYhGxsxkjfqTjlhU+W4gkx401WIwijWjAQ/Tb55ZF+IfzRQ
         m/1TXBWJ3Wk3TUVlsjy7GE0/BdEFef7xYgM+Sv2xgSMyAk9Fz5T5ZRu4v2PQp1CdwHta
         HD8lcO6xsBBZYfbxp/ZSzwcT9/7v9Gh/FrFUhE3vvIkcFphoa9N2YwLh+f5J3mrPtQb3
         z8MWQO7FYvVCTlK+sML573UrOHHBskVniukE8tSz1DXVBZd+YxoAiAuCmuV3Vwiqg+Ku
         vcBA==
X-Gm-Message-State: AOAM532D2IRKmS+4CeWNri+FmYY6tksPIngGXqmOt6/0FTVzT8p8Mshh
        d5K/9ohKzyT1OR8kEEa5/TYIEmpbnFs=
X-Google-Smtp-Source: ABdhPJy0WPrYuQzNdP2kmOMM5s7833ZebEUQCd/Xh2Z1ruxPX4KYd0gVVUxWem47jSv8rxYAt966Tw==
X-Received: by 2002:adf:d081:0:b0:203:e209:7def with SMTP id y1-20020adfd081000000b00203e2097defmr7581936wrh.388.1647611644246;
        Fri, 18 Mar 2022 06:54:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b0038c043567d3sm6826742wma.1.2022.03.18.06.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 06:54:03 -0700 (PDT)
Message-Id: <pull.1226.v5.git.git.1647611643.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
References: <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Mar 2022 13:54:01 +0000
Subject: [PATCH v5 0/2] rebase: update HEAD when is an oid
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Michael McClimon <michael@mcclimon.org>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes a bug [1] reported by Michael McClimon where rebase with oids will
erroneously update the branch HEAD points to.

 1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/

This patch has two parts:

 * updates rebase setup test to add some tags we will use, while swapping
   out manual commit creation with the test_commit helper
 * sets RESET_HARD_DETACH flag if branch is not a valid refname

changes since v4:

 * got rid of test assertion that shows bug behavior
 * clarified commit message

changes since v3:

 * fixed typos in commit message
 * added a test assertion to show bug behavior
 * included more replacements with test_commit

changes since v2:

 * remove BUG assertion

changes since v1:

 * only set RESET_HEAD_DETACH if is not a valid branch
 * updated tests to use existing setup

John Cai (2):
  rebase: use test_commit helper in setup
  rebase: set REF_HEAD_DETACH in checkout_up_to_date()

 builtin/rebase.c  |  2 ++
 t/t3400-rebase.sh | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)


base-commit: b896f729e240d250cf56899e6a0073f6aa469f5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1226%2Fjohn-cai%2Fjc%2Ffix-rebase-oids-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1226/john-cai/jc/fix-rebase-oids-v5
Pull-Request: https://github.com/git/git/pull/1226

Range-diff vs v4:

 1:  cac51a949ee < -:  ----------- rebase: test showing bug in rebase with non-branch
 2:  5c40e116eba ! 1:  9dbd2ba430a rebase: use test_commit helper in setup
     @@ t/t3400-rebase.sh: test_expect_success 'prepare repository with topic branches'
       	git checkout -f main &&
       	echo Third >>A &&
       	git update-index A &&
     - 	git commit -m "Modify A." &&
     - 	git checkout -b side my-topic-branch &&
     --	echo Side >>C &&
     --	git add C &&
     --	git commit -m "Add C" &&
     -+	test_commit --no-tag "Add C" C Side &&
     - 	git checkout -f my-topic-branch &&
     - 	git tag topic
     - '
     -@@ t/t3400-rebase.sh: test_expect_success 'rebase off of the previous branch using "-"' '
     - test_expect_success 'rebase a single mode change' '
     - 	git checkout main &&
     - 	git branch -D topic &&
     --	echo 1 >X &&
     --	git add X &&
     --	test_tick &&
     --	git commit -m prepare &&
     -+	test_commit prepare X 1 &&
     - 	git checkout -b modechange HEAD^ &&
     - 	echo 1 >X &&
     - 	git add X &&
 3:  13c5955c317 ! 2:  1dd5bb21012 rebase: set REF_HEAD_DETACH in checkout_up_to_date()
     @@ Metadata
       ## Commit message ##
          rebase: set REF_HEAD_DETACH in checkout_up_to_date()
      
     -    Fixes a bug whereby rebase updates the deferenced reference HEAD points
     -    to instead of HEAD directly.
     -
     -    If HEAD is on main and if the following is a fast-forward operation,
     -
     -    git rebase $(git rev-parse main) $(git rev-parse topic)
     -
     -    Instead of HEAD being set to $(git rev-parse topic), rebase erroneously
     -    dereferences HEAD and sets main to $(git rev-parse topic). See [1] for
     -    the original bug report.
     +    "git rebase A B" where B is not a commit should behave as if the
     +    HEAD got detached at B and then the detached HEAD got rebased on top
     +    of A.  A bug however overwrites the current branch to point at B,
     +    when B is a descendant of A (i.e. the rebase ends up being a
     +    fast-forward).  See [1] for the original bug report.
      
          The callstack from checkout_up_to_date() is the following:
      
     -    cmd_rebase() -> checkout_up_to_date() -> reset_head() -> update_refs()
     -     -> update_ref()
     +    cmd_rebase()
     +    -> checkout_up_to_date()
     +       -> reset_head()
     +          -> update_refs()
     +             -> update_ref()
      
     -    When <branch> is not a valid branch but an oid, rebase sets the head_name
     -    of rebase_options to NULL. This value gets passed down this call chain
     -    through the branch member of reset_head_opts also getting set to NULL
     -    all the way to update_refs().
     +    When B is not a valid branch but an oid, rebase sets the head_name
     +    of rebase_options to NULL. This value gets passed down this call
     +    chain through the branch member of reset_head_opts also getting set
     +    to NULL all the way to update_refs().
      
          Then update_refs() checks ropts.branch to decide whether or not to switch
          branches. If ropts.branch is NULL, it calls update_ref() to update HEAD.
          At this point however, from rebase's point of view, we want a detached
          HEAD. But, since checkout_up_to_date() does not set the RESET_HEAD_DETACH
          flag, the update_ref() call will deference HEAD and update the branch its
     -    pointing to, which in the above example is main.
     -
     -    The correct behavior is that git rebase should update HEAD to $(git
     -    rev-parse topic) without dereferencing it.
     +    pointing to. We want the HEAD detached at B instead.
      
     -    Fix this bug by adding the RESET_HEAD_DETACH flag in checkout_up_to_date
     -    if <branch> is not a valid branch. so that once reset_head() calls
     -    update_refs(), it calls update_ref() with REF_NO_DEREF which updates
     -    HEAD directly intead of deferencing it and updating the branch that HEAD
     -    points to.
     +    Fix this bug by adding the RESET_HEAD_DETACH flag in
     +    checkout_up_to_date if B is not a valid branch, so that once
     +    reset_head() calls update_refs(), it calls update_ref() with
     +    REF_NO_DEREF which updates HEAD directly intead of deferencing it
     +    and updating the branch that HEAD points to.
      
          Also add a test to ensure the correct behavior.
      
     -    1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/
     +    [1] https://lore.kernel.org/git/YiokTm3GxIZQQUow@newk/
      
     +    Reported-by: Michael McClimon <michael@mcclimon.org>
          Signed-off-by: John Cai <johncai86@gmail.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: static int checkout_up_to_date(struct rebase_options *options)
     @@ t/t3400-rebase.sh: test_expect_success 'switch to branch not checked out' '
       	git rebase main other
       '
       
     --test_expect_success 'switch to non-branch changes branch HEAD points to' '
      +test_expect_success 'switch to non-branch detaches HEAD' '
     - 	git checkout main &&
     - 	old_main=$(git rev-parse HEAD) &&
     - 	git rebase First Second^0 &&
     --	test_cmp_rev HEAD main &&
     --	test_cmp_rev main $(git rev-parse Second) &&
     --	git symbolic-ref HEAD
     ++	git checkout main &&
     ++	old_main=$(git rev-parse HEAD) &&
     ++	git rebase First Second^0 &&
      +	test_cmp_rev HEAD Second &&
      +	test_cmp_rev main $old_main &&
      +	test_must_fail git symbolic-ref HEAD
     - '
     - 
     ++'
     ++
       test_expect_success 'refuse to switch to branch checked out elsewhere' '
     + 	git checkout main &&
     + 	git worktree add wt &&

-- 
gitgitgadget
