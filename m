From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-fetch: print the new and old ref when fast-forwarding
Date: Sat, 25 Feb 2006 12:53:32 -0800
Message-ID: <7vlkvz6tyr.fsf@assigned-by-dhcp.cox.net>
References: <44003D6D.2010406@etek.chalmers.se>
	<Pine.LNX.4.63.0602252107110.17999@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 25 21:53:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FD6Q9-0007cW-HO
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 21:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWBYUxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 15:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWBYUxh
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 15:53:37 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21496 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1161109AbWBYUxg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 15:53:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060225205054.YMAE17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Feb 2006 15:50:54 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602252107110.17999@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 25 Feb 2006 21:08:37 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16763>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This is useful when you check out new changes with gitk.
>> Just copy/paste the old ref into gitk from the terminal.
>
> Why does "gitk ORIG_HEAD..HEAD" not work? (It also does the correct thing 
> when pulling...)

For most projects and repositories with single interesting head,
that would work just fine.

If you use additional Pull: lines to track more than one remote
refs, this patch would help.

For example, if you are tracking my "next" while keeping an eye
on my "master" and "pu", your .git/remotes/origin file may have
something like this:

	URL: git://git.kernel.org/pub/scm/git/git.git
        Pull: next:origin
        Pull: master:ko-master
        Pull: pu:ko-pu

When "git pull origin" pulls my next branch into your current
branch (typically "master"), it also fast forwards your tracking
branches ko-master and ko-pu.  If you want to see what I merged
in the meantime, you would want to get the old value of
ko-master and the new value and feed them to gitk (or git log).
ORIG_HEAD in this case was the old value of _your_ current
branch head, and is not useful to see what happened to my master
branch.
