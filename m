From: Sean <seanlkml@sympatico.ca>
Subject: Re: rfe: bisecting with a tristate
Date: Tue, 24 Jul 2007 09:40:17 -0400
Message-ID: <20070724094017.d14688e5.seanlkml@sympatico.ca>
References: <Pine.LNX.4.64.0707241459460.18990@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:41:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDKdU-0008CS-Op
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbXGXNkr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755129AbXGXNkq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:40:46 -0400
Received: from bay0-omc2-s9.bay0.hotmail.com ([65.54.246.145]:31383 "EHLO
	bay0-omc2-s9.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753313AbXGXNkp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 09:40:45 -0400
Received: from BAYC1-PASMTP13.bayc1.hotmail.com ([65.54.191.186]) by bay0-omc2-s9.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 24 Jul 2007 06:40:45 -0700
X-Originating-IP: [69.156.137.240]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.137.240]) by BAYC1-PASMTP13.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 24 Jul 2007 06:41:26 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IDKd1-0007W0-C2; Tue, 24 Jul 2007 09:40:43 -0400
In-Reply-To: <Pine.LNX.4.64.0707241459460.18990@fbirervta.pbzchgretzou.qr>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 24 Jul 2007 13:41:27.0094 (UTC) FILETIME=[555AB560:01C7CDF8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53590>

On Tue, 24 Jul 2007 15:21:19 +0200 (CEST)
Jan Engelhardt <jengelh@computergmbh.de> wrote:


Hi Jan,

> I have an idea about handling commits that do not compile at 
> all in git-bisect.
> For example:
> 
> git bisect start
> git bisect bad v2.6.23-rc1
> # bad: [f695baf2df9e0413d3521661070103711545207a] Linux 2.6.23-rc1
> git bisect good v2.6.22
> # good: [098fd16f00005f665d3baa7e682d8cb3d7c0fe6f] Linux 2.6.22
> 
> Then 1f1c2881f673671539b25686df463518d69c4649 will be the next commit 
> git bisect hands out. Now let's assume this commit would not compile. 
> What would the user do? git-bisect good or git-bisect bad?

Check out the section "Avoiding to test a commit" in the git-bisect
man page; it addresses this issue.  Basically you just use git-reset
to pick a different nearby commit to compile, and then continue with
git bisect good/bad.

> 
> Assume a commit previous to 1f..49 caused an oops (but the user does not 
> know yet), and the user said 'good' on 1f..49 because he did not know 
> what to say (since it did not compile). Then bisect would go the wrong 
> way, marking all left to 1f..49 as good.
> 
> Ideally, there should be like "git bisect dunno-try-left" and "git 
> bisect dunno-try-right", which allow the user to skip checking 1f..49 
> and instead try the next commit left or right of 1f..49 (to either go to 
> a commit before the compile failure, or after it).
>

Sean
