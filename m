From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 23:14:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
 <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 23:15:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9Op-00045H-AQ
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWITVO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWITVO2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:14:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:54962 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932092AbWITVO1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 17:14:27 -0400
Received: (qmail invoked by alias); 20 Sep 2006 21:14:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 20 Sep 2006 23:14:25 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27401>

Hi,

On Wed, 20 Sep 2006, Linus Torvalds wrote:

> On Wed, 20 Sep 2006, Petr Baudis wrote:
> > 
> >   I personally don't think "throwing away" history is an issue. You can
> > print the old sha1 and it is still in the database so you can recover
> > it.
> 
> No it isn't. Once you've lost the reference, you can't really depend on it 
> any more in the long run.

Exactly. And to add to that: you can lose the reference just by being not 
fast enough. Example:

Some time ago, Junio was playing with colour in the output of git. He was 
doing so in some branch he pulled into 'pu'. A few days later, he dropped 
it. Now, I was lucky enough to have fetched pu within the short time span 
where colour was part of 'pu', and some days (or weeks, don't remember) 
later, I found some more time to play with the thing again, and 
eventually submitted a patch reintroducing the colour thing.

So, you can lose things you actually never had!

Another, even more serious problems with rebasing: You can introduce a bug 
by rebasing. Meaning: git-rebase can succeed, even compilation is fine, 
but the sum of your patches, and the patches you are rebasing on, is 
buggy. And there is _no_ way to bisect this, since the "good" version can 
be gone for good.

These two problems, combined with my love of history, make me never use 
rebased branches myself, especially since I basically use git for projects 
which I work on alone, just to synchronise between different sites.

As for the problem git-rebase tries to solve: you can get a clean branch 
by cherry-picking what you have into a temporary branch, for the sole 
purpose of being history clean.

Ciao,
Dscho
