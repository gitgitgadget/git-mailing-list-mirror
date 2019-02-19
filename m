Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68981F453
	for <e@80x24.org>; Tue, 19 Feb 2019 08:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfBSIbz (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 03:31:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38824 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSIbz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 03:31:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so7522587pgl.5
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 00:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vxOct4GsP0BHQxLS+IUw97H+bkcRyDlG/nI7j1zTdUA=;
        b=PAe7khtFb1J4HHIWm513Yle5o2tJHCjjCYJyiR+OSlrsz/KmAxltxVN86lKkCN9dzM
         ZfXfAdW9zT87S9RzYXP2m0KznMuOYxuWfOAiGxe22Zd7Q0NRrupr72x75dL++skr9eI9
         euvtSOTZLD0ExT24D7LZctIrr4KDUu+mwQh4zYAEdSGE8NUe9C2gCeBaXLkxu2v3KTqO
         8iJhmz9um7ummX1X4wAKpFwj7peVuZbqUXw4Y/64jluOMe9Sn2Dia6mQCjetzTCw3Kzc
         ofaSV/M1ncz/JLpn2q8wZInN/vkFiJcvCcuw4cryH1NB2G9xDbRUM+PMOo/oeAHR9ICh
         Zpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vxOct4GsP0BHQxLS+IUw97H+bkcRyDlG/nI7j1zTdUA=;
        b=sTiSus7TjSCgb0P9f84D7ubTo8mbeHAR69wshmnR73rKR1SHztfCO0qaWarxce+fc4
         GYDvRPJKTK0F6s94ZkY2dE1GyMUgtUQdSxG38ThCR7q9+/J3ndPZ5PVHi5VbisE1JVnA
         vPkJEwHEZQmiUkWBmMpXabY0ySfhOYkHmnGJIJL+FVaTCkvh4HjrZS3iuDuqTVLWC1Rv
         LOodhjAJmfNRitWPL1tAsvoYgNPJMTR32m4OvJlCFreoNVI2o+dweZXwVkaoH5Y+YwlF
         ZTABEDNWpw1knRkpURqAMPIuhzANSZGxrPuJco+8lt1XLbdCPFH/n6gZd52FyiXXvhIg
         mjag==
X-Gm-Message-State: AHQUAuageSn7KCe8GHnkcZE7A851G1E/vkixQ1Afe7CQWkAR5tuLoadB
        XUyxbM8vlU8Fu8jgo/RHlz0cUm0t
X-Google-Smtp-Source: AHgI3Ib61hCrk/qNWSMSjy5GNjtN6R7hwH0mH1wof79kLgF1ejgIXz+HhaILI+fdMBxcvgwJ9ek28w==
X-Received: by 2002:a65:6497:: with SMTP id e23mr22610210pgv.89.1550565114019;
        Tue, 19 Feb 2019 00:31:54 -0800 (PST)
Received: from localhost.localdomain (pdadde822.hkidnt01.ap.so-net.ne.jp. [218.221.232.34])
        by smtp.gmail.com with ESMTPSA id f62sm25190120pgc.67.2019.02.19.00.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Feb 2019 00:31:53 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v8 1/3] ref-filter: add worktreepath atom
Date:   Tue, 19 Feb 2019 17:31:21 +0900
Message-Id: <20190219083123.27686-2-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190219083123.27686-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190219083123.27686-1-nbelakovski@gmail.com>
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

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 +++
 ref-filter.c                       | 78 ++++++++++++++++++++++++++++++++++++++
 t/t6302-for-each-ref-filter.sh     | 11 ++++++
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
index 422a9c9ae3..05531b7534 100644
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
@@ -1525,6 +1549,48 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
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
@@ -1562,6 +1628,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
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
@@ -2045,6 +2118,11 @@ void ref_array_clear(struct ref_array *array)
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
index fc067ed672..4ad20615d5 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -441,4 +441,15 @@ test_expect_success '--merged is incompatible with --no-merged' '
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
+	test_cmp expect actual
+'
+
 test_done
-- 
2.14.2

