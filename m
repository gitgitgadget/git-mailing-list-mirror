Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66611F8BAA
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062306; cv=none; b=pBcs3X53b84axZGMoPztSXWxeSNyKsruqbM/QhXQd8sKEwcCTjSlu2SRb264Ei2b/oq9GLWwphSTcSgBgweCalqSGIjQ0FaVPTEKk6q7E3tK/LPFvbK/7hq8SlwYt+zzvj86EFz893DvE6JupRnP9jN4a4BqV/A+cvzZIJR035I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062306; c=relaxed/simple;
	bh=pYWQh/gYS13DZSJiuJKczsnn9gF5zHD84/O0Kcc1V94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bA8v2trro1Zx5zx/TyVWzHvHJKlaYNFDUzCZXFgfRksMbSrmgMx+DLWxAHWfbYLtNsj2pkaYC1eFpBJxE4EZAhvQ2AmXhNJUTOCNDeV7p1/i4CSx3IzmNDfldEHtNYDhi/ax/ueamuZ/KKl9FGsLKBKQiKHTE+258ZTYy7Li//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/SYzIHk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/SYzIHk"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so6486825e9.1
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 06:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740062303; x=1740667103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M01c8eUB3d8P+zZLrcnusj5p65FLlKwuR4jmxW7bumw=;
        b=W/SYzIHk6YOb5ckaQidq2csLTsUhvKT2guSLbCdjWBuu5+rj0QueRKZTZxlusejRlA
         3mAWgNx/SAh77o86LP7M8/I9ypgpzVOY2YWLErFYfKeHcFQfmvuAkTtIovI9ejQnhn1Y
         Jrf3uN97Hyzl1hAh6GaHccQDfBPyzKSUaQV8TZRZDxTU+UKcnf8jbT9YjKLhoZQ+C6Ux
         Q/HM/BT6HspShSDgDOdRSto0WYTha8GXf4IQdW3vVRBnd1aPZIZvUqwYZ451hb781K1R
         24k5cipKYDZtdhRo+9baYbTHu3i/eJ7JffaN53CJQ79PQmf9vJaFF0mkJPRhcp9fP0Sr
         N1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740062303; x=1740667103;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M01c8eUB3d8P+zZLrcnusj5p65FLlKwuR4jmxW7bumw=;
        b=FYHD96KSerHcErI4aaTOe51R27mJTuAjgIB7JNduwG/zdpwX/P3oGKeq/pacnpJukL
         nCyHG22xwjuKEBg6xJUNdsiTqSB2KWDti260YfCSO6FEPLqBZzB0pX2ZitzD2oDmlXlw
         NLaTaOGvCmIlsWz7ClZd5Pgf8IBcCcOHsbijgE3iw7KU5tfyD3iFvibxiYVvLGbCUYSN
         tsjE3AmUrRjuS8uCs8LkkfKV88xP+jDEYhUtPxtWk37dq3DvIeNbWA47ixDITBsiTkrn
         oORNNK8GG6kCmK6s8jxgigzRTo7fILhLGEFG3RWWA+5nlYXf/I4UBjydOxwK055v4B6F
         NonA==
X-Forwarded-Encrypted: i=1; AJvYcCWQj6L9O4Mryd0bmhvzRMyEBmInsjFw4JwTYgzy4hskPosW8x/jxjQ3kaXkgUnS+udFZVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTA+PHMcoaDVbMkGWqlN+uxWc6NMAtY4682vHSnZOo3vdeGZRr
	5rr2KV/5qe73AtBSd8V/BFbIn6Oq/s8Z1SWLj3Ceup5pl6yVHdh4/kh0xEVI7mQ=
X-Gm-Gg: ASbGnctBtCDv5/2adWKirtsRGfvNX5ZxDUTOA8ts/EQIrEHQINVhXGd6NNPSbS/U4aS
	x5+IMRR4ui3bzgxx2v9Zohi41bgrguQdEzfdbgYdsZMeqgO3aQ+vvwvS6wM4Xmg3vaPYhgDAOep
	7GBLJyjIlzktZKm5NY2QcTc63zB9wckO2JZNJDN6Kj3pgP8Rn7AWBVAstsWHVyqej9lCLMsE512
	gJu9fxtIYV4qsb/NKrcuOlprYeVgU+yyMEKCJdhCnkRmcHBOwJy6aazuoawH8zEWLHSpbJahO7f
	e2/wPbOX0yl0B6D4QirWStwzMdUGb5UBe1jBa+qq2yKwegqBfqfYrR3ippwPwlk89t6JXg==
X-Google-Smtp-Source: AGHT+IGU6b/7xvlZIHEjlCYakMmSjW6OUDJEuT1ghBAqijxccDvDiyUiAgmYn2n22+THrmJ+Qq2YEQ==
X-Received: by 2002:a05:600c:314d:b0:439:9898:f18c with SMTP id 5b1f17b1804b1-4399898f441mr76301865e9.26.1740062302891;
        Thu, 20 Feb 2025 06:38:22 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399fd24f9esm37438655e9.12.2025.02.20.06.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 06:38:22 -0800 (PST)
Message-ID: <c9e8a5f8-fda6-4383-bbb3-0c960a4cf86e@gmail.com>
Date: Thu, 20 Feb 2025 14:38:21 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/5] t/unit-tests: implement oid helper functions in
 unit-tests.{c,h}
To: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk
References: <20250220082959.10854-1-kuforiji98@gmail.com>
 <20250220082959.10854-2-kuforiji98@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250220082959.10854-2-kuforiji98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Seyi

On 20/02/2025 08:29, Seyi Kuforiji wrote:
> `get_oid_arbitrary_hex()` and `init_hash_algo()` are both required for
> oid-related tests to run without errors. In the current implementation,
> both functions are defined and declared in the
> `t/unit-tests/lib-oid.{c,h}` which is utilized by oid-related tests in
> the homegrown unit tests structure.
> 
> Implement equivalent functions in unit-tests.{c,h}. Both these functions
> become available for oid-related test files implemented using the clar
> testing framework, which requires them. This will be used by subsequent
> commits.

It is nice to see these tests being moved over to clar but I'm not sure 
that moving these functions into this file is good idea. All the unit 
tests need to link against unit-tests.o but only a subset will want 
access to these functions. Putting them in this file means that all the 
tests will now depend on code from strbuf.o and hex.o. I think we could 
add the new functions to lib-oid.c and then remove the old ones when 
there are not needed any more.

Best Wishes

Phillip

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>   t/unit-tests/unit-test.c | 42 ++++++++++++++++++++++++++++++++++++++++
>   t/unit-tests/unit-test.h | 19 ++++++++++++++++++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
> index fa8818842a..13d54f192a 100644
> --- a/t/unit-tests/unit-test.c
> +++ b/t/unit-tests/unit-test.c
> @@ -1,5 +1,7 @@
>   #include "unit-test.h"
> +#include "hex.h"
>   #include "parse-options.h"
> +#include "strbuf.h"
>   #include "string-list.h"
>   #include "strvec.h"
>   
> @@ -62,3 +64,43 @@ int cmd_main(int argc, const char **argv)
>   	strvec_clear(&args);
>   	return ret;
>   }
> +
> +int init_hash_algo(void)
> +{
> +	static int algo = -1;
> +
> +	if (algo < 0) {
> +		const char *algo_name = getenv("GIT_TEST_DEFAULT_HASH");
> +		algo = algo_name ? hash_algo_by_name(algo_name) : GIT_HASH_SHA1;
> +
> +		cl_assert(algo != GIT_HASH_UNKNOWN);
> +	}
> +	return algo;
> +}
> +
> +static void cl_parse_oid(const char *hex, struct object_id *oid,
> +				       const struct git_hash_algo *algop)
> +{
> +	int ret;
> +	size_t sz = strlen(hex);
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	cl_assert(sz <= algop->hexsz);
> +
> +	strbuf_add(&buf, hex, sz);
> +	strbuf_addchars(&buf, '0', algop->hexsz - sz);
> +
> +	ret = get_oid_hex_algop(buf.buf, oid, algop);
> +	cl_assert_equal_i(ret, 0);
> +
> +	strbuf_release(&buf);
> +}
> +
> +
> +void cl_parse_any_oid(const char *hex, struct object_id *oid)
> +{
> +	int hash_algo = init_hash_algo();
> +
> +	cl_assert(hash_algo != GIT_HASH_UNKNOWN);
> +	cl_parse_oid(hex, oid, &hash_algos[hash_algo]);
> +}
> diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
> index 85e5d6a948..ebed51212f 100644
> --- a/t/unit-tests/unit-test.h
> +++ b/t/unit-tests/unit-test.h
> @@ -8,3 +8,22 @@
>   	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \
>   	clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1); \
>   } while (0)
> +
> +/*
> + * Convert arbitrary hex string to object_id.
> + * For example, passing "abc12" will generate
> + * "abc1200000000000000000000000000000000000" hex of length 40 for SHA-1 and
> + * create object_id with that.
> + * WARNING: passing a string of length more than the hexsz of respective hash
> + * algo is not allowed. The hash algo is decided based on GIT_TEST_DEFAULT_HASH
> + * environment variable.
> + */
> +void cl_parse_any_oid(const char *s, struct object_id *oid);
> +/*
> + * Returns one of GIT_HASH_{SHA1, SHA256, UNKNOWN} based on the value of
> + * GIT_TEST_DEFAULT_HASH environment variable. The fallback value in the
> + * absence of GIT_TEST_DEFAULT_HASH is GIT_HASH_SHA1. It also uses
> + * cl_assert(algo != GIT_HASH_UNKNOWN) before returning to verify if the
> + * GIT_TEST_DEFAULT_HASH's value is valid or not.
> + */
> +int init_hash_algo(void);

