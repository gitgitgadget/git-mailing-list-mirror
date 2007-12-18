From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] filter-branch: Remove broken and unnecessary summary of rewritten refs.
Date: Tue, 18 Dec 2007 08:30:47 +0100
Message-ID: <1197963047-15930-1-git-send-email-johannes.sixt@telecom.at>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 08:31:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Wv8-0003E2-BQ
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 08:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760465AbXLRHaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 02:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760326AbXLRHaz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 02:30:55 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62963 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758079AbXLRHay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 02:30:54 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1J4Wuu-0001GE-ET; Tue, 18 Dec 2007 08:31:06 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2AE4854D; Tue, 18 Dec 2007 08:30:48 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 03210FA45; Tue, 18 Dec 2007 08:30:47 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.73.gcaffa
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68705>

There was an attempt to list the refs that were rewritten by filtering
the output of 'git show-ref' for 'refs/original'. But it got the
grep argument wrong, which did not account for the SHA1 that is listed
before the ref.

Moreover, right before this summary is the loop that actually does the
rewriting, and the rewritten refs are listed there anyway. So this extra
summary is plainly too verbose.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-filter-branch.sh |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 29d35fd..e730897 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -423,9 +423,6 @@ fi
 
 cd ../..
 rm -rf "$tempdir"
-echo
-test $count -gt 0 && echo "These refs were rewritten:"
-git show-ref | grep ^"$orig_namespace"
 
 unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
 test -z "$ORIG_GIT_DIR" || GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
-- 
1.5.4.rc0.73.gcaffa
