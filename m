From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Update SubmittingPatches.
Date: Sun, 28 Aug 2005 17:57:08 -0700
Message-ID: <7vk6i5ef17.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 29 02:57:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9XxZ-0000Y2-O0
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 02:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVH2A5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 20:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVH2A5L
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 20:57:11 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:20679 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751050AbVH2A5K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 20:57:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050829005710.ZJCR25443.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 20:57:10 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7891>


- It does not matter how I read git list.  What matters is that
  I do not necessarily read everything on it.

- Talk a bit about how to use applymbox to check one's own
  patches.

- Talk a bit about PGP signed patches.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Strictly speaking, PGP signing your message might make some
   sense, not about what is in the patch (which isjudged by
   technical merit alone), but about Signed-off-by: line when
   later the patch is found that it should not have been sent to
   the list to begin with.

 Documentation/SubmittingPatches |   62 +++++++++++++++++++++++++++++++++++----
 1 files changed, 55 insertions(+), 7 deletions(-)

9847f7e0db8359b3932fd51290d777610090c33f
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -73,14 +73,25 @@ MIME-attached change being accepted, but
 that it will be postponed.
 
 Exception:  If your mailer is mangling patches then someone may ask
-you to re-send them using MIME.
+you to re-send them using MIME, that is OK.
 
-Note that your maintainer does not subscribe to the git mailing
-list (he reads it via mail-to-news gateway).  If your patch is
-for discussion first, send it "To:" the mailing list, and
-optoinally "cc:" him.  If it is trivially correct or after list
-discussion reached consensus, send it "To:" the maintainer and
-optionally "cc:" the list.
+Do not PGP sign your patch, at least for now.  Most likely, your
+maintainer or other people on the list would not have your PGP
+key and would not bother obtaining it anyway.  Your patch is not
+judged by who you are; a good patch from an unknown origin has a
+far better chance of being accepted than a patch from a known,
+respected origin that is done poorly or does incorrect things.
+
+If you really really really really want to do a PGP signed
+patch, format it as "multipart/signed", not a text/plain message
+that starts with '-----BEGIN PGP SIGNED MESSAGE-----'.  That is
+not a text/plain, it's something else.
+
+Note that your maintainer does not necessarily read everything
+on the git mailing list.  If your patch is for discussion first,
+send it "To:" the mailing list, and optionally "cc:" him.  If it
+is trivially correct or after the list reached a consensus, send
+it "To:" the maintainer and optionally "cc:" the list.
 
 
 (6) Sign your work
@@ -143,6 +154,43 @@ I have seen:
 * Non empty context lines that have one extra whitespace at the
   beginning.
 
+One test you could do yourself if your MUA is set up correctly is:
+
+* Send the patch to yourself, exactly the way you would, except
+  To: and Cc: lines, which would not contain the list and
+  maintainer address.
+
+* Save that patch to a file in UNIX mailbox format.  Call it say
+  a.patch.
+
+* Try to apply to the tip of the "master" branch from the
+  git.git public repository:
+
+    $ git fetch http://kernel.org/pub/scm/git/git.git master:test-apply
+    $ git checkout test-apply
+    $ git reset --hard
+    $ git applymbox a.patch
+
+If it does not apply correctly, there can be various reasons.
+
+* Your patch itself does not apply cleanly.  That is _bad_ but
+  does not have much to do with your MUA.  Please rebase the
+  patch appropriately.
+
+* Your MUA corrupted your patch; applymbox would complain that
+  the patch does not apply.  Look at .dotest/ subdirectory and
+  see what 'patch' file contains and check for the common
+  corruption patterns mentioned above.
+
+* While you are at it, check what are in 'info' and
+  'final-commit' files as well.  If what is in 'final-commit' is
+  not exactly what you would want to see in the commit log
+  message, it is very likely that your maintainer would end up
+  hand editing the log message when he applies your patch.
+  Things like "Hi, this is my first patch.\n", if you really
+  want to put in the patch e-mail, should come after the
+  three-dash line that signals the end of the commit message.
+
 
 Pine
 ----
