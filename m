From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding Reviewed-by/Tested-by tags to other peoples commits
Date: Sat, 11 Oct 2008 12:58:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810111254240.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <b2cdc9f30810102337q13432bepa957acaace9ddc5d@mail.gmail.com> <20081011074604.GA23883@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 11 12:55:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Koc7i-0000ig-7j
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 12:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbYJKKwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 06:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbYJKKwY
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 06:52:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:58839 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751769AbYJKKwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 06:52:23 -0400
Received: (qmail invoked by alias); 11 Oct 2008 10:52:23 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 11 Oct 2008 12:52:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Vwo87sh1VfvddMxsKJwGXEiaSdwyJiBSuBHF1lo
	1UzpkMmizB0YrL
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081011074604.GA23883@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97969>

Hi,

On Sat, 11 Oct 2008, Jeff King wrote:

> On Sat, Oct 11, 2008 at 07:37:04AM +0100, Alex Bennee wrote:
> 
> > I've just tested/reviewed a patch of someone elses and I want to 
> > forward it on the appropriate mailing list. I gather for Linux you 
> > just add the appropriate tags to the commit. Does git offer a shortcut 
> > for doing this or do you have to do a reset HEAD^ and re-commit with a 
> > copy&pasted and modified commit message?
> 
> Try "git commit --amend" to edit the commit message. There's no 
> automatic way of adding acked-by or tested-by tags with git; most people 
> who do those things often would probably configure their editor to make 
> it easier.

Of course, you could also automate it with a script:

-- snip --
GIT_EDITOR='sh -c "perl -pi.bak -e s/pick/edit/ \"$1\""' \
git rebase -i HEAD~2
while test -d .git/rebase-merge
do
 GIT_EDITOR='sh -c "echo \"Reviewed-by: Mini Me <mi@ni.me>\" >> \"$1\""' \
 git commit --amend &&
 git rebase --continue ||
 break
done
-- snap --

(Of course you would make HEAD~2 a parameter...)

BTW what happened with the "amend" patches to rebase -i?  AFAIR Peff or 
MadCoder (or was it j6t?) had patches to teach rebase -i the "amend" 
command, which would not fall back to the command line just to fix a typo 
in a commit message... I would like to have that.

Hth,
Dscho
