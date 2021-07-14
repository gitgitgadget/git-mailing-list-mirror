Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2919C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD11D613C0
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhGNUty (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:49:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:50000 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231852AbhGNUty (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:49:54 -0400
Received: (qmail 32154 invoked by uid 109); 14 Jul 2021 20:47:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 20:47:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28229 invoked by uid 111); 14 Jul 2021 20:47:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 16:47:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 16:47:00 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] Bump rename limit defaults (yet again)
Message-ID: <YO9NROIgMpo2zqU/@coredump.intra.peff.net>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
 <8f1deb6dd16a0c0d88cf594d2019b3096dbe5383.1626225154.git.gitgitgadget@gmail.com>
 <YO8UPtFr4wRhVTXE@coredump.intra.peff.net>
 <CABPp-BG7T2QP+6uP57NuE1Htr-vBzozL-aDxU4FsyQO+ELQ9Uw@mail.gmail.com>
 <YO8lgYa5/RlL1zGp@coredump.intra.peff.net>
 <CABPp-BE=Ghkm=sZ05=A=1vC1zscbVk7qXgeEjpA5gHxsfTGAyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE=Ghkm=sZ05=A=1vC1zscbVk7qXgeEjpA5gHxsfTGAyg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 01:03:43PM -0700, Elijah Newren wrote:

> > The 2008 timings are from the old email you linked in your commit
> > message, and the new one is from running the revised script you showed.
> > The savings seem like more than 30%. I don't know if that's all CPU or
> > if something changed in the code.
> 
> I was using the script you wrote in 2008, but comparing to your
> reported numbers in 2011[1].  When you bumped in 2011, you said you
> picked the limits of 400 & 1000 in order to give rough timings of 2s
> and 10s.  So the table looks more like:
> 
>    N  CPU (2008)  CPU (2011)  c5xlarge  CPU (yours)
>  400    4.87s         ~2s      1.106s      0.788s
> 1000   27.82s        ~10s      6.350s      4.431s
> 
> So, 2011->c5xlarge on these (just recomputed now numbers) show
> improvements of ~45% and ~36%.  Maybe I had an outlier run earlier
> that was in the upper 6s range for N=1000 and I rounded off to 30% for
> the commit message?  Don't know, those numbers are on a laptop that
> died in the last few days.

Ah, right. I forgot about the 2011 update. So yeah, things are getting
faster, but not as much as I would have hoped as somebody who came of
age during the clock speed boom of the 90's. :)

Thanks for humoring my puzzlement (I don't think any of this changes the
applicability of your patch).

-Peff
