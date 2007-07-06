From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-apply{,mbox,patch} should default to --unidiff-zero
Date: Fri, 6 Jul 2007 02:51:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707060243110.4093@racer.site>
References: <20070705232210.GR3492@stusta.de> <Pine.LNX.4.64.0707060217460.9789@racer.site>
 <20070706014222.GK3492@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 03:58:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6d5Q-0007Yf-0k
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 03:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758302AbXGFB6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 21:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758137AbXGFB6R
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 21:58:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:48453 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757033AbXGFB6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 21:58:16 -0400
Received: (qmail invoked by alias); 06 Jul 2007 01:58:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp026) with SMTP; 06 Jul 2007 03:58:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EJtxBQuJEAkH7eDoLElJB1L0KfgGSIh4dZqvQxd
	EunG87vAygd3+o
X-X-Sender: gene099@racer.site
In-Reply-To: <20070706014222.GK3492@stusta.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51714>

Hi,

On Fri, 6 Jul 2007, Adrian Bunk wrote:

> On Fri, Jul 06, 2007 at 02:18:46AM +0100, Johannes Schindelin wrote:
> 
> > On Fri, 6 Jul 2007, Adrian Bunk wrote:
> > 
> > > git-apply{,mbox,patch} should default to doing --unidiff-zero:
> > 
> > But is that not dangerous? At least now the committer has some 
> > safeguard against this kind of mistakes. Because you can easily 
> > introduce mistakes that way.
> 
> you are saying "easily".
> 
> Did you ever actually run into such a problem?

Not yet, thankfully.

> You must do something like "diff -U0" or manually editing patches for 
> creating such patches, and that's very unusual.

The point is that the _committer_ is not necessarily involved in that 
business.

And "git apply" is strict for a reason. It catches possibly unwanted 
things much earlier than patch. I _want_ to be warned that somebody is 
introducing some code at a certain position, which might, or might not be 
correct. apply has no way to tell, since there is no context to at least 
minimally verify.

> And although GNU patch (which has a much bigger userbase than git) 
> applies such patches without any warning I don't remember having ever 
> seen what you call "easily".

GNU patch is very sloppy. And I had to fix up quite a number of patches 
which were "successfully" applied, but did not do what they were supposed 
to do. The recent "GNU patch applies _indented_ _context_ diffs" fracass 
is only one example why I prefer git apply.

Unfortunately, I do not off-hand remember if I had to fix up a 
unified-zero patch that GNU patch applied, but I do know this:

	if "git am" learns to apply unified-zero by default, the first 
	thing I will do is patch it in my Git branch to _not_ do that. I 
	do _not_ want that. I want to be warned.

	I can still decide that it is probably okay, but I will make 
	_damned_ _well_ sure afterwards that it did something sensible. I 
	will _only_ apply such a scrutiny when git apply refused to apply 
	a unified-zero patch, and I decided to apply it nevertheless.

Ciao,
Dscho
