From: Junio C Hamano <junkio@cox.net>
Subject: Re: Expected Behavior?
Date: Sun, 06 Nov 2005 18:01:28 -0800
Message-ID: <7vd5ldusg7.fsf@assigned-by-dhcp.cox.net>
References: <E1EYsny-0004hq-IW@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Nov 07 03:02:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYwKQ-0006mt-39
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 03:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVKGCBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 21:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVKGCBa
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 21:01:30 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:42494 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932403AbVKGCBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 21:01:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107020059.NVMJ4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 21:00:59 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EYsny-0004hq-IW@jdl.com> (Jon Loeliger's message of "Sun, 06
	Nov 2005 16:16:02 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11247>

Jon Loeliger <jdl@freescale.com> writes:

>     git checkout -b dev
>
>     echo "More for file1" >> file1
>     rm -f file2
>     echo "Another file!" > file3
>
>     git update-index file1
>     git update-index --force-remove file2
>     git add file3

You do not have file2 in the working tree, so regular --remove
would do.

	git-update-index --add --remove file1 file2 file3

>     git merge "Grab dev stuff" master dev

This is good.  We used to use (and the tutorial only talks
about) git-resolve to do this step, like this:

	git-resolve master dev 'Merge dev branch'

And I've kept using git-resolve myself; not that I do not trust
git-merge but purely from inertia, although I was the one who
did 'git merge' ;-).  Maybe I should first update the tutorial
to use git-merge instead of git-resolve.

It appears that as the everyday workhorse, using Daniel's
git-merge-resolve is stable through git-merge have proven stable
enough.  So here is a question.  Do people mind if 'git-resolve'
and 'git-octopus' are dropped before 1.0?  This means 2 less
programs in your /usr/bin ;-).
