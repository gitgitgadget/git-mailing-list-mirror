From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Tue, 13 Feb 2007 08:58:01 -0800
Message-ID: <7vvei6yoyu.fsf@assigned-by-dhcp.cox.net>
References: <7v1wl15zc2.fsf@assigned-by-dhcp.cox.net>
	<7vtzxq3af6.fsf@assigned-by-dhcp.cox.net>
	<20070213135644.GA14555@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 17:58:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH0yv-0002fa-7d
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 17:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbXBMQ6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 11:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbXBMQ6K
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 11:58:10 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57280 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbXBMQ6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 11:58:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213165803.WEDX1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 11:58:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P4y11W00B1kojtg0000000; Tue, 13 Feb 2007 11:58:01 -0500
In-Reply-To: <20070213135644.GA14555@moooo.ath.cx> (Matthias Lederhofer's
	message of "Tue, 13 Feb 2007 14:56:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39543>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Unless there is some last minute showstopper, the final will be
>> cut on Wednesday.  Should I give it a catchy codename?  ;-)
> Documentation/git-checkout.txt still needs an update about reflogs
> with detached HEAD (the paragraph starting with "The command would
> refuse [..]").

Thanks.  I'd do the following.

---

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 55c9289..e4ffde4 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -103,22 +103,12 @@ by any branch (which is natural --- you are not on any branch).
 What this means is that you can discard your temporary commits
 and merges by switching back to an existing branch (e.g. `git
 checkout master`), and a later `git prune` or `git gc` would
-garbage-collect them.
-
-The command would refuse to switch back to make sure that you do
-not discard your temporary state by mistake when your detached
-HEAD is not pointed at by any existing ref.  If you did want to
-save your state (e.g. "I was interested in the fifth commit from
-the top of 'master' branch", or "I made two commits to fix minor
-bugs while on a detached HEAD" -- and if you do not want to lose
-these facts), you can create a new branch and switch to it with
-`git checkout -b newbranch` so that you can keep building on
-that state, or tag it first so that you can come back to it
-later and switch to the branch you wanted to switch to with `git
-tag that_state; git checkout master`.  On the other hand, if you
-did want to discard the temporary state, you can give `-f`
-option (e.g. `git checkout -f master`) to override this
-behaviour.
+garbage-collect them.  If you did this by mistake, you can ask
+the reflog for HEAD where you were, e.g.
+
+------------
+$ git log -g -2 HEAD
+------------
 
 
 EXAMPLES
