Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5A4F2036D
	for <e@80x24.org>; Fri, 24 Nov 2017 18:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbdKXSQn (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 13:16:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:39528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753794AbdKXSQl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 13:16:41 -0500
Received: (qmail 22257 invoked by uid 109); 24 Nov 2017 18:16:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Nov 2017 18:16:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15797 invoked by uid 111); 24 Nov 2017 18:16:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 24 Nov 2017 13:16:58 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Nov 2017 13:16:39 -0500
Date:   Fri, 24 Nov 2017 13:16:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Daudt <me@ikke.info>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
Message-ID: <20171124181639.GD29190@sigill>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
 <20171121214552.GB16418@alpha.vpn.ikke.info>
 <20171123000346.GA8718@sigill>
 <alpine.LFD.2.21.1711230241260.11944@localhost.localdomain>
 <20171123135155.GA8231@sigill>
 <20171123205503.GE16418@alpha.vpn.ikke.info>
 <xmqq7eugqykq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7eugqykq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 24, 2017 at 10:01:41AM +0900, Junio C Hamano wrote:

> Actually the second example is a lot worse (and that is why I am
> bringing it up).  If git does spend cycles to realize that "git
> could", for consistency, it must also check if "next" is unambiguous
> between a path or a rev, i.e. it must dig history from "master" and
> see if "next" appears as a path ever in the history, and if so, die
> with "ambiguous argument".

I just sent a similar response before reading this, and agree with
everything you said.

But I wanted to point out this "we must also look for ambiguities"
argument, because I totally missed it in my response. And it's much more
damning, I think, because it means you can never short-cut the easy
cases and say "OK, we found the path, therefore we can stop our
traversal early". To behave consistently, you have to always do the
whole traversal twice.

-Peff
