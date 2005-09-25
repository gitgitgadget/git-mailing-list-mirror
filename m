From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Sun, 25 Sep 2005 16:46:13 -0700
Message-ID: <7v7jd4n22i.fsf@assigned-by-dhcp.cox.net>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
	<7vaci1nfwa.fsf@assigned-by-dhcp.cox.net>
	<87psqwzs3x.fsf@ualberta.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 01:47:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJgCm-0003N0-C3
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 01:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbVIYXqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 19:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbVIYXqU
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 19:46:20 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:39161 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751513AbVIYXqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 19:46:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050925234614.MZLR9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Sep 2005 19:46:14 -0400
To: Tom Prince <tom.prince@ualberta.net>
In-Reply-To: <87psqwzs3x.fsf@ualberta.net> (Tom Prince's message of "Sun, 25
	Sep 2005 16:42:58 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9294>

Tom Prince <tom.prince@ualberta.net> writes:

>> When you already have a repository to track git.git, I would
>> recommend to have something like this in .git/remote/origin:
>>
>>     URL: http://kernel.org/pub/scm/git/git.git
>>     Pull: master:origin maint:maint +pu:pu
>>
>
> A warning when you do this. If you say 
>
>   git pull origin
>
> then your master will be updated with an octopus merge of the three heads.

Ahhhhhhhh.  That is true.  I always do "git fetch" and never do
"git pull" against anything but a local repository, heads
explicitly specified.  You are right.  The defaulting behaviour
is incredibly broken.

Do people agree it is a good idea to change the "git pull
origin" to mean "fetch all the default refs specified on Pull:
lines, and merge only the first one into the current branch"?

"git pull" without remote nor refspecs is a synonym to "git pull
origin" as before, and 99.99% of the time "git pull" from a
remote repo without explicit refspec is doing just one head
merge, so I think this is a sane default, much saner than the
current mess, while still allowing you to keep track of what's
happening in the other branches by doing fetches of all the
heads at once.

Opinions?
