From: Junio C Hamano <junkio@cox.net>
Subject: Re: What will happen to git.git in the near future
Date: Sun, 01 Oct 2006 11:47:45 -0700
Message-ID: <7vlknz27qm.fsf@assigned-by-dhcp.cox.net>
References: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net>
	<7vd59c2vev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610011132040.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 20:47:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6Lu-0000hW-OI
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 20:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWJASrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 14:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWJASrr
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 14:47:47 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:37346 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932176AbWJASrq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 14:47:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061001184746.HBUK18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sun, 1 Oct 2006 14:47:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id V6no1V00C1kojtg0000000
	Sun, 01 Oct 2006 14:47:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610011132040.3952@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 1 Oct 2006 11:38:06 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28186>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 1 Oct 2006, Junio C Hamano wrote:
>>
>> I've tagged the tip of the master as v1.4.3-rc1 tonight, after
>> merging things that I listed in the message last week to be
>> merged from "next".
>> 
>> Have fun.
>
> I hate that perl crud.
>...
> 	Git.xs: In function 'XS_Git_xs_version':
> 	Git.xs:62: error: 'GIT_VERSION' undeclared (first use in this function)
> 	Git.xs:62: error: (Each undeclared identifier is reported only once
> 	Git.xs:62: error: for each function it appears in.)
> 	make[1]: *** [Git.o] Error 1
> 	make[1]: Leaving directory `/home/torvalds/git/perl'
> 	make: *** [all] Error 2
>
> I don't like how git now doesn't compile just out of the box on a 
> perfectly regular FC5 box.

Everybody hated the perl crud, so we removed Git.xs and is not
even part of the source anymore.

This is a symptom that Git.c leftover from an earlier build was
in the working tree.  Could you try running "rm -f perl/Git.c"
before building and see if it helps?

The sad thing is that we do not ship Git.xs nor generate Git.c
from our Makefile, and while it is nicer to have an entry to
remove leftover perl/Git.c in our Makefile, it does not really
help in all cases.  We discussed this exact issue a few days
ago:

http://thread.gmane.org/gmane.comp.version-control.git/27730/focus=27853
