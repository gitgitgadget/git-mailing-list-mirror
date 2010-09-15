From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t7300: workaround ancient touch by rearranging arguments
Date: Wed, 15 Sep 2010 15:58:22 -0500
Message-ID: <i6Vnwbi85zvoD6Nzpw2lc1cAb4fZRJiU13x2r3wnIFnHDZWo9gkMwp9pRXJjgiXl4Ce-ERc-tvc@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 15 22:59:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovz4Z-00025z-1R
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348Ab0IOU7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 16:59:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39230 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab0IOU7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 16:59:13 -0400
Received: by mail.nrlssc.navy.mil id o8FKwdOS006122; Wed, 15 Sep 2010 15:58:39 -0500
X-OriginalArrivalTime: 15 Sep 2010 20:58:38.0830 (UTC) FILETIME=[C552B8E0:01CB5518]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156258>

From: Brandon Casey <drafnel@gmail.com>

The ancient touch on Solaris 7 thinks that a decimal number supplied as
the first argument specifies a date_time to give to the files specified by
the remaining arguments.  In this case, it fails to parse '1' as a proper
date_time and exits with a failure status.  Workaround this flaw by
rearranging the arguments supplied to touch so that a non-digit appears
first and touch will not be confused.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7300-clean.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7dbbea1..6c776e9 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -443,7 +443,7 @@ test_expect_success 'git clean -e' '
 	(
 		cd repo &&
 		git init &&
-		touch 1 2 3 known &&
+		touch known 1 2 3 &&
 		git add known &&
 		git clean -f -e 1 -e 2 &&
 		test -e 1 &&
-- 
1.7.2.1
