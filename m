From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-feed-mail-list.sh
Date: Tue, 09 May 2006 00:32:24 -0700
Message-ID: <7v7j4v8xh3.fsf@assigned-by-dhcp.cox.net>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	<7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	<1147131877.2694.37.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
	<4fb292fa0605081755m22e8239cjda0b1ac74b84c0d9@mail.gmail.com>
	<7vac9sc8m3.fsf@assigned-by-dhcp.cox.net>
	<4fb292fa0605081809r6aa76baai5eac9823183fc3fc@mail.gmail.com>
	<7vwtcvc42s.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081951390.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 09 09:33:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdMiS-000379-2k
	for gcvg-git@gmane.org; Tue, 09 May 2006 09:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWEIHc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 03:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWEIHc1
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 03:32:27 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:246 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751450AbWEIHc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 03:32:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509073225.DJYN24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 03:32:25 -0400
To: Bertrand Jacquin <beber.mailing@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0605081951390.3718@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 8 May 2006 20:06:35 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19827>

Linus Torvalds <torvalds@osdl.org> writes:

> But if you want to get it for any random merges, you can always just do
>
> 	git log -11 --pretty=oneline ^$commit^ $commit^@ |
> 		sed 's/[0-9a-f]* // ; 11 s/.*/\.\.\./' 
>
> which will show up to the ten first commits that were merged (and turn the 
> eleventh one, if it exists, into "..." - that's a pretty disgusting trick 
> to make it show when you left things out).
>
> That "^$commit^ $commit^@" part is important. It may look like some 
> deranged git smiley, but it does exactly what you want it to do: take all 
> the parents of the commit, but ignore any commit reachable from the first 
> one (the "mainline" of the person who did the commit).
>
> The ^@ syntax is obviously pretty new, so it requires a modern git.

It is indeed very quite new.  Merged into "master" branch at the
beginning of this month.

I often wish we had a straightforward way to tell when a given
feature went into the mainline, not just appeared on a topic
branch.  In this case, I said:

	$ git whatchanged -p -S'"^@"' master -- revision.c

to find ea4a19 commit (Apr 30 00:54:29 2006 -0700).  But that
was when the feature was first made on one of my topic branches,
which is not what I was looking for.

By looking at gitk, I can then tell 83262e (May 1 01:54:27)
merged it to "next", and 746437 (May 1 22:55:40) merged it to
"master".

In general this is an unsolvable question, because I can have a
topic branch forked off of the tip of "master", cook it for a
few days without advancing "master" at all, and merge it to
"master" after that.  But such a merge will be a fast-forward.
