Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2E38BF60
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774482714; cv=none; b=lEsI3fUk6oJPK2q0R620/+GWcnxjmYBQjPup+JccztigJmO7uLzxDRJs7lq80krO9xK7gtKbDmzNAK/vLreq25aFKyWzU0ZtnlJjyJlky3ySyAadhhsQDGzp+8/Wo5asF+xQb/tXRFpuqVQc44KVq6ECVSjOXE5qb7tLbqmImhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774482714; c=relaxed/simple;
	bh=FKYDQ7jofMjkq/2b2BUY2DQfABZVmAY/AhvZWysKJAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hE1V5gn37UT0J/+xz+75WnPOfSudhZNW77HXJn6TeVEOz6ABrEVOvnwye4mAiO6y0WI/pEGZJGbw3fli2PRB9zNuPhiJNac8VcX/SrHq9EGOpTf4TMUlVRfWF5I8GjboQwZJogjJbKmsJT/RsMYjEwhB8FnVu8Gwyj2SbCM2E1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PVYXwrT+; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PVYXwrT+"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7986e0553bdso4090607b3.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774482712; x=1775087512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JaJxIaCWEig1DcraehJYRrOK+BVOpyqjNHXwciIgVi8=;
        b=PVYXwrT+VWjLUxb2V+H8fKbyoaLDshZXeP8ajUqg4Tyf6Sw51SXx780z3A2XHQmzBO
         UfETGNDH8B2R0CdRWdeigzYbr4FhYjPD4XSmG41usU43aNCcWtgDkcco45+qGGSf9gf/
         W4UTKhj/G5nxG6tbRpq8eHR/7opt+WEToVRcPhtDKIso7D06o/i3z0GuCa8Af380WuDC
         3PRLQNrKGNASRX4yniARbB4E1DSHZPdnBcrRg8e44wY6R6+CeyHxVYqDLlNCzqjmqYhO
         YX49oMSN/9TyccQ20djOP5VE+7AjeZ14a5MlqxNZ9tlRXHrZKzs3sHQvgxkagQ8vHTfQ
         K4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774482712; x=1775087512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaJxIaCWEig1DcraehJYRrOK+BVOpyqjNHXwciIgVi8=;
        b=UjaQJH3WbPjHTToQDrEuG4TLMUX9MzF7SfGM/kQYl/aS00O2clwBmP7g37m1xP6M1h
         LJp67iLdA+M2SDlkgNb86Gw9r7pbaQH93HtTPihYxpxWn48WU3U9nDtDvt4l0QU8jTPV
         LEpQqKOv2mWP/QENl95Gl4jvBxY8Qb1rtqgNCKDvGuzu+HrEJrjANhybThUcAVgjddRi
         sfDG3kJRU8nr3sIAko7h2bxeo6XWjfF70iLT1KUzZMnpPZNmmqWIF4Wix2yo138Syuwk
         laM70WHW/5l23j/pk4le5UKEYe94E8mtaI7kHyCfTd/qOb5+l27v60rMATgcJ5/zxa6H
         SD1g==
X-Gm-Message-State: AOJu0YxlwddXzwORt6TnUc3H1eCySBkP1n6g23nQJS1V/aQ8ATLvidwt
	dWNmu9xFw9RI8CmPnbqWK4FBTM/A3SeCe5GY5tChGlABeAqLNxf/PT+3W+C8kMQ6gcxvSKSAwlY
	ZjYY1qUEJ7HB+
X-Gm-Gg: ATEYQzwrQJCxattwzMV5vu7X2QlsRCYxRmthpyQjz3kqa3OfYJ6wpfX6/Q82NJGGTQW
	Lqkd2NIhgP5WOH2DnSRiBVF6NNZoAVZHHcX3GOTbx7goU4KS9I6qJdyWjpqnxL3SK7e6Qf5g8ud
	d/VK/Pap07Sr6vMJ8AN1fcRmQeWFKPrYG0uIjtsFp0aWOmRuy/I+53f76SAkyKaQFFxNoHsrSsn
	YIlBsf9k70O81paksNmdqGBYhjDs+du9u4M7xRcZc+4mFZXMQPYgzXmSiyw8D+wgdq4DVyP4k0M
	n1XSXBGfbCqgkIq4X39cWQF8Pd8RAemutsKNVXp1D99pMqoIqPbWsAAPQobZuomWKkosigxujw9
	5Cv0X3NcZTLuV6o4Shz+XALHI/xEEvQ3edY65n//zy1U5jAjkldlMsv4rFjTmkkOqj4o96AiUZB
	HM/ksBN4YYwUcX9iMG6YEvXnkj3esVlrbou5mlvSx1DEZCSLrS/I6hrv1zUG5N6jUXl/FYvzL9X
	swjRRPtURzfYsSAcjHsvkkZJWQ37Q==
X-Received: by 2002:a05:690c:f09:b0:79a:d2ba:3c28 with SMTP id 00721157ae682-79ad2ba4245mr42423637b3.43.1774482711708;
        Wed, 25 Mar 2026 16:51:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b10c6be18sm5802117b3.8.2026.03.25.16.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 16:51:51 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:51:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/5] pack-objects: refactor `read_packs_list_from_stdin()`
 to use `strmap`
Message-ID: <d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774482700.git.me@ttaylorr.com>

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
 builtin/pack-objects.c | 150 ++++++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 61 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9a89bc5c4c9..068b87d2af4 100644
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
@@ -3837,90 +3838,117 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
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
+		string_list_append(&keys, entry->key)->util = info;
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
+		struct stdin_pack_info *info = item->util;
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
+		if (!*key)
 			continue;
+		if (*key == '^')
+			key++;
+
+		info = strmap_get(&packs, key);
+		if (!info) {
+			CALLOC_ARRAY(info, 1);
+			strmap_put(&packs, key, info);
+		}
 
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
@@ -3957,7 +3985,7 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 
 	/* avoids adding objects in excluded packs */
 	ignore_packed_keep_in_core = 1;
-	read_packs_list_from_stdin(&revs);
+	stdin_packs_read_input(&revs);
 	if (rev_list_unpacked)
 		add_unreachable_loose_objects(&revs);
 
-- 
2.53.0.614.g164f3b634ec

