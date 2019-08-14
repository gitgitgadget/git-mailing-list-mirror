Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 749D81F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 16:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfHNQBc (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 12:01:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:43374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726047AbfHNQBc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 12:01:32 -0400
Received: (qmail 17301 invoked by uid 109); 14 Aug 2019 16:01:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Aug 2019 16:01:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17439 invoked by uid 111); 14 Aug 2019 16:02:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Aug 2019 12:02:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Aug 2019 12:01:31 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        l.s.r@web.de
Subject: Re: [RFC PATCH] http: use xmalloc with cURL
Message-ID: <20190814160130.GD12093@sigill.intra.peff.net>
References: <20190810220251.3684-1-carenas@gmail.com>
 <nycvar.QRO.7.76.6.1908111317540.46@tvgsbejvaqbjf.bet>
 <CAPUEspg62pRNH6=_VvWDxQ4YujHUJAoTTampc0L4t68QMj30xg@mail.gmail.com>
 <20190812195537.GA14223@sigill.intra.peff.net>
 <xmqqd0ha9ml4.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1908132200110.656@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1908132200110.656@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 13, 2019 at 10:00:44PM +0200, Johannes Schindelin wrote:

> > Jeff King <peff@peff.net> writes:
> >
> > > I think it might be worth just eliminating the whole idea.
> >
> > I kinda like the simplification ;-) An even thinner wrapper that
> > calls malloc() and dies if it gets NULL, without any "try-to-free"
> > logic.
> 
> This is one of those instances where I wish we would have some reliable
> data rather than having to guess whether it is a good idea or not.

I wish we did, too. If you have an idea how to collect such data, I'm
all ears.

In the absence of that, I've made an argument that it's probably the
right thing to do, and we can see if cooking it over a release cycle
introduces any complaints. That's far from perfect (in particular, I
wouldn't be surprised if very few 32-bit users test non-releases), but I
don't have other ideas.

-Peff
