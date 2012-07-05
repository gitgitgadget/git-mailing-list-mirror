From: Max Horn <max@quendi.de>
Subject: [PATCH] Improve revisions.txt
Date: Thu,  5 Jul 2012 18:45:16 +0200
Message-ID: <1341506716-97920-1-git-send-email-max@quendi.de>
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 18:45:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmpBR-0000AE-T6
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 18:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107Ab2GEQp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 12:45:27 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:57821 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756966Ab2GEQpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 12:45:25 -0400
Received: from dhcp181.math.nat.tu-bs.de ([134.169.53.181]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1SmpBE-0003Le-75; Thu, 05 Jul 2012 18:45:24 +0200
X-Mailer: git-send-email 1.7.7.5 (Apple Git-26)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1341506725;b7ba2769;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201050>

One section talked about <name> when only <refname> was defined.
And the description for r1^! was incorrect, talking about "parents"
(which I understand as meaning direct parent commits),
when really all ancestors were meant.
Finally I added a few more examples (in particular one for "B..C")
that helped me understand the whole thing.

Signed-off-by: Max Horn <max@quendi.de>
---
 Documentation/revisions.txt |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 1725661..b452265 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -24,22 +24,22 @@ blobs contained in a commit.
   object referenced by 'refs/heads/master'.  If you
   happen to have both 'heads/master' and 'tags/master', you can
   explicitly say 'heads/master' to tell git which one you mean.
-  When ambiguous, a '<name>' is disambiguated by taking the
+  When ambiguous, a '<refname>' is disambiguated by taking the
   first match in the following rules:
 
-  . If '$GIT_DIR/<name>' exists, that is what you mean (this is usually
+  . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
     useful only for 'HEAD', 'FETCH_HEAD', 'ORIG_HEAD', 'MERGE_HEAD'
     and 'CHERRY_PICK_HEAD');
 
-  . otherwise, 'refs/<name>' if it exists;
+  . otherwise, 'refs/<refname>' if it exists;
 
   . otherwise, 'refs/tags/<refname>' if it exists;
 
-  . otherwise, 'refs/heads/<name>' if it exists;
+  . otherwise, 'refs/heads/<refname>' if it exists;
 
-  . otherwise, 'refs/remotes/<name>' if it exists;
+  . otherwise, 'refs/remotes/<refname>' if it exists;
 
-  . otherwise, 'refs/remotes/<name>/HEAD' if it exists.
+  . otherwise, 'refs/remotes/<refname>/HEAD' if it exists.
 +
 'HEAD' names the commit on which you based the changes in the working tree.
 'FETCH_HEAD' records the branch which you fetched from a remote repository
@@ -215,8 +215,9 @@ It is the set of commits that are reachable from either one of
 
 Two other shorthands for naming a set that is formed by a commit
 and its parent commits exist.  The 'r1{caret}@' notation means all
-parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
-all of its parents.
+commits reachable from 'r1' except for 'r1' itself, i.e. all ancestors
+of 'r1' are included. In contrast to this, 'r1{caret}!' includes commit
+'r1' but excludes all of its ancestors.
 
 Here are a handful of examples:
 
@@ -224,7 +225,10 @@ Here are a handful of examples:
    D F              G H I J D F
    ^G D             H D
    ^D B             E I J F B
+   B..C             C
    B...C            G H D E B C
    ^D B C           E I J F B C
+   C                I J F C
    C^@              I J F
+   B^! C            B C
    F^! D            G H D F
-- 
1.7.7.5 (Apple Git-26)
