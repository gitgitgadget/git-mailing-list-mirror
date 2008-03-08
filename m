From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Sat, 8 Mar 2008 17:58:33 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081750580.19665@iabervon.org>
References: <200803061735.47674.david-b@pacbell.net> <alpine.LNX.1.00.0803072006550.19665@iabervon.org> <200803081448.47000.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
X-From: git-owner@vger.kernel.org Sat Mar 08 23:59:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY80g-0006bA-3R
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 23:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbYCHW6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 17:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYCHW6o
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 17:58:44 -0500
Received: from iabervon.org ([66.92.72.58]:53187 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbYCHW6n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 17:58:43 -0500
Received: (qmail 18271 invoked by uid 1000); 8 Mar 2008 22:58:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 22:58:33 -0000
In-Reply-To: <200803081448.47000.david-b@pacbell.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76600>

On Sat, 8 Mar 2008, David Brownell wrote:

> On Friday 07 March 2008, Daniel Barkalow wrote:
> > On Thu, 6 Mar 2008, David Brownell wrote:
> > 
> > > When I "git pull" it first fetches a bunch of files, then
> > > concludes (wrongly) "no common commits", then starts a
> > > second fetch of a *HUGE* number of files ... 400 MB is too
> > > much to pay when updating from rc3-last-week to rc4.  But
> > > if I interrupt that second one with ^C, it seems that the
> > > first one fetched enough to make the next "git pull" go
> > > pretty quickly.
> > 
> > Actually, if you can make a tarball of the .git directory of one of those 
> > workspaces, and see if the bug is reproducable with that .git directory 
> > every time (particularly when pulling a local repository), it would be 
> > really helpful to have a reliable test case.
> 
> Seems to be.  Let me know where I can stash a ~300 MB tar.bz2 file
> for you ...

Wherever you've got web space, I guess. It shouldn't be a problem for me 
on the download side.

> > There's a debugging thing that would help, but it's not in your version.
> 
> So I updated.  :)
> 
> 
> > It's in next as
> > 
> > 49aaddd102aff Teach upload-pack to log the received need lines to an fd
> > 
> > With that commit, you should be able to do:
> > 
> > GIT_DEBUG_SEND_PACK=3 git pull 3>UPLOAD_LOG
> > 
> > and get a file UPLOAD_LOG that will show what it's doing, although there's 
> > a reasonable chance that it'll only demonstrate that it's doing nothing 
> 
> That file has always been empty.

Hmm; if the testing code is working, you should get at least one pair of 
"#B/#E" lines. You probably need to either test with current "next" or 
cherry-pick that commit, since I don't think that commit's in a particular 
hurry to get to "master"

> > helpful, which we already pretty much know.
> 
> Oddly, a few times when I tried that the bug didn't reproduce.
> One factor may be workspaces cloned a long time ago with early
> versions of GIT (or cogito).

Is it a few times on different workspaces, or with copies of the same 
workspace? I think that there's a dependance on how your current state and 
the new state happen to line up.

	-Daniel
*This .sig left intentionally blank*
