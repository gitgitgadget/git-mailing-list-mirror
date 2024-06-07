Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A531757D
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772413; cv=none; b=kRM/tkZ0uveGTdCT1Dyl9VT/ya6CZSqBxTmdC5rS0kzaFma6qitKjyh3eSgrzm17RwVoQAKqM+49Is3w0cQh4xIJGNIKv+xEn/WdrAMI1+fV340jTNUu314uggJtLjfW2d9q4EMJtWumS3nNwoTnFDFe9CzZs91OIrCRAFpzNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772413; c=relaxed/simple;
	bh=YB/FLest1hQ3e/r9M2e0OWY0XaBDHB+GUSXg0DMZqS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgwLBaA0vxB6hPg6f8+EIBpj4d+r5XlKv/U7N7yeSIE4glBPNDcn2mzYqUeEHJVC4HwYYUWSwN2RXytzOF6ITrxJ2Cd/evG0SwQErAyxq+00/vstQQCHkjkee8Gv58iQTHWX1MqwFGqJpdvYpMujiIMa8tJV+pOV+B1IwHWaAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8MuZvpp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8MuZvpp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4217990f8baso648965e9.2
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717772410; x=1718377210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vfJhL/4J7C1l21BFE8/b9d+NojOC5I6eTD0Zgjs2kJ4=;
        b=W8MuZvpp5HiqfvIBOvb4gyakxgIBUXW5Plyvf+7undXWPZOTgQp3dKRlHlDJOm2/pW
         YXasn7vHMWkwugcMr9xS/l3V3Y8KpLeVSUsEpmAXxIc7mN/k+MniySpqpY0+R+dezbCn
         feFl/23D/w0ZY155FNCQC6+fRvbQ3gsNgwIp/nhn9a18mWzIhidjlHLdpQIBy8vVXU3F
         s5JctTOe0OL1wAC3AeZymSoaBiDibQ14+G1QdFOK0gd4ve3P0zSbYanxRvLavctItWwk
         VXAyRB49zGLLlzlbRQRIqabU8EEHOadN9mIVj8t4gXOcTBQgB5+jv2MCXsh2Tsny6iCd
         piJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717772410; x=1718377210;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfJhL/4J7C1l21BFE8/b9d+NojOC5I6eTD0Zgjs2kJ4=;
        b=SIEL5zfKxGnqFaHHrMmXw3w/7x81kbpbq6xuiSa0zCXug81Uw0kJ/9Mm+bFxa6Fxea
         Ha9wEzbG+hU1LX1OQ1c6dW+TkQ3qwEhi77Gql7TWYVooti4aQrSdDzvFogzWBqE43s9S
         Mt8/DjsPUApbRjmxCt72V8HIkPSe70h7ANHPwxUANw/dAZ54RyP86cPz1KO4y4/E25PL
         Unj1SyabApn0E3LsXeTP6QGGAj3kbmppxHy/BoFglxOhaHjcMxSOtJchTRIE8qnXWlZ4
         B7bPNFL2JWEez3VtESop7Zd4fZkiFkQgz/ngaYTT20xmYpes8Zkhqb7PnAGUs9GQKl5V
         nnuA==
X-Forwarded-Encrypted: i=1; AJvYcCUjTcV4V/gMMw2PDfRxRcq7G/u9YMU7iOU6EfJ776WDd81YqKWuzKNmGgsrJuHEJUTY4jhttfRb/S+8WHYxfUFiMozZ
X-Gm-Message-State: AOJu0YyUeDfz+CcpYpv9dNnTM9ZuboVFk9hSdszvZiDNPOAlNk0fJ1jQ
	DIRtF8Goo1cV/vIn2Z+1RJXGeUkiyI+pQuEWpdUx8wgcB+EW31I7
X-Google-Smtp-Source: AGHT+IF4NJwZhLYgFOYpJRsGUvfvotQRdzsQd+KvUfVntYvSy6fY79DcLckUmf86bEuxtDB26xK87g==
X-Received: by 2002:a05:6000:1ce:b0:35e:e87e:6b40 with SMTP id ffacd0b85a97d-35efed2eb59mr2076654f8f.25.1717772410006;
        Fri, 07 Jun 2024 08:00:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:124f:b55:b414:cf29? ([2a0a:ef40:641:9001:124f:b55:b414:cf29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2a6130sm54639375e9.26.2024.06.07.08.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 08:00:09 -0700 (PDT)
Message-ID: <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
Date: Fri, 7 Jun 2024 16:00:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] apply: add unit tests for parse_range
To: Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Philip <philip.c.peterson@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
 <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philip

Thanks for re-rolling, I've left a few comments below

On 26/05/2024 08:54, Philip Peterson via GitGitGadget wrote:
> From: Philip Peterson <philip.c.peterson@gmail.com>
> 
> Also rename parse_range to parse_fragment_range for external linkage.
> 
> Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
> ---
>      apply: add unit tests for parse_range
>      
>      Add unit tests for apply's parse_range function. Also rename parse_range
>      to parse_fragment_range and expose it externally for use by the unit
>      tests. Internal callers may continue to refer to it by the name
>      parse_range.
>      
>      It is necessary to make the function be non-internal linkage in order to
>      expose it to the unit testing framework. Because there is another
>      function in the codebase also called parse_range, change this one to a
>      more specific name as well: parse_fragment_range. Also add several test
>      cases (both positive and negative) for the function.

This description is useful and should be part of the commit message 
above the "---" line

> +/*
> + * exposed only for tests; do not call this as it not
> + * a part of the API
> + */
> +extern int apply_parse_fragment_range(const char *line, int len, int offset,
> +				      const char *expect, unsigned long *p1,
> +				      unsigned long *p2);

We don't bother with extern on function declarations as can be seen from 
all the other declarations in this header file.

> +
>   #endif
> diff --git a/t/unit-tests/t-apply.c b/t/unit-tests/t-apply.c
> new file mode 100644
> index 00000000000..0eb0c22fc0d
> --- /dev/null
> +++ b/t/unit-tests/t-apply.c
> @@ -0,0 +1,101 @@
> +#include "test-lib.h"
> +#include "apply.h"
> +
> +#define FAILURE -1
> +
> +typedef struct test_case {
> +	const char *line;
> +	const char *expect_suffix;
> +	int offset;
> +	unsigned long expect_p1;
> +	unsigned long expect_p2;
> +	int expect_result;
> +} test_case;

We don't use typedef's in this code base

> +static void setup_static(struct test_case t)
> +{
> +	unsigned long p1 = 9999;
> +	unsigned long p2 = 9999;
> +	int result = apply_parse_fragment_range(t.line, strlen(t.line), t.offset,
> +						t.expect_suffix, &p1, &p2);
> +	check_int(result, ==, t.expect_result);

If we expect apply_parse_fragment_range() to return an error then I'm 
not sure we want to bother checking p1 and p2 as I don't think we make 
any guarantees about their values in that case. If we promised not to 
touch them unless the fragment was successfully parsed we would want to 
check that but we don't make that promise.

> +	check_int(p1, ==, t.expect_p1);
> +	check_int(p2, ==, t.expect_p2);
> +}
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	TEST(setup_static((struct test_case) {
> +		.line = "@@ -4,4 +",
> +		.offset = 4,
> +		.expect_suffix = " +",
> +		.expect_result = 9,
> +		.expect_p1 = 4,
> +		.expect_p2 = 4
> +	}), "well-formed range");

This is a nice use of compound literals. It would be good to have a test 
that checks .expect_result for a longer input string to ensure we're not 
just stopping at the end of the string.

> +	TEST(setup_static((struct test_case) {
> +		.line = "@@ -4 +8 @@",

I would be nice to vary "-4" a bit, all the tests where the parse is 
successful expect p1 == 4

> +		.offset = 4,
> +		.expect_suffix = " +",
> +		.expect_result = 7,
> +		.expect_p1 = 4,
> +		.expect_p2 = 1
> +	}), "non-comma range");
> +
> +	TEST(setup_static((struct test_case) {
> +		.line = "@@ -X,4 +",
> +		.offset = 4,
> +		.expect_suffix = " +",
> +		.expect_result = FAILURE,
> +		.expect_p1 = 9999,
> +		.expect_p2 = 9999
> +	}), "non-digit range (first coordinate)");
> +
> +	TEST(setup_static((struct test_case) {
> +		.line = "@@ -4,X +",
> +		.offset = 4,
> +		.expect_suffix = " +",
> +		.expect_result = FAILURE,
> +		.expect_p1 = 4,
> +		.expect_p2 = 1 // A little strange this is 1, but not end of the world

This is an example of why I don't think we should check p1 and p2 when 
we're expecting the parse to fail. Also please note we don't use "//" 
comments in the code base.

There is a good range of failing non-digit inputs. It would be nice to 
see a test for a hunk header where the number is too large to parse. 
Ideally we'd also change the parsing code to return an error in that 
case rather than waiting to error out later on as the apply code does 
currently. To do that You'd need to explicitly set errno to zero before 
calling strtoul() and check it afterwards.

Overall this is looking pretty good, thanks for working on it

Best Wishes

Phillip


> +	}), "non-digit range (second coordinate)");
> +
> +	TEST(setup_static((struct test_case) {
> +		.line = "@@ -4,4 -",
> +		.offset = 4,
> +		.expect_suffix = " +",
> +		.expect_result = FAILURE,
> +		.expect_p1 = 4,
> +		.expect_p2 = 4
> +	}), "non-expected trailing text");
> +
> +	TEST(setup_static((struct test_case) {
> +		.line = "@@ -4,4",
> +		.offset = 4,
> +		.expect_suffix = " +",
> +		.expect_result = FAILURE,
> +		.expect_p1 = 4,
> +		.expect_p2 = 4
> +	}), "not long enough for expected trailing text");
> +
> +	TEST(setup_static((struct test_case) {
> +		.line = "@@ -4,4",
> +		.offset = 7,
> +		.expect_suffix = " +",
> +		.expect_result = FAILURE,
> +		.expect_p1 = 9999,
> +		.expect_p2 = 9999
> +	}), "not long enough for offset");
> +
> +	TEST(setup_static((struct test_case) {
> +		.line = "@@ -4,4",
> +		.offset = -1,
> +		.expect_suffix = " +",
> +		.expect_result = FAILURE,
> +		.expect_p1 = 9999,
> +		.expect_p2 = 9999
> +	}), "negative offset");
> +
> +	return test_done();
> +}
> 
> base-commit: b9cfe4845cb2562584837bc0101c0ab76490a239
