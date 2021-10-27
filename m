Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943CCC433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E15610A3
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbhJ0UfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:35:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:48370 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240951AbhJ0UfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 16:35:21 -0400
Received: (qmail 14300 invoked by uid 109); 27 Oct 2021 20:32:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Oct 2021 20:32:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27815 invoked by uid 111); 27 Oct 2021 20:32:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Oct 2021 16:32:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Oct 2021 16:32:54 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH 0/2] Conditional config includes based on remote URL
Message-ID: <YXm3dtOy3FwR7FUG@coredump.intra.peff.net>
References: <YXk+TRnndNZkdsGF@coredump.intra.peff.net>
 <20211027175259.2230232-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211027175259.2230232-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 10:52:59AM -0700, Jonathan Tan wrote:

> > If the deferred includes were processed at the end of each individual
> > file, that would solve that. You're still left with the slight oddness
> > that a deferred include may override options within the same file that
> > come after it, but that's inherent to the "defer" concept, and the
> > answer is probably "don't do that". It's only when it crosses file
> > boundaries (which are explicitly ordered by priority) that it really
> > hurts.
> 
> This would indeed solve the issue of the user needing to know the trick
> to override variables set by deferred includes. But this wouldn't solve
> our primary use case in which a system-level config defines a
> conditional include but the repo config defines the URL, I think.

Doh, of course. I forgot that was the whole point of the defer. ;)

> I am implementing something similar to your first approach (stashing
> things). It's almost done so hopefully we'll have something concrete to
> discuss soon.

Sounds good.

-Peff
