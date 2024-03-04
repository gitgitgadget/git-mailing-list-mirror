Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048252574F
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545899; cv=none; b=rZhK8OI0aSkDf6cXtLcyCsW0QAo9+qH73kD2YNbwalViSfjF0a7tkws48pexgAvnVVtr9enKW3riQ4BMGNVMU3zbp3/0HL7uGNrpTNnTV1Ohmpavf367w9CEL2AL1XXME+HD5uQrxds7VuDKdxGQeFdr95qaTESA1O2BJuMsOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545899; c=relaxed/simple;
	bh=7apdsBshhR56zOoGXxf+pwZSMKvuIau8l62HoPdpqvE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YKo7NZ21aJusc9A2aMKGucy31DwdstnfR/xUeFvoOItqR2SEM7maMcBYLgaf52sbJGQY3cTOHwpFRSv3HTbenOb/oZ+uDWDZe5408EEP5It5hxtmDKkEBe/on56ank0kHbcftnKVMhLhB+6POpyA9vViHT3P+Oh2kpd9pYrE3oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXA0xnl3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXA0xnl3"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412e84e6d2fso686195e9.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 01:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545896; x=1710150696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVUbtWOaVLL11Saj17PGXWnZvZifopl+XSlJ4+wiy14=;
        b=AXA0xnl3pCTa4CuQazt3lFW3SK2g0amubMfEMHwgVuigIcF95YdGNdq2I3gBpm0Q6t
         vRCFF553mTgvVUDWsnpV70ahXkKscqHWRZFs9qgsF/3p2OmUN7QGqsVHgwAjm1BCHY/M
         PtA2PVB9Bgxl8d7K4ApjAzecEm5YcKfHlpxBtwc7XFHpv/13A2xPoYgG8/3saXtRUba5
         4IpMB/KL8Xx2IQP2IIwkcKyYvb10ASw8aHA0tcsbnQ8C3uoZacGJFBRnZfrS3zIZc92E
         yixlAj50dbZDnN/vZgNe3Ti4S4La5V+wYaBJx7qTxvwQ86cxcfSi3h14D17skNLUCWVD
         WXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545896; x=1710150696;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVUbtWOaVLL11Saj17PGXWnZvZifopl+XSlJ4+wiy14=;
        b=OjO/0NZGrFjxunzpGUY0TSN4+SXrO84sgs4+vKU4EHBav9L0rAZG5HfNU6nT2QrI4r
         H+RbFmWMkpEYbwqv26tJRJnakG5cD1rd/0weq/w/G3H/PqmyFMd0gnEIdHcFVABUQBA+
         x0H7IV2v6iGwm5+2IuBU3jlF6Nz3rspaQ14UScDj2bsrllb/gIBnoyKQBPQgHpGaU6qa
         tU7U9ZjmSrxzuaJ4oAbc2elI+woNLH313l/WXhwqE/TjB3KDjjliGdquqbs2qIE6nWUQ
         Hjbqf6LRyk+lfF1YEt+E2+pkhwVByVa/REjx/4catgb7Wgq5ubhZnZWBSarAHw9RITxE
         aFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKi5xdbmVCifHDsok0olKPE+qJR3hB3xi42E/BX2EXsN0SP4H1TDJtpysr8FBd4ScxsnSC9Y7U5aKdDGLWQ5oz6vSe
X-Gm-Message-State: AOJu0YzGdUYWjrzJ9WzaqcSOLCg/PAJ6VSt5cPmFfBggluydnm1QnAmj
	Sj/72ZNtosCQEP955iIGYEwopERTGWRx03/K27JhcnoJvHOBiCCo
X-Google-Smtp-Source: AGHT+IH2iWH1bMUScZWNYxuQpALeW0KiQSWpRG3F2DPyXme+3WPRtvSws5iJyhIqcrRCL+RjYA6vjQ==
X-Received: by 2002:a05:600c:c1a:b0:412:b4c:58da with SMTP id fm26-20020a05600c0c1a00b004120b4c58damr6448669wmb.9.1709545896104;
        Mon, 04 Mar 2024 01:51:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244? ([2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c298400b00412cfdc41f7sm2137392wmd.0.2024.03.04.01.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 01:51:35 -0800 (PST)
Message-ID: <0947cb09-8b07-4fcd-bbe2-ae37c2cd5ec7@gmail.com>
Date: Mon, 4 Mar 2024 09:51:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] t-ctype: avoid duplicating class names
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>, Achu Luma <ach.lumap@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240303101330.20187-1-l.s.r@web.de> <20240303101330.20187-5-l.s.r@web.de>
Content-Language: en-US
In-Reply-To: <20240303101330.20187-5-l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 03/03/2024 10:13, René Scharfe wrote:
> TEST_CTYPE_FUNC defines a function for testing a character classifier,
> TEST_CHAR_CLASS calls it, causing the class name to be mentioned twice.
> 
> Avoid the need to define a class-specific function by letting
> TEST_CHAR_CLASS do all the work.  This is done by using the internal
> functions test__run_begin() and test__run_end(), but they do exist to be
> used in test macros after all.

Those internal functions exist to implement the TEST() macro, they are 
not really intended for use outside that (which is why they are marked 
as private in the header file). If we ever want to update the 
implementation of TEST() it will be a lot harder if we're using the 
internal implementation directly in test files. Unit tests should be 
wrapping TEST() if it is appropriate but not the internal implementation 
directly.

Ideally we wouldn't need TEST_CTYPE_FUNC as there would only be a single 
function that was passed a ctype predicate, an input array and an array 
of expected results. Unfortunately I don't think that is possible due 
the the way the ctype predicates are implemented. Having separate macros 
to define the test function and to run the test is annoying but I don't 
think it is really worth exposing the internal implementation just to 
avoid it.

The other patches here look like useful improvements - thanks.

Best Wishes

Phillip

> Alternatively we could unroll the loop to provide a very long expression
> that tests all 256 characters and EOF and hand that to TEST, but that
> seems awkward and hard to read.
> 
> No change of behavior or output intended.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>   t/unit-tests/t-ctype.c | 64 ++++++++++++++++--------------------------
>   1 file changed, 24 insertions(+), 40 deletions(-)
> 
> diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
> index 02d8569aa3..d6ac1fe678 100644
> --- a/t/unit-tests/t-ctype.c
> +++ b/t/unit-tests/t-ctype.c
> @@ -1,19 +1,19 @@
>   #include "test-lib.h"
> 
> -/* Macro to test a character type */
> -#define TEST_CTYPE_FUNC(func, string) \
> -static void test_ctype_##func(void) { \
> +#define TEST_CHAR_CLASS(class, string) do { \
>   	size_t len = ARRAY_SIZE(string) - 1 + \
>   		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
>   		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) == sizeof(char)); \
> -	for (int i = 0; i < 256; i++) { \
> -		if (!check_int(func(i), ==, !!memchr(string, i, len))) \
> -			test_msg("      i: 0x%02x", i); \
> +	int skip = test__run_begin(); \
> +	if (!skip) { \
> +		for (int i = 0; i < 256; i++) { \
> +			if (!check_int(class(i), ==, !!memchr(string, i, len)))\
> +				test_msg("      i: 0x%02x", i); \
> +		} \
> +		check(!class(EOF)); \
>   	} \
> -	check(!func(EOF)); \
> -}
> -
> -#define TEST_CHAR_CLASS(class) TEST(test_ctype_##class(), #class " works")
> +	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
> +} while (0)
> 
>   #define DIGIT "0123456789"
>   #define LOWER "abcdefghijklmnopqrstuvwxyz"
> @@ -33,37 +33,21 @@ static void test_ctype_##func(void) { \
>   	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
>   	"\x7f"
> 
> -TEST_CTYPE_FUNC(isdigit, DIGIT)
> -TEST_CTYPE_FUNC(isspace, " \n\r\t")
> -TEST_CTYPE_FUNC(isalpha, LOWER UPPER)
> -TEST_CTYPE_FUNC(isalnum, LOWER UPPER DIGIT)
> -TEST_CTYPE_FUNC(is_glob_special, "*?[\\")
> -TEST_CTYPE_FUNC(is_regex_special, "$()*+.?[\\^{|")
> -TEST_CTYPE_FUNC(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~")
> -TEST_CTYPE_FUNC(isascii, ASCII)
> -TEST_CTYPE_FUNC(islower, LOWER)
> -TEST_CTYPE_FUNC(isupper, UPPER)
> -TEST_CTYPE_FUNC(iscntrl, CNTRL)
> -TEST_CTYPE_FUNC(ispunct, PUNCT)
> -TEST_CTYPE_FUNC(isxdigit, DIGIT "abcdefABCDEF")
> -TEST_CTYPE_FUNC(isprint, LOWER UPPER DIGIT PUNCT " ")
> -
>   int cmd_main(int argc, const char **argv) {
> -	/* Run all character type tests */
> -	TEST_CHAR_CLASS(isspace);
> -	TEST_CHAR_CLASS(isdigit);
> -	TEST_CHAR_CLASS(isalpha);
> -	TEST_CHAR_CLASS(isalnum);
> -	TEST_CHAR_CLASS(is_glob_special);
> -	TEST_CHAR_CLASS(is_regex_special);
> -	TEST_CHAR_CLASS(is_pathspec_magic);
> -	TEST_CHAR_CLASS(isascii);
> -	TEST_CHAR_CLASS(islower);
> -	TEST_CHAR_CLASS(isupper);
> -	TEST_CHAR_CLASS(iscntrl);
> -	TEST_CHAR_CLASS(ispunct);
> -	TEST_CHAR_CLASS(isxdigit);
> -	TEST_CHAR_CLASS(isprint);
> +	TEST_CHAR_CLASS(isspace, " \n\r\t");
> +	TEST_CHAR_CLASS(isdigit, DIGIT);
> +	TEST_CHAR_CLASS(isalpha, LOWER UPPER);
> +	TEST_CHAR_CLASS(isalnum, LOWER UPPER DIGIT);
> +	TEST_CHAR_CLASS(is_glob_special, "*?[\\");
> +	TEST_CHAR_CLASS(is_regex_special, "$()*+.?[\\^{|");
> +	TEST_CHAR_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~");
> +	TEST_CHAR_CLASS(isascii, ASCII);
> +	TEST_CHAR_CLASS(islower, LOWER);
> +	TEST_CHAR_CLASS(isupper, UPPER);
> +	TEST_CHAR_CLASS(iscntrl, CNTRL);
> +	TEST_CHAR_CLASS(ispunct, PUNCT);
> +	TEST_CHAR_CLASS(isxdigit, DIGIT "abcdefABCDEF");
> +	TEST_CHAR_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
> 
>   	return test_done();
>   }
> --
> 2.44.0
> 
