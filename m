From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 14/23] git-check-attr: Extract a function output_attr()
Date: Thu,  4 Aug 2011 06:36:24 +0200
Message-ID: <1312432593-9841-15-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopgu-0005WA-HL
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab1HDEht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:49 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39665 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab1HDEhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:04 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHs029203;
	Thu, 4 Aug 2011 06:37:00 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178691>


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
