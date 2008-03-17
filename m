From: Petr Baudis <pasky@suse.cz>
Subject: Re: repo.or.cz renovated
Date: Mon, 17 Mar 2008 20:54:22 +0100
Message-ID: <20080317195422.GF10335@machine.or.cz>
References: <20080313231413.27966.3383.stgit@rover> <m3ve3nwtl3.fsf@localhost.localdomain> <20080317181015.GC10335@machine.or.cz> <20080317193423.GI8368@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:56:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbLQt-0004Ez-7Q
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 20:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380AbYCQTyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 15:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756012AbYCQTyZ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 15:54:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37987 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540AbYCQTyY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 15:54:24 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B0AC7393BEAC; Mon, 17 Mar 2008 20:54:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080317193423.GI8368@mit.edu>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77461>

On Mon, Mar 17, 2008 at 03:34:23PM -0400, Theodore Tso wrote:
> On Mon, Mar 17, 2008 at 07:10:15PM +0100, Petr Baudis wrote:
> > Actually, it was overwhelmed to so much by its success but by lack of
> > good maintenance. ;-) I gave it some love again for the past week and
> > the improvement was, well, overwhelming. :-)
> > 
> > I finally fixed tons of failures and broken repositories, and most
> > importantly repacked some of the big repositories with object databases
> > in pretty horrid shape. The effect has been immense, having everything
> > in database of 1/3 the size and single big pack drastically reduced the
> > I/O load.
> 
> Are you making sure that repositories which are forks off of some
> parent repository are using objects/info/alternates to share objects?
> (If so you have to be careful when you prune not to drop objects, but
> it can make a huge difference in disk utilization and I/O bandwidth).

Yes, I reuse objects from parent projects, that has always been so.

> At least for master.kernel.org, and for those git repositories which I
> own, I make a point of periodically logging in and running git gc,
> copying over the object packs so I can do a prune operation safely,
> etc.  --- and I suspect most of the master.kernel.org git users do
> something similar.  On repo.or.cz we don't have shell access, so the
> project administrators can't do that for you.
> 
> > So for anyone running a hosting site, make sure your repositories are
> > nicely packed. It makes huge difference to the I/O load!
> 
> It seems that a Really Good Idea would be do the the packing and
> pruning via cron scripts that run during the off hours...

Yes, this was done before too, however repo.or.cz has been around for
long time and historically the scripts weren't working very well,
especially since I had to be careful about the forks problem.

Since I am repacking on live system, I think the current repacking
strategy is still not completely error prone, however I believe that I
have encountered no breakage because of pruned objects the last at least
half a year or so it has been running with the current setup (all of the
breakages I have encountered seem to be caused by child process of
git-repack dying).  Besides, if some fork breaks, it should be possible
to fix that very easily (I do not backup the object stores at all
anyway - if the server burns down, you will have to re-push ;-).

> > My current plan is to have a [Search project] box at the front page,
> > together with direct link to 'show all'. Other than that, what makes
> > sense to display on the front page? I think recently added projects (age
> > < 1 week) for sure. I'm not so sure about recently changed projects -
> > maybe it is better to keep the front page cruft-free.
> 
> There are plenty of ways which sites like freshmeat and sourceforge
> have come up to make it easy to browse a large number of software
> projects.  One way that might make sense is Sourceforge's Software Map
> (i.e., http://sourceforge.net/softwaremap/).

This all feels like a real overkill, besides my main doubt is whether
repo.or.cz needs something like this *at all* - but I think I will try
the tagging system and see how do people like it.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
