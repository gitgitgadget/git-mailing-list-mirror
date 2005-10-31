From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 11:50:10 -0800
Message-ID: <20051031195010.GM11488@ca-server1.us.oracle.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 20:51:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWffn-0000yv-Ph
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 20:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVJaTuY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 14:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbVJaTuY
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 14:50:24 -0500
Received: from rgminet04.oracle.com ([148.87.122.33]:58833 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S964813AbVJaTuX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 14:50:23 -0500
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet04.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id j9VJoBta029110;
	Mon, 31 Oct 2005 12:50:11 -0700
Received: from rgmsgw01.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j9VJoB3Z010613;
	Mon, 31 Oct 2005 12:50:11 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j9VJoABL010602
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 12:50:10 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.53)
	id 1EWffW-0004tB-Cb; Mon, 31 Oct 2005 11:50:10 -0800
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10878>

On Mon, Oct 31, 2005 at 08:18:49AM -0800, Linus Torvalds wrote:
> With git (or with BK, or any truly decentralized model), you just make 
> your own repo, do your development there, and you never need to ask for 
> permissions from the central repo people. If the development works out, 
> you just ask people to merge back. And if it doesn't, you don't even have 
> to tell people what a total failure you were.

	Actually, Linus, this provokes a question I've always wanted the
answer to.  I'm well aware of the centralized/distributed stuff you are
discussing, but there is policy regarding the distributed merges I've
never been quite clear on.
	When one does a feature branch, one creates a "throw-away"
repository.  They work on the feature, and when they are done, they
pull/push back to the main repository.  This pattern is pretty much
identical in both centralized in distributed environments, even if the
nuts-and-bolts are different.
	In the CVS/Subversion world, this merge becomes a single commit
on the "main" line of development ("trunk", or whatever you call it).
The merge has no concept of the steps taken to create the change, just
the actual patch.  This has the disadvantage that you have to work hard
in the branch namespace to find the actual steps taken (the working
repository for the feature), but the advantage that a quick look does
not have to wade through fits and starts as the feature takes shape.
	In the distributed world, a pull of the "feature" repository
pulls in all changes - the full history of the work.  This includes
aborted tries, rewritten pieces, bug fixes, etc.  Here, the main
repository has the detritus of the development process, but that also
contains the full context of the work.  It goes against your claim that:

> So with the distributed model, you don't have to publicly humiliate 
> yourself when you do something stupid. Similarly, you don't have to 

because that history will contain all your something stupids, plus your
fixes for them.
	But that's not how the kernel and git appear to work.  Many
developers have popularized dropping that context.  They take their
working repository, diff it against your mainline repository, and then
create a new repository that is merely your mainline plus one commit,
the patch of their changes.
	This violently breaks the model of "work in a new repository,
then have it pulled into the 'main' repository."  It has no real support
in the git/cogito command space (that I know of).  It does, however,
leave all the intermediate commits out of your tree, with only a feature
commit remaining.
	Where do you stand on this?  Would you rather see the full
history pulled?  Do you prefer the one-clean-patch approach?  If so, is
there any way to get a cogito/git command for it (git-pull-as-one?)?

Joel

-- 

"Drake!  We're LEAVING!"

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
