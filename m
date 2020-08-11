Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7B3C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 06:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4634120756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 06:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHKGRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:17:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48884 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgHKGRa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 02:17:30 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BD85C1F66E;
        Tue, 11 Aug 2020 06:17:29 +0000 (UTC)
Date:   Tue, 11 Aug 2020 06:17:29 +0000
From:   Eric Wong <e@80x24.org>
To:     Emma Brooks <me@pluvano.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
Message-ID: <20200811061729.GA7134@dcvr>
References: <20200808213457.13116-1-me@pluvano.com>
 <20200809230436.2152-1-me@pluvano.com>
 <20200810100249.GC37030@coredump.intra.peff.net>
 <20200811041728.GA1748@pluvano.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200811041728.GA1748@pluvano.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emma Brooks <me@pluvano.com> wrote:
> On 2020-08-10 06:02:49-0400, Jeff King wrote:
> > There was a little discussion in response to v1 on whether we could
> > reuse the existing C mailmap code:
> > 
> >   https://lore.kernel.org/git/20200731010129.GD240563@coredump.intra.peff.net/
> > 
> > Did you have any thoughts on that?
> 
> I think it's probably not worth the effort to make the necessary changes
> to "rev-list --header" Junio mentioned, just for gitweb.
> 
> I agree it's a bit worrisome to have a second parser that could
> potentially behave slightly differently than the main implementation.

+Cc Joe Perches

Fwiw, there's already a GPL-2.0 Perl .mailmap parser in
scripts/get_maintainer.pl of the Linux kernel which Joe
maintains:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/get_maintainer.pl

Been thinking about adding mailmap support to public-inbox in
the send-email reply instructions, too.  (but public-inbox is
AGPL-3+, so I can't steal the code w/o permission)

> What if we added tests for gitweb's mailmap parsing based on the same
> cases used for Git itself?

That's probably fine IMHO; especially if it's just for gitweb display
(and not writing anything that's meant to be stored forever).

There's already dozens of different parsers for email addresses,
MIME, mailbox formats, etc. all with slightly different edge cases;
things still mostly work well enough to not be a huge problem.
(Same goes for Markdown, HTML, formats and even JSON :x)
