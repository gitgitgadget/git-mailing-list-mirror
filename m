Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5355C49EA7
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 07:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985866191E
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 07:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFZH4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 03:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZHz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 03:55:58 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B0EC061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 00:53:34 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so11973339ota.13
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 00:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+gPvhftIzZBsGkQCJzrmWMtdNcHbTO283CmwJR6Nas=;
        b=INtKQyZ3dnNOD1BbdML3cYhw7LDDa8GOpcqUgt2DlN+SxAJI1DfX8uWxJw+XM7AY8h
         uB2RgBeGB9AmWcz6R6VZoxbS0nkc3iyt7RWwMNzsx3iqGoZk3CNMNGHljdwjdOS7hSAj
         IbxR9rGgukcx8OWSTYPNks6OK5dhS5fmkZbImqxY2gAktPv8D/4dByuMQDsUNQ96YCj2
         ErFfsDiLhyC8G0KFtmsBOqzmpL7zTtOzSxiY4dN61ZSFBUVKrwbnY6P0Pxq/fnnYUPTU
         E3+ovkfTEst8nkp/Jk7PYu+BGkq9mXfiXrzFiQ15Xhnx+iW70QGUDLFuTsEMcucakqc0
         Buyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+gPvhftIzZBsGkQCJzrmWMtdNcHbTO283CmwJR6Nas=;
        b=eruazmzpVowz0a9QzPXjkuplJRhOEBZIrQFEaYWE5DhAw2Z1pqFAoyPSJ36ntOLPLH
         jLLlxyYcUbhc66pUt0tpNtrt9Mfm0kQK7x9XtsXj5vjiMgi7UWmQN/+yAiNGeLE7Jd2K
         xHBTJK48BXS4ji7tiHAenK8SrkbguugdJaq1cVvuv0WEdZYeJVK7Tjl27PZDM5kgCdlB
         xorDFP9D4Inr/uRmbBv9BmQB1sNgwd5XySMZ4fN+6sOJMXAKGN+Dpq2XLHhJTC3UGH5Y
         h6/ICmsWBO3CD0SLD0HGAYV72HD/up5vpH8SJ2nBxhrK+q2itBX0j5lEpEsJjaZVgeYc
         eSHQ==
X-Gm-Message-State: AOAM530LCUi0GsuvG2wAnl/6MvxOu91lSU70JPCRr0JvLnHon4FZiLjT
        v4pw5OEjfssDCLmoCBqrEE73gKs+ag+KyO6iG2dmGIMbhL0=
X-Google-Smtp-Source: ABdhPJyMCWwOCszeBQRSBwlqmSqjWEo8Av+OdivEg6OzNDVtlprwAM2r3qi7a77hnolrebQIG7QHtvoABpwOE0Uqryo=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr13336374otn.345.1624694014044;
 Sat, 26 Jun 2021 00:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
 <9a83ef22-2291-1364-b0a8-1eb8257972a2@gmail.com> <CANLwWg5Lcf7PYtZ49U-KZ_3UYVb9FJ-g1B+eFYoO2D1t5UArmw@mail.gmail.com>
 <6b604658-8f7e-ae5d-7161-c48aed7ccbd0@gmail.com> <CANLwWg7YFC2VrRYz1PR1U9SVG5yiyRVnyMspGc8PqKktouz8dQ@mail.gmail.com>
In-Reply-To: <CANLwWg7YFC2VrRYz1PR1U9SVG5yiyRVnyMspGc8PqKktouz8dQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 26 Jun 2021 00:53:23 -0700
Message-ID: <CABPp-BH1COE8worEAuu3M_LNJfVhW3Y6+1r8zfUcVaTrVgjG5w@mail.gmail.com>
Subject: Re: Nonexistent changes appear rebasing but only with rebase.backend=apply
To:     Marco Giuliano <marco.giuliano@tesisquare.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marco,

On Fri, Jun 25, 2021 at 12:15 AM Marco Giuliano
<marco.giuliano@tesisquare.com> wrote:
>
> Hi Philip,
> oh, so I guessed correctly...
> Could you be more specific about the copy/rename issue of the apply backend ?
> Is there any bug report I can refer to ?
>
> Thank you very much for your support

Could you do us a favor?  Please avoid top-posting and instead answer
after the quoted original text, much like I'll do here...

> On Thu, Jun 24, 2021 at 8:39 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >
> > Hi Marco
> >
> > On 24/06/2021 17:23, Marco Giuliano wrote:
> > > Thanks Felipe and Philip for your answers.
> > >
> > > Let's proceed in order:
> > > @Felipe: I tried rebasing with --no-fork-point but the problem remains the same
> > >
> > > @Philip:
> > > I'm a basic git user, so bear with me if I say silly things...
> > > I tried to search for rebased-patches in .git folder when rebase
> > > stopped waiting for
> > > conflict resolution, but I didn't find any file named like that.
> > > There's a folder named rebase-apply though did you mean that ?
> >
> > Looking at the source I thought they ended up just in .git but I haven't
> > checked again, as you seem to have found the source of the problem below
> > lets not worry about that.
> >
> > > Anyway, looking at the conflict file of "fileA" directly (not behind a
> > > visual diff tool) I noticed that the marker line >>>>>>>> COMMIT
> > > DESCR: FILENAME indicates a different file name then the current
> > > conflicted file.
> > > That reminded me that those two files A & B, were actually copies
> > > (real copy, not symlink) of other two files inside the same repo.
> > > Is it somehow possible that auto-detected-renaming is involved in this
> > > (since the files are identical but in two different locations) ?
> > > Trying to give you some hints, maybe it is totally unrelated...
> >
> > I meant to ask if anything had been copied or renamed but forgot. The
> > merge backend detects copies and renames and handles them correctly but
> > the apply backend does not so I think this is the source of the discrepancy.
> >

So I've got a hunch here.  First, Marco, from your example, can you run

git diff --name-status -C Y...X

and report whether the files involved were either renamed or copied on
the upstream side of history.  (Also, please note that there are three
dots between Y and X)  Also, can you report whether a message of the
form "inexact rename detection was skipped due to too many files" when
using the merge backend and that files you copied from end up in
modify/delete conflicts when using the merge backend?


My suspicion is:
* You both renamed some files and copied them on the upstream side of history
* You made further changes to the renamed files, more so than to the "copies"
* You have enough added/removed/renamed files that with the merge
backend you are triggering merge.renameLimit and not getting rename
detection, causing various reports of modify/delete conflicts
* The apply backend's use of fake trees can be viewed as a poor-man's
version of the irrelevant rename detection optimization I added to
merge-ort, but it works well enough to get you under merge.renameLimit
so that renames are detected for the apply backend
* The fact that you modified what you view as renames more than what
you viewed as copies has the perverse effect of causing git's rename
detection to pair up files with the copy rather than the rename, and
apply changes to it

The net result is that the 'merge' backend isn't apply your changes
from various files to their renamed counterpart, while the 'apply'
backend is almost doing that but applying them to what you think of as
the copy rather than the intended renamed file.  The questions I asked
above may be able to help us either confirm or rule out this theory.
