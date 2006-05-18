From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away revs hidden by a graft.
Date: Fri, 19 May 2006 00:52:16 +0200
Message-ID: <20060518225216.GC6535@nowhere.earth>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth> <Pine.LNX.4.64.0605181435230.10823@g5.osdl.org> <7viro3nh07.fsf@assigned-by-dhcp.cox.net> <20060518222045.GB6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 00:40:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgrAa-0005EJ-JE
	for gcvg-git@gmane.org; Fri, 19 May 2006 00:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWERWke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 18:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWERWkd
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 18:40:33 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:47805 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751003AbWERWkd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 18:40:33 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 2AE394F110;
	Fri, 19 May 2006 00:40:32 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FgrLt-0002fk-EG; Fri, 19 May 2006 00:52:17 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060518222045.GB6535@nowhere.earth>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20313>

On Fri, May 19, 2006 at 12:20:45AM +0200, Yann Dirson wrote:
> On Thu, May 18, 2006 at 02:46:16PM -0700, Junio C Hamano wrote:
> > Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > > Is it/does it?
> > >
> > > I'd assume that if you have a graft, you _want_ the history to be hidden 
> > > and pruned. 
> > >
> > > That's how you'd drop history, if you wanted to do it on purpose.
> > 
> > I haven't looked at what the test does, but I think he is
> > talking about the opposite.  fsck by design does not honor
> > grafts, and if you grafted a history back to your true root
> > commit, that "older" history will be lost.
> 
> I'm not sure I understand what you're saying.  AFACT fsck does not
> ignore grafts: if a rev is not accessible from heads because of a
> graft, prune drops it, and fsck does not see a problem.
> 
> Linus, I understand your point, but the current situation is
> problematic: a graft does not get propagated by cg-clone (and I
> suppose not by git-clone or git-fetch either), so cloning a tree which
> has undergone such a pruning operation results in an incomplete clone
> (indeed it is how I met the problem).  Since grafts are supposed to
> have local effect only (as far as I understand), I see it as a bad
> indication to have such a remote effect.

To make my point maybe more clear: if someone really wants to make a
graft permanent, wouldn't some history rewriting (eg. with
cg-admin-rewritehist, but see the patch I posted against it) be the
way to go, instead of relying on out-of-band transfer of graft data ?

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
