From: Eric Wong <normalperson@yhbt.net>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 15:00:50 -0800
Message-ID: <20070129230050.GA15492@localdomain>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <45BB9C8B.8020907@fs.ei.tum.de> <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org> <204011cb0701271136m655815f6o1501de2bf699b362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Lee <clee@kde.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:01:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBfUe-0001w6-9p
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbXA2XAx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbXA2XAx
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:00:53 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47628 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623AbXA2XAw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:00:52 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 0A63F7DC094;
	Mon, 29 Jan 2007 15:00:51 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 29 Jan 2007 15:00:50 -0800
Content-Disposition: inline
In-Reply-To: <204011cb0701271136m655815f6o1501de2bf699b362@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38103>

Chris Lee <clee@kde.org> wrote:
> Also, please note, the 3GB packed repo is only about 2/3 of the full
> KDE repo - I cut off the import at revision 409202, because that was
> when the KDE svn admins decided to move a bunch of modules from
> /trunk/ to /trunk/KDE/ and it screws up everything. So a *full* KDE
> history import would definitely be more than 4GB, packed.

Hmm.. This movement from /trunk to /trunk/KDE could be a good case
for the (still-improving) --follow-parent feature in git-svn.

I've resigned to the fact that git-svn (and git) is not ideal for
tracking the entire KDE repository.   I don't think most (sane)
developers check out the entire repository root when working on KDE,
and cloning a 3GB pack just isn't realistic these days.

But if splitting the monster repository into separate repositories is an
option for KDE, and I can make --follow-parent do what it's supposed to
do very well: then it could be a nice way to make things more manageable
for developers that will eventually switch to.

For tracking the trunk of kde-common, I'm running with my
work-in-progress version of git-svn:

git-svn init -i kde-common svn://anonsvn.kde.org/home/kde/trunk/KDE/kde-common
git-svn fetch -i kde-common --follow-parent

It seems to be following kde-common into pre-409202 revisions (down to
r11472) pretty well.  I'll upload the result to git.bogomips.org when
I'm done.

You can get my latest git-svn here: git://git.bogomips.org/git-svn
Note: I've not used this to dcommit for serious work, so I can't tell
if it's really useful.  But fetching seems fine.

The current --follow-parent implementation does not handle some cases
very well.  I would like to get it to correctly track parents analogous
to the way gitk was merged into git, so that subprojects merged into
a bigger project are currently ignored.

Junio: there are some huge changes; so please don't merge it into master
yet, I don't feel it's ready yet, but it should be sometime in the next
week.  I would like to see this in 1.5.0, but only if it's not horribly
broken (especially w.r.t committing).

-- 
Eric Wong
