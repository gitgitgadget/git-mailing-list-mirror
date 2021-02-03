Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC66C433E9
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C724F64F43
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBCVJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhBCVJT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:09:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57091C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:08:39 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s5so1357227edw.8
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHdXZ14UnJNlSaq41uicH1or9WN1KckFy/Q6oEeUWD0=;
        b=YkjmDWYsofor8U7Vk+n476xxubQ07/RZariM9dA3g22VZc/PWjyCnLm0w/PP1c83ZR
         zGQpuh8LHmyawZWlVAu6Biexp07fb93WY4NEa1YyskKJMfZnAl+Yy0QCj/5rPEDpl502
         zTKMhIuceoNdzZJyek5kCUq3JuY80oc73pIQiEP1MYHTqn6IPntkiS+cpD06m718Z5HD
         K7Z0uRHqMNba1ReW4jHQ5Di91u0kYd7egGOcTJzTJaI7xjJ0OMcAwzys2UT6oncf9I/x
         zklY4zHgSwdxerv3O0oBkpFAwLkcWb8oj5z6UrRQMxfmJeNT7WyQ7fDrqQVcXeQ5tdzV
         8GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHdXZ14UnJNlSaq41uicH1or9WN1KckFy/Q6oEeUWD0=;
        b=aY0uvxoE3AwFODTCocAcw6+Q7Fqeu/TDbbfKNHzAaeWxVN9cW5VNCthu3RefBkrz+q
         iKeiMiptio9MQ8f5b39jjuWXMaIY+8QmwXPl0N9+bYWiHTEE0/UrP8402BsmbUmtdcpn
         IxRznnC1ebuZvtP6Vttw8C81lBk+SiNn9K+he3w3qzsNrYYGGE4bHQLWuuidx4WkeLtL
         WfXqfsUnw1Y/ai7+Bn2//RkN/ffFAnOhrHYNSnChqxHQlvt+u8/HrHjX+97FupgFT2ep
         TfgcOlx8pmAyHnJJeAu8KkMYfANbW2SJmY/c+8XiEzUaA19hvpnv8P9t3ufvxEFX90sY
         kHMA==
X-Gm-Message-State: AOAM531Qe9qJpP9Eeu/lm6fT1GyjSJliwR0NRhV2hhnYWe6G+NRhtB28
        38Fh1mmvwtCVHD/jb1hfZmcK/MzcERHLLb4TPYw=
X-Google-Smtp-Source: ABdhPJzep6fXLn2VrfgnjLYOChN+SRa6IV3lVJA3JiRR/ita83syWzcMTD82fkFnUdwhRxPVF/y+5FJavPLiJ2uP5y8=
X-Received: by 2002:aa7:da98:: with SMTP id q24mr5116086eds.370.1612386518025;
 Wed, 03 Feb 2021 13:08:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.854.git.1612021544723.gitgitgadget@gmail.com>
 <CAPig+cQMn6oc4Jh=gb1jNfArXJBYhPRaSzJJvvbvprit6_OC0g@mail.gmail.com>
 <CACPHW2X2UGAVmNM+cHXs6dwVfZbgLFZ0iUGU89h04H5czAt1Ww@mail.gmail.com>
 <CAPig+cS-hnwp2HjkkFPeJ4aibFHnJ0VZq0DSVgdWB0H_q5=oXw@mail.gmail.com>
 <CACPHW2VBEu=02HFhyrDes=6KceLtHzGDqBJVf2qAnD2s1f8VAg@mail.gmail.com> <CAPig+cSSU1P68dBomjRkO4jUqUnu+0ri5-3y0-H228-qONwhyw@mail.gmail.com>
In-Reply-To: <CAPig+cSSU1P68dBomjRkO4jUqUnu+0ri5-3y0-H228-qONwhyw@mail.gmail.com>
From:   Lance Ward <ljward10@gmail.com>
Date:   Wed, 3 Feb 2021 15:08:26 -0600
Message-ID: <CACPHW2WbY+c914vHV8cjfBC1GstF7PxfQFr-NF=EUhcF0YaCzQ@mail.gmail.com>
Subject: Re: [PATCH] status: learn --color for piping colored output
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Lance Ward via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

I made all the changes you suggested and split it into two
independent changes:

This patch handles the --color option:
https://github.com/git/git/pull/955

This patch fixes the coloring inconsistency:
https://github.com/git/git/pull/954

Both have failed a CI test, but the reason has nothing to do with my
code.  CI/PR / static-analysis VM is trying to install the package
coccinelle, but is failing to install it with the following:

E: Unable to locate package coccinelle
Error: Process completed with exit code 100.

On Tue, Feb 2, 2021 at 10:46 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Feb 1, 2021 at 11:09 PM Lance Ward <ljward10@gmail.com> wrote:
> > On Sun, Jan 31, 2021 at 5:09 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > I think the approach I suggested of patching those wt-status.c functions
> > > to use:
> > >     rev.diffopt.use_color = s->use_color;
> > > would fix this inconsistency, wouldn't it?
> >
> > I've made the change you requested and it resolves the issue.
> > It also fixed the inconsistency I mentioned.  I only needed
> > to modify wt_longstatus_print_verbose to resolve the issue
> > since it is the only status path that had an issue with the
> > git status command.
>
> Okay, makes sense. As long as you insert the assignment somewhere
> above the special case:
>
>     if (s->fp != stdout) {
>         rev.diffopt.use_color = 0;
>         wt_status_add_cut_line(s->fp);
>     }
>
> then it should work correctly, I would think. However, it might be
> easier for people to grok the logic overall if you incorporate it into
> that conditional, perhaps like this:
>
>     if (s->fp != stdout) {
>         rev.diffopt.use_color = 0;
>         wt_status_add_cut_line(s->fp);
>     } else {
>         rev.diffopt.use_color = s->use_color;
>     }
>
> Or this:
>
>     if (s->fp == stdout) {
>         rev.diffopt.use_color = s->use_color;
>     else {
>         rev.diffopt.use_color = 0;
>         wt_status_add_cut_line(s->fp);
>     }
>
> It's subjective, of course, so use your best judgment.
>

I've made the change you suggested.

> > > In fact, I can envision this patch being re-rolled as a two-patch
> > > series which (1) patches the wt-status.c functions to do
> > > `rev.diffopt.use_color = s->use_color` which should make
> > > `color.status` imply `color.diff`, and (2) adds a --color option to
> > > `git status` which sets `wt_status.use_color` (which would then be
> > > automatically inherited by the diff machinery due to the first patch).
> >
> > Right now as it stands my patch resolves both of these, but
> > if you'd like to make it two separate patches that would be fine.
>
> The reason I was thinking of splitting these changes into two patches
> is that they have different purposes. You'd sell the first patch as a
> straight up bug fix, and it's easier to formulate a proper "sales
> spiel" for that if it's not blurred with other changes. (This may be
> important because it could be slightly controversial if other people
> don't consider the behavior as being buggy.) The second patch would be
> an easy sell as a straightforward and simple enhancement. Another
> reason for splitting them into two patches is that doing so would make
> it easier to revert the bug-fix patch separately if it turns out that
> there are unforeseen negative side-effects.
>
> Having said that, a well-crafted commit message may very well make it
> easy to sell the change(s) as a single patch. Again, use your best
> judgment.

I've split it into two patches.
