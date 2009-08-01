From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/5] pick: rename "pick()" to "pick_commit()"
Date: Sat, 01 Aug 2009 17:46:04 +0200
Message-ID: <20090801154607.20922.59485.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 17:48:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXGpN-0000FT-HO
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 17:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbZHAPsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 11:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbZHAPsK
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 11:48:10 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36479 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbZHAPsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 11:48:08 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3E6C18180EE;
	Sat,  1 Aug 2009 17:47:59 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3BEE9818112;
	Sat,  1 Aug 2009 17:47:57 +0200 (CEST)
X-git-sha1: 08aabf2aa69e4e383c531db1ba004745e19dbf25 
X-Mailer: git-mail-commits v0.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124631>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-revert.c |    2 +-
 pick.c           |    8 ++++----
 pick.h           |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 6dd29a3..4797ac5 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -206,7 +206,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 					git_commit_encoding, encoding)))
 		commit->buffer = reencoded_message;
 
-	failed = pick(commit, mainline, flags, &msgbuf);
+	failed = pick_commit(commit, mainline, flags, &msgbuf);
 	if (failed < 0) {
 		exit(1);
 	} else if (failed > 0) {
diff --git a/pick.c b/pick.c
index 6fea39c..13bf793 100644
--- a/pick.c
+++ b/pick.c
@@ -60,16 +60,16 @@ static struct tree *empty_tree(void)
 }
 
 /*
- * Pick changes introduced by pick_commit into current working tree
- * and index.
+ * Pick changes introduced by "commit" argument into current working
+ * tree and index.
  *
  * Return 0 on success.
  * Return negative value on error before picking,
  * and a positive value after picking,
  * and return 1 if and only if a conflict occurs but no other error.
  */
-int pick(struct commit *pick_commit, int mainline, int flags,
-						struct strbuf *msg)
+int pick_commit(struct commit *pick_commit, int mainline, int flags,
+		struct strbuf *msg)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
diff --git a/pick.h b/pick.h
index 7eb0d3a..7a74ad8 100644
--- a/pick.h
+++ b/pick.h
@@ -8,6 +8,6 @@
 #define PICK_ADD_NOTE  2 /* add note about original commit (unless conflict) */
 /* We don't need a PICK_QUIET. This is done by
  *	setenv("GIT_MERGE_VERBOSITY", "0", 1); */
-extern int pick(struct commit *pick_commit, int mainline, int flags, struct strbuf *msg);
+extern int pick_commit(struct commit *commit, int mainline, int flags, struct strbuf *msg);
 
 #endif
-- 
1.6.4.133.g8a5c8
