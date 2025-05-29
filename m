Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F61362
	for <git@vger.kernel.org>; Thu, 29 May 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533545; cv=none; b=msbCQszGzqmfAK76aUgAkWcourNoxrCS6Jzv+sqbgKDy6NU/Ld0hecWtz+RqHwfpOMmpgHsqz/ZrK5qjXpRkrLAncXEsHzR+DNDJDFYwaEqRSHXb54vpwE2lzJPDrCzXywfzwMZY8Vx7gJBRb1TrSQuMi0ePP2kCni4iCShG7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533545; c=relaxed/simple;
	bh=ymZtr+rqosBlzSe7zFLrgIbkv+DP0ZL0byFnKqtz5kI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ke5ec4Lc31zt/WA1in9Ca9YH5FBKIO2AD/99btzpp3T9/kMnEHugNdWwbP9zqo+myOSUJyjEJQueqT4/7Q4W7rB4QOYADMCnXnq922sXg449o8nzy+Fv/iCkqYXhkV91qg60ybXlVnMaPAwS7UwccSfNwvO4BvkLJZ11bEPz60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1SChe/ET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cUmTKp0/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1SChe/ET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cUmTKp0/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4231C1380342;
	Thu, 29 May 2025 11:45:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 29 May 2025 11:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748533542; x=1748619942; bh=rU74qWoLAw
	gRCIOTFWY6U9mMGUqscDrCcXhd0AjIyb0=; b=1SChe/ETECZ05RhRyfpNgLc/NQ
	9eYpBxOm0SSNlR7btE8Y4/LceIFD4sTYShoNMt/1C3yUe6fxEV4q4Ofp33tMpLnn
	N1Ap4a6DsQi2wvZqYqXUynde9L2zeiZmsjkInqeQVKGngi/UDwc9In9PJKOQr/8I
	PNKYj69CFKNOXK4zHOi25zLCwzVBNX24yOfgwkHh2QsLr8xM1Op4o1m1HIsTQOLu
	/Hu9uUeiX04tv3SRWHtrb6uQjYhazgueqhHwG8YTf+Dc4/C7t44ujpv9vFfGiZNw
	KUJJZAJ5bzDhIXdp1F03TAtuOHCzHPSXZ8Rn2m7M318UrAnG5gcjcnCE5Sjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748533542; x=1748619942; bh=rU74qWoLAwgRCIOTFWY6U9mMGUqscDrCcXh
	d0AjIyb0=; b=cUmTKp0/hCtpJipWr8+sLy41xPomeqNfDrnaxDDHiFPKgEHuOPN
	V0CrVP356SHnq8nGrXdFFtfvSvAYcOygMJBRuRZA5Hu4MmqIv5wMcMHXwa9h8EK1
	++Dh7nlxiakVV2+i/2pzVycjdUGDG8FjyiQ+5x7tRM5pP+aNwcwi38G82Kz6rxuJ
	H1eMUQ7F1Ow06LCgrwnwTj4ewmoQvM1EAN6MSl64Fx6yc5xRBeWmnovKnDvfFLYB
	/lMWzqqLVP2bVeLAAsm+NgMMl18pM9NnNylMy1+lAJgKXKe/enyp0iX34nxYlPdZ
	8durn2hILv6ytbF4adjuG5kfIknbNsRRvFw==
X-ME-Sender: <xms:JYE4aGhYKwRM3JHknlk4YWk9gyAGJYQ5OG8-g__Q4voyni0aHmOGGA>
    <xme:JYE4aHAwuK-8PQB0mtfoWrvuQR0JK6hu41x6BWWua0VnizAVAg_0RYf1hW9C0RxJl
    TASPKN2CRoQ51gXzQ>
X-ME-Received: <xmr:JYE4aOGXkQsiE9PUms5WCT7qDgo1fRhInX6SWpt80rI6e4zTSUOnLAsH4QC60XH4Qd5_9NGr2Fark1chqGZeBkS6HtcbvX3zqQJ6j34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieehvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    hedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JYE4aPQ8wSGK61a9i6mtmx99egfbViJYk8_jK_UKGNoZo5tkZ6Zeuw>
    <xmx:JYE4aDzwPQFUt8-LcP7KQe3UR5EhZVgakUr0z7wisy5gVXa_1i4K8A>
    <xmx:JYE4aN7Nay2M1DaFNs1-xQcwFxmRe7x__y0gYLGG0MK8P4ZyxstZkA>
    <xmx:JYE4aAytIfErAV0mgzbmj3RrICYvpptOVfSFAxq9rkiNdQkfEwC2Zw>
    <xmx:JoE4aN74CSkU7Nc8_9AuMmxFEV5W2z-TZO4iga3Qrs5tK_LqvEYM23qF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 11:45:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v4 2/2] pack-bitmap: add load corrupt bitmap test
In-Reply-To: <7876d9a9014ea6a0657f440f7fa1efd496a4a15a.1748140983.git.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Sun, 25 May 2025 02:43:03
	+0000")
References: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
	<pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
	<7876d9a9014ea6a0657f440f7fa1efd496a4a15a.1748140983.git.gitgitgadget@gmail.com>
Date: Thu, 29 May 2025 08:45:40 -0700
Message-ID: <xmqqbjrbmndn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> This patch add test_bitmap_list_commits_offset() in patch-bitmap.c,

"pack-bitmap.c"?

> a new test helper command `test-tool bitmap list-commits-offset`,
> and a `load corrupt bitmap` test case in t5310.
>
> The `load corrupt bitmap` test case intentionally corrupt the
> "xor_offset" field of the first entry. And the newly added helper
> can help to find position of "xor_offset" in bitmap file.

[the structure of a log message]

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so".

in this order.

The proposed log message lacks the motivation and only talks about
what the patch does.  We add a test-only code in a file, intermixed
with production code.  Let's explain why it is the best arrangement.

> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>  pack-bitmap.c           | 73 +++++++++++++++++++++++++++++++++++++----
>  pack-bitmap.h           |  1 +
>  t/helper/test-bitmap.c  |  8 +++++
>  t/t5310-pack-bitmaps.sh | 27 +++++++++++++++
>  4 files changed, 103 insertions(+), 6 deletions(-)

After the second round of the series, no review comments seem to
have been sent to the list.  Is everybody happy with the latest
iteration?

Thanks.

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
>  /*
>   * The active bitmap index for a repository. By design, repositories only have
>   * a single bitmap index available (the index for the biggest packfile in
> @@ -148,6 +153,7 @@ static int existing_bitmaps_hits_nr;
>  static int existing_bitmaps_misses_nr;
>  static int roots_with_bitmaps_nr;
>  static int roots_without_bitmaps_nr;
> +static int tag_pos_on_bitmap;
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
>  	khiter_t hash_pos;
>  	int ret;
>  
> -	stored = xmalloc(sizeof(struct stored_bitmap));
> +	tagged = xmalloc(tag_pos_on_bitmap ? sizeof(struct stored_bitmap_tag_pos) :
> +					     sizeof(struct stored_bitmap));
> +	stored = &tagged->stored;
> +	if (tag_pos_on_bitmap)
> +		tagged->map_pos = map_pos;
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
>  		commit_idx_pos = read_be32(index->map, &index->map_pos);
>  		xor_offset = read_u8(index->map, &index->map_pos);
>  		flags = read_u8(index->map, &index->map_pos);
> @@ -402,8 +415,9 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
>  		if (!bitmap)
>  			return -1;
>  
> -		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
> -			index, bitmap, &oid, xor_bitmap, flags);
> +		recent_bitmaps[i % MAX_XOR_OFFSET] =
> +			store_bitmap(index, bitmap, &oid, xor_bitmap, flags,
> +				     entry_map_pos);
>  	}
>  
>  	return 0;
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
>  		bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
>  		xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
>  		bitmap = read_bitmap_1(bitmap_git);
> @@ -935,7 +951,8 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>  		if (!bitmap)
>  			goto corrupt;
>  
> -		xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid, xor_bitmap, xor_flags);
> +		xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid,
> +					  xor_bitmap, xor_flags, entry_map_pos);
>  		xor_items_nr--;
>  	}
>  
> @@ -969,6 +986,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>  	 * Instead, we can skip ahead and immediately read the flags and
>  	 * ewah bitmap.
>  	 */
> +	entry_map_pos = bitmap_git->map_pos;
>  	bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
>  	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
>  	bitmap = read_bitmap_1(bitmap_git);
> @@ -976,7 +994,8 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>  	if (!bitmap)
>  		goto corrupt;
>  
> -	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
> +	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags,
> +			    entry_map_pos);
>  
>  corrupt:
>  	free(xor_items);
> @@ -2856,6 +2875,48 @@ int test_bitmap_commits(struct repository *r)
>  	return 0;
>  }
>  
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
> +	/*
> +	 * As this function is only used to print bitmap selected
> +	 * commits, we don't have to read the commit table.
> +	 */
> +	if (bitmap_git->table_lookup) {
> +		if (load_bitmap_entries_v1(bitmap_git) < 0)
> +			die(_("failed to load bitmap indexes"));
> +	}
> +
> +	kh_foreach (bitmap_git->bitmaps, oid, tagged, {
> +		commit_idx_pos_map_pos = tagged->map_pos;
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
> +	})
> +		;
> +
> +	free_bitmap_index(bitmap_git);
> +
> +	return 0;
> +}
> +
>  int test_bitmap_hashes(struct repository *r)
>  {
>  	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
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
>  	if (argc == 2 && !strcmp(argv[1], "dump-hashes"))
>  		return bitmap_dump_hashes();
>  	if (argc == 2 && !strcmp(argv[1], "dump-pseudo-merges"))
> @@ -46,6 +53,7 @@ int cmd__bitmap(int argc, const char **argv)
>  		return bitmap_dump_pseudo_merge_objects(atoi(argv[2]));
>  
>  	usage("\ttest-tool bitmap list-commits\n"
> +	      "\ttest-tool bitmap list-commits-offset\n"
>  	      "\ttest-tool bitmap dump-hashes\n"
>  	      "\ttest-tool bitmap dump-pseudo-merges\n"
>  	      "\ttest-tool bitmap dump-pseudo-merge-commits <n>\n"
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index a62b463eaf09..ef4c5fbaae83 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -486,6 +486,33 @@ test_bitmap_cases () {
>  			grep "ignoring extra bitmap" trace2.txt
>  		)
>  	'
> +
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
> +			EOF
> +			printf '\161' |
> +				dd of=$bitmap count=1 bs=1 conv=notrunc seek=$xor_off &&
> +
> +
> +			git rev-list --count HEAD > expect &&
> +			git rev-list --use-bitmap-index --count HEAD > actual &&
> +			test_cmp expect actual
> +		)
> +	'
>  }
>  
>  test_bitmap_cases
