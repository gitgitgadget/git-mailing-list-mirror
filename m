Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD31202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933434AbdKAWQV (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:16:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:43316 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933294AbdKAWQV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:16:21 -0400
Received: (qmail 29828 invoked by uid 109); 1 Nov 2017 22:16:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 22:16:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16025 invoked by uid 111); 1 Nov 2017 22:16:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 18:16:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Nov 2017 18:16:18 -0400
Date:   Wed, 1 Nov 2017 18:16:18 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
Message-ID: <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 01, 2017 at 10:46:14PM +0100, Johannes Schindelin wrote:

> >   - it calls die() rather than returning an error. Looking at the
> >     callsites, I'm inclined to say that would be fine. Failing to write
> >     to the todo file is essentially a fatal error for sequencer code.
> 
> I spent substantial time on making the sequencer code libified (it was far
> from it). That die() call may look okay now, but it is not at all okay if
> we want to make Git's source code cleaner and more reusable. And I want
> to.
> 
> So my suggestion is to clean up write_file_buf() first, to stop behaving
> like a drunk lemming, and to return an error value already, and only then
> use it in sequencer.c.

That would be fine with me, too.

-Peff
