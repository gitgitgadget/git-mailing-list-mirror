From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Mon, 22 Jan 2007 11:28:32 -0800
Message-ID: <7vd556uahr.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
	<87lkjvhr2c.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 20:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H94qN-0003HS-B8
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 20:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbXAVT2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 14:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbXAVT2f
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 14:28:35 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59928 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbXAVT2e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 14:28:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122192833.USNU15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 14:28:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id EKUr1W00B1kojtg0000000; Mon, 22 Jan 2007 14:28:51 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87lkjvhr2c.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	22 Jan 2007 10:08:59 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37438>

Thanks for your comments; the attached probably needs
proofreading.

The changes in response to the remainder of your comments are
quite straightforward and I do not think needs proofreading, so
I'll incorporate them and push the result out in 'todo'.

diff --git a/v1.5.0.txt b/v1.5.0.txt
index c0ff071..596bfd2 100644
--- a/v1.5.0.txt
+++ b/v1.5.0.txt
@@ -107,11 +107,40 @@ Updates in v1.5.0 since v1.4.4 series
    already comfortable with your workflow with the layout.
 
  - git-clone always uses what is known as "separate remote"
-   layout for a newly created repository with a working tree;
-   i.e. tracking branches in $GIT_DIR/refs/remotes/origin/ are
-   used to track branches from the origin, instead of
-   $GIT_DIR/refs/heads/, making the difference between remotely
-   tracked and local branches more obvious.
+   layout for a newly created repository with a working tree.
+
+   A repository with the separate remote layout starts with only
+   one default branch, 'master', to be used for your own
+   development.  Unlike the traditional layout that copied all
+   the upstream branches into your branch namespace (while
+   renaming their 'master' to your 'origin'), they are not made
+   into your branches.  Instead, they are kept track of using
+   'refs/remotes/origin/$upstream_branch_name'.
+
+   This layout keeps your own branch namespace less cluttered,
+   avoids name collision with your upstream, makes it possible
+   to automatically track new branches created at the remote
+   after you clone from it, and makes it easier to interact with
+   more than one remote repositories.  There might be some
+   surprises:
+
+   * 'git branch' does not show the branches from your upstream.
+     It only lists your own branches.  Use '-r' option to view
+     the tracking branches.
+
+   * If you are forking off of a branch obtained from the
+     upstream, you would have done something like 'git branch
+     my-next next', because traditional layout dropped the
+     tracking branch 'next' into your own branch namespace.
+     With the separate remote layout, you say 'git branch next
+     origin/next', which allows you to use the matching name
+     'next' for your own branch.  It also allows you to track a
+     remote other than 'origin' (i.e. where you initially cloned
+     from) and fork off of a branch from there the same way
+     (e.g. "git branch mingw j6t/master").
+
+   Repositories initialized with the traditional layout
+   continues to work (and will continue to work).
 
  - New branches that appear on the origin side after a clone is
    made are also tracked automatically.  This is done with an
