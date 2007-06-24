From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Sun, 24 Jun 2007 12:45:00 +0200
Message-ID: <B1169070-341A-444A-ACCE-872C5E00A05A@zib.de>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <81b0412b0706231404hc8b4bc4xd5bc51c733d8ea69@mail.gmail.com> <9C4338DC-0C4A-4981-9EC9-2417513F629D@zib.de> <Pine.LNX.4.64.0706241123170.4059@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 12:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2PZg-0006nD-11
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 12:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbXFXKn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 06:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbXFXKn5
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 06:43:57 -0400
Received: from mailer.zib.de ([130.73.108.11]:35164 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754015AbXFXKn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 06:43:56 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5OAhrlf018291;
	Sun, 24 Jun 2007 12:43:53 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db104ed.pool.einsundeins.de [77.177.4.237])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5OAhqRi015799
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 24 Jun 2007 12:43:53 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0706241123170.4059@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50789>


On Jun 24, 2007, at 12:26 PM, Johannes Schindelin wrote:

>
> Oh! But the commit messages do no longer correspond to their  
> patches, do
> they?
>
> Example:
>
> In "onto", you have a sorely needed bugfix in main.c. In "from",  
> you have
> not. Then you do your transplant, and all of a sudden, the
> first transplanted commit _undoes_ that bugfix (because you take the
> contents at face value), but the commit message _cannot_ say so, or  
> even
> why.
>
> IMHO this makes no sense (and that is why I misunderstood it as  
> being a
> rebase).

It doesn't make sense on a sane repository.

I need the script to fix an insane, broken repository that was generated
by git-cvsimport [1]. cvsimport created commits attached to the wrong  
parent
in the first place. So the patches derived from this history are wrong.
They are different from the patches that you'd expect from the cvs  
repository.
The commit messages and the patches did never correspond. My script  
fixes
this relationship. Only after I transplanted the branch the commits and
their messages match.

The following is a different illustration of the same problem.  
Suppose you copy
a file and modify its contents somewhere else. Now you checkout the  
_wrong_
branch, but do not recognize, copy the file back and commit it. You'd be
writing a message as if the right branch would have been checked out.  
This
message describes what you believe you did. But because of the wrong  
branch
you may have done something completely different to the repository.  
You may
for example have reverted earlier changes. Your commit doesn't make  
any sense
before you transplanted it to the right branch. You don't want to  
apply a
patch to the right branch but transplant the content of your file.

	Steffen

[1] http://article.gmane.org/gmane.comp.version-control.git/50736
