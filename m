From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Substitute xmalloc()+memset(0) with xcalloc().
Date: Tue, 25 Jul 2006 09:30:18 +0200
Message-ID: <20060725073018.GA14150@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 25 09:30:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5HN6-0001F7-92
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 09:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWGYHaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 03:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWGYHaV
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 03:30:21 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:50931 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1751021AbWGYHaU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 03:30:20 -0400
Received: (qmail 14376 invoked by uid 5842); 25 Jul 2006 09:30:18 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24161>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---
 builtin-add.c  |    3 +--
 builtin-rm.c   |    3 +--
 combine-diff.c |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 2d25698..3a73a17 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -21,8 +21,7 @@ static void prune_directory(struct dir_s
 
 	for (specs = 0; pathspec[specs];  specs++)
 		/* nothing */;
-	seen = xmalloc(specs);
-	memset(seen, 0, specs);
+	seen = xcalloc(specs, 1);
 
 	src = dst = dir->entries;
 	i = dir->nr;
diff --git a/builtin-rm.c b/builtin-rm.c
index 5deb811..bb810ba 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -90,8 +90,7 @@ int cmd_rm(int argc, const char **argv, 
 	seen = NULL;
 	for (i = 0; pathspec[i] ; i++)
 		/* nothing */;
-	seen = xmalloc(i);
-	memset(seen, 0, i);
+	seen = xcalloc(i, 1);
 
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
diff --git a/combine-diff.c b/combine-diff.c
index 1bc1484..919112b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -639,8 +639,7 @@ static int show_patch_diff(struct combin
 			/* deleted file */
 			result_size = 0;
 			elem->mode = 0;
-			result = xmalloc(1);
-			result[0] = 0;
+			result = xcalloc(1, 1);
 		}
 		if (0 <= fd)
 			close(fd);
-- 
1.4.2.rc1.ge7a0
