From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cancelling certain commits
Date: Mon, 16 Jan 2006 15:43:39 -0800
Message-ID: <7vvewjlowk.fsf@assigned-by-dhcp.cox.net>
References: <7ac1e90c0601160557r78599886nca9be9b6672a1bd7@mail.gmail.com>
	<43CBAC0B.3020104@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bahadir Balban <bahadir.balban@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 00:43:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eye0m-0005ng-52
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 00:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWAPXnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 18:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWAPXnl
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 18:43:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:5602 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751227AbWAPXnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 18:43:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060116234131.VYIU26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 18:41:31 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14768>

Andreas Ericsson <ae@op5.se> writes:

 ... (all the good stuff not repeated).

As a general rule, first of all, make sure that this kind of
"cleaning up the history" can be done only before you make your
history available to others, and not after.

> # make sure "git status" doesn't show any changes
>
> $ git branch anchor # to make a safe point to reset to if things go bad
> $ git reset --hard HEAD~7 # undo commits 3 - 10
> # replay commits 4, 5, 6, 8, 9
> $ for i in 6 5 4 2 1; do git cherry-pick -r anchor~$i || break; done
> # replay commit 10
> $ git cherry-pick -r anchor

I think "6 5 4 2 1 0" would be sweeter.  rev~0 == rev

> ..., and never *ever*
> do
>
> $ git prune
>
> on a repo where you're juggling loose commits like this (although that
> should actually be safe when you create 'anchor' as a branch rather
> than as a tag, which Junio usually recommends).

Sorry, I do not understand this part.  tags and branch heads are
used in the same way to determine what objects to protect from
"prune", so I thought there was no difference from the safety
point of view between the anchor being a branch or a tag.
