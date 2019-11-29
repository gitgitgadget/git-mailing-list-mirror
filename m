Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1EBC432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA6521771
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg0rJryA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfK2VLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:11:55 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34476 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfK2VLz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:11:55 -0500
Received: by mail-wr1-f46.google.com with SMTP id t2so36656744wrr.1
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X131tDd4rJf08E/nb2McAvkR5IeeSoPCHzIQjA2NF24=;
        b=hg0rJryAG3tOLwdc/T+Yw6v4pe47igboZ/7s6EPl1rMvlmWp6IXaHxfiHYykp4OSB1
         zVinW24Wof3Y8sXd1Q5wFtUh9YDh4D6v8uHNB4/Hqzt6vrFdUaOGzoVeMZjdq5fv2vmb
         4Q6ZQNkuwXlxx3qlbWljk4kS8rVr1M9VhlxMsf0bG2cgYg/ee0RnVXlXO+QyG5lM2nDp
         49+hGe3ZYff1W1nmmk03VcVYTTyvQAKMop2iKOGAsH4cPfbraSXZ7WNbcBWtfJLG6u0m
         9a6kzlPrTH9SPULDT5QTuxDF6eVfyt4jEAehCYZb+2VBYXbuBHt7hgFxOzu1+YnbwMcK
         EP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X131tDd4rJf08E/nb2McAvkR5IeeSoPCHzIQjA2NF24=;
        b=iMWpM5xUcr7BzblxfbTTH/M30Sng/gHlDKFeRIb9qUmgt6Cux/pm2DAz+qduMunBXh
         MYq09OgtbuWL0M8OzB+qJkrhlpXjonrm8bM4HI2yyPiRIBWiNSu7zV6f88HSQFgihHSk
         w7zXejabx57F/ah0s2AEdFwsrM6oIMDAkwVeEhIAgZlSifJ2qCzCIOG2kB2vvapmnVL0
         TLMA9z4ZEfiWqDsjdAoPMrJ+c0woAW8JRKNCOComcJ/jDdFMZT2hWM1bBaftTWpl1Bsj
         iGD7HITYKiIX6jefXN1GacDWWNOMN5mjk+mwA8sdHAqOFc/K4IUMMv1k7w3ksQzOt1L5
         5Z4A==
X-Gm-Message-State: APjAAAUReamyBft7Vb0V1cg2E2/Jeb8OewN179KTrfu4ESHGtfLKadyC
        nZ/6ge1rX1Y08VL480BzNJk0uQ2F
X-Google-Smtp-Source: APXvYqy4L/jLeID7T+MiEkTYdpMs2VzGDAW9umgM5e5YZAfFYmsNMXmbra2gmsqfU2ZbRgfhfJy09w==
X-Received: by 2002:adf:ec48:: with SMTP id w8mr8914248wrn.19.1575061912535;
        Fri, 29 Nov 2019 13:11:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm1215463wrt.26.2019.11.29.13.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 13:11:52 -0800 (PST)
Message-Id: <fab098d86eb47d8ef108e62080db87c1381b2e56.1575061909.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Nov 2019 21:11:42 +0000
Subject: [PATCH v2 2/9] built-in add -i: allow filtering the modified files
 list
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

In the `update` command of `git add -i`, we are primarily interested in the
list of modified files that have worktree (i.e. unstaged) changes.

At the same time, we need to determine _also_ the staged changes, to be
able to produce the full added/deleted information.

The Perl script version of `git add -i` has a parameter of the
`list_modified()` function for that matter. In C, we can be a lot more
precise, using an `enum`.

The C implementation of the filter also has an easier time to avoid
unnecessary work, simply by using an adaptive order of the `diff-index`
and `diff-files` phases, and then skipping files in the second phase
when they have not been seen in the first phase.

Seeing as we change the meaning of the `phase` field, we rename it to
`mode` to reflect that the order depends on the exact invocation of the
`git add -i` command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index de2fccb0ef..c62d63e35b 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -344,10 +344,11 @@ static int pathname_entry_cmp(const void *unused_cmp_data,
 }
 
 struct collection_status {
-	enum { FROM_WORKTREE = 0, FROM_INDEX = 1 } phase;
+	enum { FROM_WORKTREE = 0, FROM_INDEX = 1 } mode;
 
 	const char *reference;
 
+	unsigned skip_unseen:1;
 	struct string_list *files;
 	struct hashmap file_map;
 };
@@ -375,6 +376,9 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 		entry = hashmap_get_entry_from_hash(&s->file_map, hash, name,
 						    struct pathname_entry, ent);
 		if (!entry) {
+			if (s->skip_unseen)
+				continue;
+
 			add_file_item(s->files, name);
 
 			entry = xcalloc(sizeof(*entry), 1);
@@ -385,7 +389,7 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 		}
 
 		file_item = entry->item;
-		adddel = s->phase == FROM_INDEX ?
+		adddel = s->mode == FROM_INDEX ?
 			&file_item->index : &file_item->worktree;
 		adddel->seen = 1;
 		adddel->add = stat.files[i]->added;
@@ -396,13 +400,22 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 	free_diffstat_info(&stat);
 }
 
-static int get_modified_files(struct repository *r, struct string_list *files,
+enum modified_files_filter {
+	NO_FILTER = 0,
+	WORKTREE_ONLY = 1,
+	INDEX_ONLY = 2,
+};
+
+static int get_modified_files(struct repository *r,
+			      enum modified_files_filter filter,
+			      struct string_list *files,
 			      const struct pathspec *ps)
 {
 	struct object_id head_oid;
 	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 					     &head_oid, NULL);
-	struct collection_status s = { FROM_WORKTREE };
+	struct collection_status s = { 0 };
+	int i;
 
 	if (discard_index(r->index) < 0 ||
 	    repo_read_index_preload(r, ps, 0) < 0)
@@ -412,10 +425,16 @@ static int get_modified_files(struct repository *r, struct string_list *files,
 	s.files = files;
 	hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
 
-	for (s.phase = FROM_WORKTREE; s.phase <= FROM_INDEX; s.phase++) {
+	for (i = 0; i < 2; i++) {
 		struct rev_info rev;
 		struct setup_revision_opt opt = { 0 };
 
+		if (filter == INDEX_ONLY)
+			s.mode = (i == 0) ? FROM_INDEX : FROM_WORKTREE;
+		else
+			s.mode = (i == 0) ? FROM_WORKTREE : FROM_INDEX;
+		s.skip_unseen = filter && i;
+
 		opt.def = is_initial ?
 			empty_tree_oid_hex() : oid_to_hex(&head_oid);
 
@@ -429,7 +448,7 @@ static int get_modified_files(struct repository *r, struct string_list *files,
 		if (ps)
 			copy_pathspec(&rev.prune_data, ps);
 
-		if (s.phase == FROM_INDEX)
+		if (s.mode == FROM_INDEX)
 			run_diff_index(&rev, 1);
 		else {
 			rev.diffopt.flags.ignore_dirty_submodules = 1;
@@ -502,7 +521,7 @@ static void print_file_item(int i, struct string_list_item *item,
 static int run_status(struct add_i_state *s, const struct pathspec *ps,
 		      struct string_list *files, struct list_options *opts)
 {
-	if (get_modified_files(s->r, files, ps) < 0)
+	if (get_modified_files(s->r, NO_FILTER, files, ps) < 0)
 		return -1;
 
 	list(s, files, opts);
-- 
gitgitgadget

