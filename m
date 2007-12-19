From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 17:16:14 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>  <20071218204623.GC2875@steel.home>  <200712182224.28152.jnareb@gmail.com>  <20071218222032.GH2875@steel.home>  <Pine.LNX.4.64.0712182239500.23902@racer.site>
 <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 02:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4nYd-0007RA-T7
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 02:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbXLSBQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 20:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753697AbXLSBQe
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 20:16:34 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55607 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753375AbXLSBQd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 20:16:33 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBJ1GEaR017293
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 17:16:16 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBJ1GE6F031532;
	Tue, 18 Dec 2007 17:16:14 -0800
In-Reply-To: <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
X-Spam-Status: No, hits=-2.413 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_34
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68852>



On Tue, 18 Dec 2007, Dana How wrote:
> 
> Both of your counterexamples use 2 disjoint directory trees:
> C: vs D:,  or trees on different machines.
> 
> The cases we are talking about are all subtrees of the working tree.
> There is a useful cwd suffix.

No.

The cases we're talking of are *not* subtrees of the working tree.

The SHA1 of a commit may well be a totally disjoint tree. Try it in the 
git repository with something like

	git show origin/man:man1/git-fsck.1

or

	git show origin/todo:TODO

and realize that Dscho's examples of using the DOS/Windows drive letters 
is actually a really good example of what that <commit>:<pathname> syntax 
is. 

In fact, you can very well think of the commit/tree as a "drive letter". 
It really does go into another namespace entirely. It's just that often 
that namespace does bear some relationship to the currently checked out 
branch. But that's just an "often", it's not at all a given.

> Don't you think that
>   git <op> commit:./file.c
> could occasionally be more convenient than
>   git <op> commit:very/long/and/boring/path/equal/to/cwd/file.c

It's not about "convenience". It's about *sanity* and good design. And the 
fact is, that "commit:path" format really has nothing to do with the CWD 
in the general case.

		Linus
