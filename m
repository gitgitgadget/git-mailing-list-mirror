From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Portability patches vs 1.7.0.2 [3/6]
Date: Tue, 9 Mar 2010 16:05:37 +0000
Message-ID: <20100309160537.GD99172@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MAH+hnPXVZWQ5cD/"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 17:13:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np23b-0008VK-C4
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 17:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870Ab0CIQNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 11:13:13 -0500
Received: from mail1.thewrittenword.com ([69.67.212.77]:59376 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab0CIQNK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 11:13:10 -0500
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 69AC35CD7
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 16:24:43 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 69AC35CD7
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id DCCFED3D
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 16:05:37 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id D0EA7BAB0; Tue,  9 Mar 2010 16:05:37 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141828>


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

## Dangling commas in enum is not portable

Unfortunately there are a still a lot of vendor compilers that choke
when the last entry in an enum has a dangling comma (irix is one, and
I can get you a list of which of our particular platforms exhibit this
problem).

This patch simply deletes all the commas that are required to be able
to compile those enums on all of our supported architectures.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)

--MAH+hnPXVZWQ5cD/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="enum.patch"

Index: dir.c
===================================================================
--- dir.c.orig
+++ dir.c
@@ -465,7 +465,7 @@ static struct dir_entry *dir_add_ignored
 enum exist_status {
 	index_nonexistent = 0,
 	index_directory,
-	index_gitdir,
+	index_gitdir
 };
 
 /*
@@ -533,7 +533,7 @@ static enum exist_status directory_exist
 enum directory_treatment {
 	show_directory,
 	ignore_directory,
-	recurse_into_directory,
+	recurse_into_directory
 };
 
 static enum directory_treatment treat_directory(struct dir_struct *dir,
Index: cache.h
===================================================================
--- cache.h.orig
+++ cache.h
@@ -361,7 +361,7 @@ enum object_type {
 	OBJ_OFS_DELTA = 6,
 	OBJ_REF_DELTA = 7,
 	OBJ_ANY,
-	OBJ_MAX,
+	OBJ_MAX
 };
 
 static inline enum object_type object_type(unsigned int mode)
@@ -544,7 +544,7 @@ extern int core_apply_sparse_checkout;
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
-	SAFE_CRLF_WARN = 2,
+	SAFE_CRLF_WARN = 2
 };
 
 extern enum safe_crlf safe_crlf;
@@ -555,14 +555,14 @@ enum branch_track {
 	BRANCH_TRACK_REMOTE,
 	BRANCH_TRACK_ALWAYS,
 	BRANCH_TRACK_EXPLICIT,
-	BRANCH_TRACK_OVERRIDE,
+	BRANCH_TRACK_OVERRIDE
 };
 
 enum rebase_setup_type {
 	AUTOREBASE_NEVER = 0,
 	AUTOREBASE_LOCAL,
 	AUTOREBASE_REMOTE,
-	AUTOREBASE_ALWAYS,
+	AUTOREBASE_ALWAYS
 };
 
 enum push_default_type {
@@ -654,7 +654,7 @@ enum sharedrepo {
 	OLD_PERM_GROUP      = 1,
 	OLD_PERM_EVERYBODY  = 2,
 	PERM_GROUP          = 0660,
-	PERM_EVERYBODY      = 0664,
+	PERM_EVERYBODY      = 0664
 };
 int git_config_perm(const char *var, const char *value);
 int set_shared_perm(const char *path, int mode);
@@ -863,7 +863,7 @@ struct ref {
 		REF_STATUS_REJECT_NODELETE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
-		REF_STATUS_EXPECTING_REPORT,
+		REF_STATUS_EXPECTING_REPORT
 	} status;
 	char *remote_status;
 	struct ref *peer_ref; /* when renaming */
Index: commit.h
===================================================================
--- commit.h.orig
+++ commit.h
@@ -60,7 +60,7 @@ enum cmit_fmt {
 	CMIT_FMT_EMAIL,
 	CMIT_FMT_USERFORMAT,
 
-	CMIT_FMT_UNSPECIFIED,
+	CMIT_FMT_UNSPECIFIED
 };
 
 struct pretty_print_context
Index: diff.h
===================================================================
--- diff.h.orig
+++ diff.h
@@ -131,7 +131,7 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
 	DIFF_WHITESPACE = 7,
-	DIFF_FUNCINFO = 8,
+	DIFF_FUNCINFO = 8
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
Index: grep.h
===================================================================
--- grep.h.orig
+++ grep.h
@@ -10,17 +10,17 @@ enum grep_pat_token {
 	GREP_OPEN_PAREN,
 	GREP_CLOSE_PAREN,
 	GREP_NOT,
-	GREP_OR,
+	GREP_OR
 };
 
 enum grep_context {
 	GREP_CONTEXT_HEAD,
-	GREP_CONTEXT_BODY,
+	GREP_CONTEXT_BODY
 };
 
 enum grep_header_field {
 	GREP_HEADER_AUTHOR = 0,
-	GREP_HEADER_COMMITTER,
+	GREP_HEADER_COMMITTER
 };
 
 struct grep_pat {
@@ -40,7 +40,7 @@ enum grep_expr_node {
 	GREP_NODE_ATOM,
 	GREP_NODE_NOT,
 	GREP_NODE_AND,
-	GREP_NODE_OR,
+	GREP_NODE_OR
 };
 
 struct grep_expr {
Index: remote.h
===================================================================
--- remote.h.orig
+++ remote.h
@@ -145,7 +145,7 @@ int branch_merge_matches(struct branch *
 enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
 	MATCH_REFS_ALL 		= (1 << 0),
-	MATCH_REFS_MIRROR	= (1 << 1),
+	MATCH_REFS_MIRROR	= (1 << 1)
 };
 
 /* Reporting of tracking info */
Index: connect.c
===================================================================
--- connect.c.orig
+++ connect.c
@@ -131,7 +131,7 @@ int path_match(const char *path, int nr,
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_SSH,
-	PROTO_GIT,
+	PROTO_GIT
 };
 
 static enum protocol get_protocol(const char *name)
Index: revision.c
===================================================================
--- revision.c.orig
+++ revision.c
@@ -1758,7 +1758,7 @@ int prepare_revision_walk(struct rev_inf
 enum rewrite_result {
 	rewrite_one_ok,
 	rewrite_one_noparents,
-	rewrite_one_error,
+	rewrite_one_error
 };
 
 static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
Index: http-walker.c
===================================================================
--- http-walker.c.orig
+++ http-walker.c
@@ -15,7 +15,7 @@ enum object_request_state {
 	WAITING,
 	ABORTED,
 	ACTIVE,
-	COMPLETE,
+	COMPLETE
 };
 
 struct object_request
Index: fast-import.c
===================================================================
--- fast-import.c.orig
+++ fast-import.c
@@ -267,7 +267,7 @@ struct hash_list
 typedef enum {
 	WHENSPEC_RAW = 1,
 	WHENSPEC_RFC2822,
-	WHENSPEC_NOW,
+	WHENSPEC_NOW
 } whenspec_type;
 
 struct recent_command
Index: http-push.c
===================================================================
--- http-push.c.orig
+++ http-push.c
@@ -105,7 +105,7 @@ enum transfer_state {
 	RUN_PUT,
 	RUN_MOVE,
 	ABORTED,
-	COMPLETE,
+	COMPLETE
 };
 
 struct transfer_request
Index: builtin-commit.c
===================================================================
--- builtin-commit.c.orig
+++ builtin-commit.c
@@ -57,7 +57,7 @@ static struct lock_file false_lock; /* u
 static enum {
 	COMMIT_AS_IS = 1,
 	COMMIT_NORMAL,
-	COMMIT_PARTIAL,
+	COMMIT_PARTIAL
 } commit_style;
 
 static const char *logfile, *force_author;
@@ -77,7 +77,7 @@ static char *untracked_files_arg, *force
 static enum {
 	CLEANUP_SPACE,
 	CLEANUP_NONE,
-	CLEANUP_ALL,
+	CLEANUP_ALL
 } cleanup_mode;
 static char *cleanup_arg;
 
Index: rerere.c
===================================================================
--- rerere.c.orig
+++ rerere.c
@@ -153,7 +153,7 @@ static int handle_path(unsigned char *sh
 	git_SHA_CTX ctx;
 	int hunk_no = 0;
 	enum {
-		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL,
+		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL
 	} hunk = RR_CONTEXT;
 	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
Index: wt-status.h
===================================================================
--- wt-status.h.orig
+++ wt-status.h
@@ -11,7 +11,7 @@ enum color_wt_status {
 	WT_STATUS_CHANGED,
 	WT_STATUS_UNTRACKED,
 	WT_STATUS_NOBRANCH,
-	WT_STATUS_UNMERGED,
+	WT_STATUS_UNMERGED
 };
 
 enum untracked_status_type {
Index: builtin-apply.c
===================================================================
--- builtin-apply.c.orig
+++ builtin-apply.c
@@ -56,7 +56,7 @@ static enum ws_error_action {
 	nowarn_ws_error,
 	warn_on_ws_error,
 	die_on_ws_error,
-	correct_ws_error,
+	correct_ws_error
 } ws_error_action = warn_on_ws_error;
 static int whitespace_error;
 static int squelch_whitespace_errors = 5;
Index: builtin-branch.c
===================================================================
--- builtin-branch.c.orig
+++ builtin-branch.c
@@ -36,20 +36,20 @@ static char branch_colors[][COLOR_MAXLEN
 	GIT_COLOR_NORMAL,	/* PLAIN */
 	GIT_COLOR_RED,		/* REMOTE */
 	GIT_COLOR_NORMAL,	/* LOCAL */
-	GIT_COLOR_GREEN,	/* CURRENT */
+	GIT_COLOR_GREEN		/* CURRENT */
 };
 enum color_branch {
 	BRANCH_COLOR_RESET = 0,
 	BRANCH_COLOR_PLAIN = 1,
 	BRANCH_COLOR_REMOTE = 2,
 	BRANCH_COLOR_LOCAL = 3,
-	BRANCH_COLOR_CURRENT = 4,
+	BRANCH_COLOR_CURRENT = 4
 };
 
 static enum merge_filter {
 	NO_FILTER = 0,
 	SHOW_NOT_MERGED,
-	SHOW_MERGED,
+	SHOW_MERGED
 } merge_filter;
 static unsigned char merge_filter_ref[20];
 
Index: builtin-help.c
===================================================================
--- builtin-help.c.orig
+++ builtin-help.c
@@ -26,7 +26,7 @@ enum help_format {
 	HELP_FORMAT_NONE,
 	HELP_FORMAT_MAN,
 	HELP_FORMAT_INFO,
-	HELP_FORMAT_WEB,
+	HELP_FORMAT_WEB
 };
 
 static int show_all = 0;
Index: builtin-mailinfo.c
===================================================================
--- builtin-mailinfo.c.orig
+++ builtin-mailinfo.c
@@ -17,10 +17,10 @@ static struct strbuf name = STRBUF_INIT;
 static struct strbuf email = STRBUF_INIT;
 
 static enum  {
-	TE_DONTCARE, TE_QP, TE_BASE64,
+	TE_DONTCARE, TE_QP, TE_BASE64
 } transfer_encoding;
 static enum  {
-	TYPE_TEXT, TYPE_OTHER,
+	TYPE_TEXT, TYPE_OTHER
 } message_type;
 
 static struct strbuf charset = STRBUF_INIT;
Index: builtin-receive-pack.c
===================================================================
--- builtin-receive-pack.c.orig
+++ builtin-receive-pack.c
@@ -16,7 +16,7 @@ enum deny_action {
 	DENY_UNCONFIGURED,
 	DENY_IGNORE,
 	DENY_WARN,
-	DENY_REFUSE,
+	DENY_REFUSE
 };
 
 static int deny_deletes;
Index: imap-send.c
===================================================================
--- imap-send.c.orig
+++ imap-send.c
@@ -212,7 +212,7 @@ enum CAPABILITY {
 	UIDPLUS,
 	LITERALPLUS,
 	NAMESPACE,
-	STARTTLS,
+	STARTTLS
 };
 
 static const char *cap_list[] = {
Index: ctype.c
===================================================================
--- ctype.c.orig
+++ ctype.c
@@ -10,7 +10,7 @@ enum {
 	A = GIT_ALPHA,
 	D = GIT_DIGIT,
 	G = GIT_GLOB_SPECIAL,	/* *, ?, [, \\ */
-	R = GIT_REGEX_SPECIAL,	/* $, (, ), +, ., ^, {, | */
+	R = GIT_REGEX_SPECIAL	/* $, (, ), +, ., ^, {, | */
 };
 
 unsigned char sane_ctype[256] = {
@@ -21,6 +21,6 @@ unsigned char sane_ctype[256] = {
 	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
 	A, A, A, A, A, A, A, A, A, A, A, G, G, 0, R, 0,		/*  80.. 95 */
 	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
-	A, A, A, A, A, A, A, A, A, A, A, R, R, 0, 0, 0,		/* 112..127 */
+	A, A, A, A, A, A, A, A, A, A, A, R, R, 0, 0, 0		/* 112..127 */
 	/* Nothing in the 128.. range */
 };

--MAH+hnPXVZWQ5cD/--
