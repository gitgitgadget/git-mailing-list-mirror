Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F28C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 02:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CA46162B
	for <git@archiver.kernel.org>; Tue, 11 May 2021 02:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhEKCYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 22:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhEKCYf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 22:24:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C279EC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 19:23:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r5so9147938lfr.5
        for <git@vger.kernel.org>; Mon, 10 May 2021 19:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0uAodsifrvX0UqqMGgg+r8ApHY9p6bOUB5EwslJc3k=;
        b=lx3Ecd8bnPe3MKaqLF3ZnUPNzBrK2BBOZh6LYu0sFj8Jd7mVYxnWZz2DYwlQ+Szkbk
         UA+xt067y2hy1K4VecqoqdDk3OPureVNGaAzk6CXvLsolbkaCig3uR2VSj3hR53m7H6M
         trra8LC+0AgCKB/FSFNuUoObGesilDbLZjCsCU4n/Ph9CtZ2WWUFRLttS6OYg1eEFX5f
         dkitw8x50wnVm275bmVvJU0OEyft0qG4dpx1r/BFU0NRsLMFEthSImvPfOV37OvF6JkD
         Bqt7bvok2MgiaiqXrh9mzKyLw+h00KgyvxFm8SJyG2K8W0/Bl6MF/0UqcVxb3WpmACXS
         tvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0uAodsifrvX0UqqMGgg+r8ApHY9p6bOUB5EwslJc3k=;
        b=KOb4V4zy+hqxDMwH4umdbK2hTyfTxkwt3mYF73aa1t/vhO1/9wRMKzi7NMuQc+MqNA
         5Kmmn4yrMHMZRESQWmgPOZM9l6fN0+FQczKh52jP9HP2Syx+1+9xnrV2Py01o/ekJxBU
         d1SbdJIXl/3RlGy18QEJKyoArblOVbJZ5q1mrX6vS6NfL6BumDBA6WbV/MWXdu8hUAVf
         NbSvybOLhJ1KX2x4SfMgAPbeFKtMWgHlxQne9M4Cp3QH+yZA6wya4VpMWw+Vvnhcy5Bj
         ms0obHWJIwjD5+0atwlssSaRKDPmxnZZoigaqUwvaxzzxfOGvTjB59yFGbMC3WCrhASV
         co4Q==
X-Gm-Message-State: AOAM531WVLRd58zqurg3/+pm6C8kAUypURrXJkCfd/+9dA6iomD8bLnR
        0HJQSL11w75M/DEwJMHr9WRxTVMDDX6sl18CP55WNg==
X-Google-Smtp-Source: ABdhPJzlXPx6LQLlSw4dcTfD0NvaJp8/ar1dczO16+Wr3qtsuu55POh1TKYmwvE62Geh//PB99Fz6t1V5KxjFKQ4pR0=
X-Received: by 2002:a19:f00c:: with SMTP id p12mr19095259lfc.502.1620699808299;
 Mon, 10 May 2021 19:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <e4c3d482-03b4-141c-e47b-cb3e175da3ab@iee.email>
 <789bcc9cd074cb94f706b9d432e29b52bf6a33c3.1620134775.git.matheus.bernardino@usp.br>
 <CABPp-BFpeoENLADH-e6dCc0PyEVQyHueY6PV8AZYbD+a3iceXA@mail.gmail.com>
 <CAHd-oW7veyN+qetv-Mf-qPa+bcah=JCz6mSRAzunVgaFRxdbnA@mail.gmail.com> <CABPp-BHPr0aJZTRsVPK+Ga2oKZJLa75OkcyHLpZH=sD1pfpNZg@mail.gmail.com>
In-Reply-To: <CABPp-BHPr0aJZTRsVPK+Ga2oKZJLa75OkcyHLpZH=sD1pfpNZg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 10 May 2021 23:23:17 -0300
Message-ID: <CAHd-oW5PFTuUQsxTWCQqdSDBskq-+zkCc2OqyY9wJEUqNUSvkw@mail.gmail.com>
Subject: Re: gitignore + commit with excludes = bug
To:     Elijah Newren <newren@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>,
        mailnew4ster@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 10, 2021 at 7:34 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, May 10, 2021 at 12:37 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > On Mon, May 10, 2021 at 4:27 PM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > Thanks for tracking this down.  Your analysis and patch look correct
> > > to me, but perhaps we could simplify the code a bit.  Instead of
> > > looping twice, perhaps insert the following code above the if-checks:
> > >
> > > +               /*
> > > +                * We can have a bunch of exclusion rules:
> > > +                *    .gitignore
> > > +                *    *.log
> > > +                *    !settings.log
> > > +                * and we're trying to see if the path matches one of these,
> > > +                * but note that the last one is a "negated exclusion rule",
> > > +                * for the excludes to match this pathspec, it needs to not
> > > +                * match the negated exclusion.
> > > +                */
> > > +               int retval = (item->magic & PATHSPEC_EXCLUDE) ? 0 : 1;
> > >
> > > and then change all the "return 1" statements to "return retval".
> >
> > Hmm, but then wouldn't something like `git add ignored :^ignored` also
> > trigger the warning, as we see 'ignored' first, and return 1 before
> > seeing ':^ignored'?
>
> Oh, right, whoops.  Do you want to add this testcase, and a commit
> message for this (and maybe a comment explaining the double loop)?

Sure, I can do that :)

Another thought that came to my mind is that this solution doesn't
cover more complex cases with other magic patterns and/or wildcards.
For example, we would still get the warning about trying to add
'ignored' when running `git add ignored ':^*ignored'`.

But that's because we are not fully matching the pathspecs to display
the ignored files warning, only using the simplified logic from
exclude_matches_pathspec(). We could perhaps use match_pathspec(), but
then I'm not sure how we would handle something like `git add
dir/file`, where `dir` is ignored, without having to recurse into the
ignored dir...
