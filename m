Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80628C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369CF23441
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392616AbhATT5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:57:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:33342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387705AbhATT5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:57:10 -0500
Received: (qmail 28844 invoked by uid 109); 20 Jan 2021 19:56:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Jan 2021 19:56:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25626 invoked by uid 111); 20 Jan 2021 19:56:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Jan 2021 14:56:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Jan 2021 14:56:17 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@gitlab.com
Subject: Re: [PATCH v2 1/3] refs: expose 'for_each_fullref_in_prefixes'
Message-ID: <YAiK4U1KnjPtWFN6@coredump.intra.peff.net>
References: <cover.1611080326.git.me@ttaylorr.com>
 <cover.1611158549.git.me@ttaylorr.com>
 <bda314fe7ae1629ba068a0c4ada9b6adc20576eb.1611158549.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bda314fe7ae1629ba068a0c4ada9b6adc20576eb.1611158549.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 11:04:21AM -0500, Taylor Blau wrote:

> This function was used in the ref-filter.c code to find the longest
> common prefix of among a set of refspecs, and then to iterate all of the
> references that descend from that prefix.
> 
> A future patch will want to use that same code from ls-refs.c, so
> prepare by exposing and moving it to refs.c. Since there is nothing
> specific to the ref-filter code here (other than that it was previously
> the only caller of this function), this really belongs in the more
> generic refs.h header.
> 
> The code moved in this patch is identical before and after, with the one
> exception of renaming some arguments to be consistent with other
> functions exposed in refs.h.

The other non-identical thing is that it handles a namespace parameter
(which is good, but an obvious non-movement).

-Peff
