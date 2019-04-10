Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B0E20248
	for <e@80x24.org>; Wed, 10 Apr 2019 17:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfDJRh4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 13:37:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34836 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbfDJRhz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 13:37:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id s39so2808972edb.2
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ie5qnom5tZ96WWYFZU5f21HqipoVHe7op3gtqxt/IVM=;
        b=hVr43GiZVwrvIQJBdknww/ThQbpvcqJuzv+6XTejtqCD4MgW+JtvqCeVY2UdKhYZU5
         e3bfArnlejQTAJDmN9w5oulEF6ZEpzkhMKMkBrz3z/bmr605QNIQu+WE4dj/g53539Vt
         0G0YAweIK44yhHsCz7yv3/tDzhqFCs7T3QLhUUXaO0fZSsXXkBfe83yqj9FAvEKluVMw
         2PvCt9Fubsy3z2cSnTMlDDgijQN1y7P92nn/tnTajWtvqyLvOFpExCNVXVp2f5O6Q5Zz
         y2krPfGEy9xrAE0IhbHrXUVtKGTLQ+GLZzqiapPPnpufxDh1+XcSv5IwjIjnYQbRE2X8
         mSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ie5qnom5tZ96WWYFZU5f21HqipoVHe7op3gtqxt/IVM=;
        b=PJUgjLMULrylpX2FvbIBhlKhi40EwKZyASU5BP4YANG6w8d76bSHUEimGZ4KvMHzxj
         wZNxKiL6I5MIQrpNcncx12SAj15gKA/PXacoPgpOf1N+/Hxy9YAHHR37tR3Z2F//geAZ
         nG2lwlE1295aGtKVYFe/+SIr+82e8Q7g2+p6/2CQbZw1I19LNoTLIiU4f9+AcaTnFTDz
         Zjf21JakJl20u19ZR6tw8EMR3r3+SrnJbvEbHZC7fM/w4l7JedogCM1RLVrzCXIQbDZz
         EZAXfOAQiKONl1lo/iF+iFKE9E2yEl5cE8/fSJZ0fAUg4sBNEeDkrkbj/NK+dc1ng2VR
         yC3w==
X-Gm-Message-State: APjAAAVLnIx/oSNH9GfMd4yLvajeOUHFktJ0dAdwWPYauyDYb2K3nkN6
        QPCi53eYiuXFMX5sU9E8Qhe1yBl6
X-Google-Smtp-Source: APXvYqwCF9sHu/ZgfqnvEw2+vJK4g/lxV1evE3QSXcsIgD+C+hZzii4P3GHFmi4o4EjcQG01KebqpA==
X-Received: by 2002:a17:906:5014:: with SMTP id s20mr23993949ejj.174.1554917872971;
        Wed, 10 Apr 2019 10:37:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5sm4192908ejv.83.2019.04.10.10.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:37:52 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:37:52 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 17:37:40 GMT
Message-Id: <be9ab904d111b27083e66d6dd696d4e0c5e479c3.1554917868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 03/11] built-in add -i: implement the `status` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

This implements the `status` command of `git add -i`. The data
structures introduced in this commit will be extended as needed later.

At this point, we re-implement only part of the `list_and_choose()`
function of the Perl script `git-add--interactive.perl` and call it
`list()`. It does not yet color anything, or do columns, or allow user
input.

Over the course of the next commits, we will introduce a
`list_and_choose()` function that uses `list()` to display the list of
options and let the user choose one or more of the displayed items. This
will be used to implement the main loop of the built-in `git add -i`, at
which point the new `status` command can actually be used.

Note that we pass the list of items as a `struct item **` as opposed to
a `struct item *`, to allow for the actual items to contain much more
information than merely the name.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 265 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 264 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 540bf185d8..f627a56eeb 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,13 +1,276 @@
 #include "cache.h"
 #include "add-interactive.h"
 #include "config.h"
+#include "diffcore.h"
+#include "revision.h"
+#include "refs.h"
 
 int add_i_config(const char *var, const char *value, void *cb)
 {
 	return git_default_config(var, value, cb);
 }
 
+struct item {
+	const char *name;
+};
+
+struct list_options {
+	const char *header;
+	void (*print_item)(int i, struct item *item, void *print_item_data);
+	void *print_item_data;
+};
+
+static void list(struct item **list, size_t nr, struct list_options *opts)
+{
+	int i;
+
+	if (!nr)
+		return;
+
+	if (opts->header)
+		printf("%s\n", opts->header);
+
+	for (i = 0; i < nr; i++) {
+		opts->print_item(i, list[i], opts->print_item_data);
+		putchar('\n');
+	}
+}
+
+struct adddel {
+	uintmax_t add, del;
+	unsigned seen:1, binary:1;
+};
+
+struct file_list {
+	struct file_item {
+		struct item item;
+		struct adddel index, worktree;
+	} **file;
+	size_t nr, alloc;
+};
+
+static void add_file_item(struct file_list *list, const char *name)
+{
+	struct file_item *item;
+
+	FLEXPTR_ALLOC_STR(item, item.name, name);
+
+	ALLOC_GROW(list->file, list->nr + 1, list->alloc);
+	list->file[list->nr++] = item;
+}
+
+static void reset_file_list(struct file_list *list)
+{
+	size_t i;
+
+	for (i = 0; i < list->nr; i++)
+		free(list->file[i]);
+	list->nr = 0;
+}
+
+static void release_file_list(struct file_list *list)
+{
+	reset_file_list(list);
+	FREE_AND_NULL(list->file);
+	list->alloc = 0;
+}
+
+static int file_item_cmp(const void *a, const void *b)
+{
+	const struct file_item * const *f1 = a;
+	const struct file_item * const *f2 = b;
+
+	return strcmp((*f1)->item.name, (*f2)->item.name);
+}
+
+struct pathname_entry {
+	struct hashmap_entry ent;
+	size_t index;
+	char pathname[FLEX_ARRAY];
+};
+
+static int pathname_entry_cmp(const void *unused_cmp_data,
+			      const void *entry, const void *entry_or_key,
+			      const void *pathname)
+{
+	const struct pathname_entry *e1 = entry, *e2 = entry_or_key;
+
+	return strcmp(e1->pathname,
+		      pathname ? (const char *)pathname : e2->pathname);
+}
+
+struct collection_status {
+	enum { FROM_WORKTREE = 0, FROM_INDEX = 1 } phase;
+
+	const char *reference;
+
+	struct file_list *list;
+	struct hashmap file_map;
+};
+
+static void collect_changes_cb(struct diff_queue_struct *q,
+			       struct diff_options *options,
+			       void *data)
+{
+	struct collection_status *s = data;
+	struct diffstat_t stat = { 0 };
+	int i;
+
+	if (!q->nr)
+		return;
+
+	compute_diffstat(options, &stat, q);
+
+	for (i = 0; i < stat.nr; i++) {
+		const char *name = stat.files[i]->name;
+		int hash = strhash(name);
+		struct pathname_entry *entry;
+		size_t file_index;
+		struct file_item *file;
+		struct adddel *adddel;
+
+		entry = hashmap_get_from_hash(&s->file_map, hash, name);
+		if (entry)
+			file_index = entry->index;
+		else {
+			FLEX_ALLOC_STR(entry, pathname, name);
+			hashmap_entry_init(entry, hash);
+			entry->index = file_index = s->list->nr;
+			hashmap_add(&s->file_map, entry);
+
+			add_file_item(s->list, name);
+		}
+		file = s->list->file[file_index];
+
+		adddel = s->phase == FROM_INDEX ? &file->index : &file->worktree;
+		adddel->seen = 1;
+		adddel->add = stat.files[i]->added;
+		adddel->del = stat.files[i]->deleted;
+		if (stat.files[i]->is_binary)
+			adddel->binary = 1;
+	}
+}
+
+static int get_modified_files(struct repository *r, struct file_list *list,
+			      const struct pathspec *ps)
+{
+	struct object_id head_oid;
+	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+					     &head_oid, NULL);
+	struct collection_status s = { FROM_WORKTREE };
+
+	if (repo_read_index_preload(r, ps, 0) < 0)
+		return error(_("could not read index"));
+
+	s.list = list;
+	hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
+
+	for (s.phase = FROM_WORKTREE; s.phase <= FROM_INDEX; s.phase++) {
+		struct rev_info rev;
+		struct setup_revision_opt opt = { 0 };
+
+		opt.def = is_initial ?
+			empty_tree_oid_hex() : oid_to_hex(&head_oid);
+
+		init_revisions(&rev, NULL);
+		setup_revisions(0, NULL, &rev, &opt);
+
+		rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+		rev.diffopt.format_callback = collect_changes_cb;
+		rev.diffopt.format_callback_data = &s;
+
+		if (ps)
+			copy_pathspec(&rev.prune_data, ps);
+
+		if (s.phase == FROM_INDEX)
+			run_diff_index(&rev, 1);
+		else {
+			rev.diffopt.flags.ignore_dirty_submodules = 1;
+			run_diff_files(&rev, 0);
+		}
+	}
+	hashmap_free(&s.file_map, 1);
+
+	/* While the diffs are ordered already, we ran *two* diffs... */
+	QSORT(list->file, list->nr, file_item_cmp);
+
+	return 0;
+}
+
+static void populate_wi_changes(struct strbuf *buf,
+				struct adddel *ad, const char *no_changes)
+{
+	if (ad->binary)
+		strbuf_addstr(buf, _("binary"));
+	else if (ad->seen)
+		strbuf_addf(buf, "+%"PRIuMAX"/-%"PRIuMAX,
+			    (uintmax_t)ad->add, (uintmax_t)ad->del);
+	else
+		strbuf_addstr(buf, no_changes);
+}
+
+struct print_file_item_data {
+	const char *modified_fmt;
+	struct strbuf buf, index, worktree;
+};
+
+static void print_file_item(int i, struct item *item,
+			    void *print_file_item_data)
+{
+	struct file_item *c = (struct file_item *)item;
+	struct print_file_item_data *d = print_file_item_data;
+
+	strbuf_reset(&d->index);
+	strbuf_reset(&d->worktree);
+	strbuf_reset(&d->buf);
+
+	populate_wi_changes(&d->worktree, &c->worktree, _("nothing"));
+	populate_wi_changes(&d->index, &c->index, _("unchanged"));
+	strbuf_addf(&d->buf, d->modified_fmt,
+		    d->index.buf, d->worktree.buf, item->name);
+
+	printf(" %2d: %s", i + 1, d->buf.buf);
+}
+
+static int run_status(struct repository *r, const struct pathspec *ps,
+		      struct file_list *files, struct list_options *opts)
+{
+	reset_file_list(files);
+
+	if (get_modified_files(r, files, ps) < 0)
+		return -1;
+
+	if (files->nr)
+		list((struct item **)files->file, files->nr, opts);
+	putchar('\n');
+
+	return 0;
+}
+
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
-	die(_("No commands are available in the built-in `git add -i` yet!"));
+	struct print_file_item_data print_file_item_data = {
+		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
+	};
+	struct list_options opts = {
+		NULL, print_file_item, &print_file_item_data
+	};
+	struct strbuf header = STRBUF_INIT;
+	struct file_list files = { NULL };
+	int res = 0;
+
+	strbuf_addstr(&header, "      ");
+	strbuf_addf(&header, print_file_item_data.modified_fmt,
+		    _("staged"), _("unstaged"), _("path"));
+	opts.header = header.buf;
+
+	res = run_status(r, ps, &files, &opts);
+
+	release_file_list(&files);
+	strbuf_release(&print_file_item_data.buf);
+	strbuf_release(&print_file_item_data.index);
+	strbuf_release(&print_file_item_data.worktree);
+	strbuf_release(&header);
+
+	return res;
 }
-- 
gitgitgadget

