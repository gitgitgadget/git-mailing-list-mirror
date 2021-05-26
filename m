Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E08C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 16:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA0B613B5
	for <git@archiver.kernel.org>; Wed, 26 May 2021 16:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhEZQKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 12:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhEZQKd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 12:10:33 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256AFC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 09:09:02 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id v22so2012059oic.2
        for <git@vger.kernel.org>; Wed, 26 May 2021 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbbltQyTtxsAs6zeefmXYruuDZxO3xuc59PaoeGiZbw=;
        b=PnF/oHYURm22abhUus+R60vCpMFAiWLjz0kDVCiGGwfUeHVYIBOPhcmuf8itd4Z5Dx
         Ai7zI2mrWivnPJhZORkTNrH4Wgya7PF8myxiXtBUw/3LWWI6d+Ve7V98dxRgwS94vBdk
         lvrF4MjjMPQoI02lMyA5zbzUdTkHM7PhCxrz0YfaU0yaIrMCDJzx6w/KCqdLhvxKhpV7
         ShEcY+e+fKMqgL/a109ER9zGcoTmH62KZ3LQEkor/ZbaNnv3cA5MB/0Mw7kYaEx2UAIf
         xUdGBJz7VDszgF1RKzaL45ZFaT971h7oRtxfERaCLSIjur+T94SnBcuSRHrK4WnqzCVs
         S8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbbltQyTtxsAs6zeefmXYruuDZxO3xuc59PaoeGiZbw=;
        b=GM/aye3fR3ehMXIXvioJ3EpX0EXsB+B7DOP+DyA1+W4xjnhgcHhblVH5UpxosCvKOz
         y8SS0KndTR30rZINg0Vb/jqMmz4EVbYeSH5uuMonR0se1COztdF2qntEGrEcAWZhyKvn
         exiReBQ9rtJAgtbnG58t0doyGxN1IaNbO9FzadWbHhSjZmJuYOIcgGB5MuF/69lTAJ+4
         zAiza1TvEh4ijSLWTRq/PyOyy7Y2D7l/FXLWdfghcHbntFTSbNUTLs2iLPosNov7GGaA
         zdeSoJi+6FwEsWaj99LaglVyXOpm4Oqlu1mI8jL+IVJU/NdD030MrI7AmjoV3e5s4JVF
         +dgA==
X-Gm-Message-State: AOAM5316X+BEclmqEXzYyFXKkxt1+QWY46cVndQT8HI0aWGzu+pPXqWP
        bvzh/orlOViucquXHopDKAcx/ycgSqkLDGl2LbRnB7Z9Qu4=
X-Google-Smtp-Source: ABdhPJztX5uhObN7RyArNDUYzq8N77VMo25Mkk0E8QLtAo35pPBVKWg63EEV27q7kP1vtrn/7+aGUilUj2nMDRtDxR4=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr2404767oiw.167.1622045341561;
 Wed, 26 May 2021 09:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <79e26cee-daed-d52b-76d7-692f5cb2e20a@gmail.com>
 <CABPp-BHq+=Q6EDNOHJGoUvJsezn=hbQORT=0NRghREf=cnwCYQ@mail.gmail.com> <365cecf9-2ce7-9d8d-6898-3234807df963@gmail.com>
In-Reply-To: <365cecf9-2ce7-9d8d-6898-3234807df963@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 May 2021 09:08:50 -0700
Message-ID: <CABPp-BHKirQiKB3yWRVN63pVF49DroDkdmD2Q6o+w-BFk5Y=vQ@mail.gmail.com>
Subject: Re: git status when merging non-conflicted 3-way merge says "All
 conflicts fixed"
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 9:06 AM Igor Djordjevic
<igor.d.djordjevic@gmail.com> wrote:
>
> On 26/05/2021 16:30, Elijah Newren wrote:
> > On Tue, May 25, 2021 at 1:22 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > Supposed that we have following commit graph:
> > >
> > > ----A----B----C----D <- master
> > >                \
> > >                 ----E <- e
> > >
> > > When we merge e branch by `git merge e`, obviously we will do 3-way
> > > merge. Assumed that the merge doesn't conflict, Git will fire up
> > > editor to edit `COMMIT_EDITMSG` for us to enter merge commit
> > > message. Then we abort the commit by either delete all the lines
> > > there, or comment all of them.
> > >
> > > But when we check status by `git status`, Git says:
> > >
> > > > On branch master
> > > > All conflicts fixed but you are still merging.
> > > >   (use "git commit" to conclude merge)
> > >
> > > That message above is misleading, because we know that our merge
> > > doesn't conflict (3-way merge applied successfully without conflict).
> > > However, it makes sense only when we have resolved all conflicts
> > > on the conflicted merge.
> >
> > Once upon a time, that message would have always been right.  Then a
> > --no-commit option was introduced to git merge, and editing of commit
> > messages for merges was also added.  As you note, both of those can
> > yield cases where the message is misleading/surprising.
> >
> > > So for non-conflicted merge, we can say instead:
> > >
> > > > On branch <branch>
> > > > You are still merging, and the merge applied without any conflicts.
> > > >   (use "git commit" to conclude merge)
> >
> > At the time this message is printed, there is no way for us to know
> > whether there had been conflicts.  We'd have to record that
> > information somewhere (probably the index, though introducing another
> > index format just for this seems like a really high lift for such a
> > small thing, and may conflict with other efforts to extend the index
> > format, such as the sparse-index work), OR re-do the merge when the
> > user runs status just to find out whether there had been conflicts
> > (which seems like overkill, and would require you to know which merge
> > backend had been used and with which flags so you could re-check with
> > the same one; further, three of the merge backends -- recursive,
> > resolve, and octopus -- all update the working tree and index and thus
> > could not be used for a case like this).
> >
> > Seems like opening a really big can of worms.
>
> All said, would it be an improvement if current message would be
> simply reworded to say "No conflicts but you are still merging"
> (instead of "All conflicts fixed but you are still merging"), thus
> stating the fact (there are no conflicts, indeed) but not implying
> how we got there (whether conflicts were fixed, or there were none to
> begin with)...?
>
> Regards, Buga

Ooh, now that seems reasonable.  Much cleaner solution.
