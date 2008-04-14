From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/2] bisect: add "stop", "show" and "restart" as synonyms
 for other commands
Date: Mon, 14 Apr 2008 06:16:27 +0200
Message-ID: <20080414061627.62119f74.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Apr 14 06:12:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlG36-00050W-Oh
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 06:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbYDNELN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 00:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbYDNELN
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 00:11:13 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:40367 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbYDNELM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 00:11:12 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E79361AB2B9;
	Mon, 14 Apr 2008 06:11:10 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 691381AB2AD;
	Mon, 14 Apr 2008 06:11:10 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79455>

This patch adds the following synonyms:

	- "show" for "visualize",
	- "stop" for "reset",
	- "restart" for "start",

as suggested by Ingo Molnar.

Note that "view" already exists as a synonym for "visualize".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   14 ++++++++++----
 git-bisect.sh                |    6 +++---
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 698ffde..2c774a3 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -86,9 +86,13 @@ $ git bisect reset
 ------------------------------------------------
 
 to get back to the master branch, instead of being in one of the
-bisection branches ("git bisect start" will do that for you too,
-actually: it will reset the bisection state, and before it does that
-it checks that you're not using some old bisection branch).
+bisection branches.
+
+"git bisect start" will do that for you too. Actually, it will reset
+the bisection state, and before it does that, it checks that you're not
+using some old bisection branch.
+
+`stop` is provided as a synonym for `reset`.
 
 Bisect visualize
 ~~~~~~~~~~~~~~~~
@@ -100,7 +104,7 @@ $ git bisect visualize
 ------------
 
 to see the currently remaining suspects in `gitk`.  `visualize` is a bit
-too long to type and `view` is provided as a synonym.
+too long to type, so `view` and `show` are provided as synonyms.
 
 If `DISPLAY` environment variable is not set, `git log` is used
 instead.  You can even give command line options such as `-p` and
@@ -187,6 +191,8 @@ $ git bisect start v2.6.20-rc6 v2.6.20-rc4 v2.6.20-rc1 --
                    # v2.6.20-rc4 and v2.6.20-rc1 are good
 ------------
 
+`restart` is provided as a synonym for `start`.
+
 Bisect run
 ~~~~~~~~~~
 
diff --git a/git-bisect.sh b/git-bisect.sh
index a090b97..78d011a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -492,16 +492,16 @@ case "$#" in
     case "$cmd" in
     help)
         git bisect -h ;;
-    start)
+    start|restart)
         bisect_start "$@" ;;
     bad|good|skip)
         bisect_state "$cmd" "$@" ;;
     next)
         # Not sure we want "next" at the UI level anymore.
         bisect_next "$@" ;;
-    visualize|view)
+    visualize|view|show)
 	bisect_visualize "$@" ;;
-    reset)
+    reset|stop)
         bisect_reset "$@" ;;
     replay)
 	bisect_replay "$@" ;;
-- 
1.5.5.50.ge6e82.dirty
