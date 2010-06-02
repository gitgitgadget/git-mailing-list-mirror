From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/5 v2] t/t7006: ignore return status of shell's unset builtin
Date: Wed,  2 Jun 2010 10:32:26 -0500
Message-ID: <6S2YIhGhiwzh6wTfvWh1Sm_3KoUNJkiAzJKJKLNpqo3MC4Z5besrsZ4fL9wiH35DJsX4cyCs7SM@cipher.nrlssc.navy.mil>
References: <CdJJyxR1_KnpwZGt1HSeDymxbS1diQ_jjDxyygUO3WI@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, j.sixt@viscovery.net, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 02 17:33:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJpwc-00070t-KI
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 17:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649Ab0FBPdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 11:33:21 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42580 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932626Ab0FBPdV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 11:33:21 -0400
Received: by mail.nrlssc.navy.mil id o52FWfjZ022991; Wed, 2 Jun 2010 10:32:41 -0500
In-Reply-To: <CdJJyxR1_KnpwZGt1HSeDymxbS1diQ_jjDxyygUO3WI@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 02 Jun 2010 15:32:41.0339 (UTC) FILETIME=[D6C6ACB0:01CB0268]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148263>

From: Brandon Casey <drafnel@gmail.com>

The unset builtin of Solaris's xpg4/sh returns non-zero if it is passed a
variable name which was not previously set.  Since the unset is not likely
to fail, ignore its return status, but add a semicolon as a clue that the
'&&' was deliberately left off.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7006-pager.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 3bc7a2a..a6f3677 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -40,7 +40,7 @@ else
 fi
 
 test_expect_success 'setup' '
-	unset GIT_PAGER GIT_PAGER_IN_USE &&
+	unset GIT_PAGER GIT_PAGER_IN_USE;
 	test_might_fail git config --unset core.pager &&
 
 	PAGER="cat >paginated.out" &&
@@ -159,7 +159,7 @@ test_expect_success 'color when writing to a file intended for a pager' '
 '
 
 test_expect_success 'determine default pager' '
-	unset PAGER GIT_PAGER &&
+	unset PAGER GIT_PAGER;
 	test_might_fail git config --unset core.pager ||
 	cleanup_fail &&
 
@@ -173,7 +173,7 @@ then
 fi
 
 test_expect_success SIMPLEPAGER 'default pager is used by default' '
-	unset PAGER GIT_PAGER &&
+	unset PAGER GIT_PAGER;
 	test_might_fail git config --unset core.pager &&
 	rm -f default_pager_used ||
 	cleanup_fail &&
@@ -192,7 +192,7 @@ test_expect_success SIMPLEPAGER 'default pager is used by default' '
 '
 
 test_expect_success TTY 'PAGER overrides default pager' '
-	unset GIT_PAGER &&
+	unset GIT_PAGER;
 	test_might_fail git config --unset core.pager &&
 	rm -f PAGER_used ||
 	cleanup_fail &&
@@ -204,7 +204,7 @@ test_expect_success TTY 'PAGER overrides default pager' '
 '
 
 test_expect_success TTY 'core.pager overrides PAGER' '
-	unset GIT_PAGER &&
+	unset GIT_PAGER;
 	rm -f core.pager_used ||
 	cleanup_fail &&
 
-- 
1.6.6.2
