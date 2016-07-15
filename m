Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0223520195
	for <e@80x24.org>; Fri, 15 Jul 2016 13:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbcGONcN (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 09:32:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:45439 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751625AbcGONcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 09:32:12 -0400
Received: (qmail 26058 invoked by uid 102); 15 Jul 2016 13:32:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 09:32:11 -0400
Received: (qmail 15821 invoked by uid 107); 15 Jul 2016 13:32:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 09:32:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 09:32:08 -0400
Date:	Fri, 15 Jul 2016 09:32:08 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Turner <novalis@novalis.org>,
	Ben Peart <peartben@gmail.com>, Joey Hess <joey@kitenet.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	David Turner <dturner@twopensource.com>
Subject: Re: Plugin mechanism(s) for Git?
Message-ID: <20160715133208.GA22711@sigill.intra.peff.net>
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
 <20160715121838.GA21968@sigill.intra.peff.net>
 <CACBZZX4TA0Ljf2aNZtZ5Sj8fFj-vhoLKq5RP5YbKSS9o9Ljg+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4TA0Ljf2aNZtZ5Sj8fFj-vhoLKq5RP5YbKSS9o9Ljg+A@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 02:46:28PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Fri, Jul 15, 2016 at 2:18 PM, Jeff King <peff@peff.net> wrote:
> > Some features, like the index-helper, aren't quite so easy. One reason
> > is that its data needs to persist as a cache between multiple git
> > invocations. In general, I think it would be nice to solve that by
> > communicating via on-disk files, rather than a running daemon (just
> > because it has fewer moving parts). But that's only half of it for
> > index-helper. It needs to monitor inotify while git isn't running at
> > all; so it really _does_ need some kind of long-running daemon.
> 
> This *may* have changed in the recent versions of the series, but I'm
> fairly sure and for what it's worth to this discussion, that's not
> what the index-helper does. It's there to keep the index file in
> memory instead of reading it from disk.
> 
> It can *also* if you "git update-index --watchman" spawn a watchman
> daemon in the background, which is the thing that'll be doing the
> inotify calls and needs to stay persistent, the index-helper then
> communicates with the watchman daemon "what changed since X?" to
> compute a new index when requested.

Ah, yeah, you're right. Sorry for the confusion; I haven't actually
followed the topic all that closely.

-Peff
