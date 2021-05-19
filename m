Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679DCC43460
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530B161355
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354032AbhESOQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 10:16:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:59068 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354029AbhESOPt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 10:15:49 -0400
Received: (qmail 23311 invoked by uid 109); 19 May 2021 14:14:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 May 2021 14:14:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20331 invoked by uid 111); 19 May 2021 14:14:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 May 2021 10:14:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 May 2021 10:14:28 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Ben Humphreys <behumphreys@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christopher Schenk <christopher@cschenk.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "remote-curl: fall back to basic auth if
 Negotiate fails"
Message-ID: <YKUdRNH+uLBxAi+m@coredump.intra.peff.net>
References: <YKNeJ+NKUbD5ixA9@coredump.intra.peff.net>
 <YKNeXq3JzxYWkxKl@coredump.intra.peff.net>
 <43035278-5742-607a-57bd-971685deece8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43035278-5742-607a-57bd-971685deece8@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 09:58:50AM -0400, Derrick Stolee wrote:

> > (Note that this isn't a pure revert; the previous commit added a test
> > showing the regression, so we can now flip it to expect_success).
> 
> Keeping the test is excellent, because it gives us a way to confirm
> that a second attempt at a fix is at least as good as the first.
> 
> The only thing that could improve this situation is to add a test
> that checks the bug that the previous version introduced, so that
> the next round doesn't repeat the mistake. That can be deferred
> because it is more important that we get this fix in time for the
> next release candidate.

Re-reading what I wrote, I think "the previous commit" may be ambiguous.
The original commit which introduced the bug (and which we're reverting
here) didn't include a test at all. In patch 1/2 of this series (what
I'm calling "the previous commit"), I provided a test which shows the
regression. And now this revert shows that we fixed it (by flipping from
expect_failure to expect_success).

So I think I've already done what you're asking (if I understand it
correctly).

It probably would be a little easier to follow by reverting first, and
then adding in the expect_success test on top to future-proof us. But by
doing it in the other order, it was easy to see the test demonstrate the
behavior before and after the revert.

-Peff
