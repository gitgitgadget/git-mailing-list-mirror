From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 18:31:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512221823460.19925@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vek465cev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AA75D1.7040009@op5.se> <Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AA9BE6.7000601@op5.se> <Pine.LNX.4.63.0512221530570.18551@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AACBE9.7060201@op5.se> <Pine.LNX.4.63.0512221700310.18982@wbgn013.biozentrum.uni-wuerzburg.de>
 <43AAD9D7.1070503@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 18:31:50 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpUI4-0002yf-9D
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 18:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVLVRbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 12:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVLVRbl
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 12:31:41 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:36505 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030227AbVLVRbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 12:31:40 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 45FE513FC7A; Thu, 22 Dec 2005 18:31:39 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2A2819E3A1; Thu, 22 Dec 2005 18:31:39 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 164469E38A; Thu, 22 Dec 2005 18:31:39 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0CB3013FCE6; Thu, 22 Dec 2005 18:31:39 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43AAD9D7.1070503@op5.se>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13957>

Hi,

On Thu, 22 Dec 2005, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > this is getting silly. The problem is: how to setup a shared repository,
> > i.e. a repository into which different users can push their updates.
> > 
> 
> You're simplifying. Your question was
> "How can I set up a repository for multiple users to write to without setting
> a global umask for non-interactive shells?"

No, I am not. My question really was: how do I setup a shared repository?

Now, my intention was to make it as easy as possible.

> Junio said:
> "I agree the setting should not be limited to git-shell, but I do
> not think setting "umask" from git configuration is the right
> way either.  For files and directories under $GIT_DIR, maybe
> imposing the policy git configuration file has is OK, but I
> think honoring the user's umask is the right thing for working
> tree files."

IMHO Junio is wrong here. If the repository is write-shared, then the 
working directory should be write-shared as well (or checkout should be 
DENIED), else you get all kinds of problems.

> which I whole-heartedly agree with. I'd be completely furious if a tool
> ignored the umask I use for checking out files of a local repository just
> because I happen to do some work at the machine where the repo is stored (I
> imagine this couldn't possibly affect repositories cloned remotely, although
> that would surely have me going ballistic).

I do not understand what you mean by "repositories cloned remotely".

And if you really are working in the working directory of the shared 
repository, and a user (I know I would do it just to annoy you) pushes a 
new HEAD while you have modified files, you deserve what you get: a 
complete mess.

As for setting the umask only when writing into $GIT_DIR: unless somebody 
convinces me that it solves a problem, this is unncessary work.

You are free to ignore my warnings and my patch, I got no problem with 
that.

You are also free to wait for users to complain why this and that breaks, 
or why setting up a shared repository has to be hard, and apply my patch 
then.

Hth,
Dscho
