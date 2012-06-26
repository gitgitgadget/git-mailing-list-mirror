From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 6/9] git p4 test: check for error message in failed test
Date: Mon, 25 Jun 2012 21:18:22 -0400
Message-ID: <1340673505-10551-7-git-send-email-pw@padd.com>
References: <1340673505-10551-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 03:23:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjKVH-0004Kg-UH
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 03:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757943Ab2FZBU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 21:20:29 -0400
Received: from honk.padd.com ([74.3.171.149]:45536 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757788Ab2FZBU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 21:20:29 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 931502E87;
	Mon, 25 Jun 2012 18:20:28 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 54DBD31383; Mon, 25 Jun 2012 21:20:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.72.gebb7ee5
In-Reply-To: <1340673505-10551-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200611>

Make sure the test fails for the expected reason.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4-basic.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 7401c21..84676a1 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -45,7 +45,8 @@ test_expect_success 'git p4 sync uninitialized repo' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		test_must_fail git p4 sync
+		test_must_fail git p4 sync 2>errs &&
+		test_i18ngrep "Perhaps you never did" errs
 	)
 '
 
-- 
1.7.11.rc2.72.gebb7ee5
