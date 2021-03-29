Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF57C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 11:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE9D6193A
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 11:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhC2LXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 07:23:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:35366 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232440AbhC2LXA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 07:23:00 -0400
Received: (qmail 10322 invoked by uid 109); 29 Mar 2021 11:23:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 11:23:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12748 invoked by uid 111); 29 Mar 2021 11:22:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 07:22:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 07:22:59 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 02/16] builtin/multi-pack-index.c: don't handle
 'progress' separately
Message-ID: <YGG4k5XUKj073qS5@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <181f11e4c55b364dc7f6a6530f397779171671a9.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <181f11e4c55b364dc7f6a6530f397779171671a9.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:04:40PM -0500, Taylor Blau wrote:

> Now that there is a shared 'flags' member in the options structure,
> there is no need to keep track of whether to force progress or not,
> since ultimately the decision of whether or not to show a progress meter
> is controlled by a bit in the flags member.

Just going back to what I wrote for patch 1, I think this "now that
there is a shared flags..." bit is what misled me.

You can easily have done this patch by just manipulating the local
"flags" variable. And the rationale for the patch is "we can get rid of
opts.progress, because nobody ever reads it except to set a bit
opts.flags".

Definitely not worth re-rolling or anything; I'm just explaining my
earlier comments. :)

-Peff
