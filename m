Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA81F181F
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743630984; cv=none; b=hwxX4h2TWwSeSYjZL+MbhlNRnKNjaolIZXdrT6m5Edmc42uET2nH4/H/QcQ/6AxTVgbg3J5PczYOll5rrDQQtzMMXbSOyVboiECrJjg4zqZy8gxKossZBZvEHpivRA7sh9JHLfOXB/O73EWtLqr4eGIXtWXGvAzBEkYA0RHxbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743630984; c=relaxed/simple;
	bh=Qb8FbEZN/RxmH/5qg5fv80KM2fMX/RNzPO62CI9pTgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeZCK9H5RFZS1th0J2mi2M3FrOlj+RjS+DjSNhD9cQLxj6USRXu3rlZNw5NrCTuRnDNa/1Kbu48tsHSPUuHIhQIgeeRfq6DTuNeApQlMyu72W2HGmJTHCfUKyip+m3q3KVxaAcGdvbtUU6QZTTwM9KOyOKiTTSjBapo49G1MQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKYgq0GW; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKYgq0GW"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-60219a77334so136425eaf.1
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743630981; x=1744235781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKCk71uHCOnRV58KFEluo+9pz0Q4e/RbFOYJY2r1+dc=;
        b=eKYgq0GWmpXPLfn8s44BWErnBFShvrAyrTh5UlcmDRB8gWF538uZtAx5u2X+8K4q6J
         s9pmcARp4DOJ6WLSSJgXtjiwT3v/8Jn5SIJQHxfqcAfVlUPew9mZ98bSWLh1DhyQ+tFA
         pcWk7PxSOVFBZcoMaHO20govBsRuI2m04iHxYNN+WE2uLNSZEYvQb0aCs7R65FB+FrUE
         L6ICuSQkZ5cMbnwSlECGL1Un+UX5zMmEoAIeeOeO8OJE+3sOq6wNzszjZHtlsqJ6zqnx
         RiEo9tbHLj1JdTfAXBSp6ZYLGTYMP5s+HLvOBH5vW6kN/zsMh5tEx/B6IYNJbIs0WLbk
         Ehyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743630981; x=1744235781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKCk71uHCOnRV58KFEluo+9pz0Q4e/RbFOYJY2r1+dc=;
        b=lKy1WGrOKB0ZtpDB3Q9fRdtNCW0FhATZ9h4qOa6L3EPXncLOFbVJtimP9TzpU3DxtC
         aF00qF/0BjEngrz6r9qmmOlKUFW4tewJjFhieAQFlU9bXhmknsvPjHfBjR1tAq1xWjAj
         1JrIXHbIQXz83NH78WRzv7BzrCn0lUYAcG4msMz2Q2aczYRAbk0AYr370OhvPbrApo6R
         n16M30NbfYs+F+M82pUd10u1NF9MQVl85Cf26377cSxJilunoth52AypKFEBywCbfKC5
         MOwjSnVD2SEOWVWhF+IOnh85yjfQ17BZvkkvuqjGZCoKnVTyMEuVFMxcsMn2Z/p5KLCV
         3IeA==
X-Gm-Message-State: AOJu0YwejLf3ScCukBV62qjBRuZxT5kC+40PbJv5OWQxUGZZgc5EQVKF
	OFB2B1LFxouY9qeqFqOr4415FD1rDRNc52K1GH3Zpqmol8euAh83SVmypg==
X-Gm-Gg: ASbGncsx6wyxwPS+OO9uThu3AwpZNovhehhsT5T5dQCSIOB6iTXK8axGgvwq5HqdUaX
	MymZ+qLvDoN9OmLXYGFDmnxK4hm1aHbOOMVjBDsdv5QkFm97GMPcfUvxI6Gx9nxo/JJKyeBV+Gc
	8GJTUR+3WBwEm/lbeUhpQQ7AC+9bBkreQNEqMVkwvVDdJRulJpGh2HDjEE6PE3uDSGHb4KFWNmz
	sqCJ/ItpSC1f+4+lixAfcwQtqxvdwttfnlM2W1lTX4MNiICbOhgS8iFI6kWDBjKLufAOlX7dIXH
	nklTf7zig8WaZIsDjMOJJtu3gz7sIWCWb+bQGw==
X-Google-Smtp-Source: AGHT+IFpenI7MrnJtapyzbFwuEdc8qTVrBiPyCwT1mSsEMO1nxWST92M/zB+RwGKmdoh90/PN3NHlA==
X-Received: by 2002:a05:6808:d4e:b0:3fa:82f6:f768 with SMTP id 5614622812f47-3ff0f5b43b9mr10637196b6e.27.1743630981441;
        Wed, 02 Apr 2025 14:56:21 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-6040c4cddcbsm10476eaf.16.2025.04.02.14.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 14:56:20 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:52:32 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 16/16] reftable/table: move printing logic into test
 helper
Message-ID: <dlrvun53gnrd7lcwjp5m3q6q2gjjavdxnuhj4kie7hp2gfcskb@e7m3mnvk7rbu>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-16-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-pks-reftable-polishing-v1-16-ebed5247434c@pks.im>

On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> The logic to print individual blocks in a table is hosted in the
> reftable library. This is only the case due to historical reasons though
> because users of the library had no interfaces to read blocks one by
> one. Otherwise, printing individual blocks has no place in the reftable
> library given that the format will not be generic in the first place.
> 
> We have now grown a public interface to iterate through blocks contained
> in a table, and thus we can finally move the logic to print them into
> the test helper.
> 
> Move over the logic and refactor it accordingly. Note that the iterator
> also trivially allows us to access index sections, which we previously
> didn't print at all. This omission wasn't intentional though, so start
> dumping those sections as well so that we can assert that indices are
> written as expected.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/reftable-table.h         |  3 --
>  reftable/table.c                  | 65 ------------------------------------
>  t/helper/test-reftable.c          | 69 ++++++++++++++++++++++++++++++++++++++-
>  t/t0613-reftable-write-options.sh |  9 +++++
>  4 files changed, 77 insertions(+), 69 deletions(-)
> 
> diff --git a/reftable/reftable-table.h b/reftable/reftable-table.h
> index f0f1784c664..293fffbddc6 100644
> --- a/reftable/reftable-table.h
> +++ b/reftable/reftable-table.h
> @@ -97,9 +97,6 @@ uint64_t reftable_table_max_update_index(struct reftable_table *t);
>  /* return the min_update_index for a table */
>  uint64_t reftable_table_min_update_index(struct reftable_table *t);
>  
> -/* print blocks onto stdout for debugging. */
> -int reftable_table_print_blocks(const char *tablename);
> -
>  /*
>   * An iterator that iterates through the blocks contained in a given table.
>   */
> diff --git a/reftable/table.c b/reftable/table.c
> index 48f0cdfd42b..8a7581b9800 100644
> --- a/reftable/table.c
> +++ b/reftable/table.c
> @@ -740,71 +740,6 @@ uint64_t reftable_table_min_update_index(struct reftable_table *t)
>  	return t->min_update_index;
>  }
>  
> -int reftable_table_print_blocks(const char *tablename)
> -{
> -	struct {
> -		const char *name;
> -		int type;
> -	} sections[] = {
> -		{
> -			.name = "ref",
> -			.type = REFTABLE_BLOCK_TYPE_REF,
> -		},
> -		{
> -			.name = "obj",
> -			.type = REFTABLE_BLOCK_TYPE_OBJ,
> -		},
> -		{
> -			.name = "log",
> -			.type = REFTABLE_BLOCK_TYPE_LOG,
> -		},
> -	};
> -	struct reftable_block_source src = { 0 };
> -	struct reftable_table *table = NULL;
> -	struct table_iter ti = { 0 };
> -	size_t i;
> -	int err;
> -
> -	err = reftable_block_source_from_file(&src, tablename);
> -	if (err < 0)
> -		goto done;
> -
> -	err = reftable_table_new(&table, &src, tablename);
> -	if (err < 0)
> -		goto done;
> -
> -	table_iter_init(&ti, table);
> -
> -	printf("header:\n");
> -	printf("  block_size: %d\n", table->block_size);
> -
> -	for (i = 0; i < sizeof(sections) / sizeof(*sections); i++) {
> -		err = table_iter_seek_start(&ti, sections[i].type, 0);
> -		if (err < 0)
> -			goto done;
> -		if (err > 0)
> -			continue;
> -
> -		printf("%s:\n", sections[i].name);
> -
> -		while (1) {
> -			printf("  - length: %u\n", ti.block.restart_off);
> -			printf("    restarts: %u\n", ti.block.restart_count);
> -
> -			err = table_iter_next_block(&ti);
> -			if (err < 0)
> -				goto done;
> -			if (err > 0)
> -				break;
> -		}
> -	}
> -
> -done:
> -	reftable_table_decref(table);
> -	table_iter_close(&ti);
> -	return err;
> -}

How that we have a table iterator exposed to iterate over the records we
can remove `reftable_table_print_blocks()` from the reftable library.
Make sense.

>  int reftable_table_init_table_iterator(struct reftable_table *t,
>  				       struct reftable_table_iterator *it)
>  {
> diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
> index f8f1956f4f3..c465137826c 100644
> --- a/t/helper/test-reftable.c
> +++ b/t/helper/test-reftable.c
> @@ -2,6 +2,7 @@
>  #include "hash.h"
>  #include "hex.h"
>  #include "reftable/system.h"
> +#include "reftable/reftable-constants.h"
>  #include "reftable/reftable-error.h"
>  #include "reftable/reftable-merged.h"
>  #include "reftable/reftable-stack.h"
> @@ -20,6 +21,72 @@ static void print_help(void)
>  	       "\n");
>  }
>  
> +static int dump_blocks(const char *tablename)
> +{
> +	struct reftable_table_iterator ti = { 0 };
> +	struct reftable_block_source src = { 0 };
> +	struct reftable_table *table = NULL;
> +	uint8_t section_type = 0;
> +	int err;
> +
> +	err = reftable_block_source_from_file(&src, tablename);
> +	if (err < 0)
> +		goto done;
> +
> +	err = reftable_table_new(&table, &src, tablename);
> +	if (err < 0)
> +		goto done;
> +
> +	err = reftable_table_init_table_iterator(table, &ti);
> +	if (err < 0)
> +		goto done;
> +
> +	printf("header:\n");
> +	printf("  block_size: %d\n", table->block_size);
> +
> +	while (1) {
> +		const struct reftable_block *block;
> +
> +		err = reftable_table_iterator_next(&ti, &block);
> +		if (err < 0)
> +			goto done;
> +		if (err > 0)
> +			break;
> +
> +		if (block->block_type != section_type) {
> +			const char *section;
> +			switch (block->block_type) {
> +			case REFTABLE_BLOCK_TYPE_LOG:
> +				section = "log";
> +				break;
> +			case REFTABLE_BLOCK_TYPE_REF:
> +				section = "ref";
> +				break;
> +			case REFTABLE_BLOCK_TYPE_OBJ:
> +				section = "obj";
> +				break;
> +			case REFTABLE_BLOCK_TYPE_INDEX:
> +				section = "idx";
> +				break;
> +			default:
> +				err = -1;
> +				goto done;
> +			}
> +
> +			section_type = block->block_type;
> +			printf("%s:\n", section);
> +		}
> +
> +		printf("  - length: %u\n", block->restart_off);
> +		printf("    restarts: %u\n", block->restart_count);
> +	}
> +
> +done:
> +	reftable_table_iterator_release(&ti);
> +	reftable_table_decref(table);
> +	return err;
> +}
> +
>  static int dump_table(struct reftable_merged_table *mt)
>  {
>  	struct reftable_iterator it = { NULL };
> @@ -184,7 +251,7 @@ int cmd__dump_reftable(int argc, const char **argv)
>  	arg = argv[1];
>  
>  	if (opt_dump_blocks) {
> -		err = reftable_table_print_blocks(arg);
> +		err = dump_blocks(arg);

Nice!

>  	} else if (opt_dump_table) {
>  		err = dump_reftable(arg);
>  	} else if (opt_dump_stack) {
> diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
> index e2708e11d5b..e4c7461ce9e 100755
> --- a/t/t0613-reftable-write-options.sh
> +++ b/t/t0613-reftable-write-options.sh
> @@ -93,6 +93,9 @@ test_expect_success 'many refs results in multiple blocks' '
>  		    restarts: 3
>  		  - length: 3289
>  		    restarts: 3
> +		idx:
> +		  - length: 103
> +		    restarts: 1
>  		EOF
>  		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
>  		test_cmp expect actual
> @@ -241,6 +244,9 @@ test_expect_success 'object index gets written by default with ref index' '
>  		    restarts: 1
>  		  - length: 80
>  		    restarts: 1
> +		idx:
> +		  - length: 55
> +		    restarts: 2
>  		obj:
>  		  - length: 11
>  		    restarts: 1
> @@ -277,6 +283,9 @@ test_expect_success 'object index can be disabled' '
>  		    restarts: 1
>  		  - length: 80
>  		    restarts: 1
> +		idx:
> +		  - length: 55
> +		    restarts: 2
>  		EOF
>  		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
>  		test_cmp expect actual
> 
> -- 
> 2.49.0.604.gff1f9ca942.dirty
> 
> 
