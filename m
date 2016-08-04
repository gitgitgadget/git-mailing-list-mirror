Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C70720191
	for <e@80x24.org>; Thu,  4 Aug 2016 02:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbcHDCxc (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 22:53:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:54541 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750775AbcHDCxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 22:53:31 -0400
Received: (qmail 32420 invoked by uid 102); 4 Aug 2016 02:46:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 22:46:50 -0400
Received: (qmail 9514 invoked by uid 107); 4 Aug 2016 02:47:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 22:47:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 22:46:46 -0400
Date:	Wed, 3 Aug 2016 22:46:46 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: What's cooking (interim report)
Message-ID: <20160804024645.vtjf5jwlz6pfz3lr@sigill.intra.peff.net>
References: <xmqqd1lp78r7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1lp78r7.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 04:06:20PM -0700, Junio C Hamano wrote:

> * jk/parseopt-string-list (2016-08-03) 1 commit
>  - blame: drop strdup of string literal
> 
>  A recent API change to parse_opt_string_list() introduced a small
>  unintended memory leak in the command line parsing of "git blame",
>  which has been plugged.
> 
>  Will merge to 'next'.

Actually, the leak was always there. It's just that
parse_opt_string_list used to leak _too_, and it was fixed, but this
case left behind.

Not that it matters too much. I doubt this one is exciting enough to
make it into the release notes. :)

> * jk/pack-objects-optim-mru (2016-07-29) 1 commit
>  - pack-objects: use mru list when iterating over packs
>  (this branch uses jk/pack-objects-optim.)
> 
>  This is still questionable in that it can attempt to create a cycle
>  in delta-chain, only to be stopped by the last-ditch recovery logic
>  in there.

I've been doing some thinking and experimenting on this. I'll try to
write up the current status tonight.

-Peff
