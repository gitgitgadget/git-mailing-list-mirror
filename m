From: Theodore Ts'o <tytso@thunk.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 06:22:24 -0400
Message-ID: <20050415102224.GA8924@thunk.org>
References: <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <1113556448.12012.269.camel@baythorne.infradead.org> <Pine.LNX.4.58.0504151340221.27162@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:21:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMRg5-0001Q1-8O
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 16:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVDOOXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 10:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVDOOXi
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 10:23:38 -0400
Received: from thunk.org ([69.25.196.29]:41682 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261673AbVDOOXf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 10:23:35 -0400
Received: from root (helo=thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 3.35 #1 (Debian))
	id 1DMRiZ-0008Sc-00; Fri, 15 Apr 2005 10:22:47 -0400
Received: from tytso by thunk.org with local (Exim 4.50)
	id 1DMNxw-0002Ks-AR; Fri, 15 Apr 2005 06:22:24 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504151340221.27162@wgmdd8.biozentrum.uni-wuerzburg.de>
>From: Theodore Ts'o <tytso@mit.edu>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2005 at 02:03:08PM +0200, Johannes Schindelin wrote:
> I disagree. In order to be trusted, this thing has to catch the following
> scenario:
> 
> Skywalker and Solo start from the same base. They commit quite a lot to
> their trees. In between, Skywalker commits a tree, where the function
> "kazoom()" has been added to the file "deathstar.c", but Solo also added
> this function, but to the file "moon.c". A file-based merge would have no
> problem merging each file, such that in the end, "kazoom()" is defined
> twice.
> 
> The same problems arise when one tries to merge line-wise, i.e. when for
> each line a (possibly different) merge-parent is sought.

Be careful.  There is a very big tradeoff between 100% perfections in
catching these sorts of errors, and usability.  There exists SCM's
where you are not allowed to do commit such merges until you do a test
compile, or run a regression test suite (that being the only way to
catch these sorts of problems when we merge two branches like this).  

BitKeeper never caught this sort of thing, and we trusted it.  In
practice it was also rarely a problem.

I'll also note that BitKeeper doesn't restrict you from doing a
committing a changeset when you have modified files that have yet to
be checked in to the tree.  Same issue; you can accidentally check in
changesets that in trees that won't build, but if we added this kind
of SCM-by-straightjacket philosophy it would decrease our productivity
and people would simply not use such an SCM, thus negating its
effectiveness.

						- Ted
