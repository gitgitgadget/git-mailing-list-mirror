Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312221F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBHTNA (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:13:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:37930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726858AbfBHTM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:12:59 -0500
Received: (qmail 14101 invoked by uid 109); 8 Feb 2019 19:12:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 19:12:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26601 invoked by uid 111); 8 Feb 2019 19:13:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 14:13:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 14:12:58 -0500
Date:   Fri, 8 Feb 2019 14:12:58 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make '--stress' more bisect-friendly
Message-ID: <20190208191257.GE27673@sigill.intra.peff.net>
References: <20190208115045.13256-1-szeder.dev@gmail.com>
 <20190208164732.GA23461@sigill.intra.peff.net>
 <20190208164937.GB23461@sigill.intra.peff.net>
 <20190208183307.GZ10587@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208183307.GZ10587@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 07:33:07PM +0100, SZEDER Gábor wrote:

> On Fri, Feb 08, 2019 at 11:49:37AM -0500, Jeff King wrote:
> >   One other thing I've noticed with it: I forget to add my custom
> >   --root=/var/ram/git-tests when I invoke it, so my hard disk goes
> >   crazy (and the tests often run slower!). I'm not sure if there's a
> >   convenient fix.
> 
> OTOH, that could introduce more variance in the timing of the test's
> commands, thus potentially increasing the chances of a failure.  I
> dunno.
> 
> Maybe ./t1234-foo.sh should learn to respect DEFAULT_TEST_OPTS
> somehow?

Yeah, that was what I was thinking. On the other hand, I'd actually find
that a little bit annoying for the non-stress case. I commonly do
"./t1234-foo.sh" in order to dig into a specific breakage, and having
the failing trash directory right there is convenient (and I don't care
as much about speed, since I'm just running it once).

I may just gut my "stress" script and make it a wrapper for calling
the script with "--stress --root=...". :)

-Peff
