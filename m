From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Tue, 23 Aug 2005 14:20:58 -0700
Message-ID: <2655.1124832058@lotus.CS.Berkeley.EDU>
References: <7v64u1ya7c.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 23:23:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7gCg-0000ID-Ro
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 23:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVHWVVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 17:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVHWVVE
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 17:21:04 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:45505 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932149AbVHWVVC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 17:21:02 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id j7NLKx6d002657;
	Tue, 23 Aug 2005 14:20:59 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id j7NLKxXX002656;
	Tue, 23 Aug 2005 14:20:59 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7v64u1ya7c.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7672>

And Junio C Hamano writes:
 - > BTW, how would people feel about replacing the 
 - > setenv() and unsetenv() calls with the older putenv()?
 - No comment on this one at this moment until I do my own digging
 - a bit.

If you're interested, I have a few patches in
  http://www.cs.berkeley.edu/~ejr/gits/git.git#portable
that let git compile with xlc on AIX and Sun's non-c99 
cc on Solaris.  Changes:
 +    Replace C99 array initializers with code.
 +    Replace unsetenv() and setenv() with older putenv().
 +    Include sys/time.h in daemon.c.
 +    Fix ?: statements.
 +    Replace zero-length array decls with [].
The top two may or may not be acceptable.  The third may
not be necessary if I can find the right -Ds for fd_set.
The last two just remove GNU C extensions.  Makefile 
changes (including extra -Ds for features) not included, 
but could be.  Tell me if you want any of these mailed.

Not all the tests pass on non-Linux, but I won't have time 
to look at them for a bit.  With the GNU findutils and 
coreutils, it works well enough for basic use.  The failing 
tests might be from using non-GNU utilities.  Rooting out
all the dependencies is a tad painful.

Jason
