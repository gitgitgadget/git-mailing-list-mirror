Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33348C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62F42343F
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392723AbhATTrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:47:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:33272 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392734AbhATTqi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:46:38 -0500
Received: (qmail 28694 invoked by uid 109); 20 Jan 2021 19:45:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Jan 2021 19:45:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25391 invoked by uid 111); 20 Jan 2021 19:45:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Jan 2021 14:45:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Jan 2021 14:45:48 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v2 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAiIbEAZSlL7B+am@coredump.intra.peff.net>
References: <20210120124514.49737-1-jacob@gitlab.com>
 <20210120124514.49737-2-jacob@gitlab.com>
 <YAhC8Gsp4H17e28n@nand.local>
 <YAhXw9Gvn5Pyvacq@coredump.intra.peff.net>
 <YAhYHUcdynbWyhwo@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAhYHUcdynbWyhwo@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 11:19:41AM -0500, Taylor Blau wrote:

> On Wed, Jan 20, 2021 at 11:18:11AM -0500, Jeff King wrote:
> > So I think both the existing and the new calls using for_each_tag_ref()
> > are OK here.
> 
> Indeed, I followed the same trail of calls as you did and reached the
> same conclusion, but didn't write any of it down here since I thought it
> wasn't worthwhile.
> 
> But, yes, I agree that both are safe.

OK. I think it's worth saying such things (in case that was not obvious.
;) ).

I also rage-replaced peel_ref() with a function taking an oid so we
never have to do that digging again. Posted separately in its own
thread.

-Peff
