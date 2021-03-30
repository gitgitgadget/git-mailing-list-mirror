Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2AAC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC51161994
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhC3HQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:16:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:36768 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhC3HP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 03:15:59 -0400
Received: (qmail 18132 invoked by uid 109); 30 Mar 2021 07:15:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Mar 2021 07:15:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22064 invoked by uid 111); 30 Mar 2021 07:15:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Mar 2021 03:15:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Mar 2021 03:15:58 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 16/16] midx.c: improve cache locality in
 midx_pack_order_cmp()
Message-ID: <YGLQLlllszQeV7zs@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <550e785f10ba14f166958501c007b75a04052a0d.1615482270.git.me@ttaylorr.com>
 <YGHPINrwIZ1mKK+y@coredump.intra.peff.net>
 <YGJH3fzQXL6TvPK2@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGJH3fzQXL6TvPK2@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 05:34:21PM -0400, Taylor Blau wrote:

> > Did we record any numbers to show the improvement here? I don't think it
> > can be demonstrated with this series (since most of the code is dead),
> > but I recall that this was motivated by a noticeable slowdown.
> 
> Looking through our messages, you wrote that this seemed to produce a
> .8 second speed-up on a large-ish repository that we were testing.
> That's not significant overall, the fact that we were spending so long
> probably caught our attention when looking at a profiler.

That sounds about right from my recollection.

> I could go either way on mentioning it. It does feel a little like
> cheating to say, "well, if you applied these other patches it would make
> it about this much faster". So I'm mostly happy to just keep it vague
> and say that it makes things a little faster, unless you feel strongly
> otherwise.

No, I don't feel strongly. I just wanted to give people reading a sense
of what to expect. Now we have.

-Peff
