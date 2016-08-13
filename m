Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E40720193
	for <e@80x24.org>; Sat, 13 Aug 2016 09:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbcHMJEe (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 05:04:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38134 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbcHMJEd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 05:04:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B7D20193;
	Sat, 13 Aug 2016 09:04:32 +0000 (UTC)
Date:	Sat, 13 Aug 2016 09:04:32 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer
Message-ID: <20160813090432.GA25565@starla>
References: <xmqq1t1twymf.fsf@gitster.mtv.corp.google.com>
 <20160812224255.GA16250@dcvr>
 <20160813081012.p46i4jcvkkfqch7m@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160813081012.p46i4jcvkkfqch7m@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Fri, Aug 12, 2016 at 10:42:55PM +0000, Eric Wong wrote:
> > Junio C Hamano <gitster@pobox.com> wrote:
> > > is still available.  An alternative
> > > 
> > >         nntp://news.public-inbox.org/inbox.comp.version-control.git
> > > 
> > > will become usable once it catches up with old messages.
> > 
> > Mostly caught up, I injected 33 more today which were
> > cross-posted (which tripped up some of my anti-spam rules) or
> > simply missed by gmane.
> > 
> > There may be more in some personal archives gmane doesn't
> > have...
> 
> Is there an easy way to get _just_ the list of message-ids you are
> storing (I know I can download the whole archive, but it's big)?

XHDR (or HDR) over NNTP should do it (that's how I checked
against gmane):
--------8<-----
use Net::NNTP;
my $nntp = Net::NNTP->new($ENV{NNTPSERVER} || 'news.public-inbox.org');
my ($num, $first, $last) = $nntp->group('inbox.comp.version-control.git');
my $batch = 10000;
my $i;
for ($i = $first; $i < $last; $i += $batch) {
	my $j = $i + $batch - 1;
	$j = $last if $j > $last;
	my $num2mid = $nntp->xhdr('Message-ID', "$i-$j");
	for my $n ($i..$j) {
		defined(my $mid = $num2mid->{$n}) or next;
		print "$mid\n";
	}
}

# and I forgot to optimize XHDR/HDR further in public-inbox-nntpd.
# Oh well, it seems to work, at least.

> Then I can cross-reference with my archive. I doubt I'll have anything
> significant that you don't. My archive of the early days was pulled from
> gmane, though I have been collecting steadily via mailing list delivery
> since 2007 or so.

What's odd is there's some messages with two Message-ID fields
from gmane from the old days, too.  I'll dig a bit another time.
