From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] Documentation: Simplify git-rev-parse's example
Date: Thu, 19 Jun 2008 13:12:56 +0200
Message-ID: <1213873976-4192-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 13:14:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9I5w-0001LH-Df
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 13:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbYFSLNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 07:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757045AbYFSLNA
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 07:13:00 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:54244 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756772AbYFSLM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 07:12:59 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6002.online.nl (SMTP Server) with ESMTP id 0C11570000A3;
	Thu, 19 Jun 2008 13:12:57 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6002.online.nl (SMTP Server) with ESMTP id 9DEC17000098;
	Thu, 19 Jun 2008 13:12:56 +0200 (CEST)
X-ME-UUID: 20080619111256646.9DEC17000098@mwinf6002.online.nl
X-Mailer: git-send-email 1.5.6.rc1.153.gc1d96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85470>

This example was overly complex and therefore confusing.
The commits have been renamed to start the oldest commit with "A"
and working up from there. Also, this removes some commits so the graph
is simpler. Finally the graph has been reversed in direction to make it
more like gitk.

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---

This was created after some discussion in #git about how this was confusing.
The consesus was that this example is better.

 Documentation/git-rev-parse.txt |   69 ++++++++++++++++++++-------------------
 1 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 9e273bc..ddeb496 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -243,34 +243,34 @@ blobs contained in a commit.
   (typically the current branch), and stage 3 is the version from
   the branch being merged.
 
-Here is an illustration, by Jon Loeliger.  Both commit nodes B
-and C are parents of commit node A.  Parent commits are ordered
-left-to-right.
+Here is an illustration. The newest commits are on the top.
+Commit H is a merge commit: its parents are both commit nodes F and G.
+Parent commits are ordered left-to-right.
 
 ........................................
-G   H   I   J
- \ /     \ /
-  D   E   F
-   \  |  / \
-    \ | /   |
-     \|/    |
-      B     C
-       \   /
-        \ /
-         A
-........................................
 
-    A =      = A^0
-    B = A^   = A^1     = A~1
-    C = A^2  = A^2
-    D = A^^  = A^1^1   = A~2
-    E = B^2  = A^^2
-    F = B^3  = A^^3
-    G = A^^^ = A^1^1^1 = A~3
-    H = D^2  = B^^2    = A^^^2  = A~2^2
-    I = F^   = B^3^    = A^^3^
-    J = F^2  = B^3^2   = A^^3^2
+         H
+        / \
+       /   \
+      F     G
+     / \    |
+    /   \   |
+   /     \ /
+  D       E
+ / \      |
+A   B     C
+
+........................................
 
+    H = H^0
+    F = H^   = H^1     = H~1
+    G = H^2
+    D = H^^  = H^1^1   = H~2
+    E = F^2  = H^^2
+    E = F^3  = H^^3    = H^2^
+    A = H^^^ = H^1^1^1 = H~3
+    B = D^   = H^^^2   = H~2^2
+    C = E^   = H^^3^
 
 SPECIFYING RANGES
 -----------------
@@ -302,16 +302,17 @@ and its parent commits exists.  `r1{caret}@` notation means all
 parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
 its all parents.
 
-Here are a handful of examples:
-
-   D                G H D
-   D F              G H I J D F
-   ^G D             H D
-   ^D B             E I J F B
-   B...C            G H D E B C
-   ^D B C           E I J F B C
-   C^@              I J F
-   F^! D            G H D F
+Here are a handful of examples. Note that there is no ordering in
+the set of commits. See also linkgit:git-rev-list[1]'s --topo-order
+and --date-order.
+
+   D                A B D
+   D E              A B C D E
+   ^A D             B D
+   ^D F             C E F
+   F...G            A B D F G
+   D^@              A B
+   E^! D            A B D E
 
 PARSEOPT
 --------
-- 
1.5.6.rc1.153.gc1d96
