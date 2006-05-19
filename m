From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away revs hidden by a graft.
Date: Fri, 19 May 2006 22:25:40 +0200
Message-ID: <20060519202540.GF6535@nowhere.earth>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth> <Pine.LNX.4.64.0605181435230.10823@g5.osdl.org> <7viro3nh07.fsf@assigned-by-dhcp.cox.net> <20060518222045.GB6535@nowhere.earth> <20060518225216.GC6535@nowhere.earth> <7vsln7lzbj.fsf@assigned-by-dhcp.cox.net> <20060519185558.GE6535@nowhere.earth> <Pine.LNX.4.64.0605191159520.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 22:14:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhBME-0008NI-0U
	for gcvg-git@gmane.org; Fri, 19 May 2006 22:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWESUNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 16:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWESUNy
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 16:13:54 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51144 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S964808AbWESUNx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 16:13:53 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 3601848D51;
	Fri, 19 May 2006 22:13:51 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FhBXZ-0003s4-3D; Fri, 19 May 2006 22:25:41 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605191159520.10823@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20354>

On Fri, May 19, 2006 at 12:02:48PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 19 May 2006, Yann Dirson wrote:
> 
> > On Thu, May 18, 2006 at 03:53:36PM -0700, Junio C Hamano wrote:
> > > Yann Dirson <ydirson@altern.org> writes:
> > > 
> > > > To make my point maybe more clear: if someone really wants to make a
> > > > graft permanent, wouldn't some history rewriting ... be the
> > > > way to go,...
> > > 
> > > Yes.
> > 
> > So if temporary usage is a typical use for grafts, don't we want to
> > protect people using them from pruning ?  I got no feedback to my
> > suggestion of changing the default behaviour, even to say it was a bad
> > idea :)
> 
> I don't actually know how much grafts end up being used. Right now, the 
> only really valid use I know about is to graft together the old kernel 
> history kind of thing, and I suspect not a whole lot of people do that (I 
> keep a separate kernel history tree around for when I need to look at it, 
> and it doesn't happen all that often).
> 
> So I think the lack of feedback on the graft-related issue comes directly 
> from that lack of graft usage. 

I take this as an incentive to share my use of the think :)

On several projects managed with CVS, I use a git mirror (maintained
with git-cvsimport for now) to prepare my sets of patches with stgit,
before committing them to cvs (through git-cvsexportcommit).  In this
context, since merges are not recorded in cvs, and cvs insists that
all branches must derive from the trunk, I use grafts to:

	1. record merges
	2. cause git to believe that the trunk derives from the vendor
	   branch
	3. hide those pseudo revisions cvs adds to rcs files saying
	   "file was initially added to branch foo"

It is the latter use which caused the loss previously mentionned.  It
could have been avoided by making cvsimport, or more likely cvsps more
clever wrt this case.


> We _could_ decide that fsck should just follow the "real parents" and the 
> grafts _both_. That's the safe thing to do by default. Possibly with a 
> flag to say "prefer one over the other", or even a "prefer which-ever 
> exists".

I'm not sure I see how "prefer which-ever exists" would be useful - do
you have anything precise in mind ?

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
