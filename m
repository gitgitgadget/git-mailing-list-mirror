Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EDAC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 08:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C08A20E65
	for <git@archiver.kernel.org>; Wed, 27 May 2020 08:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgE0IAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 04:00:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:57162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbgE0IAK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 04:00:10 -0400
Received: (qmail 20583 invoked by uid 109); 27 May 2020 08:00:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 08:00:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1691 invoked by uid 111); 27 May 2020 08:00:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 04:00:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 04:00:09 -0400
From:   Jeff King <peff@peff.net>
To:     Merlin =?utf-8?B?QsO8Z2U=?= <toni@bluenox07.de>
Cc:     git@vger.kernel.org
Subject: Re: Question about behaviour of git-checkout --patch option
Message-ID: <20200527080009.GB4006373@coredump.intra.peff.net>
References: <20200525221100.31d36d4d.toni@bluenox07.de>
 <20200527075648.GA4006373@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527075648.GA4006373@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 03:56:48AM -0400, Jeff King wrote:

> which does do the right thing. But:
> 
>   - all of this is in the process of being rewritten in C, so it should
>     probably go into add-interactive.c (it's not yet the default to use
>     the C version, but it probably will be soon).

Trying your case with:

  git -c add.interactive.usebuiltin=true checkout -p master .

shows that it does not list the added file at all. I suspect the form of
the fix will be similar, but it may have to plumb through the file
addition from the diff layer, as well.

-Peff
