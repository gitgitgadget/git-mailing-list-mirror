Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D46E1F405
	for <e@80x24.org>; Sun, 16 Dec 2018 21:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbeLPV6M (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 16:58:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33395 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730853AbeLPV6M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 16:58:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so5362312pfb.0
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 13:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ye0Cw6c8HkunQ928wrNVVJ41+b0yHraXF4fYUfXvPyE=;
        b=NbyIjEFc+aDu98Qke6vK7ypMiuRK1Alg46Pvkt8tHbfS1EeD3DeRGHkizZBqdn5Uvo
         /n5SbqSEspmwmvWLx1likvr16nHAc/h43Dr2LKGoBYaoY/Liba4+WLWJyHyHSYymzS5W
         X5LFGbF8nrkuvt9vdD+Zb+U46EdGAO5tmpfXMlrhS5L/fWX/+WR4fSvzlkDQpB+QGZ7K
         lTY7ahTEE6YrLQZbsceQBGUxSD7cHPClGppsTPQd+3+T7A/sZK+ds1plAWQoeVVLZ8e9
         wETxrnVIW0XxdZqcAqcmQxfGp67XeJ0zNAXfOlmZJDZC3vV5VDV9VXjcJtEAUpll+P6c
         XNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ye0Cw6c8HkunQ928wrNVVJ41+b0yHraXF4fYUfXvPyE=;
        b=XbHgBM58c5oan4Q291QM1QqI9gYb+0K9yb8KOEB/W3GfizTm7r+osyLrwjlc0RFrER
         5blN5Kr9LZn9wGar+lu6ps7TuRAuHtEL1Rt+nHbTRuEzZ2BTwjN4Sd/V2Lv1tv3rF6sR
         Rplh452eND7cRjFIkE6zhB7qXet4G6hC3heOE6JPxx13jdAg/dR79MVAG30UJeDY2qsA
         gFdHr7bnbjGxifnrYIPu72YjvFesPvxcXgT34PozPb3E7Egkz/GiHHhe16VU4Qa+Ez1i
         OQcMFoSTZ3rAutysUsBErIOIR6A5lg+UoQs7zqQY0oAuHQWvrwI5t/uZtr8tVIRp82fn
         eExg==
X-Gm-Message-State: AA+aEWaD7YaiCIWjbOP4sv/RVQBOIkyggOiMCYlxnGpqHlc1V1ICnIAG
        kymZ1I6YsRyQvaX7B80xMXq4MC45
X-Google-Smtp-Source: AFSGD/WwTnU7CJ4l2jmjxGp0EtzRsiZq+1VZUh5heC54H8oTKhckq3tzdsvvEXgbdMVKSEmctfsAxQ==
X-Received: by 2002:a63:2c82:: with SMTP id s124mr9839325pgs.73.1544997490766;
        Sun, 16 Dec 2018 13:58:10 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id k191sm12736056pgd.9.2018.12.16.13.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 13:58:10 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v3 1/3] ref-filter: add worktreepath atom
Date:   Sun, 16 Dec 2018 13:57:57 -0800
Message-Id: <20181216215759.24011-2-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20181216215759.24011-1-nbelakovski@gmail.com>
References: <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181216215759.24011-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Add an atom proving the path of the linked worktree where this ref is
checked out, if it is checked out in any linked worktrees, and empty
string otherwise.
---
 Documentation/git-for-each-ref.txt |  4 +++
 ref-filter.c                       | 70 ++++++++++++++++++++++++++++++++++++++
 t/t6302-for-each-ref-filter.sh     | 15 ++++++++
 3 files changed, 89 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 901faef1bf..9590f7beab 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -209,6 +209,10 @@ symref::
 	`:lstrip` and `:rstrip` options in the same way as `refname`
 	above.
 
+worktreepath::
+	The absolute path to the worktree in which the ref is checked
+	out, if it is checked out in any linked worktree. ' ' otherwise.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 5de616befe..e8713484a1 100644
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
 
+static struct worktree ** worktrees;
+
 void setup_ref_filter_porcelain_msg(void)
 {
 	msgs.gone = _("gone");
@@ -75,6 +79,12 @@ static struct expand_data {
 	struct object_info info;
 } oi, oi_deref;
 
+struct reftoworktreeinfo_entry {
+    struct hashmap_entry ent; // must be the first member!
+    char * ref; // key into map
+    struct worktree * wt;
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -114,6 +124,7 @@ static struct used_atom {
 		} objectname;
 		struct refname_atom refname;
 		char *head;
+		struct hashmap reftoworktreeinfo_map;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -420,6 +431,31 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
 	return 0;
 }
 
+static int worktree_atom_parser(const struct ref_format *format,
+				struct used_atom *atom,
+				const char *arg,
+				struct strbuf *unused_err)
+{
+	int i;
+	worktrees = get_worktrees(0);
+
+	hashmap_init(&(atom->u.reftoworktreeinfo_map), NULL, NULL, 0);
+
+	for (i = 0; worktrees[i]; i++) {
+		if (worktrees[i]->head_ref) {
+			struct reftoworktreeinfo_entry *entry;
+			FLEXPTR_ALLOC_STR(entry, ref, worktrees[i]->head_ref);
+			hashmap_entry_init(entry, strhash(entry->ref));
+
+			entry->wt = worktrees[i];
+
+			hashmap_add(&(atom->u.reftoworktreeinfo_map), entry);
+		}
+	}
+
+	return 0;
+}
+
 static struct {
 	const char *name;
 	info_source source;
@@ -461,6 +497,7 @@ static struct {
 	{ "flag", SOURCE_NONE },
 	{ "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
 	{ "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
+	{ "worktreepath", SOURCE_NONE, FIELD_STR, worktree_atom_parser },
 	{ "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
 	{ "end", SOURCE_NONE },
 	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
@@ -1500,6 +1537,28 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 	return 0;
 }
 
+static const char * get_worktree_info(const struct used_atom *atom, const struct ref_array_item *ref)
+{
+	struct strbuf val = STRBUF_INIT;
+	struct reftoworktreeinfo_entry * entry;
+	struct reftoworktreeinfo_entry * lookup_result;
+
+	FLEXPTR_ALLOC_STR(entry, ref, ref->refname);
+	hashmap_entry_init(entry, strhash(entry->ref));
+	lookup_result = hashmap_get(&(atom->u.reftoworktreeinfo_map), entry, NULL);
+	free(entry);
+
+	if (lookup_result)
+	{
+		if (!strncmp(atom->name, "worktreepath", strlen(atom->name)))
+			strbuf_addstr(&val, lookup_result->wt->path);
+	}
+	else
+		strbuf_addstr(&val, " ");
+
+	return strbuf_detach(&val, NULL);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -1537,6 +1596,10 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 		if (starts_with(name, "refname"))
 			refname = get_refname(atom, ref);
+		else if (starts_with(name, "worktreepath")) {
+			v->s = get_worktree_info(atom, ref);
+			continue;
+		}
 		else if (starts_with(name, "symref"))
 			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
@@ -2013,7 +2076,14 @@ void ref_array_clear(struct ref_array *array)
 	int i;
 
 	for (i = 0; i < used_atom_cnt; i++)
+	{
+		if (!strncmp(used_atom[i].name, "worktreepath", strlen("worktreepath")))
+		{
+			hashmap_free(&(used_atom[i].u.reftoworktreeinfo_map), 1);
+			free_worktrees(worktrees);
+		}
 		free((char *)used_atom[i].name);
+	}
 	FREE_AND_NULL(used_atom);
 	used_atom_cnt = 0;
 	for (i = 0; i < array->nr; i++)
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fc067ed672..add70a4c3e 100755
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
+	cat >expect <<-\EOF &&
+	master: checked out in a worktree
+	master_worktree: checked out in a worktree
+	side: not checked out in a worktree
+	EOF
+	git for-each-ref --format="%(refname:short): %(if)%(worktreepath)%(then)checked out in a worktree%(else)not checked out in a worktree%(end)" refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.14.2

