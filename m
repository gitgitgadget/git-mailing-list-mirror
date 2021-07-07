Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F012C07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA2661CB3
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhGGBs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 21:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGBs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 21:48:57 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86965C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 18:46:17 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u11so1602815oiv.1
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 18:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYkH81DjFOVUH7lqHwtP8RhKZIiDkYjXoB7zvpSMpSQ=;
        b=toiiKT1Rbn3aCnK3fI4fBmbn+S6geELAosCmlkVojPJ6OFc4qP8XdMuj0jdc6Ht42r
         Zq8Du7UUNqcVbt1L3lnllFLruoyeMwaH54lPJh1tkYbrqBAb1lse7uEwmjamcF6RKrlE
         zyIF4TGL8DXnJ4a4SrMrFXuLN0OS+UNaKFUCbMskbRIaZi2IbU0+MaqLmoREqjnv1uz8
         fKEzYZptwq0xFD04CPBknV/XVzRymqyK8yFyq0yfHluUOeZuUIPmbUPSOvxY/VBT06X6
         FmCv8GVYtB5VTi/XFdS9nvxq7A7eJoVfoubjN7O1tFPkV7kigKT2hFjTcz/jRyxttjaJ
         zBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYkH81DjFOVUH7lqHwtP8RhKZIiDkYjXoB7zvpSMpSQ=;
        b=B30D8G5uGrZZAoUAbi8f/EpVs0FtvfKXzlyoxLRk/6ZOatvqbf7wSdhN21omVcty/w
         m66RR7ts6LYHAYGWfJ5dHBYouiwZuy26nxr+m8nSbYx+tsgUixWQgP0vBtl3ybwA/eMd
         BFt//P2P9qV3TSI3xn7OSZztmBt6M9c6g587Xed4Vg16RcBMTdIuSkNZJKp+Nw7z7b2+
         +Lgx28c1YHU7F9C4UAAZUsleLGnHr1+ViRB1DLoxvv/lL+tmrNV95OnKdn5kXQfyOXCA
         ud+MrH+5JLzbNuDquasJJmcLu42QdKqte9nJgomTwunD4tZ4F98u7+68RwHVwymWphOT
         AhCA==
X-Gm-Message-State: AOAM530W8kHXb3PVcjq992HM88shIwNSk2L56oG3MRUxcvgDLXPWm6CG
        6UEw2lgHrdqEmIy71Q3ATpDvSFpezv3l/hxxgoQ=
X-Google-Smtp-Source: ABdhPJxbCZoWiRviHCV5giSVrvsDkJ2NJId5HIpbGIBc+IOueJIRGtYyvKuQQq5KsqQ+e43ArfZJo6hbdBanB1fAIdE=
X-Received: by 2002:aca:d547:: with SMTP id m68mr6879385oig.31.1625622376831;
 Tue, 06 Jul 2021 18:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqim1mgbty.fsf@gitster.g>
In-Reply-To: <xmqqim1mgbty.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 6 Jul 2021 18:46:05 -0700
Message-ID: <CABPp-BGt0E4nLtU6Ocn0dUwOUUwDkz-90KKUpSLK9ctU9tQXmA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2021, #01; Tue, 6)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 6, 2021 at 6:20 PM Junio C Hamano <gitster@pobox.com> wrote:

> * ds/commit-and-checkout-with-sparse-index (2021-06-28) 5 commits
>  - checkout: stop expanding sparse indexes
>  - sparse-index: recompute cache-tree
>  - commit: integrate with sparse-index
>  - p2000: compress repo names
>  - p2000: add 'git checkout -' test and decrease depth
>  (this branch uses ds/status-with-sparse-index.)
>
>  "git checkout" and "git commit" learn to work without unnecessarily
>  expanding sparse indexes.
>
>  Comments?

This was submitted at the same time as the latest round of
ds/status-with-sparse-index.  Last week was a bit busy for me.  I'd
like to complete reviewing the latest round from the other series,
then I'll review this one.  So I'll have some comments soon-ish (by
end of week).

> * ds/status-with-sparse-index (2021-06-28) 16 commits
>  - fsmonitor: integrate with sparse index
>  - wt-status: expand added sparse directory entries
>  - status: use sparse-index throughout
>  - status: skip sparse-checkout percentage with sparse-index
>  - diff-lib: handle index diffs with sparse dirs
>  - dir.c: accept a directory as part of cone-mode patterns
>  - unpack-trees: handle dir/file conflict of sparse entries
>  - unpack-trees: unpack sparse directory entries
>  - unpack-trees: rename unpack_nondirectories()
>  - unpack-trees: compare sparse directories correctly
>  - unpack-trees: preserve cache_bottom
>  - t1092: add tests for status/add and sparse files
>  - t1092: expand repository data shape
>  - t1092: replace incorrect 'echo' with 'cat'
>  - sparse-index: include EXTENDED flag when expanding
>  - sparse-index: skip indexes with unmerged entries
>  (this branch is used by ds/commit-and-checkout-with-sparse-index.)
>
>  "git status" codepath learned to work with sparsely populated index
>  without hydrating it fully.
>
>  Will merge to 'next'?

Sorry for the delay.  I reviewed about half of the latest round last
week, and it appears all my feedback from earlier rounds was addressed
from what I've seen so far.  I suspect this series is now good to go
and I'd like to stick my Reviewed-by on it before it goes to next, but
I need to complete my review first.   I should be able to complete it
by end of week.

> * jt/partial-clone-submodule-1 (2021-06-28) 5 commits
>  - promisor-remote: teach lazy-fetch in any repo
>  - run-command: refactor subprocess env preparation
>  - submodule: refrain from filtering GIT_CONFIG_COUNT
>  - promisor-remote: support per-repository config
>  - repository: move global r_f_p_c to repo struct
>
>  Prepare the internals for lazily fetching objects in submodules
>  from their promisor remotes.
>
>  Waiting for reviews.

I reviewed here:
https://lore.kernel.org/git/CABPp-BFQhBN-MEGgkyK7gcnuQp01Xfj17TrTcH04yuadXuRu3Q@mail.gmail.com/.
Sure, I left my Reviewed-by off of patch 3, but that's because I roped
Peff in and he explained to me why that patch (and more the
pre-existing code) worked and was good.  So he's the one that reviewed
that patch.  :-)

Besides Peff and I, three other folks provided feedback on previous
rounds -- Taylor, Emily, and you.

So, I think it's gotten reviews.  Another reviewer could come along
and request additional changes, but short of someone showing up soon,
I'd say this one is good to merge to 'next' (well, maybe after it's
re-rolled to include my Reviewed-by)
