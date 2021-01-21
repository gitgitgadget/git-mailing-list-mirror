Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B5EC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 20:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B059923A56
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 20:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbhAUUOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:14:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:34454 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbhAUUOu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 15:14:50 -0500
Received: (qmail 6287 invoked by uid 109); 21 Jan 2021 20:14:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Jan 2021 20:14:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5579 invoked by uid 111); 21 Jan 2021 20:14:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Jan 2021 15:14:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Jan 2021 15:14:05 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Cloning with remote unborn HEAD
Message-ID: <YAngjWaKvEukZB0p@coredump.intra.peff.net>
References: <20201211210508.2337494-1-jonathantanmy@google.com>
 <cover.1608587839.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1608587839.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 21, 2020 at 02:30:58PM -0800, Jonathan Tan wrote:

> > So I dunno. My biggest complaint is that the config option defaults to
> > _off_.  So it's helping load-balanced rollouts, but creating complexity
> > for everyone else who might want to enable the feature.
> 
>    So it seems like you're saying that it should default to "on", but at
>    the same time you are talking about enabling the feature (which seems
>    to imply switching it from "off" to "on"). (Also, note that this is a
>    server-side thing; on the client-side, Git will always use what the
>    server gives and there is no option to control this.)

Sorry, I missed this question over the holidays. Yes, what I meant is
that everyone should really want this feature on, because it gives
strictly more information and lets the client be smarter.

But if it defaults to "off", server operators may well not bother to
turn it on (or even know it exists). And the clients who would benefit
may have trouble convincing server operators to do so.

So I would strongly prefer it default to "on", and the onus be on server
operators with non-atomic clusters, etc, to turn it off when deploying
in their environments.

-Peff
