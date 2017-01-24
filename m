Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777361F437
	for <e@80x24.org>; Tue, 24 Jan 2017 20:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbdAXUlJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 15:41:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:44064 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbdAXUlI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 15:41:08 -0500
Received: (qmail 3483 invoked by uid 109); 24 Jan 2017 20:41:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 20:41:08 +0000
Received: (qmail 5029 invoked by uid 111); 24 Jan 2017 20:41:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 15:41:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2017 15:41:06 -0500
Date:   Tue, 24 Jan 2017 15:41:06 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] string-list: make string_list_sort() reentrant
Message-ID: <20170124204105.2iqmincozuqbmqo2@sigill.intra.peff.net>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
 <20170123235445.qsejumltutd2vrhd@sigill.intra.peff.net>
 <b333ecd4-a147-904d-b1ce-b49179c4ad26@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b333ecd4-a147-904d-b1ce-b49179c4ad26@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 07:00:07PM +0100, René Scharfe wrote:

> Am 24.01.2017 um 00:54 schrieb Jeff King:
> > The speed looks like a reasonable outcome. I'm torn on the qsort_r()
> > demo patch. I don't think it looks too bad. OTOH, I don't think I would
> > want to deal with the opposite-argument-order versions.
> 
> The code itself may look OK, but it's not really necessary and the special
> implementation for Linux makes increases maintenance costs.  Can we save it
> for later and first give the common implemention a chance to prove itself?

Sure, I'm OK with leaving it out for now.

> > Is there any interest in people adding the ISO qsort_s() to their libc
> > implementations? It seems like it's been a fair number of years by now.
> 
> https://sourceware.org/ml/libc-alpha/2014-12/msg00513.html is the last post
> mentioning qsort_s on the glibc mailing list, but it didn't even make it
> into https://sourceware.org/glibc/wiki/Development_Todo/Master.
> Not sure what's planned in BSD land, didn't find anything (but didn't look
> too hard).

So it sounds like "no, not really". I think that's OK. I was mostly
curious if we could expect our custom implementation to age out over
time.

-Peff
