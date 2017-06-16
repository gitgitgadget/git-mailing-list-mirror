Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E34820401
	for <e@80x24.org>; Fri, 16 Jun 2017 04:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbdFPEao (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 00:30:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:41213 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbdFPEan (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 00:30:43 -0400
Received: (qmail 19008 invoked by uid 109); 16 Jun 2017 04:30:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 04:30:43 +0000
Received: (qmail 32108 invoked by uid 111); 16 Jun 2017 04:30:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 00:30:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jun 2017 00:30:41 -0400
Date:   Fri, 16 Jun 2017 00:30:41 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
Message-ID: <20170616043040.sofnpqthmt2skdjt@sigill.intra.peff.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
 <20170306182423.GB183239@google.com>
 <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
 <20170615110518.ordr43idf2jluips@glandium.org>
 <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
 <20170615211022.vmedlcwmvtdiseqx@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170615211022.vmedlcwmvtdiseqx@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 06:10:22AM +0900, Mike Hommey wrote:

> > > What do the experts think or SHA512/256, which completely removes the
> > > concerns over length extension attack? (which I'd argue is better than
> > > sweeping them under the carpet)
> > 
> > I don't think it's sweeping them under the carpet. Git does not use the
> > hash as a MAC, so length extension attacks aren't a thing (and even if
> > we later wanted to use the same algorithm as a MAC, the HMAC
> > construction is a well-studied technique for dealing with it).
> 
> AIUI, length extension does make brute force collision attacks (which,
> really Shattered was) cheaper by allowing one to create the collision
> with a small message and extend it later.
> 
> This might not be a credible thread against git, but if we go by that
> standard, post-shattered Sha-1 is still fine for git. As a matter of
> fact, MD5 would also be fine: there is still, to this day, no preimage
> attack against them.

I think collision attacks are of interest to Git. But I would think
2^128 would be enough (TBH, 2^80 probably would have been enough for
SHA-1; it was the weaknesses that brought that down by a factor of a
million that made it a problem).

-Peff
