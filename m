From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/7] add description parameter to OPT__VERBOSE
Date: Mon, 08 Nov 2010 18:56:39 +0100
Message-ID: <4CD839D7.8070403@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 18:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFVxb-0001It-Ad
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 18:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239Ab0KHR4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 12:56:45 -0500
Received: from india601.server4you.de ([85.25.151.105]:33821 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab0KHR4p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 12:56:45 -0500
Received: from [10.0.1.100] (p4FC56F37.dip.t-dialin.net [79.197.111.55])
	by india601.server4you.de (Postfix) with ESMTPSA id 503332F807B;
	Mon,  8 Nov 2010 18:56:43 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160952>

Allows better help text to be defined than "be verbose".  Also make use
of the macro in places that already had a different description.  No
object code changes intended.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/technical/api-parse-options.txt |    2 +-
 archive.c                                     |    2 +-
 builtin/add.c                                 |    2 +-
 builtin/apply.c                               |    2 +-
 builtin/branch.c                              |    2 +-
 builtin/commit.c                              |    4 ++--
 builtin/count-objects.c                       |    2 +-
 builtin/fsck.c                                |    2 +-
 builtin/log.c                                 |    2 +-
 builtin/notes.c                               |    2 +-
 builtin/prune.c                               |    2 +-
 builtin/read-tree.c                           |    2 +-
 builtin/remote.c                              |    2 +-
 builtin/verify-tag.c                          |    2 +-
 parse-options.h                               |    2 +-
 test-parse-options.c                          |    2 +-
 16 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index c5d141c..969489b 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -124,7 +124,7 @@ There are some macros to easily define options:
 `OPT__QUIET(&int_var)`::
 	Add `-q, \--quiet`.
 
-`OPT__VERBOSE(&int_var)`::
+`OPT__VERBOSE(&int_var, description)`::
 	Add `-v, \--verbose`.
 
 `OPT_GROUP(description)`::
diff --git a/archive.c b/archive.c
index f59afda..78a67f0 100644
--- a/archive.c
+++ b/archive.c
@@ -314,7 +314,7 @@ static int parse_archive_args(int argc, const char **argv,
 			"write the archive to this file"),
 		OPT_BOOLEAN(0, "worktree-attributes", &worktree_attributes,
 			"read .gitattributes in working directory"),
-		OPT__VERBOSE(&verbose),
+		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT__COMPR('0', &compression_level, "store only", 0),
 		OPT__COMPR('1', &compression_level, "compress faster", 1),
 		OPT__COMPR_HIDDEN('2', &compression_level, 2),
diff --git a/builtin/add.c b/builtin/add.c
index 56a4e0a..fbf1403 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -314,7 +314,7 @@ static int ignore_add_errors, addremove, intent_to_add, ignore_missing = 0;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only),
-	OPT__VERBOSE(&verbose),
+	OPT__VERBOSE(&verbose, "be verbose"),
 	OPT_GROUP(""),
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive picking"),
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
diff --git a/builtin/apply.c b/builtin/apply.c
index 23c18c5..e1e9ecc 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3843,7 +3843,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			"don't expect at least one line of context"),
 		OPT_BOOLEAN(0, "reject", &apply_with_reject,
 			"leave the rejected hunks in corresponding *.rej files"),
-		OPT__VERBOSE(&apply_verbosely),
+		OPT__VERBOSE(&apply_verbosely, "be verbose"),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			"tolerate incorrectly detected missing new-line at the end of file",
 			INACCURATE_EOF),
diff --git a/builtin/branch.c b/builtin/branch.c
index 87976f0..10788fc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -621,7 +621,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
-		OPT__VERBOSE(&verbose),
+		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT_SET_INT('t', "track",  &track, "set up tracking mode (see git-pull(1))",
 			BRANCH_TRACK_EXPLICIT),
 		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..9cbc4ea 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -115,7 +115,7 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 
 static struct option builtin_commit_options[] = {
 	OPT__QUIET(&quiet),
-	OPT__VERBOSE(&verbose),
+	OPT__VERBOSE(&verbose, "be verbose"),
 
 	OPT_GROUP("Commit message options"),
 	OPT_FILENAME('F', "file", &logfile, "read log from file"),
@@ -1048,7 +1048,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	int fd;
 	unsigned char sha1[20];
 	static struct option builtin_status_options[] = {
-		OPT__VERBOSE(&verbose),
+		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT_SET_INT('s', "short", &status_format,
 			    "show status concisely", STATUS_FORMAT_SHORT),
 		OPT_BOOLEAN('b', "branch", &status_show_branch,
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 2bdd8eb..c37cb98 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -79,7 +79,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	unsigned long loose = 0, packed = 0, packed_loose = 0, garbage = 0;
 	off_t loose_size = 0;
 	struct option opts[] = {
-		OPT__VERBOSE(&verbose),
+		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT_END(),
 	};
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0929c7f..6d5ebca 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -572,7 +572,7 @@ static char const * const fsck_usage[] = {
 };
 
 static struct option fsck_opts[] = {
-	OPT__VERBOSE(&verbose),
+	OPT__VERBOSE(&verbose, "be verbose"),
 	OPT_BOOLEAN(0, "unreachable", &show_unreachable, "show unreachable objects"),
 	OPT_BOOLEAN(0, "tags", &show_tags, "report tags"),
 	OPT_BOOLEAN(0, "root", &show_root, "report root nodes"),
diff --git a/builtin/log.c b/builtin/log.c
index 22d1290..d0297a1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1365,7 +1365,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 
 	struct option options[] = {
 		OPT__ABBREV(&abbrev),
-		OPT__VERBOSE(&verbose),
+		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT_END()
 	};
 
diff --git a/builtin/notes.c b/builtin/notes.c
index 6d07aac..e0a1f62 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -806,7 +806,7 @@ static int prune(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOLEAN('n', "dry-run", &show_only,
 			    "do not remove, show only"),
-		OPT_BOOLEAN('v', "verbose", &verbose, "report pruned notes"),
+		OPT__VERBOSE(&verbose, "report pruned notes"),
 		OPT_END()
 	};
 
diff --git a/builtin/prune.c b/builtin/prune.c
index 99218ba..8b770af 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -127,7 +127,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	const struct option options[] = {
 		OPT_BOOLEAN('n', "dry-run", &show_only,
 			    "do not remove, show only"),
-		OPT_BOOLEAN('v', "verbose", &verbose, "report pruned objects"),
+		OPT__VERBOSE(&verbose, "report pruned objects"),
 		OPT_DATE(0, "expire", &expire,
 			 "expire objects older than <time>"),
 		OPT_END()
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index eb1e3e7..73c89ed 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -109,7 +109,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		  PARSE_OPT_NONEG, index_output_cb },
 		OPT_SET_INT(0, "empty", &read_empty,
 			    "only empty the index", 1),
-		OPT__VERBOSE(&opts.verbose_update),
+		OPT__VERBOSE(&opts.verbose_update, "be verbose"),
 		OPT_GROUP("Merging"),
 		OPT_SET_INT('m', NULL, &opts.merge,
 			    "perform a merge in addition to a read", 1),
diff --git a/builtin/remote.c b/builtin/remote.c
index e9a6e09..b944b91 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1512,7 +1512,7 @@ static int show_all(void)
 int cmd_remote(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
-		OPT_BOOLEAN('v', "verbose", &verbose, "be verbose; must be placed before a subcommand"),
+		OPT__VERBOSE(&verbose, "be verbose; must be placed before a subcommand"),
 		OPT_END()
 	};
 	int result;
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 9f482c2..6784846 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -93,7 +93,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	const struct option verify_tag_options[] = {
-		OPT__VERBOSE(&verbose),
+		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT_END()
 	};
 
diff --git a/parse-options.h b/parse-options.h
index d982f0f..14918b1 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -198,7 +198,7 @@ extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 extern int parse_opt_with_commit(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 
-#define OPT__VERBOSE(var)  OPT_BOOLEAN('v', "verbose", (var), "be verbose")
+#define OPT__VERBOSE(var, h)  OPT_BOOLEAN('v', "verbose", (var), (h))
 #define OPT__QUIET(var)    OPT_BOOLEAN('q', "quiet",   (var), "be quiet")
 #define OPT__VERBOSITY(var) \
 	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, "be more verbose", \
diff --git a/test-parse-options.c b/test-parse-options.c
index acd1a2b..bd7b8a4 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -66,7 +66,7 @@ int main(int argc, const char **argv)
 		  "negative ambiguity", PARSE_OPT_NOARG | PARSE_OPT_NONEG },
 		OPT_GROUP("Standard options"),
 		OPT__ABBREV(&abbrev),
-		OPT__VERBOSE(&verbose),
+		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT__DRY_RUN(&dry_run),
 		OPT__QUIET(&quiet),
 		OPT_END(),
-- 
1.7.3
