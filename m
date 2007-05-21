From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFC: submodule terminology
Date: Mon, 21 May 2007 02:52:34 -0400
Message-ID: <20070521065234.GM3141@spearce.org>
References: <20070520214417.GM5412@admingilde.org> <200705210006.47266.johan@herland.net> <7v3b1rje45.fsf@assigned-by-dhcp.cox.net> <1179729886.6187.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Mon May 21 08:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq1lI-0001yr-G9
	for gcvg-git@gmane.org; Mon, 21 May 2007 08:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbXEUGws (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 02:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbXEUGwr
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 02:52:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57399 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbXEUGwr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 02:52:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hq1kx-0006iM-PF; Mon, 21 May 2007 02:52:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BE5A820FBAE; Mon, 21 May 2007 02:52:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1179729886.6187.15.camel@localhost>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47974>

Raimund Bauer <ray007@gmx.net> wrote:
> On Sun, 2007-05-20 at 15:59 -0700, Junio C Hamano wrote:
> > I was wondering if we can get away by just calling them
> > "projects", "projects containd in the superproject", etc., as I
> > tend to agree with Linus, who used the term "superproject
> > support" in his talk, that this is not really about creating
> > "subproject" which are somehow different from ordinary projects,
> > but more about supporting superprojects that can contain/point
> > at other projects, which we did not have before 1.5.2 happened.
> 
> The "super" or "sub" only comes from where in a hierarchy it is used.
> Somewhere in the middle of the hierarchy it would be both?

Yes.  Of course.
 
> I'd have said a repository can have many "modules" or "projects", and
> each of those can have several branches. A module can hold other
> modules, but from its POV also be part of a super-module (or
> superproject), we just have to take care to not build loops.

You cannot build a loop.  OK, let me rephrase:

I can build a loop where at one point in time project A uses project
B as his subproject; then later I can have project B use project
A as a subproject.  That's a loop.  But the commits themselves are
not in a cycle.  There is a specific version of A that requires a
specific version of B, and there is a different version of B that
requires an entirely different version of A.

This loop really just means we have to be smart about how we switch
between versions of a project.  Just like if B is required in one
version of superproject A and not in another; when I switch back
and forth in A I expect B to appear/disappear.  And I expect it
to work on an airplane, where network access to reclone B is not
available (or is too costly).  That means we have to "hide" B when
its not needed.

If you can actually form a loop where version of A requires version
of B and version of B requires the version of A that requires the
version of B... that's a SHA-1 hash collision.  If you can make
them at will, you probably can make some good money illegally...

> Is my view of the world correct so far?

Yes.

-- 
Shawn.
