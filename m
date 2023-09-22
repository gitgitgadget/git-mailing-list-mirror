Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B2DE6FE3B
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 14:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjIVOfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIVOfO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 10:35:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCF3194
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:35:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405361bb949so18973275e9.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695393306; x=1695998106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCwvevtA91/VTezZJFrbxEgiQqWq3WPxiej3lBbYAC4=;
        b=A98SAoslxdvFPgiW7VqbjyAhh6X7lkViqIj1WXpE9e8SFs86veb7RJMtJ3aOwBsVyh
         yroZ/CzlfQeqYWvTlGHSzsh11KUuqSJp29hG6m/GLwVnh7gPbzutEaH4b361+3fJiuRz
         yr5PyDGCHp/mQmVK8Tvv44WO8jDDJVsKiplWj7cYtcRno8+uwADmvTqBA3yDtc61Qk6a
         xpNb4IxDZ5BT8DfADbGX4NTpNp3KjlcWbfHkjfQGw/00JS1NzBfL8pFS2JksZoX4ngbL
         tzckjKim1PPf2INDdMhDGAU8Gk20Hizn3+7QI+T9o8dnyO1/lk+EXKW8N/Ry7T2Ftw/v
         Vc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695393306; x=1695998106;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCwvevtA91/VTezZJFrbxEgiQqWq3WPxiej3lBbYAC4=;
        b=aAYantNBavXxQF+5xUMbTXYl3snFTu6ImMjsA6tI/zgN2or9KN5pIKpPh7V/r+A1Nu
         fTqcX1XwR5gZjIACWRnrZGw0cDYqynVy5MI5vyuNSiQu/60xGS1kAAhvFVI1XKs3nDPD
         tQBcVjhslpva6Y5DzKcd5ec6eCfG+l+rbu2tY2DOe4wgM+Vhff/tr5Kw/6Vngazb6N4d
         RnhAOEmpkt1akON5YIoSC6cUWnFaVQ9aKQAMaGTUG4yNx56nJzK3h7Ens+lT8K10Dqa1
         bWmx3HYaLA+R9Wpb52LPrrQGybwZhFOnavtfx0jbT3NSLKrOCV+/R2wGrWeS1/2SHWfM
         U6mA==
X-Gm-Message-State: AOJu0Yymi7gBn7NKmoGJQ3D/R3NXY9fieueHpTlofK5TWTSTuEnrvbD0
        TWfJGHs68PL1/taqJDqa+vayTNtK0KwrRw==
X-Google-Smtp-Source: AGHT+IFCiywjN11JkxbEA0JXS10A/I8J8aLkdeQXWwD6h/c8ppxG0DB562uVovSei0qPzzw4UTjafg==
X-Received: by 2002:adf:f741:0:b0:320:77f:a982 with SMTP id z1-20020adff741000000b00320077fa982mr8323888wrp.45.1695393305578;
        Fri, 22 Sep 2023 07:35:05 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d46c7000000b0031fbbe347e1sm4633236wrs.65.2023.09.22.07.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 07:35:05 -0700 (PDT)
Message-ID: <7d373691-450a-4f95-abdd-f5cd7993ee27@gmail.com>
Date:   Fri, 22 Sep 2023 15:35:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/7] unit-tests: do show relative file paths
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
 <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
 <f0b804129e8a21449cbb6f346473d3570182ddfa.1695070468.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <f0b804129e8a21449cbb6f346473d3570182ddfa.1695070468.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 18/09/2023 21:54, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Visual C interpolates `__FILE__` with the absolute _Windows_ path of
> the source file. GCC interpolates it with the relative path, and the
> tests even verify that.
> 
> So let's make sure that the unit tests only emit such paths.

This looks good to me. Calling strlcpy() without checking the return 
value is a pet peeve of mine but the silent truncation doesn't matter 
here and the buffer ought to be long enough anyway.

Best Wishes

Phillip

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   t/unit-tests/test-lib.c | 52 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
> index 70030d587ff..744e223ee98 100644
> --- a/t/unit-tests/test-lib.c
> +++ b/t/unit-tests/test-lib.c
> @@ -21,6 +21,46 @@ static struct {
>   	.result = RESULT_NONE,
>   };
>   
> +#ifndef _MSC_VER
> +#define make_relative(location) location
> +#else
> +/*
> + * Visual C interpolates the absolute Windows path for `__FILE__`,
> + * but we want to see relative paths, as verified by t0080.
> + */
> +#include "dir.h"
> +
> +static const char *make_relative(const char *location)
> +{
> +	static char prefix[] = __FILE__, buf[PATH_MAX], *p;
> +	static size_t prefix_len;
> +
> +	if (!prefix_len) {
> +		size_t len = strlen(prefix);
> +		const char *needle = "\\t\\unit-tests\\test-lib.c";
> +		size_t needle_len = strlen(needle);
> +
> +		if (len < needle_len || strcmp(needle, prefix + len - needle_len))
> +			die("unexpected suffix of '%s'", prefix);
> +
> +		/* let it end in a directory separator */
> +		prefix_len = len - needle_len + 1;
> +	}
> +
> +	/* Does it not start with the expected prefix? */
> +	if (fspathncmp(location, prefix, prefix_len))
> +		return location;
> +
> +	strlcpy(buf, location + prefix_len, sizeof(buf));
> +	/* convert backslashes to forward slashes */
> +	for (p = buf; *p; p++)
> +		if (*p == '\\')
> +			*p = '/';
> +
> +	return buf;
> +}
> +#endif
> +
>   static void msg_with_prefix(const char *prefix, const char *format, va_list ap)
>   {
>   	fflush(stderr);
> @@ -147,7 +187,8 @@ int test__run_end(int was_run UNUSED, const char *location, const char *format,
>   			break;
>   
>   		case RESULT_NONE:
> -			test_msg("BUG: test has no checks at %s", location);
> +			test_msg("BUG: test has no checks at %s",
> +				 make_relative(location));
>   			printf("not ok %d", ctx.count);
>   			print_description(format, ap);
>   			ctx.result = RESULT_FAILURE;
> @@ -193,13 +234,15 @@ int test_assert(const char *location, const char *check, int ok)
>   	assert(ctx.running);
>   
>   	if (ctx.result == RESULT_SKIP) {
> -		test_msg("skipping check '%s' at %s", check, location);
> +		test_msg("skipping check '%s' at %s", check,
> +			 make_relative(location));
>   		return 0;
>   	} else if (!ctx.todo) {
>   		if (ok) {
>   			test_pass();
>   		} else {
> -			test_msg("check \"%s\" failed at %s", check, location);
> +			test_msg("check \"%s\" failed at %s", check,
> +				 make_relative(location));
>   			test_fail();
>   		}
>   	}
> @@ -224,7 +267,8 @@ int test__todo_end(const char *location, const char *check, int res)
>   	if (ctx.result == RESULT_SKIP)
>   		return 0;
>   	if (!res) {
> -		test_msg("todo check '%s' succeeded at %s", check, location);
> +		test_msg("todo check '%s' succeeded at %s", check,
> +			 make_relative(location));
>   		test_fail();
>   	} else {
>   		test_todo();
