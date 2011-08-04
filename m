From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 16/23] git-check-attr: Extract a function error_with_usage()
Date: Thu,  4 Aug 2011 06:36:26 +0200
Message-ID: <1312432593-9841-17-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopgp-0005WA-7y
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab1HDEh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:29 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39678 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1HDEhG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:06 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHu029203;
	Thu, 4 Aug 2011 06:37:01 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178681>


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
