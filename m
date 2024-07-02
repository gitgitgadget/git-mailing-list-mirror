Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4459271B51
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933275; cv=none; b=p0+paCSHgHun2Xll1kgkv33jJ0vCSmfFHlihiI39+b/wbxII94C1CWpIyWxLaZBdSuclDYzPtf9lruIBCdyqDCL3wDFhTPzjQ7pQqgHtvK+W0TP3PWTWJ3bsHtjGPtZFkZ1MQS+RRejeM1FVRdDYTBGaO/q8iGf1rUtMu73xS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933275; c=relaxed/simple;
	bh=LN+LItAhbkRjNgoaex4MkdFS23Hi9DwM2HtogyV2g5s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V0HdTXAmQxa8N3ghW9LBwQC2rZHxFzwXPzf/cjFXbV3oVvnHgVH4V9AZUyT3OdUCMmpfJwGcA2M6B0bQVvIOENMyjt1lgxeT18BhzZU5J6HG+5u2rKsNWYZucmyBazSB65AR2iG3rTUre+Mp6bip+O+1zGuwUEmQVzSoBCeAfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5hrCEK/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5hrCEK/"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec58040f39so41819391fa.2
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719933271; x=1720538071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44wNOX5HiUZr8dKfhtZTFzIGz5+UXpJ35H8vhpFFpN4=;
        b=U5hrCEK/GjQkbKliA5OLvi66U4fKnUzSeWCNTSJaX0aiGp/KYdGmicE52ipOo9Ktuf
         5x4MlsgY+lDh/i5xBM06zUhABFT0c+Heh08UH7mxbT2egAZdFORl6iz6Hgf4Qw+9Zpcq
         0sowrCsJEq8xXyHINIGQQXbAzp4syfJ72NhIffGeHj4JqmyK7hUeOl1nTZIreQ9HSMVH
         JjnBysDizJKmyRIV4XYJb0m87mqxotKerTs9EbQXXrZfoTmNZfyc/Cc323dV5tFmWLhi
         D2hJA95w7cAqFrk8oH2lUuNSP/wJ/2VAMHSPZu+tDfo0HepaMyxnclTmBjpBk2c75xha
         fuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933271; x=1720538071;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44wNOX5HiUZr8dKfhtZTFzIGz5+UXpJ35H8vhpFFpN4=;
        b=iDcbe8+4FuDtKpxSGt4hsd/XY+b9V+ZUpNsfXGEnMg3VrLQ70rsPu86pKlJ22L7prU
         Eo3/nLdi8kU5o4odep32JBTW5bpB4hBfuQSONROoqi7nEf1ThjFaWivUy+ISQq+TSKep
         A4zaytrSVOhxyB70eLxJsl/cC2jpz75G/vjjrA830TDud0vDOpSeYNmWV7F9d+Mdtm03
         cjNzsMvvZo1EhEqF5Fv/Sr5NiQOx4hSijWrjrAJavsI11C2Qd6rotd8RvRJnA2i/LB9Y
         rb3hlszw3ui5uoMTqXbWhguwitaD93Oa4YiAdbC5pzkkjKpwOoQ1yYIZ8R6EXOFQVXuA
         nVBA==
X-Forwarded-Encrypted: i=1; AJvYcCV40nsf3UEx3vo+Ikfisso3JSO6+3hrrOXNiu6GlvfbOiZAErz8noNlHgWNIGRwcgT/LSFWoYdkr5ZokW8aL8fkARE8
X-Gm-Message-State: AOJu0Yx+8aX8RC5OyeX1hyGh6vyzkmP3sd6AJW9NO6gqVFIj7nzkg0nz
	zq6IjhleJvV92nhG3bHqH12nYGdbfm0JbMISyCH5mMXr9yqts+RUC58eLQ==
X-Google-Smtp-Source: AGHT+IGTx4KjQX3hMLdjoWk7t7DINsFMzVEFEeGQBE0Vqw65BKtOYvgjMq24TTwbexpn+qoRBh5G7A==
X-Received: by 2002:a05:651c:2c8:b0:2ec:f68:51e0 with SMTP id 38308e7fff4ca-2ee5e6e7469mr48483971fa.44.1719933269015;
        Tue, 02 Jul 2024 08:14:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a073sm201375205e9.32.2024.07.02.08.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:14:28 -0700 (PDT)
Message-ID: <c122c0a6-9f38-489d-8286-b62bd4deefcc@gmail.com>
Date: Tue, 2 Jul 2024 16:14:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/6] t-strvec: use TEST_RUN
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <27cdab5f-15b3-45fb-89e1-530a6c0817a6@web.de>
Content-Language: en-US
In-Reply-To: <27cdab5f-15b3-45fb-89e1-530a6c0817a6@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 29/06/2024 16:46, René Scharfe wrote:
> The macro TEST takes a single expression.  If a test requires multiple
> statements then they need to be placed in a function that's called in
> the TEST expression.
> 
> Remove the overhead of defining and calling single-use functions by
> using TEST_RUN instead.

I'm not sure what the overhead is that you keep referring to - the 
compiler will inline functions that are only called once so I presume 
you mean overhead for test authors or contributors reading the code?

This is not related to you changes but while looking at this patch I 
noticed that the existing code in check_strvec_loc() contains

		if (!check_uint(vec->nr, >, nr) ||
		    !check_uint(vec->alloc, >, nr) ||
		    !check_str(vec->v[nr], str)) {
			struct strbuf msg = STRBUF_INIT;
			strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
			test_assert(loc, msg.buf, 0);
			strbuf_release(&msg);
			va_end(ap);
			return;

Which looks like it should be using test_msg() instead of writing a 
message to an strbuf and calling test_assert().

The conversion itself looks correct. It is a shame that each test has to 
have boilerplate to initalize and free the strvec but that comes from 
the existing implementation.

Best Wishes

Phillip

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>   t/unit-tests/t-strvec.c | 356 ++++++++++++++++++----------------------
>   1 file changed, 156 insertions(+), 200 deletions(-)
> 
> diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
> index d4615ab06d..00ff7d4ae8 100644
> --- a/t/unit-tests/t-strvec.c
> +++ b/t/unit-tests/t-strvec.c
> @@ -36,237 +36,193 @@ static void check_strvec_loc(const char *loc, struct strvec *vec, ...)
>   	check_pointer_eq(vec->v[nr], NULL);
>   }
> 
> -static void t_static_init(void)
> +int cmd_main(int argc, const char **argv)
>   {
> -	struct strvec vec = STRVEC_INIT;
> -	check_pointer_eq(vec.v, empty_strvec);
> -	check_uint(vec.nr, ==, 0);
> -	check_uint(vec.alloc, ==, 0);
> -}
> +	if (TEST_RUN("static initialization")) {
> +		struct strvec vec = STRVEC_INIT;
> +		check_pointer_eq(vec.v, empty_strvec);
> +		check_uint(vec.nr, ==, 0);
> +		check_uint(vec.alloc, ==, 0);
> +	}
> 
> -static void t_dynamic_init(void)
> -{
> -	struct strvec vec;
> -	strvec_init(&vec);
> -	check_pointer_eq(vec.v, empty_strvec);
> -	check_uint(vec.nr, ==, 0);
> -	check_uint(vec.alloc, ==, 0);
> -}
> +	if (TEST_RUN("dynamic initialization")) {
> +		struct strvec vec;
> +		strvec_init(&vec);
> +		check_pointer_eq(vec.v, empty_strvec);
> +		check_uint(vec.nr, ==, 0);
> +		check_uint(vec.alloc, ==, 0);
> +	}
> 
> -static void t_clear(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_push(&vec, "foo");
> -	strvec_clear(&vec);
> -	check_pointer_eq(vec.v, empty_strvec);
> -	check_uint(vec.nr, ==, 0);
> -	check_uint(vec.alloc, ==, 0);
> -}
> +	if (TEST_RUN("clear")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_push(&vec, "foo");
> +		strvec_clear(&vec);
> +		check_pointer_eq(vec.v, empty_strvec);
> +		check_uint(vec.nr, ==, 0);
> +		check_uint(vec.alloc, ==, 0);
> +	}
> 
> -static void t_push(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> +	if (TEST_RUN("push")) {
> +		struct strvec vec = STRVEC_INIT;
> 
> -	strvec_push(&vec, "foo");
> -	check_strvec(&vec, "foo", NULL);
> +		strvec_push(&vec, "foo");
> +		check_strvec(&vec, "foo", NULL);
> 
> -	strvec_push(&vec, "bar");
> -	check_strvec(&vec, "foo", "bar", NULL);
> +		strvec_push(&vec, "bar");
> +		check_strvec(&vec, "foo", "bar", NULL);
> 
> -	strvec_clear(&vec);
> -}
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_pushf(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_pushf(&vec, "foo: %d", 1);
> -	check_strvec(&vec, "foo: 1", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("pushf")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_pushf(&vec, "foo: %d", 1);
> +		check_strvec(&vec, "foo: 1", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_pushl(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -	check_strvec(&vec, "foo", "bar", "baz", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("pushl")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +		check_strvec(&vec, "foo", "bar", "baz", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_pushv(void)
> -{
> -	const char *strings[] = {
> -		"foo", "bar", "baz", NULL,
> -	};
> -	struct strvec vec = STRVEC_INIT;
> +	if (TEST_RUN("pushv")) {
> +		const char *strings[] = {
> +			"foo", "bar", "baz", NULL,
> +		};
> +		struct strvec vec = STRVEC_INIT;
> 
> -	strvec_pushv(&vec, strings);
> -	check_strvec(&vec, "foo", "bar", "baz", NULL);
> +		strvec_pushv(&vec, strings);
> +		check_strvec(&vec, "foo", "bar", "baz", NULL);
> 
> -	strvec_clear(&vec);
> -}
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_replace_at_head(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -	strvec_replace(&vec, 0, "replaced");
> -	check_strvec(&vec, "replaced", "bar", "baz", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("replace at head")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +		strvec_replace(&vec, 0, "replaced");
> +		check_strvec(&vec, "replaced", "bar", "baz", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_replace_at_tail(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -	strvec_replace(&vec, 2, "replaced");
> -	check_strvec(&vec, "foo", "bar", "replaced", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("replace at tail")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +		strvec_replace(&vec, 2, "replaced");
> +		check_strvec(&vec, "foo", "bar", "replaced", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_replace_in_between(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -	strvec_replace(&vec, 1, "replaced");
> -	check_strvec(&vec, "foo", "replaced", "baz", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("replace in between")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +		strvec_replace(&vec, 1, "replaced");
> +		check_strvec(&vec, "foo", "replaced", "baz", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_replace_with_substring(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_pushl(&vec, "foo", NULL);
> -	strvec_replace(&vec, 0, vec.v[0] + 1);
> -	check_strvec(&vec, "oo", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("replace with substring")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_pushl(&vec, "foo", NULL);
> +		strvec_replace(&vec, 0, vec.v[0] + 1);
> +		check_strvec(&vec, "oo", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_remove_at_head(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -	strvec_remove(&vec, 0);
> -	check_strvec(&vec, "bar", "baz", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("remove at head")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +		strvec_remove(&vec, 0);
> +		check_strvec(&vec, "bar", "baz", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_remove_at_tail(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -	strvec_remove(&vec, 2);
> -	check_strvec(&vec, "foo", "bar", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("remove at tail")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +		strvec_remove(&vec, 2);
> +		check_strvec(&vec, "foo", "bar", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_remove_in_between(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -	strvec_remove(&vec, 1);
> -	check_strvec(&vec, "foo", "baz", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("remove in between")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +		strvec_remove(&vec, 1);
> +		check_strvec(&vec, "foo", "baz", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_pop_empty_array(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_pop(&vec);
> -	check_strvec(&vec, NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("pop with empty array")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_pop(&vec);
> +		check_strvec(&vec, NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_pop_non_empty_array(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -	strvec_pop(&vec);
> -	check_strvec(&vec, "foo", "bar", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("pop with non-empty array")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +		strvec_pop(&vec);
> +		check_strvec(&vec, "foo", "bar", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_split_empty_string(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_split(&vec, "");
> -	check_strvec(&vec, NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("split empty string")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_split(&vec, "");
> +		check_strvec(&vec, NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_split_single_item(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_split(&vec, "foo");
> -	check_strvec(&vec, "foo", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("split single item")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_split(&vec, "foo");
> +		check_strvec(&vec, "foo", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_split_multiple_items(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_split(&vec, "foo bar baz");
> -	check_strvec(&vec, "foo", "bar", "baz", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("split multiple items")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_split(&vec, "foo bar baz");
> +		check_strvec(&vec, "foo", "bar", "baz", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_split_whitespace_only(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_split(&vec, " \t\n");
> -	check_strvec(&vec, NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("split whitespace only")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_split(&vec, " \t\n");
> +		check_strvec(&vec, NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_split_multiple_consecutive_whitespaces(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	strvec_split(&vec, "foo\n\t bar");
> -	check_strvec(&vec, "foo", "bar", NULL);
> -	strvec_clear(&vec);
> -}
> +	if (TEST_RUN("split multiple consecutive whitespaces")) {
> +		struct strvec vec = STRVEC_INIT;
> +		strvec_split(&vec, "foo\n\t bar");
> +		check_strvec(&vec, "foo", "bar", NULL);
> +		strvec_clear(&vec);
> +	}
> 
> -static void t_detach(void)
> -{
> -	struct strvec vec = STRVEC_INIT;
> -	const char **detached;
> +	if (TEST_RUN("detach")) {
> +		struct strvec vec = STRVEC_INIT;
> +		const char **detached;
> 
> -	strvec_push(&vec, "foo");
> +		strvec_push(&vec, "foo");
> 
> -	detached = strvec_detach(&vec);
> -	check_str(detached[0], "foo");
> -	check_pointer_eq(detached[1], NULL);
> +		detached = strvec_detach(&vec);
> +		check_str(detached[0], "foo");
> +		check_pointer_eq(detached[1], NULL);
> 
> -	check_pointer_eq(vec.v, empty_strvec);
> -	check_uint(vec.nr, ==, 0);
> -	check_uint(vec.alloc, ==, 0);
> +		check_pointer_eq(vec.v, empty_strvec);
> +		check_uint(vec.nr, ==, 0);
> +		check_uint(vec.alloc, ==, 0);
> 
> -	free((char *) detached[0]);
> -	free(detached);
> -}
> +		free((char *) detached[0]);
> +		free(detached);
> +	}
> 
> -int cmd_main(int argc, const char **argv)
> -{
> -	TEST(t_static_init(), "static initialization");
> -	TEST(t_dynamic_init(), "dynamic initialization");
> -	TEST(t_clear(), "clear");
> -	TEST(t_push(), "push");
> -	TEST(t_pushf(), "pushf");
> -	TEST(t_pushl(), "pushl");
> -	TEST(t_pushv(), "pushv");
> -	TEST(t_replace_at_head(), "replace at head");
> -	TEST(t_replace_in_between(), "replace in between");
> -	TEST(t_replace_at_tail(), "replace at tail");
> -	TEST(t_replace_with_substring(), "replace with substring");
> -	TEST(t_remove_at_head(), "remove at head");
> -	TEST(t_remove_in_between(), "remove in between");
> -	TEST(t_remove_at_tail(), "remove at tail");
> -	TEST(t_pop_empty_array(), "pop with empty array");
> -	TEST(t_pop_non_empty_array(), "pop with non-empty array");
> -	TEST(t_split_empty_string(), "split empty string");
> -	TEST(t_split_single_item(), "split single item");
> -	TEST(t_split_multiple_items(), "split multiple items");
> -	TEST(t_split_whitespace_only(), "split whitespace only");
> -	TEST(t_split_multiple_consecutive_whitespaces(), "split multiple consecutive whitespaces");
> -	TEST(t_detach(), "detach");
>   	return test_done();
>   }
> --
> 2.45.2
