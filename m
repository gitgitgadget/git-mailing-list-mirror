Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B8C1F488
	for <e@80x24.org>; Tue,  7 May 2019 07:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfEGHgK (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 03:36:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:49882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726085AbfEGHgK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 03:36:10 -0400
Received: (qmail 18491 invoked by uid 109); 7 May 2019 07:36:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 07:36:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8995 invoked by uid 111); 7 May 2019 07:36:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 03:36:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 03:36:08 -0400
Date:   Tue, 7 May 2019 03:36:08 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: GIT/SSH_ASKPASS used for username input in https:// URLs
Message-ID: <20190507073608.GE28060@sigill.intra.peff.net>
References: <20190506134718.GA12803@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190506134718.GA12803@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 06, 2019 at 03:47:18PM +0200, Andreas Krey wrote:

> there is an interesting wart around prompt.c -
> PROMPT_ECHO isn't used in invoking an external helper program.
> 
> Thus, if I clone something on https (which requires auth for that),
> and have SSH_ASKPASS set, I will get two GUI *password* prompts,
> even though the first one will indicate in the title that it *is*
> asking for the username.
> 
> But basically, given the trivial protocol of SSH_ASKPASS, there
> doesn't seem to be any way to properly fix this without support
> from any desktop environment that sets SSH_ASKPASS. :-(

Yep. If you haven't seen it, there's more discussion in this recent
thread:

  https://public-inbox.org/git/20190429234028.GA24069@sigill.intra.peff.net/

> The best I can currently tell my users is to use the
>    [credentials "https:/..."]
> configuration to fix the username.

Yes, that works. Or a credential helper could prompt with a better
interface (but AFAIK, the only one written that does so is the Windows
one).

> But if we can't fix this, maybe we can at least point this out in the
> docs?

Sounds like a good suggestion. Where would you look for it? In the
description of GIT_ASKPASS / core.askpass?

-Peff
