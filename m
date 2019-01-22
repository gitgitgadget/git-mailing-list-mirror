Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73591F453
	for <e@80x24.org>; Tue, 22 Jan 2019 23:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfAVXXT (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 18:23:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41466 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfAVXXT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 18:23:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so128205plm.8
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 15:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Arv647prEPMSd9EKm0rTDcqhDFA2SvSM7i2XQwxfdhg=;
        b=b2a3K6WOffM4SzxvmRQBdugZ6OukvsqyEXXWMeFqnG4rkZpgxX4ZYr8be6Qt7uInVo
         vmsVjkwYdXvyEotMH5kplBw00Wc3aihSIDpPFk8v2KzWYoaiLo6H+gJ8RoMYbf8vfk4I
         jUvcDP7uV0WTDtluKm3XD9sMuPFOI+FhqpgMdWlilfNhYXH1YzW3m9uxKxiYn33fWxbe
         wt+AZO0bfsOBfAvAJgbXXzdfsmMDOgycwlDoC7L/8DuM4efcbEUup6EfH5XREZ4qNnoX
         sAJiMaYWdRisRCs45/aAfox7NQfIvj5utBVeR30k6aRy0nCwao8i5+gsOwbvGJRsRoIs
         /YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Arv647prEPMSd9EKm0rTDcqhDFA2SvSM7i2XQwxfdhg=;
        b=eH639yfIuiGQqTDjiwhFcYJ8VG8/d/xNeDoYneuaULshTrpvpZee56CGiq7yrdsp+3
         wbiVmDYMVvC1YTLoR3gaGVziPQCpmL/wkQMcnnKl50tT7GXEMBkamhZu2DVwlFlbWJGX
         gDQgjTakeQKD1WgJRzM8rNNp0TPnonPi3FqqsKADQtFBsa82J0dVVU94u31YP9L2rFUB
         H41USY7UE8j56JTIv95ElBvfBjsE1fFxLwGSh8U97Wt0YLE7IL+mCI6E8l+QLF6euKrJ
         P3hh+q4KOUCziG5t5VdU0W+fw3TMqHc35v8f/7gV75xwTRYN0gpCnZ1dQe8+QRyw9mOn
         diMg==
X-Gm-Message-State: AJcUukdvI37slAqfUfi7R6FhiiMP4HhktmPvKcS6XGMoqVeIpKBdJKUP
        gYNnwPxy4+5VFHmEVL29we8/DC8J
X-Google-Smtp-Source: ALg8bN7tRJ+CpgFv/MrurrD+lFZD2IX+622bSfWxs5ePfYqxYGeJCZWu+VrVwwl4G6dllxM7Z+Rx2Q==
X-Received: by 2002:a17:902:b707:: with SMTP id d7mr34640268pls.29.1548199398252;
        Tue, 22 Jan 2019 15:23:18 -0800 (PST)
Received: from localhost.localdomain ([12.167.51.36])
        by smtp.gmail.com with ESMTPSA id 84sm23608057pfk.134.2019.01.22.15.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 15:23:17 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v6 1/3] ref-filter: add worktreepath atom
Date:   Tue, 22 Jan 2019 15:22:59 -0800
Message-Id: <20190122232301.95971-2-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190122232301.95971-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190122232301.95971-1-nbelakovski@gmail.com>
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Add an atom providing the path of the linked worktree where this ref is
checked out, if it is checked out in any linked worktrees, and empty
string otherwise.
---
 Documentation/git-for-each-ref.txt |  5 +++
 ref-filter.c                       | 74 ++++++++++++++++++++++++++++++++++++++
 t/t6302-for-each-ref-filter.sh     | 15 ++++++++
 3 files changed, 94 insertions(+)

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
index 422a9c9ae3..3c056cc148 100644
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
@@ -75,6 +77,22 @@ static struct expand_data {
 	struct object_info info;
 } oi, oi_deref;
 
+struct ref_to_worktree_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	struct worktree *wt; /* key is wt->head_ref */
+};
+
+static int ref_to_worktree_map_cmpfnc(const void *unused_lookupdata, const void *existing_hashmap_entry_to_test,
+				   const void *key, const void *keydata_aka_refname)
+{
+	const struct ref_to_worktree_entry *e = existing_hashmap_entry_to_test;
+	const struct ref_to_worktree_entry *k = key;
+	return strcmp(e->wt->head_ref, keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);
+}
+
+static struct hashmap ref_to_worktree_map;
+static struct worktree **worktrees = NULL;
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -438,6 +456,34 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
 	return 0;
 }
 
+static int worktree_atom_parser(const struct ref_format *format,
+				struct used_atom *atom,
+				const char *arg,
+				struct strbuf *unused_err)
+{
+	int i;
+
+	if (worktrees)
+		return 0;
+
+	worktrees = get_worktrees(0);
+
+	hashmap_init(&ref_to_worktree_map, ref_to_worktree_map_cmpfnc, NULL, 0);
+
+	for (i = 0; worktrees[i]; i++) {
+		if (worktrees[i]->head_ref) {
+			struct ref_to_worktree_entry *entry;
+			entry = xmalloc(sizeof(*entry));
+			entry->wt = worktrees[i];
+			hashmap_entry_init(entry, strhash(worktrees[i]->head_ref));
+
+			hashmap_add(&ref_to_worktree_map, entry);
+		}
+	}
+
+	return 0;
+}
+
 static struct {
 	const char *name;
 	info_source source;
@@ -480,6 +526,7 @@ static struct {
 	{ "flag", SOURCE_NONE },
 	{ "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
 	{ "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
+	{ "worktreepath", SOURCE_NONE, FIELD_STR, worktree_atom_parser },
 	{ "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
 	{ "end", SOURCE_NONE },
 	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
@@ -1525,6 +1572,21 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 	return 0;
 }
 
+static char *get_worktree_path(const struct used_atom *atom, const struct ref_array_item *ref)
+{
+	struct strbuf val = STRBUF_INIT;
+	struct hashmap_entry entry;
+	struct ref_to_worktree_entry *lookup_result;
+
+	hashmap_entry_init(&entry, strhash(ref->refname));
+	lookup_result = hashmap_get(&ref_to_worktree_map, &entry, ref->refname);
+
+	if (lookup_result)
+		strbuf_addstr(&val, lookup_result->wt->path);
+
+	return strbuf_detach(&val, NULL);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -1562,6 +1624,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 		if (starts_with(name, "refname"))
 			refname = get_refname(atom, ref);
+		else if (starts_with(name, "worktreepath")) {
+			if (ref->kind == FILTER_REFS_BRANCHES)
+				v->s = get_worktree_path(atom, ref);
+			else
+				v->s = xstrdup("");
+			continue;
+		}
 		else if (starts_with(name, "symref"))
 			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
@@ -2045,6 +2114,11 @@ void ref_array_clear(struct ref_array *array)
 		free_array_item(array->items[i]);
 	FREE_AND_NULL(array->items);
 	array->nr = array->alloc = 0;
+	if (worktrees) {
+		hashmap_free(&ref_to_worktree_map, 1);
+		free_worktrees(worktrees);
+		worktrees = NULL;
+	}
 }
 
 static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fc067ed672..87e0222ea1 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -441,4 +441,19 @@ test_expect_success '--merged is incompatible with --no-merged' '
 	test_must_fail git for-each-ref --merged HEAD --no-merged HEAD
 '
 
+test_expect_success '"add" a worktree' '
+	mkdir worktree_dir &&
+	git worktree add -b master_worktree worktree_dir master
+'
+
+test_expect_success 'validate worktree atom' '
+	cat >expect <<-EOF &&
+	master: $(pwd)
+	master_worktree: $(pwd)/worktree_dir
+	side: not checked out
+	EOF
+	git for-each-ref --format="%(refname:short): %(if)%(worktreepath)%(then)%(worktreepath)%(else)not checked out%(end)" refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.14.2

