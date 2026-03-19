Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D423B9D9E
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959066; cv=none; b=Oo9vj1bdM1m1vmVhKSDcwcwwpOu3BIGApQqcLaGHQyjGEExnxYoDgBCnLhGdFuGG+/su2ue9Mlm5QdL6/PJD4hSAxAnJFNk440zuxnlWHP0qAJItHdv4LKU6tEqRtx+TlBKOwytCaCT3pZaxdPxK6JVkg07C3iqBLwEdn4/U0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959066; c=relaxed/simple;
	bh=Nf8c4jaPyC3FyJ05h23g/4pL1977ibkgXWk5ibfMYHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhH9gkRkLpaumcp4YbQfQ/AOAyBP6QfIk1eYTfEBWOfCpcpdUN9AGJLvaqwPm8H+nv+88zxZ0K/UPYLbgAz5ReUdXSZyt8sP0zDEvNXqpm1bUY4hmOYj3Ohh0TsG74V8hPk2FxjuHfvjQmIEWdQNxb2qFkHndqvq6cYLhYo+iGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=iEXXsnul; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="iEXXsnul"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-79a46260385so15806347b3.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1773959061; x=1774563861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5G5oxuYtzgr/mxHImysDhwEZ/2tXmplS6vkk4r+gVoo=;
        b=iEXXsnulhZnYbrffIuJEdTJ9SX3vjK5ttKouhKMJO08ac6SdSJro4TX6GrQj8WQbWY
         3RDuvkC2HqRgIZsd/Hr5YFcQx70VJEELBXK0XcjScXl1RKM3RM1Pbj0CnWtYlBxtkiOB
         drxds93PyxMXdgiV3o3G1zsvNc6NtBn98hiHO02VIE1FgPIi69bhAu0idXd/Gy3ZhvfR
         aVlBaaokz+nFDOWWTqIgwvlNazFBa7utmdnEEWQSvooFD9OlCQFKz2ICUgQSmvRW574X
         bh4M1JNtan3ofYrKP6jn/XFhRIG2P7oIgzEMbiJHVGR9Jhqvo0vn9rR0YIUhKUOglOYr
         7E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773959061; x=1774563861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G5oxuYtzgr/mxHImysDhwEZ/2tXmplS6vkk4r+gVoo=;
        b=iLhfxzuacrf41JQpp6SLTWNeX1BLEu0BMs0OZF1lK4B0uBGHZ7e/DYbM7JzDNjX87/
         bcuoyYzpkbexoYCsxKpFGZb6MQY13E2McyeIxF32aBo+IkfB74SvzIo5JoXvYsboKx4D
         zAtBL2bzmFLcSZKOkrP/mxhICbwx3FQT5gzqxHABj+loA+TrSKPILfJY7aLhkQc0m8fW
         s9TprdnINutzJ70sPyxQA9LiE0xXPyqgBPozfBQfQBkuKuTZj7AJXP6GZkCSEYD1/fMv
         eBdGYDwxMO/XWrY8rfz3wOeWOUFPl6NBamXRZhysHK4YozBOnjPUu4RwGEEJtaM1SJHA
         6DEw==
X-Gm-Message-State: AOJu0Yw3Vx836ykLutDX9XK23sGWzqfsdT6Ck5Fb23NzZnLb41q/ABUc
	NfOPHlXKHw2oFXJoQGhYO48fvQa4ykat/U+jacceUu0TB5ugUN/2alcYQj86qb0Arf2JlRkUJHl
	e9Ereb6b1Tvy9
X-Gm-Gg: ATEYQzwtZ2swg+p5Z7/HpTEqWatsN3auxs+HfCdV5nEyZjH4WzG0eNJ6VrhUacgdhRf
	N0tpDTAZ59B065zCL9zpKHTHb5IuLpVb9eS0RTFoGND4Rt9X7bKkqznkJ0eR2/Xv8GlUwKQopTG
	YkIOfx1hrVvA/kmoIOniibS57JoQALAKgoiE+Q/UOaXib3hAGdjJ+HSuV3hDMD7uN6RKEOd+vj9
	MgbzQh2h12F2sW/3xnjPVAcRJJm8tgC61RsHP+olhZL6APZVA1w5uPz/NEJKWmGVKEThW9yeMCm
	M9NOzF85M69fh1/GZlaKDtQ7Us+4z13bS1V4cQB+apaQYAHOLIj/897FgIMJAx8EAhc7WaQFPp7
	lc9P7UHwil9ss5rs5uj5porCCvwElnnM7u6tCZOrTvw21HR8lNfbTBYm/gh/Y0TgdJ3X7Iebkc9
	xnyb8p4SbwHfhX8DB93BfX4B73Tf7VJ8lDChN9K6LLbK/3de69tbhSkP73eC6IPlzIU2gAqQSWw
	pY6Ack74+z7HOuYDhkR6pr0yRfO2g==
X-Received: by 2002:a05:690c:dc7:b0:79a:38a2:d8af with SMTP id 00721157ae682-79a90b09fd6mr8738377b3.21.1773959061205;
        Thu, 19 Mar 2026 15:24:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903a5ac0sm5400627b3.9.2026.03.19.15.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:24:20 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:24:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/5] pack-objects: refactor `read_packs_list_from_stdin()` to
 use `strmap`
Message-ID: <ea6fdbcc46f608c3fbe65298e9ca91faf43a1b16.1773959041.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1773959041.git.me@ttaylorr.com>

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
into a separate `stdin_packs_add_entries()` helper.

While we could have used a `string_list`, we must handle the case where
the same pack is specified more than once. With a `string_list` only, we
would have to pay a quadratic cost to either (a) insert elements into
their sorted positions, or (b) a repeated linear search, which is
accidentally quadratic. For that reason, use a strmap instead.

This patch does not include any functional changes.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 153 +++++++++++++++++++++++++----------------
 1 file changed, 92 insertions(+), 61 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9a89bc5c4c9..72c9ddbed6b 100644
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
@@ -3837,90 +3838,120 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
 		return 0;
 }
 
-static void read_packs_list_from_stdin(struct rev_info *revs)
+struct stdin_pack_info {
+	struct packed_git *p;
+	enum {
+		STDIN_PACK_INCLUDE = (1<<0),
+		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
+	} kind;
+};
+
+static void stdin_packs_add_pack_entries(struct strmap *packs,
+					 struct rev_info *revs)
+{
+	struct string_list keys = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	strmap_for_each_entry(packs, &iter, entry) {
+		struct stdin_pack_info *info = entry->value;
+		if (!info->p)
+			die(_("could not find pack '%s'"), entry->key);
+
+		string_list_append(&keys, entry->key)->util = info->p;
+	}
+
+	/*
+	 * Order packs by ascending mtime; use QSORT directly to access the
+	 * string_list_item's ->util pointer, which string_list_sort() does not
+	 * provide.
+	 */
+	QSORT(keys.items, keys.nr, pack_mtime_cmp);
+
+	for_each_string_list_item(item, &keys) {
+		struct stdin_pack_info *info = strmap_get(packs, item->string);
+		if (!info->p)
+			die(_("could not find pack '%s'"), item->string);
+
+		if (info->kind & STDIN_PACK_INCLUDE)
+			for_each_object_in_pack(info->p,
+						add_object_entry_from_pack,
+						revs,
+						ODB_FOR_EACH_OBJECT_PACK_ORDER);
+	}
+
+	string_list_clear(&keys, 0);
+}
+
+static void stdin_packs_read_input(struct rev_info *revs)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct string_list include_packs = STRING_LIST_INIT_DUP;
-	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
-	struct string_list_item *item = NULL;
+	struct strmap packs = STRMAP_INIT;
 	struct packed_git *p;
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
-		if (!buf.len)
+		struct stdin_pack_info *info;
+		const char *key = buf.buf;
+
+		if (!key || !*key)
 			continue;
 
+		if (*key == '^')
+			key++;
+
+		info = strmap_get(&packs, key);
+		if (!info) {
+			CALLOC_ARRAY(info, 1);
+			strmap_put(&packs, key, info);
+		}
+
 		if (*buf.buf == '^')
-			string_list_append(&exclude_packs, buf.buf + 1);
+			info->kind |= STDIN_PACK_EXCLUDE_CLOSED;
 		else
-			string_list_append(&include_packs, buf.buf);
+			info->kind |= STDIN_PACK_INCLUDE;
 
 		strbuf_reset(&buf);
 	}
 
-	string_list_sort_u(&include_packs, 0);
-	string_list_sort_u(&exclude_packs, 0);
-
 	repo_for_each_pack(the_repository, p) {
-		const char *pack_name = pack_basename(p);
+		struct stdin_pack_info *info;
 
-		if ((item = string_list_lookup(&include_packs, pack_name))) {
+		info = strmap_get(&packs, pack_basename(p));
+		if (!info)
+			continue;
+
+		if (info->kind & STDIN_PACK_INCLUDE) {
 			if (exclude_promisor_objects && p->pack_promisor)
 				die(_("packfile %s is a promisor but --exclude-promisor-objects was given"), p->pack_name);
-			item->util = p;
+
+			/*
+			 * Arguments we got on stdin may not even be
+			 * packs. First check that to avoid segfaulting
+			 * later on in e.g.  pack_mtime_cmp(), excluded
+			 * packs are handled below.
+			 */
+			if (!is_pack_valid(p))
+				die(_("packfile %s cannot be accessed"), p->pack_name);
 		}
-		if ((item = string_list_lookup(&exclude_packs, pack_name)))
-			item->util = p;
-	}
 
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
+		if (info->kind & STDIN_PACK_EXCLUDE_CLOSED) {
+			/*
+			 * Marking excluded packs as kept in-core so
+			 * that later calls to add_object_entry()
+			 * discards any objects that are also found in
+			 * excluded packs.
+			 */
+			p->pack_keep_in_core = 1;
+		}
 
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
+		info->p = p;
 	}
 
-	/*
-	 * Order packs by ascending mtime; use QSORT directly to access the
-	 * string_list_item's ->util pointer, which string_list_sort() does not
-	 * provide.
-	 */
-	QSORT(include_packs.items, include_packs.nr, pack_mtime_cmp);
-
-	for_each_string_list_item(item, &include_packs) {
-		struct packed_git *p = item->util;
-		for_each_object_in_pack(p,
-					add_object_entry_from_pack,
-					revs,
-					ODB_FOR_EACH_OBJECT_PACK_ORDER);
-	}
+	stdin_packs_add_pack_entries(&packs, revs);
 
 	strbuf_release(&buf);
-	string_list_clear(&include_packs, 0);
-	string_list_clear(&exclude_packs, 0);
+	strmap_clear(&packs, 1);
 }
 
 static void add_unreachable_loose_objects(struct rev_info *revs);
@@ -3957,7 +3988,7 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 
 	/* avoids adding objects in excluded packs */
 	ignore_packed_keep_in_core = 1;
-	read_packs_list_from_stdin(&revs);
+	stdin_packs_read_input(&revs);
 	if (rev_list_unpacked)
 		add_unreachable_loose_objects(&revs);
 
-- 
2.53.0.614.gc4fd52e751a

