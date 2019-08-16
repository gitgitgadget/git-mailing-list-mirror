Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3C81F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 20:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfHPUtI (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 16:49:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:46358 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727568AbfHPUtI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 16:49:08 -0400
Received: (qmail 22957 invoked by uid 109); 16 Aug 2019 20:49:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Aug 2019 20:49:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10397 invoked by uid 111); 16 Aug 2019 20:50:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Aug 2019 16:50:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Aug 2019 16:49:06 -0400
From:   Jeff King <peff@peff.net>
To:     16657101987@163.com
Cc:     git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
        sunchao9@huawei.com, worldhello.net@gmail.com
Subject: Re: [PATCH v2 0/1] pack-refs: always refreshing after take the lock
 file
Message-ID: <20190816204906.GA29853@sigill.intra.peff.net>
References: <20190730063634.GA4901@sigill.intra.peff.net>
 <20190731183544.24406-1-16657101987@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731183544.24406-1-16657101987@163.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 01, 2019 at 02:35:43AM +0800, 16657101987@163.com wrote:

> > So I actually think the best path forward is just always refreshing when
> > we take the lock, something like:
> > 
> > Ultimately the best solution there is to move to a better format (like
> > the reftables proposal).
> 
> I do not know if we could get the new reftables in the next few versions,
> So I commit the changes as you suggested, which is also the same as
> another way I metioned in `PATCH v1`:
> 
> **force `update-ref -d` to update the snapshot before rewrite packed-refs.**
> 
> But if the reftables is comeing soon, please just ignore my PATCH :)

I'm undecided on this. I think reftables are still a while off, and even
once they are here, many people will still be using the older format. So
it makes sense to still apply fixes to the old code.

What I wonder, though, is whether always refreshing will cause a
noticeable performance impact (and that's why I was so slow in
responding -- I had hoped to try to come up with some numbers, but I
just hadn't gotten around to it).

My gut says it's _probably_ not an issue, but it would be nice to have
some data to back it up.

> **And thank a lot for your reply, it's great to me, because it's my first
> PATCh to git myself :)**

You're welcome. Thanks for diagnosing a rather tricky case. :)

-Peff
