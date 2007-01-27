From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT and repo-config
Date: Sat, 27 Jan 2007 11:33:54 +0100
Message-ID: <20070127103354.GE4036@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070125225512.GF4083@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701251545w1b34a0dcg545eeab08d767e38@mail.gmail.com> <Pine.LNX.4.63.0701260052590.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070126175302.GG4083@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.63.0701270008410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 11:35:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAktz-0001Y9-BL
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 11:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbXA0KfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 05:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbXA0KfJ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 05:35:09 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:35274 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbXA0KfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 05:35:07 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id C3AAC27B45;
	Sat, 27 Jan 2007 11:35:04 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 1E7561F07B; Sat, 27 Jan 2007 11:33:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701270008410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37939>

On Sat, Jan 27, 2007 at 12:12:36AM +0100, Johannes Schindelin wrote:
> > Even if that was to be done in git, it would surely be post-1.5, so we
> > need another way to do things in the meantime.
> 
> I don't think it is too late. If it is simple enough, and stuck behind a 
> command line option (not affecting the rest of repo-config), it is safe 
> enough to include.

That would be great.

> > > The most important point (to me) which came out of the discussion: It is 
> > > not at all easy, or straight-forward, to handle multi-vars, i.e. multiple 
> > > values for the same key.
> > 
> > Right, at least for filling a dictionnary.  We would need to declare
> > multi-valued parameters as such, which basically means we must only
> > try to read those config items we know about, which has all sorts of
> > consequences for config.py :)
> 
> Well, we have only two multi-valued keys at the moment (AFAIK): 
> remote.<branch>.fetch and remove.<branch>.push.
> 
> Even if there are more, they are hardly interesting to StGIT, right?

Not completely right.  It is precisely remote.<branch>.fetch I'm
needing, to be able to locate which remote a parent branch belongs to
when creating a stack.  It may be that the problem is git-remote being
too limited, and if we implement the functionnality at that level,
then maybe we can ignore those config settings.  But maybe not, since
I'd like stack creation to record a remote.<stack>.fetch entry.

> So why not just pretend that they don't exist, by making a
> dictionary, putting each new key/value pair into it one by one? 
> (Forgetting all but the last value for multi-values...)

IMHO, that'd be the easiest way to shoot ourselves in the foot :)

> > It would seem reasonable to start without a cache dictionnary, at least 
> > for now.  After all, there are not so many config items to know about in 
> > a single stgit run, so IIMHO we're only going to notice a difference for 
> > the time needed to run the testsuite.
> 
> The point is: it is very easy and short to just stash everything into a 
> dictionary, and retrieve it from there.

OTOH, it is equally easy (if not easier) to call "git repo-config
--get" or --get-all when needed :)

Best regards,
-- 
Yann.
