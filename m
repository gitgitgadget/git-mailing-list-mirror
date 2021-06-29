Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C2C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 18:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AAC61DE3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 18:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhF2TBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbhF2TBR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 15:01:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A0FC061766
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 11:58:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a13so371008wrf.10
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tesisquare-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/mEmGviv1AcmA6Db7nnNLjrxMWHHQK6F7WxjHGY6ac=;
        b=cXZTZivNTW17WfklrjoBpnu/Q07Fz5u59M8nh5Jayf6Fiy8wsWBbH/M3b0qnmKrxTj
         MRoLyY5kFZ9Ilr5XhLzF+lsFJfwUkHxux6TbiylSuemCD59eVZSS71m6EcQ1XXCbaXLV
         qIu3kHPaytGZYjig8wt8TteftijcYZzJoLe4fnq9Q8gjdkMAopjXnmxVpADRvj8ZPqpP
         h2W48dr7jBSIHEGskHHUJRimuCa72WlCyvbvy7fok4mwEjNhhQXLR+haM6RrUxTSTWFV
         muXWsRL3B6Bjbd6Fv3Wb7yx27Wf8VTpuQ4XJkbjN8AcJ3UBZY+R1KMr5buWViqbK3kFw
         Y6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/mEmGviv1AcmA6Db7nnNLjrxMWHHQK6F7WxjHGY6ac=;
        b=jx16VBoc4ZTylv44HiZa8/yWH1XcinwoI43AQYEoitwlygfHQJyBvNVtwzStkiQoWb
         3KUd7Uovml/3K7AmBd6ezFEiL1hrfsLlvg5mjJipwAq9MIfk6RsUvc68UmBADXlEX3YL
         3rCSxfhTZyCJd9i325k1EWtWVVRlIMzaPThnpUsoOmHuMB2+J1xutj1XobeK7kYjtLIK
         b17hnWZ6/sR9ke4anV4eEjx5Xz7tY2LBysOgWaYh69k0DWO9hRkpv3GCrb/FgJaC7+CB
         nfBj0TFUZ861KeX4/22ihjNf7Jadp6Kw+WSoD0NbKH5SXOCMi++JkTA7XwL+TBQ2QgJN
         FJEg==
X-Gm-Message-State: AOAM531FozRRbPW36bsJ8mGFHkGcMBwqc2TZYUFsfkDcrxisCYR84YFb
        17mRTiZKKAG6I1nkVMTM4pLq7cjE4uS/xp6MQtMtcw==
X-Google-Smtp-Source: ABdhPJwAlPKaQDpRrxoICqHDwJmvD0bgOnd6YDtINN5dtbpg3049e/7yqGc//I4gJ3XINjl0kBxzHPkFnv4ibXBVBdw=
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr17428434wrt.425.1624993127255;
 Tue, 29 Jun 2021 11:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
 <9a83ef22-2291-1364-b0a8-1eb8257972a2@gmail.com> <CANLwWg5Lcf7PYtZ49U-KZ_3UYVb9FJ-g1B+eFYoO2D1t5UArmw@mail.gmail.com>
 <6b604658-8f7e-ae5d-7161-c48aed7ccbd0@gmail.com> <CANLwWg7YFC2VrRYz1PR1U9SVG5yiyRVnyMspGc8PqKktouz8dQ@mail.gmail.com>
 <CABPp-BH1COE8worEAuu3M_LNJfVhW3Y6+1r8zfUcVaTrVgjG5w@mail.gmail.com>
In-Reply-To: <CABPp-BH1COE8worEAuu3M_LNJfVhW3Y6+1r8zfUcVaTrVgjG5w@mail.gmail.com>
From:   Marco Giuliano <marco.giuliano@tesisquare.com>
Date:   Tue, 29 Jun 2021 20:58:21 +0200
Message-ID: <CANLwWg7Y4yH=yQYt3d7xH-LDfiZgbiMpHb9uxSJ=xT12s2WnrQ@mail.gmail.com>
Subject: Re: Nonexistent changes appear rebasing but only with rebase.backend=apply
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 26, 2021 at 9:53 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hi Marco,
>
> On Fri, Jun 25, 2021 at 12:15 AM Marco Giuliano
> <marco.giuliano@tesisquare.com> wrote:
> >
> > Hi Philip,
> > oh, so I guessed correctly...
> > Could you be more specific about the copy/rename issue of the apply backend ?
> > Is there any bug report I can refer to ?
> >
> > Thank you very much for your support
>
> Could you do us a favor?  Please avoid top-posting and instead answer
> after the quoted original text, much like I'll do here...
>
> > On Thu, Jun 24, 2021 at 8:39 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > >
> > > Hi Marco
> > >
> > > On 24/06/2021 17:23, Marco Giuliano wrote:
> > > > Thanks Felipe and Philip for your answers.
> > > >
> > > > Let's proceed in order:
> > > > @Felipe: I tried rebasing with --no-fork-point but the problem remains the same
> > > >
> > > > @Philip:
> > > > I'm a basic git user, so bear with me if I say silly things...
> > > > I tried to search for rebased-patches in .git folder when rebase
> > > > stopped waiting for
> > > > conflict resolution, but I didn't find any file named like that.
> > > > There's a folder named rebase-apply though did you mean that ?
> > >
> > > Looking at the source I thought they ended up just in .git but I haven't
> > > checked again, as you seem to have found the source of the problem below
> > > lets not worry about that.
> > >
> > > > Anyway, looking at the conflict file of "fileA" directly (not behind a
> > > > visual diff tool) I noticed that the marker line >>>>>>>> COMMIT
> > > > DESCR: FILENAME indicates a different file name then the current
> > > > conflicted file.
> > > > That reminded me that those two files A & B, were actually copies
> > > > (real copy, not symlink) of other two files inside the same repo.
> > > > Is it somehow possible that auto-detected-renaming is involved in this
> > > > (since the files are identical but in two different locations) ?
> > > > Trying to give you some hints, maybe it is totally unrelated...
> > >
> > > I meant to ask if anything had been copied or renamed but forgot. The
> > > merge backend detects copies and renames and handles them correctly but
> > > the apply backend does not so I think this is the source of the discrepancy.
> > >
>
> So I've got a hunch here.  First, Marco, from your example, can you run
>
> git diff --name-status -C Y...X
>
> and report whether the files involved were either renamed or copied on
> the upstream side of history.  (Also, please note that there are three
> dots between Y and X)  Also, can you report whether a message of the
> form "inexact rename detection was skipped due to too many files" when
> using the merge backend and that files you copied from end up in
> modify/delete conflicts when using the merge backend?
>
>
> My suspicion is:
> * You both renamed some files and copied them on the upstream side of history
> * You made further changes to the renamed files, more so than to the "copies"
> * You have enough added/removed/renamed files that with the merge
> backend you are triggering merge.renameLimit and not getting rename
> detection, causing various reports of modify/delete conflicts
> * The apply backend's use of fake trees can be viewed as a poor-man's
> version of the irrelevant rename detection optimization I added to
> merge-ort, but it works well enough to get you under merge.renameLimit
> so that renames are detected for the apply backend
> * The fact that you modified what you view as renames more than what
> you viewed as copies has the perverse effect of causing git's rename
> detection to pair up files with the copy rather than the rename, and
> apply changes to it
>
> The net result is that the 'merge' backend isn't apply your changes
> from various files to their renamed counterpart, while the 'apply'
> backend is almost doing that but applying them to what you think of as
> the copy rather than the intended renamed file.  The questions I asked
> above may be able to help us either confirm or rule out this theory.


Hi Elijah,
sorry for the top posting.

I tried the 3-dots command, but no changes on those 2 files are
reported. Neither I got any message about inexact rename detection
using the merge backend.

I think it might be something related to copy/rename/slighly-change
very similar files, but probably not exactly what you described.
Commit 4 is the result of a squash where I remember doing changes and
copies of those two files, is it possible that the squash operation
(which uses rebase under the hood) somehow nullified some of those
changes because of their similarities and the current rebase-apply
made them reappear ?

I don't know if it can be useful, but if I do an interactive rebase
(rebase -i X), even with rebase.backend=apply, the two files do not
appear among the conflicts (same as rebase.backend=merge).

Thanks for the support
Marco
