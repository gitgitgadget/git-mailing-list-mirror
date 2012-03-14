From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH jh/notes-merge-in-git-dir-worktree] fixup! t3310 on Windows
Date: Wed, 14 Mar 2012 09:39:22 +0100
Message-ID: <4F60593A.5070106@viscovery.net>
References: <1319438176-7304-3-git-send-email-pclouds@gmail.com> <1331563647-1909-1-git-send-email-johan@herland.net> <1331563647-1909-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, david@tethera.net,
	pclouds@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 09:39:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7jk9-0007me-As
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 09:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372Ab2CNIjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 04:39:31 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35811 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab2CNIj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 04:39:28 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S7jjv-0004ZO-98; Wed, 14 Mar 2012 09:39:23 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EC6541660F;
	Wed, 14 Mar 2012 09:39:22 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <1331563647-1909-2-git-send-email-johan@herland.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193086>

From: Johannes Sixt <j6t@kdbg.org>

On Windows, a directory cannot be removed while it is the working
directory of a process. "git notes merge --commit" attempts to remove
.git/NOTES_MERGE_WORKTREE, but during the test the directory was still
"occupied" by the shell. Move the command out of the subshell to release
the directory.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Feel free to squash this into 1/2.

 t/t3310-notes-merge-manual-resolve.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index d6d6ac6..6351877 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -565,9 +565,9 @@ test_expect_success 'switch cwd before committing notes merge' '
 	(
 		cd .git/NOTES_MERGE_WORKTREE &&
 		echo "foo" > $(git rev-parse HEAD) &&
-		echo "bar" >> $(git rev-parse HEAD) &&
-		git notes merge --commit
+		echo "bar" >> $(git rev-parse HEAD)
 	) &&
+	git notes merge --commit &&
 	git notes show HEAD > actual_notes &&
 	test_cmp expect_notes actual_notes
 '
-- 
1.7.10.rc0.1198.g85187
