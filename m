Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EDDC2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C104920774
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgDXFZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:25:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:38384 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725769AbgDXFZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 01:25:09 -0400
Received: (qmail 19829 invoked by uid 109); 24 Apr 2020 05:25:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Apr 2020 05:25:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19916 invoked by uid 111); 24 Apr 2020 05:36:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Apr 2020 01:36:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Apr 2020 01:25:08 -0400
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] minor fixups for gs/commit-graph-path-filter
Message-ID: <20200424052508.GC1648190@coredump.intra.peff.net>
References: <20200423205851.GA1633985@coredump.intra.peff.net>
 <20200424010047.GD1949@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200424010047.GD1949@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 08:00:47AM +0700, Danh Doan wrote:

> On 2020-04-23 16:58:51-0400, Jeff King <peff@peff.net> wrote:
> > These are just a few bits I noticed in the test-tool helper when the
> > topic hit next (my -Wunused-parameter patch complained that we never
> > looked at argc).
> 
> I think I'll add this one to those few bits.

Yeah, they all look sensible (I should have looked for more "No newline"
cases.

> I've take another look into bloom.h.
> 
> I think we should drop BITS_PER_WORD definition and use CHAR_BIT
> instead. It's a standard definition.
> 
> To me, a WORD is an `int`, at least I was told that when I was still
> in university and study about computer science.

Yes, I agree it would be more clear as just CHAR_BIT if we are using
single-char words. But I suspect the code could be looking at the bit
patterns using larger word sizes (e.g., all of the ewah code uses 64-bit
words). That might be worth exploring.

-Peff
