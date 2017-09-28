Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68FBE2047F
	for <e@80x24.org>; Thu, 28 Sep 2017 00:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbdI1AfV (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 20:35:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:52918 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752402AbdI1AfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 20:35:21 -0400
Received: (qmail 8517 invoked by uid 109); 28 Sep 2017 00:35:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 00:35:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21496 invoked by uid 111); 28 Sep 2017 00:36:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 20:36:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 20:35:18 -0400
Date:   Wed, 27 Sep 2017 20:35:18 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
Message-ID: <20170928003518.z5zccj762tov4moj@sigill.intra.peff.net>
References: <20170927224909.25dfojhx6wzaqwt7@sigill.intra.peff.net>
 <20170927225126.4836-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927225126.4836-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 03:51:26PM -0700, Stefan Beller wrote:

> In 146fdb0dfe (diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY,
> 2017-06-29), the conversion from direct printing to the symbol emission
> dropped the new line character for renamed, copied and rewritten files.
> 
> Add the emission of a newline, add a test for this case.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>  Peff, I am undecided about the added 'diff --stat' call as that
>  uses a completely different code path and would not show the mode
>  change, but I guess we can just use it to document the current state.

Yeah, I agree it isn't showing much. I was mostly thinking it just made
sense to test a bunch of formats across a mode change to make sure they
all showed something reasonable. But it's a rather unlikely bug that
"--stat" would _start_ showing something that it's not supposed.

I suppose that "--patch" should also possibly be included, though I'd be
surprised if that isn't covered elsewhere (but then, I was surprised
that --summary wasn't covered either).

-Peff
