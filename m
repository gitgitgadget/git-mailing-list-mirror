From: Yann Dirson <ydirson@altern.org>
Subject: Re: remaining git-cvsimport problems: robustness when cvsps feeds strange history
Date: Sat, 27 May 2006 18:35:55 +0200
Message-ID: <20060527163555.GM1164@nowhere.earth>
References: <20060527120105.GL6535@nowhere.earth> <46a038f90605270823qdea766fxcf2327ae0bf7373a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Sat May 27 18:23:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk1Zt-0007Qi-4L
	for gcvg-git@gmane.org; Sat, 27 May 2006 18:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWE0QXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 12:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWE0QXi
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 12:23:38 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:27038 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S964856AbWE0QXh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 12:23:37 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C296748C3F;
	Sat, 27 May 2006 18:23:35 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fk1ld-0006tU-56; Sat, 27 May 2006 18:35:57 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90605270823qdea766fxcf2327ae0bf7373a@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20859>

On Sun, May 28, 2006 at 03:23:01AM +1200, Martin Langhoff wrote:
> I want to see if we can close these gaps. Have you got a public repo
> that shows this problem so can look more into it?

No, it holds proprietary code - I can only try to reproduce the
history pattern, but I have not succeeded in that yet.  And that's not
something I can do on customer time :)


> On 5/28/06, Yann Dirson <ydirson@altern.org> wrote:
> >As a sidenote, I'm wondering why there is no precise information on
> >the branchpoint in "cvsps -A".  I guess the semantics are "fork a new
> >branch from the ancestor one" at whatever point it currently is - that
> >would look quite risky to me, and could be part of the reason why
> >cvsps did not notice the inconsistency: it just did not try to find
> >out where the new branch was to be grafted exactly.
> 
> It is perfectly possible for cvs to branch at a "point" that is not
> really a patchset/patchlevel. Just like it is to tag something that
> has never been a patchset.
>
> It is something we currently fudge a bit (or a lot, depending on your
> point of view). If the branch was made on a checkout with an
> inconsistent tree, we cannot really represent that in git matching
> what happened in CVS.

Yes, I know that too much.  I've already thought that it could
possibly be represented by a merge commit taking as parents all
patchsets that contain a file revision holding the tag.  But such
patchset synthesis ought to done at cvsps level IMHO.


> OTOH, the cvsps output you are showing us seems to be in the right
> order...  patchset 20 should go on top of patchset 3... is cvsimport
> truly mishandling this?

That's the problem.  I had just copypasted the logs for handling at
home, and then I discovered in the cvsps log that the timestamp for
patchset 2 is the same as the one for patchset 1, which is obviously
wrong.  I'll look at the cvs repo next week to understand whether that
comes from the RCS file, or whether it is cvsps misunderstanding
something.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
