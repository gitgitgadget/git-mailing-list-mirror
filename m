From: Junio C Hamano <junkio@cox.net>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Fri, 23 Sep 2005 02:34:16 -0700
Message-ID: <7vslvwcelj.fsf@assigned-by-dhcp.cox.net>
References: <E1EIVsD-0001Hu-9m@jdl.com> <20050922191058.GM21019@pasky.or.cz>
	<34462.10.10.10.28.1127417134.squirrel@linux1>
	<20050923091012.GA10255@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 11:36:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIjwk-0007A4-QU
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 11:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVIWJeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 05:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVIWJeT
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 05:34:19 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:17083 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750846AbVIWJeS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 05:34:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050923093417.FMVM28168.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 05:34:17 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050923091012.GA10255@pasky.or.cz> (Petr Baudis's message of
	"Fri, 23 Sep 2005 11:10:12 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9172>

Petr Baudis <pasky@suse.cz> writes:

> 	* cg-fetch can do with symlinked object database

Do you mean ".git/object" in the repository you are fetching
into is a symlink to somewhere, or something else?

> 	* cg-fetch will hardlink if possible when fetching locally

True, git-fetch and git-clone try to use pack protocols by
default, which is debatable.  Adding -l (similar to what
git-clone does) would not be too hard, if enough people want
it.

> 	* cg-fetch won't do useless fetches when we are already
> 	  up-to-date

Care to explain?  Perhaps you are talking about rsync transport
(in which case I would not be surprised)?

> 	* I'm not sure if I could call git-fetch to do the initial
> 	  fetch during clone

    $ git-init-db && git fetch http://kernel.org/pub/scm/git/git.git

should work.

There is another minor "con", if you include git-clone in the
discussion.  Over http transport, it refuses to run against a
remote repository that does not have info/refs and info/packs,
even if it is not packed.  I think cg-clone uses recursive wget
for directory traversal and does not have to use them.
