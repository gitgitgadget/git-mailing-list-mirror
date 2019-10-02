Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5EE1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 15:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfJBPrg (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 11:47:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:38044 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726179AbfJBPrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 11:47:36 -0400
Received: (qmail 24968 invoked by uid 109); 2 Oct 2019 15:47:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Oct 2019 15:47:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22747 invoked by uid 111); 2 Oct 2019 15:50:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2019 11:50:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Oct 2019 11:47:35 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, Charles Diza <chdiza@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Revert "progress: use term_clear_line()"
Message-ID: <20191002154734.GC6116@sigill.intra.peff.net>
References: <20190822162907.GA17013@sigill.intra.peff.net>
 <20190916205412.8602-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190916205412.8602-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 16, 2019 at 10:54:10PM +0200, SZEDER Gábor wrote:

> > Yes on that final bit. We could always fall back to (4) if the terminal
> > information is not available, but given that the benefit is mostly in
> > simplifying the code, I don't know if it's worth carrying around _two_
> > solutions.
> 
> Ok, so here is a patch to revert 5b12e3123b (progress: use
> term_clear_line(), 2019-06-24) with proper explanation.
> 
> As a bonus there is a new test script exercising the progress display
> as well, in particular how it covers up the previous progress line, so
> we may have a bit more confidence in it.

Thanks for doing this. It's especially nice to get test coverage for the
progress meters, which have traditionally been neglected.

I'm a little late on my review, as it looks like this has already hit
next, but it looks pretty good to me.

My only complaint is that I think putting the new "private" bits of the
progress API into the header (with a comment) is a lesser evil than
re-declaring them in test-progress.c (if only because the compiler could
tell us if the two get out of sync). But I can live with it either way.

-Peff
