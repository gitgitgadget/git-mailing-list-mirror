Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8F61F403
	for <e@80x24.org>; Mon, 11 Jun 2018 08:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932272AbeFKIfR (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 04:35:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:41172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932109AbeFKIfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 04:35:17 -0400
Received: (qmail 11260 invoked by uid 109); 11 Jun 2018 08:35:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 08:35:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14168 invoked by uid 111); 11 Jun 2018 08:35:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 04:35:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 04:35:15 -0400
Date:   Mon, 11 Jun 2018 04:35:15 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v3 0/2] .gitmodules fsck cleanups
Message-ID: <20180611083515.GA1815@sigill.intra.peff.net>
References: <20180609093028.GA8864@sigill.intra.peff.net>
 <20180609093118.GA8942@sigill.intra.peff.net>
 <20180609094613.17675-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180609094613.17675-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 11:46:13AM +0200, SZEDER Gábor wrote:

> I add few more lines of context here:
> 
>                 tree=$(
>                         {
>                                 printf "100644 blob $content\t$tricky\n" &&
> 
> >  				printf "120000 blob $target\t.gitmodules\n"
> >  			} | git mktree
> >  		) &&
> > -		commit=$(git commit-tree $tree) &&
> 
> This was the only case where that $tree variable was used, so perhaps
> that can go away as well, in the name of even more simplicity?

Yep, that is simpler. Here's a v3 just dropping those $tree variables,
and adjusting the commit message as appropriate.

  [1/2]: t7415: don't bother creating commit for symlink test
  [2/2]: fsck: avoid looking at NULL blob->object

 fsck.c                     |  3 ++-
 t/t7415-submodule-names.sh | 29 ++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)

-Peff
