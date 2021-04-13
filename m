Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F29C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450AB6109F
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbhDMHps (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:45:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:50868 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238194AbhDMHpn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:45:43 -0400
Received: (qmail 28723 invoked by uid 109); 13 Apr 2021 07:45:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 07:45:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23355 invoked by uid 111); 13 Apr 2021 07:45:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 03:45:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 03:45:21 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
Message-ID: <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1618234575.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 03:37:14PM +0200, Patrick Steinhardt wrote:

> this is the fourth version of my patch series which implements a new
> `object:type` filter for git-rev-list(1) and git-upload-pack(1) and
> extends support for bitmap indices to work with combined filters.
> 
> Changes compared to v3:
> 
>     - Small style fix to not pass an empty string and `0`, but instead
>       simply pass two `NULL` pointers to
>       `list_objects_filter__filter_object, pointed out by Junio.
> 
>     - I've changed patch 7/8 as proposed by Peff: support of combined
>       filters is now determined directly in `filter_bitmap()`, without
>       having to mirror all filter types in the new `filter_supported()`
>       function.
> 
>     - Renamed `--filter-provided-revisions` to
>       `--filter-provided-objects` as proposed by Peff and addressed both
>       commit message and tests as pointed out by Philip.

Thanks. I have no more nits to pick. The only question left for me is
the big one of "do we like this with --filter, or should it be some kind
of rev-list option", as discussed in:

  https://lore.kernel.org/git/YHB7R8hVRt+V+i2W@coredump.intra.peff.net/

As I said elsewhere, I'm OK going with this route. I just wanted to call
attention to that earlier response in case you had any final thoughts
(I'm guessing your final thoughts are "jeez, I already wrote it with
--filter, so let's just go with that" which is perfectly reasonable to
me. ;) ).

-Peff
