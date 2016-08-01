Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C1F61F855
	for <e@80x24.org>; Mon,  1 Aug 2016 21:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbcHAVM1 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:12:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:52847 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752065AbcHAVMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 17:12:25 -0400
Received: (qmail 17959 invoked by uid 102); 1 Aug 2016 21:11:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 17:11:34 -0400
Received: (qmail 18000 invoked by uid 107); 1 Aug 2016 21:12:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 17:12:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 17:11:31 -0400
Date:	Mon, 1 Aug 2016 17:11:31 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pass constants as first argument to st_mult()
Message-ID: <20160801211131.6ernsu74ohod2cin@sigill.intra.peff.net>
References: <579CEF77.9070202@web.de>
 <20160801164723.mober7em6znt56w4@sigill.intra.peff.net>
 <xmqq8twgi4qp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8twgi4qp.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 02:00:46PM -0700, Junio C Hamano wrote:

> > Since multiplication is
> > commutative, it would be correct for st_mult() to just flip the order of
> > arguments it feeds to unsigned_mult_overflows().
> >
> > That may introduce the same inefficiency in other callsites, but I
> > wonder if it would be fewer.
> 
> "git grep -A3 st_mult \*.c" seems to tell me that the callsites with
> a constant in their first parameter are the majority (many are
> sizeof(something)).  The three places in the patch under discussion
> are the only places that got them in the different order.

Thanks for checking. I should have been less lazy and done it myself.
If the majority are the other way, I agree that just fixing the minority
is the best path forward.

> *1* I have a slight suspicion that this is cultural, i.e. how
> arithmetic is taught in grade schools.  When an apple costs 30 yen
> and I have 5 of them, I was taught to multiply 30x5 to arrive at
> 150, not 5x30=150, and I am guessing that is because the former
> matches the natural order of these two numbers (cost, quantity) in
> the language I was taught.

You might be right. I was trying to figure out what is "natural" for me
in these cases, but after thinking about it for 2 minutes, I'm pretty
sure anything resembling "natural" is lost as I try to out-think myself. :)

-Peff
