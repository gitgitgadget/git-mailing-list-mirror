Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8371B20372
	for <e@80x24.org>; Mon,  9 Oct 2017 17:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755372AbdJIRwc (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 13:52:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:47302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755370AbdJIRw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 13:52:28 -0400
Received: (qmail 25718 invoked by uid 109); 9 Oct 2017 17:46:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 17:46:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18825 invoked by uid 111); 9 Oct 2017 17:52:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 13:52:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Oct 2017 13:52:26 -0400
Date:   Mon, 9 Oct 2017 13:52:26 -0400
From:   Jeff King <peff@peff.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
Message-ID: <20171009175225.qn6a3j2th3dxjjn2@sigill.intra.peff.net>
References: <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
 <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
 <1507412674.8322.4.camel@mad-scientist.net>
 <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
 <1507473160.8322.12.camel@mad-scientist.net>
 <20171008184046.uj7gcutddli54ic3@thunk.org>
 <alpine.LFD.2.21.1710081536180.28646@localhost.localdomain>
 <20171008204227.f6wgaobosa6yn62g@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171008204227.f6wgaobosa6yn62g@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2017 at 04:42:27PM -0400, Theodore Ts'o wrote:

> On Sun, Oct 08, 2017 at 03:44:14PM -0400, Robert P. J. Day wrote:
> > >
> > >     find <find args> | xargs git rm
> > >
> > > myself.
> > 
> >   that's what i would have normally used until i learned about git's
> > magical globbing capabilities, and i'm going to go back to using it,
> > because git's magical globbing capabilities now scare me.
> 
> Hmm, I wonder if the reason why git's magically globbing capabilities
> even exist at all is for those poor benighted souls on Windows, for
> which their shell (and associated utilities) doesn't have advanced
> tools like "find" and "xargs"....

One benefit of globbing with Git is that it restricts the matches only
to tracked files. That matters a lot when you have a very broad glob
(e.g., like you might use with "git grep") because it avoids looking at
cruft like generated files (or even inside .git).

-Peff
