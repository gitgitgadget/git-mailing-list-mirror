Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2D241F45F
	for <e@80x24.org>; Tue,  7 May 2019 21:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfEGVgO (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 17:36:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:50936 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726650AbfEGVgO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 17:36:14 -0400
Received: (qmail 13778 invoked by uid 109); 7 May 2019 21:36:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 21:36:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17010 invoked by uid 111); 7 May 2019 21:36:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 17:36:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 17:36:12 -0400
Date:   Tue, 7 May 2019 17:36:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/6] perf-lib.sh: fix 0baf78e7bc regression, refactor
 & fix bugs
Message-ID: <20190507213612.GB19955@sigill.intra.peff.net>
References: <20190506232309.28538-1-avarab@gmail.com>
 <20190507105434.9600-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507105434.9600-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 12:54:28PM +0200, Ævar Arnfjörð Bjarmason wrote:

> So here as a 6-parter given some of the feedback on v2. Maybe Jeff
> still hates it :), but this time around some of the changes are split
> up and should be easier to understand in isolation, as well as some
> more "noticed while I was at it" things fixed.

Thanks, the split did make things easier to understand.

These all look reasonable to me, and I confirmed by re-running a few of
the problematic perf tests that everything is behaving as expected after
the patches.

> This series ends with outright forbidding the user from directly
> setting GIT_TEST_INSTALLED. As discussed it makes things easier for
> us, and as noted in 1/6 the demand for that in the wild seems
> non-existent, since the way we've been documenting how you could do
> that with an environment variable has been broken since 2012.

I think this is reasonable, especially with the feature in patch 6 to
tell the caller they're doing it wrong, instead of just silently
producing nonsense results.

Junio, if you haven't been following closely, this can replace my patch
from jk/perf-installed-fix.

-Peff
