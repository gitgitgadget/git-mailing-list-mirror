From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/4] Changed the documented variable for mergetool's target file
Date: Sun, 17 Feb 2008 10:23:37 +0000
Message-ID: <2bc96ddc3df496c5d078c646336c85a15dd8e892.1203242325.git.charles@hashpling.org>
References: <b63a66ef2a97cd3e791476a74bdb7081bcd57637.1203242325.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 11:24:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQgh5-0004kN-79
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 11:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbYBQKXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 05:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbYBQKXs
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 05:23:48 -0500
Received: from ptb-relay02.plus.net ([212.159.14.213]:50216 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762AbYBQKXr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 05:23:47 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1JQggU-0000pE-5m
	for git@vger.kernel.org; Sun, 17 Feb 2008 10:23:46 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1HANbqw023063
	for <git@vger.kernel.org>; Sun, 17 Feb 2008 10:23:37 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1HANbdB023062
	for git@vger.kernel.org; Sun, 17 Feb 2008 10:23:37 GMT
Content-Disposition: inline
In-Reply-To: <b63a66ef2a97cd3e791476a74bdb7081bcd57637.1203242325.git.charles@hashpling.org>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 0210fa238d04e82366109297592cc53e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74112>

Previously it was $path, now it is $MERGED which is more consistent
with the other documented variables for merge tools and a little
more meaningful.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 Documentation/config.txt |    2 +-
 git-mergetool.sh         |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 12d87d4..53f790d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -727,7 +727,7 @@ mergetool.<tool>.cmd::
 	'LOCAL' is the name of a temporary file containing the contents of
 	the file on the current branch; 'REMOTE' is the name of a temporary
 	file containing the contents of the file from the branch being
-	merged; 'path' contains the name of the file to which the merge
+	merged; 'MERGED' contains the name of the file to which the merge
 	tool should write the results of a successful merge.
 
 mergetool.<tool>.trustExitCode::
diff --git a/git-mergetool.sh b/git-mergetool.sh
index cf30e21..4681e9a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -275,10 +275,10 @@ merge_file () {
 	    if test -n "$merge_tool_cmd"; then
 		if test "$merge_tool_trust_exit_code" = "false"; then
 		    touch "$BACKUP"
-		    ( eval $merge_tool_cmd )
+		    ( MERGED="$path" eval $merge_tool_cmd )
 		    check_unchanged
 		else
-		    ( eval $merge_tool_cmd )
+		    ( MERGED="$path" eval $merge_tool_cmd )
 		    status=$?
 		fi
 		save_backup
-- 
1.5.4.1.34.g94bf
