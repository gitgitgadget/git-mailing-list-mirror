From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Sun, 28 Aug 2005 03:14:27 -0700
Message-ID: <7vll2mmkqk.fsf@assigned-by-dhcp.cox.net>
References: <2655.1124832058@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 12:15:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9KBZ-0007r3-6J
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 12:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVH1KOa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 06:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbVH1KOa
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 06:14:30 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:48305 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750897AbVH1KO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 06:14:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828101428.GQUO19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 06:14:28 -0400
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <2655.1124832058@lotus.CS.Berkeley.EDU> (Jason Riedy's message of
	"Tue, 23 Aug 2005 14:20:58 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7867>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> If you're interested, I have a few patches in
>   http://www.cs.berkeley.edu/~ejr/gits/git.git#portable
> that let git compile with xlc on AIX and Sun's non-c99 
> cc on Solaris.

I've taken a look at them.  Thanks.

> Changes:
>  +    Replace C99 array initializers with code.

I presume this is to help older compilers?

>  +    Replace unsetenv() and setenv() with older putenv().

I wonder how buggy various implementations of
putenv("THIS_ENV_VAR") are to remove the variable.

>  +    Include sys/time.h in daemon.c.
>  +    Fix ?: statements.

I do not have much problem with these two.

>  +    Replace zero-length array decls with [].

This I am ambivalent about.  If we are just trying to help older
compilers (see your "array initializers" patch), we should be
doing C90 way of "array[1]" and teach users to subtract 1 from
the allocate count.  While I do not have much objection against
using C99 flexible array member notation, I wonder how people
find being able to compile with older compilers a major issue..
