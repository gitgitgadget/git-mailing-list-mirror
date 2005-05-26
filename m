From: Junio C Hamano <junkio@cox.net>
Subject: Re: git full diff output issues..
Date: Thu, 26 May 2005 12:46:22 -0700
Message-ID: <7vpsvdbwj5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 21:46:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbOHj-0004nL-I7
	for gcvg-git@gmane.org; Thu, 26 May 2005 21:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVEZTqi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 15:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVEZTqf
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 15:46:35 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:13214 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261713AbVEZTqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 15:46:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526194621.SXNP16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 15:46:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 26 May 2005 12:25:15 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'd appreciate it if you take these two patches I sent last
night.

    * Add git-external-diff-script

    This is a demonstration of GIT_EXTERNAL_DIFF mechanism, and a
    testbed for tweaking and enhancing what the built-in diff should
    be.  This script is designed to output exactly the same output
    as the built-in diff driver produces when set as GIT_EXTERNAL_DIFF.

    * Diff updates.

    With the introduction of 'T', and the "apply-patch" Linus has
    been quietly working on without much advertisement, it started
    to make sense to emit usable information in the "diff --git"
    patch output format.  Earlier built-in diff driver punted and
    did not say anything about a symbolic link changing into a file
    or vice versa, but this version represents that as a pair of
    deletion and creation.

After that, you can experiment to flush out issues with the
current built-in using git-external-diff-script for quick
turnaround.  When you have a concrete "ok this is good" format
we can port that to C in diff.c:builtin_diff().

