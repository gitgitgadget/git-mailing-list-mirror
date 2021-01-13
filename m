Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71592C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1759C23406
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbhAMNOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:14:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:54670 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbhAMNOi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 08:14:38 -0500
Received: (qmail 22417 invoked by uid 109); 13 Jan 2021 13:13:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 13:13:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29725 invoked by uid 111); 13 Jan 2021 13:13:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 08:13:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 08:13:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <X/7yFdqUmSmRE8A0@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <xmqqk0shznvf.fsf@gitster.c.googlers.com>
 <X/5ER+ml/MhDjROA@nand.local>
 <xmqqft35ziog.fsf@gitster.c.googlers.com>
 <X/5nsw6uqKDCHGql@nand.local>
 <xmqq4kjlz1qf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kjlz1qf.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 12:21:12AM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > If you agree that the bottom topic is stable, I'd prefer to send the top
> > one separately. Otherwise, I can send both together. Let me know.
> 
> I do not expect the first 20 of the 20+8 patches to be stable from
> the beginning---in fact, after reading 01/20 myself, and seeing a
> few of Peff's reviews, I expect that you'll be redoing at least some
> of them.

They'll definitely need at least one re-roll. But I think Taylor is
expecting (and I do too) that the second half will probably have a lot
more back-and-forth over the on-disk format, and hence need more
re-rolls.

My main concern is reviewer fatigue. 28 patches is a lot. If we can
solidify the first 20 and then let people focus on the final 8
separately, that helps. If you're OK with splitting a topic and saying
"this is a re-roll of just the last 8 patches", then that problem is
solved. But IMHO it is easier to just point out that split from the
start than it is to come up with it after the fact. It tells reviewers
what to expect from the get-go.

>  (2) to find good points to divide the series into two (or more)
>      pieces, and spend more effort on helping the bottom part to
>      solidify faster.

I think we just did that preemptively. ;) In these two particular
series, the first 20 (or at least the first 19) are an improvement by
themselves. I think they would be worth doing even without the final 8,
both to make calling code more readable and to add new error checks and
assertions to revindex access.

> That way, the bottom part can be merged sooner to 'next' than the
> rest.  It always is cumbersome to have some part of the series in
> 'next' and remainder in 'seen', so at that point, the lower half
> would naturally gain a different name before it gets merged to
> 'next', I would think.

That seems to me like it ends up being _more_ work than just making them
into two branches in the first place.

So I guess I remain skeptical that ad-hoc splitting of longer series is
easier than doing so up front. But you're the one who does all of the
branch shuffling in the end, so if you really prefer longer series, I'm
not what I think matters that much. ;)

-Peff
