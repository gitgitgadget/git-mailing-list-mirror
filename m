Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BDA920984
	for <e@80x24.org>; Tue, 13 Sep 2016 18:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759884AbcIMSSN (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 14:18:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:42736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1759618AbcIMSSN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 14:18:13 -0400
Received: (qmail 5672 invoked by uid 109); 13 Sep 2016 18:18:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 18:18:12 +0000
Received: (qmail 24667 invoked by uid 111); 13 Sep 2016 18:18:22 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 14:18:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2016 11:18:09 -0700
Date:   Tue, 13 Sep 2016 11:18:09 -0700
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: constify parameters of checkout_stage() and
 checkout_merged()
Message-ID: <20160913181807.2ow5fy6b4622sndr@sigill.intra.peff.net>
References: <a66eedc3-fc86-dd45-628c-e38018a03808@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a66eedc3-fc86-dd45-628c-e38018a03808@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 07:11:52PM +0200, René Scharfe wrote:

> Document the fact that checkout_stage() and checkout_merged() don't
> change the objects passed to them by adding the modifier const.

Hmm. Sometimes these big "context" objects are hard to make const,
because we end up using them to hold or pass state between functions
(e.g., see diff_options). So I'd worry slightly that we'll end up
un-consting this in the long run.

That being said, it is easy to revert, and it provides some small
benefit, so I don't mind it in the meantime.

-Peff
