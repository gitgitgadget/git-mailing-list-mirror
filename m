From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 12:27:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vek465cev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AA75D1.7040009@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 12:28:16 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpOba-0005Fr-GQ
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 12:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVLVL1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 06:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVLVL1N
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 06:27:13 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15524 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932242AbVLVL1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 06:27:12 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7578E13FD4C; Thu, 22 Dec 2005 12:27:10 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5A0EC9E38F; Thu, 22 Dec 2005 12:27:10 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 276859E37B; Thu, 22 Dec 2005 12:27:10 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 73AB713FD55; Thu, 22 Dec 2005 12:27:09 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43AA75D1.7040009@op5.se>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13943>

Hi,

On Thu, 22 Dec 2005, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > On Wed, 21 Dec 2005, Junio C Hamano wrote:
> > 
> > 
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > 
> > > 
> > > > If you don't use git-shell, because the same machine is used for other
> > > > purposes, it makes sense to introduce
> > > > 
> > > > 	[core]
> > > > 		umask = 0002
> > > 
> > > I agree the setting should not be limited to git-shell, but I do
> > > not think setting "umask" from git configuration is the right
> > > way either.  For files and directories under $GIT_DIR, maybe
> > > imposing the policy git configuration file has is OK, but I
> > > think honoring the user's umask is the right thing for working
> > > tree files.
> > 
> > 
> > As we worked out in another thread, you should not have a working directory
> > when you write-share the repository.
> > 
> 
> Which thread was that? I see no particular problem with having a working
> directory in a write-shared repo. The same care has to be taken there as
> everywhere (pull before push), but that's nothing new.

It was the thread "How to set up a shared repository".

Okay, so there you are. You have a write-shared repository with the HEAD 
checked out. Somebody wants to push to that with different credentials 
than the user who checked out the files. Do you plainly deny updating the 
current HEAD?

If you do, then you better give the pushing user (pun intended) a way to 
update the checked out files. You can do this by (tadaah) setting the 
umask to 0002 also for working files.

Yes, we could find out exactly where writes happen inside GIT_DIR and plug 
in shared.umask which is only applied in these cases, but I am totally 
unconvinced that this is worth the hassle. In my cases, I am perfectly 
helped by a umask which is respected throughout git, and the patch is 
simple enough to be reviewed in 5 minutes.

Ciao,
Dscho
