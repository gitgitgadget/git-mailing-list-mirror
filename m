Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D2120437
	for <e@80x24.org>; Fri, 13 Oct 2017 14:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758280AbdJMO0u (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 10:26:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:52174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1758450AbdJMO0s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 10:26:48 -0400
Received: (qmail 23568 invoked by uid 109); 13 Oct 2017 14:26:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 14:26:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25860 invoked by uid 111); 13 Oct 2017 14:26:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 10:26:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 10:26:46 -0400
Date:   Fri, 13 Oct 2017 10:26:46 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Constantine <hi-angel@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
Subject: Re: git-clone causes out of memory
Message-ID: <20171013142646.evapso5uxzvh2r2p@sigill.intra.peff.net>
References: <2f9b8856-dacc-768d-32c2-985f5f145ba7@yandex.ru>
 <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
 <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
 <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
 <20171013135058.q7vhufdtin42ddic@sigill.intra.peff.net>
 <53f98311-3c5f-9863-5f6c-bc4f25fad317@gmail.com>
 <20171013135636.o2vhktt7aqx6luuy@sigill.intra.peff.net>
 <20171013141018.62zvezivkkhloc5d@sigill.intra.peff.net>
 <20171013142004.ocxpdkkbcxpi52yv@sigill.intra.peff.net>
 <42cbcb4f-7f9d-df69-f55e-0ba42b931957@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42cbcb4f-7f9d-df69-f55e-0ba42b931957@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 10:25:10AM -0400, Derrick Stolee wrote:

> This does appear to be the problem. The missing DIFF_OPT_HAS_CHANGES is
> causing diff_can_quit_early() to return false. Due to the corner-case of the
> bug it seems it will not be a huge performance improvement in most cases.
> Still worth fixing and I'm looking at your suggestions to try and learn this
> area better.

Yeah, I just timed some pathspec limits on linux.git, and it makes at
best a fraction of a percent improvement (but any improvement is well
within run-to-run noise). Which is not surprising.

I agree it's worth fixing, though.

-Peff
