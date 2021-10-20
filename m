Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F22C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 20:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE0561371
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 20:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhJTUjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:39:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:43056 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhJTUjF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 16:39:05 -0400
Received: (qmail 10542 invoked by uid 109); 20 Oct 2021 20:36:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Oct 2021 20:36:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29285 invoked by uid 111); 20 Oct 2021 20:36:50 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Oct 2021 16:36:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Oct 2021 16:36:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kenneth Arnold <ka37@calvin.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "Not possible to fast-forward" when pull.ff=only and new commits
 on remote
Message-ID: <YXB94Y4mqm8GpsfV@coredump.intra.peff.net>
References: <CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com>
 <YW83JG9t2JaX92xV@coredump.intra.peff.net>
 <xmqqzgr3pso7.fsf@gitster.g>
 <YXBNY7/mWyxvAo/r@coredump.intra.peff.net>
 <xmqqa6j3pkqw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6j3pkqw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 12:19:19PM -0700, Junio C Hamano wrote:

> > Running a sequence of traversals like this can be slow, because we may
> > walk over the same history again and again. But I think in the usual
> > non-octopus cases we'd only have one entry, so we'd only be adding a
> > single extra merge-base traversal in most cases.
> >
> > It does feel like this could be combined with get_can_ff() somehow so
> > that we're not adding even that single traversal. But I expect that may
> > be hard to do because of the multiple heads (e.g., we cannot use the
> > usual ahead/behind code).
> 
> I'd leave such an optimization as a separate topic.  This was meant
> to be a regression fix.

Yeah, I'm definitely OK with that. You might be making performance a
little worse with your patch, but getting correctness right is much more
important.

-Peff
