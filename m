From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Renaming environment variables.
Date: Mon, 09 May 2005 17:09:19 -0700
Message-ID: <7v7ji8vt5c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505091847050.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 02:02:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVICk-0001Eo-Ui
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVEJAJs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVEJAJs
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:09:48 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:6654 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261441AbVEJAJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 20:09:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510000919.KIMY22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 May 2005 20:09:19 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505091847050.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Mon, 9 May 2005 19:08:20 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> While we're at it, it would be useful to have one for what is normally
DB> ".git",...

If you mean the parent directory of ${SHA1_FILE_DIRECTORY}, and
your only gripe is about git-init-db creating ".git" in the
current working directory regardless of SHA1_FILE_DIRECTORY, I
would agree that what git-init-db does is broken.  Not that I
have a suggested "right behaviour" for it, though.

However if you also mean by ".git" the directory refs/heads and
friends hang underneath, then I have to disagree.  That does not
belong to core GIT, which always expects to run from the top
level directory that has such directory directly under it, and
at the same time corresponds to the tree structure the dircache
describes.  There is no need for the environment variable you
suggest, since it always is the ".git" subdirectory of such a
directory.

I once advocated GIT_WORKING_TREE to mean the current project
top, which is the parent directory of ".git".  The proposal was
shot down (see archives [*1*]).  While I still think that
configuration (or your ".git" location proposal, which is
essentially the equivalent) may sometimes useful, I'd rather not
conflate this environment variable renames with that issue.
They are pretty much independent issues.

[References]
*1* http://marc.theaimsgroup.com/?l=git&m=111412959320946&w=2

