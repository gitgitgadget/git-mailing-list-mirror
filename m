From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Start conforming code to "git subcmd" style
Date: Sat, 30 Aug 2008 14:12:53 +0300
Message-ID: <20080830111253.GA9148@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 13:14:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZOP2-000278-GP
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 13:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbYH3LMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 07:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYH3LMz
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 07:12:55 -0400
Received: from zakalwe.fi ([80.83.5.154]:56770 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbYH3LMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 07:12:54 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 5839E2BC68; Sat, 30 Aug 2008 14:12:53 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94374>

User notifications are presented as 'git cmd', and code comments
are presented as '"cmd"' or 'git's cmd', rather than 'git-cmd'.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
There will be more patches to come. I'm splitting these patches to 
approximately 200 lines for better review.

The patch tries to conform to Junio's style suggestions.

 builtin-apply.c            |    8 ++++----
 builtin-archive.c          |    8 ++++----
 builtin-blame.c            |    6 +++---
 builtin-branch.c           |    2 +-
 builtin-bundle.c           |    4 ++--
 builtin-cat-file.c         |    4 ++--
 builtin-check-ref-format.c |    2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2216a0b..4eb263e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -274,7 +274,7 @@ static void say_patch_name(FILE *output, const char *pre,
 static void read_patch_file(struct strbuf *sb, int fd)
 {
 	if (strbuf_read(sb, fd, 0) < 0)
-		die("git-apply: read returned %s", strerror(errno));
+		die("git apply: read returned %s", strerror(errno));
 
 	/*
 	 * Make sure that we have some slop in the buffer
@@ -506,17 +506,17 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 		name = orig_name;
 		len = strlen(name);
 		if (isnull)
-			die("git-apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
+			die("git apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
 		another = find_name(line, NULL, p_value, TERM_TAB);
 		if (!another || memcmp(another, name, len))
-			die("git-apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
+			die("git apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
 		free(another);
 		return orig_name;
 	}
 	else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
-			die("git-apply: bad git-diff - expected /dev/null on line %d", linenr);
+			die("git apply: bad git-diff - expected /dev/null on line %d", linenr);
 		return NULL;
 	}
 }
diff --git a/builtin-archive.c b/builtin-archive.c
index 22445ac..5ceec43 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -47,18 +47,18 @@ static int run_remote_archiver(const char *remote, int argc,
 
 	len = packet_read_line(fd[0], buf, sizeof(buf));
 	if (!len)
-		die("git-archive: expected ACK/NAK, got EOF");
+		die("git archive: expected ACK/NAK, got EOF");
 	if (buf[len-1] == '\n')
 		buf[--len] = 0;
 	if (strcmp(buf, "ACK")) {
 		if (len > 5 && !prefixcmp(buf, "NACK "))
-			die("git-archive: NACK %s", buf + 5);
-		die("git-archive: protocol error");
+			die("git archive: NACK %s", buf + 5);
+		die("git archive: protocol error");
 	}
 
 	len = packet_read_line(fd[0], buf, sizeof(buf));
 	if (len)
-		die("git-archive: expected a flush");
+		die("git archive: expected a flush");
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
 	rv = recv_sideband("archive", fd[0], 1, 2);
diff --git a/builtin-blame.c b/builtin-blame.c
index e4d12de..b8fa914 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1787,7 +1787,7 @@ static int prepare_lines(struct scoreboard *sb)
 
 /*
  * Add phony grafts for use with -S; this is primarily to
- * support git-cvsserver that wants to give a linear history
+ * support git's cvsserver that wants to give a linear history
  * to its clients.
  */
 static int read_ancestry(const char *graft_file)
@@ -2299,12 +2299,12 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('f', "show-name", &output_option, "Show original filename (Default: auto)", OUTPUT_SHOW_NAME),
 		OPT_BIT('n', "show-number", &output_option, "Show original linenumber (Default: off)", OUTPUT_SHOW_NUMBER),
 		OPT_BIT('p', "porcelain", &output_option, "Show in a format designed for machine consumption", OUTPUT_PORCELAIN),
-		OPT_BIT('c', NULL, &output_option, "Use the same output mode as git-annotate (Default: off)", OUTPUT_ANNOTATE_COMPAT),
+		OPT_BIT('c', NULL, &output_option, "Use the same output mode as git annotate (Default: off)", OUTPUT_ANNOTATE_COMPAT),
 		OPT_BIT('t', NULL, &output_option, "Show raw timestamp (Default: off)", OUTPUT_RAW_TIMESTAMP),
 		OPT_BIT('l', NULL, &output_option, "Show long commit SHA1 (Default: off)", OUTPUT_LONG_OBJECT_NAME),
 		OPT_BIT('s', NULL, &output_option, "Suppress author name and timestamp (Default: off)", OUTPUT_NO_AUTHOR),
 		OPT_BIT('w', NULL, &xdl_opts, "Ignore whitespace differences", XDF_IGNORE_WHITESPACE),
-		OPT_STRING('S', NULL, &revs_file, "file", "Use revisions from <file> instead of calling git-rev-list"),
+		OPT_STRING('S', NULL, &revs_file, "file", "Use revisions from <file> instead of calling git rev-list"),
 		OPT_STRING(0, "contents", &contents_from, "file", "Use <file>'s contents as the final image"),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies within and across files", PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, "score", "Find line movements within and across files", PARSE_OPT_OPTARG, blame_move_callback },
diff --git a/builtin-branch.c b/builtin-branch.c
index b1a2ad7..8efc828 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -526,7 +526,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		},
 		OPT__ABBREV(&abbrev),
 
-		OPT_GROUP("Specific git-branch actions:"),
+		OPT_GROUP("Specific git branch actions:"),
 		OPT_SET_INT('a', NULL, &kinds, "list both remote-tracking and local branches",
 			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
 		OPT_BIT('d', NULL, &delete, "delete fully merged branch", 1),
diff --git a/builtin-bundle.c b/builtin-bundle.c
index ac476e7..9b58152 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -6,10 +6,10 @@
  * Basic handler for bundle files to connect repositories via sneakernet.
  * Invocation must include action.
  * This function can create a bundle or provide information on an existing
- * bundle supporting git-fetch, git-pull, and git-ls-remote
+ * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char *bundle_usage="git-bundle (create <bundle> <git-rev-list args> | verify <bundle> | list-heads <bundle> [refname]... | unbundle <bundle> [refname]... )";
+static const char *bundle_usage="git bundle (create <bundle> <git rev-list args> | verify <bundle> | list-heads <bundle> [refname]... | unbundle <bundle> [refname]... )";
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 7441a56..3fba6b9 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -137,11 +137,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		break;
 
 	default:
-		die("git-cat-file: unknown option: %s\n", exp_type);
+		die("git cat-file: unknown option: %s\n", exp_type);
 	}
 
 	if (!buf)
-		die("git-cat-file %s: bad file", obj_name);
+		die("git cat-file %s: bad file", obj_name);
 
 	write_or_die(1, buf, size);
 	return 0;
diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index fe04be7..701de43 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -9,6 +9,6 @@
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	if (argc != 2)
-		usage("git-check-ref-format refname");
+		usage("git check-ref-format refname");
 	return !!check_ref_format(argv[1]);
 }
-- 
1.6.0.1
