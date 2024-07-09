Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF21B86D5
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720553696; cv=none; b=cbv3MUwdIO1x5JxleRdufLqB72d7Oj0flv1cjkc8fIBMb6WzUH9tAVGGuG1E+2oWWMMYYQZtmkhI90ldjloidJZKTXX5fNcwNJTau8wmds5lEf+H2Tj8l+a6Qau79h/Eo6vjQjxr9RR7WZkU4H0kcaYva8oRaQn3blL82ETR58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720553696; c=relaxed/simple;
	bh=BQBegHGjs0+BHrZyTIfBzhYTtpK0YbYdWum1nPCI3dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKcPik3lqgIENwZ57RuOXKAtsB/b9TgcB+dR0RGyP7IaxBc9j+3piYQrxSaBirsWuiqNAwQsThff5TnlkFtySO4b+DBbEosdSc8iFJv4sexOP+8/JokumhjdRFVlutzZHn49OXmaAvAA0nUR0anfDtvluQa3lhQWWl8FSfCz+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WzUkEL4J; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzUkEL4J"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b3c0a00f2so1403530b3a.3
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720553694; x=1721158494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6vVnf1kBUg4NoDOyiQEl0toGS39zwuhBDZ2w/cqCTQ=;
        b=WzUkEL4J3eOOvoxNwUvLrxIJCTxiumAFLzfQLv00TWDFJueVktq/1zEX9G8g55/jMC
         gMQGtnW/tgAxwT1y1RPGgIzcB65HaJlgtUi1G4RX5Z0NQnyga7TkaJBnZLmSXRbSgJw5
         VZ/RcKQptgsqRffhIn83CYfz+oBQ2M4udWsx8P/gmK66wPhM6B3UPyJda00Rz6F+AD7F
         efyS1mtRVpJVM3gtFpUfs1r5DOpuwE0a/rv2oQiE/VyJYE61nzEMtpynO0XhAXK3/nhv
         U/edc3g/CqDYunyzzbUdxNGp+OiVcC4XpEGgw3jlMEp0dpR2PHuuL/8o/5zTP6NdmkS4
         QpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720553694; x=1721158494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6vVnf1kBUg4NoDOyiQEl0toGS39zwuhBDZ2w/cqCTQ=;
        b=TXF8aVkmf3/29nMrSAqDkykR1I/N2YeOyIiq2OsalRzw17iXIzRM/qA48Ru9XV1diV
         Wp3CTYEP2Q8I1VLAsIFZA+0av6m/eq+YONd0GFVZidWyLFswBddxkd1X3DITw6WHG2iU
         gb6zQd7X3ujEZe2naqZ6YxLo++WVN4HPOJa17MlozErEAiupVLNMtmSkxpj0bMcmnYq0
         10txCgm6lObTOQ5H+1+R/OyPf4WVGK4+WTw1HLalgKr5KDUazDOlD3AG25YSM+sZrs82
         M7gW3uy03V4ZTeyRdmK1rRsBPlvNvi+H6SE0a5KpOV61RkCDQ6rNDdetVtEcMtWe0vcT
         /NzQ==
X-Gm-Message-State: AOJu0YzWuJvpgIgMelCXtJaR3W4JBtoBqdaW6MC0Dq75fkxGke/6EIOE
	Npa+jLm01Bdirplqek9DotJ0quEOud+IK58v9Q8cKZIqygVsjgZzaIlA3orGEV1Mhy4ynXNVbp3
	X9w==
X-Google-Smtp-Source: AGHT+IGgeTiWdkm+fM0DEd3OU6X2JQ1R+ZG6iJiAcSTKuG1do264bnH4lSVEB5weUIXIzeqUj0iIkQ==
X-Received: by 2002:a05:6a20:918c:b0:1c2:8904:14c2 with SMTP id adf61e73a8af0-1c29824364dmr4172529637.37.1720553693682;
        Tue, 09 Jul 2024 12:34:53 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:d734:a15:9ca7:2896])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa607e4sm10421862a91.40.2024.07.09.12.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 12:34:53 -0700 (PDT)
Date: Tue, 9 Jul 2024 12:34:47 -0700
From: Josh Steadmon <steadmon@google.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: port helper/test-hashmap.c to
 unit-tests/t-hashmap.c
Message-ID: <mlnerj7j6knamzj3ipnd7rgqd6xm5xrjep35rldhv6sikzipu5@72szgbso6cpo>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20240628124149.43688-1-shyamthakkar001@gmail.com>
 <20240708161641.10335-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708161641.10335-2-shyamthakkar001@gmail.com>


This looks like a good conversion to me. There are a few small
improvements that could be made, but mostly LGTM. Comments are inline
below.


On 2024.07.08 21:45, Ghanshyam Thakkar wrote:
> helper/test-hashmap.c along with t0011-hashmap.sh test the hashmap.h
> library. Migrate them to the unit testing framework for better
> debugging, runtime performance and consice code.

Typo: s/consice/concise/

> Along with the migration, make 'add' tests from the shellscript order
> agnostic in unit tests, since they iterate over entries with the same
> keys and we do not guarantee the order.
> 
> The helper/test-hashmap.c is still not removed because it contains a
> performance test meant to be run by the user directly (not used in
> t/perf). And it makes sense for such a utility to be a helper.
> 
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> The changes in v2 are inspired from the review of another similar
> test t-oidmap: https://lore.kernel.org/git/16e06a6d-5fd0-4132-9d82-5c6f13b7f9ed@gmail.com/
> 
> The v2 also includes some formatting corrections and one of the
> testcases, t_add(), was changed to be more similar to the original.
> 
>  Makefile                 |   1 +
>  t/helper/test-hashmap.c  | 100 +----------
>  t/t0011-hashmap.sh       | 260 ----------------------------
>  t/unit-tests/t-hashmap.c | 359 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 362 insertions(+), 358 deletions(-)
>  delete mode 100755 t/t0011-hashmap.sh
>  create mode 100644 t/unit-tests/t-hashmap.c

[snip]

> diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/t-hashmap.c
> new file mode 100644
> index 0000000000..1c951fcfd8
> --- /dev/null
> +++ b/t/unit-tests/t-hashmap.c
> @@ -0,0 +1,359 @@
> +#include "test-lib.h"
> +#include "hashmap.h"
> +#include "strbuf.h"
> +
> +struct test_entry {
> +	int padding; /* hashmap entry no longer needs to be the first member */
> +	struct hashmap_entry ent;
> +	/* key and value as two \0-terminated strings */
> +	char key[FLEX_ARRAY];
> +};
> +
> +static int test_entry_cmp(const void *cmp_data,
> +			  const struct hashmap_entry *eptr,
> +			  const struct hashmap_entry *entry_or_key,
> +			  const void *keydata)
> +{
> +	const int ignore_case = cmp_data ? *((int *)cmp_data) : 0;
> +	const struct test_entry *e1, *e2;
> +	const char *key = keydata;
> +
> +	e1 = container_of(eptr, const struct test_entry, ent);
> +	e2 = container_of(entry_or_key, const struct test_entry, ent);
> +
> +	if (ignore_case)
> +		return strcasecmp(e1->key, key ? key : e2->key);
> +	else
> +		return strcmp(e1->key, key ? key : e2->key);
> +}
> +
> +static const char *get_value(const struct test_entry *e)
> +{
> +	return e->key + strlen(e->key) + 1;
> +}
> +
> +static struct test_entry *alloc_test_entry(unsigned int ignore_case,
> +					   const char *key, const char *value)
> +{
> +	size_t klen = strlen(key);
> +	size_t vlen = strlen(value);
> +	unsigned int hash = ignore_case ? strihash(key) : strhash(key);
> +	struct test_entry *entry = xmalloc(st_add4(sizeof(*entry), klen, vlen, 2));
> +
> +	hashmap_entry_init(&entry->ent, hash);
> +	memcpy(entry->key, key, klen + 1);
> +	memcpy(entry->key + klen + 1, value, vlen + 1);
> +	return entry;
> +}

So we're duplicating `struct test_entry`, `test_entry_cmp()`, and
`alloc_test_entry()`, which have (almost) identical definitions in
t/helper/test-hashmap.c. I wonder if it's worth splitting these into a
separate .c file. Maybe it's too much of a pain to add Makefile rules to
share objects across the test helper and the unit tests. Something to
keep in mind I guess, if we find that we want to share more code than
this.


> +static struct test_entry *get_test_entry(struct hashmap *map,
> +					 unsigned int ignore_case, const char *key)
> +{
> +	return hashmap_get_entry_from_hash(
> +		map, ignore_case ? strihash(key) : strhash(key), key,
> +		struct test_entry, ent);
> +}
> +
> +static int key_val_contains(const char *key_val[][3], size_t n,
> +			    struct test_entry *entry)
> +{
> +	for (size_t i = 0; i < n; i++) {
> +		if (!strcmp(entry->key, key_val[i][0]) &&
> +		    !strcmp(get_value(entry), key_val[i][1])) {
> +			if (!strcmp(key_val[i][2], "USED"))
> +				return 2;
> +			key_val[i][2] = "USED";
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}
> +
> +static void setup(void (*f)(struct hashmap *map, int ignore_case),
> +		  int ignore_case)
> +{
> +	struct hashmap map = HASHMAP_INIT(test_entry_cmp, &ignore_case);
> +
> +	f(&map, ignore_case);
> +	hashmap_clear_and_free(&map, struct test_entry, ent);
> +}

As I mentioned in my review [1] on René's TEST_RUN series, I don't think
we get much value out of having a setup + callback approach when the
setup is minimal. Would you consider rewriting a v2 using TEST_RUN once
that is ready in `next`?

[1] https://lore.kernel.org/git/tswyfparvchgi7qxrjxbx4eb7cohypzekjqzbnkbffsesaiazs@vtewtz7o6twi/

> +static void t_put(struct hashmap *map, int ignore_case)
> +{
> +	struct test_entry *entry;
> +	const char *key_val[][2] = { { "key1", "value1" },
> +				     { "key2", "value2" },
> +				     { "fooBarFrotz", "value3" } };
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
> +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> +		check(hashmap_put_entry(map, entry, ent) == NULL);
> +	}
> +
> +	entry = alloc_test_entry(ignore_case, "foobarfrotz", "value4");
> +	entry = hashmap_put_entry(map, entry, ent);
> +	check(ignore_case ? entry != NULL : entry == NULL);
> +	free(entry);
> +
> +	check_int(map->tablesize, ==, 64);
> +	check_int(hashmap_get_size(map), ==,
> +		  ignore_case ? ARRAY_SIZE(key_val) : ARRAY_SIZE(key_val) + 1);
> +}

Ahhh, so you're using the same function for both case-sensitive and
-insensitive tests. So I guess TEST_RUN isn't useful here after all.
Personally I'd still rather get rid of setup(), but I don't feel super
strongly about it.


> +static void t_replace(struct hashmap *map, int ignore_case)
> +{
> +	struct test_entry *entry;
> +
> +	entry = alloc_test_entry(ignore_case, "key1", "value1");
> +	check(hashmap_put_entry(map, entry, ent) == NULL);
> +
> +	entry = alloc_test_entry(ignore_case, ignore_case ? "Key1" : "key1",
> +				 "value2");
> +	entry = hashmap_put_entry(map, entry, ent);
> +	if (check(entry != NULL))
> +		check_str(get_value(entry), "value1");
> +	free(entry);
> +
> +	entry = alloc_test_entry(ignore_case, "fooBarFrotz", "value3");
> +	check(hashmap_put_entry(map, entry, ent) == NULL);
> +
> +	entry = alloc_test_entry(ignore_case,
> +				 ignore_case ? "foobarfrotz" : "fooBarFrotz",
> +				 "value4");
> +	entry = hashmap_put_entry(map, entry, ent);
> +	if (check(entry != NULL))
> +		check_str(get_value(entry), "value3");
> +	free(entry);
> +}
> +
> +static void t_get(struct hashmap *map, int ignore_case)
> +{
> +	struct test_entry *entry;
> +	const char *key_val[][2] = { { "key1", "value1" },
> +				     { "key2", "value2" },
> +				     { "fooBarFrotz", "value3" },
> +				     { ignore_case ? "key4" : "foobarfrotz", "value4" } };
> +	const char *query[][2] = {
> +		{ ignore_case ? "Key1" : "key1", "value1" },
> +		{ ignore_case ? "keY2" : "key2", "value2" },
> +		{ ignore_case ? "foobarfrotz" : "fooBarFrotz", "value3" }
> +	};
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
> +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> +		check(hashmap_put_entry(map, entry, ent) == NULL);
> +	}
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(query); i++) {
> +		entry = get_test_entry(map, ignore_case, query[i][0]);
> +		if (check(entry != NULL))
> +			check_str(get_value(entry), query[i][1]);
> +	}
> +
> +	check(get_test_entry(map, ignore_case, "notInMap") == NULL);
> +}
> +
> +static void t_add(struct hashmap *map, int ignore_case)
> +{
> +	struct test_entry *entry;
> +	const char *key_val[][3] = {
> +		{ "key1", "value1", "UNUSED" },
> +		{ ignore_case ? "Key1" : "key1", "value2", "UNUSED" },
> +		{ "fooBarFrotz", "value3", "UNUSED" },
> +		{ ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4", "UNUSED" }
> +	};
> +	const char *queries[] = { "key1",
> +				  ignore_case ? "Foobarfrotz" : "fooBarFrotz" };
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
> +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> +		hashmap_add(map, &entry->ent);
> +	}
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(queries); i++) {

Since we only have one query, can we remove the loop and simplify the
following block of code?

Also (here and elsewhere), it might be less confusing to say "UNSEEN" /
"SEEN" instead of "UNUSED" / "USED". The latter makes it sound to me
like there's some API requirement to have a 3-item array that we don't
actually need, but in this case those fields are actually used in
key_val_contains() to track duplicates.


> +		int count = 0;
> +		entry = hashmap_get_entry_from_hash(map,
> +			ignore_case ? strihash(queries[i]) :
> +				      strhash(queries[i]),
> +			queries[i], struct test_entry, ent);
> +
> +		hashmap_for_each_entry_from(map, entry, ent)
> +		{
> +			int ret;
> +			if (!check_int((ret = key_val_contains(
> +						key_val, ARRAY_SIZE(key_val),
> +						entry)), ==, 0)) {
> +				switch (ret) {
> +				case 1:
> +					test_msg("found entry was not given in the input\n"
> +						 "    key: %s\n  value: %s",
> +						 entry->key, get_value(entry));
> +					break;
> +				case 2:
> +					test_msg("duplicate entry detected\n"
> +						 "    key: %s\n  value: %s",
> +						 entry->key, get_value(entry));
> +					break;
> +				}
> +			} else {
> +				count++;
> +			}
> +		}
> +		check_int(count, ==, 2);
> +	}
> +	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
> +	check(get_test_entry(map, ignore_case, "notInMap") == NULL);
> +}
> +
> +static void t_remove(struct hashmap *map, int ignore_case)
> +{
> +	struct test_entry *entry, *removed;
> +	const char *key_val[][2] = { { "key1", "value1" },
> +				     { "key2", "value2" },
> +				     { "fooBarFrotz", "value3" } };
> +	const char *remove[][2] = { { ignore_case ? "Key1" : "key1", "value1" },
> +				    { ignore_case ? "keY2" : "key2", "value2" } };
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
> +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> +		check(hashmap_put_entry(map, entry, ent) == NULL);
> +	}
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(remove); i++) {
> +		entry = alloc_test_entry(ignore_case, remove[i][0], "");
> +		removed = hashmap_remove_entry(map, entry, ent, remove[i][0]);
> +		if (check(removed != NULL))
> +			check_str(get_value(removed), remove[i][1]);
> +		free(entry);
> +		free(removed);
> +	}
> +
> +	entry = alloc_test_entry(ignore_case, "notInMap", "");
> +	check(hashmap_remove_entry(map, entry, ent, "notInMap") == NULL);
> +	free(entry);
> +}

Is there a reason why you don't check the table size as the shell test
did? (similar to what you have in t_put())

> +static void t_iterate(struct hashmap *map, int ignore_case)
> +{
> +	struct test_entry *entry;
> +	struct hashmap_iter iter;
> +	const char *key_val[][3] = { { "key1", "value1", "UNUSED" },
> +				     { "key2", "value2", "UNUSED" },
> +				     { "fooBarFrotz", "value3", "UNUSED" } };
> +	int count = 0;
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
> +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
> +		check(hashmap_put_entry(map, entry, ent) == NULL);
> +	}
> +
> +	hashmap_for_each_entry(map, &iter, entry, ent /* member name */)
> +	{
> +		int ret;
> +		if (!check_int((ret = key_val_contains(key_val, ARRAY_SIZE(key_val),
> +						       entry)), ==, 0)) {
> +			switch (ret) {
> +			case 1:
> +				test_msg("found entry was not given in the input\n"
> +					 "    key: %s\n  value: %s",
> +					 entry->key, get_value(entry));
> +				break;
> +			case 2:
> +				test_msg("duplicate entry detected\n"
> +					 "    key: %s\n  value: %s",
> +					 entry->key, get_value(entry));
> +				break;
> +			}
> +		} else {
> +			count++;
> +		}
> +	}
> +	check_int(count, ==, ARRAY_SIZE(key_val));
> +	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
> +}
> +
> +static void t_alloc(struct hashmap *map, int ignore_case)
> +{
> +	struct test_entry *entry, *removed;
> +
> +	for (int i = 1; i <= 51; i++) {
> +		char *key = xstrfmt("key%d", i);
> +		char *value = xstrfmt("value%d", i);
> +		entry = alloc_test_entry(ignore_case, key, value);
> +		check(hashmap_put_entry(map, entry, ent) == NULL);
> +		free(key);
> +		free(value);
> +	}
> +	check_int(map->tablesize, ==, 64);
> +	check_int(hashmap_get_size(map), ==, 51);
> +
> +	entry = alloc_test_entry(ignore_case, "key52", "value52");
> +	check(hashmap_put_entry(map, entry, ent) == NULL);
> +	check_int(map->tablesize, ==, 256);
> +	check_int(hashmap_get_size(map), ==, 52);
> +
> +	for (int i = 1; i <= 12; i++) {
> +		char *key = xstrfmt("key%d", i);
> +		char *value = xstrfmt("value%d", i);
> +
> +		entry = alloc_test_entry(ignore_case, key, "");
> +		removed = hashmap_remove_entry(map, entry, ent, key);
> +		if (check(removed != NULL))
> +			check_str(value, get_value(removed));
> +		free(key);
> +		free(value);
> +		free(entry);
> +		free(removed);
> +	}
> +	check_int(map->tablesize, ==, 256);
> +	check_int(hashmap_get_size(map), ==, 40);
> +
> +	entry = alloc_test_entry(ignore_case, "key40", "");
> +	removed = hashmap_remove_entry(map, entry, ent, "key40");
> +	if (check(removed != NULL))
> +		check_str("value40", get_value(removed));
> +	check_int(map->tablesize, ==, 64);
> +	check_int(hashmap_get_size(map), ==, 39);
> +	free(entry);
> +	free(removed);
> +}
> +
> +static void t_intern(struct hashmap *map, int ignore_case)
> +{
> +	const char *values[] = { "value1", "Value1", "value2", "value2" };
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(values); i++) {
> +		const char *i1 = strintern(values[i]);
> +		const char *i2 = strintern(values[i]);
> +
> +		if (!check(!strcmp(i1, values[i])))

Should we use check_str() here? Or does that add too much extraneous
detail when the test_msg() below is what we really care about?

> +			test_msg("strintern(%s) returns %s\n", values[i], i1);
> +		else if (!check(i1 != values[i]))

Similarly, check_pointer_eq() here?


> +			test_msg("strintern(%s) returns input pointer\n",
> +				 values[i]);
> +		else if (!check(i1 == i2))

And check_pointer_eq() here as well.


> +			test_msg("address('%s') != address('%s'), so strintern('%s') != strintern('%s')",
> +				 i1, i2, values[i], values[i]);
> +		else
> +			check_str(i1, values[i]);
> +	}
> +}
> +
> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +{
> +	TEST(setup(t_put, 0), "put works");
> +	TEST(setup(t_put, 1), "put (case insensitive) works");
> +	TEST(setup(t_replace, 0), "replace works");
> +	TEST(setup(t_replace, 1), "replace (case insensitive) works");
> +	TEST(setup(t_get, 0), "get works");
> +	TEST(setup(t_get, 1), "get (case insensitive) works");
> +	TEST(setup(t_add, 0), "add works");
> +	TEST(setup(t_add, 1), "add (case insensitive) works");
> +	TEST(setup(t_remove, 0), "remove works");
> +	TEST(setup(t_remove, 1), "remove (case insensitive) works");
> +	TEST(setup(t_iterate, 0), "iterate works");
> +	TEST(setup(t_iterate, 1), "iterate (case insensitive) works");
> +	TEST(setup(t_alloc, 0), "grow / shrink works");
> +	TEST(setup(t_intern, 0), "string interning works");
> +	return test_done();
> +}
> -- 
> 2.45.2
> 
> 
