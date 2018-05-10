Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23BE51F424
	for <e@80x24.org>; Thu, 10 May 2018 05:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756567AbeEJFVk (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 01:21:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:34344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756407AbeEJFVk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 01:21:40 -0400
Received: (qmail 18333 invoked by uid 109); 10 May 2018 05:21:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 05:21:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20734 invoked by uid 111); 10 May 2018 05:21:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 01:21:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 01:21:37 -0400
Date:   Thu, 10 May 2018 01:21:37 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/5] getting rid of most "static struct lock_file"s
Message-ID: <20180510052137.GC27259@sigill.intra.peff.net>
References: <20180508182548.GD7210@sigill.intra.peff.net>
 <cover.1525898125.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1525898125.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 09, 2018 at 10:55:34PM +0200, Martin Ågren wrote:

> This is take two of my attempt at making almost all `struct lock_file`s
> non-static. All patches have been equipped with more detailed commit
> messages. The only diff that has changed is patch 3/5, where I now take
> a small step towards gentle error-handling, rather than going in the
> opposite direction.
> 
> Thanks all for the valuable feedback on v1. I could have saved everyone
> some trouble by writing better commit messages from the start, and
> probably also by using `--thread` when formatting the patches...

Indeed, the world would be a more efficient place if we all did
everything perfectly all the time. Sadly, that's not how it works. :)

This version looks good to me. Thanks for modernizing things.

I don't think it's worth re-rolling, but one thing to think about for
future cleanups: you split the patches by touched area, not by
functionality. So the first three patches have a "while we're here..."
that has to explain why dropping the "static" is the right thing over
and over. If you instead did the error-handling fixes independently
first, then you could lump the "static" cleanups together with one
explanation (possibly even just as part of the 4th patch).

-Peff
