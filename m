Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACDC0208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 07:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbdHTHrb (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 03:47:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:43828 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751607AbdHTHrb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 03:47:31 -0400
Received: (qmail 20910 invoked by uid 109); 20 Aug 2017 07:47:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 07:47:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12473 invoked by uid 111); 20 Aug 2017 07:47:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 03:47:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 03:47:28 -0400
Date:   Sun, 20 Aug 2017 03:47:28 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Carlsson, Magnus" <Magnus.Carlsson@arris.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git fetch with refspec does not include tags?
Message-ID: <20170820074728.4dawjlnaufjdf4j5@sigill.intra.peff.net>
References: <1502960406180.9006@arris.com>
 <1502960572292.1402@arris.com>
 <20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net>
 <xmqq1soagf1p.fsf@gitster.mtv.corp.google.com>
 <20170817202257.GC3839@alpha.vpn.ikke.info>
 <xmqqk222expv.fsf@gitster.mtv.corp.google.com>
 <20170817204312.GD3839@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170817204312.GD3839@alpha.vpn.ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 10:43:12PM +0200, Kevin Daudt wrote:

> > No, you are not misunderstanding anything.  The "pretend that we
> > immediately turned around and fetched" done by "git push" was
> > already breaking the predictability, but the change in 1.8.4 made it
> > even worse.  I am saying that going back to the old behaviour may be
> > one option to address the issue being discussed in this thread.
> 
> Ok. The reason I'm bring this up is because we often had to tell users
> in the irc channel that git fetch <remote> <branch> did not update the
> remote tracking branches, which confused them, so reverting back might
> reintroduce this confusion again.

Yeah, I don't think we want to go back to the original behavior. I agree
that it is partially to blame for the inconsistency that started this
thread, but I think on balance it has saved much more confusion than it
has started. And we can address that inconsistency with better tag rules
(like the "autofollow if we wrote any real refs" thing).

I don't have a patch for that yet, so if anybody feels like taking a
look, it would be much appreciated.

-Peff
