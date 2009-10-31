From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 26/28] set httpd port before sourcing lib-httpd
Date: Fri, 30 Oct 2009 17:47:45 -0700
Message-ID: <1256950067-27938-28-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Cc: Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N429u-0001yQ-JH
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933181AbZJaAss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933179AbZJaAso
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:48:44 -0400
Received: from george.spearce.org ([209.20.77.23]:36965 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbZJaAsB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:48:01 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6FD9D38215; Sat, 31 Oct 2009 00:48:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C42FA381D3;
	Sat, 31 Oct 2009 00:47:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131809>

From: Clemens Buchacher <drizzd@aon.at>

If LIB_HTTPD_PORT is not set already, lib-httpd will set it to the
default 8111.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t5540-http-push.sh |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 28a746e..d1234f9 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -9,17 +9,16 @@ This test runs various sanity checks on http-push.'
 
 . ./test-lib.sh
 
-ROOT_PATH="$PWD"
-LIB_HTTPD_DAV=t
-LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5540'}
-
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
 then
 	say "skipping test, USE_CURL_MULTI is not defined"
 	test_done
 fi
 
+LIB_HTTPD_DAV=t
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5540'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
+ROOT_PATH="$PWD"
 start_httpd
 
 test_expect_success 'setup remote repository' '
-- 
1.6.5.2.181.gd6f41
