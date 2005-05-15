From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Sat, 14 May 2005 22:33:53 -0700
Message-ID: <7v4qd5xdby.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun May 15 07:34:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXBlA-0005KF-U5
	for gcvg-git@gmane.org; Sun, 15 May 2005 07:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVEOFd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 01:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVEOFd5
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 01:33:57 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:34748 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261488AbVEOFdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 01:33:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515053353.VMXS8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 01:33:53 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Fri, 13 May 2005 02:49:25 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I am having a bit hard time understanding how the end user uses
what you are trying to give them.  Is the basic idea to let them
say "I want to get Pasky's $GIT_DIR/refs/heads/master and store
it in my $GIT_DIR/refs/heads/git-pb, and then I want to start
the pull starting from the commit recorded in that ref"?

Assuming that is what you are doing, I do not have much
objection to it.  I however think introducing REFS_ENVIRONMENT
is going overboard.

My understanding of the definition of GIT_DIR is "the directory
traditionally known as $(pwd)/.git/ where various things hang
underneath".  We have GIT_OBJECT_DIRECTORY configurable to be
set to something other than $GIT_DIR/objects because people may
want to use shared object pools.  We have GIT_INDEX_FILE
configurable to be set to something other than $GIT_DIR/index
because being able to have it on tmp filesystem for some
application (like "merge my head and his head without using what
I have in my work dir which is a bit ahead of my head already")
helps performance; also some Porcelain operations benefit from
being able to switch between multiple cache files.  I cannot
think of a similar argument with an example use pattern that
justifies REFS_ENVIRONMENT being set to anything other than
$GIT_DIR/refs/.

