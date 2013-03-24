From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 14/15] t9500: use test_config to set/unset git config variables
Date: Sun, 24 Mar 2013 22:06:13 +0100
Message-ID: <b89138fdd40290a8697ef4e46a29c1d5a4dcf390.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:26:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsQh-0007IW-Rp
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab3CXVZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:25:48 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:46458 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929Ab3CXVZr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:25:47 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id D150E940197;
	Sun, 24 Mar 2013 22:25:37 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6oxq007319;
	Sun, 24 Mar 2013 22:06:50 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6oC5007318;
	Sun, 24 Mar 2013 22:06:50 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218991>

Instead of using construct such as:
    test_when_finished "git config --unset <key>"
    git config <key> <value>
uses
    test_config <key> <value>
The latter takes care of removing <key> at the end of the test.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t9500-gitweb-standalone-no-errors.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 90bb605..6783c14 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -539,8 +539,7 @@ test_expect_success \
 	 test_when_finished "GIT_COMMITTER_NAME=\"C O Mitter\"" &&
 	 echo "ISO-8859-1" >> file &&
 	 git add file &&
-	 git config i18n.commitencoding ISO-8859-1 &&
-	 test_when_finished "git config --unset i18n.commitencoding" &&
+	 test_config i18n.commitencoding ISO-8859-1 &&
 	 git commit -F "$TEST_DIRECTORY"/t3900/ISO8859-1.txt &&
 	 gitweb_run "p=.git;a=commit"'
 
-- 
1.7.11.7
