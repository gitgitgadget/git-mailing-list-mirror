Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5FC71F424
	for <e@80x24.org>; Wed, 20 Dec 2017 11:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754885AbdLTLlk (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 06:41:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:43926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754775AbdLTLlj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 06:41:39 -0500
Received: (qmail 4846 invoked by uid 109); 20 Dec 2017 11:41:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Dec 2017 11:41:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11908 invoked by uid 111); 20 Dec 2017 11:41:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 20 Dec 2017 06:41:59 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec 2017 06:41:31 -0500
Date:   Wed, 20 Dec 2017 06:41:31 -0500
From:   Jeff King <peff@peff.net>
To:     Wei Shuyu <wsy@dogben.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] http: support CURLPROXY_HTTPS
Message-ID: <20171220114131.GA16643@sigill.intra.peff.net>
References: <20171219172401.5263-1-wsy@dogben.com>
 <20171219205807.GC240141@aiede.mtv.corp.google.com>
 <a572179929e666e4e598930ec774c4db@dogben.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a572179929e666e4e598930ec774c4db@dogben.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 10:22:06AM +0800, Wei Shuyu wrote:

> On 2017-12-20 04:59, Jonathan Nieder wrote:
> 
> > Thanks for writing this.  Can you give an example of how I'd use it
> > (ideally in the form of a test in t/ so we avoid this functionality
> > regressing, but if that's not straightforward then an example for the
> > commit message is fine as well)?
> 
> Hi Jonathan,
> Its usage is the same as other protocols. Just set http.proxy or
> http_proxy/https_proxy
> environment to https://url.
> 
> To use apache server as a proxy, just add `ProxyRequests On` to an https
> site.

Unfortunately I don't think we have any proxy tests at all in our test
suite right now. The sticking point is that we need an actual proxy to
test against. :)

If it really is as simple as "ProxyRequests On", then we might be able
to convince the existing apache process we run to proxy requests to
itself (perhaps on a secondary port?).

-Peff
