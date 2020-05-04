Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578CFC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D056206A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgEDXfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:35:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:36902 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727982AbgEDXfO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:35:14 -0400
Received: (qmail 3618 invoked by uid 109); 4 May 2020 23:35:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 23:35:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23622 invoked by uid 111); 4 May 2020 23:35:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 19:35:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 19:35:12 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200504233512.GA39798@coredump.intra.peff.net>
References: <20200504150105.GB11373@coredump.intra.peff.net>
 <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <xmqqzhane2ir.fsf@gitster.c.googlers.com>
 <20200504231544.GJ45250@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200504231544.GJ45250@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 05:15:44PM -0600, Taylor Blau wrote:

> > If this is only a reaction to what I said earlier (i.e. "building
> > everything in github.com/gitster/git/ has no value to me"), then I
> > suspect it may be an over-engineered solution to a problem that does
> > not exist, and harms people like you.  I could just go there and
> > turn off GitHub Actions for that repository instead.
> 
> It is a reaction to that, yes. It would be nice to have a middle-ground
> where you can run Actions on the official integration branches, but
> contributors such as myself run Actions on *every* branch of their fork.

The problem is that there is no way for people to _not_ run on every
branch of their fork, then. It is either every branch or no branches.

By choosing a prefix, it gives people the option to choose. But it does
place the burden on them of adding an extra refspec:

  refs/heads/*:refs/heads/for-ci/*

or similar. I don't like it, but I don't see any other way to let people
choose some branches but not others (that doesn't involve a one-line
yaml change at the beginning of every branch, which is an even higher
burden).

-Peff
