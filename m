Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0B71F453
	for <e@80x24.org>; Mon, 29 Apr 2019 05:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfD2FUE (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 01:20:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40039 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfD2FUE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 01:20:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so4505163plr.7
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 22:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FdtTotd+cb48MIpJeALP5C8oVi4HJcYY/WFsQ6W4/Ag=;
        b=LZKqXQoXvKhjoUeKrygaYUHY2oaiD9N4Qk/ZQbfibYF+N0GkPIGv8Hk21npikx8Q/l
         PhjRnAusZWNg4I5U1cLkuzBylKy28Ht4S8LTkTGFg1iMGWKnvLsQ6nMFO16WKdUQlccD
         GI39D+WfeYr4v30OkKdbXNQn1K5Xnb+W9pHEEsoITXROLiqLzA7Da9nXwCU0Cbm0JjZW
         ii8LhK3iVwjo1QJL1M2lwK/QQCvZALPDDNVkZ4wdHNXGIJsdmyFE0a626ZflDq4wmERq
         ab6LC0pD9EMu4gr5ljiOLu1jx4lfKsqbVhDbMR9p7sRCA8xfz9WDdtWUK+1Ge9f0TfDZ
         FCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FdtTotd+cb48MIpJeALP5C8oVi4HJcYY/WFsQ6W4/Ag=;
        b=fi2VFRO0LdMm3z3AnkiU1dChny8sugnumLTPuT62bXHNZ2JEDaj5TCLNJDi8hJ1ikK
         RWdjahvVPT/iwZ4B2tIiAgMbthDyikXEA9TpaKZOk8ZRi39/gFzkc+VSWVU7nIuy0Y0V
         GMKIiMQVbynTTPdqzMbk3dgh8IkXQ/S3R2Ys+ntrlPqMS6A97kYUg3sSmrNoBE+sUIPO
         kt4i+pUdcdY2TfSM8G439yysCT0Y4dgBaHGsIPwyi9mAVq1WQSid6ytrQrFbnwGBPdyH
         s+GcMS5KP9PfVOirl6WK4twgmLytmHsz0VBMHBoy2u2+3ETK72FfdNf3CZ1hVMsKIV6F
         h7dA==
X-Gm-Message-State: APjAAAWMUxv/Qmh2VguEV7w5bfikXhNieCNQnDYfWd+TRxKARcqxIwLV
        /eSoke5s3wIKsyOtM4twsYxbtz2vmZg=
X-Google-Smtp-Source: APXvYqwTyI0l143vPtEzbsXtIZmWWU8tTo+ndtDaPWoStk3kZ/Dg85/JIXCnnRyqathA52QZZ+dOLA==
X-Received: by 2002:a17:902:e48b:: with SMTP id cj11mr17171059plb.223.1556515202988;
        Sun, 28 Apr 2019 22:20:02 -0700 (PDT)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id r4sm45564843pgl.69.2019.04.28.22.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Apr 2019 22:20:02 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v10 1/3] ref-filter: add worktreepath atom
Date:   Sun, 28 Apr 2019 22:19:42 -0700
Message-Id: <20190429051944.77164-2-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190429051944.77164-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190429051944.77164-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Add an atom providing the path of the linked worktree where this ref is
checked out, if it is checked out in any linked worktrees, and empty
string otherwise.

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 +++
 ref-filter.c                       | 78 ++++++++++++++++++++++++++++++++++++++
 t/t6302-for-each-ref-filter.sh     | 13 +++++++
 3 files changed, 96 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 774cecc7ed..6dcd39f6f6 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -214,6 +214,11 @@ symref::
 	`:lstrip` and `:rstrip` options in the same way as `refname`
 	above.
 
+worktreepath::
+	The absolute path to the worktree in which the ref is checked
+	out, if it is checked out in any linked worktree. Empty string
+	otherwise.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 8d11a94cbd..13984fa8ca 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -20,6 +20,8 @@
 #include "commit-slab.h"
 #include "commit-graph.h"
 #include "commit-reach.h"
+#include "worktree.h"
+#include "hashmap.h"
 
 static struct ref_msg {
 	const char *gone;
@@ -75,6 +77,27 @@ static struct expand_data {
 	struct object_info info;
 } oi, oi_deref;
 
+struct ref_to_worktree_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	struct worktree *wt; /* key is wt->head_ref */
+};
+
+static int ref_to_worktree_map_cmpfnc(const void *unused_lookupdata,
+				      const void *existing_hashmap_entry_to_test,
+				      const void *key,
+				      const void *keydata_aka_refname)
+{
+	const struct ref_to_worktree_entry *e = existing_hashmap_entry_to_test;
+	const struct ref_to_worktree_entry *k = key;
+	return strcmp(e->wt->head_ref,
+		keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);
+}
+
+static struct ref_to_worktree_map {
+	struct hashmap map;
+	struct worktree **worktrees;
+} ref_to_worktree_map;
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -480,6 +503,7 @@ static struct {
 	{ "flag", SOURCE_NONE },
 	{ "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
 	{ "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
+	{ "worktreepath", SOURCE_NONE },
 	{ "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
 	{ "end", SOURCE_NONE },
 	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
@@ -1529,6 +1553,48 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 	return 0;
 }
 
+static void populate_worktree_map(struct hashmap *map, struct worktree **worktrees)
+{
+	int i;
+
+	for (i = 0; worktrees[i]; i++) {
+		if (worktrees[i]->head_ref) {
+			struct ref_to_worktree_entry *entry;
+			entry = xmalloc(sizeof(*entry));
+			entry->wt = worktrees[i];
+			hashmap_entry_init(entry, strhash(worktrees[i]->head_ref));
+
+			hashmap_add(map, entry);
+		}
+	}
+}
+
+static void lazy_init_worktree_map(void)
+{
+	if (ref_to_worktree_map.worktrees)
+		return;
+
+	ref_to_worktree_map.worktrees = get_worktrees(0);
+	hashmap_init(&(ref_to_worktree_map.map), ref_to_worktree_map_cmpfnc, NULL, 0);
+	populate_worktree_map(&(ref_to_worktree_map.map), ref_to_worktree_map.worktrees);
+}
+
+static char *get_worktree_path(const struct used_atom *atom, const struct ref_array_item *ref)
+{
+	struct hashmap_entry entry;
+	struct ref_to_worktree_entry *lookup_result;
+
+	lazy_init_worktree_map();
+
+	hashmap_entry_init(&entry, strhash(ref->refname));
+	lookup_result = hashmap_get(&(ref_to_worktree_map.map), &entry, ref->refname);
+
+	if (lookup_result)
+		return xstrdup(lookup_result->wt->path);
+	else
+		return xstrdup("");
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -1566,6 +1632,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 		if (starts_with(name, "refname"))
 			refname = get_refname(atom, ref);
+		else if (!strcmp(name, "worktreepath")) {
+			if (ref->kind == FILTER_REFS_BRANCHES)
+				v->s = get_worktree_path(atom, ref);
+			else
+				v->s = xstrdup("");
+			continue;
+		}
 		else if (starts_with(name, "symref"))
 			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
@@ -2049,6 +2122,11 @@ void ref_array_clear(struct ref_array *array)
 		free_array_item(array->items[i]);
 	FREE_AND_NULL(array->items);
 	array->nr = array->alloc = 0;
+	if (ref_to_worktree_map.worktrees) {
+		hashmap_free(&(ref_to_worktree_map.map), 1);
+		free_worktrees(ref_to_worktree_map.worktrees);
+		ref_to_worktree_map.worktrees = NULL;
+	}
 }
 
 static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fc067ed672..35408d53fd 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -441,4 +441,17 @@ test_expect_success '--merged is incompatible with --no-merged' '
 	test_must_fail git for-each-ref --merged HEAD --no-merged HEAD
 '
 
+test_expect_success 'validate worktree atom' '
+	cat >expect <<-EOF &&
+	master: $(pwd)
+	master_worktree: $(pwd)/worktree_dir
+	side: not checked out
+	EOF
+	git worktree add -b master_worktree worktree_dir master &&
+	git for-each-ref --format="%(refname:short): %(if)%(worktreepath)%(then)%(worktreepath)%(else)not checked out%(end)" refs/heads/ >actual &&
+	rm -r worktree_dir &&
+	git worktree prune &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.14.2

