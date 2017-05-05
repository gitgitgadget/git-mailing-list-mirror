Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECD2207B3
	for <e@80x24.org>; Fri,  5 May 2017 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755278AbdEESoI (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 14:44:08 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34602 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754918AbdEESoE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 14:44:04 -0400
Received: by mail-qk0-f194.google.com with SMTP id u75so2040619qka.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a3+g+ksTdrlzMmPVOgeMKSd4lDOvmr6qIb/OzuJTJ2g=;
        b=Ie3jc1v4wKYm426Q+TEB7hpeqGUuv4TWELme8AFCUd6uCNkKKW1RwNjqc/a2eTADlx
         9x5GN/UjnbupgJWmhJXriJ2mFLzJnjkyr8bQZOowMh/sWTWeOdorREnkk5NkeLwXYjpF
         63r0QjinOgGjWPK6QXmgmdP1inXK58/ufaLwedDCk92NMsVWbHCU5iL5xBewBhsOaMwd
         IX3kyFxgmMSzmC/g7EiEjum3Kf0wgXiEu9svqhcISCFRbGur3RPD2ZSBt7AdLh08GwuF
         nJDARFd0UdTW9/isNBzGvcSoeC4YVbVQRJ9EK6qzpgjep1qlXCPPiWD47OH8WA4fgC74
         kAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a3+g+ksTdrlzMmPVOgeMKSd4lDOvmr6qIb/OzuJTJ2g=;
        b=DOiuMLKKCc4CZJnbZTNrxZqFDh7hJttbw/AxlWaK+16ulq9XrMtroZRbOCTRZmA4ZJ
         vQ3S8FvjYyvA0bqL7qZkcQEuI7uR7SUDsTrtRE8UKvTKjBENjceuWHrmvBX7vCihC5wL
         5yYvb4zzeLVHztphuzcga+Y5NWhxv2KQ4unymvuNkO6mpXG/5X4jFJrn5q+2zp6iJ/l/
         s5x4NtikjaYsD1RVJk57PyScqQ4N37RllACenmSm/woUZGoA++rsQATixTOuILl6SKZb
         vSXCEhXtaFGQawvSYxDa5iLoqGadL6JxKcxycm1nfV31lAHQ2bskXUqx6geSmtfKXuIq
         XKxA==
X-Gm-Message-State: AODbwcAOMJ3vbDeSft3RtAv5ZwL7X2YocG1MHYH5WKijaqnanpLg1PIe
        KSpufgJbvtRTpGZi
X-Received: by 10.55.51.146 with SMTP id z140mr14894647qkz.100.1494009843512;
        Fri, 05 May 2017 11:44:03 -0700 (PDT)
Received: from localhost.localdomain (gwmind.semfio.usp.br. [143.107.127.12])
        by smtp.gmail.com with ESMTPSA id p184sm3733369qkb.17.2017.05.05.11.44.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 11:44:02 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH 2/3] add--interactive: add builtin helper for interactive add
Date:   Fri,  5 May 2017 15:43:39 -0300
Message-Id: <1494009820-2090-3-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a builtin helper for git-add--interactive, which right now is
only able to reproduce git-add--interactive.perl's status_cmd()
function, providing a summarized diff numstat to the user.

This is the first step in an effort to convert git-add--interactive.perl
to a C builtin, in search for better portability, expressibility and
performance (specially on non-POSIX systems like Windows).

Additionally, an eventual complete port of git-add--interactive would
remove the last "big" Git script to have Perl as a dependency, allowing
most Git users to have a NOPERL build running without big losses.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 .gitignore                        |   1 +
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/add-interactive--helper.c | 258 ++++++++++++++++++++++++++++++++++++++
 git.c                             |   1 +
 5 files changed, 262 insertions(+)
 create mode 100644 builtin/add-interactive--helper.c

diff --git a/.gitignore b/.gitignore
index 833ef3b..0d6cfe4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,6 +11,7 @@
 /git
 /git-add
 /git-add--interactive
+/git-add-interactive--helper
 /git-am
 /git-annotate
 /git-apply
diff --git a/Makefile b/Makefile
index e35542e..842fce2 100644
--- a/Makefile
+++ b/Makefile
@@ -873,6 +873,7 @@ LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
+BUILTIN_OBJS += builtin/add-interactive--helper.o
 BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
diff --git a/builtin.h b/builtin.h
index 9e4a898..3d6a0ab 100644
--- a/builtin.h
+++ b/builtin.h
@@ -30,6 +30,7 @@ extern int textconv_object(const char *path, unsigned mode, const struct object_
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
+extern int cmd_add_interactive__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_am(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
diff --git a/builtin/add-interactive--helper.c b/builtin/add-interactive--helper.c
new file mode 100644
index 0000000..97ca1b3
--- /dev/null
+++ b/builtin/add-interactive--helper.c
@@ -0,0 +1,258 @@
+#include "builtin.h"
+#include "color.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
+
+#define ADD_INTERACTIVE_HEADER_INDENT "      "
+
+enum add_interactive_collection_mode {
+	COLLECTION_MODE_NONE,
+	COLLECTION_MODE_WORKTREE,
+	COLLECTION_MODE_INDEX
+};
+
+struct add_interactive_file_status {
+	int selected;
+
+	char path[PATH_MAX];
+
+	int lines_added_index;
+	int lines_deleted_index;
+	int lines_added_worktree;
+	int lines_deleted_worktree;
+};
+
+struct add_interactive_status {
+	enum add_interactive_collection_mode current_mode;
+
+	const char *reference;
+	struct pathspec pathspec;
+
+	int file_count;
+	struct add_interactive_file_status *files;
+};
+
+static int add_interactive_use_color = -1;
+enum color_add_interactive {
+	ADD_INTERACTIVE_PROMPT,
+	ADD_INTERACTIVE_HEADER,
+	ADD_INTERACTIVE_HELP,
+	ADD_INTERACTIVE_ERROR
+};
+
+static char add_interactive_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_BOLD_BLUE, /* Prompt */
+	GIT_COLOR_BOLD,      /* Header */
+	GIT_COLOR_BOLD_RED,  /* Help */
+	GIT_COLOR_BOLD_RED   /* Error */
+};
+
+static const char *add_interactive_get_color(enum color_add_interactive ix)
+{
+	if (want_color(add_interactive_use_color))
+		return add_interactive_colors[ix];
+	return "";
+}
+
+static int parse_add_interactive_color_slot(const char *slot)
+{
+	if (!strcasecmp(slot, "prompt"))
+		return ADD_INTERACTIVE_PROMPT;
+	if (!strcasecmp(slot, "header"))
+		return ADD_INTERACTIVE_HEADER;
+	if (!strcasecmp(slot, "help"))
+		return ADD_INTERACTIVE_HELP;
+	if (!strcasecmp(slot, "error"))
+		return ADD_INTERACTIVE_ERROR;
+
+	return -1;
+}
+
+static int git_add_interactive_config(const char *var,
+		const char *value, void *cbdata)
+{
+	const char *name;
+
+	if (!strcmp(var, "color.interactive")) {
+		add_interactive_use_color = git_config_colorbool(var, value);
+		return 0;
+	}
+
+	if (skip_prefix(var, "color.interactive", &name)) {
+		int slot = parse_add_interactive_color_slot(name);
+		if (slot < 0)
+			return 0;
+		if (!value)
+			return config_error_nonbool(var);
+		return color_parse(value, add_interactive_colors[slot]);
+	}
+
+	return git_default_config(var, value, cbdata);
+}
+
+static void add_interactive_status_collect_changed_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
+{
+	struct add_interactive_status *s = data;
+	struct diffstat_t stat;
+	int i, j;
+
+	if (!q->nr)
+		return;
+
+	memset(&stat, 0, sizeof(struct diffstat_t));
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p;
+		p = q->queue[i];
+		diff_flush_stat(p, options, &stat);
+	}
+
+	for (i = 0; i < stat.nr; i++) {
+		int file_index = s->file_count;
+		for (j = 0; j < s->file_count; j++) {
+			if (!strcmp(s->files[j].path, stat.files[i]->name)) {
+				file_index = j;
+				break;
+			}
+		}
+
+		if (file_index == s->file_count) {
+			s->file_count++;
+			s->files = realloc(s->files,
+					(q->nr + s->file_count) * sizeof(*s->files));
+			memset(&s->files[file_index], 0,
+					sizeof(struct add_interactive_file_status));
+		}
+
+		memcpy(s->files[file_index].path, stat.files[i]->name,
+				strlen(stat.files[i]->name) + 1);
+		if (s->current_mode == COLLECTION_MODE_WORKTREE) {
+			s->files[file_index].lines_added_worktree = stat.files[i]->added;
+			s->files[file_index].lines_deleted_worktree = stat.files[i]->deleted;
+		} else if (s->current_mode == COLLECTION_MODE_INDEX) {
+			s->files[file_index].lines_added_index = stat.files[i]->added;
+			s->files[file_index].lines_deleted_index = stat.files[i]->deleted;
+		}
+	}
+}
+
+static void add_interactive_status_collect_changes_worktree(struct add_interactive_status *s)
+{
+	struct rev_info rev;
+
+	s->current_mode = COLLECTION_MODE_WORKTREE;
+
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, NULL);
+
+	rev.max_count = 0;
+
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = add_interactive_status_collect_changed_cb;
+	rev.diffopt.format_callback_data = s;
+
+	run_diff_files(&rev, 0);
+}
+
+static void add_interactive_status_collect_changes_index(struct add_interactive_status *s)
+{
+	struct rev_info rev;
+	struct setup_revision_opt opt;
+
+	s->current_mode = COLLECTION_MODE_INDEX;
+
+	init_revisions(&rev, NULL);
+	memset(&opt, 0, sizeof(opt));
+	opt.def = s->reference;
+	setup_revisions(0, NULL, &rev, &opt);
+
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = add_interactive_status_collect_changed_cb;
+	rev.diffopt.format_callback_data = s;
+
+	run_diff_index(&rev, 1);
+}
+
+static void list_modified_into_status(struct add_interactive_status *s)
+{
+	add_interactive_status_collect_changes_worktree(s);
+	add_interactive_status_collect_changes_index(s);
+}
+
+static void print_modified(void)
+{
+	int i;
+	struct add_interactive_status s;
+	const char *modified_fmt = _("%12s %12s %s");
+	const char *header_color = add_interactive_get_color(ADD_INTERACTIVE_HEADER);
+	unsigned char sha1[20];
+
+	if (read_cache() < 0)
+		return;
+
+	s.current_mode = COLLECTION_MODE_NONE;
+	s.reference = !get_sha1("HEAD", sha1) ? "HEAD": EMPTY_TREE_SHA1_HEX;
+	s.file_count = 0;
+	s.files = NULL;
+	list_modified_into_status(&s);
+
+	printf(ADD_INTERACTIVE_HEADER_INDENT);
+	color_fprintf(stdout, header_color, modified_fmt, _("staged"),
+			_("unstaged"), _("path"));
+	printf("\n");
+
+	for (i = 0; i < s.file_count; i++) {
+		struct add_interactive_file_status f = s.files[i];
+		char selection = f.selected ? '*' : ' ';
+
+		char worktree_changes[50];
+		char index_changes[50];
+
+		if (f.lines_added_worktree != 0 || f.lines_deleted_worktree != 0)
+			snprintf(worktree_changes, 50, "+%d/-%d", f.lines_added_worktree,
+					f.lines_deleted_worktree);
+		else
+			snprintf(worktree_changes, 50, "%s", _("nothing"));
+
+		if (f.lines_added_index != 0 || f.lines_deleted_index != 0)
+			snprintf(index_changes, 50, "+%d/-%d", f.lines_added_index,
+					f.lines_deleted_index);
+		else
+			snprintf(index_changes, 50, "%s", _("unchanged"));
+
+		printf("%c%2d: ", selection, i + 1);
+		printf(modified_fmt, index_changes, worktree_changes, f.path);
+		printf("\n");
+	}
+}
+
+static void status_cmd(void)
+{
+	print_modified();
+}
+
+static const char add_interactive_helper_usage[] =
+"git add-interactive--helper <command>";
+
+int cmd_add_interactive__helper(int argc, const char **argv, const char *prefix)
+{
+	int i, found_opt = 0;
+
+	git_config(git_add_interactive_config, NULL);
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (!strcmp(arg, "--status")) {
+			status_cmd();
+			found_opt = 1;
+		}
+	}
+
+	if (!found_opt)
+		usage(add_interactive_helper_usage);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 8ff44f0..796971e 100644
--- a/git.c
+++ b/git.c
@@ -391,6 +391,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "add-interactive--helper", cmd_add_interactive__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
-- 
2.7.4 (Apple Git-66)

