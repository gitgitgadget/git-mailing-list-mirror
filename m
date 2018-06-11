Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD211F403
	for <e@80x24.org>; Mon, 11 Jun 2018 21:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934377AbeFKVKi (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 17:10:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:41858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934324AbeFKVKg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 17:10:36 -0400
Received: (qmail 13659 invoked by uid 109); 11 Jun 2018 21:10:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 21:10:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18746 invoked by uid 111); 11 Jun 2018 21:10:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 17:10:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 17:10:34 -0400
Date:   Mon, 11 Jun 2018 17:10:34 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 1/2] pack-bitmap: remove bitmap_git global variable
Message-ID: <20180611211033.GB26235@sigill.intra.peff.net>
References: <cover.1528397984.git.jonathantanmy@google.com>
 <d4d4fec265c1c53e14da465904d93e559ff2c17d.1528397984.git.jonathantanmy@google.com>
 <20180609060437.GA30224@sigill.intra.peff.net>
 <20180611115046.d03f8093347dc6c0e9b116fc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180611115046.d03f8093347dc6c0e9b116fc@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 11:50:46AM -0700, Jonathan Tan wrote:

> Here's an paragraph to be added to the end of the commit message. I can
> send a reroll with the exact same code but with the updated commit
> message if Junio requests it.
> 
> [additional paragraph begin]
> 
> This patch raises two potential issues: (1) memory for the struct
> bitmap_index is allocated without being freed, and (2)
> prepare_bitmap_git() and prepare_bitmap_walk() can reuse a previously
> loaded bitmap. For (1), this will be dealt with in a subsequent patch in
> this patch set that also deals with freeing the contents of the struct
> bitmap_index (which were not freed previously, because they have global
> scope). For (2), current bitmap users only load the bitmap once at most
> (note that pack-objects can use bitmaps or write bitmaps, but not both
> at the same time), so support for reuse has no effect - and future users
> can pass around the struct bitmap_index * obtained if they need to do 2
> or more things with the same bitmap.
> 
> [additional paragraph end]

Yeah, that sounds fine to me. Thanks.

-Peff
