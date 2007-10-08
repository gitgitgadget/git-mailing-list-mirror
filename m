From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Trying to use git-filter-branch to compress history by removing
 large, obsolete binary files
Date: Mon, 8 Oct 2007 01:34:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080129480.4174@racer.site>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> 
 <20071007213817.GJ31659@planck.djpig.de>  <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
  <Pine.LNX.4.64.0710080018270.4174@racer.site> 
 <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com> 
 <Pine.LNX.4.64.0710080028301.4174@racer.site>
 <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 02:34:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IegZt-0005HY-II
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 02:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702AbXJHAeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 20:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757707AbXJHAeZ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 20:34:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:49456 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757663AbXJHAeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 20:34:24 -0400
Received: (qmail invoked by alias); 08 Oct 2007 00:34:21 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp007) with SMTP; 08 Oct 2007 02:34:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19u/Fs5ELRubF1a1IqSTefkEnU6FuxlzcaYBVgcci
	78C4n91671riG3
X-X-Sender: gene099@racer.site
In-Reply-To: <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60269>

Hi,

On Sun, 7 Oct 2007, Elijah Newren wrote:

> On 10/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 7 Oct 2007, Elijah Newren wrote:
> <snip>
> > > $ git clone test test2
> > > <snip>
> > > $ du -hs test
> > > 11M     test
> > > $ du -hs test2
> > > 11M     test2
> > >
> > > Any other ideas?
> >
> > Yep.  Maybe it is necessary to run "git gc" in test2.
> 
> Sweet, finally solved!  That brings test2 down to 340K.
> 
> However, the solution seems somewhat involved...it requires running 
> git-filter-branch, git reset, removing the .git/refs/original/ 
> directory, editing .git/packed-refs in some editor, running git reflog 
> expire, cloning the resulting repository, and running git gc yet again.  
> It seems like there has to be an easier way.  (Anyone have one?)

It should be as easy as git filter-branch and git clone.

> Oh, and git-filter-branch could really use some explanatory note about 
> how to actually complete rewriting the history.

It does what it should do.  It is _your_ task to look at refs/original/* 
if everything went alright.  Then you just delete the checked refs.

What made your case so cumbersome was that you wanted the big objects out 
_now_, instead of having them in for a grace period.  BTW this grace 
period is in place to help _you_, not the program.  (In case you fscked up 
and need those objects back.)

Ciao,
Dscho
