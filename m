Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA392C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E47611BD
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFHGpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:45:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:48632 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhFHGpB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:45:01 -0400
Received: (qmail 28175 invoked by uid 109); 8 Jun 2021 06:43:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 06:43:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7076 invoked by uid 111); 8 Jun 2021 06:43:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 02:43:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 02:43:08 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: [suggestion] support non-negative float number in git-repack
 --max-pack-size
Message-ID: <YL8RfGijMY95miHI@coredump.intra.peff.net>
References: <776cb2f9-5fef-4486-5aef-f3ee62fcda7e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <776cb2f9-5fef-4486-5aef-f3ee62fcda7e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 01:42:47PM +0700, Bagas Sanjaya wrote:

> I would like to create packfiles with charm-numbered size (that is for
> example use 49.99M instead of 50M) with git-repack:
> 
> $ git repack --max-pack-size=49.99M -a -d

The parser for numbers with units is shared by many options and config
variables. In general, I'm not really opposed to allowing floating point
values which get rounded to the nearest byte for any of them. So no
objection for the general feature if somebody wants to implement it.

But I would note that --max-pack-size is almost never a good idea in
general. I don't know what you think it's accomplishing, but it is
probably making your repository larger than it needs to be, as well as
less performant.

-Peff
