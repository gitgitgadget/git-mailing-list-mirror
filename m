From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Sun, 20 Nov 2005 23:32:49 +0100
Message-ID: <20051120223249.GI3393@nowhere.earth>
References: <20051117230723.GD26122@nowhere.earth> <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de> <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth> <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de> <20051119170929.GF3393@nowhere.earth> <pan.2005.11.19.17.23.17.920228@smurf.noris.de> <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 23:31:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdxiS-0007Q4-6e
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 23:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVKTWbR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 17:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVKTWbR
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 17:31:17 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:51939 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932096AbVKTWbR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 17:31:17 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id A8F5B3FDAE;
	Sun, 20 Nov 2005 23:31:15 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1Edxjt-0004iQ-Ss; Sun, 20 Nov 2005 23:32:49 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12406>

On Sun, Nov 20, 2005 at 02:24:53AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 19 Nov 2005, Matthias Urlichs wrote:
> 
> > [...] What can you do with such a thing that you cannot do now, just as 
> > easily, besides slow down your programs with an unnecessary level of 
> > indirection?
> 
> I tend to agree. In fact, if I would like to introduce earlier history 
> (for the sake of archeology or whatever), I would import the earlier 
> history into git, possibly finding the best match in the current 
> development branch (for example, when the original project continued for a 
> while to be tracked in CVS), and then make a merge between these two.
> 
> Then, I'd merge the new development's HEAD, and it would be fine:
> 
> ORIG1 .. ORIG2 .. .. ORIG_HEAD
>                          |
>                          |   GIT1 .. GIT2 .. .. GIT_HEAD
>                          |   /                    /
>                          | /                     /
>                       UNIFYING_MERGE           /
>                                    \         /
>                                      \     /
>                                NEW_HEAD_FOR_ARCHEOLOGICAL_PURPOSES
> 
> Where ORIG_HEAD's tree is identical with GIT1's tree. The resulting branch 
> would serve every research purpose I can think of (just be sure not to 
> use "-m" with git-whatchanged).

Note: it's not only about research (ie. something that would be static
for browsing only), it's also about using the results of the research
in further developement.

Well, no doubt this approach can be used in many cases.  But it makes
IMHO the history somewhat confusing, and has limitations.  Let's say I
had a patch against ORIG2, and at a later date I find a successor for
it, based on GIT2.  I would not have an incarnation of GIT2 with ORIG2
as ancestor: to be on the safe side I would have had to duplicate the
whole GIT1..* history.

And after I have done some work on my branch of duplicate commits, if
I used the type of unifying merges you suggest, I'm stuck forever with
the old GIT1..GIT_HEAD line, whether I need it or not (if it comes
from import of 2.4 patches, and thus has no signed tags whatsoever, I
do not need it any more).

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
