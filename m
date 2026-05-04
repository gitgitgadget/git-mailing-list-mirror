Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D13DC4B3
	for <git@vger.kernel.org>; Mon,  4 May 2026 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900216; cv=none; b=DV3mLfeUeTfsqY0cQ6UTLUqx7YepTfJFesf0WWiXPu6I9LNWG0pE7YFVWvu8ibcyAR6tUOkDFQV6KyfuC/2Q9wa4bPwKp6U+4ly8GOkqSliXLRvJ9Jct+8X3iG2V+B5aCi2B00bAAjEFS6MdSVsNSuGu9ElcXfYKHf/vX6CQHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900216; c=relaxed/simple;
	bh=OPLrg/h8xxV+okM49kM8W886NgQ2ZaSIc4FEohBISI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Th8+/XiUS2z6nIpC9eiPcIvV7EQgggmUEIKkbMT0zOU/J08iEjABWZY3Cfb8ft+pWeDh4GQG09tvZx+/pFHYG7mIrtOHyi82Z4vxtCfTEqW56Z7gcGzN04X2H4V8j26yBwbTPN91YRh7PJKbb9fV7kXEGdOPyIUXcl6Y7vQo9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPAXAUfa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPAXAUfa"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ba840146so35204275e9.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777900213; x=1778505013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGsoy4m3iKrBKFihCsQvh33YFLobMvC/R/f5oSo2X34=;
        b=cPAXAUfa35MS7l0KL06VIDGgtu+5hK4yrzhrpH3k88cVfGwNYt6l7CahsyTcY3JgY2
         VDzS9t9Fs6yEDhL3wS2mXmnGfWxtAqCrEFcF4znCSvzpyumsAFbRiYmJa5gzlxR+NRF1
         rthntb47W4tmEoEOcURumqLu8zCV9FRkMBxQMVQjIsAkHnQu0t5W5qwN4aYBJIxtHh8t
         foODxnkNV0lBaTxdQ8pNs/f+ME2hHyn9qy442YG5jtjKw6d1r+sh7Z000AP38nmdGzY2
         XgNoeSoZA4n98pPikbeCd0B313Y9Gi8likyL26XHoBuS05Z06mARXLmBz9jEsUilJlu7
         HtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777900213; x=1778505013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGsoy4m3iKrBKFihCsQvh33YFLobMvC/R/f5oSo2X34=;
        b=g3sqcvZDbey+zR/M86x1j97t5hNwhkAgZQqnfqcwImLcJfe1bO6R9f0ITISV4evdJL
         ZKZe0ht8F9HBBz//7vXjGXoP7E5qbTgDdSHh0SQ4AiLyVUHotzeE0Sn9Z5c7OdM0DlcT
         Yr5D/4M4kqcg12bT8LF9i2OH4kZRGBNE35NIsmF7xTaALURdE9yaU0osZCXj3+6QCJvL
         UtcOCuTKigvx7Vbhg6xx1YsjkIj4148FlAOIOILJTmDrESREthaxZ5+tjiZbvEkcNxr7
         XGwX/OMNTnukXXWvyyL0gEHDcJCwIkEbROfbPiLnnH2jky+c+QVBptr5RyRdIKJKASe4
         zopg==
X-Forwarded-Encrypted: i=1; AFNElJ8w7eV818Uome2fZUNf+7mqK+1/hI3LZ/MBKeVVnGCMClqjBTBZ0XvQmDAR+V9KBd6B3tY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7bLvnDQuxBsC1CkHnPTji9TYEasYdZMT7IZWKWk9H7++hCjYp
	C1HYQDAwnUz1W4RKB0XCRvQcXwm04TYHn9lq0ZMS34VNjSBkCjqGB042
X-Gm-Gg: AeBDietSflLMUEvD5MNFuFAFQpqfbzxxT8kE8aue5QcZ8i3rYSRljknUD7uPRcd0bDH
	lphgwrQKFl0q7QjhxnjVrT9Ch2mpI2XONgPJHysFOfFhHzxmk1/NtMJFg2/3tGqBrVandqfxDn3
	xb6xhhz8yUMf26pE9Gut2ZW5M60gGroCpoHoe2zOPQ3Zwl2HCJ/ULvBKxn/51Oe95u+O7kia0RC
	R2pjAy6jYXG99vB6L/T1YRb2buhrX1sDcJmgUG5zF4/9avZCsIBskVb/lW/n3P2cRHl7cZ2wMUH
	Xz03mSzuPvphkWkCsHkMTOYf2dajx7y+8aNvGF6SOVPJ+bAXKUrEMzKWacdKfAf6KH4ZosPDtGu
	T1pYU+SRUW8VnKbwqf/mzhg0Y8MVII0cz0kGvwbDnuxL3AAhYClrAFbIOioFL8d/u9MzUMChbeF
	70k75V0CPwZFn6kp3a7sWo3Do6AGt9cTTmKqFXJ8TRjwHPJ8z8ruwL+bG6iGYW+sUvKJ5Dso79s
	3dao6Fcp2F0Rg0+zvgIBg==
X-Received: by 2002:a05:600c:c4b8:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-48a98675ca0mr155371325e9.27.1777900212608;
        Mon, 04 May 2026 06:10:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1706:1a01:60e5:d619:d6a8:b2a? ([2a0a:ef40:1706:1a01:60e5:d619:d6a8:b2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8feb47cbsm79598645e9.15.2026.05.04.06.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 06:10:12 -0700 (PDT)
Message-ID: <a7819ca3-7e57-4ba1-94e3-aab427fad678@gmail.com>
Date: Mon, 4 May 2026 14:10:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] grep: fix --column --only-match for 2nd and later matches
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Brandon Chinn <brandonchinn178@gmail.com>, git@vger.kernel.org
References: <CAGANf=dkRgFp+bEkB5f8QBeiR3m+3WE8sKqT9vKstkGHqbxA3A@mail.gmail.com>
 <9bd69678-f04b-41d2-ad74-a386820d34c8@web.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <9bd69678-f04b-41d2-ad74-a386820d34c8@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 24/04/2026 22:04, René Scharfe wrote:
> diff --git a/grep.c b/grep.c
> index c7e1dc1e0e..a54e5d86a9 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1267,6 +1267,7 @@ static void show_line(struct grep_opt *opt,
>   		regmatch_t match;
>   		enum grep_context ctx = GREP_CONTEXT_BODY;
>   		int eflags = 0;
> +		const char *start = bol;

Here we save a pointer to the start of the line

>   		if (want_color(opt->color)) {
>   			if (sign == ':')
> @@ -1285,6 +1286,7 @@ static void show_line(struct grep_opt *opt,
>   			if (match.rm_so == match.rm_eo)
>   				break;
>   
> +			cno = bol - start + match.rm_so + 1;

and then we calculate the column number relative to that.

That looks good, thanks for fixing it

Phillip

>   			if (opt->only_matching)
>   				show_line_header(opt, name, lno, cno, sign);
>   			else
> @@ -1294,7 +1296,6 @@ static void show_line(struct grep_opt *opt,
>   			if (opt->only_matching)
>   				opt->output(opt, "\n", 1);
>   			bol += match.rm_eo;
> -			cno += match.rm_eo;
>   			rest -= match.rm_eo;
>   			eflags = REG_NOTBOL;
>   		}
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 64ac4f04ee..bd439563d6 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -322,11 +322,11 @@ do
>   		${HC}file:1:5:mmap
>   		${HC}file:2:5:mmap
>   		${HC}file:3:5:mmap
> -		${HC}file:3:13:mmap
> +		${HC}file:3:14:mmap
>   		${HC}file:4:5:mmap
> -		${HC}file:4:13:mmap
> +		${HC}file:4:14:mmap
>   		${HC}file:5:5:mmap
> -		${HC}file:5:13:mmap
> +		${HC}file:5:14:mmap
>   		EOF
>   		git grep --column -n -o -e mmap $H >actual &&
>   		test_cmp expected actual

