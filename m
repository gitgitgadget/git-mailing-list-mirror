Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC55C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A076060BD3
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhG2O6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhG2O6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 10:58:16 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBABC061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:58:13 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id o20so8734647oiw.12
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+xa/hoQUS8gWcRFPy/epay1bekt69+sn0pldfog3zA=;
        b=sBusnHQM+nZfcLP5MvQX7C/MvpA99/2uq8gnWTzY4zwjkoDJ/WhN6bxi8qW41HZz50
         gEfh87b9RL6w7X51JwUdryxLzWZN4keHArtcRVxYsuhSAJfLaxKMb5BTvxicx0g6Cywo
         S17LY9nhoNg09dRCUhuvSii4Ycu2vACbLqi84tbqfVLaqkUuPF8TjP0zpQ7aZd4yD25O
         jaq8NUQsjf7brywl9dHNrsoOB2pYOwSEPpKY4Xu+U/ZTP1dHg27B4OXUfIDW/mJtgwkW
         arRRp/lKqQvholeTIlBskrXliZPXvH5rT5B37SrZJzsDq93HkxJA62/4OTG3H9bsKkIu
         yrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+xa/hoQUS8gWcRFPy/epay1bekt69+sn0pldfog3zA=;
        b=HpEMCcPZMwtcTotMews1Pjvn2ZGEFylG0sxQmb3oj359Bg5vfzzs2jQgrYloRNeD6L
         INv2aVR3bPoUh0EFjG4CQf1YcyCpEFqFlbDePATWfc0jHy72jrBsHU6AOV605ZEi3I+m
         AhwTkaIB3pPpUI/CKcitKGlrS+3KJCyyx1S965m+TGLJMYj+RfS4Z83HdQyIWYn2DAl/
         gR5cxV/JFnGwxUfmqHeLdSRUko4Wejam/mE3GwMryrtMkuWQv6GuUvuSMyMSL9FcRNVG
         zfVaQ6naj7f3ozobFMk7IELxxLhD3jJ35KVWHF6OWUBr+GHrk18ivMbPIqE8pi0fm97S
         KDPw==
X-Gm-Message-State: AOAM5316VAKf7sfTr96h+p8vWfr3osZ1rvVMN7GGfmGdF2ITqoQLCr4Z
        85skoWpTXkTE3LWLBmLuoBIkCXoiJUZZkOe6vg8=
X-Google-Smtp-Source: ABdhPJwCcVQr9vmfNQNoEbrGul+6vSIvyGCwbf7hajXs7Evw0YmOJi5ywP2M5kcWfaQ9TPhVUmJV66ZxPiRRv/55ycc=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr10075993oie.167.1627570692544;
 Thu, 29 Jul 2021 07:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com> <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Jul 2021 08:58:01 -0600
Message-ID: <CABPp-BFOW+oUiFEQG8ZYsocuVx35b5ayYyXP6M462QzJ8U7d0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Sparse Index: Integrate with 'git add'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 8:52 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This patch series re-submits the 'git add' integration with sparse-index.
> The performance gains are the same as before.
>
> It is based on ds/commit-and-checkout-with-sparse-index.
>
> This series was delayed from its initial submission for a couple reasons.
>
> The first was because it was colliding with some changes in
> mt/add-rm-in-sparse-checkout, so now we are far enough along that that
> branch is in our history and we can work forwards.
>
> The other concern was about how 'git add ' should respond when a path
> outside of the sparse-checkout cone exists. One recommendation (that I am
> failing to find a link to the message, sorry) was to disallow adding files
> that would become index entries with SKIP_WORKTREE on. However, as I worked
> towards that goal I found that change would cause problems for a realistic
> scenario: merge conflicts outside of the sparse-checkout cone.
>
> Update: Elijah points out that the SKIP_WORKTREE bit is removed from
> conflict files, which allows adding the conflicted files without warning.
> (However, we also need to be careful about untracked files, as documented in
> the test added here.)
>
> The first patch of this series adds tests that create merge conflicts
> outside of the sparse cone and then presents different ways a user could
> resolve the situation. We want all of them to be feasible, and this
> includes:
>
>  1. Reverting the file to a known version in history.
>  2. Adding the file with its contents on disk.
>  3. Moving the file to a new location in the sparse directory.
>
> The one place I did continue to update is 'git add --refresh ' to match the
> behavior added by mt/add-rm-in-sparse-checkout which outputs an error
> message. This happens even when the file exists in the working directory,
> but that seems appropriate enough.
>
>
> Updates in V3
> =============
>
>  * Added disclaimer to the merge-conflict test that this is documenting
>    current behavior, not endorsing it.
>
>  * Added Elijah's reviewed-by. Thanks for the review!

Yep, this one looks ready to merge down to me.  Thanks!

> Thanks, -Stolee
>
> Derrick Stolee (5):
>   t1092: test merge conflicts outside cone
>   add: allow operating on a sparse-only index
>   pathspec: stop calling ensure_full_index
>   add: ignore outside the sparse-checkout in refresh()
>   add: remove ensure_full_index() with --renormalize
>
>  builtin/add.c                            | 15 ++++--
>  pathspec.c                               |  2 -
>  t/t1092-sparse-checkout-compatibility.sh | 67 ++++++++++++++++++++----
>  3 files changed, 70 insertions(+), 14 deletions(-)
>
>
> base-commit: 71e301501c88399711a1bf8515d1747e92cfbb9b
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-999%2Fderrickstolee%2Fsparse-index%2Fadd-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-999/derrickstolee/sparse-index/add-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/999
>
> Range-diff vs v2:
>
>  1:  8f2fd9370fe ! 1:  5e96df4df58 t1092: test merge conflicts outside cone
>      @@ Metadata
>        ## Commit message ##
>           t1092: test merge conflicts outside cone
>
>      +    Conflicts can occur outside of the sparse-checkout definition, and in
>      +    that case users might try to resolve the conflicts in several ways.
>      +    Document a few of these ways in a test. Make it clear that this behavior
>      +    is not necessarily the optimal flow, since users can become confused
>      +    when Git deletes these files from the worktree in later commands.
>      +
>      +    Reviewed-by: Elijah Newren <newren@gmail.com>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>        ## t/t1092-sparse-checkout-compatibility.sh ##
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge' '
>         test_all_match git rev-parse HEAD^{tree}
>        '
>
>      ++# NEEDSWORK: This test is documenting current behavior, but that
>      ++# behavior can be confusing to users so there is desire to change it.
>      ++# Right now, users might be using this flow to work through conflicts,
>      ++# so any solution should present advice to users who try this sequence
>      ++# of commands to follow whatever new method we create.
>       +test_expect_success 'merge with conflict outside cone' '
>       + init_repos &&
>       +
>  2:  6e43f118fa0 ! 2:  defab1b86d3 add: allow operating on a sparse-only index
>      @@ Commit message
>           the use of a sparse index. We modify a test in t1092 to demonstrate
>           these changes which will be remedied in future changes.
>
>      +    Reviewed-by: Elijah Newren <newren@gmail.com>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>        ## builtin/add.c ##
>  3:  2ae91e0af29 ! 3:  9fc4313c889 pathspec: stop calling ensure_full_index
>      @@ Commit message
>           commits. Comparing to the full index case, we see the performance go
>           from 0.33s to 0.05s, an 85% improvement.
>
>      +    Reviewed-by: Elijah Newren <newren@gmail.com>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>        ## pathspec.c ##
>  4:  a79728d4c64 ! 4:  0ec03ab021d add: ignore outside the sparse-checkout in refresh()
>      @@ Commit message
>           tracked, untracked, or ignored. We simply avoid updating the stat()
>           information because there isn't even an entry that matches the path!
>
>      +    Reviewed-by: Elijah Newren <newren@gmail.com>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>        ## builtin/add.c ##
>  5:  1543550a4e8 ! 5:  adf5b15ac3d add: remove ensure_full_index() with --renormalize
>      @@ Commit message
>           SKIP_WORKTREE bit, so it will continue to do so with a sparse index
>           because the sparse directory entries also have this bit set.
>
>      +    Reviewed-by: Elijah Newren <newren@gmail.com>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>        ## builtin/add.c ##
>
> --
> gitgitgadget
