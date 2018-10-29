Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D071F453
	for <e@80x24.org>; Mon, 29 Oct 2018 14:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeJ2XF6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 19:05:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:58940 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725920AbeJ2XF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 19:05:58 -0400
Received: (qmail 20093 invoked by uid 109); 29 Oct 2018 14:17:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 14:17:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17812 invoked by uid 111); 29 Oct 2018 14:16:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 10:16:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 10:17:06 -0400
Date:   Mon, 29 Oct 2018 10:17:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
Message-ID: <20181029141706.GB17668@sigill.intra.peff.net>
References: <87o9dar9qc.fsf@evledraar.gmail.com>
 <20181018225739.28857-1-avarab@gmail.com>
 <20181019220755.GA31563@sigill.intra.peff.net>
 <87ftx0dg4r.fsf@evledraar.gmail.com>
 <20181020185852.GA6234@sigill.intra.peff.net>
 <20181026083905.GA1705@sigill.intra.peff.net>
 <xmqqefc976x1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefc976x1.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 12:44:58PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmph. So I was speaking before purely hypothetically, but now that your
> > patch is in 'next', it is part of my daily build. And indeed, I hit a
> > false positive within 5 minutes of building it. ;)
> 
> Sounds like somebody is having not-so-fun-a-time having "I told you
> so" moment.  The 'dotgit' thing already feels bit convoluted but I
> would say that it is still within the realm of reasonable workflow
> elements.

To be clear, the "dotgit" thing _is_ weird and convoluted. And I imagine
that I push Git more than 99% of our users would. But I also won't be
surprised if somebody else has something similarly disgusting in the
wild. :)

TBH, I'm still not really sold on the idea of doing loop detection at
all in this case. But I can live with it if others feel strongly. What
makes the current patch so bad is that there's no escape hatch (i.e.,
even a depth counter with a default of "1" would have given me something
I could bump).

-Peff
