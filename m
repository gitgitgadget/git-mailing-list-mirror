From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/7] add description parameter to OPT__DRY_RUN
Date: Mon, 08 Nov 2010 18:58:51 +0100
Message-ID: <4CD83A5B.1010601@lsrfire.ath.cx>
References: <4CD83917.3040801@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 18:59:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFVzs-0002eW-AC
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 18:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325Ab0KHR7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 12:59:00 -0500
Received: from india601.server4you.de ([85.25.151.105]:47810 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab0KHR65 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 12:58:57 -0500
Received: from [10.0.1.100] (p4FC56F37.dip.t-dialin.net [79.197.111.55])
	by india601.server4you.de (Postfix) with ESMTPSA id 07D4B2F807B;
	Mon,  8 Nov 2010 18:58:55 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CD83917.3040801@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160953>

Allows better help text to be defined than "dry run".  Also make use
of the macro in places that already had a different description.  No
object code changes intended.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/technical/api-parse-options.txt |    2 +-
 builtin/add.c                                 |    2 +-
 builtin/clean.c                               |    2 +-
 builtin/mv.c                                  |    2 +-
 builtin/notes.c                               |    3 +--
 builtin/prune.c                               |    3 +--
 builtin/remote.c                              |    2 +-
 builtin/rm.c                                  |    2 +-
 parse-options.h                               |    2 +-
 test-parse-options.c                          |    2 +-
 10 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 969489b..00c447c 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -118,7 +118,7 @@ There are some macros to easily define options:
 `OPT__COLOR(&int_var, description)`::
 	Add `\--color[=<when>]` and `--no-color`.
 
-`OPT__DRY_RUN(&int_var)`::
+`OPT__DRY_RUN(&int_var, description)`::
 	Add `-n, \--dry-run`.
 
 `OPT__QUIET(&int_var)`::
diff --git a/builtin/add.c b/builtin/add.c
index fbf1403..9625cee 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -313,7 +313,7 @@ static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
 static int ignore_add_errors, addremove, intent_to_add, ignore_missing = 0;
 
 static struct option builtin_add_options[] = {
-	OPT__DRY_RUN(&show_only),
+	OPT__DRY_RUN(&show_only, "dry run"),
 	OPT__VERBOSE(&verbose, "be verbose"),
 	OPT_GROUP(""),
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive picking"),
diff --git a/builtin/clean.c b/builtin/clean.c
index c8798f5..17ecbe6 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -49,7 +49,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet),
-		OPT__DRY_RUN(&show_only),
+		OPT__DRY_RUN(&show_only, "dry run"),
 		OPT_BOOLEAN('f', "force", &force, "force"),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				"remove whole directories"),
diff --git a/builtin/mv.c b/builtin/mv.c
index cdbb094..8677bd2 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -55,7 +55,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	int i, newfd;
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
 	struct option builtin_mv_options[] = {
-		OPT__DRY_RUN(&show_only),
+		OPT__DRY_RUN(&show_only, "dry run"),
 		OPT_BOOLEAN('f', "force", &force, "force move/rename even if target exists"),
 		OPT_BOOLEAN('k', NULL, &ignore_errors, "skip move/rename errors"),
 		OPT_END(),
diff --git a/builtin/notes.c b/builtin/notes.c
index e0a1f62..2ab070f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -804,8 +804,7 @@ static int prune(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	int show_only = 0, verbose = 0;
 	struct option options[] = {
-		OPT_BOOLEAN('n', "dry-run", &show_only,
-			    "do not remove, show only"),
+		OPT__DRY_RUN(&show_only, "do not remove, show only"),
 		OPT__VERBOSE(&verbose, "report pruned notes"),
 		OPT_END()
 	};
diff --git a/builtin/prune.c b/builtin/prune.c
index 8b770af..e65690b 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -125,8 +125,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	const struct option options[] = {
-		OPT_BOOLEAN('n', "dry-run", &show_only,
-			    "do not remove, show only"),
+		OPT__DRY_RUN(&show_only, "do not remove, show only"),
 		OPT__VERBOSE(&verbose, "report pruned objects"),
 		OPT_DATE(0, "expire", &expire,
 			 "expire objects older than <time>"),
diff --git a/builtin/remote.c b/builtin/remote.c
index b944b91..30b9922 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1200,7 +1200,7 @@ static int prune(int argc, const char **argv)
 {
 	int dry_run = 0, result = 0;
 	struct option options[] = {
-		OPT__DRY_RUN(&dry_run),
+		OPT__DRY_RUN(&dry_run, "dry run"),
 		OPT_END()
 	};
 
diff --git a/builtin/rm.c b/builtin/rm.c
index f3772c8..26b7412 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -139,7 +139,7 @@ static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
 static int ignore_unmatch = 0;
 
 static struct option builtin_rm_options[] = {
-	OPT__DRY_RUN(&show_only),
+	OPT__DRY_RUN(&show_only, "dry run"),
 	OPT__QUIET(&quiet),
 	OPT_BOOLEAN( 0 , "cached",         &index_only, "only remove from the index"),
 	OPT_BOOLEAN('f', "force",          &force,      "override the up-to-date check"),
diff --git a/parse-options.h b/parse-options.h
index 14918b1..69ce094 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -205,7 +205,7 @@ extern int parse_opt_tertiary(const struct option *, const char *, int);
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
 	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, "be more quiet", \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
-#define OPT__DRY_RUN(var)  OPT_BOOLEAN('n', "dry-run", (var), "dry run")
+#define OPT__DRY_RUN(var, h)  OPT_BOOLEAN('n', "dry-run", (var), (h))
 #define OPT__ABBREV(var)  \
 	{ OPTION_CALLBACK, 0, "abbrev", (var), "n", \
 	  "use <n> digits to display SHA-1s", \
diff --git a/test-parse-options.c b/test-parse-options.c
index bd7b8a4..cddd106 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -67,7 +67,7 @@ int main(int argc, const char **argv)
 		OPT_GROUP("Standard options"),
 		OPT__ABBREV(&abbrev),
 		OPT__VERBOSE(&verbose, "be verbose"),
-		OPT__DRY_RUN(&dry_run),
+		OPT__DRY_RUN(&dry_run, "dry run"),
 		OPT__QUIET(&quiet),
 		OPT_END(),
 	};
-- 
1.7.3
