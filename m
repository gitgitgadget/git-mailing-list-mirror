Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1291F6C1
	for <e@80x24.org>; Sun, 14 Aug 2016 10:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbcHNKgq (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 06:36:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:54976 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751290AbcHNKgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 06:36:46 -0400
Received: (qmail 2006 invoked by uid 109); 13 Aug 2016 18:36:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 18:36:42 +0000
Received: (qmail 4046 invoked by uid 111); 13 Aug 2016 18:36:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 14:36:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Aug 2016 14:36:40 -0400
Date:	Sat, 13 Aug 2016 14:36:40 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] correct FLEXPTR_* example in comment
Message-ID: <20160813183640.axpnjj44bteraevi@sigill.intra.peff.net>
References: <57AEE1E1.3080901@web.de>
 <20160813090947.uj6hurji5o6cwxge@sigill.intra.peff.net>
 <57AF582A.3050406@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57AF582A.3050406@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 07:26:02PM +0200, René Scharfe wrote:

> > I suppose it could assert(sizeof((x)->flexname) == FLEX_ALLOC) or
> > something, but I'm not sure if it is worth worrying about.
> 
> You can't use sizeof with an actual flexible array.  It only works if
> FLEX_ARRAY is defined as 1 (for platforms without native support), and
> perhaps also if it's 0.
> 
> offsetof(struct x, arr) == sizeof(struct x) won't work either because of
> padding.
> 
> I have no idea what you can do with a flexible array that would throw a
> compile error when done with a pointer.

Thanks for the input. I'd say we should not worry about it. The reason
this particular "bug" persisted is because it was in a comment. People
tend to notice code that cannot possibly do anything but segfault before
they even send in patches.

-Peff
