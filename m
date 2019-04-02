Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5EE20248
	for <e@80x24.org>; Tue,  2 Apr 2019 14:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfDBO2t (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 10:28:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:44308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725778AbfDBO2t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 10:28:49 -0400
Received: (qmail 29850 invoked by uid 109); 2 Apr 2019 14:28:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Apr 2019 14:28:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23622 invoked by uid 111); 2 Apr 2019 14:29:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Apr 2019 10:29:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2019 10:28:47 -0400
Date:   Tue, 2 Apr 2019 10:28:47 -0400
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] mailinfo: use starts_with() for clarity
Message-ID: <20190402142846.GB10564@sigill.intra.peff.net>
References: <20190331220104.31628-1-rybak.a.v@gmail.com>
 <20190401215334.18678-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190401215334.18678-1-rybak.a.v@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 01, 2019 at 11:53:33PM +0200, Andrei Rybak wrote:

> Existing checks using memcmp(3) never read past the end of the line,
> because all substrings we are interested in are two characters long, and
> the outer loop guarantees we have at least one character. So at most we
> will look at the NUL.
> 
> However, this is too subtle and may lead to bugs in code which copies
> this behavior without realizing substring length requirement.  So use
> starts_with() instead, which will stop at NUL regardless of the length
> of the prefix. Remove extra pair of parentheses while we are here.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
> 
> On Mon, Apr 01, 2019 at 06:11:57 -0400, Jeff King wrote:
> > I wonder if it's worth re-writing it like:
> 
> Turned Peff's suggestion into a patch.

Thanks. I think this may be worth doing regardless of what happens with
patch 2.

-Peff
