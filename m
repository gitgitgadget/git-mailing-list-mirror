From: Junio C Hamano <junkio@cox.net>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 13:00:18 -0800
Message-ID: <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
	<Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
	<Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	<20051031195010.GM11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 22:06:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWgrS-0006bJ-Q4
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 22:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVJaVAf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 16:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVJaVAe
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 16:00:34 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:63469 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932520AbVJaVAU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 16:00:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051031205931.YUFS2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 15:59:31 -0500
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20051031195010.GM11488@ca-server1.us.oracle.com> (Joel Becker's
	message of "Mon, 31 Oct 2005 11:50:10 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10887>

Joel Becker <Joel.Becker@oracle.com> writes:

> 	In the distributed world, a pull of the "feature" repository
> pulls in all changes - the full history of the work.  This includes
> aborted tries, rewritten pieces, bug fixes, etc.  Here, the main
> repository has the detritus of the development process, but that also
> contains the full context of the work.  It goes against your claim that:
>
>> So with the distributed model, you don't have to publicly humiliate 
>> yourself when you do something stupid. Similarly, you don't have to 
>
> because that history will contain all your something stupids, plus your
> fixes for them.

Do you think anybody is that perfect?

What happens in reality is something like this:

 - you have a master tree, and your own throwaway topic
   branches.

 - you play in your own topic branches.  you make stupid
   mistakes and redo your changes many times.

 - when the tips of your topic branches are in good shape, you
   review the changes from the master tree as a whole, without
   the history.

 - you decompose the diff between the tips of your topic branch
   and the master branch into logical steps.

 - you branch off "sanitized" branches from the tip of the
   master, and apply the decomposed diffs, making one commit per
   logical change, until all your decomposed diffs are applied.

 - after making sure that the tips of the sanitized branches
   match the tips of their corresponding topic branch you did
   your work on, you throw away your true history and pretend
   you are perfect human.  Either ask your peer to pull from
   your sanitized branch tips, or run git-format-patch between
   the master and the sanitized branch tips and send them out as
   patches.

I do not know about the kernel tree but I would be surprised if
any self-respecting developer wouldn't be doing this.  The
review-decomposition-reapplication cycle is *very* important for
both keeping the public history clean and reviewable, and
preservign your public image ;-).
