Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A252220281
	for <e@80x24.org>; Thu, 21 Sep 2017 04:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbdIUEwD (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 00:52:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:45598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750795AbdIUEwD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 00:52:03 -0400
Received: (qmail 1940 invoked by uid 109); 21 Sep 2017 04:52:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 04:52:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19106 invoked by uid 111); 21 Sep 2017 04:52:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 00:52:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 00:52:00 -0400
Date:   Thu, 21 Sep 2017 00:52:00 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] diff-lib: clear `pending` object-array in
 `index_differs_from()`
Message-ID: <20170921045200.bw2yezcwmlxvemwn@sigill.intra.peff.net>
References: <1505936846-2195-2-git-send-email-martin.agren@gmail.com>
 <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <CAN0heSqVxBreaZN9x1XtX2OpeAoVZNzixr+vzyCWwe8UKtdtgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqVxBreaZN9x1XtX2OpeAoVZNzixr+vzyCWwe8UKtdtgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2017 at 05:56:21AM +0200, Martin Ågren wrote:

> > Looks good. A similar bug was the exact reason for adding the function
> > in 46be82312. I did a grep for 'free.*\.objects' to see if there were
> > other cases.
> 
> Ah. I grepped for "pending.objects", but didn't go more general than that.

I did at first, too. My optimism lessened when I ran the more general
grep. :)

> > As I suspect you're working your way through leak-checker results, I'm
> > OK if you want to punt on digging into more cases for now and just fix
> > ones that the tool has identified as real leaks.
> 
> I am indeed going through ASan results. Your UNLEAK helps immensely!
> (I'm collecting UNLEAKs on the side. I see now that UNLEAK is in master,
> so I should probably submit those where I believe things are
> "UNLEAK-complete".)

Thanks! That's exactly what I'd hoped might happen when I started on
UNLEAK.

-Peff
