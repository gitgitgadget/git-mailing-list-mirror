Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315111F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 14:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfH0OxV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 10:53:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44924 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0OxV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 10:53:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id y22so1316411qkb.11
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MugpSOXqK1oZMdMDzLhicwe7YX1/eLXzWwtcUHOtEBA=;
        b=ff29he+rtlfMbCdtJNla/O3FGuYqMKaBNT9cFVgmjTaiAEmu1zFH03DXvC7oGefoiU
         +UevpBnChIjn4XPcZcwgzZSf6JbSqXztOZTUJcJ5JRDpGutt0W4fpTGqAyKAJ1rOA7h6
         j0/ESIoU/OBP9yCh0XzdVjfClduexeVk9xDEQdxp3YYCfyJpW79C3fth+ITV799O3q8+
         0Vg+eGVHhaYyrh2d8qnaPM8yhgc22zv21ZgdBS19E/0jeguO35EtzI2JVwKRoFjRzY66
         u1jX5LkRpk/z7rCtDXWfm4OMWuVdAqeG3ecR3boTORSp1/oc1SnssgJtuBkJ67pfqeFD
         WWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MugpSOXqK1oZMdMDzLhicwe7YX1/eLXzWwtcUHOtEBA=;
        b=TJPj68jHPYniu1csH18Ld8UC2xDOKAc+jueyLC78egU8ramXlZhC2IsHBDd5Wd6Qdt
         He/jdKD0Cha9Bh4nLcwMMmrOLIKr5wswwY+/idi2amxmyZiGz5Yo6zWk7oik2N92LvOW
         a2JjKV3dwzZzQ0h3ccjMTw/tSw1zGK4/jK1qbTbW2K25O41xZYp442TGtklnI6AQ5b2Y
         bKOvgMa/7pM1VDZ+svX41o1di8qPKW/eVsDkCZjIT/OEzd97e++tPCwHkFVQb6E7EIYE
         F9iWdavXjgtvsmanWFDcw+n5POyDAWKYfnvx0L/8gIDtwIuBRXqwPz2fR0h52keR/TfI
         hkPw==
X-Gm-Message-State: APjAAAX8TWhtaIMZ30fAUt1XIlWR5C19y4N6w8RkfyJArXDu9VXpW+Uj
        kmh6jjSmxAGSMZTn3JaOjlGG7TnoMUo=
X-Google-Smtp-Source: APXvYqxRnASFfBJ3z3aZETem5r5pbqrxOeOdKrbxRLL5pGYKCUNVsNk+w3z756wZo+fZ/FY++6ai5A==
X-Received: by 2002:a37:4cd3:: with SMTP id z202mr21851431qka.203.1566917599770;
        Tue, 27 Aug 2019 07:53:19 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a903:7653:4c3b:5b49? ([2001:4898:a800:1012:5a37:7653:4c3b:5b49])
        by smtp.gmail.com with ESMTPSA id 18sm8146830qkh.77.2019.08.27.07.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 07:53:19 -0700 (PDT)
Subject: Re: [PATCH 11/11] hashmap_get_next returns "struct hashmap_entry *"
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190826024332.3403-1-e@80x24.org>
 <20190826024332.3403-12-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2f22841c-779e-6d6e-19b7-0a119088e343@gmail.com>
Date:   Tue, 27 Aug 2019 10:53:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190826024332.3403-12-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2019 10:43 PM, Eric Wong wrote:
> This is a step towards removing the requirement for
> hashmap_entry being the first field of a struct.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  diff.c                  | 19 ++++++++++++-------
>  diffcore-rename.c       | 11 +++++++----
>  hashmap.c               |  2 +-
>  hashmap.h               | 12 ++++++++----
>  name-hash.c             |  8 +++++---
>  t/helper/test-hashmap.c | 10 ++++++----
>  6 files changed, 39 insertions(+), 23 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 72d3c6aa19..663b5d01f8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1035,8 +1035,10 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
>  {
>  	int i;
>  	char *got_match = xcalloc(1, pmb_nr);
> +	struct hashmap_entry *ent = &match->ent;
>  
> -	for (; match; match = hashmap_get_next(hm, &match->ent)) {
> +	for (; ent; ent = hashmap_get_next(hm, ent)) {
> +		match = container_of(ent, struct moved_entry, ent);

Lines like this are very difficult to parse. In this
container_of() macro, 'ent' is taking both the 'ptr' and
'member' values.

I would prefer that you make your local member be named
something different, for instance:

	struct hashmap_entry *match_ent = &match->ent;

and

	match = container_of(match_ent, struct moved_entry, ent);

>  		for (i = 0; i < pmb_nr; i++) {
>  			struct moved_entry *prev = pmb[i].match;
>  			struct moved_entry *cur = (prev && prev->next_line) ?
> @@ -1135,8 +1137,9 @@ static void mark_color_as_moved(struct diff_options *o,
>  
>  	for (n = 0; n < o->emitted_symbols->nr; n++) {
>  		struct hashmap *hm = NULL;
> +		struct hashmap_entry *ent = NULL;
>  		struct moved_entry *key;
> -		struct moved_entry *match = NULL;
> +		struct moved_entry *match;
>  		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
>  		enum diff_symbol last_symbol = 0;
>  
> @@ -1144,20 +1147,20 @@ static void mark_color_as_moved(struct diff_options *o,
>  		case DIFF_SYMBOL_PLUS:
>  			hm = del_lines;
>  			key = prepare_entry(o, n);
> -			match = hashmap_get(hm, &key->ent, NULL);
> +			ent = hashmap_get(hm, &key->ent, NULL);
>  			free(key);
>  			break;
>  		case DIFF_SYMBOL_MINUS:
>  			hm = add_lines;
>  			key = prepare_entry(o, n);
> -			match = hashmap_get(hm, &key->ent, NULL);
> +			ent = hashmap_get(hm, &key->ent, NULL);
>  			free(key);
>  			break;
>  		default:
>  			flipped_block = 0;
>  		}
>  
> -		if (!match) {
> +		if (!ent) {
>  			int i;
>  
>  			adjust_last_block(o, n, block_length);
> @@ -1169,6 +1172,7 @@ static void mark_color_as_moved(struct diff_options *o,
>  			last_symbol = l->s;
>  			continue;
>  		}
> +		match = container_of(ent, struct moved_entry, ent);
>  
>  		if (o->color_moved == COLOR_MOVED_PLAIN) {
>  			last_symbol = l->s;
> @@ -1189,8 +1193,9 @@ static void mark_color_as_moved(struct diff_options *o,
>  			 * The current line is the start of a new block.
>  			 * Setup the set of potential blocks.
>  			 */
> -			for (; match; match = hashmap_get_next(hm,
> -								&match->ent)) {
> +			for (; ent; ent = hashmap_get_next(hm, ent)) {
> +				match = container_of(ent, struct moved_entry,
> +							ent);

Same complaint here.

>  				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
>  				if (o->color_moved_ws_handling &
>  				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 4670a40179..71aa240a68 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -274,7 +274,7 @@ static int find_identical_files(struct hashmap *srcs,
>  				struct diff_options *options)
>  {
>  	int renames = 0;
> -
> +	struct hashmap_entry *ent;
>  	struct diff_filespec *target = rename_dst[dst_index].two;
>  	struct file_similarity *p, *best = NULL;
>  	int i = 100, best_score = -1;
> @@ -282,12 +282,15 @@ static int find_identical_files(struct hashmap *srcs,
>  	/*
>  	 * Find the best source match for specified destination.
>  	 */
> -	p = hashmap_get_from_hash(srcs,
> +	ent = hashmap_get_from_hash(srcs,
>  				  hash_filespec(options->repo, target),
>  				  NULL);
> -	for (; p; p = hashmap_get_next(srcs, &p->entry)) {
> +	for (; ent; ent = hashmap_get_next(srcs, ent)) {
>  		int score;
> -		struct diff_filespec *source = p->filespec;
> +		struct diff_filespec *source;
> +
> +		p = container_of(ent, struct file_similarity, entry);

This is slightly better, but still a bit confusing.

> +		source = p->filespec;
>  
>  		/* False hash collision? */
>  		if (!oideq(&source->oid, &target->oid))
> diff --git a/hashmap.c b/hashmap.c
> index 2dd9912e13..d6434d9ca4 100644
> --- a/hashmap.c
> +++ b/hashmap.c
> @@ -192,7 +192,7 @@ void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
>  	return *find_entry_ptr(map, key, keydata);
>  }
>  
> -void *hashmap_get_next(const struct hashmap *map,
> +struct hashmap_entry *hashmap_get_next(const struct hashmap *map,
>  			const struct hashmap_entry *entry)
>  {
>  	struct hashmap_entry *e = entry->next;
> diff --git a/hashmap.h b/hashmap.h
> index b62ee2e7b9..25643dcdc4 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -55,15 +55,19 @@
>   *
>   *         if (!strcmp("print_all_by_key", action)) {
>   *             struct long2string k, *e;
> + *             struct hashmap_entry *ent;
>   *             hashmap_entry_init(&k->ent, memhash(&key, sizeof(long)));
>   *             k.key = key;
>   *
>   *             flags &= ~COMPARE_VALUE;
> - *             e = hashmap_get(&map, &k, NULL);
> - *             if (e) {
> + *             ent = hashmap_get(&map, &k, NULL);
> + *             if (ent) {
> + *                 e = container_of(ent, struct long2string, ent);
>   *                 printf("first: %ld %s\n", e->key, e->value);
> - *                 while ((e = hashmap_get_next(&map, e)))
> + *                 while ((ent = hashmap_get_next(&map, ent))) {
> + *                     e = container_of(ent, struct long2string, ent);
>   *                     printf("found more: %ld %s\n", e->key, e->value);
> + *                 }
>   *             }
>   *         }
>   *
> @@ -320,7 +324,7 @@ static inline void *hashmap_get_from_hash(const struct hashmap *map,
>   * `entry` is the hashmap_entry to start the search from, obtained via a previous
>   * call to `hashmap_get` or `hashmap_get_next`.
>   */
> -void *hashmap_get_next(const struct hashmap *map,
> +struct hashmap_entry *hashmap_get_next(const struct hashmap *map,
>  			const struct hashmap_entry *entry);
>  
>  /*
> diff --git a/name-hash.c b/name-hash.c
> index f64c52bfa2..6f2779934f 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -703,15 +703,17 @@ void adjust_dirname_case(struct index_state *istate, char *name)
>  struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
>  {
>  	struct cache_entry *ce;
> +	struct hashmap_entry *ent;
>  
>  	lazy_init_name_hash(istate);
>  
> -	ce = hashmap_get_from_hash(&istate->name_hash,
> +	ent = hashmap_get_from_hash(&istate->name_hash,
>  				   memihash(name, namelen), NULL);
> -	while (ce) {
> +	while (ent) {
> +		ce = container_of(ent, struct cache_entry, ent);
>  		if (same_name(ce, name, namelen, icase))
>  			return ce;
> -		ce = hashmap_get_next(&istate->name_hash, &ce->ent);
> +		ent = hashmap_get_next(&istate->name_hash, ent);
>  	}
>  	return NULL;
>  }
> diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
> index de2bd083b9..d85b8dc58e 100644
> --- a/t/helper/test-hashmap.c
> +++ b/t/helper/test-hashmap.c
> @@ -194,16 +194,18 @@ int cmd__hashmap(int argc, const char **argv)
>  			free(entry);
>  
>  		} else if (!strcmp("get", cmd) && p1) {
> +			struct hashmap_entry *e;
>  
>  			/* lookup entry in hashmap */
> -			entry = hashmap_get_from_hash(&map, hash, p1);
> +			e = hashmap_get_from_hash(&map, hash, p1);
>  
>  			/* print result */
> -			if (!entry)
> +			if (!e)
>  				puts("NULL");
> -			while (entry) {
> +			while (e) {
> +				entry = container_of(e, struct test_entry, ent);
>  				puts(get_value(entry));
> -				entry = hashmap_get_next(&map, &entry->ent);
> +				e = hashmap_get_next(&map, e);
>  			}
>  
>  		} else if (!strcmp("remove", cmd) && p1) {

I didn't comment on them all, but essentially every use of
container_of() here is pretty confusing with the names. Perhaps
some pattern of "type_member" could be helpful, so you can use

	type_p = container_of(type_member, struct type, member);

to be really clear about each name.

Thanks,
-Stolee

