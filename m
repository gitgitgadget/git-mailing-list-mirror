From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Fri, 18 Nov 2005 00:07:23 +0100
Message-ID: <20051117230723.GD26122@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 00:08:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecspq-00056U-Hg
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 00:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVKQXGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 18:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVKQXGE
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 18:06:04 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:58568 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S964916AbVKQXGD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 18:06:03 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8131A5E2DE;
	Fri, 18 Nov 2005 00:06:02 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1Ecsqh-0006xm-Qm; Fri, 18 Nov 2005 00:07:23 +0100
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12168>

Ryan wrote:
> Junio wrote:
> > Also another rhetorical, tongue-in-cheek question.  What is your
> > plan to ripple the graft through to update signed tags?  ;-)
> 
> :) Well, since I can't resist answering your rhetorical question:
> 
> They signed a specific DAG.  I'm providing a richer, more complete DAG
> that is a pure-superset of the one they signed.  It is not, however,
> equivalent, so their signature is not related to the superset DAG I have
> created.  In practice, however, I don't expect that any tag-signers
> would state that there is a meaningful difference between the two DAGs,
> from the perspective of their signature.

Well, that seems the perfect place to mention an idea that's running
in my head since a couple of days, related to the grafing problem.
I'll write it here in case the idea would look interesting to others,
who may then find a solution to the problem stated by Junio.

Current commit objects refer to a child tree, but to parent _commits_.
Whereas it seems necessary to walk through the history line, and
easily get a changelog, it is semantically quite not right: the
changes we record with a commit indeed come from modification of
trees, not of commits.  That is, the resulting tree does not depend on
the history of the parent trees, but on the parent trees themselves.
And similarly, tags usually denote a particular state of the tree,
"somewhat" independantly of its history: linux-2.6.11 is the same
beast, whereas the repository holds full history since 0.1 or not.

Indeed that emphasizes that the history lines are on living on a
higher level of abstraction that commits.  Now what if we used
trees->tree commits, instead of the current commits->tree ones ?  The
main problem would be to be able to reconstruct those history lines,
so that we can still extract the log - what's a better model if we
loose functionnality ? ;)

However, I must admit that at this point, I have not found a
reasonable solution to this problem.

Any genius with a solution out there ? :)
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
