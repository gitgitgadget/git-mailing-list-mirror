Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958B51F4B6
	for <e@80x24.org>; Sat, 29 Jun 2019 00:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfF2A0T (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 20:26:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:54746 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726643AbfF2A0T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 20:26:19 -0400
Received: (qmail 16075 invoked by uid 109); 29 Jun 2019 00:26:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Jun 2019 00:26:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22135 invoked by uid 111); 29 Jun 2019 00:27:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 20:27:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 20:26:17 -0400
Date:   Fri, 28 Jun 2019 20:26:17 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
Message-ID: <20190629002617.GA3094@sigill.intra.peff.net>
References: <20190628093751.GA3569@sigill.intra.peff.net>
 <20190628093911.GA27329@sigill.intra.peff.net>
 <CAPig+cQAKVOqYH-CcqzViP_zuKwg5fWO2_i8=Z5t=BVf9uoAXQ@mail.gmail.com>
 <20190628230417.GC21574@szeder.dev>
 <CAPig+cQnvotvJakCp1ic_WP3AMojNmfZw-PoinR=VOODmtNBtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQnvotvJakCp1ic_WP3AMojNmfZw-PoinR=VOODmtNBtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 07:46:02PM -0400, Eric Sunshine wrote:

> On Fri, Jun 28, 2019 at 7:04 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > On Fri, Jun 28, 2019 at 05:32:35PM -0400, Eric Sunshine wrote:
> > > On Fri, Jun 28, 2019 at 5:39 AM Jeff King <peff@peff.net> wrote:
> > > > +       in_dir=${indir:+-C "$indir"}
> > >
> > > Doesn't this suffer the problem in which some older/broken
> > > shells[1][2][3][4] incorrectly [...]
> >
> > I think we don't need any of those "${indir:+-C "$indir"}" parameter
> > expansions and could simply use 'git -C "$indir" cmd...' everywhere.
> > $indir is set to empty right at the start of the function, and 'git -C
> > "" ...' works and doesn't change the working directory.
> 
> I recall the discussion around the meaning of `-C ""` when that
> command line option was introduced. The conclusion was that  the
> zero-length argument should mean "this directory" since that's how `cd
> ""` behaves. However, I don't think that behavior ever got documented,
> and it's not necessarily obvious. An alternative would be to default
> 'indir' to ".", which should give the same result and be easily
> understood.

Yeah, I had considered that, too. I had mostly just copied the solution
from test_commit, thinking nobody would nitpick it. ;) But if everybody
likes ".", I think that is a bit more readable.

-Peff
