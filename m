From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/18] rebase -i: Improve consistency of commit count in generated commit messages
Date: Thu, 14 Jan 2010 06:54:49 +0100
Message-ID: <1e03c6ff51ca0e6da4c19da014523f01a27b1579.1263447038.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgj-0002Vo-J2
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833Ab0ANF4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826Ab0ANF4H
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:56:07 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58616 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab0ANFz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:27 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bP001912;
	Thu, 14 Jan 2010 06:55:22 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136947>

Use the numeral "2" instead of the word "two" when two commits are
being interactively squashed.  This makes the treatment consistent
with that for higher numbers of commits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh    |    2 +-
 t/t3404-rebase-interactive.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2c7f3ec..16e1990 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -362,7 +362,7 @@ make_squash_message () {
 		}' <"$SQUASH_MSG"
 	else
 		COUNT=2
-		echo "# This is a combination of two commits."
+		echo "# This is a combination of 2 commits."
 		echo "# The first commit's message is:"
 		echo
 		git cat-file commit HEAD | sed -e '1,/^$/d'
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 0335b78..0511709 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -135,7 +135,7 @@ test_expect_success 'squash' '
 	test_tick &&
 	GIT_AUTHOR_NAME="Nitfol" git commit -m "nitfol" file7 &&
 	echo "******************************" &&
-	FAKE_LINES="1 squash 2" EXPECT_HEADER_COUNT=two \
+	FAKE_LINES="1 squash 2" EXPECT_HEADER_COUNT=2 \
 		git rebase -i --onto master HEAD~2 &&
 	test B = $(cat file7) &&
 	test $(git rev-parse HEAD^) = $(git rev-parse master)
@@ -301,7 +301,7 @@ test_expect_success 'squash works as expected' '
 		git commit -m $n
 	done &&
 	one=$(git rev-parse HEAD~3) &&
-	FAKE_LINES="1 squash 3 2" EXPECT_HEADER_COUNT=two \
+	FAKE_LINES="1 squash 3 2" EXPECT_HEADER_COUNT=2 \
 		git rebase -i HEAD~3 &&
 	test $one = $(git rev-parse HEAD~2)
 '
-- 
1.6.6
