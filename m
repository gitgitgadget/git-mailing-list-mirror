Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346EDC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42B4233F8
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbgLITGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgLITGD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:06:03 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2656C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:05:22 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id o25so2874145oie.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gj8lX9vRgN43jH5nWRYAagt1l3NM1WRO4XMg19MI0bU=;
        b=GzcUAjWrW3ao5A8eySkYZO6GWbqNvUMNyebJ/f7jqRW35mYyPvzfK243WZlEcw3HHB
         VH7drhE5LgnH+hBad7ZlErY+Tsk5bcbub2HO8qbuYIMEZcdWZ5KPUT4FrnP8lzcF9FlL
         jI9q+l+AJnyG5Qe+jF8JWVIEHYtGYBBLWyimLO+2Xelz1QdEVQILKzhaaHpCnaAEdcE7
         vnSCINZflCklDoIZws54C6rSJnmIOSFAeFO56ua+cT305hTR9zVMU4a4b3qZelr1dVj0
         1DEUAkv8tUoysvQb5hLIQ5d72XCpu5K99oopNWz46ucR9F7yIbJmlhv3gRk4WNXReBFv
         luFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gj8lX9vRgN43jH5nWRYAagt1l3NM1WRO4XMg19MI0bU=;
        b=gLw8j4dhHbK82AlzcwADRXY7LFkvUrAo+WZlmiyl7jL1P/QIDxNtNZ/fxXtk2GexgA
         Xn8hNW55QJdrIMlIV/zHR+LANrOgdco8U8Wkx7swAhoceKrNquW7Lq/j/n2jWl2VpDUp
         5kZ7rfanF1t6qXnrH87FQT0QbeDgYPD63U8LvPFdJ8KfM9d2dl0s+f89yqeR2TfgXJ1Z
         edQjnO8HhNTpE2ytidIAAvKELHDGHyHafHUcS85k+iXTOWCWTJ21wdO4jq+9ktRp6/Qw
         zZUvwf38BvH4ikZNekFYXV6oP1cVi7jZN+t4EIDNssqMqMXBv20ltcAPO7brmMszOt0Q
         AN7w==
X-Gm-Message-State: AOAM530lbSUssKLf2zr+Zjy3W+dqW5yv6B3vHYcrV8ki07AtqF/bQWsI
        OH7yAMI12GLSQAo9vsM0XSjMwAdW5tutWvrDhHp9XWRSoojD4w==
X-Google-Smtp-Source: ABdhPJwg9hZiMF2lCfeO7xZSBJMbSkbTHR2OwAV8lAmmvmOsil0gqPb4GTa5XL3LdvJ11iDwfAZ2UYvy1f5t/UhGNRE=
X-Received: by 2002:a54:4704:: with SMTP id k4mr2833981oik.39.1607540722025;
 Wed, 09 Dec 2020 11:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
 <xmqqeek2cc14.fsf@gitster.c.googlers.com> <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
 <xmqqpn3lbhxn.fsf@gitster.c.googlers.com> <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
 <xmqqlfe99yvy.fsf@gitster.c.googlers.com> <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
 <xmqq360h8286.fsf@gitster.c.googlers.com> <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
 <xmqqy2i86ok1.fsf@gitster.c.googlers.com> <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
In-Reply-To: <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Dec 2020 11:05:11 -0800
Message-ID: <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Dec 9, 2020 at 1:53 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Tue, Dec 8, 2020 at 2:16 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> > > That is exemplified by the fact that this whole thread started from a
> > > user that refused to configure pull.rebase and expected the Git
> > > project to just do the right thing (which is basically choosing a
> > > useful default).
> >
> > Which is basically asking for impossible, and I do not think it is a
> > good idea to focus our effort to satisfy such a request in general.
> > There is no useful default that suits everybody in this particular
> > case.
>
> I think I already made this point, but this is the nirvana fallacy
> (the perfect is the enemy of the good) [1]. Just because we can't have
> the perfect solution doesn't mean we can't pursue something better
> than the current state.
>
> What was asked was not a perfect solution, just a better default. If
> right now the default is good enough for 20% of users, and with some
> changes we can make it better for 40%... that's progress. We don't
> have to wait until we have a solution for 100% of them.
>
> > But for anybody who uses git for real (read: produces his or her own
> > history), it would be pretty much a useless default that forces the
> > user to say rebase or merge every time 'git pull' is run.
>
> This is not true.
>
> I will give you a real example.
>
> I create a branch named "fc/margin" based on "master", I make my
> changes, I push the branch to my personal repository, and create a
> pull request. This is the typical triangular workflow.
>
> Then I do "git pull [--ff-only]". What will happen? 1) As long as my
> branch is not merged upstream, I will get an error, and my branch will
> stay where it is. But then, 2) when my branch is finally merged to
> "master" it will be fast-forwarded, so now both "fc/margin" and
> "origin/master" point to the same commit.
>
> A. Did I use git "for real"? (produce my own history)
> B. Was "git pull [--ff-only]" useful in this case?
>
> I think that one of the problems is that Git has so many different
> workflows that finding another person that has your same workflow is
> like finding a person with your same birthday. It's not impossible,
> just takes more than a few tries.
>
> Also, and this is not a deriding question, I'm genuinely curious: how
> often do you send pull requests?
>
> BTW, this example above is real [2]. In my particular case very often
> I'm creating history, I'm just not the one pulling it.
>
> > But other than that, I do not
> > see any real use for the choice, which would mean in practice,
> > pull.mode would have only two useful values, rebase or merge.  That
> > does not feel a good enough reason to supersede what already exists,
> > which is pull.rebase=yes/no.
>
> The fact that you don't see the use doesn't mean the use is not there.
>
> Why do you think this issue keeps coming back again and again, and
> again? And every time it comes back people say the same thing:
> "fast-forward-only merges should be the default".
>
> Unfortunately it's not that simple. It's a rabbit hole that leads to a
> cacophony of issues in git pull. However, we can fix some of them
> *today*.
>
> > Perhaps there is a good reason why certain classes of users would
> > want to configure pull.mode=ff-only (i.e. "I might type 'git pull'
> > by mistake, please stop me if I did so on a branch I have real work
> > already.").  If that is the case, I would very much agree that it
> > would be awkward to express that choice in the current framework to
> > choose between pull.rebase=yes/no and pull.mode=(rebase/merge/ff-only)
> > would become a lot easier to explain.
>
> There's three options:
>
> 1. pull.ff=only (that doesn't work IMO)
> 2. pull.rebase=ff-only (that works, but it's kind of wonky)
> 3. pull.mode=ff-only (maybe it should be pull.mode=fast-forward)
>
> But the current option (pull.mode=merge) just doesn't fly. And BTW, I
> did create a poll in reddit's r/git [3], and 67% (of 789) said they
> didn't specify anything, just "git pull".
>
> So, most people simply do "git pull" and hope for the best.
>
> Moreover, in 2014 I said if we don't fix it now (which is likely), we
> will be discussing it again [4], and here we are now. And I'm saying
> it again: leave the mode as "merge", we will be discussing this again.
>
> I could do some mail archeology if you want, but this issue starts to
> be mentioned at least since 2010, and virtually everyone (except one
> person) agreed the default must change, even Linus Torvalds. Reading
> back what Linus said [5], it's something very, *very* close to what
> I'm proposing (I would argue my proposal is better).
>
> So you let me know. Do you want me to dig a decade of discussions and
> coalesce those conclusions into a summary so we can decide how to
> proceed? Or should I drop the plan? Only that if we drop it, I
> *guarantee* we will discuss it yet again years later.
>
> Moreover, this is the reason why I split the series in 3. Even if you
> decide you don't want to change the default, part I of the series can
> still be merged *today*, and everyone would benefit.

Have I missed some subtlety here?  This whole email appears to me to
be arguing against a strawman.  Reading Junio's other emails in this
thread[1][2], it's pretty clear he thinks the current behavior is
buggy and suggests how it should be changed.  From what I can tell,
you appear to be arguing against doing nothing and against only
accepting perfection, neither of which were positions I saw anyone
take.  In fact, the positions you argue for at length appear to
exactly match the ones he took[1][2].  What am I missing?

[1] https://lore.kernel.org/git/xmqq360h8286.fsf@gitster.c.googlers.com/
[2] https://lore.kernel.org/git/xmqqlfe99yvy.fsf@gitster.c.googlers.com/
