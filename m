Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D231F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426652AbeCBKtJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:49:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:44042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1426648AbeCBKtH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:49:07 -0500
Received: (qmail 7620 invoked by uid 109); 2 Mar 2018 10:49:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Mar 2018 10:49:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27200 invoked by uid 111); 2 Mar 2018 10:49:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Mar 2018 05:49:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2018 05:49:04 -0500
Date:   Fri, 2 Mar 2018 05:49:04 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] roll back locks in various code paths
Message-ID: <20180302104904.GC11074@sigill.intra.peff.net>
References: <xmqq4llzha5m.fsf@gitster-ct.c.googlers.com>
 <20180301204020.24406-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180301204020.24406-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 01, 2018 at 09:40:20PM +0100, Martin Ågren wrote:

> After thinking about it, I tend to agree. That rewrite loses an
> indentation level and makes it a bit clearer that we have two steps,
> "maybe bail" and "write". But at the cost of duplicating logic -- after
> all, those two steps are very closely related, so there's no need to
> artificially separate them.
> 
> Here it is again, without that hunk, and without the commit message
> claim that it'd be a good thing to have just a few uses of
> "active_cache_changed" remaining.

Thanks, this version looks good to me. The name SKIP_IF_UNCHANGED is
generic and may result in clashes down the road. But then so is the name
COMMIT_LOCK. I'm OK to punt on that until we do see such a collision, at
which point we may want to provide a consistent namespace for these
flags.

-Peff
