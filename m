Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942ACC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB6E2073B
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404492AbgE1Pnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 11:43:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:58800 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404436AbgE1Pnv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 11:43:51 -0400
Received: (qmail 30418 invoked by uid 109); 28 May 2020 15:43:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 May 2020 15:43:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14613 invoked by uid 111); 28 May 2020 15:43:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 May 2020 11:43:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 May 2020 11:43:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, hji@dyntopia.com
Subject: Re: [PATCH] t: avoid alternation (not POSIX) in grep's BRE
Message-ID: <20200528154349.GA1215380@coredump.intra.peff.net>
References: <20200528083745.15273-1-carenas@gmail.com>
 <xmqqo8q83x3v.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8q83x3v.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 08:20:04AM -0700, Junio C Hamano wrote:

> > [1] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03
> >
> > Fixes: f1e3df3169 (t: increase test coverage of signature verification
> >        output, 2020-03-04)
> 
> I do appreciate the information recorded in the log message, but not
> like this.  Does everybody's tool understand the "folding" the above
> two physical lines require to be able to handle it correctly?

If you use any of the Git tools, they support an "unfold" option like:

  git log --format='%(trailers:unfold)'

that normalizes this. However, I would not be at all surprised if people
use custom readers. I think it may be a good policy to stick to the
simplest machine-readable formats for trailers. Likewise I'd suggest
using the full sha1-hex for future-proofing in this context.

-Peff
