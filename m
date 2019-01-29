Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642B61F453
	for <e@80x24.org>; Tue, 29 Jan 2019 16:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfA2Q5S (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 11:57:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:53468 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726852AbfA2Q5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 11:57:18 -0500
Received: (qmail 3759 invoked by uid 109); 29 Jan 2019 16:57:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 16:57:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8565 invoked by uid 111); 29 Jan 2019 16:57:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 11:57:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 11:57:16 -0500
Date:   Tue, 29 Jan 2019 11:57:16 -0500
From:   Jeff King <peff@peff.net>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pretty: Allow %(trailers) options with explicit
 value
Message-ID: <20190129165715.GB7349@sigill.intra.peff.net>
References: <20181028125025.30952-1-anders@0x63.nu>
 <20190128213337.24752-1-anders@0x63.nu>
 <20190128213337.24752-3-anders@0x63.nu>
 <xmqq8sz49zm1.fsf@gitster-ct.c.googlers.com>
 <87tvhsklpb.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tvhsklpb.fsf@0x63.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 07:45:06AM +0100, Anders Waldenborg wrote:

> > Instead of using "char buf[8]", just using a strbuf and avoidng
> > strlcpy() would make the code much better, I would think.
> 
> Yes, taking the heap allocation hit would most likely make the intent
> clearer.

If you can reuse the same struct and strbuf_reset() it each time, then
that amortizes the cost of the heap (to basically once per program run,
instead of once per commit).

-Peff
