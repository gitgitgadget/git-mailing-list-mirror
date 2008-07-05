From: Brian Hetro <whee@smaertness.net>
Subject: [PATCH 2/5] builtin-log.c: Use 'git_config_string' to get 'format.subjectprefix' and 'format.suffix'
Date: Sat,  5 Jul 2008 01:24:41 -0400
Message-ID: <f1c8159441e6afc5021e5f087f6feaf5b53e61df.1215234749.git.whee@smaertness.net>
References: <cover.1215234749.git.whee@smaertness.net>
 <fd5cae53021281c920ba48efef82dc8a8d3c7fe1.1215234749.git.whee@smaertness.net>
Cc: gitster@pobox.com, Brian Hetro <whee@smaertness.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 07:26:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF0Hc-0003MG-JF
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 07:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbYGEFY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 01:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYGEFY6
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 01:24:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:58503 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbYGEFY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 01:24:57 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1046214wri.5
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 22:24:56 -0700 (PDT)
Received: by 10.90.94.2 with SMTP id r2mr2162224agb.17.1215235495995;
        Fri, 04 Jul 2008 22:24:55 -0700 (PDT)
Received: from localhost.localdomain ( [74.69.33.95])
        by mx.google.com with ESMTPS id 34sm1794628yxm.0.2008.07.04.22.24.54
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jul 2008 22:24:55 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.1.204.g699135
In-Reply-To: <fd5cae53021281c920ba48efef82dc8a8d3c7fe1.1215234749.git.whee@smaertness.net>
In-Reply-To: <cover.1215234749.git.whee@smaertness.net>
References: <cover.1215234749.git.whee@smaertness.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87430>

Signed-off-by: Brian Hetro <whee@smaertness.net>
---
 builtin-log.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 9979e37..430d876 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -234,12 +234,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
-	if (!strcmp(var, "format.subjectprefix")) {
-		if (!value)
-			config_error_nonbool(var);
-		fmt_patch_subject_prefix = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "format.subjectprefix"))
+		return git_config_string(&fmt_patch_subject_prefix, var, value);
 	if (!strcmp(var, "log.date"))
 		return git_config_string(&default_date_mode, var, value);
 	if (!strcmp(var, "log.showroot")) {
@@ -489,12 +485,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		add_header(value);
 		return 0;
 	}
-	if (!strcmp(var, "format.suffix")) {
-		if (!value)
-			return config_error_nonbool(var);
-		fmt_patch_suffix = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "format.suffix"))
+		return git_config_string(&fmt_patch_suffix, var, value);
 	if (!strcmp(var, "format.cc")) {
 		if (!value)
 			return config_error_nonbool(var);
-- 
1.5.6.1.204.g699135
