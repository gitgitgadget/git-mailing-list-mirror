From: Fernando Vezzosi <buccia@repnz.net>
Subject: [PATCH] Introduce commit.verbose config option
Date: Sat, 5 Nov 2011 19:07:35 +0100
Message-ID: <20111105182339.27C069004A@inscatolati.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 19:23:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMku9-0005ar-RV
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 19:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab1KESXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 14:23:41 -0400
Received: from www.inscatolati.net ([212.45.155.126]:48587 "EHLO
	inscatolati.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab1KESXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 14:23:40 -0400
Received: by inscatolati.net (Postfix, from userid 1004)
	id 27C069004A; Sat,  5 Nov 2011 19:23:39 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184872>

Enabling commit.verbose will make git commit behave as if --verbose was
passed on the command line.

Reviewed-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Fernando Vezzosi <buccia@repnz.net>
---
 Documentation/config.txt |    3 +++
 builtin/commit.c         |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5a841da..6826788 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -832,6 +832,9 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
 	specified user's home directory.
 
+commit.verbose::
+	A boolean to enable verbose mode like the --verbose flag does.
+
 include::diff-config.txt[]
 
 difftool.<tool>.path::
diff --git a/builtin/commit.c b/builtin/commit.c
index c46f2d1..c2a1f3d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1331,6 +1331,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		include_status = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "commit.verbose")) {
+		verbose = git_config_bool(k, v);
+		return 0;
+	}
 
 	return git_status_config(k, v, s);
 }
-- 
1.7.7.1
