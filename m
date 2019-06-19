Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F731F462
	for <e@80x24.org>; Wed, 19 Jun 2019 19:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfFSTRL (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 15:17:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:44456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729988AbfFSTRL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 15:17:11 -0400
Received: (qmail 11887 invoked by uid 109); 19 Jun 2019 19:13:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 19:13:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8488 invoked by uid 111); 19 Jun 2019 19:18:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 15:18:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 15:17:09 -0400
Date:   Wed, 19 Jun 2019 15:17:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
Message-ID: <20190619191709.GF28145@sigill.intra.peff.net>
References: <20190619095858.30124-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 04:58:50PM +0700, Nguyễn Thái Ngọc Duy wrote:

> This is probably just my itch. Every time I have to do something with
> the index, I need to add a little bit code here, a little bit there to
> get a better "view" of the index.
> 
> This solves it for me. It allows me to see pretty much everything in the
> index (except really low detail stuff like pathname compression). It's
> readable by human, but also easy to parse if you need to do statistics
> and stuff. You could even do a "diff" between two indexes.
> 
> I'm not really sure if anybody else finds this useful. Because if not,
> I guess there's not much point trying to merge it to git.git just for a
> single user. Maintaining off tree is still a pain for me, but I think
> I can manage it.

I don't have any particular use for this, but I am all in favor of tools
that make it easier to access and analyze information kept in our
on-disk formats (some of this is available via --debug, I think, but
AFAIK most of the extension bits are not).

And I'd rather see something like JSON than inventing yet another ad-hoc
output format.

I think your warning in the manpage that this is for debugging is fine,
as it does not put us on the hook for maintaining the feature nor its
format forever. We might want to call it "--debug=json" or something,
though, in case we do want real stable json support later (though of
course we would be free to steal the option then, since we're making no
promises).

-Peff
