Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C0920305
	for <e@80x24.org>; Thu, 11 Apr 2019 04:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDKES0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 00:18:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:54518 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726037AbfDKES0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 00:18:26 -0400
Received: (qmail 2150 invoked by uid 109); 11 Apr 2019 04:18:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 04:18:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24030 invoked by uid 111); 11 Apr 2019 04:18:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 00:18:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 00:18:24 -0400
Date:   Thu, 11 Apr 2019 00:18:24 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ls-files: use correct format string
Message-ID: <20190411041823.GA17699@sigill.intra.peff.net>
References: <20190407184751.28027-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190407184751.28027-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 07, 2019 at 07:47:51PM +0100, Thomas Gummerer wrote:

> struct stat_data and struct cache_time both use unsigned ints for all
> their members.  However the format string for 'git ls-files --debug'
> currently uses %d for formatting these numbers.  This means that we
> potentially print these values incorrectly if they are greater than
> INT_MAX.
> 
> This has been the case since the --debug option was introduced in 'git
> ls-files' in 8497421715 ("ls-files: learn a debugging dump format",
> 2010-07-31).

I didn't see any comment on this, but it seems like it must be obviously
correct, since as you note we do define those fields as unsigned. I'm
really surprised that -Wformat doesn't catch this, though. I wonder why.

-Peff
