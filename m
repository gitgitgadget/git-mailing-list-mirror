Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D92C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhLJJRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:17:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:48550 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhLJJRx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:17:53 -0500
Received: (qmail 18015 invoked by uid 109); 10 Dec 2021 09:14:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 09:14:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28343 invoked by uid 111); 10 Dec 2021 09:14:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 04:14:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 04:14:17 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 06/19] t6300: make `%(raw:size) --shell` test more robust
Message-ID: <YbMaadyT+YmZeGlB@coredump.intra.peff.net>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-7-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211209051115.52629-7-sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 12:11:02AM -0500, Eric Sunshine wrote:

> This test populates its `expect` file solely by appending content but
> fails to ensure that the file starts out empty. The test succeeds only
> because no earlier test populated a file of the exact same name, however
> this is an accident waiting to happen. Make the test more robust by
> ensuring that it contains exactly the intended content.

Agreed.

> While at it, simplify the implementation via a straightforward `sed`
> application and by avoiding dropping out of the single-quote context
> within the test body (thus eliminating a hard-to-digest combination of
> apostrophes and backslashes).

I find them equally ugly. :) The most confusing thing is that we are not
doing any shell quoting at all, just adding single-quote wrappers. But
that is OK because %(raw:size) should never need quoting.

Your solution seems fine to me.

-Peff
