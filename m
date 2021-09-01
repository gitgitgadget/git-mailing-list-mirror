Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF32C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 04:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6EE61008
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 04:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbhIAEoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 00:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241684AbhIAEoY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 00:44:24 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC71C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 21:43:27 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso2104725otu.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 21:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ym2mRnKYwCpcUDW1/OtnoEMi59YLfftpzBE2mu9tPRM=;
        b=Ja+GrAEDJqcqvVrd8pnE2bmIDhC8GqiDkD66Sm91O+rpee7/aQxIWcI4UbYApoOoB0
         3jjcDulVY1KmMoB73cduuKlgEUe6QO7QoUPxu1QbOdcUj2CI6t+py+GyDvj78bRJJ8K8
         tUGARUWlokp0x0WSQBC6nvpd3MNbAdXFgjTweVFcTVjxktzkkn0cQp2bzyQwwUhq7t1C
         rv5cYoekrFXCFI8o8ShuvUV9L0WQmYn9mkeYLdsIg4Cn2sR3PHfjU+VTnwadkKbnje1o
         ewNuED+n+CIkMA1iByV/z9cGHgLPLIkLWKCYEOKf30Hb/OJNpU2MYIzHFXwqA7tmCkiW
         CKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ym2mRnKYwCpcUDW1/OtnoEMi59YLfftpzBE2mu9tPRM=;
        b=AKVWmZS1ATKyu3+P41Wy7oGA69yZwgoZ2Zg3pFvJ7YiYWY90XMVTjtfIUYknbkvsh+
         YtHpkoMvLEUd/wl2D3eWaewgPEXihQ+r+1faSRq0+cMc0mgY16JOYp2lY+eiV940W0WF
         fdtaPx4MgO7u3TJE9/Ib9TcxvCeQMrSGGjUc8LjW5G33mjVg/DP8A5SsLQiByuXNvg7w
         jf/E2uTsueQelH4nrVnZAuEfq1rt8tI1nl+S3OuRdqovsAvLVjOzP85r9Rj/ZsiXybp9
         c0TT3mwvhE1XMnjzzSoKL6e9ZxmjP+tFIzsNPdl55K0fp2sGKc6okQkIKzWplBREtBHR
         Da6w==
X-Gm-Message-State: AOAM532yTtXQuk0+JVFzcoAFLsFIViQ4+Cb9Su4/3h45fwTm5rNPqyD2
        880h6kXPWvO3SZ54Zux3us0AxRQINPBi7rkLjjo=
X-Google-Smtp-Source: ABdhPJzUf3V8uGA6lFij62PoV9X732jqaLx0YawKF72AvJ55TJzfO/pShpSXckboLZsjFjahGDoOQBKvLLhfQbpKg8E=
X-Received: by 2002:a05:6830:b8e:: with SMTP id a14mr26833224otv.162.1630471407099;
 Tue, 31 Aug 2021 21:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
 <YS3Tv7UfNkF+adry@coredump.intra.peff.net> <CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDbdz7CCA@mail.gmail.com>
 <YS7rl8ynKD0fAerG@nand.local>
In-Reply-To: <YS7rl8ynKD0fAerG@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Aug 2021 21:43:15 -0700
Message-ID: <CABPp-BGkQTBBR_D-3EJPY-ONVYY4jjbEE4zA40n_oiz2DCrHgA@mail.gmail.com>
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 7:55 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Tue, Aug 31, 2021 at 01:14:55PM -0700, Elijah Newren wrote:
> > > Now I have spent zero time looking into actually coding this, so it may
> > > turn out to be much trickier than I am suggesting. But this seems like a
> > > much more fruitful direction, where we can protect users in cases where
> > > they benefit (and give them sensible and actionable error messages),
> > > without bothering people in the majority of cases where their cwd
> > > doesn't go away.
> >
> > Ooh, this sounds intriguing to me...but what if we changed that rule
> > slightly and just decided to never make the cwd go away?  Currently,
> > the checkout code removes directories if they have no tracked or
> > untracked or ignored files left, i.e. if they're empty.  What if we
> > decide to only have remove_scheduled_dirs() remove directories that
> > are empty AND they are not the current working directory?
>
> Hmm. My first thought after reading this is that it would cause
> surprising behavior for anybody who had 'git add --all' in their 'rebase
> -x' script. But would it?
>
> I.e., imagine somebody doing an in-place sed in a rebase and then `git
> add --all`-ing the result at each point in history. If the directory
> they were in ever went away, then the *next* revision would add that
> directory right back.
>
> That behavior seems somewhat surprising to me, or at least I could
> imagine it being surprising to users.

I'm not following.  `git add --all` doesn't add empty directories, so
I don't see how my proposed change would cause any problems in such a
case; nothing would be added back.

> Another thought is what should happen when the current directory goes
> away and then comes back as a file? We wouldn't be able to checkout that
> file, I don't think, so it might be a dead end.

I'm not following this either.  Peff's original suggestion was to
error out only when we knew it could cause problems, in particular
when the working directory would be removed.  Here I've shifted the
way the problem is viewed by just not removing the working directory,
but the end result is the same -- it errors out when the removal was
needed.  Given that erroring out is exactly what we wanted for a case
like this, why does that make it a dead end?
