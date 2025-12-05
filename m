Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED230BBAB
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764951086; cv=none; b=o2EBZDAAC5rjFxdE0Y9UYJAajp2uWW+m2lRKFP/ZVkReG7VgEuGC/Pgn5/OdFknlQ/5lCbNDcFguByVyXHidypZi/RI2R6n2odcJmyagzOilHCDYzqoEpzmb/z/taKqcNgiREVd/oEhJCh9c0qmIlpQj76lr1v0pOZsf/Y9HrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764951086; c=relaxed/simple;
	bh=3Jh4oQio69peeBUjS6tM1gD/zZrYoxTYzFnDmo6lHvc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FWfk9QhlT4rF9Gxcpn1SizsNafh8VfmhigvONEuCw3NYwmJJQujJo8AxzMxwjGc5IfUGVt1kA1cwlXYoCTMW0w6e6HvjVgJB7HiD8HRBaHbSQIuAiXhw3Xg09Zbwj+UPfE2vjMZZLNl2ILBeCPcJrkrlGFtg402MyFgt70/ir/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZReYjLwX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZReYjLwX"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso1185822f8f.0
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764951077; x=1765555877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M450KF5WVq9xXB6PUGF2na8Zc0eaaPE8pe9UiiDJ+KE=;
        b=ZReYjLwXYNnpO1H790KSvbnk3jz9sJXm3B8RkdStFieG9VMVSyPjSh5FdMMEz3XRN9
         3Q0e4wunoNUO5vhiTMfppPGoFDtOsCmMtGjBx3S9msv46A/Y/kO16eCmGh2WnN3He/az
         7Jtn6QhkkRFESZK8srWis0IREcIwPYJVoWi5I0tbUCDqn3p4/2Yzq+oZqtcMojkpkhMn
         cJkHrRabKj6zwZq82oBKHQKPyn67NzhNs5P/b0H87hJDiIEB14ZpP8YWw32L965/kHhp
         MOTelNlCBUplHx6pc/0zy9X4q6YEesB+BQxfXs6GkDF2e8axCqMh0hiYdaQ/moabRCbB
         RohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764951077; x=1765555877;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M450KF5WVq9xXB6PUGF2na8Zc0eaaPE8pe9UiiDJ+KE=;
        b=Lq0tAlnHYg89A4jVVAyLl29N4lBmQWdMoja00sUKR72FIbHKIoaxFegygq2kRxLpso
         vf2Lrx29+Bsk396Mdh4NmSOUgYRSe1uFP1KMUVMlbFg2ed8SsifKUFdFn5RiaUqPBmj7
         qpqso4Vj58BdSeXpxtWXOo7GA0C0KXX0QBzdvOptHAvRplAmUVetWAXYybink0CSMHlN
         LPfgHSFZBIlXGPRW7OsZngHi3xls7bHwtU97JivZcfJRBgSEm72C0W0ruewKBqhCfLkv
         21QhC4VOF4OfXLwao6iROScI+tUwzEp1kKtOS1RDhjWWuOd7Jm+Q2KEkdtdRS0sEjXWw
         PijA==
X-Gm-Message-State: AOJu0YxSKq5OMNtJNPsH4JxdjnZz/AJCEvfFd7huwl8Bhj1yJXpYJKQe
	cyMsGppbDGPv8lQslNYzn1xCJZhVSlH+LQhCd1zWGpF9fHneK4gD6vsS
X-Gm-Gg: ASbGncsJuRPZAxDTkxqsHp4UI/AFEyoTlFyTvGHIzo11iCe0fZSGqhUk9FEVPWH+J5L
	aEOYeEjtgRQNOkpJj69rnhbSRGlC6LCZ/nq9hFRTl23ryWhA7FRCFM+dQvKJOix0++/QKpvzGSf
	Ua5LorJqWuQHg4zOoR5w4rnwjugSLbIi2epMaAxgdDYvDE+xTNMGWlTNk/pWULcK8Gn7Sz+yoBO
	gR5syeQ/qTsxK69fLcnlRsPxzp2xf1e35dyZ6kpwZtyeiqLsM3IQe37CVshWVffh2G81PwGLdlz
	ggwys3rMrtNE260gC80Q/8GkL62gDuYCCrtgJKHDdncJFtbo2nEyn5aHot5EpMFFbi2ocKWOV3e
	CNa1Hvs75SU9bKOUN5GWcZaZhKzgfTD0JLX1AwDbeomSLh3PPFk/Zumzi12ClPQp3NEN6aey94w
	C0ACj0ZWfUs+xMOJXxNMUg7Sldyk5/mxZUi/AAyKefvh7S44isTeTimG3PhpXY6sk=
X-Google-Smtp-Source: AGHT+IFdX4jJw+MlrbTpsryxyPN4ea+sIKx+CkhzDQDiRg0QLCc++7e0gmKMpYHBStcrbZQoLPOIkw==
X-Received: by 2002:a05:6000:200c:b0:42b:2e39:6d45 with SMTP id ffacd0b85a97d-42f73178ec2mr11263128f8f.15.1764951076719;
        Fri, 05 Dec 2025 08:11:16 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f8bsm9805010f8f.43.2025.12.05.08.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 08:11:16 -0800 (PST)
Message-ID: <4d83375b-76e2-4420-80dd-6a04d3201532@gmail.com>
Date: Fri, 5 Dec 2025 16:11:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/4] parse: add functions for parsing from non-string
 buffers
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
References: <20251130131351.GA198697@coredump.intra.peff.net>
 <20251130131537.GB199335@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20251130131537.GB199335@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/11/2025 13:15, Jeff King wrote:
> If you have a buffer that is not NUL-terminated but want to parse an
> integer, there aren't many good options. If you use strtol() and
> friends, you risk running off the end of the buffer if there is no
> non-digit terminating character. And even if you carefully make sure
> that there is such a character, ASan's strict-string-check mode will
> still complain.
> 
> You can copy bytes into a temporary buffer, terminate it, and then call
> strtol(), but doing so adds some pitfalls (like making sure you soak up
> whitespace and leading +/- signs, and reporting overflow for overly long
> input). Or you can hand-parse the digits, but then you need to take some
> care to handle overflow (and again, whitespace and +/- signs).
> 
> These things aren't impossible to do right, but it's error-prone to have
> to do them in every spot that wants to do such parsing. So let's add
> some functions which can be used across the code base.
> 
> There are a few choices regarding the interface and the implementation.
> 
> First, the implementation:
> 
>    - I went with with parsing the digits (rather than buffering and
>      passing to libc functions). It ends up being a similar amount of
>      code because we have to do some parsing either way. And likewise
>      overflow detection depends on the exact type the caller wants, so we
>      either have to do it by hand or write a separate wrapper for
>      strtol(), strtoumax(), and so on.
> 
>    - Unsigned overflow detection is done using the same techniques as in
>      unsigned_add_overflows(), etc. We can't use those macros directly
>      because our core function is type-agnostic (so the caller passes in
>      the max value, rather than us deriving it on the fly). This is
>      similar to how git_parse_int(), etc, work.
> 
>    - Signed overflow detection assumes that we can express a negative
>      value with magnitude one larger than our maximum positive value
>      (e.g., -128..127 for a signed 8-bit value). I doubt this is
>      guaranteed by the standard, but it should hold in practice, and we
>      make the same assumption in git_parse_int(), etc. The nice thing
>      about this is that we can derive the range from the number of bits
>      in the type. For ints, you obviously could use INT_MIN..INT_MAX, but
>      for an arbitrary type, we can use maximum_signed_value_of_type().
> 
>    - I didn't bother with handling bases other than 10. It would
>      complicate the code, and I suspect it won't be needed. We could
>      probably retro-fit it later without too much work, if need be.

This all sounds sensible to me and an does the interface description.

> +bool parse_unsigned_from_buf(const char *buf, size_t len, const char **ep,
> +			     uintmax_t *ret, uintmax_t max)
> +{
> +	return parse_from_buf_internal(buf, len, ep, NULL, ret, max);
> +}
> +
> +bool parse_signed_from_buf(const char *buf, size_t len, const char **ep,
> +			   intmax_t *ret, intmax_t max)
> +{
> +	uintmax_t u_ret;
> +	bool negate;
> +
> +	if (!parse_from_buf_internal(buf, len, ep, &negate, &u_ret, max))
> +		return false;
> +	/*
> +	 * Range already checked internally, but we must apply negation
> +	 * ourselves since only we have the signed integer type.
> +	 */
> +	if (negate) {
> +		*ret = u_ret;
> +		*ret = -*ret;

If we're parsing INTMAX_MIN then this negation tries to calculate 
-INTMAX_MIN which is undefined (I've added some tests for parsing 
INTMAX_MAX and INTMAX_MIN at [1] and verified that UBSAN is triggered 
when parsing INTMAX_MIN). We could do

		*ret = u_ret;
		if (*ret != INTMAX_MIN)
			*ret = -*ret;

but I think it might be easier to alter parse_from_buf_internal() to 
make "negate" a local variable, change the function argument to "bool 
allow_negative" and do

		*ret = negate ? 0u - val : val;

Then parse_signed_from_buf() can do "*ret = *u_ret;" to convert the 
output of parse_from_buf_internal() to a signed value.

> diff --git a/t/unit-tests/u-parse-int.c b/t/unit-tests/u-parse-int.c
> new file mode 100644
> index 0000000000..a1601bb16b
> --- /dev/null
> +++ b/t/unit-tests/u-parse-int.c
> @@ -0,0 +1,98 @@
> +#include "unit-test.h"
> +#include "parse.h"
> +
> +static void check_int(const char *buf, size_t len,
> +		      size_t expect_ep_ofs, int expect_errno,
> +		      int expect_result)
> +{
> +	const char *ep;
> +	int result;

Do we want to set errno=0 here so that we can be sure it has been set by 
parse_int_from_buf() when we check it below?

Thanks

Phillip

[1] 
https://github.com/phillipwood/git/commit/e061e3e640db01d4fcf54d265d33352235151973

> +	bool ok = parse_int_from_buf(buf, len, &ep, &result);
> +
> +	if (expect_errno) {
> +		cl_assert(!ok);
> +		cl_assert_equal_i(expect_errno, errno);
> +		return;
> +	}
> +
> +	cl_assert(ok);
> +	cl_assert_equal_i(expect_result, result);
> +	cl_assert_equal_i(expect_ep_ofs, ep - buf);
> +}
> +
> +static void check_int_str(const char *buf, size_t ofs, int err, int res)
> +{
> +	check_int(buf, strlen(buf), ofs, err, res);
> +}
> +
> +static void check_int_full(const char *buf, int res)
> +{
> +	check_int_str(buf, strlen(buf), 0, res);
> +}
> +
> +static void check_int_err(const char *buf, int err)
> +{
> +	check_int(buf, strlen(buf), 0, err, 0);
> +}
> +
> +void test_parse_int__basic(void)
> +{
> +	cl_invoke(check_int_full("0", 0));
> +	cl_invoke(check_int_full("11", 11));
> +	cl_invoke(check_int_full("-23", -23));
> +	cl_invoke(check_int_full("+23", 23));
> +
> +	cl_invoke(check_int_str("  31337  ", 7, 0, 31337));
> +
> +	cl_invoke(check_int_err("  garbage", EINVAL));
> +	cl_invoke(check_int_err("", EINVAL));
> +	cl_invoke(check_int_err("-", EINVAL));
> +
> +	cl_invoke(check_int("123", 2, 2, 0, 12));
> +}
> +
> +void test_parse_int__range(void)
> +{
> +	/*
> +	 * These assume a 32-bit int. We could avoid that with some
> +	 * conditionals, but it's probably better for the test to
> +	 * fail noisily and we can decide how to handle it then.
> +	 */
> +	cl_invoke(check_int_full("2147483647", 2147483647));
> +	cl_invoke(check_int_err("2147483648", ERANGE));
> +	cl_invoke(check_int_full("-2147483647", -2147483647));
> +	cl_invoke(check_int_full("-2147483648", -2147483648));
> +	cl_invoke(check_int_err("-2147483649", ERANGE));
> +}
> +
> +static void check_unsigned(const char *buf, uintmax_t max,
> +			   int expect_errno, uintmax_t expect_result)
> +{
> +	const char *ep;
> +	uintmax_t result;
> +	bool ok = parse_unsigned_from_buf(buf, strlen(buf), &ep, &result, max);
> +
> +	if (expect_errno) {
> +		cl_assert(!ok);
> +		cl_assert_equal_i(expect_errno, errno);
> +		return;
> +	}
> +
> +	cl_assert(ok);
> +	cl_assert_equal_s(ep, "");
> +	/*
> +	 * Do not use cl_assert_equal_i_fmt(..., PRIuMAX) here. The macro
> +	 * casts to int under the hood, corrupting the values.
> +	 */
> +	clar__assert_equal(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC,
> +			   CLAR_CURRENT_LINE,
> +			   "expect_result != result", 1,
> +			   "%"PRIuMAX, expect_result, result);
> +}
> +
> +void test_parse_int__unsigned(void)
> +{
> +	cl_invoke(check_unsigned("4294967295", UINT_MAX, 0, 4294967295U));
> +	cl_invoke(check_unsigned("1053", 1000, ERANGE, 0));
> +	cl_invoke(check_unsigned("-17", UINT_MAX, EINVAL, 0));
> +}

