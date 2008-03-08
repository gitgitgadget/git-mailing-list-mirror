From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 06/11] Add a function to set a non-default work tree
Date: Sat, 8 Mar 2008 18:04:13 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081804120.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY86w-0008Dx-0a
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbYCHXES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYCHXER
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:04:17 -0500
Received: from iabervon.org ([66.92.72.58]:42229 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbYCHXEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:04:14 -0500
Received: (qmail 18594 invoked by uid 1000); 8 Mar 2008 23:04:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:04:13 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76604>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 cache.h       |    1 +
 environment.c |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 6aae174..32e8746 100644
--- a/cache.h
+++ b/cache.h
@@ -311,6 +311,7 @@ extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
+extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/environment.c b/environment.c
index 6739a3f..d6c6a6b 100644
--- a/environment.c
+++ b/environment.c
@@ -81,6 +81,12 @@ const char *get_git_dir(void)
 	return git_dir;
 }
 
+void set_git_work_tree(const char *new_work_tree)
+{
+	get_git_work_tree(); /* make sure it's initialized */
+	work_tree = xstrdup(make_absolute_path(new_work_tree));
+}
+
 const char *get_git_work_tree(void)
 {
 	static int initialized = 0;
-- 
1.5.4.3.327.g614d7.dirty

