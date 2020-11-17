Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F613C63777
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 02:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEBA24699
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 02:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgKQCNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 21:13:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:59990 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgKQCNT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 21:13:19 -0500
Received: (qmail 13296 invoked by uid 109); 17 Nov 2020 02:13:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 02:13:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21534 invoked by uid 111); 17 Nov 2020 02:13:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Nov 2020 21:13:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Nov 2020 21:13:18 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] list-objects-filter-options: fix function name in BUG
Message-ID: <20201117021318.GA30463@coredump.intra.peff.net>
References: <20201114084327.14891-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201114084327.14891-1-martin.agren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 14, 2020 at 09:43:26AM +0100, Martin Ågren wrote:

> Fix the function name we give in the BUG message. It's "config", not
> "choice".

Yep, obviously an improvement.

But as a general rule, I don't think we even need to include function
names here. The message would look like:

  BUG: list-objects-filter-options.c:20: list_object_filter_choice_name: invalid argument '3'

which already tells us where the code is[1]. Perhaps:

  BUG("invalid filter choice enum: %d", c);

would be shorter but equally informative (I don't overly care here,
since the idea is that nobody sees it, but just making a point about the
future).

-Peff

[1] Obviously it doesn't include the actual function name, though we
    could do so on many platforms by using __FUNCTION__. I tend to think
    it would make the messages overly long, but again, the hope is that
    nobody ever sees these.
