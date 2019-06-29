Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5041F461
	for <e@80x24.org>; Sat, 29 Jun 2019 00:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfF2ATh (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 20:19:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:54722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726643AbfF2ATh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 20:19:37 -0400
Received: (qmail 16047 invoked by uid 109); 29 Jun 2019 00:19:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Jun 2019 00:19:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22079 invoked by uid 111); 29 Jun 2019 00:20:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 20:20:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 20:19:35 -0400
Date:   Fri, 28 Jun 2019 20:19:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
Message-ID: <20190629001935.GE2625@sigill.intra.peff.net>
References: <20190628093751.GA3569@sigill.intra.peff.net>
 <20190628093911.GA27329@sigill.intra.peff.net>
 <87woh57dnt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87woh57dnt.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 08:44:38PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > +# Similar to test_commit, but efficiently create <nr> commits, each with a
> > +# unique number $n (from 1 to <nr> by default) in the commit message.
> 
> Is it intentional not to follow test_commit's convention of creating a
> tag as well? If so it would be helpful to note that difference here, or

Yes, it was intentional. I have long hated that feature, as there are
many tests have to bend over backwards to deal with the reachability
implications of adding the extra tag (not to mention the waste of a
process). Likewise, I have long hated the implicit-argument-ordering of
test_commit that make it hard to set some optional arguments but not
others (hence the double-dash parameters).

I had planned to add a "--tag" parameter if anybody ever wanted one. But
we can call out that difference explicitly. Or alternatively, stop
saying "like test_commit" and just say "Efficiently create <nr>
commits".

> rather, move this documentation to t/README where test_commit and
> friends are documented.

Ugh. I had no idea that documentation even existed. Because of course
test_commit _is_ documented next to its definition, and that
documentation has been kept up to date, unlike the far-away stale bits
in t/README.

-Peff
