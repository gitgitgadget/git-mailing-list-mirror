From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add a "git-describe" command
Date: Tue, 27 Dec 2005 16:42:05 -0800
Message-ID: <7v7j9q3vdu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
	<Pine.LNX.4.64.0512241409300.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 01:43:30 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErPPZ-0003w8-KC
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 01:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVL1Ama (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 19:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVL1Am2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 19:42:28 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29892 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932419AbVL1AmH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 19:42:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051228004210.SNIB25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Dec 2005 19:42:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14089>

Linus Torvalds <torvalds@osdl.org> writes:

> The problem is not that it generates GIT_VERSION wrong. The problem is 
> two-fold:
>  - it should notice when "git-describe" doesn't exist, and fall back on 
>    the old less-than-descriptive behaviour
>  - it doesn't do dependencies correctly (ie it should now make "git" 
>    depend on the version number, but it doesn't, so it doesn't re-build 
>    git after a commit/pull)
>
> but at least it shows the _idea_ of using git-describe.
>
> With this I get
>
> 	[torvalds@g5 git]$ git --version
> 	git version v1.0.4-g6e9961d6
>
> which I think is better than "1.0.GIT" which doesn't say anything about 
> what the _actual_ version was.

I do not think 1.0.GIT is a good name either, so obviously there
is a room for improvement.

One problem with git-describe is that getting tags is a concious
user action, and you need to do "git fetch --tags" from time to
time in order to see the v1.0.4-g6e9961d6 name.  It could well
say v1.0.3-g6649c466 if the end user has built on top of
otherwise fully up-to-date maint branch without fetching v1.0.4
nor v1.0.5 tags, so when we learn that the v1.0.3-g6649c466 does
not work for an end-user, it would not help us to look for
regression between v1.0.3 and v1.0.4.  All it tells us is that
it is not older than v1.0.3, and it may well be the v1.0.5
without any local modification.
