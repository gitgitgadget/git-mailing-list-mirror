From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport: skip commits that are too recent
Date: Sun, 07 Jan 2007 17:59:38 -0800
Message-ID: <7virfiz3at.fsf@assigned-by-dhcp.cox.net>
References: <1168218683853-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 02:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3jnb-0001SE-4y
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 02:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbXAHB7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 20:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbXAHB7k
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 20:59:40 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:61002 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030443AbXAHB7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 20:59:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108015939.HBHK19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sun, 7 Jan 2007 20:59:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8Ryp1W00B1kojtg0000000; Sun, 07 Jan 2007 20:58:50 -0500
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <1168218683853-git-send-email-martin@catalyst.net.nz> (Martin
	Langhoff's message of "Mon, 8 Jan 2007 14:11:23 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36221>

Martin Langhoff <martin@catalyst.net.nz> writes:

> With this patch, cvsimport will skip commits made
> in the last 10 minutes. The recent-ness test is of
> 5 minutes + cvsps fuzz window (5 minutes default).
>
> When working with a CVS repository that is in use,
> importing commits that are too recent can lead to
> partially incorrect trees. This is mainly due to
>
>  - Commits that are within the cvsps fuzz window may later
>    be found to have affected more files.
>
>  - When performing incremental imports, clock drift between
>    the systems may lead to skipped commits.

Hmmmmm.  This is good for tracking other people's work, but, I
am not quite sure how well it works with my workflow.

I have a CVS upstream, but I manage my own development with git.
I start my day by running an incremental cvsimport, rebase my
branch on top of whatever at the tip of the cvsimport branch.  I
use cvsexportcommit (actually a moral equivalent of it I've been
using before cvsexportcommit has become part of git) to make
parts of my branch that are ready for other people's consumption
available by making commits on the CVS side.  Almost immediately
after that, I do another incremental cvsimport so that I can
rebase the remainder of my branch on top of what I made public.

I guess there is no negative impact your patch has on me -- this
10 minute window does not mean that I cannot continue working.
I can keep working on my stuff on my (old) branch without the
second cvsimport and rebase and there is nothing lost.  I can do
the second cvsimport and rebase later.

Which means that you did not give me a new excuse to take a
coffee break and work on git stuff instead of my day job project
to my management but that is Ok.  I'll find other ways ;-).
