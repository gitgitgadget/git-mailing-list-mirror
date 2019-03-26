Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B173202BB
	for <e@80x24.org>; Tue, 26 Mar 2019 18:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbfCZSUu (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 14:20:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:36986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732064AbfCZSUu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 14:20:50 -0400
Received: (qmail 17833 invoked by uid 109); 26 Mar 2019 18:20:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 18:20:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22054 invoked by uid 111); 26 Mar 2019 18:21:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 14:21:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 14:20:48 -0400
Date:   Tue, 26 Mar 2019 14:20:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2 0/2] Last big GIT_TEST_PROTOCOL_VERSION=2 fix,
 hopefully
Message-ID: <20190326182047.GB24105@sigill.intra.peff.net>
References: <cover.1553546216.git.jonathantanmy@google.com>
 <cover.1553622678.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1553622678.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 10:53:24AM -0700, Jonathan Tan wrote:

> Updated to remove the unnecessary NULL check and memory leak that Peff
> noticed [1].
> 
> (Only commit 2/2 is changed, so the range-diff only shows 1 commit.)

But isn't this line:

>     + 	if (version == protocol_v2) {
>     +-		if (shallow && shallow->nr)
>     ++		if (shallow->nr)
>       			BUG("Protocol V2 does not provide shallows at this point in the fetch");

added by patch 1? It's added with "shallow &&" in patch 1, and then
modified in patch 2.

I think the "it's never NULL" property is true even before this series,
right?

-Peff
