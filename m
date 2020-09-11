Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394D7C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAF2208E4
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgIKTre (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:47:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:55012 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgIKTrc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 15:47:32 -0400
Received: (qmail 3508 invoked by uid 109); 11 Sep 2020 19:47:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2020 19:47:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7128 invoked by uid 111); 11 Sep 2020 19:47:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2020 15:47:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Sep 2020 15:47:30 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200911194730.GA2697651@coredump.intra.peff.net>
References: <cover.1599664389.git.me@ttaylorr.com>
 <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
 <20200911175216.GA2693949@coredump.intra.peff.net>
 <20200911185934.GA2871@xor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911185934.GA2871@xor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 02:59:34PM -0400, Taylor Blau wrote:

> I think that we have to treat "-1" as the no-limit indicator, or
> otherwise we'd have to specify some other way to say we don't want to
> generate any filters. With this patch, users can write:
> 
>   $ git commit-graph write --changed-paths .. --max-new-filters=0
> 
> to generate a commit-graph without writing any new filters. This is
> important to be able to do since we also have a
> 'commitGraph.maxNewFilters' configuration, which callers may want to
> override.

OK, that makes sense. Consistency would be nice, but I agree it just
wouldn't work here (and we're not entirely consistent anyway, so it's
not that big a loss).

-Peff
