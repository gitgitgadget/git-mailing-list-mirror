Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E471201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdEPEBE (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:01:04 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36748 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdEPEBC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:01:02 -0400
Received: by mail-qk0-f193.google.com with SMTP id y128so20715852qka.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 21:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XidoBioOqJ9RMkq8XBYzlt7Sla6DoiZ6nVRgzp40zFY=;
        b=fFnmAmJNJu+rCGJi9IEGWRwP5bhqHVlQIHt3Lsr2AoGvKsqpJpyxawyijvkNa7awms
         4FWie+wiqvyWIjUri8PyD9ije8to/sUX0/wpFR13kM/qDiDzPidYrxMK6MU3uHsBPCI2
         EOg+dBCbg9/sAM1wb1+0KaaqYDeb9L87rVog9HVNxiLKvfUQ1UEqapxE3KkEmKtJZlaY
         pREDAxTQxWOkNomQPGeOYrKbd5KAkp0Fu/v2MRlqv+7z1oh22j+fGnfmrVdrlfF3cL0B
         9ZaBIacvuYM4lx/+hmuUEHqOQulZPcKgLy88/kSQbTa6adx4DtUJFLdPsMY4vfNzHU2W
         kX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XidoBioOqJ9RMkq8XBYzlt7Sla6DoiZ6nVRgzp40zFY=;
        b=TeT0ZcHxQyudBt+j4WTIptKPRPeG++LY3OCMb6NUSkSxMGCaBTlUS+7aehlzEh9oBG
         jfSek8Paxq/oaquuqLPWJ37ie2VEmdyU/kbPd7Ij08yv/ASiWWY1IuWOj4mUeckHLxFu
         q3wP0iny6vubQhDm9DCGNQbBVXk2BFA8V7RRjnbiK6YT0fL/+xp5I4iuPPiwBVHGlZ3s
         OqFfaYhEIKy0F+6drlyJXjiHVZQ9EKgAtO7hAP5FHCa+NHSZSFl/7FkoN3mXC3VemsGB
         6P6UvlaGb5XazDzPnO+dZP2UapMsMZ8DSdqoUdlg5tOYJvdSZ0GybNiyLcTQi4AakTjt
         I65w==
X-Gm-Message-State: AODbwcD6dh4RSpfhTRwJ168OCRAe31ptUYdcH1f2L/lfH6aW61AH8qTf
        OlH5aHYpkASZRugLrbA=
X-Received: by 10.55.89.4 with SMTP id n4mr7767184qkb.194.1494907261126;
        Mon, 15 May 2017 21:01:01 -0700 (PDT)
Received: from localhost.localdomain ([189.62.40.36])
        by smtp.gmail.com with ESMTPSA id h14sm10068049qta.18.2017.05.15.21.00.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 21:00:59 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        jrnieder@gmail.com, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v2 3/4] add--helper: implement interactive status command
Date:   Tue, 16 May 2017 01:00:33 -0300
Message-Id: <1494907234-28903-4-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
References: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement add--interactive's status command in the add--helper builtin.
It prints a numstat comparing changed files between a) the worktree and
the index; b) the index and the HEAD.

To do so, we use run_diff_index() and run_diff_files() to get changed
files, use the diffstat API on them to get the numstat and use a
combination of a hashmap and qsort() to print the result in
O(n) + O(n lg n) complexity.

This is the first add--interactive command implemented in C of those
anticipated by 6cbc52d ("add--helper: create builtin helper for
interactive add", 2017-05-15).

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 builtin/add--helper.c | 279 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 279 insertions(+)

diff --git a/builtin/add--helper.c b/builtin/add--helper.c
index 6a97f0e..f6d35bf 100644
--- a/builtin/add--helper.c
+++ b/builtin/add--helper.c
@@ -1,6 +1,285 @@
 #include "builtin.h"
+#include "color.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "hashmap.h"
+#include "revision.h"
+
+#define HEADER_INDENT "      "
+
+enum collection_phase {
+	WORKTREE,
+	INDEX
+};
+
+struct file_stat {
+	struct hashmap_entry ent;
+	struct {
+		uintmax_t added, deleted;
+	} index, worktree;
+	char name[FLEX_ARRAY];
+};
+
+struct collection_status {
+	enum collection_phase phase;
+
+	const char *reference;
+	struct pathspec pathspec;
+
+	struct hashmap file_map;
+};
+
+static int use_color = -1;
+enum color_add_i {
+	COLOR_PROMPT,
+	COLOR_HEADER,
+	COLOR_HELP,
+	COLOR_ERROR
+};
+
+static char colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_BOLD_BLUE, /* Prompt */
+	GIT_COLOR_BOLD,      /* Header */
+	GIT_COLOR_BOLD_RED,  /* Help */
+	GIT_COLOR_BOLD_RED   /* Error */
+};
+
+static const char *get_color(enum color_add_i ix)
+{
+	if (want_color(use_color))
+		return colors[ix];
+	return "";
+}
+
+static int parse_color_slot(const char *slot)
+{
+	if (!strcasecmp(slot, "prompt"))
+		return COLOR_PROMPT;
+	if (!strcasecmp(slot, "header"))
+		return COLOR_HEADER;
+	if (!strcasecmp(slot, "help"))
+		return COLOR_HELP;
+	if (!strcasecmp(slot, "error"))
+		return COLOR_ERROR;
+
+	return -1;
+}
+
+static int add_i_config(const char *var,
+		const char *value, void *cbdata)
+{
+	const char *name;
+
+	if (!strcmp(var, "color.interactive")) {
+		use_color = git_config_colorbool(var, value);
+		return 0;
+	}
+
+	if (skip_prefix(var, "color.interactive", &name)) {
+		int slot = parse_color_slot(name);
+		if (slot < 0)
+			return 0;
+		if (!value)
+			return config_error_nonbool(var);
+		return color_parse(value, colors[slot]);
+	}
+
+	return git_default_config(var, value, cbdata);
+}
+
+static int hash_cmp(const void *entry, const void *entry_or_key,
+ 			      const void *keydata)
+{
+ 	const struct file_stat *e1 = entry, *e2 = entry_or_key;
+ 	const char *name = keydata ? keydata : e2->name;
+
+	return strcmp(e1->name, name);
+}
+
+static int alphabetical_cmp(const void *a, const void *b)
+{
+	struct file_stat *f1 = *((struct file_stat **)a);
+	struct file_stat *f2 = *((struct file_stat **)b);
+
+	return strcmp(f1->name, f2->name);
+}
+
+static void collect_changes_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
+{
+	struct collection_status *s = data;
+	struct diffstat_t stat = { 0 };
+	int i;
+
+	if (!q->nr)
+		return;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p;
+		p = q->queue[i];
+		diff_flush_stat(p, options, &stat);
+	}
+
+	for (i = 0; i < stat.nr; i++) {
+		struct file_stat *entry;
+		const char *name = stat.files[i]->name;
+		unsigned int hash = strhash(name);
+
+		entry = hashmap_get_from_hash(&s->file_map, hash, name);
+		if (!entry) {
+			FLEX_ALLOC_STR(entry, name, name);
+			hashmap_entry_init(entry, hash);
+			hashmap_add(&s->file_map, entry);
+		}
+
+		if (s->phase == WORKTREE) {
+			entry->worktree.added = stat.files[i]->added;
+			entry->worktree.deleted = stat.files[i]->deleted;
+		} else if (s->phase == INDEX) {
+			entry->index.added = stat.files[i]->added;
+			entry->index.deleted = stat.files[i]->deleted;
+		}
+	}
+}
+
+static void collect_changes_worktree(struct collection_status *s)
+{
+	struct rev_info rev;
+
+	s->phase = WORKTREE;
+
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, NULL);
+
+	rev.max_count = 0;
+
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = collect_changes_cb;
+	rev.diffopt.format_callback_data = s;
+
+	run_diff_files(&rev, 0);
+}
+
+static void collect_changes_index(struct collection_status *s)
+{
+	struct rev_info rev;
+	struct setup_revision_opt opt = { 0 };
+
+	s->phase = INDEX;
+
+	init_revisions(&rev, NULL);
+	opt.def = s->reference;
+	setup_revisions(0, NULL, &rev, &opt);
+
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = collect_changes_cb;
+	rev.diffopt.format_callback_data = s;
+
+	run_diff_index(&rev, 1);
+}
+
+static void list_modified_into_status(struct collection_status *s)
+{
+	collect_changes_worktree(s);
+	collect_changes_index(s);
+}
+
+static void print_modified(void)
+{
+	int i = 0;
+	struct collection_status s;
+	/* TRANSLATORS: you can adjust this to align "git add -i" status menu */
+	const char *modified_fmt = _("%12s %12s %s");
+	const char *header_color = get_color(COLOR_HEADER);
+	unsigned char sha1[20];
+
+	struct hashmap_iter iter;
+	struct file_stat **files;
+	struct file_stat *entry;
+
+	if (read_cache() < 0)
+		return;
+
+	s.reference = !get_sha1("HEAD", sha1) ? "HEAD": EMPTY_TREE_SHA1_HEX;
+	hashmap_init(&s.file_map, hash_cmp, 0);
+	list_modified_into_status(&s);
+
+	if (s.file_map.size < 1) {
+		printf("\n");
+		return;
+	}
+
+	printf(HEADER_INDENT);
+	color_fprintf(stdout, header_color, modified_fmt, _("staged"),
+			_("unstaged"), _("path"));
+	printf("\n");
+
+	hashmap_iter_init(&s.file_map, &iter);
+
+	files = xcalloc(s.file_map.size, sizeof(struct file_stat *));
+	while ((entry = hashmap_iter_next(&iter))) {
+		files[i++] = entry;
+	}
+	QSORT(files, s.file_map.size, alphabetical_cmp);
+
+	for (i = 0; i < s.file_map.size; i++) {
+		struct file_stat *f = files[i];
+
+		char worktree_changes[50];
+		char index_changes[50];
+
+		if (f->worktree.added || f->worktree.deleted)
+			snprintf(worktree_changes, 50, "+%ju/-%ju", f->worktree.added,
+					f->worktree.deleted);
+		else
+			snprintf(worktree_changes, 50, "%s", _("nothing"));
+
+		if (f->index.added || f->index.deleted)
+			snprintf(index_changes, 50, "+%ju/-%ju", f->index.added,
+					f->index.deleted);
+		else
+			snprintf(index_changes, 50, "%s", _("unchanged"));
+
+		printf(" %2d: ", i + 1);
+		printf(modified_fmt, index_changes, worktree_changes, f->name);
+		printf("\n");
+	}
+	printf("\n");
+
+	free(files);
+}
+
+static const char * const builtin_add_helper_usage[] = {
+	N_("git add-interactive--helper <command>"),
+	NULL
+};
+
+enum cmd_mode {
+	DEFAULT = 0,
+	STATUS
+};
 
 int cmd_add__helper(int argc, const char **argv, const char *prefix)
 {
+	enum cmd_mode mode = DEFAULT;
+
+	struct option options[] = {
+		OPT_CMDMODE(0, "status", &mode,
+			 N_("print status information with diffstat"), STATUS),
+		OPT_END()
+	};
+
+	git_config(add_i_config, NULL);
+	argc = parse_options(argc, argv, NULL, options,
+			     builtin_add_helper_usage,
+			     PARSE_OPT_KEEP_ARGV0);
+
+	if (mode == STATUS)
+		print_modified();
+	else
+		usage_with_options(builtin_add_helper_usage,
+				   options);
+
 	return 0;
 }
-- 
2.7.4 (Apple Git-66)

