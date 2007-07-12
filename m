From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Volume of commits
Date: Thu, 12 Jul 2007 14:59:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707121451290.4516@racer.site>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com> <20070712132937.GQ19386@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: VMiklos <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 16:00:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8zDC-0003FK-ST
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 16:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764137AbXGLOAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 10:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760683AbXGLOAA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 10:00:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:46033 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932167AbXGLN77 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 09:59:59 -0400
Received: (qmail invoked by alias); 12 Jul 2007 13:59:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 12 Jul 2007 15:59:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182EPo6IB82sCnZdKjU6BPm8czUgZ4W/t5ocnCswe
	1j14a7PVDa2i64
X-X-Sender: gene099@racer.site
In-Reply-To: <20070712132937.GQ19386@genesis.frugalware.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52291>

Hi,

On Thu, 12 Jul 2007, VMiklos wrote:

> Na Thu, Jul 12, 2007 at 03:16:47PM +0200, Fredrik Tolf <fredrik@dolda2000.com> pisal(a):
> > So what I'm wondering is how you people manage to do this? Do you 
> > actually always commit changes this way (and, in that case, how do you 
> > switch between branches)? Or do you somehow aggregate the smaller 
> > commits into larger patches and recommit them? Or is there some third 
> > possibility that I'm missing?
> 
> you can cherry-pick the relevan patches to a separate branch and commit 
> then at once (cherry-pick -n), or can merge --squash to archive 
> something similar

What I do these days is committing early, and often, and then rearrange 
with "git rebase -i".  Beware: this is a 1.5.3 feature!  But IMHO it is 
really something you can look forward to.

A little diagram hopefully explains what you can do with it:

- upstream
 \
   A - B - C - D - E - F - G - HEAD with a messy history

In this case, "messy history" means that there are tiny patches which are 
often in the wrong order, or should be squashed into one commit.  "git 
rebase -i upstream" presents you with the list of A - HEAD, and you can 
reorder the patches.  If you want to, you can combine ("squash") some 
into one commit, or you can skip it, by removing the corresponding line.

The result can look like this:

- upstream
 \
   B+C+F - A - G+E

Note that D is missing, which can be desirable, for example when you made 
a commit only introducing lots and lots of debug output.  See, nobody has 
to know what you did.  The end result will look elegant.

This demonstration of why distributed SCM is good ("it lowers the 
embarrasment factor") was brought to you by Git.
 
Ciao,
Dscho
