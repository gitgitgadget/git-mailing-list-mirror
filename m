Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E188620798
	for <e@80x24.org>; Sat, 14 Jan 2017 18:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdANSFy (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 13:05:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:39236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdANSFy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 13:05:54 -0500
Received: (qmail 20548 invoked by uid 109); 14 Jan 2017 18:05:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Jan 2017 18:05:53 +0000
Received: (qmail 14346 invoked by uid 111); 14 Jan 2017 18:06:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Jan 2017 13:06:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jan 2017 13:05:50 -0500
Date:   Sat, 14 Jan 2017 13:05:50 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH v3 01/38] sequencer: avoid unnecessary curly braces
Message-ID: <20170114180550.ebra5qexewetuoyk@sigill.intra.peff.net>
References: <cover.1481642927.git.johannes.schindelin@gmx.de>
 <cover.1483370556.git.johannes.schindelin@gmx.de>
 <bc1a6c21c9ab2f55882c363e802bfcf37e49d79f.1483370556.git.johannes.schindelin@gmx.de>
 <xmqqk2a0ktxr.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1701141856240.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701141856240.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2017 at 06:57:13PM +0100, Johannes Schindelin wrote:

> On Thu, 12 Jan 2017, Junio C Hamano wrote:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > 
> > >  
> > > -	if (!commit->parents) {
> > > +	if (!commit->parents)
> > >  		parent = NULL;
> > > -	}
> > >  	else if (commit->parents->next) {
> > >  		/* Reverting or cherry-picking a merge commit */
> > >  		int cnt;
> > 
> > The result becomes
> > 
> > 	if (...)
> > 		single statement;
> > 	else if (...) {
> > 		multiple;
> >                 statements;
> >         }
> > 
> > which is not quite an improvement.  
> 
> Yet, this used to be the coding style of Git, and your statement comes
> quite as a surprise to me.

Yeah, I thought we were OK with:

  if (cond)
	single statement;
  else {
	multiple;
	statements;
  }

but not the other way around:

  if (cond) {
	multiple;
	statements;
  } else
	single statement;

I don't know if the "else if" changes that or not, but I certainly have
written things like your patch does.

-Peff
