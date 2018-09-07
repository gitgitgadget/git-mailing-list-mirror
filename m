Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7B71F404
	for <e@80x24.org>; Fri,  7 Sep 2018 14:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeIGT3U (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 15:29:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:42686 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725944AbeIGT3T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 15:29:19 -0400
Received: (qmail 10958 invoked by uid 109); 7 Sep 2018 14:48:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Sep 2018 14:48:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14039 invoked by uid 111); 7 Sep 2018 14:48:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 07 Sep 2018 10:48:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Sep 2018 10:48:02 -0400
Date:   Fri, 7 Sep 2018 10:48:02 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>,
        gitster@pobox.com, pclouds@gmail.com
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
Message-ID: <20180907144802.GA26719@sigill.intra.peff.net>
References: <20180906191203.GA26184@sigill.intra.peff.net>
 <20180906192021.GB26575@sigill.intra.peff.net>
 <20180906235033.GA100309@aiede.svl.corp.google.com>
 <20180907032401.GB31728@sigill.intra.peff.net>
 <20180907063241.GA172953@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180907063241.GA172953@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 11:32:41PM -0700, Jonathan Nieder wrote:

> > I think Stefan pointed out a "case 4" in the other part of the thread:
> > ones where we really care not just about fast lookup, but actual
> > iteration order.
> 
> I had assumed that that was the whole point of this data structure.
> Anything else that is using it for lookups should indeed use a hash
> map instead, and I can take my share of blame for missing this kind of
> thing in review.

Keep in mind we didn't have a decent generic hashmap for many years. So
I think string-list got used in its place.

> > I think I like the hashmap way, if the conversion isn't too painful.
> 
> If we don't have any callers that actually need the sort-and-lookup
> thing, then yay, let's get rid of it.  But I don't actually think of
> this as the hashmap way.  It's the get-rid-of-the-unneeded-feature
> way.
> 
> In other words, *regardless* of what else we should do, we should
> update any callers that want a hashmap to use a hashmap.  Please go
> ahead, even if it doesn't let us simplify the string list API at all.

Great, I think we're on the same page. Thanks!

-Peff
