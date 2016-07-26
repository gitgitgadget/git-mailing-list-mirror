Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A1D7203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbcGZUAd (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:00:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:49443 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753176AbcGZUAb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:00:31 -0400
Received: (qmail 9230 invoked by uid 102); 26 Jul 2016 20:00:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 16:00:31 -0400
Received: (qmail 10375 invoked by uid 107); 26 Jul 2016 20:00:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 16:00:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jul 2016 16:00:28 -0400
Date:	Tue, 26 Jul 2016 16:00:28 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	larsxschneider@gmail.com, git@vger.kernel.org, tboegi@web.de
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
Message-ID: <20160726200028.GA21194@sigill.intra.peff.net>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
 <5792B622.5040306@gmail.com>
 <20160723072721.GA20875@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160723072721.GA20875@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 23, 2016 at 07:27:21AM +0000, Eric Wong wrote:

> Jakub Narębski <jnareb@gmail.com> wrote:
> > W dniu 2016-07-22 o 17:49, larsxschneider@gmail.com pisze:
> > > +use strict;
> > > +use warnings;
> > > +use autodie;
> > 
> > autodie?
> 
> "set -e" for Perl (man autodie)
> 
> It's been a part of Perl for ages, but I've never used it
> myself, either; I suppose it's fine for tests...

autodie has been around for a long time, but it only became part of the
perl core in v5.10.1 (according to Module::CoreList). I think the code
in perl/ requires only 5.8, but whenever we unconditionally use perl
without respect to NO_PERL (like in the test scripts), we usually shoot
for even antique versions of perl like 5.005.

So by those rules, we should avoid "autodie" here, though I wouldn't be
surprised if it takes a while for people to complain in practice (most
modern systems will have a recent enough perl, but it seems we go
through cycles where every few years somebody posts a bunch of patches
for ancient versions of IRIX or some other platform, cleaning up all of
these sorts of portability problems).

-Peff
