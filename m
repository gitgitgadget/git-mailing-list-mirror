Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10A320248
	for <e@80x24.org>; Tue, 26 Mar 2019 18:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfCZSSI (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 14:18:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:36978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731904AbfCZSSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 14:18:08 -0400
Received: (qmail 17758 invoked by uid 109); 26 Mar 2019 18:18:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 18:18:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22030 invoked by uid 111); 26 Mar 2019 18:18:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 14:18:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 14:18:06 -0400
Date:   Tue, 26 Mar 2019 14:18:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch-pack: respect --no-update-shallow in v2
Message-ID: <20190326181806.GA24105@sigill.intra.peff.net>
References: <20190326052011.GB1933@sigill.intra.peff.net>
 <20190326173706.175638-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326173706.175638-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 10:37:06AM -0700, Jonathan Tan wrote:

> > Perhaps it's worth passing down the shallows array we get from the
> > caller of fetch_pack(). Something like the patch below (I think it is
> > never NULL, which means in your patch 1 you can simplify the conditional
> > for the BUG).
> 
> [snip patch]
> 
> You're right that it is never NULL - I have removed that check. As for
> passing down the shallows array that we get from the caller of
> fetch_pack(), that would get confusing because we end up modifying the
> shallows array in some code paths, and the transport is sometimes reused
> (for example, when backfilling tags). I have instead made a
> shallows_scratch variable in fetch_pack(), and made it pass it down
> (like in the diff you provided).

Yeah, I confess to having spent quite a few minutes trying to figure out
the difference between "shallows" and "shallow_info", whether one
wrote into the other, and who was responsible for filling each in. So I
will not complain if you have a way of writing it that is less
confusing. :)

-Peff
