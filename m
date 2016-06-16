Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408361FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 12:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbcFPMN7 (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 08:13:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:55614 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753846AbcFPMN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 08:13:58 -0400
Received: (qmail 16833 invoked by uid 102); 16 Jun 2016 12:13:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 08:13:58 -0400
Received: (qmail 15880 invoked by uid 107); 16 Jun 2016 12:14:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 08:14:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 08:13:54 -0400
Date:	Thu, 16 Jun 2016 08:13:54 -0400
From:	Jeff King <peff@peff.net>
To:	Saksham Saxena <saksham.saxena.1994@ieee.org>
Cc:	git@vger.kernel.org
Subject: Re: URL rewrite in local config unable to override global config rule
Message-ID: <20160616121353.GB15988@sigill.intra.peff.net>
References: <CABYP2JZU5wqxCK1B7b_fDB0Lqz4-7a_Erb5dHKReZHQecxC8QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABYP2JZU5wqxCK1B7b_fDB0Lqz4-7a_Erb5dHKReZHQecxC8QQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 03:44:17PM +0530, Saksham Saxena wrote:

> Summary : Added a new rule to the local config of a git repo by
> issuing ' git config --local url."https://".insteadOf git:// ', but it
> wasn't observed by git as it kept using "git://".

Hmm. This works in a simple example for me...

> Details : I had set my global config to use "git://" instead of
> "https://", as I prefer working with SSH.

..even if I have an existing "url.git://.insteadOf=https://". But I
could believe that having other config confuses things. The
url-rewriting is not "last one wins", but rather that we try all of
them, and the longest match wins.

Can you show us the output of "git config --list" on a repository that
is having this problem, and then the command that you run and its
output?

> Recently, I began writing a
> 'GitHub Wiki' of one of my GitHub projects, and, apparently, those
> Wikis are normal git repositories, and can be cloned and edited
> locally. However, the clone url available is served over HTTPS only,
> and doesn't support any other protocol.

You should be able to clone, fetch, or push wiki repositories using any
of the normal protocols. So:

  git@github.com:username/repo.wiki.git

should work. Likewise, git:// will work if the repository is public, but
you cannot push over it.

-Peff
