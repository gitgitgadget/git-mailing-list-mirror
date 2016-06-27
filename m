Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C252018A
	for <e@80x24.org>; Mon, 27 Jun 2016 14:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbcF0OhI (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 10:37:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:33229 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751846AbcF0OhH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 10:37:07 -0400
Received: (qmail 23603 invoked by uid 102); 27 Jun 2016 14:36:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 10:36:51 -0400
Received: (qmail 7984 invoked by uid 107); 27 Jun 2016 14:37:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 10:37:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 10:36:48 -0400
Date:	Mon, 27 Jun 2016 10:36:48 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Eric Wong <e@80x24.org>, Stefan Beller <sbeller@google.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
Message-ID: <20160627143648.GA2618@sigill.intra.peff.net>
References: <20160626232112.721-1-e@80x24.org>
 <20160626232112.721-2-e@80x24.org>
 <20160626234251.GA21668@sigill.intra.peff.net>
 <xmqqoa6mdbu3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa6mdbu3.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 06:02:12AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I also wondered how we managed to miss such an obvious point in review
> > of the original patch. Sadly, we _did_ notice it[1] but it looks like we
> > never fixed the problem. That is even more disturbing.
> 
> Yes indeed.
> 
> I try to pay attention to "this is broken because..."  comments in
> discussions to make a note in my copy of "What's cooking" report for
> a problematic topic, as that is where I work from when merging
> topics down, but apparently that procedure failed work in this case.
> There needs a stronger mechanism to stop a known-buggy patch from
> going thru, but I am not sure offhand what that should be.

I was the one who saw the bug. I could have followed the series more
closely to make sure my concern was addressed. Or possibly pointed out
the bug more prominently than an in a "PS" as part of the discussion.

I think part of the problem was that this particular series was
large-ish and involved a lot of re-rolls, and I got sick of looking at
it. I dunno.

It's also true that our error rate will never be 0%. So some bugs will
always slip through, some review comments will be forgotten, etc. Eric
did find and fix the bug just now, so the "many eyes" theory did work
here eventually.

-Peff
