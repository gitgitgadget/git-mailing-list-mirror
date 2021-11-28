Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51E2C433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 12:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357382AbhK1Mm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 07:42:59 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:37645 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357389AbhK1Mk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 07:40:58 -0500
Received: by mail-pj1-f54.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so13186630pjb.2
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 04:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9DwHRSaOrncO0W9KNAcSmjMK2qXm99qTgd/jnMKEmY=;
        b=aD51oDoOXbBOMhKZJlEGaGkboQWxawsvcDvjGaN7JdYrW38dZhUW0fXYjvkn6C1PGw
         +VpnPzH0bNvMxLRvXPpFEOf4fQeGSH4Eq3PmCQs4b0q9WzP6Nw6WyTKgbuoEvRVJwn/Y
         P26F6dgtzein4+h5bSZSP/PJZ0FToQIkSsKp6oHIPWc100XoRM/mp2vnPvVrLucIXn1O
         3nZ1W1x8RBgLwM3VGxyLe5iOFxxyLZnfPSFSf74msk4n6E0VNcLgUB0D+hWk+MCTiSaV
         mll3Ar2DAgYABch6uQq6SJH2fz4VcHwyS35d1GAPeJJCC7WhQUpi8noJzl2k9s90icAL
         XBbg==
X-Gm-Message-State: AOAM532WOPqkXDbYoV0JowzKVFc9S5u4gTZH6I4nFBgJyt7WY0QSlZeE
        xTTzVPfRp2WAyxa18V1FqQNtH/eBY515Xhq+iyazvpEvNCs=
X-Google-Smtp-Source: ABdhPJyJcppYj6fD8TRe9iLE4zEVAxU7+UrSLU3aJXBfHg00gu0VI8drl1t6ByTVD5+Ur0K3TcuhGcGE5wcXLd72kO0=
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr31148142pjb.236.1638103062545;
 Sun, 28 Nov 2021 04:37:42 -0800 (PST)
MIME-Version: 1.0
References: <CA+34VNLj6VB1kCkA=MfM7TZR+6HgqNi5-UaziAoCXacSVkch4A@mail.gmail.com>
In-Reply-To: <CA+34VNLj6VB1kCkA=MfM7TZR+6HgqNi5-UaziAoCXacSVkch4A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Nov 2021 07:37:31 -0500
Message-ID: <CAPig+cQ224Tz5iQ5Yt4fMadehLmrJWGzH7kwUSr+UT4hcQf14w@mail.gmail.com>
Subject: Re: misleading message printed when worktree add fails
To:     Baruch Burstein <bmburstein@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for reporting. Inline comments below...

On Sun, Nov 28, 2021 at 1:53 AM Baruch Burstein <bmburstein@gmail.com> wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> run `git worktree add <path> <branch>`, where <branch> is an already
> checked-out branch
>
> What happened instead? (Actual behavior)
>
> worktree was not created, but a confusing message was printed:
> "Preparing worktree (checking out '<branch>')"
>
> What's different between what you expected and what actually happened?
>
> The printed message seems to indicate that the command was a success,
> when in fact
> it was not

When I perform these actions, I see a "fatal error" message which
clearly indicates failure, not success:

    % git worktree add ../foo bar
    Preparing worktree (checking out 'bar')
    fatal: 'bar' is already checked out at '.../wherever'

Is your installation not showing the "fatal error" message?

Or, are you saying that the "Preparing worktree" message is
misleading? I read that message as telling me what the command is
trying to do (i.e. "Preparing"), and the error happens as it makes the
attempts, which seems logical to me, thus I don't see anything
misleading in that.

Are you reading it differently, as if it is saying that it already
performed that action (i.e. "Prepared")?
