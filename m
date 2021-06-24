Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EED7C48BDF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 05:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B25160FF1
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 05:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFXFmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 01:42:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:59142 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhFXFmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 01:42:37 -0400
Received: (qmail 9943 invoked by uid 109); 24 Jun 2021 05:39:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 05:39:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10020 invoked by uid 111); 24 Jun 2021 05:40:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 01:40:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 01:40:18 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] progress.c tests: fix breakage with COLUMNS != 80
Message-ID: <YNQawgw0EzG86k8S@coredump.intra.peff.net>
References: <patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com>
 <YNPISWEBxISC30DW@coredump.intra.peff.net>
 <20210624051253.GG6312@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210624051253.GG6312@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 24, 2021 at 07:12:53AM +0200, SZEDER Gábor wrote:

> > I admit this a _bit_ of a nitpick (since as far as we know none of the
> > other scripts care about the terminal width), so I'm OK with this as-is
> > if you feel strongly the other way.
> 
> I remember one commit-graph test that does check the number of lines
> in the progress output, assuming one progress line per commit-graph
> layer, which breaks when we break the progress line in a too narrow
> terminal.  Running './t5324-split-commit-graph.sh -v -i' in a 46
> column wide terminal fails for me, but succeeds with 47 columns.
> 
> I do suggest setting COLUMNS=80 in 'test-lib.sh'.

Thanks for providing a concrete example. I agree we should just set it
for all scripts via test-lib.sh, then.

-Peff
