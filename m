From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 12:13:23 -0700
Message-ID: <7vhdgvdqgc.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
	<7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 21:12:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZvs5-0005F7-ED
	for gcvg-git@gmane.org; Sun, 22 May 2005 21:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVEVTNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 15:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVEVTNc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 15:13:32 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:65495 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261615AbVEVTN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 15:13:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522191323.KPQF23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 15:13:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 22 May 2005 11:35:34 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have to have some time to ruminate about this, but I am
leaving for the day and won't be back till late afternoon (PDT).

My feeling, knee-jerk reaction, to what you are proposing is
that you are trying to go half-way back to the earlier format
that had addremove/change distinction.

I have to disagree that having path for the non-existent side is
_illogical_.  I ask "what is different between tree A and tree
B", and the diff-raw answers "there was no path0 in tree A but
path0 exists in tree B; there was path1 in tree A but now path2
is there instead in tree B".  To me, the answer would be more
illogical if the diff-raw said "there was no /dev/null in tree
A, and instead path0 exists in tree B.", which is what your
suggestion makes it say if I am reading you right.  Also, again
this is my knee-jerk reaction without thinking things through,
you are hiding (not losing, because having a rename/copy entry
that removes a path _is_ illogical) information by not saying
what no longer exists by replacing the right hand side with
/dev/null and having the reader to infer what is removed.  I
want the reader to be able to say "I can look at only right hand
side to see what is in the right hand side tree".  With
/dev/null munging, it becomes necessary to sometimes look at the
other side.

