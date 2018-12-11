Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E54D20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 11:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLKLRT (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 06:17:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:38018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726114AbeLKLRT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 06:17:19 -0500
Received: (qmail 15954 invoked by uid 109); 11 Dec 2018 11:17:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 11:17:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4132 invoked by uid 111); 11 Dec 2018 11:16:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 06:16:26 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 06:16:54 -0500
Date:   Tue, 11 Dec 2018 06:16:54 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] test-lib: add the '--stress' option to help
 reproduce occasional failures in flaky tests
Message-ID: <20181211111654.GD8452@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181209225628.22216-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 09, 2018 at 11:56:21PM +0100, SZEDER Gábor wrote:

> This patch series tries to make reproducing rare failures in flaky
> tests easier: it adds the '--stress' option to our test library to run
> the test script repeatedly in multiple parallel jobs, in the hope that
> the increased load creates enough variance in the timing of the test's
> commands that such a failure is eventually triggered.
> 
> Notable changes since v1:
> 
>   - Made it more Peff-friendly :), namely it will now show the log of
>     the failed test and will rename its trash directory.
> 
>     Furthermore, '--stress' will now imply '--verbose -x --immediate'.

:) Thanks. I do sympathize with the notion of keeping orthogonal things
orthogonal, but I hope that this will make the tool a little more
pleasant to use out of the box. We can always tweak the behavior later,
too. It's not like this is something user-facing that we've promised as
a scripting interface.

>   - Improved abort handling based on the discussion of the previous
>     version.  (As a result, the patch is so heavily modified, that
>     'range-diff' with default parameters consideres it a different
>     patch; increasing the creation factor then results in one big ugly
>     diff of a diff, so I left it as-is.)

Yeah, this all looked good to me.

>   - Added a few new patches, mostly preparatory refactorings, though
>     the first one might be considered a bugfix.

I left a few minor comments, but these all looked good to me.

-Peff
