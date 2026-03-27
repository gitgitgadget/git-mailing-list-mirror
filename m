Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF03876BF
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642010; cv=none; b=auQmnAwuJKDUGobdKmb6pCuBZ9jo1b+hVeCQnOhB7Jlzj1iHe+CA+ZfF3lk9bTBEVP+juJWmDE7pxEYUz4yAIXehB/gHqu9af6V/Qz/cSrJFJgKIqFuBqMyeGZBMEk1935yvqkoVDI+gpTZuaWMSA8S++Uhc+mc7kYJLzlomujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642010; c=relaxed/simple;
	bh=GKiW0dUZrdhg8yNz9YIomUMPjci7OAwljugOZdfZ4nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzjDT5eUOcj6sQ+i63DANVhXs285J0TRheEumaoZYvultmm9zNAQSycfztHXuh0D0hJQAIqJV7nUhqfyVFJzMFEbDCAHoKN4lflNtgpvqodCgPwQ474C4HPu+z7V27oqW3Oetg/7gXWjSms/KEwr9dlDuHd7gk4czotbmtIpsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=n0PUOLI1; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="n0PUOLI1"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-798374d0f44so51919627b3.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774642007; x=1775246807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKO9UHZMybsIuppxLVe5xS/aSSP4HCfsI4w1qNJaX5s=;
        b=n0PUOLI116JJGgvkq8SLLr0nb3Y/p0VJ+VcX2KbhzCwUBADEhUmn+0XReH8g9Y8dGp
         z+Cj57a+urvgY5ABtd6G1pNJLIsFB4KPPQorssu+4nlgP6wMfESK7XttbbTkODWIV/iC
         NfXHO4avookl/CF7bf3vKfpomgniF66niBKev3fHJVwgOJ9oBaypZ8djc/R0IWC7yHWB
         9zSAsZf058jBmqgSxeOJUbNbHRN+fF8jKTfTxFsfV5MBaLknoQjMWdJp8OdW8LBxi/sy
         0EgFuDi+mLzekAaAviOHabqQXq7ldcFco8IPE2l0gcBeGp7fl+RoUMlTWOvjyEwe4sG5
         BePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642007; x=1775246807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKO9UHZMybsIuppxLVe5xS/aSSP4HCfsI4w1qNJaX5s=;
        b=IvXKku57SLkk9RdKN6IUzkdVkfPPmWW8Km0SOP/n0rhDqJNQXzOr3xX9jqqY9OaKRG
         IQWSTrhX7XITcOBbFXStvwVeYYIZ/kxFk3nu4ZK++27L+LdCpDy450CwdNKL1sFzQGKp
         2lyzVPcYim80l4bTasiX/Z73RiwqgLxtbyfuKp+T6uOdXdxat0/OhSruO6doYNZGAgji
         tOM3AdbgReV//hc5eaSJWWJEhAJoSTtI82kCwugzGMOSJ3rKedOACIot149vpktea2h1
         XzBHkzbq2NIYz0fVymBNAXu5J1ro3+Sbt9uBWd1lZG18H4fF6tu8ma/Fpa0QnUXzJLiS
         0NaA==
X-Gm-Message-State: AOJu0YzzzpUQ1Q6BzDz/waxA7SgshZD6IIfPhvAAgMSu7FaAtOndRZMN
	NdY2Y0mckwkqIwwOqeTkFeL8kOm+eZ8IZSctPDvPdgww0Yc/syzUDxTGFAD2aFQtQ8oBcdQHe/s
	8uM7868gkr0Sq
X-Gm-Gg: ATEYQzyxYxMGXwP27wc2LAzYn3dZmGitAl8LHh7XRUWTy2TfU7sedKg7imCC/kXCaaB
	GEYw83MRoE8oeVNyE7dP1OxiB1bzjJD/KWp8IP8eOnyywd1w6YIu4tkHfvlMKOhCgsIvah+WqIT
	Z7/9jUuy5ptO5enmjx4GRVMvFKG/bc+JO4RsX0BlFl6M9+qKOMIbCyojnwBqEbqB+XLXF0mqtjj
	0815LOiKlGQD0cQmgk4tncCyI+r9ABWKT3PgXw2/Ci35rCJlhRAcExJf6s7cq3nrY1DnVmL4opx
	9PTD9yFMBlWd8VYk0Yh9OGPQCkJxBVUMm9N759894xjO93Vsg77aNbD+vkaZ8aL4Chh7fgEYC4U
	Q1YWrzznSpzSpRjlUYnXLjrl8CB902F6xIfy9pCVTj/ZCKkdpDp3K/94RDIjAFFK/P1MJdzLwfB
	mzsHTaIfqmR3dzg4XBtc0ychkNm1LDFXrpfn4q1Lf9d5g8RaZ6ePzZNh147kd3m/8lC7wAUL3Nf
	yvDUxQwFoxC9MSzDidpf/Q2B9QpxQ==
X-Received: by 2002:a05:690c:6e86:b0:79a:b520:c8b7 with SMTP id 00721157ae682-79bde574b5bmr31400947b3.22.1774642007387;
        Fri, 27 Mar 2026 13:06:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7721566sm160547b3.12.2026.03.27.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:06:47 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:06:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 2/5] pack-objects: refactor `read_packs_list_from_stdin()`
 to use `strmap`
Message-ID: <dd9ff1ede4ac0b3b18284d2363ea4aa4c1d97f8c.1774641999.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774641999.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774641999.git.me@ttaylorr.com>

The '--stdin-packs' mode of pack-objects maintains two separate
string_lists: one for included packs, and one for excluded packs. Each
list stores the pack basename as a string and the corresponding
`packed_git` pointer in its `->util` field.

This works, but makes it awkward to extend the set of pack "kinds" that
pack-objects can accept via stdin, since each new kind would need its
own string_list and duplicated handling. A future commit will want to do
just this, so prepare for that change by handling the various "kinds" of
packs specified over stdin in a more generic fashion.

Namely, replace the two `string_list`s with a single `strmap` keyed on
the pack basename, with values pointing to a new `struct
stdin_pack_info`. This struct tracks both the `packed_git` pointer and a
`kind` bitfield indicating whether the pack was specified as included or
excluded.

Extract the logic for sorting packs by mtime and adding their objects
into a separate `stdin_packs_add_pack_entries()` helper.

While we could have used a `string_list`, we must handle the case where
the same pack is specified more than once. With a `string_list` only, we
would have to pay a quadratic cost to either (a) insert elements into
their sorted positions, or (b) a repeated linear search, which is
accidentally quadratic. For that reason, use a strmap instead.

This patch does not include any functional changes.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 197 +++++++++++++++++++++++++----------------
 1 file changed, 121 insertions(+), 76 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f640e556823..8ab7ca98a55 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -28,6 +28,7 @@
 #include "reachable.h"
 #include "oid-array.h"
 #include "strvec.h"
+#include "strmap.h"
 #include "list.h"
 #include "packfile.h"
 #include "object-file.h"
@@ -3835,87 +3836,61 @@ static void show_commit_pack_hint(struct commit *commit, void *data)
 
 }
 
+/*
+ * stdin_pack_info_kind specifies how a pack specified over stdin
+ * should be treated when pack-objects is invoked with --stdin-packs.
+ *
+ *  - STDIN_PACK_INCLUDE: objects in any packs with this flag bit set
+ *    should be included in the output pack, unless they appear in an
+ *    excluded pack.
+ *
+ *  - STDIN_PACK_EXCLUDE_CLOSED: objects in any packs with this flag
+ *    bit set should be excluded from the output pack.
+ *
+ * Objects in packs whose 'kind' bits include STDIN_PACK_INCLUDE are
+ * used as traversal tips when invoked with --stdin-packs=follow.
+ */
+enum stdin_pack_info_kind {
+	STDIN_PACK_INCLUDE = (1<<0),
+	STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
+};
+
+struct stdin_pack_info {
+	struct packed_git *p;
+	enum stdin_pack_info_kind kind;
+};
+
 static int pack_mtime_cmp(const void *_a, const void *_b)
 {
-	struct packed_git *a = ((const struct string_list_item*)_a)->util;
-	struct packed_git *b = ((const struct string_list_item*)_b)->util;
+	struct stdin_pack_info *a = ((const struct string_list_item*)_a)->util;
+	struct stdin_pack_info *b = ((const struct string_list_item*)_b)->util;
 
 	/*
 	 * order packs by descending mtime so that objects are laid out
 	 * roughly as newest-to-oldest
 	 */
-	if (a->mtime < b->mtime)
+	if (a->p->mtime < b->p->mtime)
 		return 1;
-	else if (b->mtime < a->mtime)
+	else if (b->p->mtime < a->p->mtime)
 		return -1;
 	else
 		return 0;
 }
 
-static void read_packs_list_from_stdin(struct rev_info *revs)
+static void stdin_packs_add_pack_entries(struct strmap *packs,
+					 struct rev_info *revs)
 {
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list include_packs = STRING_LIST_INIT_DUP;
-	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
-	struct string_list_item *item = NULL;
-	struct packed_git *p;
+	struct string_list keys = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
 
-	while (strbuf_getline(&buf, stdin) != EOF) {
-		if (!buf.len)
-			continue;
+	strmap_for_each_entry(packs, &iter, entry) {
+		struct stdin_pack_info *info = entry->value;
+		if (!info->p)
+			die(_("could not find pack '%s'"), entry->key);
 
-		if (*buf.buf == '^')
-			string_list_append(&exclude_packs, buf.buf + 1);
-		else
-			string_list_append(&include_packs, buf.buf);
-
-		strbuf_reset(&buf);
-	}
-
-	string_list_sort_u(&include_packs, 0);
-	string_list_sort_u(&exclude_packs, 0);
-
-	repo_for_each_pack(the_repository, p) {
-		const char *pack_name = pack_basename(p);
-
-		if ((item = string_list_lookup(&include_packs, pack_name))) {
-			if (exclude_promisor_objects && p->pack_promisor)
-				die(_("packfile %s is a promisor but --exclude-promisor-objects was given"), p->pack_name);
-			item->util = p;
-		}
-		if ((item = string_list_lookup(&exclude_packs, pack_name)))
-			item->util = p;
-	}
-
-	/*
-	 * Arguments we got on stdin may not even be packs. First
-	 * check that to avoid segfaulting later on in
-	 * e.g. pack_mtime_cmp(), excluded packs are handled below.
-	 *
-	 * Since we first parsed our STDIN and then sorted the input
-	 * lines the pack we error on will be whatever line happens to
-	 * sort first. This is lazy, it's enough that we report one
-	 * bad case here, we don't need to report the first/last one,
-	 * or all of them.
-	 */
-	for_each_string_list_item(item, &include_packs) {
-		struct packed_git *p = item->util;
-		if (!p)
-			die(_("could not find pack '%s'"), item->string);
-		if (!is_pack_valid(p))
-			die(_("packfile %s cannot be accessed"), p->pack_name);
-	}
-
-	/*
-	 * Then, handle all of the excluded packs, marking them as
-	 * kept in-core so that later calls to add_object_entry()
-	 * discards any objects that are also found in excluded packs.
-	 */
-	for_each_string_list_item(item, &exclude_packs) {
-		struct packed_git *p = item->util;
-		if (!p)
-			die(_("could not find pack '%s'"), item->string);
-		p->pack_keep_in_core = 1;
+		string_list_append(&keys, entry->key)->util = info;
 	}
 
 	/*
@@ -3923,19 +3898,89 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 	 * string_list_item's ->util pointer, which string_list_sort() does not
 	 * provide.
 	 */
-	QSORT(include_packs.items, include_packs.nr, pack_mtime_cmp);
-
-	for_each_string_list_item(item, &include_packs) {
-		struct packed_git *p = item->util;
-		for_each_object_in_pack(p,
-					add_object_entry_from_pack,
-					revs,
-					ODB_FOR_EACH_OBJECT_PACK_ORDER);
+	QSORT(keys.items, keys.nr, pack_mtime_cmp);
+
+	for_each_string_list_item(item, &keys) {
+		struct stdin_pack_info *info = item->util;
+
+		if (info->kind & STDIN_PACK_INCLUDE)
+			for_each_object_in_pack(info->p,
+						add_object_entry_from_pack,
+						revs,
+						ODB_FOR_EACH_OBJECT_PACK_ORDER);
 	}
 
+	string_list_clear(&keys, 0);
+}
+
+static void stdin_packs_read_input(struct rev_info *revs)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct strmap packs = STRMAP_INIT;
+	struct packed_git *p;
+
+	while (strbuf_getline(&buf, stdin) != EOF) {
+		struct stdin_pack_info *info;
+		enum stdin_pack_info_kind kind = STDIN_PACK_INCLUDE;
+		const char *key = buf.buf;
+
+		if (!*key)
+			continue;
+		else if (*key == '^')
+			kind = STDIN_PACK_EXCLUDE_CLOSED;
+
+		if (kind != STDIN_PACK_INCLUDE)
+			key++;
+
+		info = strmap_get(&packs, key);
+		if (!info) {
+			CALLOC_ARRAY(info, 1);
+			strmap_put(&packs, key, info);
+		}
+
+		info->kind |= kind;
+
+		strbuf_reset(&buf);
+	}
+
+	repo_for_each_pack(the_repository, p) {
+		struct stdin_pack_info *info;
+
+		info = strmap_get(&packs, pack_basename(p));
+		if (!info)
+			continue;
+
+		if (info->kind & STDIN_PACK_INCLUDE) {
+			if (exclude_promisor_objects && p->pack_promisor)
+				die(_("packfile %s is a promisor but --exclude-promisor-objects was given"), p->pack_name);
+
+			/*
+			 * Arguments we got on stdin may not even be
+			 * packs. First check that to avoid segfaulting
+			 * later on in e.g.  pack_mtime_cmp(), excluded
+			 * packs are handled below.
+			 */
+			if (!is_pack_valid(p))
+				die(_("packfile %s cannot be accessed"), p->pack_name);
+		}
+
+		if (info->kind & STDIN_PACK_EXCLUDE_CLOSED) {
+			/*
+			 * Marking excluded packs as kept in-core so
+			 * that later calls to add_object_entry()
+			 * discards any objects that are also found in
+			 * excluded packs.
+			 */
+			p->pack_keep_in_core = 1;
+		}
+
+		info->p = p;
+	}
+
+	stdin_packs_add_pack_entries(&packs, revs);
+
 	strbuf_release(&buf);
-	string_list_clear(&include_packs, 0);
-	string_list_clear(&exclude_packs, 0);
+	strmap_clear(&packs, 1);
 }
 
 static void add_unreachable_loose_objects(struct rev_info *revs);
@@ -3972,7 +4017,7 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 
 	/* avoids adding objects in excluded packs */
 	ignore_packed_keep_in_core = 1;
-	read_packs_list_from_stdin(&revs);
+	stdin_packs_read_input(&revs);
 	if (rev_list_unpacked)
 		add_unreachable_loose_objects(&revs);
 
-- 
2.53.0.724.gb20b077944a

