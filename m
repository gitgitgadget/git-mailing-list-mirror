Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DADC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 01:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3790D20719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 01:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfedKMdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCZBhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:37:50 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39706 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZBhu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 21:37:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id d63so4104961oig.6
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 18:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbtO2xfMAD5flwkqZ9VP8IkMZDgyVOjSWXUi13wsnf8=;
        b=nfedKMdYPQ6EXlty5pqz3mnyl6CmbyxeUSusUgdCThbLxB14nrjettMCXyXEkrGHQZ
         MEdXMaPnVedyi4cOoDtNckSbuyqNVHhtex6ZyIF8tLEaSPiZmEKtofk4d8wCi4tVvfCk
         dGH2vw0iwTEDZNxOaDPvo94f6LlBQ0+dwUyV087a8uvMHWdA3DfjBhP7Ob2ZHfJhyDmp
         xDSw47s135lUC/sQgvsanfZTZRcRMB3mWC5TJmgBMUEFRsYN6pIS3dafGWpfa4wpwgGc
         tSoqy9QODOsUrB/1fA+KEHibLlNOBoM6uJD9mV/bZw9oraV2muUh1ANaGTJhvoNdDLOE
         4I9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbtO2xfMAD5flwkqZ9VP8IkMZDgyVOjSWXUi13wsnf8=;
        b=CpjIGqqe7xNpm3o9TGg2IYYZJ21EATdya9Av8q2GT13kJqzBjqMSq6HP2aB0opDNoj
         jb4tkoC8+SreLaF6QrbV88LQnl7Jw2LRAQsEc/1VjWYkrgAdDCEDbWXe/DIgXh2FcI+v
         qoT91vqKPnFlYECmTMrhkVaPUICNZxvsc8aXHaHqCW+H22bDL/VWQTG1xhCyizFvNcbq
         +qWUnHB1WCeinRdApcpii5SXAh8JuEiUFHgNy1+aKsQ+14W5Jiiv2NugRpTzqH44kMkd
         ZbGuihr21M3mMJXBTr4r/zWqH+KDjrK7qutUE56Cxbt3thbrvA7mBnSyDNPng2cPoEnj
         tMYg==
X-Gm-Message-State: ANhLgQ2WhB/vlVcQP5ThppZ+nmNf6gKiZFcQLIkbjojlfjM5Jivw7SQL
        ym9taeilJ/zs3MdHZKRu9OrvkmAoLGpJXtfJXkg=
X-Google-Smtp-Source: ADFU+vuPXQjATvGoznWYF/y26MiduQhCbj0W6y9/kjK9Wf8x348tWIThf3+51h2TYfakVfd0D42/oinQcvfmUN/NQOM=
X-Received: by 2002:aca:df45:: with SMTP id w66mr291839oig.76.1585186668972;
 Wed, 25 Mar 2020 18:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
 <20200325053908.GC651138@coredump.intra.peff.net> <CABPp-BF9LDfaw8=S4yqtuZ5U70Jcj_yZHq17Y7SUa17DwRqMSA@mail.gmail.com>
 <CAM+g_NtHC5ukU3jchVfud_H_m_h29UQ8vmwQoND8s_Q9Hv70Fg@mail.gmail.com>
In-Reply-To: <CAM+g_NtHC5ukU3jchVfud_H_m_h29UQ8vmwQoND8s_Q9Hv70Fg@mail.gmail.com>
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Wed, 25 Mar 2020 18:37:36 -0700
Message-ID: <CAM+g_Nvt3X4d5cjKajzDOcoDgNS4bVkj3a0KvVm4yDEW-J7v2w@mail.gmail.com>
Subject: Re: "git rebase" behavior change in 2.26.0
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have to wait for a few hours to see more changes in that branch that
showed this behavior.

I tried with this branch just now and my repo is in sync with
upstream.  Nevertheless, I see messages about operations for both
backends now for `git pull` which I don't remember seeing before:
% git status --untracked-files=no
On branch nextrelease
Your branch is up to date with 'origin/nextrelease'.

nothing to commit (use -u to show untracked files)
% git -c rebase.backend=merge pull
Already up to date.
Successfully rebased and updated refs/heads/nextrelease.
% git -c rebase.backend=apply pull
Already up to date.
First, rewinding head to replay your work on top of it...
Fast-forwarded nextrelease to d008080d3f2dc5a9af30067f705a3cb26ed847b3.
%

Why is git doing anything if the branch is already up-to-date? The
commit it ff to is the HEAD of that branch so I don't think anything
is really changing. Also, if I use `-c pull.rebase=false` I see what I
think is the 2.25 behavior

% git status --untracked-files=no
On branch nextrelease
Your branch is up to date with 'origin/nextrelease'.

nothing to commit (use -u to show untracked files)
% git -c rebase.backend=merge -c pull.rebase=false pull
Already up to date.
% git -c rebase.backend=apply -c pull.rebase=false pull
Already up to date.

I had `pull.rebase=true` configured for quite some time now. And yes,
I should set it for just this "never push" branch instead of for all
branches.  I just tried with `-c pull.rebase=false -c
branch.nextrelease.rebase=true` and that shows
the same behavior as `-c pull.rebase=true`.

One potential difference: I have tons of untracked files in my working
directory. Could that make a difference?

On Wed, Mar 25, 2020 at 2:39 PM Norbert Kiesel <nkiesel@gmail.com> wrote:
>
> I will try to reproduce and will report back.
>
> On Wed, Mar 25, 2020 at 2:21 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Tue, Mar 24, 2020 at 10:40 PM Jeff King <peff@peff.net> wrote:
>> >
>> > On Tue, Mar 24, 2020 at 08:38:04PM -0700, Norbert Kiesel wrote:
>> >
>> > > I track an upstream repo with "pull.rebase = true" where I do a `git
>> > > pull` followed by a `git log -p ORIG_HEAD..` for a branch to see
>> > > changes since the last "pull".  I normally do not commit to this
>> > > branch and thus this normally is a "fast-forward" merge.
>> > >
>> > > Starting with 2.26 this no longer works because ORIG_HEAD is always
>> > > set to HEAD after my `git pull`.
>> > >
>> > > I track other prances from the same repo where I do local changes and
>> > > then want the `git pull --rebase` and I thus do not want to
>> > > give up on the `pull.rebase = true` configuration.
>> >
>> > I can imagine this is related to the switch to the "merge" backend for
>> > git-pull, which may be more eager to overwrite ORIG_HEAD. Perhaps try:
>> >
>> >   git -c rebase.backend=apply pull
>> >
>> > and see if that behaves differently.
>> >
>> > I tried to reproduce what you're seeing, but my recipe doesn't seem to
>> > show any difference between the two versions:
>> >
>> > -- >8 --
>> > #!/bin/sh
>> >
>> > rm -rf repo
>> >
>> > git init -q repo
>> > cd repo
>> > echo content >base && git add base && git commit -q -m base
>> > git clone -q . dst
>> > echo content >new && git add new && git commit -q -m new
>> >
>> > cd dst
>> > git rev-parse HEAD >.git/ORIG_HEAD
>> > echo before: $(git log -1 --oneline ORIG_HEAD)
>> > git -c pull.rebase=true pull -q ..
>> > echo after: $(git log -1 --oneline ORIG_HEAD)
>> > -- 8< --
>> >
>> > We don't seem to touch ORIG_HEAD in either case. But maybe a more
>> > complex set of pulled commits would trigger it?
>>
>> I can't duplicate either.  I suspected that perhaps rebase.autoStash
>> might help cause it to happen if you had local changes, but I didn't
>> succeed in reproducing with that either.
>>
>> Norbert: Any ideas what you may be doing differently to trigger this?
>> And does it still happen with rebase.backend=apply, as Peff asked
>> about?
>>
>>
>> Elijah
