Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D467D1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755954AbcIAVTO (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:19:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:36784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754505AbcIAVTM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:19:12 -0400
Received: (qmail 30476 invoked by uid 109); 1 Sep 2016 21:19:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Sep 2016 21:19:12 +0000
Received: (qmail 19446 invoked by uid 111); 1 Sep 2016 21:19:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Sep 2016 17:19:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2016 17:19:07 -0400
Date:   Thu, 1 Sep 2016 17:19:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Should "git symbolic-ref -d HEAD" be forbidden?
Message-ID: <20160901211907.iivokwu3yjuxz3qf@sigill.intra.peff.net>
References: <xmqqpoonuy4n.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpoonuy4n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 01, 2016 at 02:08:08PM -0700, Junio C Hamano wrote:

> I think we should.
> 
> t1401 expects to be able to, but if you really do it:
> 
> 	$ cd /tmp
> 	$ git init throwaway
>         $ cd throwaway
>         $ git symbolic-ref -d HEAD
> 
> the setup machinery considers that you are no longer in a working
> tree that is controlled by a repository at .git/ because .git/ is
> no longer a valid repository, so you cannot even do
> 
> 	$ git symbolic-ref HEAD refs/heads/master
> 
> to recover.

Yes, I think we should, too. The same reasoning from afe5d3d (symbolic
ref: refuse non-ref targets in HEAD, 2009-01-29) applies.

-Peff
