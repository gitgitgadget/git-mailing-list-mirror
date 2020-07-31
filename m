Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFBDC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 01:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957232083E
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 01:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGaBBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:01:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:43220 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgGaBBa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 21:01:30 -0400
Received: (qmail 17794 invoked by uid 109); 31 Jul 2020 01:01:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 01:01:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22821 invoked by uid 111); 31 Jul 2020 01:01:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jul 2020 21:01:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jul 2020 21:01:29 -0400
From:   Jeff King <peff@peff.net>
To:     Emma Brooks <me@pluvano.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: Map names/emails with mailmap
Message-ID: <20200731010129.GD240563@coredump.intra.peff.net>
References: <20200730041217.6893-1-me@pluvano.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730041217.6893-1-me@pluvano.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 30, 2020 at 04:12:17AM +0000, Emma Brooks wrote:

> Add an option to map names and emails to their canonical forms via a
> .mailmap file. This is enabled by default, consistent with the behavior
> of Git itself.

I'm quite far from an expert in gitweb, but this seems like a good
feature to have.

Having a separate implementation to read and apply mailmaps makes me
worried that it will behave slightly differently than the C code,
especially around corner cases. Is it possible for us to ask git
programs that are called by gitweb to do the conversion for us (e.g.,
by passing "--use-mailmap" or using "%aE" and "%aN" formatters)?
I won't be surprised if the answer is "no, we access commits using
lower-level plumbing". But it's worth looking into, I think, if you
didn't already.

-Peff
