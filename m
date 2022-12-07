Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4CCC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 06:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLGGIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 01:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGGIN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 01:08:13 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021192EF62
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 22:08:12 -0800 (PST)
Received: (qmail 17820 invoked by uid 109); 7 Dec 2022 06:08:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Dec 2022 06:08:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30624 invoked by uid 111); 7 Dec 2022 06:08:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Dec 2022 01:08:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Dec 2022 01:08:11 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y5Aty8p4617CZu1C@coredump.intra.peff.net>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <xmqqedtdpfoe.fsf@gitster.g>
 <Y46M4oksPQkqwmTC@nand.local>
 <Y46ZJUsyp8UW5rFW@coredump.intra.peff.net>
 <xmqqv8mpnwjp.fsf@gitster.g>
 <Y4/8ilFBfGApR8YR@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4/8ilFBfGApR8YR@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 09:38:02PM -0500, Taylor Blau wrote:

> On Tue, Dec 06, 2022 at 10:35:54AM +0900, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> >
> > > So you can think of "allocate this one element and zero it" as "calloc,
> > > but don't multiply" or as "malloc, but zero". Naming it CALLOC() is
> > > thinking of it as the former. If we think of it as the latter it could
> > > perhaps be MALLOCZ() or something. I don't know if that name is too
> > > subtle or not. We have xmemdupz(), which is basically the same thing;
> > > it's only a zero-terminator, but that is because we are writing non-zero
> > > bytes in the rest of it. Mostly I'd worry that it is easy to glance past
> > > the "Z".
> >
> > I think the name for the former would be CALLOC_ONE(), as I would
> > rephrase it as "calloc, but just one element".  I agree MALLOCZ()
> > would be fine for the other interpretation, and I do not have much
> > problem as much problem with the name as calling it CALLOC().
> 
> Between CALLOC_ONE() and MALLOCZ(), I prefer the latter for brevity. But
> between that and CALLOC(), I prefer the latter, since "CALLOC()" reminds
> me of the zero-initialization of calloc()-proper, and the "Z" in
> "MALLOCZ()" feels easy-ish to miss.

FWIW, I agree with your preferences here. But if people think CALLOC()
is misleading or badly named, I'm OK with MALLOCZ(). I guess maybe it is
ALLOCZ() to go with ALLOC_ARRAY(), and a potential ALLOC() if we choose
to have one.

-Peff
