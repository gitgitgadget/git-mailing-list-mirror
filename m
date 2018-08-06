Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F302208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 13:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeHFPLS (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 11:11:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:43704 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727834AbeHFPLS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 11:11:18 -0400
Received: (qmail 7586 invoked by uid 109); 6 Aug 2018 13:02:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 13:02:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25071 invoked by uid 111); 6 Aug 2018 13:02:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 09:02:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 09:02:16 -0400
Date:   Mon, 6 Aug 2018 09:02:16 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, wchargin@gmail.com,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] t/test-lib: make `test_dir_is_empty` more robust
Message-ID: <20180806130216.GA29966@sigill.intra.peff.net>
References: <20180805022002.28907-1-wchargin@gmail.com>
 <20180805022002.28907-2-wchargin@gmail.com>
 <20180805041956.GI258270@aiede.svl.corp.google.com>
 <CAPig+cQSryjWrFZML_g0fR5oq6dzVaWPXm_4R-Jg_ay1R2DzbQ@mail.gmail.com>
 <20180805205231.GA14688@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180805205231.GA14688@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 05, 2018 at 04:52:31PM -0400, Jeff King wrote:

> On Sun, Aug 05, 2018 at 01:23:05AM -0400, Eric Sunshine wrote:
> 
> > A simpler approach, without the portability concerns of -A, would be
> > to remove the "." and ".." lines from the top of the listing:
> > 
> >     ls -f1 "$1" | sed '1,2d'
> > 
> > If we're worried about -f not being sufficiently portable, then an
> > even simpler approach would be to check whether the output of 'ls -a1'
> > has more lines than the two expected ("." and ".."):
> > 
> >     test $(ls -a1 "$1" | wc -l) -gt 2
> > 
> > I think I favor this final implementation over the others.
> 
> Perhaps even simpler:
> 
>   test "$1" = "$(find "$1")"

Actually, I guess it needs to add "-print", since IIRC that is not the
default on some old versions of "find".

-Peff
