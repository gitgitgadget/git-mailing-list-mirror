Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD88C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 11:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjCILCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 06:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjCILAu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 06:00:50 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B60DCF7E
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 02:58:26 -0800 (PST)
Received: (qmail 8381 invoked by uid 109); 9 Mar 2023 10:57:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 10:57:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30063 invoked by uid 111); 9 Mar 2023 10:57:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 05:57:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 05:57:30 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] Add a CI for unsigned char system
Message-ID: <ZAm7mpf36IOCqgN4@coredump.intra.peff.net>
References: <cover.1677850517.git.congdanhqx@gmail.com>
 <ZAmsikbYncUbNjD2@coredump.intra.peff.net>
 <CAPx1GveS2=8-rh6PVFsOXLvJ4iZGzeo9uUdG=wcbophxiDam0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx1GveS2=8-rh6PVFsOXLvJ4iZGzeo9uUdG=wcbophxiDam0g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 02:26:34AM -0800, Chris Torek wrote:

> On Thu, Mar 9, 2023 at 1:54 AM Jeff King <peff@peff.net> wrote:
> > I like the overall goal, but I'm not wild about having another CI
> > provider.
> 
> So, why not do an x86 build with `-funsigned-char`? Seems to work with
> both gcc and clang.

Yeah, that would be even simpler. Though IMHO "unsigned char" is only
one interesting difference to be checking. Another would be having a
platform where unaligned access isn't tolerated. It would be nice to
have a big-endian platform, too, but I'm not sure if arm is a good fit
there (my impression is that it can be run in either mode?).

On the other hand, I think Ævar does periodically run on the gcc build
machines, which includes examples of each (including aarch64). And this
particular bug was found pretty quickly (within a week of it hitting
next, and only a day after hitting master). So while it might be nice to
have more immediate CI feedback, it does seem like the old "if the
platform matters, somebody will try it and report the problem" strategy
still works, too.

-Peff
