From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 12:50:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708031243330.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com> 
 <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 13:50:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGvg5-0000qP-Vo
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 13:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760854AbXHCLun (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 07:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760844AbXHCLun
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 07:50:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:45327 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760794AbXHCLum (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 07:50:42 -0400
Received: (qmail invoked by alias); 03 Aug 2007 11:50:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 03 Aug 2007 13:50:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ClWIEZJgCrU//5aTxdxysQSA029aC9WP3wcZsmt
	OTMI87SjbnQ/lP
X-X-Sender: gene099@racer.site
In-Reply-To: <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54710>

Hi,

On Fri, 3 Aug 2007, Dmitry Kakurin wrote:

> The changes that I've made:
> * removed .git in /git directory to save space
> * installed gdb
> * applied my Vista fix
> * made self-extracting .rar archive

Completely forgot: we might want to do something like this at the end of 
/etc/profile:

	test ! -d /git || {
		mv /git $HOME/ &&
		cd $HOME/git &&
		make install &&
		git config remote.origin.url \
			git://repo.or.cz/git/mingw.git
		git config remote.origin.fetch \
			'+refs/heads/*:refs/remotes/origin/*'
		git config remote.mob.url \
			repo.or.cz:/srv/git/git/mingw.git
		git config remote.mob.fetch \
			+refs/remote/mob:refs/remotes/origin/mob
		git config remote.mob.push \
			master:mob
		git fetch
		git reset 51785010a4d3e7f6c3
	}

Please test that, and include it if it works.

It would be a bit easier if perl would work (it is installed, but for some 
reason (cd perl && make) does not do its job).

Ciao,
Dscho
