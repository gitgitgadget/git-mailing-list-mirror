Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF01DEFE8
	for <git@vger.kernel.org>; Thu, 29 May 2025 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748553654; cv=none; b=YWVxGpndQn/uI7yP/L36CsjDikC+oaragnHmMczh63SXH1g4bqnBGFe5aIrcNOOyBXSCJyZmYZruFwQ3hbRBX08NSk+m5i1j4dgDnzex1q3JVY24kaCWgsweZoICqWsrr4yT2V/PqmAVIv/CyBZaaF/ElfKbLzZhhJ8DpzoWHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748553654; c=relaxed/simple;
	bh=9sKODIe+p5wYyCVKx31+yaN7Thyzy0s5mdF4RjtkX4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC9hQiy0/xWActDLEszuqA4W8e6S467/fkuxPJTaaCiMZ9yQUGma804dYLyn2QlpI1PtrQe9OnhNQq45Oej8dRSzqB7rLBflOhYrvbLQp1f35l3Sg7/5GFBkWBViijFn5UWuYoXKA9mxXmWbQzNIJ9ncltKaPHwJQLJ0b4tY0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DnJwbjOf; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DnJwbjOf"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso1207099276.2
        for <git@vger.kernel.org>; Thu, 29 May 2025 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1748553651; x=1749158451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM8us/+OCqg+nlBUS2F6LjluXs/kFkc+UJH0CD09gWU=;
        b=DnJwbjOf1n5IEblOr0oUHgbOCTbaqE1pbsCn3CBvDGpogk/OJmrUR8Alrcq55Q43CA
         9cRLvp6q38QgE5tKBWtqESmvowr/jz7EYK7ig6/AjkqBtZXm56swNTIT7d9X/MeIAKTE
         UGJISB8Koe3+VKKDKsM+QNudB8IYuOLsYYuuTv3WJZRP84nkznrithewaK/NA17uJpEt
         dJDuxchP6t/20PpkjvhH3u1qMGOxLsQfeV0NRcEkSqcxvg99DoFq+zipP89LJqmZFw5/
         oEkmoeEG4XueLos4g65px130hJTCek6VD6UJ/SQMwKHgTibZRWm+wZcX4ai3Z6gaxbD6
         cTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748553651; x=1749158451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM8us/+OCqg+nlBUS2F6LjluXs/kFkc+UJH0CD09gWU=;
        b=E8BBkaBBGwMZRE6JEE5AFrs8N7JEKC0ZTCRmzyolxFAfL5mjcX6nyn6/I3hXlk9NkL
         VXNhlbmSWA+G/WIyiKy9ZrxKjc2iS1zu/wKd5cFkLwLpRxvUpA2BDuJgB6kf0/VPTQGy
         OxFyG6IJQJ8WQx2PKdHTPZO8b05K/WCct5VDt+pY2cx3gwjIBkI4EU5mTmTQzP0/RPCX
         beh3WieaNR9R4YnHWy7UAerogOUpTt2FsVXxWZjseBmgUu4md093Tv/IaFXssYcaJO4O
         pRsdVCUlJjS6VNo6K9QC1woPI2ytfR7hkEevAswgwp2lxXdr5j5lEsIXU8G53Q5zutwO
         2gMA==
X-Gm-Message-State: AOJu0YwB59Xx/EC89MPeO5GO/votSAAr5syhDp28SC/Y8RQix8ZnA93d
	pWURv18a+EEIWPh07HjzQAWMqXdWBa7Ig4FiC9XSBONaVw4u39qrPJgp5bqa6G0DEYU=
X-Gm-Gg: ASbGncu/3ARbcPoirKMTUKcOh56anZSpr4P6VBuj0aslC/Laj9xm1yvk2jn52sBOqiY
	RHnC7Iw0Leqe56TO5bulnyua/wjGW5qk+43qtQueMbteSkNRkUZqrPSd7jHyHUIKaMVo6NeNBEz
	nMqMCJVV8a0rFDlIlzk1LQZk+QB8LmATc28EY99qzTvRj9hfGCnf0Gqgui9Kuw+XllxrNdUL4Vs
	683bZsLCUm+kSIVsVvfEIQwmMqeGeZOMRJgqbXToERfz80j7kG1H5hqBdAZJ4ME9TluJlp96Tyl
	fEXW+kATdBJ4CiTON2m3m4YrSP27+TtV9F27Ar+TQXrfGmgixogpm5B6E9QSRy8JPIpemIHI/kf
	gQq7IidPJ8LQlFToDMGvrEkU=
X-Google-Smtp-Source: AGHT+IHbWZbcD4OtV1OMcPB/nQrilremJ0RdOJAdZa5ZvekUtavKKtK8dIMQ60mAn1+lax2jwn8qHA==
X-Received: by 2002:a05:6902:1547:b0:e7d:c9f4:ed81 with SMTP id 3f1490d57ef6-e7f81eea6b2mr1816755276.34.1748553650400;
        Thu, 29 May 2025 14:20:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e7f733cd118sm499301276.20.2025.05.29.14.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 14:20:50 -0700 (PDT)
Date: Thu, 29 May 2025 17:20:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v4 2/2] pack-bitmap: add load corrupt bitmap test
Message-ID: <aDjPsMqyYSm+b2Ap@nand.local>
References: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
 <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
 <7876d9a9014ea6a0657f440f7fa1efd496a4a15a.1748140983.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7876d9a9014ea6a0657f440f7fa1efd496a4a15a.1748140983.git.gitgitgadget@gmail.com>

On Sun, May 25, 2025 at 02:43:03AM +0000, Lidong Yan via GitGitGadget wrote:
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index fd19c2255163..39c1c1bc4ce1 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -34,6 +34,11 @@ struct stored_bitmap {
>  	int flags;
>  };
>
> +struct stored_bitmap_tag_pos {
> +	struct stored_bitmap stored;
> +	size_t map_pos;
> +};
> +

Hmm. I was expecting you to add a new member to the stored_bitmap
structure, not a new structure entirely. Let's read on...

>  /*
>   * The active bitmap index for a repository. By design, repositories only have
>   * a single bitmap index available (the index for the biggest packfile in
> @@ -148,6 +153,7 @@ static int existing_bitmaps_hits_nr;
>  static int existing_bitmaps_misses_nr;
>  static int roots_with_bitmaps_nr;
>  static int roots_without_bitmaps_nr;
> +static int tag_pos_on_bitmap;

Why are we only sometimes tagging bitmaps with their position?

>
>  static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
>  {
> @@ -314,13 +320,18 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
>  					  struct ewah_bitmap *root,
>  					  const struct object_id *oid,
>  					  struct stored_bitmap *xor_with,
> -					  int flags)
> +					  int flags, size_t map_pos)
>  {
>  	struct stored_bitmap *stored;
> +	struct stored_bitmap_tag_pos *tagged;

OK.

>  	khiter_t hash_pos;
>  	int ret;
>
> -	stored = xmalloc(sizeof(struct stored_bitmap));
> +	tagged = xmalloc(tag_pos_on_bitmap ? sizeof(struct stored_bitmap_tag_pos) :
> +					     sizeof(struct stored_bitmap));
> +	stored = &tagged->stored;
> +	if (tag_pos_on_bitmap)
> +		tagged->map_pos = map_pos;

I am quite worried about this portion of the diff.

Here you allocate memory for "tagged" which is a stored_bitmap_tag_pos.
But the amount of bytes you allocate depends on whether the global
variable tag_pos_on_bitmap is set or not. If it isn't, then you don't
allocate enough memory here to hold an entire stored_bitmap_tag_pos
structure.

I think within this function you're OK, since you only write into that
field when tag_pos_on_bitmap is set. But this seems like a recipe for
disaster if you ever try to read or write into the tagged->map_pos field
when tag_pos_on_bitmap *isn't* set.

This happens to work because of where the pointer to the stored_bitmap
structure lives within the stored_bitmap_tag_pos structure. But this
seems *extremely* fragile to only save 4 bytes of allocated memory per
bitmap. Even on a repository with ~1,000 bitmaps (which is rare from my
experience), you're only saving ~3.91 KiB.

I would expect something more like the following (based on top of your
patch here):

--- 8< ---
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 39c1c1bc4c..4c3829dba9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -31,12 +31,8 @@ struct stored_bitmap {
 	struct object_id oid;
 	struct ewah_bitmap *root;
 	struct stored_bitmap *xor;
-	int flags;
-};
-
-struct stored_bitmap_tag_pos {
-	struct stored_bitmap stored;
 	size_t map_pos;
+	int flags;
 };

 /*
@@ -153,7 +149,6 @@ static int existing_bitmaps_hits_nr;
 static int existing_bitmaps_misses_nr;
 static int roots_with_bitmaps_nr;
 static int roots_without_bitmaps_nr;
-static int tag_pos_on_bitmap;

 static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
 {
@@ -323,17 +318,13 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 					  int flags, size_t map_pos)
 {
 	struct stored_bitmap *stored;
-	struct stored_bitmap_tag_pos *tagged;
 	khiter_t hash_pos;
 	int ret;

-	tagged = xmalloc(tag_pos_on_bitmap ? sizeof(struct stored_bitmap_tag_pos) :
-					     sizeof(struct stored_bitmap));
-	stored = &tagged->stored;
-	if (tag_pos_on_bitmap)
-		tagged->map_pos = map_pos;
+	stored = xmalloc(sizeof(struct stored_bitmap));
 	stored->root = root;
 	stored->xor = xor_with;
+	stored->map_pos = map_pos;
 	stored->flags = flags;
 	oidcpy(&stored->oid, oid);

@@ -2878,12 +2869,11 @@ int test_bitmap_commits(struct repository *r)
 int test_bitmap_commits_offset(struct repository *r)
 {
 	struct object_id oid;
-	struct stored_bitmap_tag_pos *tagged;
+	struct stored_bitmap *bitmap;
 	struct bitmap_index *bitmap_git;
 	size_t commit_idx_pos_map_pos, xor_offset_map_pos, flag_map_pos,
 		ewah_bitmap_map_pos;

-	tag_pos_on_bitmap = 1;
 	bitmap_git = prepare_bitmap_git(r);
 	if (!bitmap_git)
 		die(_("failed to load bitmap indexes"));
@@ -2897,9 +2887,9 @@ int test_bitmap_commits_offset(struct repository *r)
 			die(_("failed to load bitmap indexes"));
 	}

-	kh_foreach (bitmap_git->bitmaps, oid, tagged, {
-		commit_idx_pos_map_pos = tagged->map_pos;
-		xor_offset_map_pos = tagged->map_pos + sizeof(uint32_t);
+	kh_foreach (bitmap_git->bitmaps, oid, bitmap, {
+		commit_idx_pos_map_pos = bitmap->map_pos;
+		xor_offset_map_pos = bitmap->map_pos + sizeof(uint32_t);
 		flag_map_pos = xor_offset_map_pos + sizeof(uint8_t);
 		ewah_bitmap_map_pos = flag_map_pos + sizeof(uint8_t);
--- >8 ---

>  	stored->root = root;
>  	stored->xor = xor_with;
>  	stored->flags = flags;
> @@ -376,10 +387,12 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
>  		struct stored_bitmap *xor_bitmap = NULL;
>  		uint32_t commit_idx_pos;
>  		struct object_id oid;
> +		size_t entry_map_pos;
>
>  		if (index->map_size - index->map_pos < 6)
>  			return error(_("corrupt ewah bitmap: truncated header for entry %d"), i);
>
> +		entry_map_pos = index->map_pos;

Good. This is important since the read_be32() and read_u8() calls below
both adjust the value of index->map_pos past the beginning of the bitmap.

> @@ -869,6 +883,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>  	int xor_flags;
>  	khiter_t hash_pos;
>  	struct bitmap_lookup_table_xor_item *xor_item;
> +	size_t entry_map_pos;
>
>  	if (is_corrupt)
>  		return NULL;
> @@ -928,6 +943,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>  			goto corrupt;
>  		}
>
> +		entry_map_pos = bitmap_git->map_pos;

Same here.

> @@ -969,6 +986,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>  	 * Instead, we can skip ahead and immediately read the flags and
>  	 * ewah bitmap.
>  	 */
> +	entry_map_pos = bitmap_git->map_pos;

And here.

> +int test_bitmap_commits_offset(struct repository *r)
> +{
> +	struct object_id oid;
> +	struct stored_bitmap_tag_pos *tagged;
> +	struct bitmap_index *bitmap_git;
> +	size_t commit_idx_pos_map_pos, xor_offset_map_pos, flag_map_pos,
> +		ewah_bitmap_map_pos;
> +
> +	tag_pos_on_bitmap = 1;
> +	bitmap_git = prepare_bitmap_git(r);
> +	if (!bitmap_git)
> +		die(_("failed to load bitmap indexes"));
> +

If we either forgot to set this variable here or did so after calling
prepare_bitmap_git(), then we wouldn't allocate enough memory to store
the map_pos field in the stored_bitmap_tag_pos structure. When we then
would try and read that field below, we'd read garbage heap data outside
of our structure.

> +	/*
> +	 * As this function is only used to print bitmap selected
> +	 * commits, we don't have to read the commit table.
> +	 */
> +	if (bitmap_git->table_lookup) {
> +		if (load_bitmap_entries_v1(bitmap_git) < 0)
> +			die(_("failed to load bitmap indexes"));
> +	}

This comment suggests that we can avoid reading the commit table
altogether. Indeed, calling load_bitmap_entries_v1() here does that,
since it is not called when loading a bitmap that has a lookup table.

So I think the behavior here is correct, but the comment is misleading.
I suspect that the confusion would be resolved by instead writing:

    /*
     * Since this function needs to know the position of each individual
     * bitmap, bypass the commit lookup table (if one exists) by forcing
     * the bitmap to eagerly load its entries.
     */

I think this is copy-and-paste from 28cd730680 (pack-bitmap: prepare to
read lookup table extension, 2022-08-14) via the 'test_bitmap_commits()'
function immediately above this one. I think both would benefit from
some clean-up, since this comment is equally misleading in that
function.

For your purposes, I would either:

 - remove or (preferably) reword the comment in your new function,
   leaving the one in test_bitmap_commits() as-is, or

 - reword the comment in test_bitmap_commits() to be more like the one
   above, via a preparatory commit, and then introduce the new function
   using the same wording.

Between the two, I think the latter is preferable.

As an aside, I think that for bitmaps that do have a commit lookup
table, you could go slightly faster here by walking over that portion of
the *.bitmap file, since it directly encodes the information you're
interested in here. But I would avoid doing that, since it too seems
brittle and I would like to avoid having two separate spots that each
implement reading the commit table format.

> +	kh_foreach (bitmap_git->bitmaps, oid, tagged, {
> +		commit_idx_pos_map_pos = tagged->map_pos;

OK, and here's where we pull out the actual position of the selected
commit's bitmap.

> +		xor_offset_map_pos = tagged->map_pos + sizeof(uint32_t);
> +		flag_map_pos = xor_offset_map_pos + sizeof(uint8_t);
> +		ewah_bitmap_map_pos = flag_map_pos + sizeof(uint8_t);
> +
> +		printf_ln("%s %"PRIuMAX" %"PRIuMAX" %"PRIuMAX" %"PRIuMAX,
> +			  oid_to_hex(&oid),
> +			  (uintmax_t)commit_idx_pos_map_pos,
> +			  (uintmax_t)xor_offset_map_pos,
> +			  (uintmax_t)flag_map_pos,
> +			  (uintmax_t)ewah_bitmap_map_pos);

Hmm. We print more information here than just the map_pos. This is
brittle if the on-disk format changes (e.g., to store the XOR offsets in
some other part of the bitmap). But hopefully future updates to the
bitmap format will come with updates to this function as well ;-).

It feels somewhat unsatisfying to print output like:

    $COMMIT_OID <map_pos> <map_pos+4> <map_pos+5> <map_pos+6>

, but I think it makes sense here for a couple of reasons:

 - If we just print the <map_pos>, then the test is responsible for
   knowing the distance between that and the XOR offset, which extends
   the brittleness to the test code

 - likewise, if we print out just the map_pos and the positions of the
   XOR offset, it feels strange to omit the others.

> diff --git a/pack-bitmap.h b/pack-bitmap.h
> index 382d39499af2..96880ba3d72d 100644
> --- a/pack-bitmap.h
> +++ b/pack-bitmap.h
> @@ -81,6 +81,7 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
>  				 show_reachable_fn show_reachable);
>  void test_bitmap_walk(struct rev_info *revs);
>  int test_bitmap_commits(struct repository *r);
> +int test_bitmap_commits_offset(struct repository *r);
>  int test_bitmap_hashes(struct repository *r);
>  int test_bitmap_pseudo_merges(struct repository *r);
>  int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
> diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
> index 3f23f2107268..65a1ab29192b 100644
> --- a/t/helper/test-bitmap.c
> +++ b/t/helper/test-bitmap.c
> @@ -10,6 +10,11 @@ static int bitmap_list_commits(void)
>  	return test_bitmap_commits(the_repository);
>  }
>
> +static int bitmap_list_commits_offset(void)
> +{
> +	return test_bitmap_commits_offset(the_repository);
> +}
> +
>  static int bitmap_dump_hashes(void)
>  {
>  	return test_bitmap_hashes(the_repository);
> @@ -36,6 +41,8 @@ int cmd__bitmap(int argc, const char **argv)
>
>  	if (argc == 2 && !strcmp(argv[1], "list-commits"))
>  		return bitmap_list_commits();
> +	if (argc == 2 && !strcmp(argv[1], "list-commits-offset"))
> +		return bitmap_list_commits_offset();

All of the scaffolding here looks good.

This new mode reads a little awkwardly to me (but may not to others, in
which case I am happy to back away from the following suggestion). Can
we either call this 'list-commits-with-offset' or 'list-commit-offsets'?
I have a vague preference towards the former since the new mode has a
string prefix matching the existing mode.

> +	test_expect_success 'load corrupt bitmap' '
> +		rm -fr repo &&
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
> +
> +			test_commit base &&
> +
> +			git repack -adb &&
> +			bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
> +			chmod +w $bitmap &&
> +
> +			read oid commit_off xor_off flag_off ewah_off <<-EOF &&
> +				$(test-tool bitmap list-commits-offset | head -n 1)

We avoid putting 'git' or 'test-tool' on the left-hand side of a pipe,
since we want to avoid squelching any errors / segfaults from our code.

How about (assuming the rename above):

    test-tool bitmap list-commit-offsets >offsets &&
    xor_off="$(head -n1 offsets | awk '{print $3}')" &&
    ...

?

> +			printf '\161' |
> +				dd of=$bitmap count=1 bs=1 conv=notrunc seek=$xor_off &&
> +
> +
> +			git rev-list --count HEAD > expect &&
> +			git rev-list --use-bitmap-index --count HEAD > actual &&

Using --count can mask failures in the bitmap code since it only guards
you against getting the wrong number of objects, but doesn't guard you
against getting the right amount of objects in a permuted order. I think
we'd want just 'git rev-list --objects' here, but note that you have to
use '--no-object-names' on the non-bitmap side, since rev-list does not
print out paths when using bitmaps[^1].

How about:

    git rev-list --objects --no-object-names HEAD >expect.raw &&
    git rev-list --objects --use-bitmap-index --no-object-names HEAD \
      >actual.raw &&

    sort expect.raw >expect &&
    sort actual.raw >actual &&

    test_cmp expect actual

(Note that you also have to sort the output here since rev-list does not
output objects in a meaningful order when using bitmaps.)

Thanks,
Taylor

[^1]: Not that it matters here since we don't expect to load the bitmap
  anyway, but it's worth doing regardless.
