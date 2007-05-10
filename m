From: Junio C Hamano <junkio@cox.net>
Subject: Re: Switching branch before commit
Date: Thu, 10 May 2007 13:08:44 -0700
Message-ID: <7v3b24jvar.fsf@assigned-by-dhcp.cox.net>
References: <769697AE3E25EF4FBC0763CD91AB1B0201D496E7@MBGMail01.mobot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Ron Parker" <ron.parker@mobot.org>
X-From: git-owner@vger.kernel.org Thu May 10 22:08:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmEwV-0004rj-12
	for gcvg-git@gmane.org; Thu, 10 May 2007 22:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931AbXEJUIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 16:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755604AbXEJUIq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 16:08:46 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49742 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289AbXEJUIq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 16:08:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510200845.YBAF13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 16:08:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xY8k1W00c1kojtg0000000; Thu, 10 May 2007 16:08:45 -0400
In-Reply-To: <769697AE3E25EF4FBC0763CD91AB1B0201D496E7@MBGMail01.mobot.org>
	(Ron Parker's message of "Thu, 10 May 2007 14:43:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46896>

"Ron Parker" <ron.parker@mobot.org> writes:

> I know this is probably a FAQ and I thought I found it somewhere once,
> but... How do I commit changes from in my working directory to another
> (possibly non-existent) branch?
>  
> All too often I am working on changes and realize I am sitting on master
> or a topic branch and I need to commit my mods to different branch.  I
> really don't like:
>  
>     git commit
>     git branch <other-branch>
>     git reset --hard HEAD^

I do not like that either, and I wouldn't do that.  In fact that
would not work, as "git branch" would not switch to the other
branch you just created.

I would do:

	$ git checkout -b other-branch

which would create and switch to other-branch, based on the
current HEAD (in your case, 'master'), WITHOUT disrupting what
is in your working tree and the index.

and then (perhaps after working on it some more to perfection):

	$ git commit

to commit that work I (mistakenly) started on 'master' in that
other branch.  Then I would come back to master:

	$ git checkout master
