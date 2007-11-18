From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] builtin-commit: Fix git-commit honoring status.color
Date: Mon, 19 Nov 2007 01:10:34 +0800
Message-ID: <1195405834-1469-1-git-send-email-pkufranky@gmail.com>
Cc: Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 18:14:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItnjD-00087v-OT
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 18:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbXKRROX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 12:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbXKRROX
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 12:14:23 -0500
Received: from mail.qikoo.org ([60.28.205.235]:43254 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751141AbXKRROW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 12:14:22 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 4EB6247067; Mon, 19 Nov 2007 01:10:34 +0800 (CST)
X-Mailer: git-send-email 1.5.3.5.1876.g7ba19-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65375>

status.color shouldn't be honored when committing since the run-status
output is fed to the editor.
---
 builtin-commit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 8db74ed..4396e7d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -45,6 +45,7 @@ static int quiet, verbose, untracked_files, no_verify;
 static int no_edit, initial_commit, in_merge;
 const char *only_include_assumed;
 struct strbuf message;
+extern int wt_status_use_color;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
@@ -325,6 +326,7 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 	if (only_include_assumed)
 		fprintf(fp, "# %s\n", only_include_assumed);
 
+	wt_status_use_color = 0;
 	commitable = run_status(fp, index_file, prefix);
 
 	fclose(fp);
-- 
1.5.3.5.1876.g7ba19-dirty
