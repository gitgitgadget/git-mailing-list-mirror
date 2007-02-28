From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] --amend Rename --pretty=changelog to --pretty=gnucl
Date: Wed, 28 Feb 2007 13:44:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702281343200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702280258200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702272147590.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 13:44:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMOAt-0002Hn-7v
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 13:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbXB1Mot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 07:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbXB1Mot
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 07:44:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:36365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752155AbXB1Mos (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 07:44:48 -0500
Received: (qmail invoked by alias); 28 Feb 2007 12:44:46 -0000
X-Provags-ID: V01U2FsdGVkX1+SmpwZtWiSygAgguKzX6FQpRp91sLDG6adrjYK6c
	+RKQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <alpine.LRH.0.82.0702272147590.29426@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40918>


Also rename {CMIT_FMT_,DIFF_FORMAT_}{CHANGELOG=>GNUCL}.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 27 Feb 2007, Nicolas Pitre wrote:

	> Shouldn't it be CMIT_FMT_GNUCL as well to be consistent?
	> 
	> This is nitpicking but I don't see why those GNU abominations 
	> should be assigned generic terms, even in this particular name 
	> space.

	I agree.

 commit.c   |   14 +++++++-------
 commit.h   |    2 +-
 diff.c     |    2 +-
 diff.h     |    2 +-
 log-tree.c |    4 ++--
 revision.c |    4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/commit.c b/commit.c
index abd84a8..3cb7e1c 100644
--- a/commit.c
+++ b/commit.c
@@ -38,7 +38,7 @@ struct cmt_fmt_map {
 	{ "fuller",	5,	CMIT_FMT_FULLER },
 	{ "oneline",	1,	CMIT_FMT_ONELINE },
 	{ "format:",	7,	CMIT_FMT_USERFORMAT},
-	{ "gnucl",	1,	CMIT_FMT_CHANGELOG}
+	{ "gnucl",	1,	CMIT_FMT_GNUCL}
 };
 
 static char *user_format;
@@ -564,7 +564,7 @@ static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
 		ret += namelen - display_name_length;
 		buf[ret++] = '\n';
 	}
-	else if (fmt == CMIT_FMT_CHANGELOG)
+	else if (fmt == CMIT_FMT_GNUCL)
 		ret = 0;
 	else {
 		ret = sprintf(buf, "%s: %.*s%.*s\n", what,
@@ -584,7 +584,7 @@ static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
 		ret += sprintf(buf + ret, "%sDate: %s\n", what,
 			       show_date(time, tz, relative_date));
 		break;
-	case CMIT_FMT_CHANGELOG:
+	case CMIT_FMT_GNUCL:
 		ret += sprintf(buf + ret, "%s  %.*s\n",
 				show_date(time, tz, DATE_SHORT),
 				namelen, line);
@@ -611,7 +611,7 @@ static int add_merge_info(enum cmit_fmt fmt, char *buf, const struct commit *com
 	int offset;
 
 	if ((fmt == CMIT_FMT_ONELINE) || (fmt == CMIT_FMT_EMAIL) ||
-	    fmt == CMIT_FMT_CHANGELOG || !parent || !parent->next)
+	    fmt == CMIT_FMT_GNUCL || !parent || !parent->next)
 		return 0;
 
 	offset = sprintf(buf, "Merge:");
@@ -940,7 +940,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 		msg = reencoded;
 
 	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL ||
-	    fmt == CMIT_FMT_CHANGELOG)
+	    fmt == CMIT_FMT_GNUCL)
 		indent = 0;
 
 	/* After-subject is used to pass in Content-Type: multipart
@@ -992,7 +992,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 			if (linelen == 1) {
 				hdr = 0;
 				if (fmt != CMIT_FMT_ONELINE &&
-				    fmt != CMIT_FMT_CHANGELOG && !subject)
+				    fmt != CMIT_FMT_GNUCL && !subject)
 					buf[offset++] = '\n';
 				continue;
 			}
@@ -1062,7 +1062,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 			offset += linelen + indent;
 		}
 		buf[offset++] = '\n';
-		if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_CHANGELOG)
+		if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_GNUCL)
 			break;
 		if (subject && plain_non_ascii) {
 			int sz;
diff --git a/commit.h b/commit.h
index 9d59e0f..2425f7b 100644
--- a/commit.h
+++ b/commit.h
@@ -48,7 +48,7 @@ enum cmit_fmt {
 	CMIT_FMT_ONELINE,
 	CMIT_FMT_EMAIL,
 	CMIT_FMT_USERFORMAT,
-	CMIT_FMT_CHANGELOG,
+	CMIT_FMT_GNUCL,
 
 	CMIT_FMT_UNSPECIFIED,
 };
diff --git a/diff.c b/diff.c
index f2d162f..9f9cb34 100644
--- a/diff.c
+++ b/diff.c
@@ -2821,7 +2821,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & DIFF_FORMAT_CHANGELOG) {
+	if (output_format & DIFF_FORMAT_GNUCL) {
 		struct changelog_t changelog;
 		memset(&changelog, 0, sizeof(struct changelog_t));
 		for (i = 0; i < q->nr; i++) {
diff --git a/diff.h b/diff.h
index df3b512..1c52851 100644
--- a/diff.h
+++ b/diff.h
@@ -30,7 +30,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_FORMAT_SUMMARY	0x0008
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
-#define DIFF_FORMAT_CHANGELOG	0x0040
+#define DIFF_FORMAT_GNUCL	0x0040
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
diff --git a/log-tree.c b/log-tree.c
index b7006bf..dd49154 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -212,7 +212,7 @@ void show_log(struct rev_info *opt, const char *sep)
 			opt->diffopt.stat_sep = buffer;
 		}
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT &&
-			opt->commit_format != CMIT_FMT_CHANGELOG) {
+			opt->commit_format != CMIT_FMT_GNUCL) {
 		fputs(diff_get_color(opt->diffopt.color_diff, DIFF_COMMIT),
 		      stdout);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
@@ -254,7 +254,7 @@ void show_log(struct rev_info *opt, const char *sep)
 				  sizeof(this_header), abbrev, subject,
 				  extra_headers, opt->relative_date);
 
-	if (opt->commit_format == CMIT_FMT_CHANGELOG) {
+	if (opt->commit_format == CMIT_FMT_GNUCL) {
 		static char *oneline = NULL;
 		char *eol = strchr(this_header, '\n');
 
diff --git a/revision.c b/revision.c
index 5bdc1fc..d7b9d2d 100644
--- a/revision.c
+++ b/revision.c
@@ -1119,8 +1119,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		if (revs->dense_combined_merges && !revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
-	if (revs->commit_format == CMIT_FMT_CHANGELOG) {
-		revs->diffopt.output_format |= DIFF_FORMAT_CHANGELOG;
+	if (revs->commit_format == CMIT_FMT_GNUCL) {
+		revs->diffopt.output_format |= DIFF_FORMAT_GNUCL;
 		revs->diff = 1;
 		revs->diffopt.recursive = 1;
 		revs->no_merges = 1;
-- 
1.5.0.2.778.g534f-dirty
