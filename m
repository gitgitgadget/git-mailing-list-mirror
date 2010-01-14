From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/18] rebase -i: Use symbolic constant $MSG consistently
Date: Thu, 14 Jan 2010 06:54:44 +0100
Message-ID: <1dc77ab5f378ce6fc41b01541fbf15c5ae037aa8.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgc-0002Vo-Mz
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab0ANFz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755485Ab0ANFz0
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:26 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58599 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab0ANFzW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:22 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bK001912;
	Thu, 14 Jan 2010 06:55:16 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136936>

The filename constant $MSG was previously used in some places and
written out literally in others.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6dbc64e..b7e8189 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -131,8 +131,8 @@ make_patch () {
 		echo "Root commit"
 		;;
 	esac > "$DOTEST"/patch
-	test -f "$DOTEST"/message ||
-		git cat-file commit "$1" | sed "1,/^$/d" > "$DOTEST"/message
+	test -f "$MSG" ||
+		git cat-file commit "$1" | sed "1,/^$/d" > "$MSG"
 	test -f "$DOTEST"/author-script ||
 		get_author_ident_from_commit "$1" > "$DOTEST"/author-script
 }
@@ -343,7 +343,7 @@ peek_next_command () {
 }
 
 do_next () {
-	rm -f "$DOTEST"/message "$DOTEST"/author-script \
+	rm -f "$MSG" "$DOTEST"/author-script \
 		"$DOTEST"/amend || exit
 	read command sha1 rest < "$TODO"
 	case "$command" in
@@ -611,7 +611,7 @@ first and then run 'git rebase --continue' again."
 				die "Cannot rewind the HEAD"
 			fi
 			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
-			git commit --no-verify -F "$DOTEST"/message -e || {
+			git commit --no-verify -F "$MSG" -e || {
 				test -n "$amend" && git reset --soft $amend
 				die "Could not commit staged changes."
 			}
-- 
1.6.6
