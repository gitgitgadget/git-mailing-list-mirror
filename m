Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8AF9202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 23:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966205AbdIYX1J (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 19:27:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:49906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966123AbdIYX1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 19:27:08 -0400
Received: (qmail 11204 invoked by uid 109); 25 Sep 2017 23:27:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 23:27:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30537 invoked by uid 111); 25 Sep 2017 23:27:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 19:27:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 19:27:06 -0400
Date:   Mon, 25 Sep 2017 19:27:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/7] add xread_in_full() helper
Message-ID: <20170925232706.ulrefbv623tinukf@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925203323.rmm3i5kx266ma3wu@sigill.intra.peff.net>
 <20170925221608.GF27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925221608.GF27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 03:16:08PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Many callers of read_in_full() expect to see exactly "len"
> > bytes, and die if that isn't the case.
> 
> micronit: Can this be named read_in_full_or_die?
> 
> Otherwise it's too easy to mistake for a function like xread, which
> has different semantics.
> 
> I realize that xmalloc, xmemdupz, etc use a different convention.
> That's yet another reason to be explicit, IMHO.

Yeah, we've definitely misused the "x" prefix for different things. I
agree that being explicit probably can't hurt.

I wonder if it's worth calling it "read_exactly_or_die()" to emphasize
that not reading enough bytes is a die-able offense.

-Peff
