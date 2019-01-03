Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1661F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 07:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfACHoY (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 02:44:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:53646 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726671AbfACHoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 02:44:24 -0500
Received: (qmail 26188 invoked by uid 109); 3 Jan 2019 07:44:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 07:44:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8722 invoked by uid 111); 3 Jan 2019 07:44:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 03 Jan 2019 02:44:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2019 02:44:22 -0500
Date:   Thu, 3 Jan 2019 02:44:22 -0500
From:   Jeff King <peff@peff.net>
To:     "Stephen P . Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
Message-ID: <20190103074421.GC24925@sigill.intra.peff.net>
References: <20181231003150.8031-1-ischis2@cox.net>
 <20181231003150.8031-4-ischis2@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181231003150.8031-4-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 30, 2018 at 05:31:50PM -0700, Stephen P. Smith wrote:

> The `human` date format varies based on two inputs: the date in the
> reference time which is constant and the local computers date which
> varies.  Using hardcoded test expected output dates would require
> holding the local machines date and time constant which is not
> desireable.
> 
> Alternatively, letting the local date vary, which is the normal
> situation, implies that the tests would be checking for formating
> changes based on on a ref date relative to the local computers time.

We already have $TEST_DATE_NOW, which "test-tool date" will respect for
various commands to pretend that it's currently a particular time. I
think you'd need to add a sub-command similar to "relative" (which
directly calls show_date_relative()) which calls into the "human" code.

Note that there _isn't_ a way to have actual non-test git programs read
the current time from an environment variable (as opposed to actually
calling gettimeofday()).

-Peff
