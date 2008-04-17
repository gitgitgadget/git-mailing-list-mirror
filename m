From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/8] Add a function to set a non-default work tree
Date: Thu, 17 Apr 2008 19:32:33 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804171931550.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 01:33:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmdbj-0003ZA-AM
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 01:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbYDQXcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 19:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755226AbYDQXcf
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 19:32:35 -0400
Received: from iabervon.org ([66.92.72.58]:42458 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186AbYDQXce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 19:32:34 -0400
Received: (qmail 6313 invoked by uid 1000); 17 Apr 2008 23:32:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2008 23:32:33 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79849>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 cache.h       |    1 +
 environment.c |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 96dcb49..d88a4e2 100644
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
1.5.4.3.610.gea6cd
