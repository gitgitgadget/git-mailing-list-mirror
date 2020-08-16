Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50C7C433E1
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 08:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998602067C
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 08:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgHPIna (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 04:43:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:60410 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgHPIn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 04:43:29 -0400
Received: (qmail 24144 invoked by uid 109); 16 Aug 2020 08:43:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 16 Aug 2020 08:43:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6688 invoked by uid 111); 16 Aug 2020 08:43:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 16 Aug 2020 04:43:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 16 Aug 2020 04:43:28 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] dir: fix leak of parent_hashmap and recursive_hashmap
Message-ID: <20200816084328.GA1221900@coredump.intra.peff.net>
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
 <932741d7598ca2934dbca40f715ba2d3819fcc51.1597561152.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <932741d7598ca2934dbca40f715ba2d3819fcc51.1597561152.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 16, 2020 at 06:59:09AM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> Commit 96cc8ab531 ("sparse-checkout: use hashmaps for cone patterns",
> 2019-11-21) added a parent_hashmap and recursive_hashmap to each struct
> pattern_list and initialized these in add_patterns_from_buffer() but did
> not make sure to add necessary code to clear_pattern_list() to free
> these new structures.  Call hashmap_free_() on each to plug this memory
> leak.

Beat you to it. :)

See: https://lore.kernel.org/git/20200814111049.GA4101811@coredump.intra.peff.net/

-Peff
