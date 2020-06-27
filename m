Return-Path: <SRS0=mvrS=AI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDBEC433E0
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 15:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2DE20E65
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 15:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifx8xn3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgF0Pxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0Pxk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jun 2020 11:53:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F2DC061794
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 08:53:40 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l12so12102627ejn.10
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XYffx/2p2taBXuUO9LPx8m9KL/hQu3gmDGRWd/AIY3g=;
        b=ifx8xn3JaBw7oC7hjPDLHdvbV9txJEXXwN66ALfq2Pil1JEl2Z9o1N9aNOcs/bfUFd
         nj/3KuiiYK1GUZM0pKtrJjOrvyi/LUmdMKqnyFoVwk9MIPqtgV8V3dFmgscikaYbjD1p
         4NrOfaFmStPfnRwDijFQeH5aqKmjofhJsPryvadfTtay2StfjGtpwiSy8XeFn/scm5Q5
         W0/Ou63MvzAo9Xu+73TuCOagfB9JzdclFwBuMfaIfUnq0HQz78K3FVAJX9mMlR8xLYqq
         o9+bYiyoCMSztQ64Ds7m/yxv0etj3I2wSWlqWBzmJ95ykhm5t3xfan1s7KfJn//n70HP
         1IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XYffx/2p2taBXuUO9LPx8m9KL/hQu3gmDGRWd/AIY3g=;
        b=hmOAlmFcsXWyh6qnQ+2ez5c3Nrk1lYnE5q4Y1DJ8ctdu+r/KvrHqyF0WBOnoMnjFK/
         +2SIaIPu8tF5cQXe6QmItr5lj3a4krCRG+16JHaHpc5omvHJcbEEEH/iiSD9lVe0g3Wn
         FrxNwDT1vQY9PGRBmoBrlSvIgNdazmzQDb6PfsaLaYkXeQlWshpeZYfEUqfO28c3eZxN
         2T9fCaMXGNpF49Ui2qy51j7cDYKjXfA/vc+8o8b41AmRIzX6eyml+s39SeEg/yL3kN6P
         6K1ndcspidQthfGPXzbrLQzs26yjSYtozAHg0ljm4AytuvKttCkDLZEjcjNrpHUIkSC+
         DdoA==
X-Gm-Message-State: AOAM5308wMFgkQCgACcfWMaiciqjaDukpczcR0UnvEm6AQW2q6wY+3Zb
        F59HL4jWOOhjfExbIuXi2M8=
X-Google-Smtp-Source: ABdhPJw9RuPb2ki30J7igm2+wp0uprmC2gohYUr3R7R5V7Wqi4NPGa8oLSxP7K4fBb/tdJ5SIcB74g==
X-Received: by 2002:a17:906:ccd3:: with SMTP id ot19mr7707370ejb.468.1593273219027;
        Sat, 27 Jun 2020 08:53:39 -0700 (PDT)
Received: from szeder.dev (92-249-246-85.pool.digikabel.hu. [92.249.246.85])
        by smtp.gmail.com with ESMTPSA id o20sm9266233ejr.64.2020.06.27.08.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2020 08:53:38 -0700 (PDT)
Date:   Sat, 27 Jun 2020 17:53:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v4 04/15] bloom.c: core Bloom filter implementation for
 changed paths.
Message-ID: <20200627155336.GB11341@szeder.dev>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <8304c2975207ee847c6709abd71efee918fc4142.1586192395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8304c2975207ee847c6709abd71efee918fc4142.1586192395.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 04:59:44PM +0000, Garima Singh via GitGitGadget wrote:
> From: Garima Singh <garima.singh@microsoft.com>
> 
> Add the core implementation for computing Bloom filters for
> the paths changed between a commit and it's first parent.
> 
> We fill the Bloom filters as (const char *data, int len) pairs
> as `struct bloom_filters" within a commit slab.
> 
> Filters for commits with no changes and more than 512 changes,
> is represented with a filter of length zero. There is no gain
> in distinguishing between a computed filter of length zero for
> a commit with no changes, and an uncomputed filter for new commits
> or for commits with more than 512 changes. The effect on
> `git log -- path` is the same in both cases. We will fall back to
> the normal diffing algorithm when we can't benefit from the
> existence of Bloom filters.
> 
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Reviewed-by: Jakub Narębski <jnareb@gmail.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  bloom.c               | 97 +++++++++++++++++++++++++++++++++++++++++++
>  bloom.h               |  8 ++++
>  t/helper/test-bloom.c | 20 +++++++++
>  t/t0095-bloom.sh      | 47 +++++++++++++++++++++
>  4 files changed, 172 insertions(+)
> 
> diff --git a/bloom.c b/bloom.c
> index 888b67f1ea6..881a9841ede 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -1,5 +1,18 @@
>  #include "git-compat-util.h"
>  #include "bloom.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +#include "revision.h"
> +#include "hashmap.h"
> +
> +define_commit_slab(bloom_filter_slab, struct bloom_filter);

So here we define a commit slab for modified path Bloom filters, ...

> +struct bloom_filter_slab bloom_filters;
> +
> +struct pathmap_hash_entry {
> +    struct hashmap_entry entry;
> +    const char path[FLEX_ARRAY];
> +};
>  
>  static uint32_t rotate_left(uint32_t value, int32_t count)
>  {
> @@ -107,3 +120,87 @@ void add_key_to_filter(const struct bloom_key *key,
>  		filter->data[block_pos] |= get_bitmask(hash_mod);
>  	}
>  }
> +
> +void init_bloom_filters(void)
> +{
> +	init_bloom_filter_slab(&bloom_filters);

... here initialize the slab ...

> +}
> +
> +struct bloom_filter *get_bloom_filter(struct repository *r,
> +				      struct commit *c)
> +{
> +	struct bloom_filter *filter;
> +	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
> +	int i;
> +	struct diff_options diffopt;
> +
> +	if (bloom_filters.slab_size == 0)
> +		return NULL;
> +
> +	filter = bloom_filter_slab_at(&bloom_filters, c);

... allocate an entry in the slab ...

> +
> +	repo_diff_setup(r, &diffopt);
> +	diffopt.flags.recursive = 1;
> +	diff_setup_done(&diffopt);
> +
> +	if (c->parents)
> +		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &diffopt);
> +	else
> +		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
> +	diffcore_std(&diffopt);
> +
> +	if (diff_queued_diff.nr <= 512) {
> +		struct hashmap pathmap;
> +		struct pathmap_hash_entry *e;
> +		struct hashmap_iter iter;
> +		hashmap_init(&pathmap, NULL, NULL, 0);
> +
> +		for (i = 0; i < diff_queued_diff.nr; i++) {
> +			const char *path = diff_queued_diff.queue[i]->two->path;
> +
> +			/*
> +			* Add each leading directory of the changed file, i.e. for
> +			* 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
> +			* the Bloom filter could be used to speed up commands like
> +			* 'git log dir/subdir', too.
> +			*
> +			* Note that directories are added without the trailing '/'.
> +			*/
> +			do {
> +				char *last_slash = strrchr(path, '/');
> +
> +				FLEX_ALLOC_STR(e, path, path);
> +				hashmap_entry_init(&e->entry, strhash(path));
> +				hashmap_add(&pathmap, &e->entry);
> +
> +				if (!last_slash)
> +					last_slash = (char*)path;
> +				*last_slash = '\0';
> +
> +			} while (*path);
> +
> +			diff_free_filepair(diff_queued_diff.queue[i]);
> +		}
> +
> +		filter->len = (hashmap_get_size(&pathmap) * settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
> +		filter->data = xcalloc(filter->len, sizeof(unsigned char));

... and here we fill the slab with data, including a memory allocation
for each slab entry.

What is missing in this patch or in any of the followup patches is a
place where we clear the slab and the additional memory attached to
it.

> +
> +		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
> +			struct bloom_key key;
> +			fill_bloom_key(e->path, strlen(e->path), &key, &settings);
> +			add_key_to_filter(&key, filter, &settings);
> +		}
> +
> +		hashmap_free_entries(&pathmap, struct pathmap_hash_entry, entry);
> +	} else {
> +		for (i = 0; i < diff_queued_diff.nr; i++)
> +			diff_free_filepair(diff_queued_diff.queue[i]);
> +		filter->data = NULL;
> +		filter->len = 0;
> +	}
> +
> +	free(diff_queued_diff.queue);
> +	DIFF_QUEUE_CLEAR(&diff_queued_diff);
> +
> +	return filter;
> +}
> diff --git a/bloom.h b/bloom.h
> index b9ce422ca2d..85ab8e9423d 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -1,6 +1,9 @@
>  #ifndef BLOOM_H
>  #define BLOOM_H
>  
> +struct commit;
> +struct repository;
> +
>  struct bloom_filter_settings {
>  	/*
>  	 * The version of the hashing technique being used.
> @@ -73,4 +76,9 @@ void add_key_to_filter(const struct bloom_key *key,
>  					   struct bloom_filter *filter,
>  					   const struct bloom_filter_settings *settings);
>  
> +void init_bloom_filters(void);
> +
> +struct bloom_filter *get_bloom_filter(struct repository *r,
> +				      struct commit *c);
> +
>  #endif
> \ No newline at end of file
> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> index 20460cde775..f18d1b722e1 100644
> --- a/t/helper/test-bloom.c
> +++ b/t/helper/test-bloom.c
> @@ -1,6 +1,7 @@
>  #include "git-compat-util.h"
>  #include "bloom.h"
>  #include "test-tool.h"
> +#include "commit.h"
>  
>  struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
>  
> @@ -32,6 +33,16 @@ static void print_bloom_filter(struct bloom_filter *filter) {
>  	printf("\n");
>  }
>  
> +static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
> +{
> +	struct commit *c;
> +	struct bloom_filter *filter;
> +	setup_git_directory();
> +	c = lookup_commit(the_repository, commit_oid);
> +	filter = get_bloom_filter(the_repository, c);
> +	print_bloom_filter(filter);
> +}
> +
>  int cmd__bloom(int argc, const char **argv)
>  {
>  	if (!strcmp(argv[1], "get_murmur3")) {
> @@ -57,5 +68,14 @@ int cmd__bloom(int argc, const char **argv)
>  		print_bloom_filter(&filter);
>  	}
>  
> +    if (!strcmp(argv[1], "get_filter_for_commit")) {
> +		struct object_id oid;
> +		const char *end;
> +		if (parse_oid_hex(argv[2], &oid, &end))
> +			die("cannot parse oid '%s'", argv[2]);
> +		init_bloom_filters();
> +		get_bloom_filter_for_commit(&oid);
> +	}
> +
>  	return 0;
>  }
> \ No newline at end of file
> diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
> index 36a086c7c60..8f9eef116dc 100755
> --- a/t/t0095-bloom.sh
> +++ b/t/t0095-bloom.sh
> @@ -67,4 +67,51 @@ test_expect_success 'compute bloom key for test string 2' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'get bloom filters for commit with no changes' '
> +	git init &&
> +	git commit --allow-empty -m "c0" &&
> +	cat >expect <<-\EOF &&
> +	Filter_Length:0
> +	Filter_Data:
> +	EOF
> +	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'get bloom filter for commit with 10 changes' '
> +	rm actual &&
> +	rm expect &&
> +	mkdir smallDir &&
> +	for i in $(test_seq 0 9)
> +	do
> +		echo $i >smallDir/$i
> +	done &&
> +	git add smallDir &&
> +	git commit -m "commit with 10 changes" &&
> +	cat >expect <<-\EOF &&
> +	Filter_Length:25
> +	Filter_Data:82|a0|65|47|0c|92|90|c0|a1|40|02|a0|e2|40|e0|04|0a|9a|66|cf|80|19|85|42|23|
> +	EOF
> +	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
> +	rm actual &&
> +	rm expect &&
> +	mkdir bigDir &&
> +	for i in $(test_seq 0 512)
> +	do
> +		echo $i >bigDir/$i
> +	done &&
> +	git add bigDir &&
> +	git commit -m "commit with 513 changes" &&
> +	cat >expect <<-\EOF &&
> +	Filter_Length:0
> +	Filter_Data:
> +	EOF
> +	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> \ No newline at end of file
> -- 
> gitgitgadget
> 
