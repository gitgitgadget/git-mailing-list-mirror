From: Petr Baudis <pasky@suse.cz>
Subject: Re: is rebase the same as merging every commit?
Date: Fri, 27 Jun 2008 10:34:19 +0200
Message-ID: <20080627083419.GD12567@machine.or.cz>
References: <vpqfxqz5qzj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Jeske <jeske@willowmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 27 10:35:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC9QT-0005Vp-Uj
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 10:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbYF0Ie3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 04:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754808AbYF0Ie2
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 04:34:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59613 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559AbYF0Ie0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 04:34:26 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0EC4C393BAB8; Fri, 27 Jun 2008 10:34:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpqfxqz5qzj.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86533>

On Fri, Jun 27, 2008 at 08:30:56AM +0200, Matthieu Moy wrote:
> "David Jeske" <jeske@willowmail.com> writes:
> 
> > Rebasing is described in the docs I've read as turning this: (sorry for the
> > dots)
> >
> > ..........A---B---C topic
> > ........./
> > ....D---E---F---G master
> >
> > Into this:
> >
> > ...................A'--B'--C' topic
> > ................../
> > .....D---E---F---G master
> >
> > If I understand it right (and that's a BIG if), it's the same as doing a merge
> > of C into G where every individual commit in the C-line is individually
> > committed into the new C' line.
> >
> > ...........-------------A---B---C
> > ........../            /   /   /
> > ........./        /---A'--B'--C'  topic
> > ......../        /
> > ....D---E---F---G - master
> 
> I'd draw that the other way:
> 
>   ...........---------A---B---C
>   ........../          \   \   \
>   ........./        /---A'--B'--C'  topic
>   ......../        /
>   ....D---E---F---G - master
> 
> > (1) Is the above model a valid explanation?
> 
> Sounds correct to me.

I don't think you can call it correct since it assumes !(2) while (2)
holds. Drawing the diagram this way is misleading; merging commits
one-by-one implies preserving the merge information in the history
graph; nothing like that is done by rebase.

Rebase is more like _cherry-picking_ all the patches on your branch on
top of the upstream branch. You just essentially take each patch (commit
message + diff to parent) growing on top of upstream's E and recommit it
on top of G.

> > (2) From the documentation diagrams, it looks like the rebased A' has only (G)
> > as a parent, not (A,G). If this is the case, why?
..snip..
> > (i.e. not connecting those nodes throws away useful information)
> 
> For the use-cases where this information is useful, "rebase" is not
> for you. Indeed, in these cases, a plain "merge" is usually what you
> want.

Indeed, noone forces you into the rebase workflow for your own projects.
I personally never ever rebase (I do use StGIT though, but it records
per-patch history and makes sure I'm always in some consistent state).

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
