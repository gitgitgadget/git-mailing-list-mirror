Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1636BC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC9861928
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC3HPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:15:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:36748 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhC3HPD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 03:15:03 -0400
Received: (qmail 18103 invoked by uid 109); 30 Mar 2021 07:15:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Mar 2021 07:15:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22040 invoked by uid 111); 30 Mar 2021 07:15:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Mar 2021 03:15:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Mar 2021 03:15:02 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 00/16] midx: implement a multi-pack reverse index
Message-ID: <YGLP9oE4HtgLudg4@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <YGHQnQ9/ulXd+jgu@coredump.intra.peff.net>
 <YGJIfdyghSUrq/0I@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGJIfdyghSUrq/0I@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 05:37:01PM -0400, Taylor Blau wrote:

> > The biggest question is what we want to happen next. As you note, the
> > concept of a midx .rev file is useless until we have the matching
> > .bitmap file. So we _could_ let this sit in next while the dependent
> > bitmap topic is reviewed, and then merge them down together. But I'm
> > inclined to treat this as an independent topic that can get merged to
> > master on its own, since the early cleanups are valuable on their own,
> > and the .rev parts at the end, even if dead, won't hurt anything.
> 
> That matches what I was hoping for. I think the clean-ups are worth it
> on their own, but I also think it's a good idea to take the whole
> series, since it means there's one less long-running branch in flight
> while we review the MIDX bitmaps topic.
> 
> (FWIW, I can also see an argument in the other direction along the lines
> of "we may discover something later on that requires us to change the
> way multi-pack .rev files work". I think that such an outcome is fairly
> unlikely, but worth considering anyway).

That would be my general worry, too, but in this case I am not too
concerned because I know the code has received substantial exercise
already on real-world production servers. So while we may clean up some
cosmetic bits or respond to review as it goes upstream, I'm much less
worried about seeing some brown-paper-bag bug that would be sufficient
to make us want to re-roll these .rev commits. And hopefully the
existing rounds have addressed the cosmetic/review bits.

-Peff
