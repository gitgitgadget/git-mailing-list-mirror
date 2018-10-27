Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8881F453
	for <e@80x24.org>; Sat, 27 Oct 2018 08:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeJ0Q5g (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:57:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:57138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726610AbeJ0Q5g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:57:36 -0400
Received: (qmail 27762 invoked by uid 109); 27 Oct 2018 08:17:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 08:17:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4909 invoked by uid 111); 27 Oct 2018 08:16:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 04:16:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 04:17:25 -0400
Date:   Sat, 27 Oct 2018 04:17:25 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] thread-utils: better wrapper to avoid #ifdef
 NO_PTHREADS
Message-ID: <20181027081724.GH26685@sigill.intra.peff.net>
References: <20181018170934.GA21138@sigill.intra.peff.net>
 <20181018180522.17642-1-pclouds@gmail.com>
 <20181023202842.GA17371@sigill.intra.peff.net>
 <852ad281-09df-c980-790c-df25e82b3331@gmail.com>
 <CACsJy8D8a-0R=J6nCPwBAypYF=rejgT-3QFnuK1h3vMcJGG7_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8D8a-0R=J6nCPwBAypYF=rejgT-3QFnuK1h3vMcJGG7_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 09:26:28AM +0200, Duy Nguyen wrote:

> On Fri, Oct 26, 2018 at 4:09 PM Ben Peart <peartben@gmail.com> wrote:
> > I agree though I'm still curious if there are still no-threaded
> > platforms taking new versions of git.  Perhaps we should do the
> > depreciation warning you suggested elsewhere and see how much push back
> > we get.  It's unlikely we'd get lucky and be able to stop supporting
> > them completely but it's worth asking!
> 
> NO_PTHREADS can also be used even though the platform supports
> multithread: to make keep git execution in a single core/thread. It
> might matter on hosted systems with limited cpu power and you don't
> want git to hog it all. Yes it can also be achieved by setting a
> zillion config keys to "1", this way is just simpler.

Yeah, I wondered about that use case (also with your patches, and
whether they might run into problems on systems that _do_ have pthreads,
but just don't want to compile with them).

But I think that is pretty easily solved by just having a single runtime
option (e.g., to just pretend that oneline_cpus is always 1 by default).

-Peff
