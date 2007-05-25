From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 21:30:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705252128200.4648@racer.site>
References: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
 <11801165433267-git-send-email-hjemli@gmail.com> <Pine.LNX.4.64.0705251924280.4648@racer.site>
 <7vodk8r97s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 22:30:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrgQb-0000XU-AN
	for gcvg-git@gmane.org; Fri, 25 May 2007 22:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759707AbXEYUaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 16:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758078AbXEYUaU
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 16:30:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:46167 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755162AbXEYUaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 16:30:18 -0400
Received: (qmail invoked by alias); 25 May 2007 20:30:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 25 May 2007 22:30:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WDWEPFzkWUSHjXCzZnjIHndFh5WQCYcf5TsdcuV
	2QvgRx6CTVMJoc
X-X-Sender: gene099@racer.site
In-Reply-To: <7vodk8r97s.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48409>

Hi,

On Fri, 25 May 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 25 May 2007, Lars Hjemli wrote:
> >
> >> +FILES
> >> +-----
> >> +When cloning submodules, a .gitmodules file in the top-level directory
> >> +of the containing work-tree is examined for the url of each submodule.
> >> +The url is the value of the key module.$path.url.
> >
> > IIRC Junio talked about a name for overriding. But I think it would be 
> > even better to to override by mapping the URLs from .gitmodules to the 
> > locally-wanted URLs.
> >
> > Junio?
> 
> I really do not want that (mis)conception that .gitmodules
> specify the default and .git/config the override.  I really
> think we should use the .git/config as _the_ only authority to
> get URL, but keyed with the three-level scheme, with URL in
> .gitmodules used _solely_ as a hint when setting up the URL in
> the .git/config file.
> 
> 	cf. $gmane/47502, 47548, 47621

Yes, I skipped over the first two, and concentrated on the third. If 
.gitmodules are used to initialize what is in .git/config, I agree.

However, could we have that as a separate commit, to keep things simple 
enough so that I can understand them?

> >> +When updating submodules, the same .gitmodules file is examined for a key
> >> +named 'module.$path.branch'. If found, and if the named branch is currently 
> >> +at the same revision as the commit-id in the containing repositories index, 
> >> +the specified branch will be checked out in the submodule. If not found, or 
> >> +if the branch isn't currently positioned at the wanted revision, a checkout
> >> +of the wanted sha1 will happen in the submodule, leaving its HEAD detached.
> >
> > A very good description, and I think this is the only method to checkout 
> > the submodule which makes sense. (Just maybe default the value of 
> > module.<path>.branch to "master"?)
> 
> I suspect leaving the HEAD always detached if the superproject
> tree names a concrete commit object name would be less confusing
> and consistent.  When the name of the commit object in the
> superproject tree and/or index is 0{40}, it would be a good
> extension to use "whatever commit that happens to be at the tip
> of this branch" taken from the .gitmodules file.

Yes, that's a much better idea.

Ciao,
Dscho
