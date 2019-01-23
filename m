Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0751B1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 21:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfAWVA7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 16:00:59 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45338 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfAWVA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 16:00:59 -0500
Received: by mail-pg1-f202.google.com with SMTP id y8so2363498pgq.12
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R/scxIUuZoQ0uGuRGieHDPD4pJYFI0hqVUz2GlGGulM=;
        b=plEoVaGqnFbVlfZpLkiB14erF5bLOkmE8kejOl/UkDJc+Ofpm37zXRZk7G87GI/1tS
         EkRhPqyU73apIkKoPgUrmyHfiNxHAklGxTkYg6RGPUkJf2GqByI3zq6IFmTCMMKFpPP6
         HZzh57mGCQebt/cLcVx8dHCaygJL/J8SuW6k+KkB70J4VwBNuOrUKEeSCz22YOp/68XV
         cFa9tE1lDzQ/F40uQPviHzr2grAzZpE4EvyFPmUyDY0+orAcNPoNmTQBjylNhE0xCnNO
         VthsuvH4f16ypZYnnYglGU0vDUQRkS99ch9IWr1fjXk8JoUsC4kM6iQwl6Y5KryOOWwY
         48zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R/scxIUuZoQ0uGuRGieHDPD4pJYFI0hqVUz2GlGGulM=;
        b=nIDfZ/0kH+HW/RSY8ACzhRTrLrXj9O8ml+bAlcdWHaBEMixHjzvKogT1O/2J42vJu9
         tcNO0lM72aSmAQvoUrHiOmlcamiPdB9g3JNTwTZbyHu69HJHmB/Aac29IKxpDpcSeHht
         EIP8yxlT8bkJpyovZ73R89nL7Usa7dhFYJZ65/UmCUKSGZTKBs6lmER0tMjHlxNwdXpW
         mpkDINyONHSJ1t4tExXIbvdiotv8vrZUzqGwAhANEleqmf8/h32VVBEIaCggatVGjodn
         SD25XFlwGRaPmqSuK/P8Tfm2RkhR98nW4/JO3nEXayBEexsh0q1cqxJncJNv156PJFRs
         RzKQ==
X-Gm-Message-State: AJcUukdJGZY8K7ItQoAceRFVNvGQRoWzwFHBZoCenQuJMzncDzfFcH8L
        D+ebO2PYDJFuWBTBF0R2wRYcKg99hXp5QYMPadAD
X-Google-Smtp-Source: ALg8bN4K7v0+4aAXtDRRC7CfK5fuic4o6KhwvRQjF/H1lMADW0Wu1V+UHcKoODUDBBua8k+xjB/bl6YgDrdIZChN/8yg
X-Received: by 2002:a62:449b:: with SMTP id m27mr1534057pfi.87.1548277258310;
 Wed, 23 Jan 2019 13:00:58 -0800 (PST)
Date:   Wed, 23 Jan 2019 13:00:54 -0800
In-Reply-To: <a0d4cc6cb3fbca0de732dfd34cbec4d765b55228.1547047269.git.gitgitgadget@gmail.com>
Message-Id: <20190123210054.118647-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <a0d4cc6cb3fbca0de732dfd34cbec4d765b55228.1547047269.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v3 5/9] midx: refactor permutation logic and pack sorting
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        dstolee@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following Stolee's wishes [1], I'll stick to the technical aspects here.
Patches 1-4 look correct technically to me, so let me start here.

[1] https://public-inbox.org/git/3aa0a7ea-6c30-2c61-0815-2b9ab8304564@gmail.com/

> +struct pack_info {
> +	uint32_t orig_pack_int_id;
> +	char *pack_name;
> +	struct packed_git *p;
> +};
> +
> +static int pack_info_compare(const void *_a, const void *_b)
> +{
> +	struct pack_info *a = (struct pack_info *)_a;
> +	struct pack_info *b = (struct pack_info *)_b;
> +	return strcmp(a->pack_name, b->pack_name);
> +}
> +
>  struct pack_list {
> -	struct packed_git **list;
> -	char **names;
> +	struct pack_info *info;
>  	uint32_t nr;
> -	uint32_t alloc_list;
> -	uint32_t alloc_names;
> +	uint32_t alloc;
>  	struct multi_pack_index *m;
>  };

"list" and "names" look like a parallel array, but as far as I can tell,
they are actually not, because "names" is eventually sorted but not
"list". So combining these two arrays is great, and removes a lot of
confusion.

Now the packed_git list will be sorted too when the names are sorted; I
was surprised that code did not need to be changed to take this into
account, but I see now that it's because the struct packed_gits don't
need to be referenced anymore after get_sorted_entries().

> -struct pack_pair {
> -	uint32_t pack_int_id;
> -	char *pack_name;
> -};
> -
> -static int pack_pair_compare(const void *_a, const void *_b)
> -{
> -	struct pack_pair *a = (struct pack_pair *)_a;
> -	struct pack_pair *b = (struct pack_pair *)_b;
> -	return strcmp(a->pack_name, b->pack_name);
> -}
> -
> -static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *perm)
> -{
> -	uint32_t i;
> -	struct pack_pair *pairs;
> -
> -	ALLOC_ARRAY(pairs, nr_packs);
> -
> -	for (i = 0; i < nr_packs; i++) {
> -		pairs[i].pack_int_id = i;
> -		pairs[i].pack_name = pack_names[i];
> -	}
> -
> -	QSORT(pairs, nr_packs, pack_pair_compare);
> -
> -	for (i = 0; i < nr_packs; i++) {
> -		pack_names[i] = pairs[i].pack_name;
> -		perm[pairs[i].pack_int_id] = i;
> -	}
> -
> -	free(pairs);
> -}

It's nice that this gets removed.

>  static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
> -				      uint32_t *pack_perm,
>  				      struct pack_midx_entry *e,
>  				      uint32_t pos)
>  {
> @@ -488,7 +464,7 @@ static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
>  		return 1;
>  
>  	nth_midxed_object_oid(&e->oid, m, pos);
> -	e->pack_int_id = pack_perm[nth_midxed_pack_int_id(m, pos)];
> +	e->pack_int_id = nth_midxed_pack_int_id(m, pos);
>  	e->offset = nth_midxed_offset(m, pos);

nth_midxed_pack_midx_entry() is only called from get_sorted_entries(),
which is now called *before* any sorting of pack_info, so there is no
longer any need for considering pack_perm. As to why
get_sorted_entries() needs to be called before sorting of pack_info and
not after, that question will be answered later.

> @@ -522,8 +498,7 @@ static void fill_pack_entry(uint32_t pack_int_id,
>   * of a packfile containing the object).
>   */
>  static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
> -						  struct packed_git **p,
> -						  uint32_t *perm,
> +						  struct pack_info *info,
>  						  uint32_t nr_packs,
>  						  uint32_t *nr_objects)

[snip rest of get_sorted_entries]

As stated above, get_sorted_entries() is now called before any sorting
of pack_info, so there is no need for perm.

>  static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_needed,
> +					uint32_t *perm,
>  					struct pack_midx_entry *objects, uint32_t nr_objects)
>  {
>  	struct pack_midx_entry *list = objects;
> @@ -699,7 +675,7 @@ static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_nee
>  	for (i = 0; i < nr_objects; i++) {
>  		struct pack_midx_entry *obj = list++;
>  
> -		hashwrite_be32(f, obj->pack_int_id);
> +		hashwrite_be32(f, perm[obj->pack_int_id]);
>  
>  		if (large_offset_needed && obj->offset >> 31)
>  			hashwrite_be32(f, MIDX_LARGE_OFFSET_NEEDED | nr_large_offset++);

This was unexpected to me - why is perm introduced here when it wasn't
needed before? This is because get_sorted_entries() is now called before
any sorting of pack_info. get_sorted_entries() generates entries using
the old pack_int_id, but the resulting packfile is written using new
pack numbers, so when writing the entries to the file, they must be
written using the new numbers.

The mapping of perm is: perm[old number] = new number.

> @@ -795,10 +768,7 @@ int write_midx_file(const char *object_dir)
>  	if (packs.m && packs.nr == packs.m->num_packs)
>  		goto cleanup;
>  
> -	ALLOC_ARRAY(pack_perm, packs.nr);
> -	sort_packs_by_name(packs.names, packs.nr, pack_perm);
> -
> -	entries = get_sorted_entries(packs.m, packs.list, pack_perm, packs.nr, &nr_entries);
> +	entries = get_sorted_entries(packs.m, packs.info, packs.nr, &nr_entries);
>  
>  	for (i = 0; i < nr_entries; i++) {
>  		if (entries[i].offset > 0x7fffffff)
> @@ -807,8 +777,15 @@ int write_midx_file(const char *object_dir)
>  			large_offsets_needed = 1;
>  	}
>  
> +	QSORT(packs.info, packs.nr, pack_info_compare);
> +
> +	ALLOC_ARRAY(pack_perm, packs.nr);
> +	for (i = 0; i < packs.nr; i++) {
> +		pack_perm[packs.info[i].orig_pack_int_id] = i;
> +	}
> +
>  	for (i = 0; i < packs.nr; i++)
> -		pack_name_concat_len += strlen(packs.names[i]) + 1;
> +		pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
>  
>  	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
>  		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -

Indeed, the sorting of pack_info is moved to after get_sorted_entries().
Also, pack_perm[old number] = new number, as expected.

I think a comment explaining why the perm is needed would be helpful -
something explaining that the entries were generated using the old pack
numbers, so we need this mapping to be able to write them using the new
numbers.

As part of this review, I did attempt to make everything use the sorted
pack_info order, but failed. I got as far as making get_sorted_entries()
always use start_pack=0 and skip the pack_infos that didn't have the p
pointer (to match the existing behavior of get_sorted_entries() that
only operates on new pack_infos being added by add_pack_to_midx), but it
still didn't work, and I didn't investigate further.
