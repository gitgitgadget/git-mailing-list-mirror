Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197262018A
	for <e@80x24.org>; Mon, 27 Jun 2016 19:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbcF0Tfq (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 15:35:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:33642 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751639AbcF0Tfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 15:35:45 -0400
Received: (qmail 4300 invoked by uid 102); 27 Jun 2016 19:35:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:35:45 -0400
Received: (qmail 12707 invoked by uid 107); 27 Jun 2016 19:36:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:36:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 15:35:42 -0400
Date:	Mon, 27 Jun 2016 15:35:42 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/3] diff.c: add --relative-names to be used with
 --name-only
Message-ID: <20160627193542.GC10877@sigill.intra.peff.net>
References: <20160626171616.27948-1-pclouds@gmail.com>
 <20160626171616.27948-4-pclouds@gmail.com>
 <20160627192426.GA10877@sigill.intra.peff.net>
 <CACsJy8BYsPCLiEM2syrGUa_VOCHnR3W+sSiG3sNFme1L0Hx7XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8BYsPCLiEM2syrGUa_VOCHnR3W+sSiG3sNFme1L0Hx7XA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 09:33:18PM +0200, Duy Nguyen wrote:

> On Mon, Jun 27, 2016 at 9:24 PM, Jeff King <peff@peff.net> wrote:
> > On Sun, Jun 26, 2016 at 07:16:16PM +0200, Nguyễn Thái Ngọc Duy wrote:
> >
> >> The difference with --relative option is, this option does not filter
> >> paths outside cwd. You can add two more chars " ." on your command
> >> line for that.
> >
> > Another difference seems to be that it applies only to --name-only, and
> > not to other forms. I can see how "-p --relative-names" might be weird,
> > because you'll get:
> >
> >   diff --git a/../foo/bar b/../foo/bar
> >
> > or something. But surely things like --name-status would want to support
> > it?
> 
> That's my plan :) Anything that does not start with a/ or b/ should
> respect this new option.

I guess it seems a bit unfortunate that:

  git log -p --relative-names .

would not be equivalent to:

  git log -p --relative

I am not entirely convinced that "a/../Documentation/git.txt" is that
unreasonable. Sure, it looks weird, and probably nobody will be able to
apply the patch. But it is what the user asked for.

-Peff
