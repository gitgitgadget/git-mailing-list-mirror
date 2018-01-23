Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621921F404
	for <e@80x24.org>; Tue, 23 Jan 2018 16:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeAWQUT (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 11:20:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:54390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751170AbeAWQUS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 11:20:18 -0500
Received: (qmail 24015 invoked by uid 109); 23 Jan 2018 16:20:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 16:20:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16828 invoked by uid 111); 23 Jan 2018 16:20:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Jan 2018 11:20:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jan 2018 11:20:16 -0500
Date:   Tue, 23 Jan 2018 11:20:16 -0500
From:   Jeff King <peff@peff.net>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 5/6] convert: add 'working-tree-encoding' attribute
Message-ID: <20180123162016.GD13068@sigill.intra.peff.net>
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
 <20180120152418.52859-6-lars.schneider@autodesk.com>
 <20180121142222.GA10248@ruderich.org>
 <05265803-BD74-4667-ABB5-9752E55A5015@gmail.com>
 <20180123005401.GG26357@sigill.intra.peff.net>
 <20180123102558.GA3878@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180123102558.GA3878@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 11:25:58AM +0100, Simon Ruderich wrote:

> On Mon, Jan 22, 2018 at 07:54:01PM -0500, Jeff King wrote:
> > But anyway, that was a bit of a tangent. Certainly the smaller change is
> > just standardizing on sizeof(*foo), which I think most people agree on
> > at this point. It might be worth putting in CodingGuidelines.
> 
> Personally I prefer sizeof(*foo) which is a well non-idiom, used
> in many projects and IMHO easy to read and understand.

Me too.

> I've played a little with coccinelle and the following spatch
> seems to catch many occurrences of sizeof(struct ..) (the first
> hunk seems to expand multiple times causing conflicts in the
> generated patch). Cases like a->b = xcalloc() are not matched, I
> don't know enough coccinelle for that. If there's interest I
> could prepare patches, but it will create quite some code churn.

Yeah, I'm not sure what our current policy is there. Traditionally our
strategy was not to churn code, but to update old idioms as they were
touched. Especially if the change was not urgent, but mostly stylistic
(which this one is).

But with Coccinelle, it's a lot easier to apply the change tree-wide, and
to convert topics in flight as they get merged. The maintainer still
gets conflicts with topics-in-flight that touch converted areas, though.
So I'd be curious to hear if Junio's opinion has changed at all.

-Peff
