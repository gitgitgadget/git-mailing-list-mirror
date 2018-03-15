Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFD01F404
	for <e@80x24.org>; Thu, 15 Mar 2018 00:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeCOAu3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 20:50:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:57460 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751537AbeCOAu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 20:50:26 -0400
Received: (qmail 16324 invoked by uid 109); 15 Mar 2018 00:50:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Mar 2018 00:50:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11025 invoked by uid 111); 15 Mar 2018 00:51:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Mar 2018 20:51:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Mar 2018 20:50:24 -0400
Date:   Wed, 14 Mar 2018 20:50:24 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] http: fix an unused variable warning for 'curl_no_proxy'
Message-ID: <20180315005023.GA22967@sigill.intra.peff.net>
References: <517c4210-c381-899e-b13a-00f8e4caba74@ramsayjones.plus.com>
 <20180314221544.GA20167@sigill.intra.peff.net>
 <d290f115-20b8-2c47-79a1-0fc92e046a94@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d290f115-20b8-2c47-79a1-0fc92e046a94@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 14, 2018 at 11:01:01PM +0000, Ramsay Jones wrote:

> >> The version of libcurl installed was 0x070f04. So, while it was fresh in my
> >> mind, I applied and tested this patch.
> > 
> > Makes sense. This #if would go away under my "do not support antique
> > curl versions" proposal. I haven't really pushed that forward since Tom
> > Christensen's patches to actually make the thing build (and presumably
> > since he is building on antique versions he can't turn on -Werror
> > anyway, since IIRC it tends to have some false positives).
> 
> Yes, I suspected this would be removed by your proposed update (hence
> the cc:), but I didn't know what the ETA on your patches was. Is this
> worth doing, or are you about to re-visit that series?

I wasn't about to revisit it. I wasn't sure if we actually wanted to
proceed or not, since Git _does_ actually build now with the old
versions (and there was some minor grumbling about dropping
compatibility).

> > I'm not sure whether our ordering of these variables actually means
> > much, but arguably it makes sense to keep the proxy-related variables
> > near each other, even if one of them has to be surrounded by an #if.
> > 
> > I guess you were going for ordering the #if's in increasing version
> > order. I'm not sure the existing code follows that pattern very well.
> 
> Yes, that was the idea, but I was already in two minds about that!
> In the end I went with this, because not all of the proxy variables
> are together anyway. ;-) (see, for example, 'proxy_auth' and 
> 'curl_proxyuserpwd' around line #113).
> 
> So, I don't mind placing the #ifdef around the current definition
> (rather than moving it up), if you would prefer that. (It will have
> to be tomorrow, since I have put that laptop away now!).

I'm OK with it either way, then. Thanks.

-Peff
