From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/19] git-check-attr: Extract a function output_attr()
Date: Tue, 26 Jul 2011 16:12:53 +0200
Message-ID: <1311689582-3116-11-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:33:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlihL-0005pK-TK
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab1GZOdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:33:19 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40240 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab1GZOdS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:33:18 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-Pu; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177879>


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
