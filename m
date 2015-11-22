From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v2] blame: add support for --[no-]progress option
Date: Sun, 22 Nov 2015 10:02:13 -0600
Message-ID: <1448208133-29430-1-git-send-email-eantoranz@gmail.com>
Cc: peff@peff.net, max@max630.net,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 17:02:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0X5w-0001UC-9K
	for gcvg-git-2@plane.gmane.org; Sun, 22 Nov 2015 17:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbbKVQCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2015 11:02:25 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35572 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbbKVQCY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2015 11:02:24 -0500
Received: by ykba77 with SMTP id a77so214441461ykb.2
        for <git@vger.kernel.org>; Sun, 22 Nov 2015 08:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WGgEOWgXVaEjEQssdJmdMa+4YtMlJhj4GVjnsB/eLZ8=;
        b=gb1Gw6Ra6tm/w0BNwA0nrK9pw5tMPq5a78CHvss8MxE6779S8WhSfyOwgtZ9v8OcWo
         VPRcfvf1dckDSjohEZs2anHIvfDBhUBEAC9em55XHh/1G5/LL+r/eMMhBe1EG6MxWuge
         RMepAQMXAFCOzK2wo9Yo3BJaDaavNlg1+AHsO/hPMnKxJK9H8zTXTywUa5r7C+NBjQnv
         CCBynaGrpls6a5GGBZdoEMC3RsEcpRQ2W0vnlmMiVALyLEWcEzkjPoACHqyFZ7Kts+nc
         eYVhRMSvU/vHEcm3is6qp7U00cHj3T2UygXZX6cshdJxiaRzv2XK3wbM/q+F8jwlGAym
         2eSQ==
X-Received: by 10.13.229.133 with SMTP id o127mr20351796ywe.267.1448208143418;
        Sun, 22 Nov 2015 08:02:23 -0800 (PST)
Received: from linuxerio.cabletica.com (ip100-190-15-186.ct.co.cr. [186.15.190.100])
        by smtp.gmail.com with ESMTPSA id p63sm7988977ywf.8.2015.11.22.08.02.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Nov 2015 08:02:22 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281566>

Will also affect annotate

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/blame-options.txt |  7 +++++++
 Documentation/git-blame.txt     |  9 ++++++++-
 builtin/blame.c                 | 25 +++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 760eab7..43f4f08 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -69,6 +69,13 @@ include::line-range-format.txt[]
 	iso format is used. For supported values, see the discussion
 	of the --date option at linkgit:git-log[1].
 
+--[no-]progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal. This flag
+	enables progress reporting even if not attached to a
+	terminal.
+
+
 -M|<num>|::
 	Detect moved or copied lines within a file. When a commit
 	moves or copies a block of lines (e.g. the original file
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index e6e947c..2e63397 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
-	    [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
+	    [--[no-]progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>]
+	    [--] <file>
 
 DESCRIPTION
 -----------
@@ -88,6 +89,12 @@ include::blame-options.txt[]
 	abbreviated object name, use <n>+1 digits. Note that 1 column
 	is used for a caret to mark the boundary commit.
 
+--[no-]progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal. This flag
+	enables progress reporting even if not attached to a
+	terminal.
+
 
 THE PORCELAIN FORMAT
 --------------------
diff --git a/builtin/blame.c b/builtin/blame.c
index 83612f5..480bb2d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -28,6 +28,7 @@
 #include "line-range.h"
 #include "line-log.h"
 #include "dir.h"
+#include "progress.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
@@ -50,6 +51,7 @@ static int incremental;
 static int xdl_opts;
 static int abbrev = -1;
 static int no_whole_file_rename;
+static int show_progress;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -1768,6 +1770,11 @@ static void assign_blame(struct scoreboard *sb, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	struct commit *commit = prio_queue_get(&sb->commits);
+	struct progress * progress = NULL;
+	int blamed_lines = 0;
+
+	if (show_progress)
+		progress = start_progress(_("Blaming lines"), sb->num_lines);
 
 	while (commit) {
 		struct blame_entry *ent;
@@ -1814,6 +1821,12 @@ static void assign_blame(struct scoreboard *sb, int opt)
 					ent = next;
 					continue;
 				}
+				if (progress) {
+					for (next = suspect->suspects; next != NULL;
+					     next = next->next)
+						blamed_lines += next->num_lines;
+					display_progress(progress, blamed_lines);
+				}
 				ent->next = sb->ent;
 				sb->ent = suspect->suspects;
 				suspect->suspects = NULL;
@@ -1825,6 +1838,9 @@ static void assign_blame(struct scoreboard *sb, int opt)
 		if (DEBUG) /* sanity */
 			sanity_check_refcnt(sb);
 	}
+
+	if (progress)
+		stop_progress(&progress);
 }
 
 static const char *format_time(unsigned long time, const char *tz_str,
@@ -2520,6 +2536,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
 		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
 		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
+		OPT_BOOL(0, "progress", &show_progress, N_("Force progress reporting")),
 		OPT_BIT(0, "score-debug", &output_option, N_("Show output score for blame entries"), OUTPUT_SHOW_SCORE),
 		OPT_BIT('f', "show-name", &output_option, N_("Show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
 		OPT_BIT('n', "show-number", &output_option, N_("Show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
@@ -2555,6 +2572,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
+	show_progress = -1;
 
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
@@ -2579,6 +2597,9 @@ parse_done:
 	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
 	argc = parse_options_end(&ctx);
 
+	if (show_progress < 0)
+		show_progress = isatty(2);
+
 	if (0 < abbrev)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
@@ -2830,11 +2851,11 @@ parse_done:
 
 	read_mailmap(&mailmap, NULL);
 
+	assign_blame(&sb, opt);
+
 	if (!incremental)
 		setup_pager();
 
-	assign_blame(&sb, opt);
-
 	free(final_commit_name);
 
 	if (incremental)
-- 
2.6.2
