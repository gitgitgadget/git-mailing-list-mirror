From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rfe: bisecting with a tristate
Date: Tue, 24 Jul 2007 18:21:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241818450.14781@racer.site>
References: <Pine.LNX.4.64.0707241459460.18990@fbirervta.pbzchgretzou.qr>
 <20070724094017.d14688e5.seanlkml@sympatico.ca> <Pine.LNX.4.64.0707241447200.14781@racer.site>
 <200707241907.57857.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>,
	Jan Engelhardt <jengelh@computergmbh.de>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 19:22:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDO5A-0004jO-Fh
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 19:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbXGXRVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 13:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755526AbXGXRVx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 13:21:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:37522 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754419AbXGXRVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 13:21:53 -0400
Received: (qmail invoked by alias); 24 Jul 2007 17:21:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 24 Jul 2007 19:21:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LhcQIZYkLocXGtNwfrwE3Nrnt6gfBNzZEd5BYTr
	jV/oAgL3GFvvoE
X-X-Sender: gene099@racer.site
In-Reply-To: <200707241907.57857.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53615>

Hi,

On Tue, 24 Jul 2007, Robin Rosenberg wrote:

> tisdag 24 juli 2007 skrev Johannes Schindelin:
> 
> > On Tue, 24 Jul 2007, Sean wrote:
> > 
> > > > git bisect start
> > > > git bisect bad v2.6.23-rc1
> > > > # bad: [f695baf2df9e0413d3521661070103711545207a] Linux 2.6.23-rc1
> > > > git bisect good v2.6.22
> > > > # good: [098fd16f00005f665d3baa7e682d8cb3d7c0fe6f] Linux 2.6.22
> > > > 
> > > > Then 1f1c2881f673671539b25686df463518d69c4649 will be the next commit 
> > > > git bisect hands out. Now let's assume this commit would not compile. 
> > > > What would the user do? git-bisect good or git-bisect bad?
> > > 
> > > Check out the section "Avoiding to test a commit" in the git-bisect
> > > man page; it addresses this issue.  Basically you just use git-reset
> > > to pick a different nearby commit to compile, and then continue with
> > > git bisect good/bad.
> > 
> > But a "git bisect dunno" would be handy.
> 
> Why? Not doing anything is enough, just select a new commit. Going back 
> can be done by git reset, but forward (towards original HEAD) requires 
> more thinking so a git bisect forward [n] would help there.

And why exactly do you want to make it hard on the user?

Imagine this history:

	A - B - broken - bad - C

Now you bisect.  It goes to "broken".  You compile.  Darn, does not 
compile.  Why not have a "git bisect dunno", which considers only the 
_rest_ of the commits for the next bisection point?  When it finally found 
the "bad" one, it has to say it broke somewhere between "B..bad".

Now that would be user friendly, wouldn't it?

Ciao,
Dscho
