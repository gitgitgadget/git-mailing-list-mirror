Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB65C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 19:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40928610A7
	for <git@archiver.kernel.org>; Mon,  3 May 2021 19:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhECTj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 15:39:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:43408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhECTj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 15:39:56 -0400
Received: (qmail 7170 invoked by uid 109); 3 May 2021 19:39:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 19:39:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6823 invoked by uid 111); 3 May 2021 19:39:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 15:39:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 15:39:01 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/9] t7450: test verify_path() handling of gitmodules
Message-ID: <YJBRVQ7+CUkYf5Us@coredump.intra.peff.net>
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
 <YI124aZ1dbY5O67J@coredump.intra.peff.net>
 <CAPig+cSxB89mJcjaoLMLEgqdqi9SSP5+R9qjbVydvA-kVq-2+g@mail.gmail.com>
 <CAPig+cQFUUncb17MFAvJAh2KFxK_OCq_6AoOwPViYyQJUDVJNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQFUUncb17MFAvJAh2KFxK_OCq_6AoOwPViYyQJUDVJNg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 01, 2021 at 03:03:56PM -0400, Eric Sunshine wrote:

> On Sat, May 1, 2021 at 2:55 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Sat, May 1, 2021 at 11:42 AM Jeff King <peff@peff.net> wrote:
> > > +       tree=$(git -C symlink mktree <symlink/bad-tree)
> >
> > `tree` is an unusually generic name for this now-global variable. One
> > can easily imagine it being re-used by some unrelated test arbitrarily
> > inserted into this script, thus potentially breaking the following
> > tests which depend upon it. I wonder if a name such as `BAD_TREE`
> > would be more appropriate.
> 
> I see that all `$tree` references get encapsulated into a shell
> function by the next patch, so perhaps the generic name `tree` isn't a
> big deal after all.

Yeah. I'd like to think it is not that big a deal between even just
adjacent tests, because anybody adding tests in the middle of a script
would take care not to split related ones. But that may be too
optimistic. ;)

At any rate, it seems OK to assume the function will all be used
together.

-Peff
