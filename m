From: Junio C Hamano <junkio@cox.net>
Subject: Re: deleting a branch
Date: Tue, 13 Sep 2005 09:05:23 -0700
Message-ID: <7v4q8p3qd8.fsf@assigned-by-dhcp.cox.net>
References: <4326F2AE.50108@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 18:07:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFDHn-0003Wp-Pc
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 18:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVIMQF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 12:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVIMQF3
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 12:05:29 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:47785 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964834AbVIMQF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 12:05:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913160524.PVFA9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 12:05:24 -0400
To: cel@citi.umich.edu
In-Reply-To: <4326F2AE.50108@citi.umich.edu> (Chuck Lever's message of "Tue,
	13 Sep 2005 11:39:26 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8469>

Chuck Lever <cel@citi.umich.edu> writes:

> a couple of newbie questions.
>
> 1.  how do i delete a branch?

"rm -f .git/refs/heads/no-longer-needed".  Make sure your
working tree is not on that branch (i.e. .git/HEAD should not be
pointing at it).

I have not introduced "git branch -d no-longer-needed" because
I think that should do a bit more than "rm -f".  For example:

 - making sure you are not on that branch (obvious),

 - check if all changes on that branch are included in the
   master branch or some other branch (easy if we hardcode "master";
   checking all other branches might be nicer but expensive).

 - otherwise tell the user this and that changes will be forever
   lost and get a confirmation before removing.

> 2.  is there a conventional place where branch description files reside?

No, but somebody proposed a convention a couple of days ago.
