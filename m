Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94F0C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 20:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbiFTUtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 16:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiFTUta (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 16:49:30 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B1C167E6
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:49:28 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id p14so1180097ile.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NhntLndyiWu2qOlD0XvukJQfXbRdXLKs9bo+MB8MVaM=;
        b=Cfgqk8A5eIp2i21wH1CLz2W+doGpqvJlVhsd3hnUzUh8RVdH+SCjaYj+MF+ZOnzaUX
         HELt/Jyx2DDHcqHZxqlXQbsatRUEOpxb/XWKUDRwkjn6D28JQiQYjofs/w/Fpt0zjPpY
         mF9hRyJ8ELqpxAjJTA9hZJSJN2paZkObiaRNYsaX3uxxw5IERqWI0/lwz499jmbkg2qE
         ngaldIxjmP3UfB3OUuBIfcSZCEF99/evqhn1kB8DK0Tpo13vqmQYCyYzIZkSZyANyQVA
         9OrrojqXSPUSQX7vUT/vdaCvLLtEyqtOGWj+aeJEp82BD7RAxTlAkyfUcFQzvFjD8kq3
         wJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NhntLndyiWu2qOlD0XvukJQfXbRdXLKs9bo+MB8MVaM=;
        b=4F+uJ7bjHrx0LgsD0TXkiCjMML08H/LQq0vxJrAa+ySHfrSUNdmo1aGtaHUFksG+Pt
         59GoTgrv/IEqqSfr5AtxoFalv4iRsTZ8G66I4EV3HijsYfMiLm0DilTm6AfRR1q4B8BZ
         WKbBuM1MuhXJbfaaKktw8DXX1YzwS58Gv/u5MrrX6gJTFremOob/cuBXOIUiijnowLv4
         nGV74d7UJEF5KwJBY5Ghh80P9D6d51iDT6wXdVq0reKb5Ej4la25E1IzLDmaUS970qip
         45Wqb23QQNRh3I/nyfMWhwv1QqZ3lwWVhG7gG06/fLeTGT1vwm1LIFF8B3Vql2s1xeIx
         pmTQ==
X-Gm-Message-State: AJIora9caHI31VFq8+Eg2sgbl4NnuGqgqJt7mbEKnnELzbq8J/epDEl2
        8DyQ4CqgRssxcctnk8bk8nKA9C/uJgxv
X-Google-Smtp-Source: AGRyM1tHByqB4kFnWt4SQsWNX/7yeynzK1RfyK226GfdS/1UQzMIDPvNwvV4u9VfaDTizjkzjRtCjg==
X-Received: by 2002:a05:6e02:b2c:b0:2d1:ba4d:c240 with SMTP id e12-20020a056e020b2c00b002d1ba4dc240mr14913507ilu.273.1655758168182;
        Mon, 20 Jun 2022 13:49:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ed9a:c6cc:7079:2a02? ([2600:1700:e72:80a0:ed9a:c6cc:7079:2a02])
        by smtp.gmail.com with ESMTPSA id c18-20020a92cf12000000b002d8f398c845sm4105723ilo.84.2022.06.20.13.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 13:49:27 -0700 (PDT)
Message-ID: <92dc6860-ff35-0989-5114-fe1e220ca10c@github.com>
Date:   Mon, 20 Jun 2022 16:49:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/6] pack-bitmap: prepare to read lookup table extension
Content-Language: en-US
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <d139a4c48aa058b142c4860721b10344c5498031.1655728395.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <d139a4c48aa058b142c4860721b10344c5498031.1655728395.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/2022 8:33 AM, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> 
> Bitmap lookup table extension can let git to parse only the necessary
> bitmaps without loading the previous bitmaps one by one.

Here is an attempt to reword this a bit:

  The bitmap lookup table extension was documented by an earlier
  change, but Git does not yet know how to parse that information.
  The extension allows parsing a smaller portion of the bitmap
  file in order to find bitmaps for specific commits.

 
> Teach git to read and use the bitmap lookup table extension.

Normally, I don't mind doing the read portion after the write
portion, but it would be nice to have them in the opposite
order so we can test writing the extension _and Git ignoring
the extension_ before implementing the parsing. As it stands,
most of the code in this patch is untested until patch 5.

General outline attempt:

1. Document the format.
2. Write the extension if the flag is given.
3. Add pack.writeBitmapLookupTable and add tests that write
   the lookup table (and do other bitmap reads on that data).
4. Read the lookup table. The tests from step 3 already cover
   acting upon the lookup table. (Perhaps we add a mode here
   that disables GIT_READ_COMMIT_TABLE since that is not used
   anywhere else.)
5. Performance tests.

> +		if (flags & BITMAP_OPT_LOOKUP_TABLE &&
> +		    git_env_bool("GIT_READ_COMMIT_TABLE", 1)) {

This environment variable does not appear to be used or
documented anywhere. Do we really want to use it as a way
to disable reading the lookup table in general? Or would it be
better to have a GIT_TEST_* variable for disabling the read
during testing?

> +			uint32_t entry_count = ntohl(header->entry_count);
> +			uint32_t table_size =
> +				(entry_count * the_hash_algo->rawsz) /* oids */ +
> +				(entry_count * sizeof(uint32_t)) /* offsets */ +
> +				(entry_count * sizeof(uint32_t)) /* xor offsets */ +
> +				(sizeof(uint32_t)) /* flags */;

Here, uint32_T is probably fine, but maybe we should just use
size_t instead? Should we use st_mult() and st_add() everywhere?

Note: you're using the_hash_algo->rawsz here, which makes sense
because the bitmap format doesn't specify which hash algorithm is
used. Just making this note to say that we should include the hash
algorithm as a value in the bitmap format when we increment the
format version (in the future).

> +			if (table_size > index_end - index->map - header_size)
> +				return error("corrupted bitmap index file (too short to fit commit table)");
> +
> +			index->table_lookup = (void *)(index_end - table_size);
> +			index->table_offsets = index->table_lookup + the_hash_algo->rawsz * entry_count;

st_mult(), st_add()? Or, should we assume safety now?

> +			index_end -= table_size;
> +		}

> -	if (load_bitmap_entries_v1(bitmap_git) < 0)
> +	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
>  		goto failed;

Ok, don't load these entries pre-emptively if we have the lookup table.

> +static struct stored_bitmap *stored_bitmap_for_commit(struct bitmap_index *bitmap_git,
> +						      struct commit *commit,
> +						      uint32_t *pos_hint);

I see that we have a two-method recursion loop. Please move this
declaration to immediately before lazy_bitmap_for_commit() so it
is declared as late as possible.

> +static inline const unsigned char *bitmap_oid_pos(struct bitmap_index *bitmap_git,
> +						  uint32_t pos)
> +{
> +	return bitmap_git->table_lookup + (pos * the_hash_algo->rawsz);
> +}

I would call this "bitmap_hash_pos()" because we are getting a raw
hash and not a 'struct object_id'. Do you want a helper that fills
a 'struct object_id', perhaps passed-by-reference?

> +static inline const void *bitmap_offset_pos(struct bitmap_index *bitmap_git,
> +					    uint32_t pos)

> +static inline const void *xor_position_pos(struct bitmap_index *bitmap_git,
> +					   uint32_t pos)

These two helpers should probably return a size_t and uint32_t
instead of a pointer. Let these do get_be[32|64]() on the computed
pointer.

> +static int bitmap_table_lookup(struct bitmap_index *bitmap_git,
> +			       struct object_id *oid,
> +			       uint32_t *commit_pos)
> +{
> +	unsigned char *found = bsearch(oid->hash, bitmap_git->table_lookup,
> +				       bitmap_git->entry_count,
> +				       the_hash_algo->rawsz, bitmap_lookup_cmp);
> +	if (found)
> +		*commit_pos = (found - bitmap_git->table_lookup) / the_hash_algo->rawsz;
> +	return !!found;

Ok, we are running binary search and converting the pointer into a
position.

Frequently, these kind of searches return an int, but use a negative
value to indicate that the value was not found. Using an int in this
way would restrict us to 2^31 bitmaps instead of 2^32, so maybe it
is not worth matching that practice.

> +static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
> +						    struct object_id *oid,
> +						    uint32_t commit_pos)
> +{
> +	uint32_t xor_pos;
> +	off_t bitmap_ofs;
> +
> +	int flags;
> +	struct ewah_bitmap *bitmap;
> +	struct stored_bitmap *xor_bitmap;
> +
> +	bitmap_ofs = get_be32(bitmap_offset_pos(bitmap_git, commit_pos));
> +	xor_pos = get_be32(xor_position_pos(bitmap_git, commit_pos));

These lines become simpler with a change in the helper methods'
prototypes, as I recommended higher up.

> +	/*
> +	 * Lazily load the xor'd bitmap if required (and we haven't done so
> +	 * already). Make sure to pass the xor'd bitmap's position along as a
> +	 * hint to avoid an unnecessary binary search in
> +	 * stored_bitmap_for_commit().
> +	 */
> +	if (xor_pos == 0xffffffff) {
> +		xor_bitmap = NULL;
> +	} else {
> +		struct commit *xor_commit;
> +		struct object_id xor_oid;
> +
> +		oidread(&xor_oid, bitmap_oid_pos(bitmap_git, xor_pos));
> +
> +		xor_commit = lookup_commit(the_repository, &xor_oid);
> +		if (!xor_commit)
> +			return NULL;
> +
> +		xor_bitmap = stored_bitmap_for_commit(bitmap_git, xor_commit,
> +						      &xor_pos);
> +	}

This is using an interesting type of tail-recursion. We might be
better off using a loop with a stack: push to the stack the commit
positions of the XOR bitmaps. At the very bottom, we get a bitmap
without an XOR base. Then, pop off the stack, modifying the bitmap
with XOR operations as we go. (Perhaps we also store these bitmaps
in-memory along the way?) Finally, we have the necessary bitmap.

This iterative approach avoids possible stack exhaustion if there
are long XOR chains in the file.

> +
> +	/*
> +	 * Don't bother reading the commit's index position or its xor
> +	 * offset:
> +	 *
> +	 *   - The commit's index position is irrelevant to us, since
> +	 *     load_bitmap_entries_v1 only uses it to learn the object
> +	 *     id which is used to compute the hashmap's key. We already
> +	 *     have an object id, so no need to look it up again.
> +	 *
> +	 *   - The xor_offset is unusable for us, since it specifies how
> +	 *     many entries previous to ours we should look at. This
> +	 *     makes sense when reading the bitmaps sequentially (as in
> +	 *     load_bitmap_entries_v1()), since we can keep track of
> +	 *     each bitmap as we read them.
> +	 *
> +	 *     But it can't work for us, since the bitmap's don't have a
> +	 *     fixed size. So we learn the position of the xor'd bitmap
> +	 *     from the commit table (and resolve it to a bitmap in the
> +	 *     above if-statement).
> +	 *
> +	 * Instead, we can skip ahead and immediately read the flags and
> +	 * ewah bitmap.
> +	 */
> +	bitmap_git->map_pos = bitmap_ofs + sizeof(uint32_t) + sizeof(uint8_t);
> +	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
> +	bitmap = read_bitmap_1(bitmap_git);
> +	if (!bitmap)
> +		return NULL;
> +
> +	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);

Looks like we'd want to call store_bitmap() while popping the stack
in the loop I recommended above.

> +}
> +
> +static struct stored_bitmap *stored_bitmap_for_commit(struct bitmap_index *bitmap_git,
> +						      struct commit *commit,
> +						      uint32_t *pos_hint)
>  {
>  	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
>  					   commit->object.oid);
> -	if (hash_pos >= kh_end(bitmap_git->bitmaps))
> +	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
> +		uint32_t commit_pos;
> +		if (!bitmap_git->table_lookup)
> +			return NULL;
> +
> +		/* NEEDSWORK: cache misses aren't recorded. */
> +		if (pos_hint)
> +			commit_pos = *pos_hint;
> +		else if (!bitmap_table_lookup(bitmap_git,
> +					      &commit->object.oid,
> +					      &commit_pos))
> +			return NULL;
> +		return lazy_bitmap_for_commit(bitmap_git, &commit->object.oid,
> +					      commit_pos);

The extra bonus of going incremental is that we don't have recursion
across two methods, which I always find difficult to reason about.

> +	}
> +	return kh_value(bitmap_git->bitmaps, hash_pos);
> +}

> @@ -26,6 +26,7 @@ struct bitmap_disk_header {
>  enum pack_bitmap_opts {
>  	BITMAP_OPT_FULL_DAG = 1,
>  	BITMAP_OPT_HASH_CACHE = 4,
> +	BITMAP_OPT_LOOKUP_TABLE = 16,

Perhaps it is time to use hexadecimal representation here to match the
file format document?

Thanks,
-Stolee
