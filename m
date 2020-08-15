Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE50C433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7322053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOMppGXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgHOWBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgHOVvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:25 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4F2C02B8F3
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 06:05:00 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id j23so6016173vsq.7
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+b4ysnhkrYcwa88dweFhWhNFj+JAQJih2bYH+U7U1IE=;
        b=tOMppGXJjcPX69cJAgLMUTFCn1mmKTd2rGzUEemssC3AMTuwE05apCLeiSiavkGqCl
         b+DSq65cYws5RHVVEbs/3M915+nukk586Q22OVJ/jea1qFnTEqs1tTG9F1giZmd8WGC7
         XiWN7cWyCAs3Dh9aYjdh1O480v0TNqTlxMSzljLHTvZpYbxfm5xlRVewk6syiacBIhSg
         Cm3tslAR8SRHNPNkKIZUoH2mLiWIIaBilG1qv9z3O5/rhds4+spGV+QB+uRnlTlk0csZ
         OXfWNrGtUBspLaDV50HL9nus9DKFglrXAdEUSCGNDS5cPfsf6TIWCYcjekW5JDeWr1x+
         V1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+b4ysnhkrYcwa88dweFhWhNFj+JAQJih2bYH+U7U1IE=;
        b=rDRgKpXQU21CyBkw4YpBeMT05X8REupcHZ3WnzusgR6rEO0c47MhErOEP0cRDhnwb4
         x5HUG95abllb7AD9ZaIasieLzbDZmzCo6a90SZUt5TZY4G9j3DiHZ5b4D2HZ0YUZpQ65
         VIoGDVpsgGcI17KgOOixLhnbkN59EHOMLRzmvacisdoLUcJbgRokA3tujECEVNB5Hn9I
         Kpl3yefy7u8INqJ2576lj49floLa4bV9keLbaCZ2nwl/Q5jcn1nK0qMBT5MQx4iei/p+
         fK63uO0LPaoNztFDwDk2CU7wLwUtBnZZcG6oXjm97dF3S69w3qavoZnuWmStkGm7Ov2Q
         RNbg==
X-Gm-Message-State: AOAM53295wsM7r4SxWKC8UsRWdB9o+5Uu7W09Cxx4RQ5KFyCoVnH+/I3
        IUFrbv7BRgADxdGMaKUjNLBv3gpbc1kiS+EDa5+xp5bef9kIUg==
X-Google-Smtp-Source: ABdhPJyXQzM4eCo+eSe+uogBuRTjntZnh6sI3lF1XrU3oxtSkDmlZ3Ug9WJKN90VwHcquWil2NaPP3wJ9Id+KuVOC9M=
X-Received: by 2002:a67:1e81:: with SMTP id e123mr3645448vse.210.1597496698515;
 Sat, 15 Aug 2020 06:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxw2KudBPfpmVqU9VOfnvrKdczU6Us5FWvpj50T88BarHw@mail.gmail.com>
 <20200814220828.GP8085@camp.crustytoothpaste.net> <012301d67289$c5c36010$514a2030$@nexbridge.com>
In-Reply-To: <012301d67289$c5c36010$514a2030$@nexbridge.com>
From:   jim.cromie@gmail.com
Date:   Sat, 15 Aug 2020 07:04:31 -0600
Message-ID: <CAJfuBxxqxKAFd_3F5ZKWjfmWA0v+kKX6mNqQA=sGYaP-NYXDSQ@mail.gmail.com>
Subject: Re: git bisect enhancement request
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

good questions, thank you both

On Fri, Aug 14, 2020 at 4:25 PM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> On August 14, 2020 6:08 PM, brian m. carlson wrote:
> > On 2020-08-14 at 21:11:19, jim.cromie@gmail.com wrote:
> > > please teach git bisect how to use 2 separate worktrees for the
> > > bisection, toggling between them as bisection progresses, so that the
> > > end result is 2 compiled kernels, one broken, one good.
> >
> > I'm not sure how such a thing would be implemented.  Git doesn't know u=
ntil
> > after it's checked out the tree whether a revision is good or bad, sinc=
e usually
> > the user needs to tell it (or use git bisect run).  Even if Git alterna=
ted between
> > the two worktrees in order, that doesn't mean that one of them will end=
 up
> > being good, since Git may find the last good revision early on, then co=
ntinue
> > to bisect and find many bad revisions until it determines the right one=
.
> >
> > Can you tell us more about the algorithm you'd like to see here?
>
> I'm wondering more about the requirements on this. Does the bisect manipu=
late both worktrees at once or separately? Are these worktrees variants on =
a theme but on different branches (so synchronizing the commits would proba=
bly be impractical) - or bisect both workspaces but using different commits=
 as start and end (this should be scriptable)? Does it flip back and forth =
between the two worktrees doing a bisect in one, then the other (this shoul=
d be scriptable)? Or is this just to teach git to bisect a worktree in a di=
stinct manner - which, correct me if I'm wrong, I think it already supports=
.
>
> Or is this more, I have two worktrees on basically the same branch. When =
bisect happens, one worktree is bisected, tested. If the new code succeeds,=
 and the other worktree is in a failed state, don't bisect the other worktr=
ee in the same direction - that's not right, but I think I know your end-st=
ate goal: keep bisecting both worktrees until a state change. What that is =
leading to is really something different, which is that once bisect is done=
, you know which commit introduced the bug, so set one worktree to the work=
ing commit and the other to the broken commit. If that's the case, it's not=
 a toggle, but an end-state operation to set two worktrees to adjacent comm=
its essentially surrounding the introduction point. Is that what you want?
>

heh - reading paragraph 1, I thought "yeah thats it"
but then paragraph 2 ...

its more about the end-state as Ive thought about it,
and I casually leaped to it being useful at every iteration.
Having 2 worktrees converging on good/bad yes/no old/new
does seem generically appealing, but I dont have a solid use case.

My best generic argument is that determining good/bad on a build can be har=
d,
and having the previous build(s) around could be useful.

Broadening, having --last=3DN wktree-g<sha8>s, in a grove/orchard
would be simple to explain (N=3D0 currently, wo naming games)
Accepting a 'wktree' prefix, and adding suffixes like
5.8.0-v1-00025-g8bfb9456e727-dirty
(with a strftime-like format "%v-%u-%5N-%14g-%s" ideally)
would sidestep any 'policy/methodology' implied by wktree names.
having -00025 etc would give cheap look at bisect convergence.

and having 'planted' a grove of bisection points, one could leave it around=
,
for subsequent use as a "re-bisection cache" to retest against a
iteratively refined bisect run script

Im now speculating hard, I hope it makes some sense.

My fever dream is to have a gdb-mi script/program talking to 2 separate tar=
gets,
and "bisecting breakpoints" back from where the bad one panics, to the poin=
t
where the gdb trace diverges between the 2 targets.

and I want to run rr record vmlinux inside qemu, with quick
deterministic replay,
and a tight "breakpoint bisection" loop.  But I digress. And a pony.

thanks for your considerations
Jim

> Regards,
> Randall
>
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
>
>
>
