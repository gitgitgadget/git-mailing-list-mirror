From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use printf rather than echo -n.
Date: Tue, 06 Dec 2005 18:04:25 -0800
Message-ID: <7vfyp5zmqe.fsf@assigned-by-dhcp.cox.net>
References: <20512.1133907712@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 03:05:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejofd-0000Jn-6x
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 03:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbVLGCEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 21:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVLGCEd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 21:04:33 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62436 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964852AbVLGCEc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 21:04:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207020312.WRMH17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 21:03:12 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <20512.1133907712@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Tue, 06 Dec 2005 14:21:52 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13315>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> On AIX, there is no -n option to the system's echo.  Instead,
> it needs the '\c' control character.  We could replace
>   echo -n "foo"
> with
>   echo -e "foo\c"
> but printf is recommended by most man pages.  Tested on AIX
> 5.3, Solaris 8, and Debian.

Hmmmmmmmmmmmmmmmmmmmmmmmm.

Perhaps printf '%s' "$blah" to futureproof, instead of just
saying printf "$blah"?

<rant mode on>
While I do not have anything aginst system without "sane" echo,
I really do not like it.  Not your solution, but *having to do*
something like that.

metaconfig Configure does "echo $n frotz $c" with n=-n or c=\\c
set appropriately; autoconf does the same with $ac_n $ac_c.
IIRC, I think ancient autoconf did "echo | tr -d '\012'".  

These are far worse than a single printf, although they may be
more portable.

</rant mode off>

As a traditionalist, if I were doing it myself I would probably
pipe echo to tr, but I am lazy so I'd take your patch as is ;-).
