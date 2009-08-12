From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/13] pick: rename "pick()" to "pick_commit()"
Date: Wed, 12 Aug 2009 07:15:45 +0200
Message-ID: <20090812051552.18155.44080.chriscool@tuxfamily.org>
References: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 07:28:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb6O0-0003mw-9Y
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 07:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbZHLF2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 01:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbZHLF2M
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 01:28:12 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47770 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242AbZHLF2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 01:28:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9B747818100;
	Wed, 12 Aug 2009 07:27:58 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5C4C88180AC;
	Wed, 12 Aug 2009 07:27:55 +0200 (CEST)
X-git-sha1: 4f7fba959166ba37904260d483729994013edf85 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125659>


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
1.6.4.271.ge010d
