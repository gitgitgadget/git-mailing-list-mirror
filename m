From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Sun, 8 Jul 2007 17:37:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707081729040.4248@racer.site>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 08 18:44:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ZsZ-0006vT-5O
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 18:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbXGHQou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 12:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbXGHQou
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 12:44:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:59919 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752710AbXGHQot (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 12:44:49 -0400
Received: (qmail invoked by alias); 08 Jul 2007 16:44:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 08 Jul 2007 18:44:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lyUIwX6YlGan509IQ67daxwHUqKdVHez42ESEbb
	ew31r7y3NZG9Zl
X-X-Sender: gene099@racer.site
In-Reply-To: <1183911808787-git-send-email-skimo@liacs.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51895>

Hi,

On Sun, 8 Jul 2007, skimo@liacs.nl wrote:

> 	bash-3.00$ time git-filter-branch test
> 	Rewrite 274fe3dfb8e8c7d0a6ce05138bdb650de7b459ea (425/425)
> 	Rewritten history saved to the test branch
> 
> 	real    0m30.845s
> 	user    0m13.400s
> 	sys     0m19.640s
> 
> 	bash-3.00$ time git-rewrite-commits
> 
> 	real    0m0.223s
> 	user    0m0.080s
> 	sys     0m0.140s

That is to be expected.  After all, the first is a script.  However, I 
really have ask: how often per hour do you want to run that program?

> The command line is more reminiscent of git-log.
> For example you can say
> 
> 	git-rewrite-commits --all
> 
> to incorporate grafts in all branches, or
> 
> 	git rewrite-commits --author='!Darl McBribe' --all
> 
> to remove all commits by Darl McBribe.

I am really unhappy that so much is talked about filtering out commits.  
That is amost certainly not what you want in most cases.  In particular, I 
suspect that most users would expect the _changes_ filtered out by such a 
command, which is just not true.

Further, I do not see much value in making this operation faster.  It is 
meant to be a one-time operation, for example when you open-source a 
product and have to cull a lot of history that you must not show for legal 
reasons.  It is a one-shot operation.  And having a script which works 
reliably is more valuable than having two programs, each with its own set 
of bugs.

So there are two things I see here that filter-branch cannot do yet.  The 
first is to rewrite _all_ branches, which should be easy to do, it only 
has to be done.

The second is to rewrite the commit messages so that the hashes are 
mapped, too.  But that should be relatively easy, too: you can provide a 
message filter, and you can use the provided "map" function.  If this 
seems to be what many people need, you can write a simple function and put 
it into filter-branch for common use.

BTW I am not at all opposed to changing the name from filter-branch to 
something that fits better.

Ciao,
Dscho
