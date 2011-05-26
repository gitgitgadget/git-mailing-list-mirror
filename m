From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] t7508: demonstrate status's failure to use --porcelain format with -z
Date: Thu, 26 May 2011 13:43:20 -0700
Message-ID: <vdMu20HxiNaWL_IogfamtfZCd6xRyKanIqTSw0k4f2SrbLfUYHDzKT2EGkwdFRlaLzX-5vGGtDCZRGu84HrJzw@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 26 22:56:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhbj-0005bd-Jn
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 22:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758542Ab1EZU43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 16:56:29 -0400
Received: from mail2.nrlssc.navy.mil ([128.160.25.4]:48670 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758493Ab1EZU41 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 16:56:27 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 May 2011 16:56:26 EDT
Received: by mail.nrlssc.navy.mil id p4QKo2Vu028043; Thu, 26 May 2011 15:50:02 -0500
X-OriginalArrivalTime: 26 May 2011 20:45:31.0369 (UTC) FILETIME=[DA787590:01CC1BE5]
X-Virus-Scanned: clamav-milter 0.95.3 at mail2
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174567>

From: Brandon Casey <drafnel@gmail.com>

When 'git status' is supplied the -z switch, and no output format has been
selected, it is supposed to use the --porcelain format.  This does not
happen.  Instead, the standard long format is used.  Add a test to
demonstrate this failure.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7508-status.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index cd6e2c5..9601258 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -533,6 +533,13 @@ test_expect_success 'status --porcelain ignores -b' '
 
 '
 
+test_expect_failure 'status -z implies porcelain' '
+	echo " M dir1/modifiedQA  dir2/addedQ?? dir1/untrackedQ?? dir2/modifiedQ?? dir2/untrackedQ?? expectQ?? outputQ?? untrackedQ" |
+		q_to_nul | tr -d "\\012" >expect &&
+	git status -z >output &&
+	test_cmp expect output
+'
+
 cat >expect <<\EOF
 # On branch master
 # Changes to be committed:
-- 
1.7.4.4
