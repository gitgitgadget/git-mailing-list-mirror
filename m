From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/7] add description parameter to OPT__QUIET
Date: Mon, 08 Nov 2010 19:00:29 +0100
Message-ID: <4CD83ABD.30804@lsrfire.ath.cx>
References: <4CD83917.3040801@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:00:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFW1N-0003cS-LC
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab0KHSAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:00:36 -0500
Received: from india601.server4you.de ([85.25.151.105]:47812 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab0KHSAf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:00:35 -0500
Received: from [10.0.1.100] (p4FC56F37.dip.t-dialin.net [79.197.111.55])
	by india601.server4you.de (Postfix) with ESMTPSA id AD04C2F807B;
	Mon,  8 Nov 2010 19:00:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CD83917.3040801@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160954>

Allows better help text to be defined than "be quiet".  Also make use
of the macro in a place that already had a different description.  No
object code changes intended.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/technical/api-parse-options.txt |    2 +-
 builtin/checkout-index.c                      |    2 +-
 builtin/checkout.c                            |    2 +-
 builtin/clean.c                               |    2 +-
 builtin/commit.c                              |    2 +-
 builtin/gc.c                                  |    2 +-
 builtin/grep.c                                |    4 ++--
 builtin/merge-file.c                          |    2 +-
 builtin/reset.c                               |    2 +-
 builtin/rm.c                                  |    2 +-
 builtin/show-ref.c                            |    2 +-
 builtin/symbolic-ref.c                        |    2 +-
 parse-options.h                               |    2 +-
 test-parse-options.c                          |    2 +-
 14 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt
b/Documentation/technical/api-parse-options.txt
index 00c447c..248a66d 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -121,7 +121,7 @@ There are some macros to easily define options:
 `OPT__DRY_RUN(&int_var, description)`::
 	Add `-n, \--dry-run`.

-`OPT__QUIET(&int_var)`::
+`OPT__QUIET(&int_var, description)`::
 	Add `-q, \--quiet`.

 `OPT__VERBOSE(&int_var, description)`::
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 65cbee0..7ba0913 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -219,7 +219,7 @@ int cmd_checkout_index(int argc, const char **argv,
const char *prefix)
 			"checks out all files in the index"),
 		OPT_BOOLEAN('f', "force", &force,
 			"forces overwrite of existing files"),
-		OPT__QUIET(&quiet),
+		OPT__QUIET(&quiet, "be quiet"),
 		OPT_BOOLEAN('n', "no-create", &not_new,
 			"don't checkout new files"),
 		{ OPTION_CALLBACK, 'u', "index", &newfd, NULL,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9240faf..a952477 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -686,7 +686,7 @@ int cmd_checkout(int argc, const char **argv, const
char *prefix)
 	int patch_mode = 0;
 	int dwim_new_local_branch = 1;
 	struct option options[] = {
-		OPT__QUIET(&opts.quiet),
+		OPT__QUIET(&opts.quiet, "be quiet"),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
 			   "create and checkout a new branch"),
 		OPT_STRING('B', NULL, &opts.new_branch_force, "branch",
diff --git a/builtin/clean.c b/builtin/clean.c
index 17ecbe6..449d2a3 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -48,7 +48,7 @@ int cmd_clean(int argc, const char **argv, const char
*prefix)
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
-		OPT__QUIET(&quiet),
+		OPT__QUIET(&quiet, "be quiet"),
 		OPT__DRY_RUN(&show_only, "dry run"),
 		OPT_BOOLEAN('f', "force", &force, "force"),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
diff --git a/builtin/commit.c b/builtin/commit.c
index 9cbc4ea..97ae1bc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -114,7 +114,7 @@ static int opt_parse_m(const struct option *opt,
const char *arg, int unset)
 }

 static struct option builtin_commit_options[] = {
-	OPT__QUIET(&quiet),
+	OPT__QUIET(&quiet, "be quiet"),
 	OPT__VERBOSE(&verbose, "be verbose"),

 	OPT_GROUP("Commit message options"),
diff --git a/builtin/gc.c b/builtin/gc.c
index c304638..8f67325 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -180,7 +180,7 @@ int cmd_gc(int argc, const char **argv, const char
*prefix)
 	char buf[80];

 	struct option builtin_gc_options[] = {
-		OPT__QUIET(&quiet),
+		OPT__QUIET(&quiet, "be quiet"),
 		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
 			"prune unreferenced objects",
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
diff --git a/builtin/grep.c b/builtin/grep.c
index 3d5f6ac..adb5424 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -915,8 +915,8 @@ int cmd_grep(int argc, const char **argv, const char
*prefix)
 		{ OPTION_CALLBACK, ')', NULL, &opt, NULL, "",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
 		  close_callback },
-		OPT_BOOLEAN('q', "quiet", &opt.status_only,
-			    "indicate hit with exit status without output"),
+		OPT__QUIET(&opt.status_only,
+			   "indicate hit with exit status without output"),
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			"show only matches from files that match all patterns"),
 		OPT_GROUP(""),
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index b6664d4..58e4731 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -39,7 +39,7 @@ int cmd_merge_file(int argc, const char **argv, const
char *prefix)
 			    XDL_MERGE_FAVOR_UNION),
 		OPT_INTEGER(0, "marker-size", &xmp.marker_size,
 			    "for conflicts, use this marker size"),
-		OPT__QUIET(&quiet),
+		OPT__QUIET(&quiet, "be quiet"),
 		OPT_CALLBACK('L', NULL, names, "name",
 			     "set labels for file1/orig_file/file2", &label_cb),
 		OPT_END(),
diff --git a/builtin/reset.c b/builtin/reset.c
index 0037be4..d624207 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -243,7 +243,7 @@ int cmd_reset(int argc, const char **argv, const
char *prefix)
 	struct commit *commit;
 	char *reflog_action, msg[1024];
 	const struct option options[] = {
-		OPT__QUIET(&quiet),
+		OPT__QUIET(&quiet, "be quiet"),
 		OPT_SET_INT(0, "mixed", &reset_type,
 						"reset HEAD and index", MIXED),
 		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
diff --git a/builtin/rm.c b/builtin/rm.c
index 26b7412..49461b6 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -140,7 +140,7 @@ static int ignore_unmatch = 0;

 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, "dry run"),
-	OPT__QUIET(&quiet),
+	OPT__QUIET(&quiet, "be quiet"),
 	OPT_BOOLEAN( 0 , "cached",         &index_only, "only remove from the
index"),
 	OPT_BOOLEAN('f', "force",          &force,      "override the
up-to-date check"),
 	OPT_BOOLEAN('r', NULL,             &recursive,  "allow recursive
removal"),
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index be9b512..6507f03 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -193,7 +193,7 @@ static const struct option show_ref_options[] = {
 	  "only show SHA1 hash using <n> digits",
 	  PARSE_OPT_OPTARG, &hash_callback },
 	OPT__ABBREV(&abbrev),
-	OPT__QUIET(&quiet),
+	OPT__QUIET(&quiet, "be quiet"),
 	{ OPTION_CALLBACK, 0, "exclude-existing", &exclude_existing_arg,
 	  "pattern", "show refs from stdin that aren't in local repository",
 	  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, exclude_existing_callback },
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index ca855a5..1b28425 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -30,7 +30,7 @@ int cmd_symbolic_ref(int argc, const char **argv,
const char *prefix)
 	int quiet = 0;
 	const char *msg = NULL;
 	struct option options[] = {
-		OPT__QUIET(&quiet),
+		OPT__QUIET(&quiet, "be quiet"),
 		OPT_STRING('m', NULL, &msg, "reason", "reason of the update"),
 		OPT_END(),
 	};
diff --git a/parse-options.h b/parse-options.h
index 69ce094..3dd3a94 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -199,7 +199,7 @@ extern int parse_opt_with_commit(const struct option
*, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);

 #define OPT__VERBOSE(var, h)  OPT_BOOLEAN('v', "verbose", (var), (h))
-#define OPT__QUIET(var)    OPT_BOOLEAN('q', "quiet",   (var), "be quiet")
+#define OPT__QUIET(var, h)    OPT_BOOLEAN('q', "quiet",   (var), (h))
 #define OPT__VERBOSITY(var) \
 	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, "be more verbose", \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
diff --git a/test-parse-options.c b/test-parse-options.c
index cddd106..0828592 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -68,7 +68,7 @@ int main(int argc, const char **argv)
 		OPT__ABBREV(&abbrev),
 		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT__DRY_RUN(&dry_run, "dry run"),
-		OPT__QUIET(&quiet),
+		OPT__QUIET(&quiet, "be quiet"),
 		OPT_END(),
 	};
 	int i;
-- 
1.7.3
