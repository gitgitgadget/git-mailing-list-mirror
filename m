Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3D0420248
	for <e@80x24.org>; Sat, 16 Mar 2019 01:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCPBi0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 21:38:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44001 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfCPBiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 21:38:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id l11so7589236pgq.10
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 18:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+XtTxtpx239s3GzcMWaH2iyT0LVbC9sqeYeDC4xRWY=;
        b=oxSOJ/v1NQN5Am+MBU1e0v0+PQ3mFdHU47NuY2urxfADcksKvON0cWEtzxsQkcTneA
         uiReFwD+OSv6YBx6fkBiq8KzH+DG/jo6vPbGIIxr2xhBnNAdB148ZTZmhnoHDBMVNyOr
         28FoN3XmshG/nRBLdrjFO2JUIitvsrz2BWOSBWAvgsp3KxeJgNXFjX4W/rzHE7hSo4Em
         pOfQufqdtfOBDzwDX5DFI4CiQGL1T+rXJU+TXfrl59MMTPIhHb9DfgSKtJBhqKIVdUMs
         JoJLDwIlES2MYc9jFogA06r84j73kKVHX2iMllO4tX58aoLLQZ9Jpyt6Ony78vuAc3K3
         KAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+XtTxtpx239s3GzcMWaH2iyT0LVbC9sqeYeDC4xRWY=;
        b=bqk0kEIkPtzq3Z9Xt+dwT9fla+xEEISgIurPrTa8r9W82+P/JcmcCqUiYAhPC8jvOK
         GX/wKBsCGxqOKa0qa56YVAKtGbjkXDtnOlaaYUAHtbR86bGvVRxqjAfjTbag61sIXn9a
         frwKGBU9zEtUTStHJC3zng1e8IGQyrShDjPYtkskVdEaSwhS9Cysw/Z2+XiEoJ1FYV/N
         iHLshDWXPnQTMX9XnKak7LETPvUNP4GQw44mMB9aLy8uDdwPugUXbegTQi4hdZUmPS+7
         FD03QHRKv7eF5iuNw0mqehpHuWwGqA5s8i5tFs9e6Zx9kwGc8NN4nmtX0Ar+3ckJChPn
         ysfA==
X-Gm-Message-State: APjAAAXoBcty7TWpxgCaULjxBjLNmwrEdbYNo5hIv9Nq+Iyd0EntcEni
        zBONAyuznRoM/EjfQuVb6dIBG+kU
X-Google-Smtp-Source: APXvYqyu8cWzZ4AjrQmWuyvrlTZ9O0pseV1G4PP1843BXc5isTBVMQQZAxn6nTT6Gh1ZjbC7vuIcxg==
X-Received: by 2002:a17:902:9683:: with SMTP id n3mr7462637plp.333.1552700304389;
        Fri, 15 Mar 2019 18:38:24 -0700 (PDT)
Received: from localhost.localdomain (173-8-128-22-SFBA.hfc.comcastbusiness.net. [173.8.128.22])
        by smtp.gmail.com with ESMTPSA id b138sm5817623pfb.48.2019.03.15.18.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 18:38:23 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, rafa.almas@gmail.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v9 1/3] ref-filter: add worktreepath atom
Date:   Fri, 15 Mar 2019 18:38:05 -0700
Message-Id: <20190316013807.38756-2-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190316013807.38756-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190316013807.38756-1-nbelakovski@gmail.com>
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
index 3aca105307..79cfec914a 100644
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

