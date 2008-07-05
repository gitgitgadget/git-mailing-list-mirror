From: Brian Hetro <whee@smaertness.net>
Subject: [PATCH 4/5] diff.c: Use 'git_config_string' to get 'diff.external'
Date: Sat,  5 Jul 2008 01:24:43 -0400
Message-ID: <1addd570c31b5f1b09bde0d330c4094714cac624.1215234749.git.whee@smaertness.net>
References: <cover.1215234749.git.whee@smaertness.net>
 <fd5cae53021281c920ba48efef82dc8a8d3c7fe1.1215234749.git.whee@smaertness.net>
 <f1c8159441e6afc5021e5f087f6feaf5b53e61df.1215234749.git.whee@smaertness.net>
 <81a6961a970f77cc8166c1ae59cae6326bc5c143.1215234749.git.whee@smaertness.net>
Cc: gitster@pobox.com, Brian Hetro <whee@smaertness.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 07:26:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF0Hd-0003MG-T5
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 07:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbYGEFZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 01:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbYGEFZD
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 01:25:03 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:58503 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbYGEFY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 01:24:59 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1046214wri.5
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 22:24:58 -0700 (PDT)
Received: by 10.90.50.5 with SMTP id x5mr2158652agx.36.1215235498425;
        Fri, 04 Jul 2008 22:24:58 -0700 (PDT)
Received: from localhost.localdomain ( [74.69.33.95])
        by mx.google.com with ESMTPS id 34sm1794628yxm.0.2008.07.04.22.24.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jul 2008 22:24:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.1.204.g699135
In-Reply-To: <81a6961a970f77cc8166c1ae59cae6326bc5c143.1215234749.git.whee@smaertness.net>
In-Reply-To: <cover.1215234749.git.whee@smaertness.net>
References: <cover.1215234749.git.whee@smaertness.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87432>

Signed-off-by: Brian Hetro <whee@smaertness.net>
---
 diff.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 803fbba..6a39b39 100644
--- a/diff.c
+++ b/diff.c
@@ -153,12 +153,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_auto_refresh_index = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.external")) {
-		if (!value)
-			return config_error_nonbool(var);
-		external_diff_cmd_cfg = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "diff.external"))
+		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep = strrchr(var, '.');
 
-- 
1.5.6.1.204.g699135
