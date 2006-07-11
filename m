From: Shawn Pearce <spearce@spearce.org>
Subject: Reflog support status
Date: Tue, 11 Jul 2006 02:34:35 -0400
Message-ID: <20060711063435.GD11822@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 11 08:34:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0BpU-0002sI-0p
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 08:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWGKGel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 02:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWGKGel
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 02:34:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:64963 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965072AbWGKGek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 02:34:40 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G0BpN-0007jT-Vs
	for git@vger.kernel.org; Tue, 11 Jul 2006 02:34:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7A24820E43C; Tue, 11 Jul 2006 02:34:35 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23691>

My recent flurry of patches tonight (looks to be 5 total, 6
counting the user.name/user.email bug fix) should now include
reasonably useful information messages anytime a ref which has an
associated reflog gets updated, unless the update was made by one
of the following:

	git-archimport
	git-cvsimport
	git-svnimport
	git-receive-pack

Which is pretty reasonable.

I'll try to tackle git-receive-pack tomorrow night, but the reason
I have been putting it off is it would die a horrible death (exit
anyway) if it attempts to update a logged ref and GIT_COMMITTER_IDENT
can't be determined.  But if the repository owner has enabled
reflogging exiting is probably the right thing to do in that case...

I'd also like to parameterize git-am's reflog entries the way I
did with git-merge, this way git-rebase will report as 'rebase'
in the log rather than 'am'.  Again, I'll see if I can get that
done tomorrow night.

Junio: do you happen to still have that reflog program you put
together?  I'm wondering if maybe we shouldn't include a git-reflog
to cat the reflog file in a more human friendly format than the
timestamps contained within the file, not to mention maybe also do
oneline commit pretty printing.

-- 
Shawn.
