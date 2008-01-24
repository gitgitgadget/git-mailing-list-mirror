From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Multiple working trees with GIT ?
Date: Thu, 24 Jan 2008 13:38:45 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801241336510.5731@racer.site>
References: <20080124074952.GA8793@1wt.eu> <Pine.LNX.4.64.0801240947230.14173@reaper.quantumfyre.co.uk> <alpine.LSU.1.00.0801241102260.5731@racer.site> <20080124125606.GB13247@1wt.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
X-From: git-owner@vger.kernel.org Thu Jan 24 14:39:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI2Ig-0006vM-VU
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 14:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbYAXNi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 08:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbYAXNiz
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 08:38:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:41884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751675AbYAXNiz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 08:38:55 -0500
Received: (qmail invoked by alias); 24 Jan 2008 13:38:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 24 Jan 2008 14:38:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+fvE9u8J+ClT5hwv+P+Bd+vyueWt5zatAjc+vcv
	JRRxXyBrBWTnzM
X-X-Sender: gene099@racer.site
In-Reply-To: <20080124125606.GB13247@1wt.eu>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71619>

Hi,

On Thu, 24 Jan 2008, Willy Tarreau wrote:

> On Thu, Jan 24, 2008 at 11:04:42AM +0000, Johannes Schindelin wrote:
> 
> > On Thu, 24 Jan 2008, Julian Phillips wrote:
> > 
> > > You might want to have a look at the git-new-workdir script in 
> > > contrib, it does basically the same thing.  It's been there for 
> > > about 10 months now. It was based on an email from Junio:
> > > 
> > > http://article.gmane.org/gmane.comp.version-control.git/41513/
> > 
> > FWIW I have a patch to do something like that in "git branch" itself.
> >
> > > However, there are some caveats about using this approach, basically 
> > > about the fact that there is nothing stopping you from updating refs 
> > > that are currently checked out in another directory and causing 
> > > yourself all sorts of pain ... the topic has cropped up a couple of 
> > > times on the list since the script was added.
> > 
> > I agree; maybe we should have a telltale file 
> > "refs/heads/<bla>.checkedout" which is heeded by "git checkout" and 
> > "git branch -d/-D", as well as update_ref() (should only update that 
> > ref when it HEAD points to it)?
> 
> Why not generalize this into HEAD.$branch (thus limiting to one checkout 
> per branch) or HEAD.$checkoutdir ?

Because multiple working trees for the same repository will always be a 
second-class citizen.  And I would rather not affect the common case too 
much.

Having a "lock" file which is heeded by just a few places which are 
supposed to update refs (thinking about it, just update_ref() should be 
enough), is at least a well-contained change.

Ciao,
Dscho
