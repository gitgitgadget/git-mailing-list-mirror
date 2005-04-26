From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Tue, 26 Apr 2005 14:25:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261408460.18901@ppc970.osdl.org>
References: <Pine.LNX.4.44.0504261301520.4678-100000@wax.eds.org>
 <Pine.LNX.4.58.0504261347520.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 23:19:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQXRQ-00022n-Ht
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 23:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVDZVXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 17:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVDZVXM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 17:23:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261793AbVDZVXG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 17:23:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QLN4s4027668
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 14:23:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QLN355009948;
	Tue, 26 Apr 2005 14:23:03 -0700
To: Bram Cohen <bram@bitconjurer.org>
In-Reply-To: <Pine.LNX.4.58.0504261347520.18901@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Linus Torvalds wrote:
> 
> > What I'd really like to hear is some explanation of why git is
> > reimplementing all of this stuff from scratch.
> 
> Git does in ~5000 lines and two weeks of work what _I_ think is the right 
> thing to do. You're welcome to disagree, but the fact is, people have 
> whined and moaned about my use of BK FOR THREE YEARS without showing me 
> any better alternatives.

Btw, I've also been pretty disgusted by SCM's apparently generally caring 
about stuff that is totally not relevant.

For example, it seems like most SCM people think that merging is about
getting the end result of two conflicting patches right.

In my opinion, that's the _least_ important part of a merge. Maybe the 
kernel is very unusual in this, but basically true _conflicts_ are not 
only rare, but they tend to be things you want a human to look at 
regardless.

The important part of a merge is not how it handles conflicts (which need
to be verified by a human anyway if they are at all interesting), but that
it should meld the history together right so that you have a new solid
base for future merges.

In other words, the important part is the _trivial_ part: the naming of
the parents, and keeping track of their relationship. Not the clashes.

For example, CVS gets this part totally wrong. Sure, it can merge the 
contents, but it totally ignores the important part, so once you've done a 
merge, you're pretty much up shit creek wrt any subsequent merges in any 
other direction. All the other CVS problems pale in comparison. Renames? 
Just a detail.

And it looks like 99% of SCM people seem to think that the solution to 
that is to be more clever about content merges. Which misses the point 
entirely.

Don't get me wrong: content merges are nice, but they are _gravy_. They
are not important. You can do them manually if you have to. What's
important is that once you _have_ done them (manually or automatically),
the system had better be able to go on, knowing that they've been done.

		Linus
