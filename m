Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E7C77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 21:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjDKVQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 17:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDKVQL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 17:16:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7CB55BB
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:16:05 -0700 (PDT)
Received: (qmail 13694 invoked by uid 109); 11 Apr 2023 21:16:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Apr 2023 21:16:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10680 invoked by uid 111); 11 Apr 2023 21:16:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Apr 2023 17:16:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Apr 2023 17:16:04 -0400
From:   Jeff King <peff@peff.net>
To:     Jonas Haag <jonas@lophus.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Infinite loop + memory leak in annotate_refs_with_symref_info
Message-ID: <20230411211604.GB626331@coredump.intra.peff.net>
References: <39035D34-8548-44B0-BBBB-5C36B3876C4A@lophus.org>
 <20230411210633.GA626331@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411210633.GA626331@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 05:06:33PM -0400, Jeff King wrote:

> On Tue, Apr 11, 2023 at 10:53:59PM +0300, Jonas Haag wrote:
> 
> > There is an infinite loop with an accompanying memory leak in
> > annotate_refs_with_symref_info that was introduced in Git 2.28 (I
> > think in commit 2c6a403: “connect: add function to parse multiple v1
> > capability values”).
> 
> Have you tried to reproduce with a more recent version of Git? This
> sounds a lot like the bug fixed in 44d2aec6e8 (connect: also update
> offset for features without values, 2021-09-26), which is in v2.33.1.

Never mind. I was able to reproduce (I never used klaus, but it's
packaged for Debian, so it was pretty easy to do). And yes, the problem
still exists today. And bisection confirms it's from 2c6a403.

-Peff
