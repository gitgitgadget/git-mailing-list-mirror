From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question about git-prune
Date: Sat, 30 Jun 2007 21:18:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706302115290.4438@racer.site>
References: <Pine.LNX.4.64.0706300915440.16800@x2.ybpnyarg>
 <Pine.LNX.4.64.0706301900290.4438@racer.site> <f66d3l$sa6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 22:18:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4jOX-0006c0-Tg
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 22:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbXF3USJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 16:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbXF3USH
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 16:18:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:37066 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751789AbXF3USH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 16:18:07 -0400
Received: (qmail invoked by alias); 30 Jun 2007 20:18:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 30 Jun 2007 22:18:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FF39BixHFg3ly+lQWPAcL9P+WyHhqtmYDP+4NWE
	urYS9btFtf/E7J
X-X-Sender: gene099@racer.site
In-Reply-To: <f66d3l$sa6$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51253>

Hi,

On Sat, 30 Jun 2007, walt wrote:

> Johannes Schindelin wrote:
> > 
> > On Sat, 30 Jun 2007, walt wrote:
> ...
> > > $git-prune
> > > $git-fsck
> > > dangling tree c642c018aa55d39fff061183f58062de9d8375ac
> > > dangling commit e1341abc3759950e891822088cb0163b71b316b3
> > > dangling commit 9f38e1ef7e7992ca490b9b419f52fb4d11efb0e4
> > > dangling commit b82871b3c32faa8a317007f343fdf2d0ddc9954e
> > 
> > Probably the objects were packed.
> 
> I also tried git-prune-packed, which also did nothing AFAICT.

git-prune-packed prunes objects which are loose _and_ packed.

> > I do not understand why you use git-prune directly, to begin with. Why 
> > not use git-gc and be done with it?
> 
> It didn't exist when I started using git.  I normally don't use 
> git-prune either, but in this case I was just scanning for problems 
> after switching from cg-update to git-pull.

Fair enough.

> git-gc did get rid of all the danglers even though git-prune didn't. 
> I'll do some investigating to find out why -- that should get me more up 
> to date with recent changes.

The thing you needed was actually git-repack (which is called with every 
necessary option you need from git-gc).

Basically, your objects were dangling _and_ packed. Thus you had to repack 
in order to get rid of them, but keep the others.

Ciao,
Dscho
