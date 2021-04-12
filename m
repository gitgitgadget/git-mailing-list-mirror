Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85FFC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 16:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8025D61074
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 16:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbhDLQ5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344625AbhDLQ4U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 12:56:20 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E11DC06134E
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 09:53:15 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id s16-20020a0568301490b02901b83efc84a0so13372666otq.10
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOX+wOuP4zyUqgtDL4MXRJYM065t2WopHbMF5xMmoAU=;
        b=PpWVyBnVvF1sS1xGKQqg8x0Xu+viGxVUFs1BrAbPn70EbBo1lle5xJbolNPNuhorGD
         fYE32lu64RtTtyYXnQrOEhNZmjf+0eFTywExWMzJShfSFRVdzZcqJ16r0SrAJMt4/U18
         EKEX8XfJYTSrITZx1FnaToTgvIWOIkghBhhKxmXiU9jTr1bXmbqTxNEAvCkMP0XK/zGi
         OG7UYTA0GjwE/2HiSGJqN7L1OXtlQpEwvjvSnIIkTKodmMdhv/c2N8O8S8a+Q9tvSbLu
         tVTopRNize817I3BTHStlcw7dE2LItPMcWA9s5xKoaMnnjRVTAc3K/tXXhbK5bpv7men
         ynSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOX+wOuP4zyUqgtDL4MXRJYM065t2WopHbMF5xMmoAU=;
        b=DfdYDpdH2CSoJNsKc8ttoYxCgIwS946q6uiAOLsr7Sv//il8QV28viXWMevrBILqB9
         3F0pMt8vLghKgPKTosiygY6hKumKO8cyBa8uwQW4zvSqOwVS0CLjfFDH7jXTlJ9Tz96N
         Pzo3aWXKudduLEEDQk4J3JX/5gGr/5jyl9dKf2GmvNtQsD/uqg8gtjtACqbegMXoO/ah
         gmrvtPs6GR6RdURKF+qrndrLWaZ/f6Zv0iHmZhpI3DD3S7jt9i3DvlVEXnjIwWSQaFU4
         hMvk6ZHSHYpxPIbO5+sR2rvn9JJbaicJmYJi2kW8TO5SSs7gciMPLf5x+V3CI70YuR86
         L3cw==
X-Gm-Message-State: AOAM532woAW6uZFDo5mQZ67xJPTJiE498ixZcvi4vV53eQ7D9OOL/D1v
        v2SU23bFBtnQ+rUojOeCOWwbAlhwkqZ+7RkPXscq6WU6yRg=
X-Google-Smtp-Source: ABdhPJzrZLjFYzp0b2dm7T9Y4GKsjU3XHcwd5AvRalsZz3VF04bYV/KU7Jxjq0Kdh9vzX1/UKOg6+BDC1D9WDy9jUMo=
X-Received: by 2002:a9d:2de8:: with SMTP id g95mr11703063otb.162.1618246395041;
 Mon, 12 Apr 2021 09:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAKJ37DfivxL-2Sy0qa+M_1Pw0c9-CWsCJO5=VqP1UOB5zTSP_Q@mail.gmail.com>
 <CABPp-BEOnrnQKov1YDdHXkb6CCNxudE9bUdntOeq3k0wOODc1A@mail.gmail.com> <CAKJ37Dc5-rOeN_=vq5P3=z=_1bqGFRuFhuWde6cS0vGg3mkLnQ@mail.gmail.com>
In-Reply-To: <CAKJ37Dc5-rOeN_=vq5P3=z=_1bqGFRuFhuWde6cS0vGg3mkLnQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Apr 2021 09:53:03 -0700
Message-ID: <CABPp-BHASo5CFejED8CFbB1zszAaQW1Q8yitUdqW-wi8eFuvWg@mail.gmail.com>
Subject: Re: Unexpected conflict during cherry-pick after moving submodule
To:     Tamas Peregi <tamas.peregi@formlabs.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tamas,

On Mon, Apr 12, 2021 at 9:08 AM Tamas Peregi <tamas.peregi@formlabs.com> wrote:
>
> Hi Elijah,
>
> thanks for the quick reply and the useful information about the ort strategy!
>
> Do I understand correctly that the problem is in the recursive
> strategy, i.e. inside the cherry-pick step, not the submodule
> movement? That sounds a bit unfortunate in my case, as I'm the one
> moving the submodule (then merging it back to master), and others in
> my company want to cherry-pick over it, so I'm breaking their
> workflows if I go ahead with moving. (Unless I tell all of them to use
> the experimental ort strategy instead, which may introduce its own set
> of problems.) Is there any way of moving the submodule that doesn't
> break cherry-picking with the default (recursive) strategy? I'm
> willing to do some extra work to spare confusion by others down the
> line.

Unfortunately, the recursive merge machinery had a variety of issues
with submodules (see e.g.
https://git.kernel.org/pub/scm/git/git.git/commit/?id=aa2faac03ad646873ebac2b230581d1d26dd1b99)
and yes, the merge machinery is intrinsic to cherry-pick's
functionality.  I don't have a good workaround for you, short of "wait
until git-2.32 is released".

> Also: up until now, I thought cherry-pick simply exports the source
> commit as a patch, then applies it to the target commit, but
> "recursive" is a merge strategy, correct? So is cherry-pick doing
> something vastly more complex than I thought, involving merging in the
> background?

Right, cherry-pick makes use of the merge machinery using a particular
specially crafted merge while recording it as a regular commit.
Interestingly, the rebase command has multiple backends, one of which
used the merge machinery and another that behaved as you thought by
creating and applying patches.  While the use of an appropriate
special merge (as done by cherry-pick and rebase) is roughly
semantically equivalent to what creating and applying patches
provides, the create-and-apply-patches procedure actually discards
relevant information and results in some shortcomings that simply
cannot be fixed.  As such, we switched the default rebase backend from
"apply" to "merge" as of git-2.26.  If you're curious, read up on the
"BEHAVIORAL DIFFERENCES" section of the git-rebase(1) manual,
especially the "Context" section.

Hope that helps,
Elijah
