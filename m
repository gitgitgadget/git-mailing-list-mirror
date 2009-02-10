From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix contrib/hooks/post-receive-email for new branch with
 no new commits
Date: Tue, 10 Feb 2009 16:59:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101655500.10279@pacific.mpi-cbg.de>
References: <1234273695-4981-1-git-send-email-pknotz@sandia.gov> <m3ab8uuwfg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pat Notz <pknotz@sandia.gov>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:00:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWv2K-00054y-Ln
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbZBJP7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 10:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbZBJP7B
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 10:59:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:49378 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753833AbZBJP7B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 10:59:01 -0500
Received: (qmail invoked by alias); 10 Feb 2009 15:58:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 10 Feb 2009 16:58:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lcF1XS1bl0JL8mHCC9Tcql3WiNx1mWC9meq+L4G
	mtXCDo1qfl9LvP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <m3ab8uuwfg.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: -0.07000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109262>

Hi,

On Tue, 10 Feb 2009, Jakub Narebski wrote:

> "Pat Notz" <pknotz@sandia.gov> writes:
> 
> > In the show_new_revisions function, the original code:
> > 
> >    git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
> > 
> > isn't quite right since one can create a new branch and push it without
> > any new commits.  In that case, two refs will have the same sha1 but
> > both would get filtered by the 'grep'.  In the end, we'll show ALL the
> > history which is not what we want.  Instead, we should list the branches
> > by name and remove the branch being updated and THEN pass that list
> > through rev-parse.
> 
> Good idea, bad execution.

And I thought that I hold the patent for grumpy comments on this list :-)

As for your suggestions, I think they are valid.  We try to keep the 
interface of certain commands (so called "plumbing") stable, for script 
consumption.  "git for-each-ref" is such a command.

However, "git branch" is meant for human consumption, and a pretty recent 
patch wants to change the interface to make it even friendlier -- but 
breaking scripts' assumption in the process, should they use "git branch".

Ciao,
Dscho
