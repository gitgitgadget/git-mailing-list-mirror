From: Junio C Hamano <junkio@cox.net>
Subject: Re: Newbie falls at first hurdle
Date: Sun, 18 Sep 2005 13:10:23 -0700
Message-ID: <7vfys22l3k.fsf@assigned-by-dhcp.cox.net>
References: <alan@chandlerfamily.org.uk>
	<200509181347.11403.alan@chandlerfamily.org.uk>
	<7vek7m5m0z.fsf@assigned-by-dhcp.cox.net>
	<200509182011.10689.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 22:11:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH5Uk-0000oT-EW
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 22:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVIRUKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 16:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVIRUKc
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 16:10:32 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35306 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932184AbVIRUKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 16:10:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050918201024.VFVD11628.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Sep 2005 16:10:24 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200509182011.10689.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Sun, 18 Sep 2005 20:11:10 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8809>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> I effectively loaded both my current code and the day before's
> backup into git as two separate branches.
>
> What I was then trying to do, via various attempts with git diff -p was to 
> extract small chunks of updates (ie limit scope over a few files).  Edit the 
> result to limit the diff to cover a small update and then apply it to a my 
> current stuff to slowly undo some of the mess that I had made. 

Ah, what you have to work with are only date-based snapshots of
various states (i.e. the separation between one snapshot and
another does not necessarily have much to do with a single set
of logically isolated changes).

I end up doing that myself, although the situation I'd be in
tend to be one logical change spread over multiple commits (the
other way around from your case where one diff contains many
logically unrelated chagnes).  I run git-diff-tree -p between
states to obtain a set of N diffs, look them over and hand edit
them to collect related things together and separate independent
things separate to create a different set of M diffs. then
create a temporary branch that is reset to the state before
those N diffs and use applymbox to apply M diffs.  This is
essentially what Martin suggested.

In your case, each diff you have contains unrelated changes and
you have to move things around.  It's a pain but I am afraid
there are not any SCM can do much to help you.
