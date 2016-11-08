Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9552022A
	for <e@80x24.org>; Tue,  8 Nov 2016 20:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbcKHUFr (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:05:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:40289 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932219AbcKHUFq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:05:46 -0500
Received: (qmail 25304 invoked by uid 109); 8 Nov 2016 20:05:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 20:05:46 +0000
Received: (qmail 23431 invoked by uid 111); 8 Nov 2016 20:06:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 15:06:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2016 15:05:44 -0500
Date:   Tue, 8 Nov 2016 15:05:44 -0500
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH] t6026-merge-attr: don't fail if sleep exits early
Message-ID: <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net>
References: <mvmtwbhdhvb.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mvmtwbhdhvb.fsf@hawking.suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2016 at 06:03:04PM +0100, Andreas Schwab wrote:

> Commit 5babb5bdb3 ("t6026-merge-attr: clean up background process at end
> of test case") added a kill command to clean up after the test, but this
> can fail if the sleep command exits before the cleanup is executed.
> Ignore the error from the kill command.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
> The failure can be simulated by adding a sleep after the last command to
> delay the cleanup.

Thanks for the reproduction hint. I sometimes run the test suite through
a "stress" script that sees if a test script racily fails under load,
but I wasn't able to trigger it here (I guess a full second is just too
long even under high load). But the extra sleep makes it obvious.

Looks like the original is in v2.10.1, so this should probably go to
maint, as well as the upcoming v2.11-rc1.

-Peff
