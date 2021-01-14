Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA0C43381
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED51B23A56
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbhANTTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 14:19:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:56298 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbhANTTt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 14:19:49 -0500
Received: (qmail 16803 invoked by uid 109); 14 Jan 2021 19:19:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Jan 2021 19:19:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17040 invoked by uid 111); 14 Jan 2021 19:19:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Jan 2021 14:19:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Jan 2021 14:19:08 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 01/20] pack-revindex: introduce a new API
Message-ID: <YACZLHm4NtrM3POZ@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <e1aa89244ad3edb52aaeb28d6934cb2b0a0dc65a.1610576604.git.me@ttaylorr.com>
 <xmqq1reoypzy.fsf@gitster.c.googlers.com>
 <YAB6DNk4wPBVbGtU@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAB6DNk4wPBVbGtU@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 12:06:20PM -0500, Taylor Blau wrote:

> > > + * This function runs in time O(log N) with the number of objects in the pack.
> >
> > Is it a good idea to commit to such performance characteristics as a
> > promise to callers like this (the comment applies to all three
> > functions)?
> >
> > It depends on how a developer is helped by this comment when
> > deciding whether to use this function, or find other ways, to
> > implement what s/he wants to do.
> 
> I don't mind it. If they all had the same performance characteristics, I
> wouldn't be for it, but since they don't, I think that it's good to
> know. Peff suggested this back in [1].

Yeah, I asked for this. As somebody who has frequently worked on the
code which accesses the revindex (mostly bitmap stuff), I found it
useful to understand how expensive the operations were.  However, I also
know what their runtimes are at this point, and it is not like somebody
interested cannot look at the implementation. So it may not be that
important.

So I do still think it is useful, but if somebody feels strongly against
it, I don't mind it being removed.

-Peff
