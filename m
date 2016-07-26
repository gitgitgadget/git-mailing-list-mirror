Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64B04203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758413AbcGZUap (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:30:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:49498 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758406AbcGZUao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:30:44 -0400
Received: (qmail 10564 invoked by uid 102); 26 Jul 2016 20:30:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 16:30:44 -0400
Received: (qmail 10986 invoked by uid 107); 26 Jul 2016 20:31:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 16:31:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jul 2016 16:30:41 -0400
Date:	Tue, 26 Jul 2016 16:30:41 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Stephen Morton <stephen.c.morton@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
Message-ID: <20160726203041.GA4675@sigill.intra.peff.net>
References: <CAH8BJxGZW8eNQogksZ416sVaBkpQ78uYkV7FtN6wxGafzNwjAg@mail.gmail.com>
 <CAGZ79kaop1HB4tQAKxOcq8ZNEc+6VMPB1suwA9jra2BoXc27cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaop1HB4tQAKxOcq8ZNEc+6VMPB1suwA9jra2BoXc27cw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 01:18:55PM -0700, Stefan Beller wrote:

> > Would it be possible to expand the hint message to tell users to run
> > 'git cherry-pick --continue'
> 
> Instead of expanding I'd go for replacing?
> 
> I'd say the user is tempted for 2 choices,
> a) aborting (for various reasons)
> b) fix and continue.

Yeah, I'd agree with this.

I think that advice comes from a time when you could only cherry-pick a
single commit. These days you can do several in a single run, and that's
why "git cherry-pick --continue" was invented.

So I think we would need to make sure that the "cherry-pick --continue"
advice applies in both cases (and that we do not need to give different
advice depending on whether we are in a single or multiple cherry-pick).

I did some basic tests and it _seems_ to work to use --continue in
either case. Probably due to 093a309 (revert: allow cherry-pick
--continue to commit before resuming, 2011-12-10), but I didn't dig.

-Peff
