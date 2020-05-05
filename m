Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8820C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9C02078C
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgEEQn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:43:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:37922 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728804AbgEEQn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:43:27 -0400
Received: (qmail 13352 invoked by uid 109); 5 May 2020 16:43:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 May 2020 16:43:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31445 invoked by uid 111); 5 May 2020 16:43:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 May 2020 12:43:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 May 2020 12:43:26 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200505164326.GA64077@coredump.intra.peff.net>
References: <20200504150105.GB11373@coredump.intra.peff.net>
 <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505002055.GC64230@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 06:20:55PM -0600, Taylor Blau wrote:

> > > Of course, I don't want to maintain a one-patch difference between
> > > ttaylorr/git@master and git/git@master, so I wonder if we could get a
> > > little more creative with these rules and actually run Actions on
> > > *every* branch, but introduce a new first step which stops the rest of
> > > the actions run (so that in practice we're not running CI on
> > > non-integration branches in Junio's tree).
> >
> > I don't understand what that would accomplish. If we ran the actions on
> > every branch but stopped the run, then you wouldn't get the CI results
> > you want. What am I missing?
> 
> That on forks of git/git we *would't* stop the run for non-integration
> branches, i.e., that we'd have something like:

Ah, so the first step is "if we are gitster/git, then do not run", not
"do not run".

But that is missing the point of the exercise, no? The question of what
gitster/git should do was a side conversation. The purpose of Dscho's
original patch and Danh's followup was to allow anybody to choose which
branches in their own fork. I.e.:

>   * Actions is running on all branches, of all forks, all the time.

This is how it works now, and is the exact thing we are trying to fix.

-Peff
