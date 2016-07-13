Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3771420195
	for <e@80x24.org>; Wed, 13 Jul 2016 02:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbcGMCBx (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 22:01:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:43875 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752502AbcGMCBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 22:01:52 -0400
Received: (qmail 2017 invoked by uid 102); 13 Jul 2016 02:01:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 22:01:37 -0400
Received: (qmail 8889 invoked by uid 107); 13 Jul 2016 02:01:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 22:01:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 22:01:33 -0400
Date:	Tue, 12 Jul 2016 22:01:33 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160713020132.GA13918@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
 <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox>
 <20160712073912.GA26431@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607121257450.6426@virtualbox>
 <xmqqbn2267zq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbn2267zq.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 11:12:25AM -0700, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Cool! Thanks for working on this.
> >
> > Well, I had to. Git for Windows v2.9.1 needs to get released, and I won't
> > do that with a failing test suite.
> 
> Let's do 2.9.2 together, as this is not limited to GfW.
> 
> Taking Peff's suggestions into account, perhaps like the attached?

It looks good to me.

> It wasn't readily apparent to me why 2038 check worked, so I added a
> short paragraph at the end, but those who know the test helper well
> enough may find it redundant, in which case I am fine with removing
> it.

Definitely keep that paragraph. I am quite familiar with the test
helper and it was not the outcome I initially expected.

> +test_lazy_prereq 64BIT_TIME '
> +	case "$(test-date show:iso 9999999999)" in
> +	*" -> 2038-"*)
> +		# on this platform, unsigned long is 32-bit, i.e. not large enough
> +		false

I see you tightened up the match a little. TBH, I think we could
probably just match the whole output string, but I doubt there's much
chance of a false positive either way.

-Peff
