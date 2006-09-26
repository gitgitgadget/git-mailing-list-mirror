From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Tue, 26 Sep 2006 17:30:03 -0400
Message-ID: <20060926213003.GA8177@spearce.org>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 23:30:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSKVK-0006jM-To
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 23:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWIZVaK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 17:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWIZVaK
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 17:30:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:17613 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964819AbWIZVaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 17:30:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSKV2-0001vg-Hq; Tue, 26 Sep 2006 17:29:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9FB6220FB28; Tue, 26 Sep 2006 17:30:03 -0400 (EDT)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609261629160.9789@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27824>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 26 Sep 2006, A Large Angry SCM wrote:
> 
> > Git, unfortunately, does not make it easy. What is wanted is to put all
> > of the subprojects in one repository and be able to checkout the various
> > parts from a local copy of the repository. The problem is, with Git, a
> > repository can have at most one working directory associated with it at
> > a time. This is because Git stores a lot of information about the
> > contents of the working directory in the repository. In fact, the usual
> > situation is that the repository, itself, is in the working directory.
> 
> There are a bunch of use cases which people see as subprojects, with 
> slightly different desires. For example, I personally don't think there's 
> any point to subprojects if a commit of the parent project doesn't specify 
> the embedded commits of each subproject (so, for example, you can use 
> bisect on the parent project to figure out which act of updating a 
> subproject broke the resulting system). AFAICT, your design doesn't handle 
> that, but uses the most recently fetched versions of all subprojects, with 
> the revision control of the parent only handling revisions in the 
> arrangement and membership of subprojects in the parent.

I agree entirely.

I have about 30 "subprojects" tacked into one large Git repository
for this exact reason.  In at least 5 of these cases they shouldn't
be sharing a Git repository as by all rights they are different
projects.

What I'm doing is sort of like tacking both the Linux kernel and
glibc into the same Git repository because you might need to change
and bisect over updates to the system call layer.  Insane, yes.
Probably shouldn't be done; but right now that interface layer
between several subprojects is still in flux and it makes it rather
easy to keep everything in sync.

Its annoying to perform commits to the "root project" every time the
subproject changes.  And it brings some complexity when you want to
talk about merging that root project.  But if its automated as part
of "git commit" and "git merge" (either directly in those tools or
by hooks users can install) then its probbaly a non issue.

-- 
Shawn.
