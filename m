From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] shortlog: prompt when reading from terminal by mistake
Date: Fri, 09 Mar 2007 16:39:40 -0800
Message-ID: <7vwt1q2apf.fsf@assigned-by-dhcp.cox.net>
References: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703080827170.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 01:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPpck-00029V-L0
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 01:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbXCJAjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 19:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbXCJAjm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 19:39:42 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43348 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbXCJAjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 19:39:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310003942.HOCJ3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 19:39:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Yofg1W00X1kojtg0000000; Fri, 09 Mar 2007 19:39:40 -0500
In-Reply-To: <Pine.LNX.4.64.0703080827170.10832@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 8 Mar 2007 08:37:44 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41825>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Sure, this probably gets some cases (and the one you tried in particular), 
> but if you pipe the output to a pager, I doubt it's actually all that 
> useful.
>
> To simulate a "wait a long time without output" case, try this:
>
> 	( echo "Important warning" >&2 ; sleep 10) | less -S
>
> and at least for me, I don't see squat _in_case_I'm_at_the_top_ of the 
> window, simply because "less" will clear the screen for me.

> In other words, putting warnings on stderr usually isn't all that useful 
> when you have something like a pager that will do tty stuff - it will 
> easily overwrite the warning so quickly that you'll never see it at all.

That is correct in general, but you are being unfair.

You know git-shortlog has built-in pager _and_ you know _you_
added select(2) before spawning less, so that when that warning
is emitted, less hasn't even started running --- it cannot clear
the display.
