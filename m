Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43CEC433E1
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 23:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B147F2065C
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 23:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgHOXSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 19:18:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:60290 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbgHOXSi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 19:18:38 -0400
Received: (qmail 8740 invoked by uid 109); 15 Aug 2020 06:38:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Aug 2020 06:38:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31647 invoked by uid 111); 15 Aug 2020 06:38:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Aug 2020 02:38:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Aug 2020 02:38:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
Message-ID: <20200815063811.GA628010@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145936.GC891370@coredump.intra.peff.net>
 <xmqqr1sa2znw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1sa2znw.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 11:01:23AM -0700, Junio C Hamano wrote:

> > ---
> >  Makefile                            |  6 +-----
> >  builtin.h                           |  1 +
> >  bugreport.c => builtin/bugreport.c  | 10 +++-------
> >  contrib/buildsystems/CMakeLists.txt |  5 +----
> >  git.c                               |  1 +
> >  5 files changed, 7 insertions(+), 16 deletions(-)
> >  rename bugreport.c => builtin/bugreport.c (96%)
> 
> I am on the fence, as bugreport does not seem to be fully completed
> part of the system.  The original thinking was that it may soon want
> to grow by linking with platform specific libraries for lower-level
> system characteristic identification, at which time we'd not want to
> have it in builtins and "we can take advantage of builtin niceties"
> will cause us regrets.  The only reason that hasn't happened as far
> as I can see is because its development speed is rather slow.
> 
> So, I dunno.

Where do we want to go with this? After the discussion and sleeping on
it, I'm still of the mind that we should generally default things to
being builtins unless there's an immediate need not to do so (like
extra link dependencies). But I don't care _too_ much, so I'd rather
eject this patch and move forward with the rest of the series if it's a
sticking point. Thoughts?

-Peff
