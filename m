Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C033876BF
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642005; cv=none; b=hB88Dz92tkyiwnOfmDOqcVl1b5ZbHH9pTefvmvC82rMJAnRMfzTG6I2msJF6z+ShjcfjsOHX8/H73aXQxv4pih6q41D0kufglDme7B1lmJGJAxm/5oa8rTnpQLqTdvafp/T8KuqbDRz8atKOo1db3Y6n7SdPlLIt7Ax7qodZ7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642005; c=relaxed/simple;
	bh=xhTT6sPxGys+oNytpHmPfCuWjo4s9Sl9iCfONMd8Ve4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyKewoJaavn1HRFVGp4NmiXONXHc2rz7XvteVX25PmkUwm1f37uoB0FAMhWzfgwIWDvQN1bBNP5BNVnB17CpFwjy0abv5k11x+Us+EWGXvopRjMd4AbWbJa3zaVgJAigN0XzO2uVGHNdfXWO6fPVpi6MXFckTKHoCLXV1iwt23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WOdiXEKM; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WOdiXEKM"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7991db3dc98so28225557b3.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774642002; x=1775246802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKqBecGD5Hqz3CreFp97nuYY6vQRuKPHM0L5kR02Hs8=;
        b=WOdiXEKM4HftB6CBo0Fp2eLWEeE352tg+emNTY7S6DitDfabakaECNt1bDnyxIvHFh
         tao/DBgq1HtSsajL8xOlu6uD6RHrrYIIClcehKpbWHTNz/FUG/efhQF7nD5FpmNXzCE+
         T6cs2jxlQd5NS2STga5AwI7/PbRZdKEMm7skV5ZdOcUftMLl5gkR0olS4qhP5ha+dDnu
         wDxxth7WV9rR3ByRoba62gP96yMQpCYaE80Ff1CkiJXi4w9PPTwTGy/U7SzmWVAZjdAR
         x274hIsZL9OKXTlWcAi2utCOKj+WNuc/V0bgvVLeY04EuAG4E4bE1B2m1e/gDiacwu7b
         vDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642002; x=1775246802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKqBecGD5Hqz3CreFp97nuYY6vQRuKPHM0L5kR02Hs8=;
        b=JSn/NrozDCxSFbNX2P2ioUPqORQCPukn91QJ2lWt455OSzlTf0i96KigkiakTML7Dv
         4HJKJyrWBOdz5xDVaWUq3tjznS7nysZDnbd2PqMPIMUGYDO/ppIS4Wfu3xCbNpm1+LM3
         mXCFgBIDli4ZAUw+mYw8gQUVDisZjGtv55U//4jVvQYzxCGbMVottF+bdKeVg0vLGfqo
         iP6b355WggevsfydotYZ8mqL2qqzkzzKumwihRb+YM5POYzlGs6cofSeD6n67Amv4g7l
         pCrfHPTDPIX8GkdoQ2l5TjQ72/AR0cDeLXYFJMKdN5jWUsTReuJXo9szMiJGFUpEYknm
         OYqw==
X-Gm-Message-State: AOJu0YzjYAiTNAIvcKLYu08Sn9XVhk+CIEYsEtaiti0WpIsZsYmfzQEp
	QlQ0EiEXpxZNfeZDGz2n0TKaFdiKDRgV5ePS4VBU7hF7Nnl4qIvh1r0GZCWbQaVlIBNBxTKOoBK
	zyphEp/HQFMa5
X-Gm-Gg: ATEYQzxA99RfxGDk+f4W6X67YQBO+XXkBk4ni1bbVX+zkyL5ZALgVFKNI9LfhRuGI8Q
	492uMq8J5+K2FCTrigh/1sGAbbnj2SQcTjdREkyU6jOzfKLllFPc57cjiIBOn/Bb/mws7P/sEjE
	iFpAnqoS/TmUi8TfZx6BFgF3HKdsNMENShwDzjWw/72WjbyPGDLJdhuy5i6oRbzp42XgaO08CV1
	UIOK7BMxwflsfmtfQDsydo8BXmbgc3NDrW5tnCCCYakBG9dwiXP/cgl2eK5Cc7rVsdXAcFfbTSB
	pRKZ3EF0w8gLw7QwIVmb8wvpXd4dYTbIIZcNWjdpMFVbl/J+P7EXZAG2nuug562DVdN0QQ2udeB
	a9JBRoT7WN1Hs5ui3+QlWmSmPXq8BTiWgX3g0z8IQO0icv0gvI4r++A8V562z/zvIlUFsCD88HC
	cG+1F8ZYiZ188+Urpxrp80HrUIeNxtuhh0NXhuhPVYaBvlw36eURcL8r+3HmEIxAe/oXnD8FRzl
	c4uIabSln28YSyeEeMILJvVBSIe2Q==
X-Received: by 2002:a05:690c:f14:b0:79a:c396:c01 with SMTP id 00721157ae682-79bde0b4d8amr40104567b3.55.1774642001911;
        Fri, 27 Mar 2026 13:06:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8e4fcsm20037b3.24.2026.03.27.13.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:06:41 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:06:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 0/5] pack-objects: handle excluded-but-open packs via
 `--stdin-packs=follow`
Message-ID: <cover.1774641999.git.me@ttaylorr.com>
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

This is another small reroll of my series to fix an issue where MIDX
bitmaps fail to generate after a geometric repack in certain scenarios
where the set of MIDX'd objects is not closed under reachability.

The main changes since last time are:

 * Named enum stdin_pack_info_kind.

 * Refactored how we handle reading incoming packs via stdin.

 * Fixed a nasty case where sorting the packs in order of mtime happened
   to work on some systems, but ASan detected a very legitimate bug.

As usual, a range-diff is included below for convenience.

Thanks again for your review!

Taylor Blau (5):
  pack-objects: plug leak in `read_stdin_packs()`
  pack-objects: refactor `read_packs_list_from_stdin()` to use `strmap`
  t7704: demonstrate failure with once-cruft objects above the geometric
    split
  pack-objects: support excluded-open packs with --stdin-packs
  repack: mark non-MIDX packs above the split as excluded-open

 Documentation/git-pack-objects.adoc |  25 ++-
 builtin/pack-objects.c              | 301 +++++++++++++++++++---------
 builtin/repack.c                    |  19 +-
 packfile.c                          |   3 +-
 packfile.h                          |   2 +
 t/t5331-pack-objects-stdin.sh       | 105 ++++++++++
 t/t7704-repack-cruft.sh             |  22 ++
 7 files changed, 373 insertions(+), 104 deletions(-)

Range-diff against v2:
1:  1fabd88f5e3 = 1:  d6ff4e801ab pack-objects: plug leak in `read_stdin_packs()`
2:  d5cb793f0eb ! 2:  dd9ff1ede4a pack-objects: refactor `read_packs_list_from_stdin()` to use `strmap`
    @@ builtin/pack-objects.c
      #include "list.h"
      #include "packfile.h"
      #include "object-file.h"
    -@@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b)
    +@@ builtin/pack-objects.c: static void show_commit_pack_hint(struct commit *commit, void *data)
    + 
    + }
    + 
    ++/*
    ++ * stdin_pack_info_kind specifies how a pack specified over stdin
    ++ * should be treated when pack-objects is invoked with --stdin-packs.
    ++ *
    ++ *  - STDIN_PACK_INCLUDE: objects in any packs with this flag bit set
    ++ *    should be included in the output pack, unless they appear in an
    ++ *    excluded pack.
    ++ *
    ++ *  - STDIN_PACK_EXCLUDE_CLOSED: objects in any packs with this flag
    ++ *    bit set should be excluded from the output pack.
    ++ *
    ++ * Objects in packs whose 'kind' bits include STDIN_PACK_INCLUDE are
    ++ * used as traversal tips when invoked with --stdin-packs=follow.
    ++ */
    ++enum stdin_pack_info_kind {
    ++	STDIN_PACK_INCLUDE = (1<<0),
    ++	STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
    ++};
    ++
    ++struct stdin_pack_info {
    ++	struct packed_git *p;
    ++	enum stdin_pack_info_kind kind;
    ++};
    ++
    + static int pack_mtime_cmp(const void *_a, const void *_b)
    + {
    +-	struct packed_git *a = ((const struct string_list_item*)_a)->util;
    +-	struct packed_git *b = ((const struct string_list_item*)_b)->util;
    ++	struct stdin_pack_info *a = ((const struct string_list_item*)_a)->util;
    ++	struct stdin_pack_info *b = ((const struct string_list_item*)_b)->util;
    + 
    + 	/*
    + 	 * order packs by descending mtime so that objects are laid out
    + 	 * roughly as newest-to-oldest
    + 	 */
    +-	if (a->mtime < b->mtime)
    ++	if (a->p->mtime < b->p->mtime)
    + 		return 1;
    +-	else if (b->mtime < a->mtime)
    ++	else if (b->p->mtime < a->p->mtime)
    + 		return -1;
    + 	else
      		return 0;
      }
      
     -static void read_packs_list_from_stdin(struct rev_info *revs)
    -+struct stdin_pack_info {
    -+	struct packed_git *p;
    -+	enum {
    -+		STDIN_PACK_INCLUDE = (1<<0),
    -+		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
    -+	} kind;
    -+};
    -+
     +static void stdin_packs_add_pack_entries(struct strmap *packs,
     +					 struct rev_info *revs)
    -+{
    + {
    +-	struct strbuf buf = STRBUF_INIT;
    +-	struct string_list include_packs = STRING_LIST_INIT_DUP;
    +-	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
    +-	struct string_list_item *item = NULL;
    +-	struct packed_git *p;
     +	struct string_list keys = STRING_LIST_INIT_NODUP;
     +	struct string_list_item *item;
     +	struct hashmap_iter iter;
     +	struct strmap_entry *entry;
    -+
    + 
    +-	while (strbuf_getline(&buf, stdin) != EOF) {
    +-		if (!buf.len)
    +-			continue;
     +	strmap_for_each_entry(packs, &iter, entry) {
     +		struct stdin_pack_info *info = entry->value;
     +		if (!info->p)
     +			die(_("could not find pack '%s'"), entry->key);
    -+
    + 
    +-		if (*buf.buf == '^')
    +-			string_list_append(&exclude_packs, buf.buf + 1);
    +-		else
    +-			string_list_append(&include_packs, buf.buf);
    +-
    +-		strbuf_reset(&buf);
    +-	}
    +-
    +-	string_list_sort_u(&include_packs, 0);
    +-	string_list_sort_u(&exclude_packs, 0);
    +-
    +-	repo_for_each_pack(the_repository, p) {
    +-		const char *pack_name = pack_basename(p);
    +-
    +-		if ((item = string_list_lookup(&include_packs, pack_name))) {
    +-			if (exclude_promisor_objects && p->pack_promisor)
    +-				die(_("packfile %s is a promisor but --exclude-promisor-objects was given"), p->pack_name);
    +-			item->util = p;
    +-		}
    +-		if ((item = string_list_lookup(&exclude_packs, pack_name)))
    +-			item->util = p;
    +-	}
    +-
    +-	/*
    +-	 * Arguments we got on stdin may not even be packs. First
    +-	 * check that to avoid segfaulting later on in
    +-	 * e.g. pack_mtime_cmp(), excluded packs are handled below.
    +-	 *
    +-	 * Since we first parsed our STDIN and then sorted the input
    +-	 * lines the pack we error on will be whatever line happens to
    +-	 * sort first. This is lazy, it's enough that we report one
    +-	 * bad case here, we don't need to report the first/last one,
    +-	 * or all of them.
    +-	 */
    +-	for_each_string_list_item(item, &include_packs) {
    +-		struct packed_git *p = item->util;
    +-		if (!p)
    +-			die(_("could not find pack '%s'"), item->string);
    +-		if (!is_pack_valid(p))
    +-			die(_("packfile %s cannot be accessed"), p->pack_name);
    +-	}
    +-
    +-	/*
    +-	 * Then, handle all of the excluded packs, marking them as
    +-	 * kept in-core so that later calls to add_object_entry()
    +-	 * discards any objects that are also found in excluded packs.
    +-	 */
    +-	for_each_string_list_item(item, &exclude_packs) {
    +-		struct packed_git *p = item->util;
    +-		if (!p)
    +-			die(_("could not find pack '%s'"), item->string);
    +-		p->pack_keep_in_core = 1;
     +		string_list_append(&keys, entry->key)->util = info;
    -+	}
    -+
    -+	/*
    -+	 * Order packs by ascending mtime; use QSORT directly to access the
    -+	 * string_list_item's ->util pointer, which string_list_sort() does not
    -+	 * provide.
    -+	 */
    + 	}
    + 
    + 	/*
    +@@ builtin/pack-objects.c: static void read_packs_list_from_stdin(struct rev_info *revs)
    + 	 * string_list_item's ->util pointer, which string_list_sort() does not
    + 	 * provide.
    + 	 */
    +-	QSORT(include_packs.items, include_packs.nr, pack_mtime_cmp);
    +-
    +-	for_each_string_list_item(item, &include_packs) {
    +-		struct packed_git *p = item->util;
    +-		for_each_object_in_pack(p,
    +-					add_object_entry_from_pack,
    +-					revs,
    +-					ODB_FOR_EACH_OBJECT_PACK_ORDER);
     +	QSORT(keys.items, keys.nr, pack_mtime_cmp);
     +
     +	for_each_string_list_item(item, &keys) {
    @@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b
     +						add_object_entry_from_pack,
     +						revs,
     +						ODB_FOR_EACH_OBJECT_PACK_ORDER);
    -+	}
    -+
    + 	}
    + 
     +	string_list_clear(&keys, 0);
     +}
     +
     +static void stdin_packs_read_input(struct rev_info *revs)
    - {
    - 	struct strbuf buf = STRBUF_INIT;
    --	struct string_list include_packs = STRING_LIST_INIT_DUP;
    --	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
    --	struct string_list_item *item = NULL;
    ++{
    ++	struct strbuf buf = STRBUF_INIT;
     +	struct strmap packs = STRMAP_INIT;
    - 	struct packed_git *p;
    - 
    - 	while (strbuf_getline(&buf, stdin) != EOF) {
    --		if (!buf.len)
    ++	struct packed_git *p;
    ++
    ++	while (strbuf_getline(&buf, stdin) != EOF) {
     +		struct stdin_pack_info *info;
    ++		enum stdin_pack_info_kind kind = STDIN_PACK_INCLUDE;
     +		const char *key = buf.buf;
     +
     +		if (!*key)
    - 			continue;
    -+		if (*key == '^')
    ++			continue;
    ++		else if (*key == '^')
    ++			kind = STDIN_PACK_EXCLUDE_CLOSED;
    ++
    ++		if (kind != STDIN_PACK_INCLUDE)
     +			key++;
     +
     +		info = strmap_get(&packs, key);
    @@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b
     +			CALLOC_ARRAY(info, 1);
     +			strmap_put(&packs, key, info);
     +		}
    - 
    - 		if (*buf.buf == '^')
    --			string_list_append(&exclude_packs, buf.buf + 1);
    -+			info->kind |= STDIN_PACK_EXCLUDE_CLOSED;
    - 		else
    --			string_list_append(&include_packs, buf.buf);
    -+			info->kind |= STDIN_PACK_INCLUDE;
    - 
    - 		strbuf_reset(&buf);
    - 	}
    - 
    --	string_list_sort_u(&include_packs, 0);
    --	string_list_sort_u(&exclude_packs, 0);
    --
    - 	repo_for_each_pack(the_repository, p) {
    --		const char *pack_name = pack_basename(p);
    ++
    ++		info->kind |= kind;
    ++
    ++		strbuf_reset(&buf);
    ++	}
    ++
    ++	repo_for_each_pack(the_repository, p) {
     +		struct stdin_pack_info *info;
    - 
    --		if ((item = string_list_lookup(&include_packs, pack_name))) {
    ++
     +		info = strmap_get(&packs, pack_basename(p));
     +		if (!info)
     +			continue;
     +
     +		if (info->kind & STDIN_PACK_INCLUDE) {
    - 			if (exclude_promisor_objects && p->pack_promisor)
    - 				die(_("packfile %s is a promisor but --exclude-promisor-objects was given"), p->pack_name);
    --			item->util = p;
    ++			if (exclude_promisor_objects && p->pack_promisor)
    ++				die(_("packfile %s is a promisor but --exclude-promisor-objects was given"), p->pack_name);
     +
     +			/*
     +			 * Arguments we got on stdin may not even be
    @@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b
     +			 */
     +			if (!is_pack_valid(p))
     +				die(_("packfile %s cannot be accessed"), p->pack_name);
    - 		}
    --		if ((item = string_list_lookup(&exclude_packs, pack_name)))
    --			item->util = p;
    --	}
    - 
    --	/*
    --	 * Arguments we got on stdin may not even be packs. First
    --	 * check that to avoid segfaulting later on in
    --	 * e.g. pack_mtime_cmp(), excluded packs are handled below.
    --	 *
    --	 * Since we first parsed our STDIN and then sorted the input
    --	 * lines the pack we error on will be whatever line happens to
    --	 * sort first. This is lazy, it's enough that we report one
    --	 * bad case here, we don't need to report the first/last one,
    --	 * or all of them.
    --	 */
    --	for_each_string_list_item(item, &include_packs) {
    --		struct packed_git *p = item->util;
    --		if (!p)
    --			die(_("could not find pack '%s'"), item->string);
    --		if (!is_pack_valid(p))
    --			die(_("packfile %s cannot be accessed"), p->pack_name);
    --	}
    ++		}
    ++
     +		if (info->kind & STDIN_PACK_EXCLUDE_CLOSED) {
     +			/*
     +			 * Marking excluded packs as kept in-core so
    @@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b
     +			 */
     +			p->pack_keep_in_core = 1;
     +		}
    - 
    --	/*
    --	 * Then, handle all of the excluded packs, marking them as
    --	 * kept in-core so that later calls to add_object_entry()
    --	 * discards any objects that are also found in excluded packs.
    --	 */
    --	for_each_string_list_item(item, &exclude_packs) {
    --		struct packed_git *p = item->util;
    --		if (!p)
    --			die(_("could not find pack '%s'"), item->string);
    --		p->pack_keep_in_core = 1;
    ++
     +		info->p = p;
    - 	}
    - 
    --	/*
    --	 * Order packs by ascending mtime; use QSORT directly to access the
    --	 * string_list_item's ->util pointer, which string_list_sort() does not
    --	 * provide.
    --	 */
    --	QSORT(include_packs.items, include_packs.nr, pack_mtime_cmp);
    --
    --	for_each_string_list_item(item, &include_packs) {
    --		struct packed_git *p = item->util;
    --		for_each_object_in_pack(p,
    --					add_object_entry_from_pack,
    --					revs,
    --					ODB_FOR_EACH_OBJECT_PACK_ORDER);
    --	}
    ++	}
    ++
     +	stdin_packs_add_pack_entries(&packs, revs);
    - 
    ++
      	strbuf_release(&buf);
     -	string_list_clear(&include_packs, 0);
     -	string_list_clear(&exclude_packs, 0);
3:  d8f0577077c = 3:  5a5090f8da2 t7704: demonstrate failure with once-cruft objects above the geometric split
4:  e028dfbc9fb ! 4:  efba1ab93d8 pack-objects: support excluded-open packs with --stdin-packs
    @@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct objec
      	create_object_entry(oid, type, 0, 0, 0, p, ofs);
      
      	return 0;
    +@@ builtin/pack-objects.c: static void show_commit_pack_hint(struct commit *commit, void *data)
    +  *  - STDIN_PACK_EXCLUDE_CLOSED: objects in any packs with this flag
    +  *    bit set should be excluded from the output pack.
    +  *
    +- * Objects in packs whose 'kind' bits include STDIN_PACK_INCLUDE are
    +- * used as traversal tips when invoked with --stdin-packs=follow.
    ++ *  - STDIN_PACK_EXCLUDE_OPEN: objects in any packs with this flag
    ++ *    bit set should be excluded from the output pack, but are not
    ++ *    guaranteed to be closed under reachability.
    ++ *
    ++ * Objects in packs whose 'kind' bits include STDIN_PACK_INCLUDE or
    ++ * STDIN_PACK_EXCLUDE_OPEN are used as traversal tips when invoked
    ++ * with --stdin-packs=follow.
    +  */
    + enum stdin_pack_info_kind {
    + 	STDIN_PACK_INCLUDE = (1<<0),
    + 	STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
    ++	STDIN_PACK_EXCLUDE_OPEN = (1<<2),
    + };
    + 
    + struct stdin_pack_info {
     @@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b)
      		return 0;
      }
    @@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b
     +	return stdin_packs_include_check_obj((struct object *)commit, data);
     +}
     +
    - struct stdin_pack_info {
    - 	struct packed_git *p;
    - 	enum {
    - 		STDIN_PACK_INCLUDE = (1<<0),
    - 		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
    -+		STDIN_PACK_EXCLUDE_OPEN = (1<<2),
    - 	} kind;
    - };
    - 
    + static void stdin_packs_add_pack_entries(struct strmap *packs,
    + 					 struct rev_info *revs)
    + {
     @@ builtin/pack-objects.c: static void stdin_packs_add_pack_entries(struct strmap *packs,
      	for_each_string_list_item(item, &keys) {
      		struct stdin_pack_info *info = item->util;
    @@ builtin/pack-objects.c: static void stdin_packs_add_pack_entries(struct strmap *
      	struct strbuf buf = STRBUF_INIT;
      	struct strmap packs = STRMAP_INIT;
     @@ builtin/pack-objects.c: static void stdin_packs_read_input(struct rev_info *revs)
    - 
    - 		if (!*key)
      			continue;
    --		if (*key == '^')
    -+		if (*key == '^' ||
    -+		    (*key == '!' && mode == STDIN_PACKS_MODE_FOLLOW))
    + 		else if (*key == '^')
    + 			kind = STDIN_PACK_EXCLUDE_CLOSED;
    ++		else if (*key == '!' && mode == STDIN_PACKS_MODE_FOLLOW)
    ++			kind = STDIN_PACK_EXCLUDE_OPEN;
    + 
    + 		if (kind != STDIN_PACK_INCLUDE)
      			key++;
    - 
    - 		info = strmap_get(&packs, key);
    -@@ builtin/pack-objects.c: static void stdin_packs_read_input(struct rev_info *revs)
    - 
    - 		if (*buf.buf == '^')
    - 			info->kind |= STDIN_PACK_EXCLUDE_CLOSED;
    -+		else if (*buf.buf == '!' && mode == STDIN_PACKS_MODE_FOLLOW)
    -+			info->kind |= STDIN_PACK_EXCLUDE_OPEN;
    - 		else
    - 			info->kind |= STDIN_PACK_INCLUDE;
    - 
     @@ builtin/pack-objects.c: static void stdin_packs_read_input(struct rev_info *revs)
      			p->pack_keep_in_core = 1;
      		}
5:  23cb9f33dba = 5:  c9ad9a0c4ae repack: mark non-MIDX packs above the split as excluded-open

base-commit: 41688c1a2312f62f44435e1a6d03b4b904b5b0ec
-- 
2.53.0.724.gb20b077944a
