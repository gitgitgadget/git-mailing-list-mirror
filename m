Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E8FC433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A59164DF1
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhA2BTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:19:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:42856 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhA2BTh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:19:37 -0500
Received: (qmail 20918 invoked by uid 109); 29 Jan 2021 01:18:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 01:18:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4742 invoked by uid 111); 29 Jan 2021 01:18:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 20:18:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 20:18:55 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] hash_pos(): convert to oid_pos()
Message-ID: <YBNifzRKYOjaZ4eV@coredump.intra.peff.net>
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
 <YBJXfl86Juv5kn16@coredump.intra.peff.net>
 <YBM/NpLeS0uFzVb3@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBM/NpLeS0uFzVb3@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 05:48:22PM -0500, Taylor Blau wrote:

> >  builtin/name-rev.c  |  8 ++++----
> >  commit-graph.c      | 28 ++++++++++++++--------------
> >  commit.c            | 10 +++++-----
> >  hash-lookup.c       | 18 +++++++++---------
> >  hash-lookup.h       | 10 +++++-----
> 
> I wondered briefly if we should rename this to oid-lookup.{c,h}, but I
> think the answer is "no", since we still have bsearch_hash() in this
> header.
> 
> Probably a single header with "hash" in the name is better than two
> headers each containing a single function (and one containing an
> additional typedef).
> 
> So, I think that what you did here is good.

Yeah. I'd be more inclined to do so if renames weren't still a minor
pain when following history, etc. Getting rid of "sha1" crosses my bar
of worth doing. The distinction between "hash" and "oid" here doesn't.
(plus as you note, we'd really have to split it, which is even more
annoying).

-Peff
