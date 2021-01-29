Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576D2C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 19:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F5664DED
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 19:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhA2Tdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 14:33:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:40730 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhA2Tdc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 14:33:32 -0500
Received: (qmail 3484 invoked by uid 109); 29 Jan 2021 19:32:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 19:32:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8293 invoked by uid 111); 29 Jan 2021 19:32:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jan 2021 14:32:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jan 2021 14:32:50 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 05/10] p5303: measure time to repack with keep
Message-ID: <YBRi4v/AeDD/Zc9X@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
 <xmqqft2ktnpj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft2ktnpj.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 07:40:40PM -0800, Junio C Hamano wrote:

> > diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
> > index 277d22ec4b..85b077b72b 100755
> > --- a/t/perf/p5303-many-packs.sh
> > +++ b/t/perf/p5303-many-packs.sh
> > @@ -27,8 +27,11 @@ repack_into_n () {
> 
> this construct:
> 
> 	... |
> 	sed -n '1~5p' |
> 	head -n "$1" |
>         ...
> 
> which is a GNUism.  Peff often says that very small population
> actually run our perf suite, and this seems to corroborate the
> conjecture.

Oops. Looks like I was the one who introduced that. Nobody seems to have
complained, so I'm somewhat tempted to leave it. But it would not be too
hard to replace with perl, I think.

-Peff
