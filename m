Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C8B1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 17:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbeIRXLu (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 19:11:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:52306 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729037AbeIRXLu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 19:11:50 -0400
Received: (qmail 8078 invoked by uid 109); 18 Sep 2018 17:38:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Sep 2018 17:38:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9324 invoked by uid 111); 18 Sep 2018 17:38:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Sep 2018 13:38:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2018 13:38:10 -0400
Date:   Tue, 18 Sep 2018 13:38:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] doc/Makefile: drop doc-diff worktree and temporary
 files on "make clean"
Message-ID: <20180918173810.GF15470@sigill.intra.peff.net>
References: <20180830195546.GA22407@sigill.intra.peff.net>
 <20180831063318.33373-1-sunshine@sunshineco.com>
 <20180831063318.33373-4-sunshine@sunshineco.com>
 <20180917183258.GC140909@aiede.svl.corp.google.com>
 <xmqq36u77w7y.fsf@gitster-ct.c.googlers.com>
 <20180917194214.GG140909@aiede.svl.corp.google.com>
 <xmqqy3bz6h24.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3bz6h24.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 12:48:51PM -0700, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > I'd rather that we revert this change altogether.  I have nothing
> > against a convenient command to do this kind of non build related
> > cleanup, but it shouldn't be spelled as "make clean".
> 
> OK, let's do this for now as I wanted to merge the remainder to
> 'master' today.
> 
> -- >8 --
> Subject: Revert "doc/Makefile: drop doc-diff worktree and temporary files on "make clean""
> 
> This reverts commit 6f924265a0bf6efa677e9a684cebdde958e5ba06, which
> started to require that we have an executable git available in order
> to say "make clean", which gives us a chicken-and-egg problem.
> 
> Having to have Git installed, or be in a repository, in order to be
> able to run an optional "doc-diff" tool is fine.  Requiring either
> in order to run "make clean" is a different story.

Yeah, this seems like the best solution. We started with "can we just rm
-rf the temporary directory as part of 'make clean'", which is totally
sensible and matches the other bits there. But then it got more
complicated. :)

People who use doc-diff can still use "doc-diff --clean", so I don't
think much is lost.

Thanks.

-Peff
