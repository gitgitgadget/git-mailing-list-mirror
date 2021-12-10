Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69419C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhLJJOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:14:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:48542 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234276AbhLJJOR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:14:17 -0500
Received: (qmail 17996 invoked by uid 109); 10 Dec 2021 09:10:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 09:10:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28315 invoked by uid 111); 10 Dec 2021 09:10:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 04:10:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 04:10:41 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 05/19] t5516: drop unnecessary subshell and command
 invocation
Message-ID: <YbMZkdaEt6Q+MtR5@coredump.intra.peff.net>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-6-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211209051115.52629-6-sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 12:11:01AM -0500, Eric Sunshine wrote:

> To create its "expect" file, this test pipes into `sort` the output of
> `git for-each-ref` and a copy of that same output but with a minor
> textual transformation applied. To do so, it employs a subshell and
> commands `cat` and `sed` even though the same result can be accomplished
> by `sed` alone (without a subshell).

Clever. The ordering of output from sed is different than the original,
but because it all gets fed into sort anyway, that's OK.

In theory it could change the output of a stable sort of lines which
match (which won't be totally identical, because you are sorting with
-k3), but it seems we don't care in this instance.

-Peff
