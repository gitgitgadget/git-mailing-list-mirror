Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F392047F
	for <e@80x24.org>; Fri,  4 Aug 2017 21:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbdHDVWe (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 17:22:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:58174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752012AbdHDVWd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 17:22:33 -0400
Received: (qmail 18478 invoked by uid 109); 4 Aug 2017 21:22:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Aug 2017 21:22:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29292 invoked by uid 111); 4 Aug 2017 21:22:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Aug 2017 17:22:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Aug 2017 17:22:31 -0400
Date:   Fri, 4 Aug 2017 17:22:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC] imap-send: escape backslash in password
Message-ID: <20170804212231.pl3uipcsujflcuha@sigill.intra.peff.net>
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
 <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
 <87bmnvktee.fsf@linux-m68k.org>
 <20170804202255.3oia7ivsoa6vu4me@sigill.intra.peff.net>
 <xmqq3797t4kq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq3797t4kq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 04, 2017 at 02:18:13PM -0700, Junio C Hamano wrote:

> > I also think it might be reasonable to scrap all of this ad-hoc imap
> > code in favor of curl, which already gets these cases right. We already
> > have a curl-backed implementation. I think we just left the old code out
> > of conservatism. But it seems somewhat buggy and unmaintained, and I
> > wonder if we aren't better off to simply encourage people to install
> > curl.
> 
> That is a very attractive direction to go in, especially in the mid
> to longer term.  Perhaps we declare that the ad-hoc hardcoded imap
> is deprecated in the next cycle and drop the support by the end of
> this year?

That is fine by me. AFAIK, we already build the curl support by default
when a sufficiently-advanced version of curl is available. So if there
were feature-parity problems hopefully somebody would have reported it.

I think the deprecation here can be relatively fast because we're not
actually dropping support for any feature. We're just requiring that
they install curl to get the same functionality (which might be
inconvenient, but it's a heck of a lot less inconvenient than "there's
no way to do what you want anymore").

-Peff
