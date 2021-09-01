Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D024DC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 06:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32E06101A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 06:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbhIAGJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 02:09:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:36080 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242085AbhIAGJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 02:09:46 -0400
Received: (qmail 15418 invoked by uid 109); 1 Sep 2021 06:08:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Sep 2021 06:08:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3874 invoked by uid 111); 1 Sep 2021 06:08:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Sep 2021 02:08:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Sep 2021 02:08:48 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] pack-write,repack: prevent opening packs too early
Message-ID: <YS8Y8Ag1Ya+Sn2zg@coredump.intra.peff.net>
References: <cover.1630461918.git.me@ttaylorr.com>
 <YS75P7r33NIBmFh2@coredump.intra.peff.net>
 <YS8BwgfurPzhT4xh@nand.local>
 <YS8IqxNbxy0YrXSe@coredump.intra.peff.net>
 <YS8LyanAqro3PDlm@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS8LyanAqro3PDlm@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 01:12:41AM -0400, Taylor Blau wrote:

> On Wed, Sep 01, 2021 at 12:59:23AM -0400, Jeff King wrote:
> > So anyway. I think we definitely want the index-pack.c change. We
> > _could_ stop there and change the read side as a separate series, but I
> > think that until we do, the ordering changes on the write side aren't
> > really doing that much. They're shrinking the race a little, I guess,
> > but it's still very much there.
> 
> Yeah, now that I've had a chance to look at it it seems pretty
> straightforward. Probably limited to checks in prepare_pack(), and
> add_pack_to_midx(), which are the lone two callbacks of
> for_each_file_in_pack_dir().

Yes, that matches what I'd expect.

> I'll make sure that I'm not missing anything and then send a reroll
> tomorrow.

Great, thanks!

-Peff
