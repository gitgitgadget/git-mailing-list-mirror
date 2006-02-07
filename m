From: Junio C Hamano <junkio@cox.net>
Subject: Heads up, git.git approaches 1.2.0
Date: Tue, 07 Feb 2006 00:40:10 -0800
Message-ID: <7vek2fzhn9.fsf@assigned-by-dhcp.cox.net>
References: <7vbqxkapr2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 07 09:40:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6OOw-0001kg-2d
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 09:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWBGIkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 03:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWBGIkN
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 03:40:13 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13277 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750888AbWBGIkM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 03:40:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207083750.YIQK17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Feb 2006 03:37:50 -0500
To: git@vger.kernel.org
In-Reply-To: <7vbqxkapr2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 05 Feb 2006 23:52:01 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15686>

I've done a bit more work to round the corners diff-tree -c/--cc
had.  Most notably, earlier the algorithm punted if the merge
removed or added files.  These should raise red flag, because
diff-tree -c/--cc deal with case where the result is different
from all parents, so removal of a file means all parents had it
in some shape but the file does not appear in the result, and
addition of a file means no parents had it but merge made it
magically appear.  These cases are now shown as interesting.

BTW, I was pleasantly surprised that "git show 2950411" showed
exactly what the commit log message said.  Now I agree with
Linus that --cc is a wonderful thing ;-).

Tonight I have pushed out all I said I would want to have in the
next feature release 1.2.0 in the master branch, so that people
can beat it more easily and help us shaking out potential bugs.
Most of the things are something I've been using myself on git
itself and also during my day-job, so there hopefully won't be
any major data eating problems.  Admittedly I almost never do
"git commit paths...", but for the last couple of days I tried
to use it whenever possible to make sure it works as intended.
It defaults to --include behaviour which is the traditional one.

"git commit --only paths..." and running "git commit" from a
subdirectory are also implemented and I've tried them with toy
commits.  If you are one of the people who missed them, please
try it out and see if they satisfy your expectations.

I might receive some more HTTP fixes from Mark, documentation
updates from J. Bruce etc. and I'd merge them before 1.2.0. But
otherwise I am pretty happy with what's there in the "master"
branch right now.  The tip of the "master" is this commit:

    commit 5a798fb57f788692467b1a11416dd5ebff0d31ae
    Author: Junio C Hamano <junkio@cox.net>

        git-commit: finishing touches.

Please consider it a 1.2.0-rc1, and treat it the same way you
would treat -rc1 from the kernel project.  If you are going to
test only one -rc version, this is THE one to test, and all the
rest are bugfixes.
