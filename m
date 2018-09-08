Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E39E1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 16:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeIHVDc (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 17:03:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:43726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726880AbeIHVDc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 17:03:32 -0400
Received: (qmail 11186 invoked by uid 109); 8 Sep 2018 16:17:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 08 Sep 2018 16:17:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28957 invoked by uid 111); 8 Sep 2018 16:17:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Sep 2018 12:17:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Sep 2018 12:17:12 -0400
Date:   Sat, 8 Sep 2018 12:17:12 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t5551-http-fetch-smart.sh: sort cookies before comparing
Message-ID: <20180908161712.GA9016@sigill.intra.peff.net>
References: <20180907232205.31328-1-tmz@pobox.com>
 <20180907235508.GB32065@sigill.intra.peff.net>
 <20180908032841.GK7192@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180908032841.GK7192@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 07, 2018 at 11:28:41PM -0400, Todd Zullinger wrote:

> > So this fix looks fine. It might be worth a comment above the creation
> > of expect_cookies.txt to mention it must be in sorted order (of course
> > anybody modifying it would see a test failure).
> 
> I thought about running the expect_cookies.txt file through
> sort as well.  That would ensure that both files were using
> the same sorting.  Whether that's needed on any platform
> now, I don't know.  Maybe that would be a useful way to
> protect against future edits to the expect_cookies.txt file
> catching the editor?

Yes, I think sorting the expect file would work fine. I'm OK with that,
or just leaving a comment. The comment has the bonus that it does not
cost an extra process at runtime. I'd probably use a sort if we expected
the list to be long and complicated, since it makes life easier on a
future developer. But since there are only 2 lines, I don't think it's a
big deal either way (or even just leaving it as-is without a comment is
probably OK).

> I thought there might be a test function to sort the output,
> but I was (incorrectly) thinking of check_access_log() which
> Gábor added in e8b3b2e275 ("t/lib-httpd: avoid occasional
> failures when checking access.log", 2018-07-12).
> 
> Perhaps it would be useful to have a test_cmp_sorted() to do
> the simple dance of sorting the actual & expected.  I
> haven't looked through the tests to see how often such a
> function might be useful.

I suspect it would occasionally be useful, but I don't recall it coming
up all that often.

-Peff
