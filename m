Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AD7C432C3
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB25221771
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXqMhmYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbfK2VMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:12:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55807 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfK2VMA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:12:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id a131so11089804wme.5
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8WO4jGWIUZxR0x+Y4exgnUcJFz8YcGg8pDldJ4Orx7o=;
        b=WXqMhmYEBJN7qN1jQwHO3VTESwWJ+NaNgPz/tLQehAYLYPkof5jl/hpjtbX/jCoBbf
         dwz+44axDjQjHCcUuFXD8rES0EEoDT+BZRsIb+kjxVU0ffHGkJjoCmsTMSWluxdNgpX8
         KOJgZydrwySCTfV8e5HOTM8NplMnRlwH1SY9ixhVcXduboO6hZ/ntvLpXuWWq+e67olV
         +J1biD5l1S7yfGBTtR+ampTZ5xNVIM62kBWStBVLO/YS6ltfxuHOm/ET3uqvWOV4Id9E
         +tgemT7fhWOqK4sIamQOC+LGGS98TezDxlyqR7zGVlbTS+wcHz5NcacJyMgRo4vXgG5Z
         r0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8WO4jGWIUZxR0x+Y4exgnUcJFz8YcGg8pDldJ4Orx7o=;
        b=hUdVfcYePlTxb/Mddmi97Y97T7QGhZVPp9+oSA1+tg9edmhb3GTTKuTpi2LfVGFQgd
         zHlH3ryncHb+Zb12Ir0xV3PxMbNynhbQ6zWXdDJ9ZjqEdaQZ03K1IEJuo5ICRW7LamnJ
         B284KmpT5W0HrTjroSS3BcOc9upqdD7CfRBcGv+lm9xuZP99uU00xuUrA4lRevbiUKie
         isCJeT0WuaTmFq2lvwTHEpNZrc3bgEyZ2oOmuYfhR/s8AnJckWySfhoRogKl2bG/T0uq
         p8dsesbGyyGHNbZu1FJHtx5JscwPJN+KUrP5rd6+Vh8h/FutJ5X0H/6Xgn1bICGR3nQP
         /v1A==
X-Gm-Message-State: APjAAAUN/6ZWjeSnitBUIt9lKVexE6o2+L0r77U0FIxwwDA31izjYfxn
        GfCG6TqAmUi1FmaSkcJ8/ubpooFR
X-Google-Smtp-Source: APXvYqybw3aPbxdLe0wVdTYnILB8dVuQM0ex9X8z3vGgFrpO6Ic78rLxcelifwRiUp30tq/rzYCKjQ==
X-Received: by 2002:a1c:3b82:: with SMTP id i124mr15615738wma.122.1575061916175;
        Fri, 29 Nov 2019 13:11:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm5777736wmf.29.2019.11.29.13.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 13:11:55 -0800 (PST)
Message-Id: <cbd10da523a0d1f17ad90628b3867fd498dd3675.1575061909.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Nov 2019 21:11:47 +0000
Subject: [PATCH v2 7/9] built-in add -i: implement the `patch` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Well, it is not a full implementation yet. In the interest of making
this easy to review (and easy to keep bugs out), we still hand off to
the Perl script to do the actual work.

The `patch` functionality actually makes up for more than half of the
1,800+ lines of `git-add--interactive.perl`. It will be ported from Perl
to C incrementally, later.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 91 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index a719d30b0b..cba9688bb5 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -8,6 +8,7 @@
 #include "string-list.h"
 #include "lockfile.h"
 #include "dir.h"
+#include "run-command.h"
 
 struct add_i_state {
 	struct repository *r;
@@ -375,7 +376,7 @@ static ssize_t list_and_choose(struct add_i_state *s,
 
 struct adddel {
 	uintmax_t add, del;
-	unsigned seen:1, binary:1;
+	unsigned seen:1, unmerged:1, binary:1;
 };
 
 struct file_item {
@@ -415,6 +416,7 @@ struct collection_status {
 	const char *reference;
 
 	unsigned skip_unseen:1;
+	size_t unmerged_count, binary_count;
 	struct string_list *files;
 	struct hashmap file_map;
 };
@@ -437,7 +439,7 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 		int hash = strhash(name);
 		struct pathname_entry *entry;
 		struct file_item *file_item;
-		struct adddel *adddel;
+		struct adddel *adddel, *other_adddel;
 
 		entry = hashmap_get_entry_from_hash(&s->file_map, hash, name,
 						    struct pathname_entry, ent);
@@ -457,11 +459,21 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 		file_item = entry->item;
 		adddel = s->mode == FROM_INDEX ?
 			&file_item->index : &file_item->worktree;
+		other_adddel = s->mode == FROM_INDEX ?
+			&file_item->worktree : &file_item->index;
 		adddel->seen = 1;
 		adddel->add = stat.files[i]->added;
 		adddel->del = stat.files[i]->deleted;
-		if (stat.files[i]->is_binary)
+		if (stat.files[i]->is_binary) {
+			if (!other_adddel->binary)
+				s->binary_count++;
 			adddel->binary = 1;
+		}
+		if (stat.files[i]->is_unmerged) {
+			if (!other_adddel->unmerged)
+				s->unmerged_count++;
+			adddel->unmerged = 1;
+		}
 	}
 	free_diffstat_info(&stat);
 }
@@ -475,7 +487,9 @@ enum modified_files_filter {
 static int get_modified_files(struct repository *r,
 			      enum modified_files_filter filter,
 			      struct prefix_item_list *files,
-			      const struct pathspec *ps)
+			      const struct pathspec *ps,
+			      size_t *unmerged_count,
+			      size_t *binary_count)
 {
 	struct object_id head_oid;
 	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
@@ -525,6 +539,10 @@ static int get_modified_files(struct repository *r,
 			clear_pathspec(&rev.prune_data);
 	}
 	hashmap_free_entries(&s.file_map, struct pathname_entry, ent);
+	if (unmerged_count)
+		*unmerged_count = s.unmerged_count;
+	if (binary_count)
+		*binary_count = s.binary_count;
 
 	/* While the diffs are ordered already, we ran *two* diffs... */
 	string_list_sort(&files->items);
@@ -607,7 +625,7 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 		      struct prefix_item_list *files,
 		      struct list_and_choose_options *opts)
 {
-	if (get_modified_files(s->r, NO_FILTER, files, ps) < 0)
+	if (get_modified_files(s->r, NO_FILTER, files, ps, NULL, NULL) < 0)
 		return -1;
 
 	list(s, &files->items, NULL, &opts->list_opts);
@@ -624,7 +642,7 @@ static int run_update(struct add_i_state *s, const struct pathspec *ps,
 	size_t count, i;
 	struct lock_file index_lock;
 
-	if (get_modified_files(s->r, WORKTREE_ONLY, files, ps) < 0)
+	if (get_modified_files(s->r, WORKTREE_ONLY, files, ps, NULL, NULL) < 0)
 		return -1;
 
 	if (!files->items.nr) {
@@ -703,7 +721,7 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 	struct tree *tree;
 	struct diff_options diffopt = { NULL };
 
-	if (get_modified_files(s->r, INDEX_ONLY, files, ps) < 0)
+	if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
 		return -1;
 
 	if (!files->items.nr) {
@@ -855,6 +873,64 @@ static int run_add_untracked(struct add_i_state *s, const struct pathspec *ps,
 	return res;
 }
 
+static int run_patch(struct add_i_state *s, const struct pathspec *ps,
+		     struct prefix_item_list *files,
+		     struct list_and_choose_options *opts)
+{
+	int res = 0;
+	ssize_t count, i, j;
+	size_t unmerged_count = 0, binary_count = 0;
+
+	if (get_modified_files(s->r, WORKTREE_ONLY, files, ps,
+			       &unmerged_count, &binary_count) < 0)
+		return -1;
+
+	if (unmerged_count || binary_count) {
+		for (i = j = 0; i < files->items.nr; i++) {
+			struct file_item *item = files->items.items[i].util;
+
+			if (item->index.binary || item->worktree.binary) {
+				free(item);
+				free(files->items.items[i].string);
+			} else if (item->index.unmerged ||
+				 item->worktree.unmerged) {
+				color_fprintf_ln(stderr, s->error_color,
+						 _("ignoring unmerged: %s"),
+						 files->items.items[i].string);
+				free(item);
+				free(files->items.items[i].string);
+			} else
+				files->items.items[j++] = files->items.items[i];
+		}
+		files->items.nr = j;
+	}
+
+	if (!files->items.nr) {
+		if (binary_count)
+			fprintf(stderr, _("Only binary files changed.\n"));
+		else
+			fprintf(stderr, _("No changes.\n"));
+		return 0;
+	}
+
+	opts->prompt = N_("Patch update");
+	count = list_and_choose(s, files, opts);
+	if (count >= 0) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&args, "git", "add--interactive", "--patch",
+				 "--", NULL);
+		for (i = 0; i < files->items.nr; i++)
+			if (files->selected[i])
+				argv_array_push(&args,
+						files->items.items[i].string);
+		res = run_command_v_opt(args.argv, 0);
+		argv_array_clear(&args);
+	}
+
+	return res;
+}
+
 static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
 		    struct prefix_item_list *unused_files,
 		    struct list_and_choose_options *unused_opts)
@@ -952,6 +1028,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		{ "update", run_update },
 		{ "revert", run_revert },
 		{ "add untracked", run_add_untracked },
+		{ "patch", run_patch },
 		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
-- 
gitgitgadget

