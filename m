Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48BE38DC53
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056500; cv=none; b=jRi9Qr7E/jWYulQMPGmFRKAwdGl9dG+zvR2XG595gtNmB41drn/mU9sEh750UZDhEgJVt+AxjR55y0P7urHSapTLM41X8scptXec47OUhHuvF2soLoOHDy5eRneU8Mvt1Hai81gPSpnnunRnZVQBlZUywxPYYEHlM0PhpYNmG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056500; c=relaxed/simple;
	bh=lXZVFAG8g4CoDmpCkBAgC0r5n2mB2taf2zAE5xeGNl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGXIucaEagL4OyhOBWTg1HH7sYHBR2WoGK+Jmy7R/7O6prKJ8uNLKnj0zxdTFePnVeQ/hAz2/23gtqKx0K5fsnT8fjVB33yY9nyCXX5erzSQ4uFOP612ySQTxqO66X4Q9FTQGLjCBApWyY95zUd/XfqMxeqt1TT9Y3/D7WZTt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sxkYnOBc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxkYnOBc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso17004865e9.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792056497; x=1792661297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mJYitBjWbK6uvOU0hvp5aICFjGJjEQcAz0dmDhnGlrQ=;
        b=sxkYnOBcEr4ljVJmlLjozp1gyzzQnn/flgnZM7Kgsak4osGKXq07VSdN4UQ5Il1D74
         5ureCE8SPPc5Cc+uxfgCy6HXtoyRODTG8w5sfCu/FYGmqbdmPva3yUsupzJerJi2Ydu+
         srCGTMy3pkrjbLIN7ApGC/WYItuh2Sf093tlWx4yvCHEe1jkE1ZI39YsgyL6KltDBH+d
         X9k8Qyoerz8poNQF9Zo/7uo27O16tz81pl7c4W624h0MdikB2m9jw5yoA1zoqBLxknuX
         LooAwwOOyYEScv4y1GecXZJWibVxIph1MPD/M0Wn2+jg1EwRFsb9xht2yuU2dfny3a05
         YYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792056497; x=1792661297;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mJYitBjWbK6uvOU0hvp5aICFjGJjEQcAz0dmDhnGlrQ=;
        b=Ue7f6CBDh8Sr08x00lKyMePLbbDcaHCelPF2/XSsa1QkEAsJsZgpt+B5Fy+VT10OOU
         jmhMGrt/3Oaw8DpKB4z+QQVZOOJj7NCm3mTF0HG2dfwcTUmxOC/ccPMOZYN7kH1hWrm1
         W0GPxZwa4jEoyeEdDqqH8HQJ03Coa0EM92cjWG8mS8lV/cdyds6P5+cjfzCcVhlLIE7e
         vsKPHuH/54z4AfA+9q3+y6QBidDflVAHWzBVKiAlfQnRLT/lYW1axsEkh92TNtuXZmna
         /EP0ZictM1lqUtzplafE8oNs0FrdLwkHAj+LKm+kdeSSTd/ASg+KnVME8eH44DUWNf41
         62jw==
X-Forwarded-Encrypted: i=1; AKwUvBxM9WM+LyJBYkC0VhSVog8jbx2eHoywEr2XcL/2TZasEJrnToY3+Dl4erIu6eaFbOwMNAw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3PC/WNjYdGYa7wnsWIxkHe2V/yKLoTHcaEoVhLTc0p8oOfjRt
	Uv8VzfdoO3zlgKycnRonkGDfOHuTfbHE5dv/rjJJUflko8l7rNL2EfmR
X-Gm-Gg: AYBFou0Qmga+oCs2F4mMGjkMFGmPRwu3/9LzG5w0O6tvDVe9MnKlu7Z0Uus3p5TgbE7
	vevSmQaTqbNeXRlOwO1jlHYbIi9+tnFL5V/vI/7nZIUBxDwmiMoxGp8bqW5l0uu4UrhXnPWnXR8
	62le38+ynas1v49AmCovppDX6BqnNh2QLpa8kdt97nSQamst0PJTn9vIZdmJVz5CURlv13kBU2/
	+GEdyUInXGwDHb2jW4UGOpFHvL+hR03P8WhGVFovQMng5Z5HiRuBZKh4wUKoTdJHAHVwgCCFnr5
	m+baHI/hHGxyVOJ0jYca0qbeSacn+GpjAS3vt3QdwtQLNApAn7KFrLAV3nL+JgX32g7/zK0mqqS
	gCaPtmGLXLbAkzP/KlGdDPxlcTmAhmug45FpGdribmjL4R9h1qSb7Ej+4G7vZBExy2DIKIvqUSj
	xGREPw6TQBeDHkcwrWYuhAg9vc8K3rly98tRGaMJ7+4mca8CnPLxa9AHP4QQttC0UsiMmJkdSeV
	wCDUdKDjmFo7QFY9YaiodjrjRhIvdbwQb1bACKA63ezf4XoXct/
X-Received: by 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-4a18e49886amr414502355e9.10.1792056496752;
        Thu, 15 Oct 2026 02:28:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c50689e6sm3964755e9.5.2026.10.15.02.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 02:28:16 -0700 (PDT)
Message-ID: <163d14a8-711c-4d4f-b441-8268db819541@gmail.com>
Date: Thu, 15 Oct 2026 10:28:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/5] date: avoid overflow in approxidate relative-time
 multiplication
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
 <a4e602b9e726081aaaf73c627548b823a4d35477.1791958171.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <a4e602b9e726081aaaf73c627548b823a4d35477.1791958171.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 14/10/2026 07:09, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The `approxidate_alpha()` function multiplies a time unit length (e.g.,
> 604800 for weeks) by a user-supplied number to compute a time offset in
> seconds. Both operands are `int`, and the product is passed to
> `update_tm()` as `time_t`. For inputs like "99999 weeks ago", the int
> multiplication overflows (604800 * 99999 is roughly 60 billion, far
> beyond `INT_MAX`), producing a wrapped value that results in a wrong
> date.

Signed integer overflow is undefined so we don't necessarily get a 
wrapped value - the whole program is invalid.

It looks like "length" is always positive, can the user supplied number 
ever be negative?

> Use the checked `time_t` multiplication so oversized products do not
> overflow or wrap around.

This is only true when compiling with gcc or clang though because 
mult_overflows() always returns 0 on other compilers, so we're still 
exposed to undefined behavior when compiling with a different compiler 
on platforms where time_t is signed. I wonder if it would be better to 
perform the multiplication on a known type and then check that the 
result can be losslessly converted to time_t

	intmax_t length tl->length, num_t = *num, result;

	if (signed_mult_overflows(length, num_t))
		// error
	result = length * num_t;
	if ((intmax_t)((time_t)result) != result ||
	    (result < 0 && (time_t)result > 0))
		// error

that would avoid overflow on all platforms, regardless of the compiler 
and regardless of the type of time_t. Having mult_overflows() only 
implemented for gcc seems like a footgun waiting to happen when we're 
typically checking for overflow to avoid some form of bad behavior.

> On platforms where `time_t` is unsigned (and where the pre-processor
> allows us to determine this fact), reject counts that are too large and
> report a parse error. Narrowing them first could otherwise produce
> negative or truncated values that become bogus offsets. Leave signed
> `time_t` count parsing unchanged.

I'm a bit confused what this is trying to do - why can't we check this 
when time_t is signed?

	if ((timestamp_t)((int)number) != number)
		return NULL

	return *val = value;

Ensures "value" fits in "val" without truncation, we could also add a 
check that value is positive when time_t is unsigned if we wanted.

Thanks

Phillip
> Pointed out by Coverity.
> 
> Assisted-by: Claude Opus 4.6 and GPT-6.1 Sol
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   date.c | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/date.c b/date.c
> index 014065b419..0d65804d2f 100644
> --- a/date.c
> +++ b/date.c
> @@ -1298,7 +1298,18 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
>   	while (tl->type) {
>   		size_t len = strlen(tl->type);
>   		if (match_string(date, tl->type) >= len-1) {
> -			update_tm(tm, now, tl->length * *num);
> +			time_t length = tl->length, num_t = *num;
> +			time_t seconds;
> +#ifndef is_unsigned_type
> +			seconds = length * num_t;
> +#else
> +			time_t max_val = is_unsigned_type(length)
> +				? maximum_unsigned_value_of_type(length)
> +				: maximum_signed_value_of_type(length);
> +			seconds = mult_overflows(length, num_t)
> +				? max_val : length * num_t;
> +#endif
> +			update_tm(tm, now, seconds);
>   			*num = 0;
>   			*touched = 1;
>   			return end;
> @@ -1368,8 +1379,15 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
>   	}
>   
>   	/* Accept zero-padding only for small numbers ("Dec 02", never "Dec 0002") */
> -	if (date[0] != '0' || end - date <= 2)
> +	if (date[0] != '0' || end - date <= 2) {
> +#ifdef is_unsigned_type
> +		if (is_unsigned_type((time_t)0) &&
> +		    (number > INT_MAX ||
> +		     number > maximum_unsigned_value_of_type((time_t)0)))
> +			return NULL;
> +#endif
>   		*num = number;
> +	}
>   	return end;
>   }
>   
> @@ -1398,6 +1416,10 @@ static timestamp_t approxidate_str(const char *date,
>   		if (isdigit(c)) {
>   			pending_number(&tm, &number);
>   			date = approxidate_digit(date-1, &tm, &number, time_sec);
> +			if (!date) {
> +				*error_ret = 1;
> +				return 0;
> +			}
>   			touched = 1;
>   			continue;
>   		}

