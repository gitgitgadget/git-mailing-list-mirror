Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609871FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760389AbcLAU7s (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:59:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:50218 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760360AbcLAU7r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:59:47 -0500
Received: (qmail 16739 invoked by uid 109); 1 Dec 2016 20:59:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 20:59:47 +0000
Received: (qmail 4246 invoked by uid 111); 1 Dec 2016 21:00:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 16:00:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 15:59:45 -0500
Date:   Thu, 1 Dec 2016 15:59:45 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1480555714-186183-2-git-send-email-bmwill@google.com>
 <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
 <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com>
 <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net>
 <20161201191603.GB54082@google.com>
 <20161201205444.GG54082@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201205444.GG54082@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 12:54:44PM -0800, Brandon Williams wrote:

> > I think this more robust check is probably a good idea, that way we
> > don't step into a submodule with a .git directory that isn't really a
> > .git dir.
> 
> Looks like this is a no-go as well...the call to is_git_directory() ends
> up calling real_path...which ends up performing the chdir call, which
> puts us right back to where we started!  (as a side note I was using
> is_git_directory else where...which I now know I can't use)

Bleh. Looks like it happens as part of the recently-added
get_common_dir(). I'm not sure if that is ever relevant for submodules,
but I guess in theory you could have a submodule clone that is part of a
worktree?

-Peff
