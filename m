From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/7] avoid to use error that shadows the function name, use err instead.
Date: Wed, 23 Aug 2006 12:39:10 +0200
Message-ID: <11563295562072-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 23 12:40:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFq9A-0007TY-Ia
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 12:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWHWKj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 06:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWHWKj2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 06:39:28 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:55229 "EHLO mx2.intersec.fr")
	by vger.kernel.org with ESMTP id S964832AbWHWKjU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 06:39:20 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id 14186D817F;
	Wed, 23 Aug 2006 12:39:17 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id E6DB23FE07; Wed, 23 Aug 2006 12:39:16 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.g4caa
In-Reply-To: 200608231238.10963.madcoder@debian.org
References: 200608231238.10963.madcoder@debian.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25910>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-apply.c |    6 +++---
 builtin-push.c  |   10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 4f0eef0..5991737 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1907,13 +1907,13 @@ static int check_patch(struct patch *pat
 static int check_patch_list(struct patch *patch)
 {
 	struct patch *prev_patch = NULL;
-	int error = 0;
+	int err = 0;
 
 	for (prev_patch = NULL; patch ; patch = patch->next) {
-		error |= check_patch(patch, prev_patch);
+		err |= check_patch(patch, prev_patch);
 		prev_patch = patch;
 	}
-	return error;
+	return err;
 }
 
 static void show_index_list(struct patch *list)
diff --git a/builtin-push.c b/builtin-push.c
index 2b5e6fa..ada8338 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -232,7 +232,7 @@ static int do_push(const char *repo)
 	common_argc = argc;
 
 	for (i = 0; i < n; i++) {
-		int error;
+		int err;
 		int dest_argc = common_argc;
 		int dest_refspec_nr = refspec_nr;
 		const char **dest_refspec = refspec;
@@ -248,10 +248,10 @@ static int do_push(const char *repo)
 		while (dest_refspec_nr--)
 			argv[dest_argc++] = *dest_refspec++;
 		argv[dest_argc] = NULL;
-		error = run_command_v(argc, argv);
-		if (!error)
+		err = run_command_v(argc, argv);
+		if (!err)
 			continue;
-		switch (error) {
+		switch (err) {
 		case -ERR_RUN_COMMAND_FORK:
 			die("unable to fork for %s", sender);
 		case -ERR_RUN_COMMAND_EXEC:
@@ -262,7 +262,7 @@ static int do_push(const char *repo)
 		case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
 			die("%s died with strange error", sender);
 		default:
-			return -error;
+			return -err;
 		}
 	}
 	return 0;
-- 
1.4.1.1
