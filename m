Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95415A49E
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953774; cv=none; b=ag8sIjS/U8X/Yu1NQvVtj3oKrqgrT1Ba/x4Uw6Oz8Se1ePeOMNJ2zqW7j/1y6R1e0slFAGfWpMTC31eBmEZZT8dFl+1QrCo1X3+qqnguT9uhc1a+rgJVGqErF8eQSHB2kwYcERh/9Cxza0ZHd21kpDGluBSvyDSH9YZ/fGvkmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953774; c=relaxed/simple;
	bh=lOiOtHSTKDBRwzOAx3j7B5QPU81AbIXUGobSpEocoXY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JzmE3T2SmbKxYZ7rRHFbvEbIC/3EPwLOVeMbv4okwoCEFbQ6oKqm1N5rj+uKwgj5q8PKN6fh69rIm3Xwa6oMa8rEssDokuVW0XVlLmYRObhOCyUzDcxV4ry8BghfYEQXbRraWpqJvnFwJ9C5tX4Cn8h44mrxcxKLdLEsD5B/GLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyz/l2u7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyz/l2u7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41a77836f16so24473535e9.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 03:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713953771; x=1714558571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MtVE1JGY1brf2Ta5LfkyntMw1pYyFXutzUtJilI++MY=;
        b=fyz/l2u7SjCDExjMzNZVQnfIeK30/9kjASsBCIunJkSBWTSVe0xTTUkWYXPF09JzM8
         nnzDqgT8a4/lv99e93NIgdrI0uqdmHWPsZwTZEcpXh5KWUWdyNd39QtqlErvM1XIOaBu
         PeH8EnPv75g4e3LCMiCeRHxT2/h1UXG/SZFGYWAj7k9vUOiEiVqlo7xfszFaCk66iAN9
         iiSVgOsIJedJPL3eJhMS5t3FqEYynyHZSXS9KwiE+VVby/xNY/49MjOpMPm8Dyc5YWAc
         z1vuiDhZri42GDULKy6FyL+msTMKSL2KFVUvw8UarUZXzbA/ZMs6gjxWN+Clsc96XyVC
         lrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713953771; x=1714558571;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtVE1JGY1brf2Ta5LfkyntMw1pYyFXutzUtJilI++MY=;
        b=m7CmWKuxqgMndIfAt+8WlGmOt4nc2EbOaUVjX+dQJFm7ROqOUUqTRn4J4prmaD6mxG
         hXRVrSmZSMC+Sh841m66dxgZ61wo+Rvffm4rG6+YFgf2W+ODCdxEIiZyVhiKWl6wmtON
         8ZwpdpEX/Q27j4H3m5B0MMxUnziHfO1HKOtcPR9kJmGtxeY8j8l5kG33on+FO8yIUUXc
         0xGyukTifsQG9v/wDHyjT8aqJy9R482jqBfLOLg1mI2J2CZgpW2i+zPKfH7ILZeMBj6S
         Sfz5zjAeWY6HjVDrkQJBwcPRuT73/AKeZCa8fon7uD64cNDSmTLA/vhS93+DJ3XrPqrs
         RcPA==
X-Forwarded-Encrypted: i=1; AJvYcCXPbnh49IyitLm8LgHuQsjDOmOXXtFzRacsFKO+MWQKRPFCGruhPXpLd//UQRcPB4hNu0EVso270ic41PJqJYM+Ki9C
X-Gm-Message-State: AOJu0YypKPLCXZbLJ/s/G0WvLpUZO56EwsqybBhgSprpiKhDJQK8Yusj
	RxeAXlmTLCp8dGiTof2uAlCVqxJB7rVUidEK8AhhnuzguHje0ZJn
X-Google-Smtp-Source: AGHT+IFNb6bsJbjhOdG5+W7klQ3YF4LVricYMMuxtUO2KsZ2fOL9GzF2w2nmmsNubINwqavL71Z5ew==
X-Received: by 2002:a05:600c:46cc:b0:418:ed13:302d with SMTP id q12-20020a05600c46cc00b00418ed13302dmr1586684wmo.26.1713953770812;
        Wed, 24 Apr 2024 03:16:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm23364481wmo.36.2024.04.24.03.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 03:16:10 -0700 (PDT)
Message-ID: <aa628eba-1545-47ac-9773-8aff47ca4adf@gmail.com>
Date: Wed, 24 Apr 2024 11:16:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] format-patch: "--rfc=-(WIP)" appends to produce
 [PATCH (WIP)]
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Dragan Simic <dsimic@manjaro.org>
References: <20240421185915.1031590-1-gitster@pobox.com>
 <20240423175234.170434-1-gitster@pobox.com>
 <20240423175234.170434-3-gitster@pobox.com>
Content-Language: en-US
In-Reply-To: <20240423175234.170434-3-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 23/04/2024 18:52, Junio C Hamano wrote:
> In the previous step, the "--rfc" option of "format-patch" learned
> to take an optional string value to prepend to the subject prefix,
> so that --rfc=WIP can give "[WIP PATCH]".
> 
> There may be cases in which the extra string wants to come after the
> subject prefix.  Extend the mechanism to allow "--rfc=-(WIP)" [*] to
> signal that the extra string is to be appended instead of getting
> prepended, resulting in "[PATCH (WIP)]".
> 
> In the documentation, discourage (ab)using "--rfc=-RFC" to say
> "[PATCH RFC]" just to be different, when "[RFC PATCH]" is the norm.
> 
> [Footnote]
> 
>   * The syntax takes inspiration from Perl's open syntax that opens
>     pipes "open fh, '|-', 'cmd'", where the dash signals "the other
>     stuff comes here".

I'm not convinced this is a good idea as I'm not sure how adding "RFC" 
at the end of the subject prefix makes the world better than just having 
at the start of the prefix and I find using "-" to do that quite confusing.

Best Wishes

Phillip

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   Documentation/git-format-patch.txt | 6 ++++++
>   builtin/log.c                      | 8 ++++++--
>   t/t4014-format-patch.sh            | 9 +++++++++
>   3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index e553810b1e..369af2c4a7 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -247,6 +247,12 @@ RFC means "Request For Comments"; use this when sending
>   an experimental patch for discussion rather than application.
>   "--rfc=WIP" may also be a useful way to indicate that a patch
>   is not complete yet ("WIP" stands for "Work In Progress").
> ++
> +If the convention of the receiving community for a particular extra
> +string is to have it _after_ the subject prefix, the string _<rfc>_
> +can be prefixed with a dash ("`-`") to signal that the the rest of
> +the _<rfc>_ string should be appended to the subject prefix instead,
> +e.g., `--rfc='-(WIP)'` results in "PATCH (WIP)".
>   
>   -v <n>::
>   --reroll-count=<n>::
> diff --git a/builtin/log.c b/builtin/log.c
> index 97ca885b33..4750e480e6 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -2065,8 +2065,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   	if (cover_from_description_arg)
>   		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
>   
> -	if (rfc && rfc[0])
> -		strbuf_insertf(&sprefix, 0, "%s ", rfc);
> +	if (rfc && rfc[0]) {
> +		if (rfc[0] == '-')
> +			strbuf_addf(&sprefix, " %s", rfc + 1);
> +		else
> +			strbuf_insertf(&sprefix, 0, "%s ", rfc);
> +	}
>   
>   	if (reroll_count) {
>   		strbuf_addf(&sprefix, " v%s", reroll_count);
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 645c4189f9..fcbde15b16 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1394,6 +1394,15 @@ test_expect_success '--rfc=WIP and --rfc=' '
>   	test_cmp expect-raw actual
>   '
>   
> +test_expect_success '--rfc=-(WIP) appends' '
> +	cat >expect <<-\EOF &&
> +	Subject: [PATCH (WIP) 1/1] header with . in it
> +	EOF
> +	git format-patch -n -1 --stdout --rfc="-(WIP)" >patch &&
> +	grep "^Subject:" patch >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success '--rfc does not overwrite prefix' '
>   	cat >expect <<-\EOF &&
>   	Subject: [RFC PATCH foobar 1/1] header with . in it
