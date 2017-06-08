Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58EED1F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 07:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbdFHHV5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 03:21:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:36368 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750860AbdFHHV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 03:21:56 -0400
Received: (qmail 29144 invoked by uid 109); 8 Jun 2017 07:21:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Jun 2017 07:21:55 +0000
Received: (qmail 9981 invoked by uid 111); 8 Jun 2017 07:21:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Jun 2017 03:21:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Jun 2017 03:21:54 -0400
Date:   Thu, 8 Jun 2017 03:21:53 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] fast-import: Increase the default pack depth to 50
Message-ID: <20170608072153.3fchkvjmudlhhstr@sigill.intra.peff.net>
References: <20170608053436.9121-1-mh@glandium.org>
 <20170608070537.zgrcxhl57u4akzvq@sigill.intra.peff.net>
 <20170608071152.bnjr5zopbb3aly62@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170608071152.bnjr5zopbb3aly62@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 04:11:52PM +0900, Mike Hommey wrote:

> > It probably doesn't matter that much, though, as you'd really want to
> > `repack -f` afterwards if you care about getting good deltas. And one
> > base object every 50 versions is probably fine for keeping the initial
> > pack manageable.
> 
> It actually is possible to have non-linear delta chains with
> fast-import, because the cat-blob command resets the delta base when
> storing a blob. See
> https://github.com/git/git/blob/v2.13.1/fast-import.c#L2984-L2987
> 
> As a side effect of that, git-cinnabar[1] ends up with decent-ish delta
> chains out of the box, without having to go with repack -f, when the
> mercurial server gives out changegroup version 2.

Interesting. Today I learned.

I agree that bumping the "10" to "50" is doubly important then.

-Peff
