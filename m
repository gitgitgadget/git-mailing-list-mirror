From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/3] t5541: avoid TAP test miscounting
Date: Sun,  8 Jan 2012 22:06:21 +0100
Message-ID: <1326056781-17456-4-git-send-email-drizzd@aon.at>
References: <1326056781-17456-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 22:15:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk05I-0007Ti-W6
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 22:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab2AHVPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 16:15:04 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:46094 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754535Ab2AHVOp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 16:14:45 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id B41EEA7EB2;
	Sun,  8 Jan 2012 22:15:10 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1326056781-17456-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188139>

From: Michael J Gruber <git@drmicha.warpmail.net>

lib-terminal.sh runs a test and thus increases the test count, but the
output is lost so that TAP produces a "no plan found error".

Move the lib-terminal call after the lib-httpd and make TAP happy
(though still leave me clueless).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t5541-http-push.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 0c3cd3b..6c9ec6f 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -5,7 +5,6 @@
 
 test_description='test smart pushing over http via http-backend'
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-terminal.sh
 
 if test -n "$NO_CURL"; then
 	skip_all='skipping test, git built without http support'
@@ -15,6 +14,7 @@ fi
 ROOT_PATH="$PWD"
 LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5541'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 start_httpd
 
 test_expect_success 'setup remote repository' '
-- 
1.7.8
