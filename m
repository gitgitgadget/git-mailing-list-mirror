Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78742211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 00:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfAFA0c (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 19:26:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36247 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfAFA0c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 19:26:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so20049104pfc.3
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 16:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ypauC4IUvMMcSuUYDROiCLMx5UzRvg2xWq3xwwBdJ94=;
        b=UT1xnR4F2nLzzv/zfJUwSDuerrYTHSS4N6H9YGNT2Mog6WqiMyGETAdjNFhXPv+Iap
         93pd3No0Zp5fz1DWaH7Ef+iSFD1VgJE+Cmv7h71y1pxWK+d/iDypguWp0zbI9oN2z43O
         jwzsil8qFH69VfPmQOmV+M9WnvjgSjer+9/UGfpAB+J0BAmEup0sQeDnJIo+aqktzH/D
         k41XJ/aINje21iPjDrM4dcph2WJhjJ5lc5LD50YSAmVsSfgL58imEmf1xbXBYm9Q0Jve
         qMC6wDcaRbU6N/RrXXNSv3UynmZWpNp+tblX8ns6Wu6iaXiG6lfJrBPf8+fsR79V1cGJ
         mXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ypauC4IUvMMcSuUYDROiCLMx5UzRvg2xWq3xwwBdJ94=;
        b=lWDb9gePVYxhDMjzRA9aonLO7My6DoTXUfh5fjTQm0fbhaGuoBX/YjkCZV4QvDhgSP
         95192b0ccpY19lnkt03ubEiP1BdBl9UZg5dkxGgnHwfxsUqmY5iY7NKSrnY1rNKqdQC2
         kzZigbcuRU8t2PU20CsLptJFXWJApjXVDb8Cf9EPcQ2znekRKwbjSV1jAvHvfq6B4UKs
         GQ3BzgRlm+QQ43i0R2kaw9spU0/PQTzwAKHuFcXgaNgR4mhvy4uLhYyUYHNPWC1xUUQi
         LJTCwT/1uu2GkWunl+JuFlceq6NLgwSfqaTAeK8M6yqHegcTNmb0BczSY287xkVYnI1x
         w3pw==
X-Gm-Message-State: AJcUukftJdmrAZAxIkECuht4ukitPBTYdwDzqaeg22W3Rx7vfHZg0JJN
        pUejpXhtwQDGjscaKu28B2zTM8U8
X-Google-Smtp-Source: AFSGD/XNyEojnTo7gFhzipzeBc8fsZZNOIwDrsY761c1se7xJWWC+PjJV83iwi5qSm0pD2cSKGn3Yg==
X-Received: by 2002:a62:1c7:: with SMTP id 190mr57903344pfb.46.1546734390511;
        Sat, 05 Jan 2019 16:26:30 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id e16sm85376485pfn.46.2019.01.05.16.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Jan 2019 16:26:29 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v5 1/3] ref-filter: add worktreepath atom
Date:   Sat,  5 Jan 2019 16:26:17 -0800
Message-Id: <20190106002619.54741-2-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190106002619.54741-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190106002619.54741-1-nbelakovski@gmail.com>
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
 ref-filter.c                       | 71 ++++++++++++++++++++++++++++++++++++++
 t/t6302-for-each-ref-filter.sh     | 15 ++++++++
 3 files changed, 91 insertions(+)

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
index 5de616befe..e7ca45f39b 100644
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
@@ -420,6 +438,34 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
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
@@ -461,6 +507,7 @@ static struct {
 	{ "flag", SOURCE_NONE },
 	{ "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
 	{ "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
+	{ "worktreepath", SOURCE_NONE, FIELD_STR, worktree_atom_parser },
 	{ "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
 	{ "end", SOURCE_NONE },
 	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
@@ -1500,6 +1547,21 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
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
@@ -1537,6 +1599,10 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 		if (starts_with(name, "refname"))
 			refname = get_refname(atom, ref);
+		else if (starts_with(name, "worktreepath")) {
+			v->s = get_worktree_path(atom, ref);
+			continue;
+		}
 		else if (starts_with(name, "symref"))
 			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
@@ -2020,6 +2086,11 @@ void ref_array_clear(struct ref_array *array)
 		free_array_item(array->items[i]);
 	FREE_AND_NULL(array->items);
 	array->nr = array->alloc = 0;
+	if (worktrees)
+	{
+		hashmap_free(&ref_to_worktree_map, 1);
+		free_worktrees(worktrees);
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

