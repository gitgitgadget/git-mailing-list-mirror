Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8210C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 09:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C476D20714
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 09:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgC0JhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:37:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:53358 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725956AbgC0JhM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 05:37:12 -0400
Received: (qmail 10148 invoked by uid 109); 27 Mar 2020 09:37:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Mar 2020 09:37:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23484 invoked by uid 111); 27 Mar 2020 09:47:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2020 05:47:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Mar 2020 05:37:10 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] fetch-pack: lazy fetch using tree:0
Message-ID: <20200327093710.GA611304@coredump.intra.peff.net>
References: <20200319174439.230969-1-jonathantanmy@google.com>
 <20200320061214.GA511478@coredump.intra.peff.net>
 <20200326195058.GA8613@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326195058.GA8613@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 01:50:58PM -0600, Taylor Blau wrote:

> > One side note (for Taylor, cc'd): our patches elsewhere to limit the
> > allowed filters don't make it possible to express the difference between
> > "tree:0" and "tree:1". It may be worth thinking about that, especially
> > if it influences the config schema (since we'll have to support it
> > forever once it makes it into a release).
> [...]
>   [uploadpack "filter.tree:depth"]
>     allow = true
>     maxDepth = <n>

Yeah, that scheme solves the problem very neatly, and removes any worry
I had about painting ourselves into a corner. Thanks.

-Peff
