From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 1/4] t3509: use unconstrained initial test to setup repository.
Date: Thu,  3 Feb 2011 15:31:42 +0000
Message-ID: <1296747105-1663-2-git-send-email-patthoyts@users.sourceforge.net>
References: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 03 16:35:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl1Dr-0007ou-25
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 16:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430Ab1BCPfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 10:35:46 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:45245 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755168Ab1BCPfq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 10:35:46 -0500
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Pl1De-0005tV-FA; Thu, 03 Feb 2011 15:35:39 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <pat@patthoyts.tk>)
	id 1Pl1AB-0003cB-UT; Thu, 03 Feb 2011 15:32:03 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 9771F23190; Thu,  3 Feb 2011 15:32:03 +0000 (GMT)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165978>

The first test did not run on msysGit due to the SYMLINKS constraint and
so subsequent tests failed because the test repository was not initialized.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 t/t3509-cherry-pick-merge-df.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index 948ca1b..df921d1 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -3,12 +3,14 @@
 test_description='Test cherry-pick with directory/file conflicts'
 . ./test-lib.sh
 
-test_expect_success SYMLINKS 'Setup rename across paths each below D/F conflicts' '
+test_expect_success 'Initialize repository' '
 	mkdir a &&
 	>a/f &&
 	git add a &&
-	git commit -m a &&
+	git commit -m a
+'
 
+test_expect_success SYMLINKS 'Setup rename across paths each below D/F conflicts' '
 	mkdir b &&
 	ln -s ../a b/a &&
 	git add b &&
-- 
1.7.4.msysgit.0
