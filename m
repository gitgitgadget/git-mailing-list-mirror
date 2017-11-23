Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73B2202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 20:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbdKWUzF (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 15:55:05 -0500
Received: from ikke.info ([178.21.113.177]:47488 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753297AbdKWUzF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 15:55:05 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 685524400E0; Thu, 23 Nov 2017 21:55:03 +0100 (CET)
Date:   Thu, 23 Nov 2017 21:55:03 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Jeff King <peff@peff.net>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
Message-ID: <20171123205503.GE16418@alpha.vpn.ikke.info>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
 <20171121214552.GB16418@alpha.vpn.ikke.info>
 <20171123000346.GA8718@sigill>
 <alpine.LFD.2.21.1711230241260.11944@localhost.localdomain>
 <20171123135155.GA8231@sigill>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123135155.GA8231@sigill>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 08:51:55AM -0500, Jeff King wrote:
> On Thu, Nov 23, 2017 at 02:45:44AM -0500, Robert P. J. Day wrote:
> 
> > > It's pretty clear to me as it is, but maybe we can write it differently.
> > > Like:
> > >
> > >   Without a disambiguating `--`, Git makes a reasonable guess. If it
> > >   cannot guess (because your request is ambiguous), then it will error
> > >   out.
> > 
> >   ok, i'll give this another try, given that there are two independent
> > points to be made here:
> > 
> > 1) even without the "--", git can generally parse the command and do
> > the right thing (or do a *valid* thing, given its heuristics)
> > 
> > 2) occasionally, without the "--", the command is really and truly
> > ambiguous, at which point git will fail and tell you to disambiguate
> > 
> >   not the wording i will use, but can we agree that those are the two
> > points to be made here?
> 
> Yep, I think so.
> 
> -Peff

Just for completeness, as it is somewhat covered by point 1 already, but
there are cases where there is no real ambiguity but you are required to
add '--' to tell git that it should not look for the file in the working
tree:

  $ git show abc123 deleted_file.txt
  fatal: ambiguous argument 'deleted_file.txt':
  unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

There might be good reasons why this is, but I don't consider this to be
actually ambiguous: there is no branch called 'deleted_file.txt' and git
could know that the files exists in the mentioned commit, so it should
be pretty clear what is meant.

Might be worth documenting this.

Kevin
