Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6F7C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 16:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6052460EBB
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 16:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhG2QX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:23:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:60944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhG2QX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 12:23:29 -0400
Received: (qmail 8889 invoked by uid 109); 29 Jul 2021 16:23:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jul 2021 16:23:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22242 invoked by uid 111); 29 Jul 2021 16:23:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jul 2021 12:23:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Jul 2021 12:23:24 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/7] Final optimization batch (#15): use memory pools
Message-ID: <YQLV/MTQ+MkxUBSn@coredump.intra.peff.net>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
 <YQLVPN9n5E1Yvi/q@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQLVPN9n5E1Yvi/q@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 12:20:13PM -0400, Jeff King wrote:

> I assume your tests are just done using the regular glibc allocator. I
> also wondered how plugging in a better allocator might fare. Here are
> timings I did of your mega-renames case with three binaries: one built
> with USE_MEMORY_POOL set to 0, one with it set to 1, and one with it set
> to 0 but adding "-ltcmalloc" to EXTLIBS via config.mak.

Oh, btw, I wasn't able to apply your series from the list on top of
en/ort-perf-batch-14 (there are some problems in patch 4, and "am -3"
says my clone of git.git is missing some of the pre-image sha1s). I
fetched ort-perf-batch-15 from https://github.com/newren/git and timed
that, which I imagine is the same. But you may need to tweak the patches
so that Junio can pick them up.

-Peff
