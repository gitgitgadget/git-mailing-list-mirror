X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH qgit] Change also tag marks when changing graph size
Date: Wed, 25 Oct 2006 04:20:12 +0200
Message-ID: <200610250420.12324.Josef.Weidendorfer@gmx.de>
References: <e5bfff550610240947i30bc3fc0x49710e4cbb0f0556@mail.gmail.com> <200610242041.22230.Josef.Weidendorfer@gmx.de> <e5bfff550610241245r73b594ftf2cd39f4194b5411@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 02:20:24 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <e5bfff550610241245r73b594ftf2cd39f4194b5411@mail.gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30027>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcYNQ-0005uw-5I for gcvg-git@gmane.org; Wed, 25 Oct
 2006 04:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422882AbWJYCUR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 22:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422880AbWJYCUQ
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 22:20:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:53194 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1422877AbWJYCUP (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 22:20:15 -0400
Received: (qmail invoked by alias); 25 Oct 2006 02:20:13 -0000
Received: from p5496B314.dip0.t-ipconnect.de (EHLO noname) [84.150.179.20] by
 mail.gmx.net (mp006) with SMTP; 25 Oct 2006 04:20:13 +0200
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

On Tuesday 24 October 2006 21:45, Marco Costalba wrote:
> Quoting from your last e-mail:
> "The new painting code regroups the drawing commands in
> multiple switch-statements to prepare for far simpler code
> with booleans for different elements, and not one type only."
> 
> Indeed it's not clear to me what the above line means exactly, it just
> smells like there is something more cooking.

Ah, yes ;-)

Currently, the drawing code knows how a full part of the graph
should be drawn, with circle, rects, lines.
Now, with direct drawing, this "knowledge" can be moved to graph
layout time, which can generate info whether a circle or rect should
be drawn. Making drawing a little bit faster, and simpler.

I am not sure if it is worth it, but this way, the drawing code could
be the same e.g. for different graph drawing algorithms (like gitk).

> > Now that everything is drawn directly, the question is what to do with
> > the new flexibility. E.g. we _could_ implement different
> > graph drawing algorithms next to the original qgit one,
> > e.g. mimicking gitk.
> 
> One little secret of current algorithm is that it just needs to know
> the "state" of previous revision graph to calculate the next one. (see
> Git::updateLanes() and lanes.cpp), it's a kind of a "rasterized" graph
> drawing, i.e. line by line.
> 
> I didn't studied gitk in deep but it seems a little bit less simpler.
> Anyway if you are interested it's for sure worth trying ;-)

I will have a look.

Current qgit layout gets really extremely wide e.g. with the kernel.

Some ideas:
* Put lanes to the right if possible
* If a branch has no commit for more than e.g. 50 entries, it's better to
draw an arrow and get rid of the lane at all.
By clicking on an arrow head, we could rearrange the commit ordering
a little bit so that commits on the given branch move in a way that
we always see the context on this branch.
* Collapsing parts of the graph into mega-commits, e.g.
 - straight commit lines
 - short topic branches forking from and merging into a branch

Josef

> 
>   Marco
> 
