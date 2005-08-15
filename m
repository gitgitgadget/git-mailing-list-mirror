From: Matt Draisey <mattdraisey@sympatico.ca>
Subject: Re: symlinked directories in refs are now unreachable
Date: Mon, 15 Aug 2005 05:01:15 -0400
Message-ID: <1124096475.749.64.camel@della.draisey.ca>
References: <1124073677.27393.15.camel@della.draisey.ca>
	 <7v64u7941c.fsf@assigned-by-dhcp.cox.net>
	 <1124089116.749.39.camel@della.draisey.ca>
	 <7v1x4v4pfx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 11:04:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4atV-0006pl-1i
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 11:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVHOJEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 05:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVHOJEY
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 05:04:24 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:4760 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932280AbVHOJEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 05:04:23 -0400
Received: from Windsor-ppp121559.sympatico.ca ([216.209.168.44])
          by tomts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050815090419.DDLW26128.tomts5-srv.bellnexxia.net@Windsor-ppp121559.sympatico.ca>;
          Mon, 15 Aug 2005 05:04:19 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x4v4pfx.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-08-15 at 00:41 -0700, Junio C Hamano wrote:
> Matt Draisey <mattdraisey@sympatico.ca> writes:
> 
> > ...  My own programming efforts rarely exceed two or three files
> > per project, and don't justify there own .git/objects repository.
> > Still, a few projects do benefit from having their own commit history,
> 
> I am afraid I am not quite getting it.
> 
> You are interested in many projects that have outside upstream,
> and you typically modify only small portion of each of them,
> which is quite a typical behaviour for individual developers.
> For some reason you want to keep those repository "clean"
> without your own commit objects or changed objects only
> reachable from your commits.  Is it what is happening here?

No, all the projects are my own.  I am not a developer at all, merely a
hobbyist.  Upstream projects don't fit into this scheme.

> > I've only written a commit tool.  All the other git and cogito tools I
> > invoke from the outermost directory like so 
> >
> > $git-cat-file commit per/Minesweeper/master
> >
> > Symlinking still works here as expected.  The per directory is just
> > there so I don't stomp on the outermost namespace, the Minesweeper is a
> > symlink to the nested project's refs directory.
> 
> Hmm.  So you have two GIT managed trees, $D/matt and $D/Minesweeper,
> and a symlink between them like this.  Is that what is happening here?
> 
>   $D/matt/.git/refs/heads/per/Minesweeper -> $D/Minesweeper/.git/refs/heads
> 

No, they are nested

    $D/.git/refs/heads/per/Minesweeper -> $D/Minesweeper/.git/refs/heads

The outermost repository merely aggregates a bunch of small unrelated
projects that are not yet ready for an independent existence.  The idea
is to put everything under revision control in the hope that eventually
something useful falls out.

My commit tool walks up the chain towards root until it finds the
objects directory and does the appropriate thing.

> Of course 'git-cat-file commit per/Minesweeper/master' would
> work in "$D/matt" directory.  How do the set of paths recorded
> in the index file used in these repositories relate to each
> other?  Is $D/matt/ tracking the same set of files as the other
> repository tracks?  Is it meant to be a superset?  Subset?  More
> or less independent "private additions"?
> 
> There must be some advantage to this arrangement than the more
> typical arrangement I've seen people do, which is to have two
> branches in Minesweeper (that is the upstream, right?)
> repository, one "origin" and the other "master".  Upstream
> changes you fetch and pull into "origin" branch while you commit
> your changes to "master" branch.  I just do not yet see what
> that advantage is, and I strongly suspect because I misread your
> description and misunderstood the two repository arrangement you
> have and how they are used.
> 
> By the way, did you want to take this discussion private or was
> it by accident you did not CC: the list?
> 

No, I didn't want to take it private.  I just don't know how my email
programme works.  I also just discovered that Evolution's Forward As >
Redirect is really a bounce and not a forward at all (it doesn't change
the to: address)
