From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/5] log: introduce init_log_defaults()
Date: Tue, 23 Feb 2016 18:44:57 +0100
Message-ID: <1456249498-3232-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:45:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYH1X-000164-Hr
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744AbcBWRpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 12:45:16 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47028 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754699AbcBWRpP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:45:15 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj7gD021485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 18:45:07 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj6MX012979;
	Tue, 23 Feb 2016 18:45:09 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 18:45:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NHj7gD021485
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456854310.98259@YgrzIGsFzqwCVSh3f96LBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287095>

This is currently a wrapper around init_grep_defaults(), but will allow
adding more initialization in further patches.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/log.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 0d738d6..7f96c64 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -100,6 +100,11 @@ static int log_line_range_callback(const struct option *option, const char *arg,
 	return 0;
 }
 
+static void init_log_defaults()
+{
+	init_grep_defaults();
+}
+
 static void cmd_log_init_defaults(struct rev_info *rev)
 {
 	if (fmt_pretty)
@@ -416,7 +421,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	init_grep_defaults();
+	init_log_defaults();
 	git_config(git_log_config, NULL);
 
 	init_revisions(&rev, prefix);
@@ -527,7 +532,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	struct pathspec match_all;
 	int i, count, ret = 0;
 
-	init_grep_defaults();
+	init_log_defaults();
 	git_config(git_log_config, NULL);
 
 	memset(&match_all, 0, sizeof(match_all));
@@ -608,7 +613,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	init_grep_defaults();
+	init_log_defaults();
 	git_config(git_log_config, NULL);
 
 	init_revisions(&rev, prefix);
@@ -647,7 +652,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	init_grep_defaults();
+	init_log_defaults();
 	git_config(git_log_config, NULL);
 
 	init_revisions(&rev, prefix);
@@ -1280,7 +1285,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_hdr.strdup_strings = 1;
 	extra_to.strdup_strings = 1;
 	extra_cc.strdup_strings = 1;
-	init_grep_defaults();
+	init_log_defaults();
 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
-- 
2.7.2.334.g35ed2ae.dirty
