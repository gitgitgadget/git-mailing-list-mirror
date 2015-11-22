From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v1] blame: add support for --[no-]progress option
Date: Sat, 21 Nov 2015 23:11:56 -0600
Message-ID: <1448169116-32335-1-git-send-email-eantoranz@gmail.com>
Cc: peff@peff.net, max@max630.net,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 06:12:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0MxI-00015e-3t
	for gcvg-git-2@plane.gmane.org; Sun, 22 Nov 2015 06:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbbKVFMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2015 00:12:08 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34410 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbbKVFMH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2015 00:12:07 -0500
Received: by ykfs79 with SMTP id s79so208803299ykf.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2015 21:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kEz5+cNN2uhar8dSkJCJtZiu3+ss4disAgvEXuYw6UI=;
        b=0NBZ9wOqeYNzcBytpwJ8/FTZ/FVrgxQzeLI0MCLox4R+9lTMV1KjiFU+vSTiv4wE+9
         8DpxWCGab48aMy3v4qQyajw0f6OVe18jxrcSvQLdd1ecE6ipA2rodMTGCTAIzqEqO8h6
         VCqz0yhBL5mMlSL6JiKWW4N0QzH9ijUsKeRgMmQM+s8yi1gNLlFT6aj36/y6AgAAQgqv
         B983fUTfntSG78bHX7V0VdJFw9xQgD3TYIbxQhV7Dzbikr7Nzg+EW7sJe2wsuBRaaHJZ
         aBXRuKP/DyQiX5BoEi5IUyOF766F6UIsXc4g/QWFjFgx6eDquJfsvbtK4g/X/TE3x4vu
         YAtg==
X-Received: by 10.129.113.68 with SMTP id m65mr794145ywc.61.1448169125656;
        Sat, 21 Nov 2015 21:12:05 -0800 (PST)
Received: from linuxerio.cabletica.com (ip100-190-15-186.ct.co.cr. [186.15.190.100])
        by smtp.gmail.com with ESMTPSA id j65sm6421320ywg.52.2015.11.21.21.12.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Nov 2015 21:12:04 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281560>

Will also affect annotate

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/blame-options.txt |  7 +++++++
 Documentation/git-blame.txt     |  9 ++++++++-
 builtin/blame.c                 | 39 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 51 insertions(+), 4 deletions(-)

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
index 83612f5..31477d8 100644
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
@@ -1760,14 +1762,28 @@ static void found_guilty_entry(struct blame_entry *ent)
 	}
 }
 
+static int count_blamed_lines(struct scoreboard *sb)
+{
+	int counter = 0;
+	for (struct blame_entry * entry = sb->ent; entry; entry = entry->next)
+		counter += entry->num_lines;
+	return counter;
+}
+
 /*
  * The main loop -- while we have blobs with lines whose true origin
  * is still unknown, pick one blob, and allow its lines to pass blames
  * to its parents. */
-static void assign_blame(struct scoreboard *sb, int opt)
+static void assign_blame(struct scoreboard *sb, int opt, int show_progress)
 {
 	struct rev_info *revs = sb->revs;
 	struct commit *commit = prio_queue_get(&sb->commits);
+	struct progress * progress = NULL;
+	int blamed_lines = -1;
+
+	if (show_progress) {
+		progress = start_progress(_("Blaming lines"), sb->num_lines);
+	}
 
 	while (commit) {
 		struct blame_entry *ent;
@@ -1822,9 +1838,21 @@ static void assign_blame(struct scoreboard *sb, int opt)
 		}
 		origin_decref(suspect);
 
+		if (progress) {
+			int current_blamed_lines = count_blamed_lines(sb);
+			if (current_blamed_lines > blamed_lines) {
+				blamed_lines = current_blamed_lines;
+				display_progress(progress, blamed_lines);
+			}
+		}
+
 		if (DEBUG) /* sanity */
 			sanity_check_refcnt(sb);
 	}
+
+	if (progress) {
+		stop_progress(&progress);
+	}
 }
 
 static const char *format_time(unsigned long time, const char *tz_str,
@@ -2520,6 +2548,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
 		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
 		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
+		OPT_BOOL(0, "progress", &show_progress, N_("Force progress reporting")),
 		OPT_BIT(0, "score-debug", &output_option, N_("Show output score for blame entries"), OUTPUT_SHOW_SCORE),
 		OPT_BIT('f', "show-name", &output_option, N_("Show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
 		OPT_BIT('n', "show-number", &output_option, N_("Show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
@@ -2555,6 +2584,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
+	show_progress = -1;
 
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
@@ -2578,6 +2608,9 @@ parse_done:
 	no_whole_file_rename = !DIFF_OPT_TST(&revs.diffopt, FOLLOW_RENAMES);
 	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
 	argc = parse_options_end(&ctx);
+	if (show_progress < 0) {
+		show_progress = isatty(2);
+	}
 
 	if (0 < abbrev)
 		/* one more abbrev length is needed for the boundary commit */
@@ -2830,11 +2863,11 @@ parse_done:
 
 	read_mailmap(&mailmap, NULL);
 
+	assign_blame(&sb, opt, show_progress);
+
 	if (!incremental)
 		setup_pager();
 
-	assign_blame(&sb, opt);
-
 	free(final_commit_name);
 
 	if (incremental)
-- 
2.6.2
