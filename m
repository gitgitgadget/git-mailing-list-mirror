Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11671F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeBUX3m (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:29:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:60154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751274AbeBUX3m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:29:42 -0500
Received: (qmail 21594 invoked by uid 109); 21 Feb 2018 23:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Feb 2018 23:29:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29209 invoked by uid 111); 21 Feb 2018 23:30:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Feb 2018 18:30:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Feb 2018 18:29:40 -0500
Date:   Wed, 21 Feb 2018 18:29:40 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: drop uses of get_cached_commit_buffer()
Message-ID: <20180221232939.GE7944@sigill.intra.peff.net>
References: <20180221185204.GA8476@sigill.intra.peff.net>
 <1519240631-221761-1-git-send-email-dstolee@microsoft.com>
 <20180221231338.GC7944@sigill.intra.peff.net>
 <CAGZ79kZz+hC+eXxa2A-NpnCZa-LikWDaegfijUjHp5CCenwQvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZz+hC+eXxa2A-NpnCZa-LikWDaegfijUjHp5CCenwQvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 03:22:02PM -0800, Stefan Beller wrote:

> > Subject: [PATCH] commit: drop uses of get_cached_commit_buffer()
> > ---
> >  builtin/rev-list.c | 2 +-
> >  log-tree.c         | 3 ---
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> Now if we'd get around to rewrite pretty.c as well, we could make it static,
> giving a stronger reason of not using that function. But it looks a bit
> complicated to me, who is not familiar in that area of the code.
> 
> Thanks for making less use of this suboptimal API,

I'm not sure the API is suboptimal. It's not wrong to ask "do you have a
cached copy of this?". It was just being used poorly here. :)

See the discussion in

  https://public-inbox.org/git/20180221184811.GD4333@sigill.intra.peff.net/

-Peff
