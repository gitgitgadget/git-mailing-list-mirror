Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D524A069
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360532; cv=none; b=rGd/xhPgGEd+ce4cLnvgTQB4o/yYwZlk3d+IvlqfyEFrdhTAnFVx6FCXszX0tGk53YkHWKtgfpqghehKa/uJldxRF3U9ky/+yn2jaFQz40rAclM/izrmxCjgJNYjXNWdjCavGpL4sjNvXIpVT3ahUE4GTUN84STuBHkqgQ7yVIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360532; c=relaxed/simple;
	bh=MQ96XK49QVXCi6NZrZCOZ4IH7kkM9Nfu3yVCHrt+TpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2JhZrv+Fko31RPg9cAA2PmX45KojscijGQb6/EZjDO5teGKz/ExKFHDSPJFRPUH/O+u6XWwaifEBqlyDGMZ+bukwc98qd/sLb/3Q5H1DleZ5oYd1wCZywA5cenTKqZ0hx6XAP6is7aNrTtjDxwqx88Hm+cPyYb8qFWkAcbOPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoWQPWtz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoWQPWtz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47755a7652eso29015e9.0
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 08:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762360528; x=1762965328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SlHL9d5Bbex0o0U83RfTeD5zT9C+YvPM/1jV172w4Dg=;
        b=PoWQPWtzVXn5rm1plkPTjKQPTQ29aYRo3Lb7VME6SwtX9BIPrr/bUzhkqS7x5Dn4bf
         EoWkv7GDjW52ONjRUe1fZHEkhK7IJGiwJKWLpRK0qIznU/anOM0ce9rWLjxqAJm1eZ2C
         Kil8M/adLpKpTpCyH2a4KY559WH4I/MZgP0kkJ//OIC0bxbig7nSvNfHf/mjK2VB6Ors
         6ATWLfdPtoTIJnYP0kdaI5gcPvuSp2PSwQ2d9iLf35BrCHOmK9ymGuHA9QOADpfZpZ3J
         nDao/ku60YqF1ZkAb9/U0CZwX2DnLyWWCV2i5JtPfIxHv5Pn1GWsoBRdnE6mhVqXb7kA
         lqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360528; x=1762965328;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlHL9d5Bbex0o0U83RfTeD5zT9C+YvPM/1jV172w4Dg=;
        b=S/8IUUEssDRhU/9/G9gvwZOM0X14f69F6coDVZopq6vSE5mROBCEqqWnV9l4PuRGeD
         Pg4PwATdBl+cPwysp6OMMHw14SODfADsdEEaUPExq/q3ZbHBH8N8p1gE6+wlBa6gQjey
         z5s0u8yWXKMyYKz+5wHjPj7/C6wCse1FlRmlQuUb2C3jkqfa8fEva8mr3sHiPQ2qAUmZ
         bA+5zBXYQp0Bhi6ZbtEMKgVtU9C7cNEjPkGpFMTxDsYBZullstzpr7dQptKXFaYF02Aq
         kjrlrManOLGJE+XNcoqvd5rGRSnz6toGUkeL4qmp/yNjz4v+xT0wReLMkF8Nm11vcQf+
         qn1w==
X-Forwarded-Encrypted: i=1; AJvYcCVH8P/i7145bBr/ULqSjqQofLPpBSTtUKEQoKETVyIVyGs660kScBCyB3+lxdzmTvpPfzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9P6H+eVmu+QxsM0h1LikZFQ31ny+NPb+cgWVe9KPgmTeHY34w
	rpD1tdJYF6utz5MGgB64n0mEuW3VsL2BqNWesrBSGwYJZyYWaanPN4cg
X-Gm-Gg: ASbGncsaA2oKyiVyQhiBJFp7RZtAc2cwZTQEKVGqIa8QiXBCkEcdGVvut2vSMQNEWMW
	+tTiTWg66leT6HX09OiLEqO0w0av1MNE8Ysp0jjgmowxqHCj7jimR7Dv0d6gn/0c5TGV6T0U41l
	E9nXfbh5zABE3dU2JDhf/FmnqdZrTSCpWzAMAsgroGSXLpLquh2Gc4I37hMNqkVFvOGwLFaYBU/
	mHPNnB1sUrt9BQrn+99j+VSoU216A10A7/dss84QA6dTiouMSkOW5+4n0l9y9GwYqnVI5Cfju0R
	eJEcvYXTZF6ASTqK77KFDS//wZngR3nZ/17LnR3cIlEUAuCN/pHjAEjPriLfzIu0Wak+8zyUZUE
	/125aYbKVGbhJPieVeZc0mhlPYmVgJfvnw684OpCzDEOTODq0PA2NWgMAOIwDKcObledgLefQnS
	FLx1fkxIw+/oEiw52CcYKiQi/M70O7/J4pf+KyAh2zteoo6N57ZxSpZIYKUCHFs2E=
X-Google-Smtp-Source: AGHT+IE6Fvdap9jvIDspKdYtEGErgrB/N0q2JAm5S0u1GqwHfYiT0VjekN5ph0Du/4Gkz++Lq5X6sw==
X-Received: by 2002:a05:600c:5299:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-4775ce1610fmr28899335e9.16.1762360528199;
        Wed, 05 Nov 2025 08:35:28 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c4edasm45444415e9.5.2025.11.05.08.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:35:27 -0800 (PST)
Message-ID: <5951a930-0e57-4201-9b56-12a41cb44333@gmail.com>
Date: Wed, 5 Nov 2025 16:35:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/5] parseopt: fix :(optional) at command line to only
 ignore missing files
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
 <9ec696eaac647aa01466b101129da2b12ef5dbd5.1762100242.git.ben.knoble+github@gmail.com>
 <ec8d1764-649d-4edf-b0ae-a19ead5f6f9a@gmail.com> <xmqq1pmdr9qu.fsf@gitster.g>
 <xmqqwm45puqr.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqwm45puqr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2025 17:34, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> Let me have this on top of Ben's 5-patch series.
> 
> ----- >8 -----
> Subject: [PATCH] parseopt: remove unreachable code
> 
> At this point in the code after running skip_prefix() on the
> variable and receiving the result in the same variable, the contents
> of the variable can never be NULL.  The function either (1) updates
> the variable to point at a later part of the string it originally
> pointed at, or (2) leaves it intact if the string does not have the
> prefix.  (1) will never make the variable NULL, and (2) cannot be
> the source of NULL, because the variable cannot be NULL before
> calling skip_prefix(), which would die immediately by dereferencing
> the NULL pointer in that case.

Nicely explained, the changes below look good

Thanks

Phillip

> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   parse-options.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 27c1e75d53..97a55300e8 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -223,8 +223,6 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
>   			return 0;
>   
>   		is_optional = skip_prefix(value, ":(optional)", &value);
> -		if (!value)
> -			is_optional = false;
>   		value = fix_filename(p->prefix, value);
>   		if (is_optional && is_missing_file(value)) {
>   			free((char *)value);

