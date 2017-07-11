Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A849A202DD
	for <e@80x24.org>; Tue, 11 Jul 2017 04:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbdGKEif (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 00:38:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:36490 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751107AbdGKEie (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 00:38:34 -0400
Received: (qmail 21136 invoked by uid 109); 11 Jul 2017 04:38:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 04:38:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12116 invoked by uid 111); 11 Jul 2017 04:38:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 00:38:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 00:38:31 -0400
Date:   Tue, 11 Jul 2017 00:38:31 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
Message-ID: <20170711043831.cffutjnrxo3pcyst@sigill.intra.peff.net>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
 <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
 <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 11:11:35PM +0200, Johannes Sixt wrote:

> > I am not sure what negative impact you think the macro-ness would
> > have to the validity of the result from this test balloon.  An old
> > compiler that does not understand designated initializer syntax
> > would fail to compile both the same way, no?
> > 
> > 	struct strbuf buf0 = STRBUF_INIT;
> > 	struct strbuf buf1 = { .alloc = 0, .len = 0, .buf = strbuf_slopbuf };
> 
> I said it is uninteresting, not that there is a negative impact. There is
> simply nothing gained for strbuf users: They would use STRBUF_INIT before
> and after the change and would not benefit from designated initializers.
> 
> This change may serve well as a test balloon, but not as an example of the
> sort of changes that we would want to see later (of the kind "change
> FOO_INIT macro to use designated initializers"; they are just code churn).

But that is exactly the point. First the test balloon, wait a release or
two, and then make real useful changes. The purpose of the test balloon
is to gather data with minimal impact. To be useful, the changes would
be pervasive, and that would not have minimal impact.

-Peff
