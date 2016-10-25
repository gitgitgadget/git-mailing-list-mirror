Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14FC2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 18:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933784AbcJYSbB (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 14:31:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:34051 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932785AbcJYSbA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 14:31:00 -0400
Received: (qmail 11261 invoked by uid 109); 25 Oct 2016 18:30:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 18:30:59 +0000
Received: (qmail 3804 invoked by uid 111); 25 Oct 2016 18:31:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 14:31:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Oct 2016 14:30:57 -0400
Date:   Tue, 25 Oct 2016 14:30:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #06; Mon, 24)
Message-ID: <20161025183057.x24gqm56tgshyuvu@sigill.intra.peff.net>
References: <xmqq1sz5tetv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sz5tetv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2016 at 06:09:00PM -0700, Junio C Hamano wrote:

>  - lt/abbrev-auto and its follow-up jk/abbrev-auto are about auto
>    scaling the default abbreviation length when Git produces a short
>    object name to adjust to the modern times.  Peff noticed one
>    fallout from it recently and its fix jc/abbrev-auto is not yet in
>    'next'.  I would not be surprised if there are other uncovered
>    fallouts remaining in the code, but at the same time, I expect
>    they are all cosmetic kind that do not affect correctness, so I
>    am inclined to include all of them in the upcoming release.

Yeah, I'd agree any fallouts are likely to be purely cosmetic (and if
there _is_ some script broken by this, it was an accident waiting to
happen as soon as it was used in a repo with a partial hash collision).

I'm still not sure if people will balk just at the increased length in
all of their output. I think I'm finally starting to get used to it. :)

> * jc/abbrev-auto (2016-10-22) 4 commits
>  - transport: compute summary-width dynamically
>  - transport: allow summary-width to be computed dynamically
>  - fetch: pass summary_width down the callchain
>  - transport: pass summary_width down the callchain
>  (this branch uses jk/abbrev-auto and lt/abbrev-auto.)
> 
>  "git push" and "git fetch" reports from what old object to what new
>  object each ref was updated, using abbreviated refnames, and they
>  attempt to align the columns for this and other pieces of
>  information.  The way these codepaths compute how many display
>  columns to allocate for the object names portion of this output has
>  been updated to match the recent "auto scale the default
>  abbreviation length" change.
> 
>  Will merge to 'next'.

In case it was not obvious, I think this topic is good-to-go. And
clearly any decision on lt/abbrev-auto should apply to this one, too. I
notice you built it on jk/abbrev-auto, though, which is listed as
"undecided". That's fine by me, but I think it would technically hold
this topic hostage. You might want to adjust that before merging to
next.

-Peff
