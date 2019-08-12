Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32FB1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 16:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfHLQNx (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 12:13:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:40794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725648AbfHLQNx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 12:13:53 -0400
Received: (qmail 26101 invoked by uid 109); 12 Aug 2019 16:13:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Aug 2019 16:13:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23872 invoked by uid 111); 12 Aug 2019 16:16:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2019 12:16:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Aug 2019 12:13:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t/perf: rename duplicate-numbered test script
Message-ID: <20190812161352.GB25388@sigill.intra.peff.net>
References: <20190812155803.GA25161@sigill.intra.peff.net>
 <xmqqftm6bca3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftm6bca3.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 09:04:36AM -0700, Junio C Hamano wrote:

> >  t/perf/{p5600-clone-reference.sh => p5601-clone-reference.sh} | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename t/perf/{p5600-clone-reference.sh => p5601-clone-reference.sh} (100%)
> >
> > diff --git a/t/perf/p5600-clone-reference.sh b/t/perf/p5601-clone-reference.sh
> > similarity index 100%
> > rename from t/perf/p5600-clone-reference.sh
> > rename to t/perf/p5601-clone-reference.sh
> 
> By the way, do we feel differently (e.g. more risky) when we see
> 100% rename without the "index old-oid..new-oid mode" lines and when
> we see 99% rename with one, with a one-line change?

I saw that earlier message from Linus, too. :)

For a change like this, I don't think it matters either way. Whatever is
the content of that file, my intent is to move it to a new location. So
if you did have changes, moving them along with it would be the right
thing.

That said, I'm not at all opposed to having more data in the patch. Even
if the "apply" side doesn't do anything useful with the "index" line in
such a case, it's possible it could help with tracking down a mis-merge
or other confusion after the fact.

What I don't think we would want, though, is for a change on your side
to reject a patch like mine (a sort of "RENAME/MODIFY" conflict, I
guess, where "am" says "I can't move 1234abcd to this new filename,
because that's not what I have at that path"). Our merges are already
happy to port changes around when there's a rename on another branch,
and this case is no different.

-Peff
