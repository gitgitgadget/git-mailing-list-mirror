Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ACAC2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 07:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A26C206CB
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 07:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLVH6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 02:58:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:52152 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725829AbfLVH6i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 02:58:38 -0500
Received: (qmail 11783 invoked by uid 109); 22 Dec 2019 07:58:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Dec 2019 07:58:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23984 invoked by uid 111); 22 Dec 2019 08:03:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Dec 2019 03:03:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Dec 2019 02:58:36 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tom Miller <jackerran@gmail.com>, git@vger.kernel.org
Subject: Re: Propose promoting 'contrib/rerere-train.sh' to command
Message-ID: <20191222075836.GA3425263@coredump.intra.peff.net>
References: <BZAQIE4YND2I.Z7BFCW7BLH3K@penguin>
 <20191221193110.GB3339249@coredump.intra.peff.net>
 <xmqqeewx6xt6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeewx6xt6.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 21, 2019 at 03:52:53PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The situations where I need rerere-train don't come up often, but when
> > they do, it has always worked easily and without hiccups for me. So
> > perhaps there are lurking gotchas that Junio might know about, but AFAIK
> > the quality is high enough for it to be part of normal Git.
> 
> I actually suspect that rewriting has a high chance of initially
> degrading the quality, so we should take a two step approach if we
> really want it as part of the core distribution.  As to the UI, I
> think "git rerere train a..b" would be a good one, but if the
> scripted version is of high quality (I haven't looked at it for a
> long time---even though I used it for a couple of times a year in
> recent years), perhaps we can add it as "git-rerere--train"
> subcommand that is spawned from "builtin/rerere.c" for the first
> cut?

Yeah, I'd be pretty happy with that, too.

I just suspect its ultimate fate is conversion to C, given the general
trend. And converting it to C that just calls out to other git commands
via run_command would presumably behave just like the original, leaving
the more challenging and error-prone conversion for later. Hopefully any
upgrade to "real Git command" would include some tests, though. :)

-Peff
