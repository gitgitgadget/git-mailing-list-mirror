From: Junio C Hamano <junkio@cox.net>
Subject: Re: git log -S problem
Date: Sun, 20 May 2007 14:05:41 -0700
Message-ID: <7vy7jjjjdm.fsf@assigned-by-dhcp.cox.net>
References: <200705202115.39325.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun May 20 23:06:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpsbE-0002ey-NE
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbXETVFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756548AbXETVFu
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:05:50 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:59683 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756569AbXETVFu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:05:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520210547.EQAP12190.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 17:05:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1Z5i1X0051kojtg0000000; Sun, 20 May 2007 17:05:45 -0400
In-Reply-To: <200705202115.39325.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sun, 20 May 2007 21:15:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47917>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> There is something odd with -S of git log. Try this in your git.git:
>
> $ git log --pretty=oneline -Sbuiltin-merge-base -- Makefile 
> 71dfbf224ff980f4085f75868dc409118418731e Make merge-base a built-in.
>
> $ git log --pretty=oneline -Smerge-base -- Makefile
> e468305a954d95a26bfcdec3bc6e4bd477d95676 [PATCH] Remove the explicit ...
> a3df180138b85a603656582bde6df757095618cf Rename git core commands ...
> cef661fc799a3a13ffdea4a3f69f1acd295de53d Add support for alternate ...
> e590d694ead8d50c2afc7086161d4ddc5d907655 Add more header dependencies.
> 6683463ed6b2da9eed309c305806f9393d1ae728 Do a very simple "merge-base"...
>
> $ git version
> git version 1.5.2
>
> I had expected that the set of commits found by the second search string are a 
> proper superset of those found by the first one. What's wrong here? Why does 
> a search for 'merge-base' not find occurences of 'builtin-merge-base'?

71dfbf224 removes one line that has "git-merge-base$X" and adds
one line that has "builtin-merge-base.o".  If you count the
number of occurences of substring "builtin-merge-base" in the
preimage and the postimage, you see one addition.  If you count
the same for substring "merge-base", the net difference is 0.
