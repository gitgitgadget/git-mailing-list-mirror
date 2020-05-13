Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EFFC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F34206A5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390850AbgEMUR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:17:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:45726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732650AbgEMUR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 16:17:26 -0400
Received: (qmail 8359 invoked by uid 109); 13 May 2020 20:17:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 May 2020 20:17:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25359 invoked by uid 111); 13 May 2020 20:17:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2020 16:17:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 May 2020 16:17:24 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH 3/8] commit-graph.c: peel refs in 'add_ref_to_set'
Message-ID: <20200513201724.GA1823254@coredump.intra.peff.net>
References: <cover.1588641176.git.me@ttaylorr.com>
 <5ff56feab55b005b4a4d9559909ce7a08e5fa81e.1588641176.git.me@ttaylorr.com>
 <20200507195441.GA29683@coredump.intra.peff.net>
 <20200513194848.GA24173@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200513194848.GA24173@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 01:48:48PM -0600, Taylor Blau wrote:

> > Alternatively, you could do this without a struct copy at all with:
> >
> >   if (!peel_ref(...))
> >          oid = peeled;
> >   oidset_insert(..., oid);
> >
> > which is actually a bit cheaper.
> 
> Makes sense, I think this version is the better of the two that you
> suggested here. I noticed one small thing which is that since peeled is
> only on the stack, I think we actually want 'oid = &peeled', but
> otherwise I took this as-is.

Yes, definitely. That's what I get for writing code in my email editor. :)

-Peff
