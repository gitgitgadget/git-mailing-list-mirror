From: Junio C Hamano <junkio@cox.net>
Subject: Re: reverting back both working copy and commits
Date: Wed, 11 Jan 2006 11:37:26 -0800
Message-ID: <7vslrutv2h.fsf@assigned-by-dhcp.cox.net>
References: <7ac1e90c0601110832u6fc3a3bcwb7e584445610e53f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 20:42:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewlmo-00025s-8y
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 20:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWAKTh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 14:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWAKTh3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 14:37:29 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35819 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932456AbWAKTh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 14:37:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111193634.DBXG15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 14:36:34 -0500
To: Bahadir Balban <bahadir.balban@gmail.com>
In-Reply-To: <7ac1e90c0601110832u6fc3a3bcwb7e584445610e53f@mail.gmail.com>
	(Bahadir Balban's message of "Wed, 11 Jan 2006 16:32:16 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14501>

Bahadir Balban <bahadir.balban@gmail.com> writes:

> % git-branch master-2006-get-rid-of-commits
>
> % git-reset --hard [sha1id]
>
> where sha1id is the id of commit I want to revert back to. After this,
> git-log points at the right commit (the one with [sha1id]) as the last
> commit made. However, the working copy is left in the original state,
> i.e with the unwanted changes.

Eh?  That should not happen.

Could you elaborate?

	$ git diff master-2006-get-rid-of-commits

should show differences between the wrongly committed state and
your working tree.

	$ git diff --cached HEAD ;# or git diff --cached [sha1id]

should show *nothing* and

	$ git diff HEAD ;# or git diff [sha1id]

should also show nothing.

What is different between what I just described "Thess should
happen" and what actually happens to you?  I use "git reset
--hard" all the time, probably a lot more often than other
people, and I'd be surprised if things are not working.

What "git reset --hard" would leave behind are files in the
working tree that you had when you made the wrongly done commit,
which were *not* known to git (i.e. you forgot to "git add"
before committing).  Since they are not known to git, "reset --hard"
does not touch them.
