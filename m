Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FFF1DE8AF
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774482706; cv=none; b=Z6RfgiaQVAf+2GZDmSDmHTEPLycueDqRUMVSJ3ACxZXgJ13j2rA7g5KbRQ4CHr2XCLrXWMhj38lfh1MM6NlgSLkgbKOp0CZgbf1dvzdir+Jity0QDzN9ELukuhQe22gs5ipI9L7FAGQg+zvN1vlhFGGmxPX+k6e3rbp1J5RmQ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774482706; c=relaxed/simple;
	bh=ipDybZz67YF1DlTpxPSVaIn08qY5FlsnYpzzJfkIC3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpQUKZrca/txDZZ4cMMLuPpEIGJVnluuxrKKuGIrYQ7jRHuelHptFr+nNmuAyoPzib/qYtMNUvvjRfXnSEDYSbLbamiCFvo8NUZOS6WROTiqH7pc0tW4ay/nXl6kP6PLh3tqqY/0r7lEZ3wukPNNtrDcgB+UZkkBz+ovhM1+j6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FPIXfV/m; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FPIXfV/m"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-64ae222d87dso440991d50.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774482704; x=1775087504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZYV9vYmJECjb0clZsBnLGLnni78dkyemOeiWC1nTaM=;
        b=FPIXfV/mt76dM9Jj2v4RpnpCmJcHSumo73h6r+qwTTNM+FxYNIoox7zuKCsdFmvoCn
         WHyu/yRMv9oK0kZrrvNuv/NRKlIRXwZqgTluGXCVq7ZAsNV1ni+3qWC92vUYLRw0f71y
         sQXWqXc9tNDgTFQrYdpJNeU6mSE5CtmhITYmlkx/92pKCGv+YEN/89h+tDmjKied8I9N
         aki6tgp7YHMVlQNfM0iiOhVZt5r5pg0wIE9AJx+tme/mTuODJLuRkRVcPzFls8YU9uOs
         hv1BSwRB4pd2pmOTVhQdBSqeb4oAhX3wpf+pW8iJ25s8CwF48WeWG8PvrdXHDpir0Wsm
         3E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774482704; x=1775087504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZYV9vYmJECjb0clZsBnLGLnni78dkyemOeiWC1nTaM=;
        b=alZmPyLZHMyee2fvFykAU6QrIBrnFKIbfbBvX6oeomd5rcbuHktow7iLSf+grm3ITR
         UGqBx9/UDELPqd4RAFHtpRWPXwzA4M9kNanwKJavvvWtTNFMSuTNDqw4a3cUnBjMR5Ac
         ysGS8hm/Yhxi/9qFJDMWOVx4guy3IR+2DJMr7dUomPs+6/buDwPLiXWITroVCgW8xq0R
         UtssBIEOoBy3ykQWCRomyuF+6E3GWEsZgFBDPKjF/ynyTaYBQO7qgHtkw9Dv/sKYeuqE
         Sn+rh4Uce2uAM9Q/NzRDUaJzEGa71uuEWHO7LYW1AKuoYfkqnuyVFIdEP4Q1HAxK31xO
         +gYA==
X-Gm-Message-State: AOJu0YxfGvqA6Vb5i0O47shG7Wh7DNluPmXfWX9kHrcUGhq5ZTrQNmpZ
	aKHhlLtIUh4Ztd1ZYkolgqe/RRXSvKtsAtLHTY/fr98n7yCtXq4uQjiaIoWT1UgYUFIJmstj/qX
	fR4FfpUxwvwfI
X-Gm-Gg: ATEYQzzNF5ZPf0vyMe3LuYovZgfc/819nRtuueKRKFNp8vnAhDn2QlZQVqerujM1Jlj
	U1V28Ca7pJsgDelibGaRPjj1UQPOrxwaaRHMUumCZxC1gqfjR+vP2cjPnYeY1ws+UtbIkDwhG5x
	7NwGkIOCHZ8kaeVVrpGlUMEnt25Q99u8KHHPsHhe3piIqS5cVK0SWQWHG1wi1zdUCVYsVWO3+Zq
	qoUH332FiJAa3LjSXvMHsf36QueqNYqBx4GCRiuIi4giT9X94oMtg+LfWNohL9VYyyRK1bO30GI
	rnCumuyqJEc2q0kXNroqx+YBoY+ZRjCsbGPEgXi5xocpmxtRQFCmpmg/IGjRYhSMhZQsH/N8aBZ
	EybaeetySYYO9Lsmc8ZPT077ci9syS4dEgzMGkMD08MnqISvUlBTPpEdUuOfuoCU1I8hwBPXQB0
	v4NKp44Xz+xzNuPyW7fHgX0WmetsvhJns6tV7kTgXzJLipxFF0kTGkJmnjL7XNmPRb84j+kI65d
	yIKkCyzyTJSoksLYe3xxxB/2XbJiyqmoveZMOJr
X-Received: by 2002:a05:690e:4199:b0:64c:e890:fbb9 with SMTP id 956f58d0204a3-64ee609da58mr5043125d50.20.1774482703958;
        Wed, 25 Mar 2026 16:51:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64ef57bf895sm721525d50.2.2026.03.25.16.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 16:51:43 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:51:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] pack-objects: handle excluded-but-open packs via
 `--stdin-packs=follow`
Message-ID: <cover.1774482700.git.me@ttaylorr.com>
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

This is a small reroll of my series to fix an issue where MIDX bitmaps
fail to generate after a geometric repack in certain scenarios where the
set of MIDX'd objects is not closed under reachability.

The main changes since last time are:

 * Clarification in the first patch that the added `release_revisions()`
   call prevents a *potential* leak, not an actual one.

 * Cleanup in the second patch (where we convert the --stdin-packs
   handling to use a strmap) based on Patrick's review.

 * Dropped an unnecessary "if (p)" conditional in the fourth patch's
   `add_object_entry_from_pack()` callback that is unnecessary.

Otherwise, the series is unchanged from the original round. As usual, a
range-diff is included below for convenience.

Thanks again for your review!

Taylor Blau (5):
  pack-objects: plug leak in `read_stdin_packs()`
  pack-objects: refactor `read_packs_list_from_stdin()` to use `strmap`
  t7704: demonstrate failure with once-cruft objects above the geometric
    split
  pack-objects: support excluded-open packs with --stdin-packs
  repack: mark non-MIDX packs above the split as excluded-open

 Documentation/git-pack-objects.adoc |  25 ++-
 builtin/pack-objects.c              | 254 +++++++++++++++++++---------
 builtin/repack.c                    |  19 ++-
 packfile.c                          |   3 +-
 packfile.h                          |   2 +
 t/t5331-pack-objects-stdin.sh       | 105 ++++++++++++
 t/t7704-repack-cruft.sh             |  22 +++
 7 files changed, 339 insertions(+), 91 deletions(-)

Range-diff against v1:
1:  1dac74f1e4a ! 1:  1fabd88f5e3 pack-objects: plug leak in `read_stdin_packs()`
    @@ Commit message
         The `read_stdin_packs()` function added originally via 339bce27f4f
         (builtin/pack-objects.c: add '--stdin-packs' option, 2021-02-22)
         declares a `rev_info` struct but neglects to call `release_revisions()`
    -    on it before returning, creating a leak.
    +    on it before returning, creating the potential for a leak.
     
         The related change in 97ec43247c0 (pack-objects: declare 'rev_info' for
         '--stdin-packs' earlier, 2025-06-23) carried forward this oversight and
         did not address it.
     
         Ensure that we call `release_revisions()` appropriately to prevent a
    -    leak from this function.
    +    potential leak from this function. Note that in practice our `rev_info`
    +    here does not have a present leak, hence t5331 passes cleanly before
    +    this commit, even when built with SANITIZE=leak.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
2:  ea6fdbcc46f ! 2:  d5cb793f0eb pack-objects: refactor `read_packs_list_from_stdin()` to use `strmap`
    @@ Commit message
         excluded.
     
         Extract the logic for sorting packs by mtime and adding their objects
    -    into a separate `stdin_packs_add_entries()` helper.
    +    into a separate `stdin_packs_add_pack_entries()` helper.
     
         While we could have used a `string_list`, we must handle the case where
         the same pack is specified more than once. With a `string_list` only, we
    @@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b
     +		if (!info->p)
     +			die(_("could not find pack '%s'"), entry->key);
     +
    -+		string_list_append(&keys, entry->key)->util = info->p;
    ++		string_list_append(&keys, entry->key)->util = info;
     +	}
     +
     +	/*
    @@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b
     +	QSORT(keys.items, keys.nr, pack_mtime_cmp);
     +
     +	for_each_string_list_item(item, &keys) {
    -+		struct stdin_pack_info *info = strmap_get(packs, item->string);
    -+		if (!info->p)
    -+			die(_("could not find pack '%s'"), item->string);
    ++		struct stdin_pack_info *info = item->util;
     +
     +		if (info->kind & STDIN_PACK_INCLUDE)
     +			for_each_object_in_pack(info->p,
    @@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b
     +		struct stdin_pack_info *info;
     +		const char *key = buf.buf;
     +
    -+		if (!key || !*key)
    ++		if (!*key)
      			continue;
    - 
     +		if (*key == '^')
     +			key++;
     +
    @@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b
     +			CALLOC_ARRAY(info, 1);
     +			strmap_put(&packs, key, info);
     +		}
    -+
    + 
      		if (*buf.buf == '^')
     -			string_list_append(&exclude_packs, buf.buf + 1);
     +			info->kind |= STDIN_PACK_EXCLUDE_CLOSED;
3:  0ec9bba92ad = 3:  d8f0577077c t7704: demonstrate failure with once-cruft objects above the geometric split
4:  bd78919e19c ! 4:  e028dfbc9fb pack-objects: support excluded-open packs with --stdin-packs
    @@ Commit message
         In `add_object_entry_from_pack()`, move the `want_object_in_pack()`
         check to *after* `add_pending_oid()`. This is necessary so that commits
         from excluded-open packs are added as traversal tips even though their
    -    objects won't appear in the output. The `include_check` and
    -    `include_check_obj` callbacks on `rev_info` are used to halt the walk at
    -    closed-excluded packs, since objects behind a '^' boundary are
    -    guaranteed to have closure and need not be rescued.
    +    objects won't appear in the output. As a consequence, the caller
    +    `for_each_object_in_pack()` will always provide a non-NULL 'p', hence we
    +    are able to drop the "if (p)" conditional.
    +
    +    The `include_check` and `include_check_obj` callbacks on `rev_info` are
    +    used to halt the walk at closed-excluded packs, since objects behind a
    +    '^' boundary are guaranteed to have closure and need not be rescued.
     
         The following commit will make use of this new functionality within the
         repack layer to resolve the test failure demonstrated in the previous
    @@ builtin/pack-objects.c: static int want_found_object(const struct object_id *oid
      				return 0;
      		} else {
     @@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct object_id *oid,
    + 				      void *_data)
    + {
    + 	off_t ofs;
    ++	struct object_info oi = OBJECT_INFO_INIT;
    + 	enum object_type type = OBJ_NONE;
    + 
    + 	display_progress(progress_state, ++nr_seen);
    +@@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct object_id *oid,
    + 	if (have_duplicate_entry(oid, 0))
      		return 0;
      
    ++	stdin_packs_found_nr++;
    ++
      	ofs = nth_packed_object_offset(p, pos);
    --	if (!want_object_in_pack(oid, 0, &p, &ofs))
    --		return 0;
    ++
    ++	oi.typep = &type;
    ++	if (packed_object_info(p, ofs, &oi) < 0) {
    ++		die(_("could not get type of object %s in pack %s"),
    ++		    oid_to_hex(oid), p->pack_name);
    ++	} else if (type == OBJ_COMMIT) {
    ++		struct rev_info *revs = _data;
    ++		/*
    ++		 * commits in included packs are used as starting points
    ++		 * for the subsequent revision walk
    ++		 *
    ++		 * Note that we do want to walk through commits that are
    ++		 * present in excluded-open ('!') packs to pick up any
    ++		 * objects reachable from them not present in the
    ++		 * excluded-closed ('^') packs.
    ++		 *
    ++		 * However, we'll only add those objects to the packing
    ++		 * list after checking `want_object_in_pack()` below.
    ++		 */
    ++		add_pending_oid(revs, NULL, oid, 0);
    ++	}
    ++
    + 	if (!want_object_in_pack(oid, 0, &p, &ofs))
    + 		return 0;
      
    - 	if (p) {
    - 		struct object_info oi = OBJECT_INFO_INIT;
    -@@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct object_id *oid,
    - 		} else if (type == OBJ_COMMIT) {
    - 			struct rev_info *revs = _data;
    - 			/*
    +-	if (p) {
    +-		struct object_info oi = OBJECT_INFO_INIT;
    +-
    +-		oi.typep = &type;
    +-		if (packed_object_info(p, ofs, &oi) < 0) {
    +-			die(_("could not get type of object %s in pack %s"),
    +-			    oid_to_hex(oid), p->pack_name);
    +-		} else if (type == OBJ_COMMIT) {
    +-			struct rev_info *revs = _data;
    +-			/*
     -			 * commits in included packs are used as starting points for the
     -			 * subsequent revision walk
    -+			 * commits in included packs are used as starting points
    -+			 * for the subsequent revision walk
    -+			 *
    -+			 * Note that we do want to walk through commits that are
    -+			 * present in excluded-open ('!') packs to pick up any
    -+			 * objects reachable from them not present in the
    -+			 * excluded-closed ('^') packs.
    -+			 *
    -+			 * However, we'll only add those objects to the packing
    -+			 * list after checking `want_object_in_pack()` below.
    - 			 */
    - 			add_pending_oid(revs, NULL, oid, 0);
    - 		}
    +-			 */
    +-			add_pending_oid(revs, NULL, oid, 0);
    +-		}
     -
     -		stdin_packs_found_nr++;
    - 	}
    - 
    -+	if (!want_object_in_pack(oid, 0, &p, &ofs))
    -+		return 0;
    -+
    -+	stdin_packs_found_nr++;
    -+
    +-	}
    +-
      	create_object_entry(oid, type, 0, 0, 0, p, ofs);
      
      	return 0;
    @@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b
      };
      
     @@ builtin/pack-objects.c: static void stdin_packs_add_pack_entries(struct strmap *packs,
    - 		if (!info->p)
    - 			die(_("could not find pack '%s'"), item->string);
    + 	for_each_string_list_item(item, &keys) {
    + 		struct stdin_pack_info *info = item->util;
      
     -		if (info->kind & STDIN_PACK_INCLUDE)
     +		if (info->kind & STDIN_PACK_EXCLUDE_OPEN) {
    @@ builtin/pack-objects.c: static void stdin_packs_add_pack_entries(struct strmap *
      	struct strbuf buf = STRBUF_INIT;
      	struct strmap packs = STRMAP_INIT;
     @@ builtin/pack-objects.c: static void stdin_packs_read_input(struct rev_info *revs)
    - 		if (!key || !*key)
    + 
    + 		if (!*key)
      			continue;
    - 
     -		if (*key == '^')
     +		if (*key == '^' ||
     +		    (*key == '!' && mode == STDIN_PACKS_MODE_FOLLOW))
5:  c4fd52e751a = 5:  23cb9f33dba repack: mark non-MIDX packs above the split as excluded-open

base-commit: 7ff1e8dc1e1680510c96e69965b3fa81372c5037
-- 
2.53.0.614.g164f3b634ec
