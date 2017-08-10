Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C0520899
	for <e@80x24.org>; Thu, 10 Aug 2017 08:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbdHJICu (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 04:02:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:34184 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750909AbdHJICs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 04:02:48 -0400
Received: (qmail 27014 invoked by uid 109); 10 Aug 2017 08:02:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 08:02:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2402 invoked by uid 111); 10 Aug 2017 08:03:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 04:03:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 04:02:46 -0400
Date:   Thu, 10 Aug 2017 04:02:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] make interpret-trailers useful for parsing
Message-ID: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 08:21:47AM -0400, Jeff King wrote:

> This series teaches interpret-trailers to parse and output just the
> trailers. So now you can do:
> 
>   $ git log --format=%B -1 8d44797cc91231cd44955279040dc4a1ee0a797f |
>     git interpret-trailers --parse
>   Signed-off-by: Hartmut Henkel <henkel@vh-s.de>
>   Helped-by: Stefan Beller <sbeller@google.com>
>   Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>   Acked-by: Matthias Rüster <matthias.ruester@gmail.com>

And here's a v2 that addresses all of the comments except one: Stefan
suggested that --only-existing wasn't a great name. I agree, but I like
everything else less.

Summary:

  - opts arguments are now const
  - tests that depend on the value of trailer.sign.command now set it
    explicitly
  - the arg_head variable is now moved into the conditional block whewre
    it's used
  - the interpret-trailers manpage has been updated in patch 5 to make
    it clear that "add" and "parse" are the two major modes

  [1/5]: trailer: put process_trailers() options into a struct
  [2/5]: interpret-trailers: add an option to show only the trailers
  [3/5]: interpret-trailers: add an option to show only existing trailers
  [4/5]: interpret-trailers: add an option to normalize output
  [5/5]: interpret-trailers: add --parse convenience option

 Documentation/git-interpret-trailers.txt | 34 +++++++++++---
 builtin/interpret-trailers.c             | 34 +++++++++++---
 t/t7513-interpret-trailers.sh            | 76 ++++++++++++++++++++++++++++++++
 trailer.c                                | 68 ++++++++++++++++++++++------
 trailer.h                                | 13 +++++-
 5 files changed, 196 insertions(+), 29 deletions(-)

-Peff
