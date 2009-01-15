From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last
 branch
Date: Thu, 15 Jan 2009 17:50:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151749350.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <496EE559.3060901@viscovery.net> <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de> <200901151732.57023.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <junio@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 17:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNVRU-00057C-2N
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 17:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826AbZAOQt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 11:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754374AbZAOQtz
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 11:49:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:48983 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753575AbZAOQtz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 11:49:55 -0500
Received: (qmail invoked by alias); 15 Jan 2009 16:49:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 15 Jan 2009 17:49:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2XCs2hIP2QDT8pHnKjvqdOj49dCPZM6rLncCSno
	r9BuWgh9Fulvqs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901151732.57023.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105852>

Hi,

On Thu, 15 Jan 2009, Johan Herland wrote:

> On Thursday 15 January 2009, Johannes Schindelin wrote:
>
> > On Thu, 15 Jan 2009, Johannes Sixt wrote:
> > > Thomas Rast schrieb:
> > > > Let git-checkout save the old branch as a symref in LAST_HEAD,
> > > > and make 'git checkout -' switch back to LAST_HEAD, like 'cd -'
> > > > does in the shell.
> > >
> > > /me likes this feature.
> > >
> > > git rebase (-i or not) calls checkout behind the scenes if the
> > > two-argument form is used:
> > >
> > >    git rebase [-i] master topic
> > >
> > > and 'topic' is not the current branch. You may want to add a test
> > > that ensures that rebase sets LAST_HEAD in this case.
> > >
> > > You must make sure that commits referenced by LAST_HEAD are not
> > > garbage-collected. (I don't know if this happens anyway for symrefs
> > > in .git.)
> >
> > Note: if you used reflogs for that feature, the garbage collection
> > could not have killed the commit.  However, it is quite possible that
> > the branch was deleted.
> 
> I also like this feature, but as this is only a _convenience_ feature, I 
> would prefer if it didn't keep the previous branch/commit alive (if 
> otherwise unreachable).

You misread me: if the information is in HEAD's reflog, the _is_ 
reachable.  From HEAD's reflog.  And therefore, the objects will not be 
gc'ed (yet).

> In any case, this new feature will _have_ to handle the case where there 
> simply is no previous branch/commit (e.g. after a git clone or git 
> init).
>
> I suggest that "git checkout -" looks at the reflog, and if there is no 
> previous entry in the reflog, or that entry is unreachable, then fail 
> in the same manner as "git checkout garbage"

Exactly my thinking.

Ciao,
Dscho
