Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA711F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbeKLWTF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:19:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:35342 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729476AbeKLWTF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:19:05 -0500
Received: (qmail 23664 invoked by uid 109); 12 Nov 2018 12:26:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 12:26:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10181 invoked by uid 111); 12 Nov 2018 12:25:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 07:25:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 07:26:00 -0500
Date:   Mon, 12 Nov 2018 07:26:00 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Upcast size_t variables to uintmax_t when printing
Message-ID: <20181112122600.GD3956@sigill.intra.peff.net>
References: <20181111070504.12858-1-tboegi@web.de>
 <20181111072835.GL30850@sigill.intra.peff.net>
 <20181111101650.GA4471@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181111101650.GA4471@tor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 11:16:50AM +0100, Torsten Bögershausen wrote:

> > I like the overall direction. I feel a little funny doing this step now,
> > and not as part of a series to convert individual variables. But I
> > cannot offhand think of any reason that it would behave badly even if
> > the other part does not materialize
> > 
> 
> Hej all,
> There may be some background information missing:
> - I did a 2-patch series based on this commit in pu:
>     commit 37c59c3e8fac8bae7ccc5baa148b0e9bae0c8d65
>     Author: Junio C Hamano <gitster@pobox.com>
>     Date:   Sat Oct 27 16:42:25 2018 +0900
> 
>         treewide: apply cocci patch
> 
> (that patch was never send out, see below)
> ....
> The week later, I tried to apply it on pu, but that was nearly hopeless,
> as too much things had changed on pu.
> I had the chance to compile & test it, but decided to take "part2" before
> "part1", so to say:
> Fix all the printing, and wait for the master branch to settle,
> and then do the "unsigned long" -> size_t conversion.
> That will probably happen after 2.20.

Ah, OK. I am fine with that approach. My thinking was that we'd see
individual functions and their callers converted, which is another way
to do it incrementally. But sometimes that ends up cascading and you end
up having to change quite a bit of the callstack anyway.

-Peff
