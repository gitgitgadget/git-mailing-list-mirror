From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: LCA06 Cogito/GIT workshop - (Re: git-whatchanged: exit out early on errors)
Date: Sun, 29 Jan 2006 11:12:25 +0100
Message-ID: <20060129101225.GA4815@c165.ib.student.liu.se>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <Pine.LNX.4.64.0601280047240.2909@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>, keithp@keithp.com
X-From: git-owner@vger.kernel.org Sun Jan 29 11:12:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F39Y5-0005u0-Cz
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 11:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWA2KMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 05:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWA2KMh
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 05:12:37 -0500
Received: from [85.8.31.11] ([85.8.31.11]:39069 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750832AbWA2KMg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 05:12:36 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 9D20F40FF; Sun, 29 Jan 2006 11:25:40 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F39Xl-0001ZN-00; Sun, 29 Jan 2006 11:12:25 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601280047240.2909@evo.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15211>

On Sat, Jan 28, 2006 at 12:53:31AM -0500, Linus Torvalds wrote:
> 
> 
> On Sat, 28 Jan 2006, Martin Langhoff wrote:
> > 
> > BTW, have you still got that patch to git-merge to seed the commit msg
> > with conflicted files? ;-)
> 
> Nope. But it was something like the appended (totally untested, and 
> slightly improved).
> 
> The point being that we'd fill in a template that the committer will 
> hopefully edit to explain what he did to fix up the merge for each file 
> that had conflicts.
> 


Would it make sense to add an optional

   mergeresult <tree>

line to merge commit objects? Here <tree> is supposed to be a SHA1 of
the tree object which corresponds to the result of the automatic part
of a merge. Hence, for a given merge commit which had conflicts
"git-diff-tree <commit SHA1> <mergeresult SHA1>" would give a diff
which shows the changes that was applied to resolve the conflict.

When the recursive merge strategy is used we actually write the
'mergeresult' tree object to the object database, so this thing should
be straight forward to implement in that case. If there is interest it
could be implemented for the resolve strategy too.

I think those mergeresult lines might be useful when implementing
git-annotate across merges too. It makes it easy to distinguish
changes which came from the merged branches and changes introduced in
the merge itself.

It would not be backwards compatible with the current git though...

- Fredrik
