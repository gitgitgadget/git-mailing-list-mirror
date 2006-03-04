From: Junio C Hamano <junkio@cox.net>
Subject: Re: On recording renames
Date: Fri, 03 Mar 2006 22:16:58 -0800
Message-ID: <7v64muvin9.fsf@assigned-by-dhcp.cox.net>
References: <7vfylyx3e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paul@hibernia.jakma.org
X-From: git-owner@vger.kernel.org Sat Mar 04 07:17:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFQ4n-0007Rm-Qf
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 07:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWCDGRC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 01:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWCDGRC
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 01:17:02 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:22400 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751001AbWCDGRA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 01:17:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060304061415.WNTM17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Mar 2006 01:14:15 -0500
To: git@vger.kernel.org
In-Reply-To: <7vfylyx3e3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 03 Mar 2006 20:03:32 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17174>

Junio C Hamano <junkio@cox.net> writes:

>
>        a1--a2--a3--a4--a5--A
>       /                     \
>   ---O---b1--b2--b3--b4--B---* 
>
>     O has hello.c
>     a1 renames file hello.c to world.c and a2-a5-A modifies world.c
>     b1-b4-B modifies hello.c 
>     we are about to merge A and B
>
>     comparing O and A may not notice O's hello.c and A's world.c
>     are similar!
>
> But you are allowed to write a new merge strategy that is more
> careful about renames.  There is no reason you can only look at
> three trees.  Such a merge strategy, when given commit A and B,
> would walk the history back, running "diff-tree -M" for each
> commit along the way, and difference between O's hello.c and
> a1's world.c would be hopefully *much* smaller than O's hello.c
> and A's world.c -- even the current similarity estimator may
> recognize it is a rename.

A bit more on merges and renames.  The thread that started on
Dec 16 2005 by Don Zickus is about a case that anybody
interested in renaming merge should think about.  Unfortunately
gmane web interface says it is "down for maintenance" so I
cannot give an URL, but the message IDs of key messages are:

        <68948ca0512161205x3d5921bfm3bfcaa64f988eb99@mail.gmail.com>
        <7vbqzgbcyv.fsf@assigned-by-dhcp.cox.net>

The whole thread is worth reading, but the punch line is:

        The transition happened over time with multiple commits.
        You cannot record "this is the rename" by attributing that
        information to one particular commit.
