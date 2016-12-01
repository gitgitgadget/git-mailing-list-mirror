Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331F41FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 21:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759218AbcLAV7n (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 16:59:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:50269 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757961AbcLAV7m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 16:59:42 -0500
Received: (qmail 20294 invoked by uid 109); 1 Dec 2016 21:59:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 21:59:36 +0000
Received: (qmail 4894 invoked by uid 111); 1 Dec 2016 22:00:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 17:00:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 16:59:34 -0500
Date:   Thu, 1 Dec 2016 16:59:34 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161201215934.g7dt5ioekmx6ssii@sigill.intra.peff.net>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1480555714-186183-2-git-send-email-bmwill@google.com>
 <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
 <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com>
 <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net>
 <20161201191603.GB54082@google.com>
 <20161201205444.GG54082@google.com>
 <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net>
 <CAGZ79kaqzssfN_bRQYpqC9HsKmyQZNCQcs+T5ke95Sf-C5PaRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaqzssfN_bRQYpqC9HsKmyQZNCQcs+T5ke95Sf-C5PaRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 01:56:32PM -0800, Stefan Beller wrote:

> > Bleh. Looks like it happens as part of the recently-added
> > get_common_dir(). I'm not sure if that is ever relevant for submodules,
> > but I guess in theory you could have a submodule clone that is part of a
> > worktree?
> 
> Sure we can, for a test that we don't have that, see the embedgitdirs series. ;)
> 
> For now each submodule has its own complete git dir, but the vision
> would be to have a common git dir for submodules in the common
> superprojects git dir as well, such that objects are shared actually. :)

Fair enough. Given that it seems to behave OK even in error cases, the
simple stat() test may be the best option, then. I do think we should
consider adding a few test cases to make sure it continues to behave in
the error cases (just because we are relying partially on what git's
setup code happens to do currently, and we'd want to protect ourselves
against regressions).

-Peff
