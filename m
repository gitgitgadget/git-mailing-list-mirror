From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/19] git-check-attr: Extract a function error_with_usage()
Date: Tue, 26 Jul 2011 16:12:55 +0200
Message-ID: <1311689582-3116-13-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:33:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlihh-0005y0-1U
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab1GZOdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:33:45 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40258 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab1GZOdn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:33:43 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-R9; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177881>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-attr.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index c527078..d004222 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -68,6 +68,12 @@ static void check_attr_stdin_paths(int cnt, struct git_attr_check *check)
 	strbuf_release(&nbuf);
 }
 
+static NORETURN void error_with_usage(const char *msg)
+{
+	error("%s", msg);
+	usage_with_options(check_attr_usage, check_attr_options);
+}
+
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
 	struct git_attr_check *check;
@@ -103,8 +109,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	else if (stdin_paths && filei < argc)
 		errstr = "Can't specify files with --stdin";
 	if (errstr) {
-		error("%s", errstr);
-		usage_with_options(check_attr_usage, check_attr_options);
+		error_with_usage(errstr);
 	}
 
 	check = xcalloc(cnt, sizeof(*check));
-- 
1.7.6.8.gd2879
