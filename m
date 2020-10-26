Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67D4C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 11:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3B322265
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 11:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeRBdTKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773809AbgJZL3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 07:29:39 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:36277 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773806AbgJZL3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 07:29:39 -0400
Received: by mail-il1-f174.google.com with SMTP id p10so7897376ile.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 04:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3MQkVFmz50CKygVlS5wBFEMV19XQkctwc34C5jTipA=;
        b=NeRBdTKGBoevnGHN6FRJJ7fWPQt8ViFoXPncSRMMN8qSOrb4ZE6BAdV1yaca8XUaAY
         NzOEmOyUFsQmqgEGSelUg3r0C8UlQeg/v0ezrrNQNB4EOcLHXayrQOjvFS1mswOzib6o
         CXHzWtfIZoRnK8wzPUOTQeIed3Fw7Woh6JEXa18nJGLBM+5lEF4P1oHOJ9a7VDvRPLZE
         nmC3/CN4Nl+UsZu1dYfCO3DIlsMf/IuqdebeNOCxdSD4Y37HlYse1d+02ZsHvxfHg0ak
         vYmPmv1cgHHn3G2EwNHnjCjhKSx90e79/e4VMlgCXx/a7BNuz/N9DhiZVarbytrEAEK9
         3vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3MQkVFmz50CKygVlS5wBFEMV19XQkctwc34C5jTipA=;
        b=EO+0SVtWRDdU2QW9Kvf9sgCsJ+i09+bYc30SfMy50t0C/vO5xpbezk4lG+/SXgMobV
         GgbXdsNYVt6hHBszb5RjwWHUaclVmC68RE+7z7O2fi2AXPPRx3h2vwUu3+Gi1mJ0kcdU
         95E4OEfZf1fyiHEKciU3dUCyE+A0pI9t8RqJVCyI0g2KGMmeBChMiIecV7rRrerIyYUu
         LBPAxpnWYSUv3cNrxDWLXsITuynNA/djRoJIOKyLH9i3Ns3NDixUTfdG/dSu/TZOA2fE
         SfMvxtyF9jfGdz6qlNsuYNgukGwoBVE0jcAznzOUYyVPCQpE4U4KMfvpWRd64hyhQ2It
         M7/g==
X-Gm-Message-State: AOAM531dP2uaBtSJecthE3srgcCK9OU6kZPhievRKNwXxZw0YpF5/E6A
        /1xW3v95071eMAamp4fxR8g94n4ozabKksUf78c=
X-Google-Smtp-Source: ABdhPJyNk7JIzlJC5ea2j0zCynCFryE5kjZs7tC2ANwFC0dMX3w7fERipaUK0c2vSeLj8O+LLUs9juYSfwP+LI9ODcs=
X-Received: by 2002:a92:b04:: with SMTP id b4mr2727346ilf.65.1603711777610;
 Mon, 26 Oct 2020 04:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAFzd1+62PmHBoVpMw-y4TC=bmc8N0wDpF2jQa7XGz2e+7Dos6A@mail.gmail.com>
 <8bb82be6-dc51-6602-47b5-c849a87ae55e@gmail.com>
In-Reply-To: <8bb82be6-dc51-6602-47b5-c849a87ae55e@gmail.com>
From:   "herr.kaste" <herr.kaste@gmail.com>
Date:   Mon, 26 Oct 2020 12:29:13 +0100
Message-ID: <CAFzd1+7PDg2PZgKw7U0kdepdYuoML9wSN4kofmB_-8NHrbbrHg@mail.gmail.com>
Subject: Re: ORIG_HEAD after rebase is confusing
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philipp,

for whatever reason that doesn't work.  I know the `feature@{1}` trick
but hoped just `ORIG_HEAD` would work.  Or maybe it used to work, it's not
an everyday command.

Following is my test case:

    $ git init; git commit --allow-empty -m "Init"
    [master (root-commit) 5db5264] Init

    c-flo@KLOG MINGW64 /d/rebtest (master)
    $ git co -b feature
    Switched to a new branch 'feature'

    c-flo@KLOG MINGW64 /d/rebtest (feature)
    $ git commit --allow-empty -m "A"
    [feature 5c7dfb4] A

    c-flo@KLOG MINGW64 /d/rebtest (feature)
    $ git commit --allow-empty -m "B"
    [feature a61bd4c] B

    c-flo@KLOG MINGW64 /d/rebtest (feature)
    $ git commit --allow-empty -m "C"
    [feature 26e6417] C

    c-flo@KLOG MINGW64 /d/rebtest (feature)
    $ git commit --allow-empty -m "D"
    [feature 735e4fb] D

    c-flo@KLOG MINGW64 /d/rebtest (feature)
    $ git co master
    Switched to branch 'master'

    c-flo@KLOG MINGW64 /d/rebtest (master)
    $ git commit --allow-empty -m "X"
    [master 3eb6a3f] X

    c-flo@KLOG MINGW64 /d/rebtest (master)
    $ git co feature
    Switched to branch 'feature'

    c-flo@KLOG MINGW64 /d/rebtest (feature)
    $ git rev-parse ORIG_HEAD
    fatal: ambiguous argument 'ORIG_HEAD': unknown revision or path
not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'
    ORIG_HEAD

Intentional, up to this point I did nothing that sets `ORIG_HEAD`.

    c-flo@KLOG MINGW64 /d/rebtest (feature)
    $ git rebase master
    Successfully rebased and updated refs/heads/feature.

    c-flo@KLOG MINGW64 /d/rebtest (feature)
    $ git rev-parse ORIG_HEAD
    a61bd4c550396ac086879aea829375d839a1667b

    c-flo@KLOG MINGW64 /d/rebtest (feature)
    $ git rev-parse feature@{1}
    735e4fbd14b9ef8b3f2156f1ed90dbde3742d65d

So here again, `ORIG_HEAD` points to the original B.  And `feature@{1}`
correctly points to the original D.  I obviously did no `rebase --skip`
here.  Is there an internal `git --reset` somewhere here I'm missing?

Anyhow, you said it should work unless there is an `git --reset` or
`--skip` **while** rebasing.  So I guess the relatively declarative
usage of `ORIG_HEAD` I'm after, for example `reset ORIG_HEAD`, is error-prone
for example if I use `-i --rebase-merges`.

That is, I actually wonder if you set `ORIG_HEAD` more at the start of the
rebasing work, or basically in the cleanup function of the rebase, e.g. when you
delete the `orig-head` file.  It looks like the former, and I assumed
the latter.


Regards,
Caspar Duregger

Am Mo., 26. Okt. 2020 um 11:43 Uhr schrieb Phillip Wood
<phillip.wood123@gmail.com>:
>
> Hi Caspar
>
> On 22/10/2020 21:31, herr.kaste wrote:
> > Reading the git rebase manual and some answer on stackoverflow I assumed
> > `ORIG_HEAD` will point to the original HEAD, the tip of the branch *before*
> > I started rebasing.  But it doesn't seem so.
> >
> > For example, I have this:
> >
> >
> >    $ git log --graph --all --oneline
> >    * 9830f9f (master) X
> >    | * fb7b6a6 (HEAD -> feature) D
> >    | * 46b7a7a C
> >    | * da5e4c7 B
> >    | * 5c135da A
> >    |/
> >    * 6848823 Init
> >
> >    $ git rebase master
> >    Successfully rebased and updated refs/heads/feature.
> >
> >    $ git rev-parse ORIG_HEAD
> >    da5e4c7e9eb3b10c1efa08c534b9c9e4b92d9fd7
> >
> >    $ git reflog
> >    a647bd7 (HEAD -> feature) HEAD@{0}: rebase (finish): returning to
> > refs/heads/feature
> >    a647bd7 (HEAD -> feature) HEAD@{1}: rebase (pick): D
> >    2f458e8 HEAD@{2}: rebase (pick): C
> >    0aa2160 HEAD@{3}: rebase (pick): B
> >    b957fc7 HEAD@{4}: rebase (pick): A
> >    9830f9f (master) HEAD@{5}: rebase (start): checkout master
> >    fb7b6a6 HEAD@{6}: checkout: moving from master to feature
> >    9830f9f (master) HEAD@{7}: commit: X
> >    6848823 HEAD@{8}: checkout: moving from feature to master
> >    fb7b6a6 HEAD@{9}: commit: D
> >    46b7a7a HEAD@{10}: commit: C
> >    da5e4c7 HEAD@{11}: commit: B
> >    5c135da HEAD@{12}: commit: A
> >    6848823 HEAD@{13}: checkout: moving from master to feature
> >    6848823 HEAD@{14}: commit (initial): Init
> >
> > So `ORIG_HEAD` here points to the original B commit.  (I expected the D.)
>
> It should be D, unless you ran `git reset` or `git rebase --skip` while
> you were rebasing as they also update ORIG_HEAD
>
> > Honestly, this doesn't make much sense to me in that I don't know *why* it
> > even chooses B which is a middle commit in the chain.  (And from reading the
> > source `sequencer.c` I can't deduce it either.)
> >
> >    $ git --version
> >    git version 2.29.0.windows.1
> >
> > What I actually wanted to do was `git reset --hard ORIG_HEAD` fwiw.  And for
> > example `git diff HEAD..ORIG_HEAD` to check for unwanted changes after a merge
> > conflict.
>
> After you rebase you can user feature@{1} to get the head of feature
> before rebasing (until you make another commit on feature)
>
> Best Wishes
>
> Phillip
>
> > Regards,
> > Caspar Duregger
> >
>
