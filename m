From: Junio C Hamano <junkio@cox.net>
Subject: Current status toward 0.99.5 and beyond
Date: Tue, 23 Aug 2005 10:14:47 -0700
Message-ID: <7vmzn8poc8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Aug 23 19:18:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7cMN-00006D-Mi
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 19:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVHWROt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 13:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVHWROt
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 13:14:49 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40330 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932232AbVHWROs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 13:14:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823171446.VMYV8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 13:14:46 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7659>

Some people may have noticed that the progress of the master
branch head has somewhat slowed down lately, and I have kept
some changes in the proposed updates branch for quite some time.

There are two reasons for this.  One is that I've been quite
busy during my day job hours, and haven't had enough time to
make sure the multi-head fetch stuff does not break things and
the way it works is reasonable.  Another is that I am feeling
guilty about letting Documentation go stale, and am reluctant to
have what is in the proposed updates branch graduate to the
master branch without accompanying documentation.  Maybe I'll
have some time on my next GIT day [*1*].

Anyway, here is my updated Itchlist, as a preview of what comes
next.

For 0.99.5, I would like to finish testing and documenting what
is currently in the proposed updates branch.  There are two
changes there: multi-head fetch and $GIT_DIR/remotes/ that
somewhat deprecates $GIT_DIR/branches/; semantics cleanup of
"git reset" command.

Linus has been feeding updates to make various commands to be
capable of running from subdirectories and taking paths relative
to the current directory.  I would have liked these patches with
test scripts to demonstrate they do what they claim to do well.
Patches to extend existing test scripts in t/ directory are very
much welcomed.  So far, the following commands should be usable
with relative directory paths:

    update-cache
    ls-files
    diff-files
    diff-cache
    diff-tree


I do not have major itch after 0.99.5 right now, except for
obvious fixes and tweaks here and there [*2*].  I think we would
concentrate a bit more on usability enhancement including the
tutorial updates.  One code change I would like to see is to add
limited MIME support to applymbox suite.  We should be able to
teach mailinfo to:

  - detect B encoding in the mail headers, and translate it to UTF-8;

  - understand a single level multipart and pick out the body of
    the message;

  - detect QP in the body and decode into the original charset;

  - after splitting the body into commit log and patch, translate only
    the commit log part into UTF-8.


[Footnote]

*1* Currently, my Wednesdays and Saturdays are for GIT only.

*2* Here is a list of minor itches:

 * "git rebase" could be a bit more tolerant to conflicting
   patches.  We may want to "wiggle" it, or may want to run
   3-way "merge".

 * The semantics of rev-parse needs to be clarified.

 * show-branch may want to show things in topological order, not
   time-based order.

 * There are commands that were well intentioned but not useful
   in practice, like build-rev-cache.  I would like to review
   them for removal.

 * Cloning a packed repository over HTTP should work natively
   now.  Update "git clone" and remove "git-clone-dumb-http".
 
