Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7881F744
	for <e@80x24.org>; Wed, 20 Jul 2016 20:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbcGTUyQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 16:54:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:47778 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755002AbcGTUyP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 16:54:15 -0400
Received: (qmail 28922 invoked by uid 102); 20 Jul 2016 20:54:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 16:54:16 -0400
Received: (qmail 24710 invoked by uid 107); 20 Jul 2016 20:54:38 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 16:54:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 14:54:12 -0600
Date:	Wed, 20 Jul 2016 14:54:12 -0600
From:	Jeff King <peff@peff.net>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH v1 4/6] Expanded branch header for Porcelain Status V2
Message-ID: <20160720205411.GB578@sigill.intra.peff.net>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-5-git-send-email-jeffhost@microsoft.com>
 <20160720160635.GC24902@sigill.intra.peff.net>
 <578FC0E8.4010102@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <578FC0E8.4010102@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 02:20:24PM -0400, Jeff Hostetler wrote:

> > IIRC, it happens when HEAD points to a broken ref. So something like:
> > 
> >    git init
> >    echo broken >.git/refs/heads/master
> > 
> > would cause resolving HEAD to return NULL.
> 
> That worked and I see "(unknown)".
> 
> This is a bit of a nit, but is there a value we'd like
> to see there, such as "(unknown)" or "(broken)" or "(missing)"
> in that case?  (And make it clear that this is a different
> case from "(detached)".)
> 
> I'm thinking it would be nicer to always have a field
> there for parsing.

My gut feeling is to err on the side of being vague, like "unknown".
This is something that _shouldn't_ ever happen, and if it does, it could
be a broken on-disk ref, a transient syscall error, or some other
weirdness. I don't think we need to get too specific in this context
(we'll likely have said something else useful on stderr already, I
think).

-Peff
