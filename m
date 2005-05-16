From: Junio C Hamano <junkio@cox.net>
Subject: Re: speeding up cg-log -u
Date: Mon, 16 May 2005 01:13:21 -0700
Message-ID: <7voebboafy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505151158300.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Zack Brown <zbrown@tumblerings.org>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 16 10:13:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXaj1-0004GX-Ob
	for gcvg-git@gmane.org; Mon, 16 May 2005 10:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVEPINb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 04:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVEPINb
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 04:13:31 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:59017 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261477AbVEPINY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 04:13:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516081322.QKHQ550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 04:13:22 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505151158300.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Sun, 15 May 2005 12:09:55 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> Existance is the primary thing, and everything else was added as
DB> needed. (Pure connectivity is a bit special, because it's a property of
DB> generic objects so that fsck-cache doesn't need to know about particular
DB> types of objects unless there are particular things to check about them)

DB> If you need more fields, let me know, and I'll figure out how to include
DB> them.

Could you take a look at the latest round of the patch and see
what I did there makes sense?

    From: Junio C Hamano <junkio@cox.net>
    Date: Sun, 15 May 2005 14:18:36 -0700
    Message-ID: <7vy8agqjbn.fsf@assigned-by-dhcp.cox.net>
    Subject: [PATCH 1/4] Add --author and --committer match
             to git-rev-list and git-rev-tree.

Another thing I wanted to ask you about was lifetime rules.
When we "lookup" these objects (and then "parse" them, which
causes more memory to be used), who is responsible for freeing
them?  When my program thinks it is done with a commit, is it
allowed to free it?  Or does the lookup machinery own all of the
objects that have ever been looked up, and the program should
not worry about freeing them to begin with?

