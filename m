Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95211FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 19:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbcFWTV2 (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 15:21:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:59292 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750876AbcFWTV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 15:21:27 -0400
Received: (qmail 2107 invoked by uid 102); 23 Jun 2016 19:21:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 15:21:26 -0400
Received: (qmail 14068 invoked by uid 107); 23 Jun 2016 19:21:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 15:21:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 15:21:24 -0400
Date:	Thu, 23 Jun 2016 15:21:24 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes
 >= 8GB
Message-ID: <20160623192124.GA32745@sigill.intra.peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net>
 <57687413.3030609@web.de>
 <20160621155920.GA7549@sigill.intra.peff.net>
 <5769A6CC.9030001@web.de>
 <20160621210234.GB4747@sigill.intra.peff.net>
 <576A2625.8010706@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <576A2625.8010706@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 07:46:13AM +0200, René Scharfe wrote:

> Yes, it's only useful as a debug flag, but the fact that it breaks
> highlights a (admittedly mostly theoretical) shortcoming: The code doesn't
> handle extended headers that are over the size limit as nicely as it could.
> So the test was already worth it, even if won't land in master. :)

Kind of. It was impossible to trigger in the original (and we still
don't actually handle it in the revised version; we just die in
xsnprintf).

But still, I'll go with the simpler thing we've discussed here. The
symmetry with ustar_mtime isn't worth it, and doubly so if we just write
a single pax header.

-Peff
