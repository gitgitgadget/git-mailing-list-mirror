Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A484203C1
	for <e@80x24.org>; Tue, 15 Nov 2016 03:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938659AbcKOD6s (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 22:58:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:43225 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933542AbcKOD6r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 22:58:47 -0500
Received: (qmail 12585 invoked by uid 109); 15 Nov 2016 03:58:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Nov 2016 03:58:47 +0000
Received: (qmail 7942 invoked by uid 111); 15 Nov 2016 03:59:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 22:59:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2016 22:58:44 -0500
Date:   Mon, 14 Nov 2016 22:58:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        spearce@spearce.org
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any
 output
Message-ID: <20161115035844.e6ehuy7uigqinbnv@sigill.intra.peff.net>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
 <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
 <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
 <20161115004426.unheihlmftlw6ex7@sigill.intra.peff.net>
 <xmqqa8d1v9lo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8d1v9lo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 05:02:27PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Actually, I take it back. I think it works for a single round of ref
> > negotiation, but not for multiple. Enabling GIT_TEST_LONG=1 causes it to
> > fail t5551.
> >
> > I think I've probably made a mis-assumption on exactly when in the HTTP
> > protocol we will see a flush packet (and perhaps that is a sign that
> > this protocol-snooping approach is not a good one).
> 
> Hmph.  I think I tried David's original under GIT_TEST_LONG and saw
> it got stuck; could be the same issue, I guess.

It works OK here. I think it is just that the test is really slow (by
design).

-Peff
