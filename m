From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/19] git-check-attr: Extract a function output_attr()
Date: Thu, 28 Jul 2011 06:46:49 +0200
Message-ID: <1311828418-2676-11-git-send-email-mhagger@alum.mit.edu>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 28 06:55:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIcu-0007mB-RX
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab1G1EzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:55:08 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57332 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab1G1EzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:55:03 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmITD-000889-H1; Thu, 28 Jul 2011 06:45:15 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178029>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-attr.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 5f04126..384c5a6 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -20,12 +20,10 @@ static const struct option check_attr_options[] = {
 	OPT_END()
 };
 
-static void check_attr(int cnt, struct git_attr_check *check,
+static void output_attr(int cnt, struct git_attr_check *check,
 	const char *file)
 {
 	int j;
-	if (git_checkattr(file, cnt, check))
-		die("git_checkattr died");
 	for (j = 0; j < cnt; j++) {
 		const char *value = check[j].value;
 
@@ -41,6 +39,14 @@ static void check_attr(int cnt, struct git_attr_check *check,
 	}
 }
 
+static void check_attr(int cnt, struct git_attr_check *check,
+	const char *file)
+{
+	if (git_checkattr(file, cnt, check))
+		die("git_checkattr died");
+	output_attr(cnt, check, file);
+}
+
 static void check_attr_stdin_paths(int cnt, struct git_attr_check *check)
 {
 	struct strbuf buf, nbuf;
-- 
1.7.6.8.gd2879
