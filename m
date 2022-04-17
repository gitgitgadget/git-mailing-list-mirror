Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB369C433EF
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 05:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiDQFkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Apr 2022 01:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiDQFkP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Apr 2022 01:40:15 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E642E9D2
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 22:37:41 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q22so5258003iod.2
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 22:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPuilfmAK0M3pcM63OE37N/X+E4w8hYrBVMFjz88DKY=;
        b=Eu6TZHqhvh3l8CoxVdQPjspxDxI81dvSoWY7EcxNvf0BKLpotwPSXc+zRuavIAIAqR
         kehCgbCVgPH/5XOAXwC22kmsgnJA+VARsKbh7xAab1nTcAS53/bAZ0wzUEJ3kbtHbqDU
         SF+HRoo4sSMSRH06M8jj/aZMtDFWFeTscNCaaMMV3GM0YsH+1JH75+W1yKhQxBqhc5XX
         VaqtL/iwtfJ07a05TFsifU8BnwVncuTUZek0PaatHHRvAyTZRxSrPXsVkCYZtUyBHEy0
         l6upNXxo6+G55dUvOHVoX5w0MD34yPnQK6kEINBKZN55vF99ko4kyqVdXNF+02IvFd85
         jqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPuilfmAK0M3pcM63OE37N/X+E4w8hYrBVMFjz88DKY=;
        b=aLtcmjNlSrzo4yTeaocgGEgxxfK8cs+TDCXFC8Ua3EUV66Uaq5xizO7jjluicIY1Js
         jmy6AnHS6jTwL3tuXk1CRD1sUlvyL+fIMTgLz0Bkb+v6FffJXxcXePwo0V9HA/Jx6ZsR
         /mFblpjD1WaaiH9ik30uxrlm17Z/zYLfnjNrWvxNQz212p3jJm7NC9NbA7bcAuihFaC7
         YNuspLh5rft8dRE0Wh3OF+Qf+AJ2drZZe9HPyxHmSQCVwcf1T+ER2j0q+gq2/fGdU756
         2sA9/80rsKXKaAdRsRSkPA19yOiOYDMNtLPyVx9/ZYeVZh61REc191Ik905NiQIDNcG+
         VBLw==
X-Gm-Message-State: AOAM530mPjEht8Ap7ST8WM3IaaXBueH7LduX5BZWpFkS0ZkUN7Ro34mg
        uQ8s6gdakapWkbrit8eOBCagXS87yuxVyc6F650=
X-Google-Smtp-Source: ABdhPJzsFWkn5odOEnKAp9GAJnrJixpKuJL3mSxP7jGe/BSDnAZFa5VcaM55MnuyY9BEl66sikQJph01j5RlaqS8Lws=
X-Received: by 2002:a05:6602:59e:b0:64c:b96e:aa4f with SMTP id
 v30-20020a056602059e00b0064cb96eaa4fmr2369214iox.126.1650173859954; Sat, 16
 Apr 2022 22:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqq4k2wap8g.fsf@gitster.g>
 <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
 <xmqqbkx2ccj4.fsf@gitster.g> <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
 <CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com>
In-Reply-To: <CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sun, 17 Apr 2022 07:37:27 +0200
Message-ID: <CAOc6etb7fmO2FAv09+wHsDBwnLsBi+B-CwRarm2tfYS-aUWcfg@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2022 at 7:05 AM Elijah Newren <newren@gmail.com> wrote:
>
>
> Replaying merges is something I've put a little thought into, so allow
> me to provide some pointers that may help.  Merges need special
> handling for replaying, and in my opinion, doing either just a new
> merge of the new trees (what rebase --rebase-merges does), or just
> reusing existing trees (what you proposed to start this thread) are
> both suboptimal, though the former is likely to just be annoying and
> require potentially unnecessary user refixing, whereas the latter can
> silently discard changes or reintroduce discarded changes and could be
> dangerous.  More details on both of these...
>
> An important part about merges is they may have resolved conflicts --
> both textual (the standard conflict markers people have to resolve)
> and semantic (e.g. one person changes the API of some function, and
> the other branch being merged adds a caller of that function, so the
> merge has to modify the new caller to use the new API).  We do not
> just want to do a new merge and re-use the commit message (as rebase
> --rebase-merges does), for two reasons: (1) the user either has to
> re-resolve the textual conflict resolutions by hand, or use rerere
> which requires a working tree (and we'd like replays to proceed
> without a working tree where possible), and (2) it tosses semantic
> merge conflict resolutions entirely.  We also do not just want to use
> existing trees as-is (as you started with in your patch), for three
> reasons: (1) when we move to a new base the new merge needs to include
> the changes from the newer base, (2) the topic might have additional
> changes added (or removed) during the "rebase" which need to be
> reflected in the merge as well, and (3) the merge may have had
> additional changes stuffed directly into it to solve semantic
> conflicts which we want "ported" to the new merge commit.    So, for
> handling merges, we should avoid both of these overly simplistic
> mechanisms, and do something that tries to handle forward-porting
> these conflict resolutions.  I have outlined steps to do so at
> https://lore.kernel.org/git/CABPp-BHp+d62dCyAaJfh1cZ8xVpGyb97mZryd02aCOX=Qn=Ltw@mail.gmail.com/
>

Hey, Elijah! Thanks for taking the time and the feedback.

Forget about me introducing replay as a separate command as a "real"
proposal. My intent (and which I saw most simple to be able to show
it) was to present the idea of an optimization (if you will) to the
rebase mechanism under certain rather narrow conditions:

git rebase --onto A B C

if A^{tree} == B^{tree} that means that we could create an equivalent
commit for the segment B..C on top of A without much hassle by reusing
the same trees from that segment (no need to calculate new trees...and
no need to move along the working tree as we are creating those
commits).

My impression from reading your feedback is that you have a much
broader scope in terms of what you want to achieve.So, for the time
being, I will work on trying to get the optimization in rebase and see
how far I am able to move it forward.... and you are able to keep
replay as a separate command if that is your will for the
not-so-distant future. :-)

BR!

PS I will be snooping around all of that material you are linking as I
am sure there will be interesting stuff in there. And thanks, again!
