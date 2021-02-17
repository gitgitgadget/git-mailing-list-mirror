Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDD3C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 00:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3B964EAD
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 00:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhBQADh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 19:03:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:35234 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhBQADg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 19:03:36 -0500
Received: (qmail 15559 invoked by uid 109); 17 Feb 2021 00:02:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 00:02:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30964 invoked by uid 111); 17 Feb 2021 00:02:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 19:02:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 19:02:55 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 5/8] p5303: measure time to repack with keep
Message-ID: <YCxdL9Xi4nAcnqIg@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <b5081c01b53beb568ef2e59956d25b36be9f24d0.1612411124.git.me@ttaylorr.com>
 <YCxcGKo7kyLwVvw+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCxcGKo7kyLwVvw+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 06:58:16PM -0500, Jeff King wrote:

> For showing the impact of the optimizations in patches 7 and 8, I think
> doing a full repack with --honor-pack-keep is a better test. Because
> then we're always doing a full traversal, and most of the work continues
> to scale with the repo size (though obviously not the actual shuffling
> of packed bytes around). That would get rid of the weird "no work to do"
> case in the single-pack tests, too.

I meant to add: but I do like that we are timing --stdin-packs, too. We
may actually want to time both.

Another thing we _could_ do, if we have --honor-pack-keep perf tests, is
to shuffle patches 5, 6, and 7 towards the front of the series. They
should be able to show off the improvement even without the
--stdin-packs feature.

-Peff
