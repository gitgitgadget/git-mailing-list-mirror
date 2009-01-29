From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Thu, 29 Jan 2009 11:00:16 -0500
Message-ID: <1233244816-67565-1-git-send-email-benji@silverinsanity.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 17:02:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSZL3-00078T-Bu
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 17:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbZA2QAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 11:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbZA2QAb
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 11:00:31 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:38121 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbZA2QAa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 11:00:30 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id DE9171FFC15B; Thu, 29 Jan 2009 16:00:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=4.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO autolearn=ham version=3.1.7-deb3
Received: from localhost.localdomain (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	by silverinsanity.com (Postfix) with ESMTP id ABECD1FFC159;
	Thu, 29 Jan 2009 16:00:17 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.2.418.gd79e6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107698>

The call to "git reset --hard B1" failed on case-insensitive file
systems (such as the default settings for HFS+) because there was both
a tag "B1" and a file "b1".  Adding "--" to the command makes it
clear that we mean commit B1.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 t/t3411-rebase-preserve-around-merges.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
index 6533505..e544451 100755
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -24,7 +24,7 @@ test_expect_success 'setup' '
 	test_commit A1 &&
 	test_commit B1 &&
 	test_commit C1 &&
-	git reset --hard B1 &&
+	git reset --hard B1 -- &&
 	test_commit D1 &&
 	test_merge E1 C1 &&
 	test_commit F1
-- 
1.6.1.2.418.gd79e6.dirty
