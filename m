Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5C420A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 08:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeLXIsJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 03:48:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43685 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeLXIsI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 03:48:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so5558802pfk.10
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 00:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WwTD7BGFzoqOdBKlsUL3EGdIHTJsTF4mKcWcWx06BjQ=;
        b=bp2m3PsLAfczjo94Dt0sXZd+fFgDku7i5EWeWjgJbOB5TIvZIxCSn8XkkyUCY2GK/K
         WIsVOQCfr1g4aesPck0LGvVukO8+FDJDKgHyM21nau2Hxj1GiOD+H3UC4a6b10QfkBxC
         9QQWu+XO5il/9eqqzhBmqRyXBkvIDhCeRDDSqsj2WBELkhozKdDJSAYL+A6H/2Yyijyq
         ELdC/8KesenPy3NTruLv1FY4cT/lKML2pBPIZrTE9InLm7JGc7p/UP156zT77bexeudv
         GlTpZnH1NHeNMLsycllk7wk0BqOZwQtgzhz4LhLqOkmSup9XDypuwGMv1nR7YNnAcC4g
         mkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WwTD7BGFzoqOdBKlsUL3EGdIHTJsTF4mKcWcWx06BjQ=;
        b=S5cpl1MH3wSkqv4+w5AKkLt7ScqlaP86f+v0IPp2HyB+XVfTc6gHC9S+rM49kY0LQO
         PXuTISL2eCc6SBAGi1ckk7bzDjQ0MbmhmL0RzzBzfhVmIDpRL22f29cVKhX08UUCzRNM
         I6OIgBZJ3oiiWvBLIHREB7WWDxhk174Qo8WOZlYfTt7jNAOaSoOLTqL/ZSVzOIxyoiSg
         dQEQc0jk2hbQMyuw5x2W2sEwr7PVL+PKc9UfyurQ70O0S1jTio8Fp0cqfQ76hm616PD2
         JYnvxkxvzRnkhFYjl8d2pTkJH2kbR7HEXSgaoAZ0M495GmpjRciRbur2XoMNqxRUiWg1
         I68Q==
X-Gm-Message-State: AJcUukebzzkYdh/Na+t/7KIsb0YmSB2CFN0X3PDuhLXSGJTUvH7YEA3F
        hjkPbFEE2HY7UHO+979z1ehs9axj
X-Google-Smtp-Source: ALg8bN4JizuElPbpFsjxuccD3CfQ0W1lf+z0pwdqs9Epo/WX0bHrB5f3zdVDvH2t1gjgdFSKGG8hOQ==
X-Received: by 2002:a63:4246:: with SMTP id p67mr11549023pga.335.1545641287646;
        Mon, 24 Dec 2018 00:48:07 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id m67sm57292021pfb.25.2018.12.24.00.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 00:48:07 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v4 1/3] ref-filter: add worktreepath atom
Date:   Mon, 24 Dec 2018 00:47:54 -0800
Message-Id: <20181224084756.49952-2-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20181224084756.49952-1-nbelakovski@gmail.com>
References: <20181220145931.GB27361@sigill.intra.peff.net>
 <20181224084756.49952-1-nbelakovski@gmail.com>
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
 ref-filter.c                       | 72 +++++++++++++++++++++++++++++++++++++-
 t/t6302-for-each-ref-filter.sh     | 15 ++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 901faef1bf..caba1c23b8 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -209,6 +209,11 @@ symref::
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
index 5de616befe..240e7b80f8 100644
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
@@ -34,6 +36,8 @@ static struct ref_msg {
 	"ahead %d, behind %d"
 };
 
+static struct worktree **worktrees;
+
 void setup_ref_filter_porcelain_msg(void)
 {
 	msgs.gone = _("gone");
@@ -75,6 +79,11 @@ static struct expand_data {
 	struct object_info info;
 } oi, oi_deref;
 
+struct ref_to_worktree_entry {
+    struct hashmap_entry ent; /* must be the first member! */
+    struct worktree *wt; /* key is wt->head_ref */
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -116,7 +125,8 @@ static struct used_atom {
 		char *head;
 	} u;
 } *used_atom;
-static int used_atom_cnt, need_tagged, need_symref;
+static int used_atom_cnt, need_tagged, need_symref, has_worktree;
+static struct hashmap ref_to_worktree_map;
 
 /*
  * Expand string, append it to strbuf *sb, then return error code ret.
@@ -420,6 +430,42 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
 	return 0;
 }
 
+static int worktree_hashmap_cmpfnc(const void *unused_lookupdata, const void *existing_hashmap_entry_to_test,
+				   const void *unused_key, const void *keydata_aka_refname)
+{
+	const struct ref_to_worktree_entry *e = existing_hashmap_entry_to_test;
+	return strcmp(e->wt->head_ref, keydata_aka_refname);
+}
+
+static int worktree_atom_parser(const struct ref_format *format,
+				struct used_atom *atom,
+				const char *arg,
+				struct strbuf *unused_err)
+{
+	int i;
+	if (has_worktree)
+		return 0;
+
+	worktrees = get_worktrees(0);
+
+	hashmap_init(&ref_to_worktree_map, worktree_hashmap_cmpfnc, NULL, 0);
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
+	has_worktree = 1;
+
+	return 0;
+}
+
 static struct {
 	const char *name;
 	info_source source;
@@ -461,6 +507,7 @@ static struct {
 	{ "flag", SOURCE_NONE },
 	{ "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
 	{ "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
+	{ "worktreepath", SOURCE_NONE, FIELD_STR, worktree_atom_parser },
 	{ "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
 	{ "end", SOURCE_NONE },
 	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
@@ -1500,6 +1547,20 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 	return 0;
 }
 
+static const char *get_worktree_path(const struct used_atom *atom, const struct ref_array_item *ref)
+{
+	struct strbuf val = STRBUF_INIT;
+	struct hashmap_entry entry;
+	struct ref_to_worktree_entry *lookup_result;
+
+	hashmap_entry_init(&entry, strhash(ref->refname));
+	lookup_result = hashmap_get(&ref_to_worktree_map, &entry, ref->refname);
+
+	strbuf_addstr(&val, lookup_result ? lookup_result->wt->path : "");
+
+	return strbuf_detach(&val, NULL);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -1537,6 +1598,10 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 		if (starts_with(name, "refname"))
 			refname = get_refname(atom, ref);
+		else if (starts_with(name, "worktreepath")) {
+			v->s = get_worktree_path(atom, ref);
+			continue;
+		}
 		else if (starts_with(name, "symref"))
 			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
@@ -2020,6 +2085,11 @@ void ref_array_clear(struct ref_array *array)
 		free_array_item(array->items[i]);
 	FREE_AND_NULL(array->items);
 	array->nr = array->alloc = 0;
+	if (has_worktree)
+	{
+		hashmap_free(&ref_to_worktree_map, 1);
+		free_worktrees(worktrees);
+	}
 }
 
 static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fc067ed672..d70517a6ae 100755
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
+	{
+	echo master: $PWD &&
+	echo master_worktree: $PWD/worktree_dir &&
+	echo side: not checked out
+	} > expect &&
+	git for-each-ref --format="%(refname:short): %(if)%(worktreepath)%(then)%(worktreepath)%(else)not checked out%(end)" refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.14.2

