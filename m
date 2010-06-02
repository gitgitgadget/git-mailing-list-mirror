From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/5] t/t7006: ignore return status of shell's unset builtin
Date: Tue,  1 Jun 2010 19:13:43 -0500
Message-ID: <Wt_M4qptcPdpY0Q3jqUbfMMZpuKZEHudj8tavRDS41LEhIuAY6Jac5ja0dD0ZRTTyKV_0v7MM6g@cipher.nrlssc.navy.mil>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 02:14:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJbbF-0007mc-T3
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 02:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757329Ab0FBAOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 20:14:18 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50201 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab0FBAOR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 20:14:17 -0400
Received: by mail.nrlssc.navy.mil id o520EDFj007919; Tue, 1 Jun 2010 19:14:14 -0500
In-Reply-To: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 02 Jun 2010 00:14:14.0568 (UTC) FILETIME=[8894BA80:01CB01E8]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148174>

From: Brandon Casey <drafnel@gmail.com>

The unset builtin of Solaris's xpg4/sh returns non-zero if it is passed a
variable name which was not previously set.  Since the unset is not likely
to fail, ignore it's return status.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7006-pager.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 3bc7a2a..a82bfb1 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -40,7 +40,7 @@ else
 fi
 
 test_expect_success 'setup' '
-	unset GIT_PAGER GIT_PAGER_IN_USE &&
+	unset GIT_PAGER GIT_PAGER_IN_USE
 	test_might_fail git config --unset core.pager &&
 
 	PAGER="cat >paginated.out" &&
@@ -159,7 +159,7 @@ test_expect_success 'color when writing to a file intended for a pager' '
 '
 
 test_expect_success 'determine default pager' '
-	unset PAGER GIT_PAGER &&
+	unset PAGER GIT_PAGER
 	test_might_fail git config --unset core.pager ||
 	cleanup_fail &&
 
@@ -173,7 +173,7 @@ then
 fi
 
 test_expect_success SIMPLEPAGER 'default pager is used by default' '
-	unset PAGER GIT_PAGER &&
+	unset PAGER GIT_PAGER
 	test_might_fail git config --unset core.pager &&
 	rm -f default_pager_used ||
 	cleanup_fail &&
@@ -192,7 +192,7 @@ test_expect_success SIMPLEPAGER 'default pager is used by default' '
 '
 
 test_expect_success TTY 'PAGER overrides default pager' '
-	unset GIT_PAGER &&
+	unset GIT_PAGER
 	test_might_fail git config --unset core.pager &&
 	rm -f PAGER_used ||
 	cleanup_fail &&
@@ -204,7 +204,7 @@ test_expect_success TTY 'PAGER overrides default pager' '
 '
 
 test_expect_success TTY 'core.pager overrides PAGER' '
-	unset GIT_PAGER &&
+	unset GIT_PAGER
 	rm -f core.pager_used ||
 	cleanup_fail &&
 
-- 
1.6.6.2
