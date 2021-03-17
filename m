Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDDDC433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91D164F3B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhCQWBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 18:01:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:40552 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhCQWBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 18:01:16 -0400
Received: (qmail 27772 invoked by uid 109); 17 Mar 2021 22:01:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Mar 2021 22:01:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14459 invoked by uid 111); 17 Mar 2021 22:01:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Mar 2021 18:01:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Mar 2021 18:01:14 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] Makefile: add 'check-sort' target
Message-ID: <YFJ8KpseGSJdd3Am@coredump.intra.peff.net>
References: <cover.1615856156.git.liu.denton@gmail.com>
 <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
 <87mtv2dk18.fsf@evledraar.gmail.com>
 <YFI9QzKMKLMXYoyz@coredump.intra.peff.net>
 <CAPig+cRk-fCLFtug47w3trYQFiPzZ3bD4g11Qu4fTd3Fh6_bCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRk-fCLFtug47w3trYQFiPzZ3bD4g11Qu4fTd3Fh6_bCQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 05:48:18PM -0400, Eric Sunshine wrote:

> On Wed, Mar 17, 2021 at 1:34 PM Jeff King <peff@peff.net> wrote:
> > TBH, I'm a little on the fence on whether automatically checking this is
> > even worth the hassle. Doing the make function above was a fun
> > diversion, but already I think this discussion has taken more time than
> > people actually spend resolving conflicts on unsorted Makefile lists.
> 
> I had the same reaction. Like you, I jumped in for the fun diversion.
> It allowed me to flex my Perl muscle a bit which has atrophied, but an
> out-of-order item here and there is such a minor concern, especially
> since they don't impact correctness, that I worry that such a CI job
> would be more hassle than it's worth. Making the feedback loop
> tighter, as discussed elsewhere in this thread, makes the idea of the
> automated check a bit more palatable.

There's an implication in what both of us said that I think is worth
calling out explicitly: I would not feel the same about a problem that
impacts the correctness of the resulting code. E.g., if the list of
builtins were used with a binary search, then an unsorted list would
produce the wrong result. And that would be worth testing.

It just seems that the stakes here are much lower.

-Peff
