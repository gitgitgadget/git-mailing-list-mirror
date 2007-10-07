From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fetch -- double fetch
Date: Mon, 8 Oct 2007 00:25:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080022300.4174@racer.site>
References: <20071006185759.GE28610@shadowen.org> <Pine.LNX.4.64.0710071728570.4174@racer.site>
 <20071007214433.GA30833@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefVX-0004S3-Ov
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756425AbXJGXZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756419AbXJGXZn
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:25:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:59203 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756383AbXJGXZm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:25:42 -0400
Received: (qmail invoked by alias); 07 Oct 2007 23:25:40 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp002) with SMTP; 08 Oct 2007 01:25:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19b3B0lY/ZbBNDb/42KwtkufliPoiIP5HbxJqtO/1
	1M2ngcpo03nzb1
X-X-Sender: gene099@racer.site
In-Reply-To: <20071007214433.GA30833@shadowen.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60256>

Hi,

On Sun, 7 Oct 2007, Andy Whitcroft wrote:

> On Sun, Oct 07, 2007 at 05:29:38PM +0100, Johannes Schindelin wrote:
>
> > On Sat, 6 Oct 2007, Andy Whitcroft wrote:
> > 
> > > I have recently been seeing repeated fetching of some branches.  I 
> > > feel this has happened in at least three of my repos on three 
> > > distinct projects:
> > > 
> > > apw@pinky$ git fetch origin
> > > remote: Generating pack...
> > > remote: Done counting 5 objects.
> > > remote: Deltifying 5 objects...
> > > remote:  100% (5/5) done
> > > Unpacking 5 objects...
> > > remote: Total 5 (delta 0), reused 0 (delta 0)
> > >  100% (5/5) done
> > > * refs/remotes/origin/master: fast forward to branch 'master' of ssh://git@abat-dev/var/www/git/abat
> > >   old..new: ce046f0..41c9dde
> > > * refs/remotes/origin/master: fast forward to branch 'master' of ssh://git@abat-dev/var/www/git/abat
> > >   old..new: ce046f0..41c9dde
> > 
> > What does "git config --get-all remote.origin.fetch" say?
> 
> apw@pinky$ git config --get-all remote.origin.fetch
> +refs/heads/master:refs/remotes/origin/master
> +refs/heads/*:refs/remotes/origin/*
> apw@pinky$
> 
> I don't think that I did anything to this config, I think that is what 
> the clone setup for me.

Actually, I am quite certain that git clone does not produce the first 
line; But I think that it was necessary to put in some line like that in 
older git, where the first ref was the one being merged by a pull.

But as I suspected, and Daniel replied, too, your issue is that both lines 
match "master".

You might want to delete the first line, and use "branch.<name>.remote" 
and "branch.<name>.merge" to force pull to merge "master" instead.

In the long run, it might be a good idea to cull duplicates in git-fetch, 
but for the moment I have enough other stuff to do ;-)

Ciao,
Dscho
