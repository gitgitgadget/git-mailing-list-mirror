Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3E1CA87
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720110833; cv=none; b=VWePdYSgYxp8NOffrxiTv1kyWQP0TWyp3OlyMDZSf3VRvQIl2QmczP05X1lgd3827W+WtcPWEB6pWC1PAa70+n6dL0LhJFyZP3w7AtelmTLrmaRImQEo7B6Vd5eD1zKPMzP7/q7UuaVlpg17T3yOR8i3Y10qMLC9HmNfy0BK3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720110833; c=relaxed/simple;
	bh=I+ZSenTnetkZEmVU4oWpKDKJf/6GoSOGkoCaZgq8/YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPjyAvvM5NzHsq7n1fdUG6tkOAefngaPPWYXOAePGzjiwxdKv1pu9am99ncBAYiP00U2mjt4WuQWt1HqIgmAb5x/d2nJdLWQ7+XiDAw05ormAx4mBteyE9uGaUZ7NN81Z0O+m4drzRTCvPu+KQclCNP3OriU9RUB60IIWKunO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIJaPYO+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIJaPYO+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42562fde108so5530495e9.0
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720110830; x=1720715630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt8INSU/veqPoQ91X3cHY1kPFMKMkvwdlbLuOqlJDt8=;
        b=TIJaPYO+2D5YK4iH2Y5xShiFyxuxnzJMM8kZBLbM7mcM8oiA124SNOBOVVvleC99sd
         bxDkTTRkyrfqc4i+HtSAngpajlWBbYsgXsBm4T98dj7jcFrn7vUz42Y3tqyuaBYzRvW0
         xDiPIA3qu8+TRc1kPI0IzIHDzTkJU5jN4O+1Fo4DN+HuhpD+2RfljWxRCp1xaFkywulr
         +nRCtK3HT5jNzP4ta9qIQo42fhHLVL5XALZvj9kLIUbNDpoBdbBgphcgXamMRbe7iDCH
         OR62Qyiv7BUshY8TKBVO1SVQy7I5do9MsR+RMPNwPOYGQ+0+pVSaFREAl4FBPu050aAm
         HqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720110830; x=1720715630;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yt8INSU/veqPoQ91X3cHY1kPFMKMkvwdlbLuOqlJDt8=;
        b=XBz8tub0QkZNAJbZGhm3HQTxH3TDr/ExCIkKq2jxMn1gl7k3RoMLEjx7duHkQ+byS+
         xrsI2eNEhVyGVC0b01jYD9qzCUFv0hBeyWkuzl1657qfLMfHVTIYHSFllrwuUrzcIUmv
         apSLQsiTyBa2XAB/vahFXI3oFvFuSXIxstKalkNKAkUIE/xwqebDUJpO1CKhU5ui9W9o
         MSWDlJa81duijj9h+/IfSKnYugUBFx81CqvaLWNSTxrh16ajQJLcU0WRw7D8ay4+1SW7
         BbwtgyXnvD8K8Yes+YagbiUqcfQ4xTaK4Xj5zrPubkC8u8yB4S5OwlsuxOL/sJ26kT3a
         abhw==
X-Forwarded-Encrypted: i=1; AJvYcCX6nxE1BmDQDwW3GMMrH+h9X1Tkuar4DuUhiYLdodXpZBP1pmhQh8bSSJzzqe6iU2p+GfNOVIE6DskI3YwxSgn6LAWq
X-Gm-Message-State: AOJu0YxbJYlh+S0/MRGOjzx2dLO5lhfDiQnkFlfqq1A6SdQPssOSBK2M
	N0kz3GWsqHrKvnlXVLZqWSv223lgtO834jZhdFpDs8UbkCtKWWVE
X-Google-Smtp-Source: AGHT+IFEByhnOMVRW8CwPGhnsz+5SoxE9u+jSLmpc0OF4Y4ZjO0w6PX5ri3K+iu0sj2JFl3mETJL9g==
X-Received: by 2002:a05:600c:158b:b0:422:62db:5a02 with SMTP id 5b1f17b1804b1-4264a4561d7mr15275685e9.32.1720110829692;
        Thu, 04 Jul 2024 09:33:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d6d22sm30393515e9.20.2024.07.04.09.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 09:33:49 -0700 (PDT)
Message-ID: <db2f97b6-a06e-470f-b1f9-60a78a0a2a7f@gmail.com>
Date: Thu, 4 Jul 2024 17:33:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH] t: port helper/test-oid-array.c to
 unit-tests/t-oid-array.c
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Christian Couder <chriscool@tuxfamily.org>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20240703034638.8019-2-shyamthakkar001@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240703034638.8019-2-shyamthakkar001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ghanshyam

Overall this looks like a faithful conversion, I've left a few comments 
below.

On 03/07/2024 04:46, Ghanshyam Thakkar wrote:
> helper/test-oid-array.c along with t0064-oid-array.sh test the
> oid-array.h library, which provides storage and processing
> efficiency over large lists of object identifiers.
> 
> Migrate them to the unit testing framework for better runtime
> performance and efficiency. Also 'the_hash_algo' is used internally in
> oid_array_lookup(), but we do not initialize a repository directory,
> therefore initialize the_hash_algo manually. And
> init_hash_algo():lib-oid.c can aid in this process, so make it public.
> 
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> Note: Once 'rs/unit-tests-test-run' is merged to atleast next, I plan to
> replace these internal function used in TEST_LOOKUP() with TEST_RUN().

Nice idea

> diff --git a/t/unit-tests/lib-oid.c b/t/unit-tests/lib-oid.c
> index 37105f0a8f..8f0ccac532 100644
> --- a/t/unit-tests/lib-oid.c
> +++ b/t/unit-tests/lib-oid.c
> @@ -3,7 +3,7 @@
>   #include "strbuf.h"
>   #include "hex.h"
>   
> -static int init_hash_algo(void)
> +int init_hash_algo(void)
>   {
>   	static int algo = -1;
>   
> diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
> index 8d2acca768..011a2d88de 100644
> --- a/t/unit-tests/lib-oid.h
> +++ b/t/unit-tests/lib-oid.h
> @@ -13,5 +13,11 @@
>    * environment variable.
>    */
>   int get_oid_arbitrary_hex(const char *s, struct object_id *oid);
> +/*
> + * Returns one of GIT_HASH_{SHA1, SHA256, UNKNOWN} based on the value of
> + * GIT_TEST_DEFAULT_HASH. The fallback value in case of absence of
> + * GIT_TEST_DEFAULT_HASH is GIT_HASH_SHA1.
> + */
> +int init_hash_algo(void);
>   
>   #endif /* LIB_OID_H */
> diff --git a/t/unit-tests/t-oid-array.c b/t/unit-tests/t-oid-array.c
> new file mode 100644
> index 0000000000..0a506fab07
> --- /dev/null
> +++ b/t/unit-tests/t-oid-array.c
> @@ -0,0 +1,138 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
> +#include "test-lib.h"
> +#include "lib-oid.h"
> +#include "oid-array.h"
> +#include "hex.h"
> +
> +static inline int test_min(int a, int b)
> +{
> +	return a <= b ? a : b;
> +}
> +
> +static int fill_array(struct oid_array *array, const char *hexes[], size_t n)
> +{
> +	for (size_t i = 0; i < n; i++) {
> +		struct object_id oid;
> +
> +		if (get_oid_arbitrary_hex(hexes[i], &oid))
> +			return -1;
> +		oid_array_append(array, &oid);
> +	}
> +	if (!check_int(array->nr, ==, n))

This should probably use check_uint() as the arguments are unsigned 
integers.

> +		return -1;
> +	return 0;
> +}
> +
> +static int add_to_oid_array(const struct object_id *oid, void *data)
> +{
> +	struct oid_array *array = data;

style: we leave a blank line after variable declarations at the start of 
a block.

> +	oid_array_append(array, oid);
> +	return 0;
> +}
> +
> +static void t_enumeration(const char *input_args[], size_t input_sz,
> +			  const char *result[], size_t result_sz)

style: we use "const char **arg" rather than "const char *arg[]"

> +{
> +	struct oid_array input = OID_ARRAY_INIT, expect = OID_ARRAY_INIT,
> +			 actual = OID_ARRAY_INIT;
> +	size_t i;
> +
> +	if (fill_array(&input, input_args, input_sz))
> +		return;
> +	if (fill_array(&expect, result, result_sz))
> +		return;
> +
> +	oid_array_for_each_unique(&input, add_to_oid_array, &actual);
> +	check_int(actual.nr, ==, expect.nr);
> +
> +	for (i = 0; i < test_min(actual.nr, expect.nr); i++) {
> +		if (!check(oideq(&actual.oid[i], &expect.oid[i])))
> +			test_msg("expected: %s\n       got: %s\n     index: %" PRIuMAX,
> +				 oid_to_hex(&expect.oid[i]), oid_to_hex(&actual.oid[i]),
> +				 (uintmax_t)i);
> +	}
> +	check_int(i, ==, result_sz);
> +
> +	oid_array_clear(&actual);
> +	oid_array_clear(&input);
> +	oid_array_clear(&expect);
> +}
> +
> +#define TEST_ENUMERATION(input, result, desc)                                     \
> +	TEST(t_enumeration(input, ARRAY_SIZE(input), result, ARRAY_SIZE(result)), \
> +			   desc " works")

This macro and its helper function look good.

> +static int t_lookup(struct object_id *oid_query, const char *query,
> +		    const char *hexes[], size_t n)
> +{
> +	struct oid_array array = OID_ARRAY_INIT;
> +	int ret;
> +
> +	if (get_oid_arbitrary_hex(query, oid_query))
> +		return INT_MIN;
> +	if (fill_array(&array, hexes, n))
> +		return INT_MIN;
> +	ret = oid_array_lookup(&array, oid_query);
> +
> +	oid_array_clear(&array);
> +	return ret;
> +}
> +
> +#define TEST_LOOKUP(input_args, query, condition, desc)                   \

Passing in the condition is a bit unfortunate as it means that the 
caller has to know which variable name to use. It might be nicer to have 
a function instead that takes the upper and lower bounds of the expected 
result and then does

	check_int(res, >=, expected_lower);
	check_int(res, <=, expected_upper);

It might be worth checking that array[res] matches the expected entry as 
well.

> +	do {                                                              \
> +		int skip = test__run_begin();                             \
> +		if (!skip) {                                              \
> +			struct object_id oid_query;                       \
> +			int ret = t_lookup(&oid_query, query, input_args, \
> +					   ARRAY_SIZE(input_args));       \
> +                                                                          \
> +			if (ret != INT_MIN && !check(condition))          \
> +				test_msg("oid query for lookup: %s",      \
> +					 oid_to_hex(&oid_query));         \
> +		}                                                         \
> +		test__run_end(!skip, TEST_LOCATION(), desc " works");     \
> +	} while (0)
> +
> +static void setup(void)
> +{
> +	int algo = init_hash_algo();
> +	/* because the_hash_algo is used by oid_array_lookup() internally */
> +	if (check_int(algo, !=, GIT_HASH_UNKNOWN))
> +		repo_set_hash_algo(the_repository, algo);
> +}
> +
> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +{
> +	const char *arr_input[] = { "88", "44", "aa", "55" };
> +	const char *arr_input_dup[] = { "88", "44", "aa", "55",
> +					"88", "44", "aa", "55",
> +					"88", "44", "aa", "55" };
> +	const char *res_sorted[] = { "44", "55", "88", "aa" };
> +
> +	if (!TEST(setup(), "setup"))
> +		test_skip_all("hash algo initialization failed");
> +
> +	TEST_ENUMERATION(arr_input, res_sorted, "ordered enumeration");
> +	TEST_ENUMERATION(arr_input_dup, res_sorted,
> +			 "ordered enumeration with duplicate suppression");
> +
> +	/* ret is the return value of oid_array_lookup() */
> +	TEST_LOOKUP(arr_input, "55", ret == 1, "lookup");
> +	TEST_LOOKUP(arr_input, "33", ret < 0, "lookup non-existent entry");
> +	TEST_LOOKUP(arr_input_dup, "55", ret >= 3 && ret <= 5,
> +		    "lookup with duplicates");
> +	TEST_LOOKUP(arr_input_dup, "66", ret < 0,
> +		    "lookup non-existent entry with duplicates");
> +
> +	TEST_LOOKUP(((const char *[]){
> +		    "55",
> +		    init_hash_algo() == GIT_HASH_SHA1 ?
> +				"5500000000000000000000000000000000000001" :
> +				"5500000000000000000000000000000000000000000000000000000000000001" }),

> +		    "55", ret == 0, "lookup with almost duplicate values");

This might be slightly more readable if we stored the oids in a separate 
variable at the beginning of this function and then it would look 
something like

	TEST_LOOKUP(((const char *[]) {"55", nearly_55}), "55", 0, 0,
		    "lookup with almost duplicate values");

Having said that it is kind of unfortunate that we have all the variable 
definitions at the start as it makes it harder to see what's going on in 
each test. We could avoid that by using TEST_RUN() and declaring the 
variables in the test block. For example the first test would look like

	TEST_RUN("ordered enumeration") {
		const char *input[] = { "88", "44", "aa", "55" };
		const char *expected[] = { "44", "55", "88", "aa" };

		TEST_ENUMERATION(input, expected)
	}

where TEST_ENUMERATION is adjusted so it does not call TEST(). It's more 
verbose but it is clearer what the input and expected values actually are.

Best Wishes

Phillip

> +	TEST_LOOKUP(((const char *[]){ "55", "55" }), "55",
> +		    ret >= 0 && ret <= 1, "lookup with single duplicate value");
> +
> +	return test_done();
> +}
