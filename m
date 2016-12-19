Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E52D1203EA
	for <e@80x24.org>; Mon, 19 Dec 2016 17:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933547AbcLSRTr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:19:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:58557 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933510AbcLSRTo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:19:44 -0500
Received: (qmail 16357 invoked by uid 109); 19 Dec 2016 17:19:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Dec 2016 17:19:44 +0000
Received: (qmail 31450 invoked by uid 111); 19 Dec 2016 17:20:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Dec 2016 12:20:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2016 12:19:42 -0500
Date:   Mon, 19 Dec 2016 12:19:42 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
Message-ID: <20161219171941.z3yvelyekc5ys32p@sigill.intra.peff.net>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de>
 <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de>
 <xmqqlgvhuj82.fsf@gitster.mtv.corp.google.com>
 <20161215185630.xxeimack63wqwv2e@sigill.intra.peff.net>
 <alpine.DEB.2.20.1612191758290.54750@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1612191758290.54750@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 05:59:06PM +0100, Johannes Schindelin wrote:

> > > > +		sprintf((char *)p, "%d", ++count);
> > > 
> > > Do we know the area pointed at p (which is inside buf) long enough
> > > not to overflow?  If the original were 9 and you incremented to get
> > > 10, you would need one extra byte.
> > 
> > Even if it is enough, I'd ask to please use xsnprintf(). In the off
> > chance that there's a programming error, we'd get a nice die("BUG")
> > instead of a buffer overflow (and it makes the code base easier to audit
> > for other overflows).
> 
> I ended up with more verbose, easier-to-read code that does not try to do
> things in-place, in favor of being slightly more wasteful with strbufs.

Great. I agree that should make the whole thing way more readable.

-Peff
