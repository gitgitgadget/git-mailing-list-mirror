From: Theodore Tso <tytso@mit.edu>
Subject: A proposed solution (Was: nicer frontend to get rebased tree?)
Date: Sat, 23 Aug 2008 19:01:37 -0400
Message-ID: <20080823230137.GD18169@mit.edu>
References: <20080822174655.GP23334@one.firstfloor.org> <m37ia8sv49.fsf@localhost.localdomain> <20080823071552.GU23334@one.firstfloor.org> <200808231121.41694.jnareb@gmail.com> <20080823165350.GY23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 01:02:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX283-0000gk-PT
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 01:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbYHWXBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 19:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbYHWXBk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 19:01:40 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:39219 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754290AbYHWXBj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 19:01:39 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KX270-0006Bh-CP; Sat, 23 Aug 2008 19:01:38 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KX26z-0006tt-ON; Sat, 23 Aug 2008 19:01:37 -0400
Content-Disposition: inline
In-Reply-To: <20080823165350.GY23334@one.firstfloor.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93503>

Maybe what we need is a way in git to advertise that a particular
branch, when pulled into another repository, shouldn't be used as a
base for someone else to do development.  The only question is what
can we do other than give a warning if someone tries to create a local
branch which tracks such a branch.  One thought is to have a git
config option which will forbid creating local branches that track an
"rebase-unstable" branch, on the theory that the best thing to do with
such workloads is to either use them as sources for "git merge" or a
git checkout creating a detached HEAD. 

Once you've merged a rebase-unstable remote branch into a local
branch, the resulting local branch could be treated "contaminated"
such that if the user tries to do any commits on such a local branch,
git issues a warning that you are committing changes onto a branch
which should be considered throwaway.

I guess the real question is whether we should be encoding quite this
much policy into git.  I think it would help make it easier to
advertise what is considered the preferred workflow, and if it can all
be turned off with a git-config option, people who don't want it can
always turn it off.

What do folks think?

						- Ted
