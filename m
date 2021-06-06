Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87294C47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 04:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC2261408
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 04:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhFFEfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 00:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhFFEfN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 00:35:13 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B4CC061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 21:33:24 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id z206so7122136vsz.6
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 21:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyM0X6Nz9XjoFagNgDfmascSO5PzEq/MWfT7C8//1+o=;
        b=p5SAcKeIKpbFbjY2EHMqtyeB9yUSV8KaJXH4+hUFlm2Y3NMWPZo237eWs0O5w2SeV/
         zs6e/JaM5R9dcXnX2z+MvZZ60csyWIKKeEemPmFK7S3dkMfthnd0dvp+jTE48Bnl4Si8
         6tw5X2FONFotbaFXKYm0R2624klTbKqzmX6vXwtmHSaGz4RWCGDjEeWc8toZYuzm0ayX
         rWMxPkejN0hd+kk4v43YIaggL7Cf5tPTA1YMf/iAg7wHmqERJRB3X6p52tGVDiKzEeY7
         brsKlxrXDd3LgVMm9qP5T+fLiqgpbIGczdvn57wGOU2njTIryc+dHEi777W2NQzIpXTy
         rNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyM0X6Nz9XjoFagNgDfmascSO5PzEq/MWfT7C8//1+o=;
        b=K1fWcLoS3Dq5WMM1Tfcv3Dh6+qg4vQ2n0NnTlqv+9dErr5s2ARdtrNGYcmEN28crlb
         Z0iVQxWvYEBKmaorWTJLHhJgJf7Rv7v9uC9wnPt5KHGVqnp4L97Ds2KcCI7jJsgMXFHz
         mF+ZNcZ2dfGlIIrWajrL4FJXcNWwJywv8YDWjiLm4Kl8wLqTQ9WF2SPY85VRhrbJMriP
         IBhItN20yBKIhc97yJ2fcpvg/9A56enUeeEAM/3uE9DumDy3mRaEt+pwgpOkmP2MdQYy
         pzTayfqn5siUHOPSq/kllpJ5HTwgp67gmQG0oxvFHef1856Wo0X6tJz/l5YlCOMWmCLe
         Ra6Q==
X-Gm-Message-State: AOAM532T/LHuffyRvkK/LyHRNImUjkR2hp064tgpopxau8usD8WuI3V3
        OHGR4m/bTjjdoNfX1be3U87nndOWuWC7Oaihtyw=
X-Google-Smtp-Source: ABdhPJyvGhbb0yyNBkGfjFp88cBWtE7pY6Y01UTOm86uwGnO/81ZvVcnk3Xp+IP4E49tJTdH84vscCAeA8Xqq0BkJ1k=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr6923524vsl.9.1622954002410;
 Sat, 05 Jun 2021 21:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
 <3170f78daa5fa89f04f61e24c9c64c93ea5b394f.1622828605.git.gitgitgadget@gmail.com>
 <CAKiG+9UT+B-kFiY7sA8ZedB31xYARbFgSFwQRzktww_S2B_tfA@mail.gmail.com> <CAOjrSZv9h09y-=KVz8UGZaB0r5MHRqFZJjp0VDFX6fnohoFx9Q@mail.gmail.com>
In-Reply-To: <CAOjrSZv9h09y-=KVz8UGZaB0r5MHRqFZJjp0VDFX6fnohoFx9Q@mail.gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 6 Jun 2021 10:03:11 +0530
Message-ID: <CAKiG+9UPBDVVH+2TnfYU6VoTdB1UFoVP=M_D+9H1e=k5+s7vfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmake: add knob to disable vcpkg
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 6, 2021 at 4:01 AM Matt Rogers <mattr94@gmail.com> wrote:
>
> On Fri, Jun 4, 2021 at 4:55 PM Sibi Siddharthan
> <sibisiddharthan.github@gmail.com> wrote:
> >
> > On Fri, Jun 4, 2021 at 11:13 PM Matthew Rogers via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >
> > > -if(WIN32)
> > > +
> > > +if (WIN32 AND NOT NO_VCPKG)
> > > +       set(USING_VCPKG TRUE)
> > > +else()
> > > +       set(USING_VCPKG FALSE)
> > > +endif()
> >
> > I think it would be better if we could have an option for this knob.
> > Maybe like this
> >
> > option(NO_VCPKG "Don't use vcpkg for obtaining dependencies. Only
> > applicable to Windows platforms" OFF)
>
> Option would definitely be the better tool to use here, I just didn't
> think about
> it when originally writing it, so I'll send a reroll with that and the spelling
> corrections suggested by Eric Sunshine.  I assume you'd prefer something
> with a final form more like:
>
> option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.
> Only applicable to Windows platforms" ON)
>

Yes, this would be better.

Thank You,
Sibi Siddharthan
