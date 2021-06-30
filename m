Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22CC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFD761449
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhF3SCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 14:02:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:37632 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhF3SCO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 14:02:14 -0400
Received: (qmail 24720 invoked by uid 109); 30 Jun 2021 17:59:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 17:59:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9333 invoked by uid 111); 30 Jun 2021 17:59:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Jun 2021 13:59:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Jun 2021 13:59:43 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Structured (ie: json) output for query commands?
Message-ID: <YNyxD4qAHmbluNRe@coredump.intra.peff.net>
References: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
 <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 01:00:24PM -0400, Martin Langhoff wrote:

> I'm used to automating git by parsing stuff in Unix shell style. But
> the golden days that gave us Perl are well behind us.
> 
> Before I write (unreliable, leaky, likely buggy) text parsing bits one
> more time, has git grown formatted output? I'm aware of fmt and
> friends, I'm thinking of something that handles escaping, nested data
> structures, etc.
> 
> Something like "git shortlog --json".
> 
> Have there been discussions? Patches? (I don't spot anything in what's cooking).

It's been discussed off-and-on over the years, but I don't think
anybody's actively working on it.

The trace2 facility has some json output. That's probably not helpful
for what you're doing, but it does mean we have basic json output
routines available.

One complication we faced is that a lot of Git's data is bag-of-bytes,
not utf8. And json technically requires utf8. I don't remember if we
simply fudged that and output possibly non-utf8 sequences, or if we
actually encode them.

-Peff
