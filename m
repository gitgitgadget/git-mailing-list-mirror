From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rebasing local patches
Date: Sat, 7 Mar 2009 12:41:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903071229220.10279@pacific.mpi-cbg.de>
References: <49B237E2.3080606@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 12:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfuwH-00035A-A2
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 12:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbZCGLji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 06:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbZCGLji
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 06:39:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:32981 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752146AbZCGLjh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 06:39:37 -0500
Received: (qmail invoked by alias); 07 Mar 2009 11:39:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 07 Mar 2009 12:39:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18A+/B0gkYAo5TXsWMrrKckmtVEIxWzCIwfW/v4ay
	EjAasY4rRRq8JP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49B237E2.3080606@morey-chaisemartin.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112526>

Hi,

On Sat, 7 Mar 2009, Nicolas Morey-Chaisemartin wrote:

> On one of our project, we depend on an external source which uses git. 
> On our side of the project, we create some patches (this part is not the 
> problem), but only some of them are intended to be pushed (ie pulled by) 
> the external source. So basically, we have a set of patches on local 
> branch that we rebase every so and then against master to keep our 
> version up-to-date with the external one.
> 
> Is this the right way to do it?

Looks sane.

> Then, internally we have a centralized repository and many personal 
> ones. When the need to go to the next version, one of the developper 
> rebases the company patches branch afaisnt master and push it into the 
> centralized repo.
>
> What is the best way for the other developpers to get up-to-date with 
> the rebased branch?
>
> git pull --rebase seems to me like a good way to keep local modifications.

Indeed.

You could also work from release branches, i.e. whenever you rebase your 
company-specific changes onto the upstream, you could start a new branch.

Or even better: you could "merge -s ours" the pre-rebase commit.  The 
history would then look something like this:

           new UPSTREAM - A' - B' - C' - M
                                        /
old UPSTREAM - A - B - C --------------'

The ' commits are the rewritten versions of the original company-specific 
ones, made by the rebase.

If you do it that way, not only will you not lose the history of your 
project, but your users can happily continue to merge instead of having to 
rebase.

> I noticed that when the branch was rebased on the centralized and repo 
> and origin/our_patches is up-to-date in mine.
>
> If I checkout another branch and then ckecout our_branches, I got a 
> message telling my our_patches and the one from the server have diverged 
> (or you are two commits behind...).
>
> How can you get this info directly without leaving/rejoining your 
> branch?

It is also part of "git status"' output.

Ciao,
Dscho
