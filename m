From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 4/7] remove ugly shadowing of loop indexes in subloops.
Date: Wed, 23 Aug 2006 12:39:13 +0200
Message-ID: <11563295573215-git-send-email-madcoder@debian.org>
References: 200608231238.10963.madcoder@debian.org <11563295562072-git-send-email-madcoder@debian.org> <11563295562422-git-send-email-madcoder@debian.org> <1156329556788-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 23 12:40:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFq8v-0007Mz-4D
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 12:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWHWKjZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 06:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWHWKjY
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 06:39:24 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:22181 "EHLO mx2.intersec.fr")
	by vger.kernel.org with ESMTP id S964831AbWHWKjU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 06:39:20 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id 370D2D81C3;
	Wed, 23 Aug 2006 12:39:17 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id 0BAC23FE06; Wed, 23 Aug 2006 12:39:17 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.g4caa
In-Reply-To: <1156329556788-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25911>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-mv.c |    6 +++---
 git.c        |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index ff882be..fd1e520 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -262,10 +262,10 @@ int cmd_mv(int argc, const char **argv, 
 	} else {
 		for (i = 0; i < changed.nr; i++) {
 			const char *path = changed.items[i].path;
-			int i = cache_name_pos(path, strlen(path));
-			struct cache_entry *ce = active_cache[i];
+			int j = cache_name_pos(path, strlen(path));
+			struct cache_entry *ce = active_cache[j];
 
-			if (i < 0)
+			if (j < 0)
 				die ("Huh? Cache entry for %s unknown?", path);
 			refresh_cache_entry(ce, 0);
 		}
diff --git a/git.c b/git.c
index 930998b..a01d195 100644
--- a/git.c
+++ b/git.c
@@ -292,11 +292,11 @@ static void handle_internal_command(int 
 		if (p->option & USE_PAGER)
 			setup_pager();
 		if (getenv("GIT_TRACE")) {
-			int i;
+			int j;
 			fprintf(stderr, "trace: built-in: git");
-			for (i = 0; i < argc; ++i) {
+			for (j = 0; j < argc; ++j) {
 				fputc(' ', stderr);
-				sq_quote_print(stderr, argv[i]);
+				sq_quote_print(stderr, argv[j]);
 			}
 			putc('\n', stderr);
 			fflush(stderr);
-- 
1.4.1.1
