Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5CD1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 05:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbcLEFdT (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 00:33:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:51535 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbcLEFdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 00:33:19 -0500
Received: (qmail 25489 invoked by uid 109); 5 Dec 2016 05:33:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 05:33:00 +0000
Received: (qmail 1826 invoked by uid 111); 5 Dec 2016 05:33:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 00:33:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 00:32:58 -0500
Date:   Mon, 5 Dec 2016 00:32:58 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
Message-ID: <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
References: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 04, 2016 at 08:45:59PM +0000, Ramsay Jones wrote:

> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Junio,
> 
> I recently noticed that:
> 
>     $ make >pout 2>&1
>     $ ./git version
>     git version 2.11.0.286.g109e8a9
>     $ git describe
>     v2.11.0-286-g109e8a99d
>     $
> 
> ... for non-release builds, the commit part of the version
> string was still using an --abbrev=7.

It seems like this kind of discussion ought to go in the commit message.
:)

That said, I think the right patch may be to just drop --abbrev
entirely. Its use goes all the way back to 9b88fcef7 (Makefile: use
git-describe to mark the git version., 2005-12-27), where it was
--abbrev=4. That became --abbrev=7 in bf505158d (Git 1.7.10.1,
2012-05-01) without further comment.

I think at that point it was a noop, as 7 should have been the default.
And now we probably ought to drop it, so that we can use the
auto-scaling default.

-Peff
