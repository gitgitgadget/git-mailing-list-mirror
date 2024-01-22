Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F183DB86
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954407; cv=none; b=lkb/9bYkMdJgZgz8nBWWYI0xKjcaGDVfE6cPHgphm9MG7Vde1Uuiylr9Z8eXTqPJvR1qA63IayHnkojRb51VgeavyZnb9Ztd7Gakftt8QqJ93VNSj5mpDJgO9Sg6FnTSIuH4cbuLCGcMZJREu00hUwYjqwawOdhG6c42Pwz8DlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954407; c=relaxed/simple;
	bh=O2zoiszKAu6c+n4Nu5g4q7KJS35rLE8QGfrwZESYwDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QLWHTOLm8nhjTmj139zeoyz9ddi21nuXG0N6Ps4auNcnNyngalVOJdQmQPFCOJIvaYeGAlEmfVAFMp7bKS3ALjayqxcF67IHup70ATOO66+eT5tjHAqZmbkQdYsu/TCRJkPgP5sD4rzLHextqcVOfLoocfKCTpLB9p6+J9Le4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8ldAe4o; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8ldAe4o"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-339208f5105so3118203f8f.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 12:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705954404; x=1706559204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8AzHPA+4yPx7LyXG3RgofzLIgOv93IRz8DjT/NHZPD0=;
        b=H8ldAe4ojJ2CNQveQErO70xNg/j0GdE9piqePy44OsN/X6/urm4IAMgJQIdBhNzhok
         EX1c4oxOhK8TLBxF+HdgRHctQrOjf1OTT+MiV0793fuT+AXw7Stdw7sSP9D62UStqFv7
         kHWK6Q3Smk9J3b0pVlE3nvSPLM7FwA/pXIw8Y2o4qG0yQw+Cpx5ClqXBRSmYYJd/Bgtj
         M0U+PAG95eEVK6cSnctApvZc1tzXSq33aQKs5nmQXudTZoEp5abmpHHsgp8a/dT9ZuFV
         9dc+eghaTDfnK+0OA8w336lz1u5MNBzBxH7Y3dsqqsDBku0H3WmmXgWEJOaZCHgnTcoW
         eW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705954404; x=1706559204;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AzHPA+4yPx7LyXG3RgofzLIgOv93IRz8DjT/NHZPD0=;
        b=v0V/ZsdvQdt0uKLKYHrYL8rtEhmP3Fewqt4rDWUu/tOaEoPqyc54rdhwkJljG+fBKD
         51jB+ZtNFo7eEnKmk/OcTAcQOIa/Xtt2bkMdSVWqzPd9kiY0sgm+wSnW8rtuxfeEb/nV
         5Ip5+XEs5IQ8hNg5qIK93R4gtTB0ElUFRd9dig8uy00CWMII4VyJrU7z6wYdMUf3Y0s+
         rpZknwJo8UyXkT/BBUrm4BPrGBoY4lYcIEPIn9BXMMO6o/PlqVm+2cJ4/rq/bAoAUq8+
         D0k3eKAdan7RFYdcSWKwncpIMAzD3KuoD+8c/y/wyzmKTwzgsYX/Yn8p4htNnknij/UI
         yfFQ==
X-Gm-Message-State: AOJu0YyWiF5xfGUuS4VaZOng98kDo9bcCCdQY+qDtNjs2LNU3qDQ+Mp7
	K39uM19CWCa7uqMqFYjxJlWZLvHz2XvX/JsLj+5srA256Zi+gqVQ
X-Google-Smtp-Source: AGHT+IE06wH975vmK3G396ZrTSixfDb9plX13baY2qLZyD9KmLBzEdMcY147axOgkMvpeUBBsJU8yw==
X-Received: by 2002:adf:f405:0:b0:337:6128:7574 with SMTP id g5-20020adff405000000b0033761287574mr1666752wro.55.1705954403800;
        Mon, 22 Jan 2024 12:13:23 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id v29-20020adfa1dd000000b0033929310ae4sm7037840wrv.73.2024.01.22.12.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 12:13:23 -0800 (PST)
Message-ID: <ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com>
Date: Mon, 22 Jan 2024 20:13:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
Content-Language: en-US
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240119142705.139374-3-karthik.188@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20240119142705.139374-3-karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 19/01/2024 14:27, Karthik Nayak wrote:
> The `is_pseudoref_syntax()` function is used to determine if a
> particular refname follows the pseudoref syntax. The pseudoref syntax is
> loosely defined at this instance as all refs which are in caps and use
> underscores. Most of the pseudorefs also have the "HEAD" suffix.
> 
> Using this information we make the `is_pseudoref_syntax()` function
> stricter, by adding the check for "HEAD" suffix and for refs which don't
> end with the HEAD suffix, matching them with a predetermined list.
> 
> This requires fixing up t1407 to use the "HEAD" suffix for creation of
> pseudorefs.

I'm concerned that this change is a regression. is_pseudoref_syntax() is 
used by is_current_worktree_ref() and so scripts that create pseudorefs 
that do not conform to your new rules will break as git will no-longer 
consider the pseudorefs they create to be worktree specific. The list of 
hard coded exceptions also looks quite short, I can see MERGE_AUTOSTASH 
and BISECT_START are missing and there are probably others I've not 
thought of.

The commit message would be a good place to discuss why you're making 
this change, the implications of the change and any alternative 
approaches that you considered. As I understand it you're tying to get 
round the problem that the files backend stores pseudorefs mixed up with 
other non-ref files in $GIT_DIR. Another approach would be to read all 
the files whose name matches the pseudoref syntax and see if its 
contents looks like a valid ref skipping names like COMMIT_EDITMSG that 
we know are not pseudorefs.

Best Wishes

Phillip

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   refs.c                        | 21 ++++++++++++++++++---
>   t/t1407-worktree-ref-store.sh | 12 ++++++------
>   2 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 5999605230..b84e173762 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -829,6 +829,14 @@ int is_per_worktree_ref(const char *refname)
>   
>   int is_pseudoref_syntax(const char *refname)
>   {
> +	/* TODO: move these pseudorefs to have _HEAD suffix */
> +	static const char *const irregular_pseudorefs[] = {
> +		"BISECT_EXPECTED_REV",
> +		"NOTES_MERGE_PARTIAL",
> +		"NOTES_MERGE_REF",
> +		"AUTO_MERGE"
> +	};
> +	size_t i;
>   	const char *c;
>   
>   	for (c = refname; *c; c++) {
> @@ -837,10 +845,17 @@ int is_pseudoref_syntax(const char *refname)
>   	}
>   
>   	/*
> -	 * HEAD is not a pseudoref, but it certainly uses the
> -	 * pseudoref syntax.
> +	 * Most pseudorefs end with _HEAD. HEAD itself is not a
> +	 * pseudoref, but it certainly uses the pseudoref syntax.
>   	 */
> -	return 1;
> +	if (ends_with(refname, "HEAD"))
> +		return 1;
> +
> +	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
> +		if (!strcmp(refname, irregular_pseudorefs[i]))
> +			return 1;
> +
> +	return 0;
>   }
>   
>   static int is_current_worktree_ref(const char *ref) {
> diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
> index 05b1881c59..53592c95f3 100755
> --- a/t/t1407-worktree-ref-store.sh
> +++ b/t/t1407-worktree-ref-store.sh
> @@ -61,18 +61,18 @@ test_expect_success 'create_symref(FOO, refs/heads/main)' '
>   # PSEUDO-WT and refs/bisect/random do not create reflogs by default, so it is
>   # not testing a realistic scenario.
>   test_expect_success REFFILES 'for_each_reflog()' '
> -	echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
> +	echo $ZERO_OID >.git/logs/PSEUDO_MAIN_HEAD &&
>   	mkdir -p     .git/logs/refs/bisect &&
> -	echo $ZERO_OID > .git/logs/refs/bisect/random &&
> +	echo $ZERO_OID >.git/logs/refs/bisect/random &&
>   
> -	echo $ZERO_OID > .git/worktrees/wt/logs/PSEUDO-WT &&
> +	echo $ZERO_OID >.git/worktrees/wt/logs/PSEUDO_WT_HEAD &&
>   	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
> -	echo $ZERO_OID > .git/worktrees/wt/logs/refs/bisect/wt-random &&
> +	echo $ZERO_OID >.git/worktrees/wt/logs/refs/bisect/wt-random &&
>   
>   	$RWT for-each-reflog | cut -d" " -f 2- | sort >actual &&
>   	cat >expected <<-\EOF &&
>   	HEAD 0x1
> -	PSEUDO-WT 0x0
> +	PSEUDO_WT_HEAD 0x0
>   	refs/bisect/wt-random 0x0
>   	refs/heads/main 0x0
>   	refs/heads/wt-main 0x0
> @@ -82,7 +82,7 @@ test_expect_success REFFILES 'for_each_reflog()' '
>   	$RMAIN for-each-reflog | cut -d" " -f 2- | sort >actual &&
>   	cat >expected <<-\EOF &&
>   	HEAD 0x1
> -	PSEUDO-MAIN 0x0
> +	PSEUDO_MAIN_HEAD 0x0
>   	refs/bisect/random 0x0
>   	refs/heads/main 0x0
>   	refs/heads/wt-main 0x0
