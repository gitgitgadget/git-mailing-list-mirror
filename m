From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git push" logic changed?
Date: Fri, 20 Jan 2006 16:54:28 -0800
Message-ID: <7vacdq2yez.fsf@assigned-by-dhcp.cox.net>
References: <20060120225336.GA29206@kroah.com>
	<7vlkxa30rd.fsf@assigned-by-dhcp.cox.net>
	<20060121001547.GA30712@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 01:54:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F071V-0004rk-Go
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 01:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWAUAyb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 19:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWAUAyb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 19:54:31 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:1705 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932216AbWAUAya (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 19:54:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121005315.KJCN6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 Jan 2006 19:53:15 -0500
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060121001547.GA30712@kroah.com> (Greg KH's message of "Fri, 20
	Jan 2006 16:15:47 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14982>

Greg KH <greg@kroah.com> writes:

> Well what should I do then to push to "orgin"?
>...
> Yes, but "git push origin" used to push my local changes there, and
> that's all I really want.
>
> Someone off-list told me I could edit my .git/branches/parent file to
> fix this issue for that branch.  Since I hand-created that file in the
> first place, that's not a bit deal.  But I was relying on git to get the
> "origin" branch right, as I didn't edit it at all :)

If you cloned from "origin", then you would have gotton
something like:

	URL: that.machine:/this/directory.git
        Pull: master:origin

in your ".git/remotes/origin".  Since there are more downloaders
and individual developers than subsystem maintainers, this is a
good default for the former class of people.

You as the tree owner would then add "Push:" line(s) to push
back from your local repository.  For example:

	$ cat .git/remotes/origin	
	URL: that.machine:/this/directory.git
        Pull: master:origin
	Push: master:master

With this,

	$ git push origin

would push master branch to that.machine:/this/directory.git/
repository.  With --tags or --all:

	$ git push --tags origin
        $ git push --all origin

These "Push:" lines are for people who have write access to the
other side (which is a minority compared to downloaders), so git
does not create them by default when you clone the repository.
