Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6BBC433EF
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 16:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350807AbhK1Qym (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 11:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353162AbhK1Qwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 11:52:41 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EADAC061748
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 08:47:52 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id j2so34978243ybg.9
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 08:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4I/VzjHcSTR/ReYPm2D37wG6rIg9vm416Uc8X1hF+48=;
        b=I2klB866jCzSjOgadzpqK9BVo/Kn/Kkez2qlFVSFFlwUPH0Vc25yAAS7+2GfU/Gjmd
         H78+uvW8F5zlnigorT9dn4VTW9Rt0zWDHL/5Kv1+cCUUn/u/oQTwZi6UVO/ccLMsAoji
         aTwxXUWctQo3DnHhoejzfjJdY1CQMMUikT7piaMR3Sy7+7F1LGUiZfdMP5PFHWTJrNPt
         /xby5khOf4VPxj3O2nW74ZIKMwpWyQnDFuFVwhm2BMtoaFbvgZfeGeL5CvG3/mmGyP56
         gFdn23llhR/tCu2tq2VL7qOixtJYrgQvVp7TcTF9dmjhjJEqBPJNxSTRnbI+9NmSq5Qt
         8csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4I/VzjHcSTR/ReYPm2D37wG6rIg9vm416Uc8X1hF+48=;
        b=v1mK31ZuVK2tJBTZooAZadUlaTG+9qY6lb845wKit6vphCDC1jZdyWD0KwsviIH7M8
         7THUtm4liWWiq5nNm6/iJ7Xy0xVeV1bcI8RAc1eMXJDukgWuHHEZfV5epFiN3tug8NA1
         pwVo+9NH9Xa8PhnyxZkMRAVQSQxx2/BbKpRZyy4Cl/IEmLsXp8EBXyleWSnZwqJnkS8f
         w1wxgyjP3f2dXpRo7r+mu4BVpg9qXgnrhcjmFACamI5O50S4TKdfeMdWn6LvGeJtyAyC
         JNnwmojltfApGfvDj26WC/t487P41xKIdDKx7dIz55Uj6wiYpnZo6E7wRt1HqajFcyP8
         8Nfw==
X-Gm-Message-State: AOAM530cuiyKVpFkv96G+FfN5IdCFcTlFS345W79mjoEPKhBzJSOjG1p
        wWMdOdoFohMeuVXP7ICL0wtVtYw3FHhR83GDtN+gLP2RbYY=
X-Google-Smtp-Source: ABdhPJyIQJaQcy0EOt1lS0oeY13j30ngdYubKMQjvpWIT6/QMU3uCqoGlokNPrBYkTmy/SMZJ+ZZHXH+i7plKAIEolA=
X-Received: by 2002:a25:3307:: with SMTP id z7mr30407599ybz.129.1638118071117;
 Sun, 28 Nov 2021 08:47:51 -0800 (PST)
MIME-Version: 1.0
References: <CA+34VNLj6VB1kCkA=MfM7TZR+6HgqNi5-UaziAoCXacSVkch4A@mail.gmail.com>
 <CAPig+cQ224Tz5iQ5Yt4fMadehLmrJWGzH7kwUSr+UT4hcQf14w@mail.gmail.com>
In-Reply-To: <CAPig+cQ224Tz5iQ5Yt4fMadehLmrJWGzH7kwUSr+UT4hcQf14w@mail.gmail.com>
From:   Baruch Burstein <bmburstein@gmail.com>
Date:   Sun, 28 Nov 2021 18:47:14 +0200
Message-ID: <CA+34VNJbOHYhYgN+p7EsGiRAzf+aAQGeMxCzG1dizFjDRVQVbg@mail.gmail.com>
Subject: Re: misleading message printed when worktree add fails
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see them in the other order:

    fatal: 'master' is already checked out at 'C:/Users/bmbur/temp'
    Preparing worktree (checking out 'master')

which I understood as "there was an error, but we managed to recover
somehow and set up the worktree anyway"


On Sun, Nov 28, 2021 at 2:37 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> Thanks for reporting. Inline comments below...
>
> On Sun, Nov 28, 2021 at 1:53 AM Baruch Burstein <bmburstein@gmail.com> wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >
> > run `git worktree add <path> <branch>`, where <branch> is an already
> > checked-out branch
> >
> > What happened instead? (Actual behavior)
> >
> > worktree was not created, but a confusing message was printed:
> > "Preparing worktree (checking out '<branch>')"
> >
> > What's different between what you expected and what actually happened?
> >
> > The printed message seems to indicate that the command was a success,
> > when in fact
> > it was not
>
> When I perform these actions, I see a "fatal error" message which
> clearly indicates failure, not success:
>
>     % git worktree add ../foo bar
>     Preparing worktree (checking out 'bar')
>     fatal: 'bar' is already checked out at '.../wherever'
>
> Is your installation not showing the "fatal error" message?
>
> Or, are you saying that the "Preparing worktree" message is
> misleading? I read that message as telling me what the command is
> trying to do (i.e. "Preparing"), and the error happens as it makes the
> attempts, which seems logical to me, thus I don't see anything
> misleading in that.
>
> Are you reading it differently, as if it is saying that it already
> performed that action (i.e. "Prepared")?
