Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529BF17BC5
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303093; cv=none; b=Z0DVzZKvk/CWL/8aqsqvDmVVQFnY6mUke9LSWXYuh+QiR4YzmuyzW8ceLaT1xiD2oy1Gbh32PxXfebY6SigmqH82q7Ic8gfchcFsDJQ7Zg6AWZZIDN2CD96AzQThXrfkHNkDmfaiL92YWHPOak+JAuDqRCc9GEDOk+xeoMNyL/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303093; c=relaxed/simple;
	bh=87cwyWAux1CTEQwlp2oh/LPSjqN/iHnZqlukSumsEe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBX9UjDbO4o4R1G+AAhE+0hyLXjNmTjFnLqMzPSlKeBZPA6T3Gs2zu8zd0FKbhbBOLgPpk5EFQUZ9cHJg8VL2QUX+qhC0pkyve5Ur5D+Ig1DlsYkxSH6t7dEqZ587tkiq+V8f0ng1m7ryTCdzIggIK9QUEHiQqxTOykDT8lToiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0+GpQlH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0+GpQlH"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so3886425e9.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 02:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707303089; x=1707907889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+LshZI4kWaIAwzNtPuoN7nDWAho9hfh2metUYEzZHso=;
        b=f0+GpQlHX0SWk5qySozTptOIYWSm0s8z1yviuZZaJQGqgsXWIwRLmIC0WsXnROkdVU
         mRvUgeGOXZEKH7EdC1/L36FuNNQoK1q8S0Z77XwXS+W90X85gn+ADfI1n/MXw2GWyMcn
         QJPGGvYFoO0DiUcgUIovP3glRL2Q1AwfzJXGWml6emifRwpanUXOTtmdkz1ezbbwYaXk
         TwQedvaVdk0CMD2e4jJTuJh3ZxWWBW5n88YxD6hqjUNTsj9sLHVyok5Es1Ylu2N0WV5Q
         j6qcE1/9dZg+VxLp9BRb2eg8PJEHqJrGl3G9QuXuKNs+pBOsfRnPBd7u+RcebDfYCNAa
         wgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707303089; x=1707907889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LshZI4kWaIAwzNtPuoN7nDWAho9hfh2metUYEzZHso=;
        b=vdQsCvTWkt6TAZNsYVYsgSxzsYzIGJCiYckUTbdbjBNZ54yuqcXBOyCw2ccKmO73L7
         BOI9vazH8yM6X4ynajEHEXOp6oP17rMB38mEg13TJgl+6BatN8tsAIeRYYlQoe5f4M5l
         Vxs0OYc1ElH/AOzSbzsE7KZXcsll2KiklOah2XONvjTj6CoSsl5gRcrrjrjuL2XnRR6Z
         gGqipnK+r/yiISwes4zaQRWqG3V4C9wOdsk1g1MUhsmfjDuD1HWe2NMPEleFVsLbvyIJ
         7FDsg5Uyhm3Sp22KlrDRSwLPCYlhFibsX/UvxVUCAlQzda2hiruJIbg+fDlWv6uqRtlc
         vnYg==
X-Forwarded-Encrypted: i=1; AJvYcCXRXJb7c18YcW63jlRzEx+hXt0XMr76PKFodAEYDsoxx7yI3Atm/CLZ3tBW3V3Law9IlCNUB5QyNxuUwEX07kVHMEWt
X-Gm-Message-State: AOJu0YyYlaGuy5Z2EoIsNDvEll4u0nC2ePz1IEVyQtTMnIFEcb493HDU
	f4GzAtxd/47PBBMDzX1JFqIi4mssXxkIwUHUJJZbVvGY8HFF/wDs
X-Google-Smtp-Source: AGHT+IHTwcwA7yaU6Z2b9H5y87SV7DoHD9F/Vh7ZWtNubY7BGZ/s1Aa8sMdymu4tLy6xVO9KzuW1Qg==
X-Received: by 2002:a05:600c:5249:b0:40e:491d:ac80 with SMTP id fc9-20020a05600c524900b0040e491dac80mr4397507wmb.15.1707303089375;
        Wed, 07 Feb 2024 02:51:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVdDOVHW8FE4RRQYz+sd/ecRL8CYtE3uMRtrxOCd94RLP7llV6FU/sEFIDk90TJ+7jkVxaqaYNvHycL8p7OBzOzejUtLzVHWWXoK9bFPs=
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id b15-20020a05600010cf00b0033b4e58746asm1140381wrx.69.2024.02.07.02.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 02:51:29 -0800 (PST)
Message-ID: <99fcba4a-a4f7-4d72-8238-09d9bf7851ce@gmail.com>
Date: Wed, 7 Feb 2024 10:51:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/3] add-patch: remove unnecessary NEEDSWORK comment
Content-Language: en-US
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
 <20240206225122.1095766-4-shyamthakkar001@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240206225122.1095766-4-shyamthakkar001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ghanshyam

On 06/02/2024 22:50, Ghanshyam Thakkar wrote:
> The comment suggested to compare commit objects instead of string
> comparison to 'HEAD' for supporting more ways of saying 'HEAD' (e.g.
> '@'). However, this approach would also count a non-checked out branch
> pointing to same commit as HEAD, as HEAD. This would cause confusion to
> the user.

I forgot to say before, but I think this could be squashed into the next 
patch so we remove the comment at the same time as fixing the issue it 
describes.

Best Wishes

Phillip

> Junio described it best as[1]:
> 
> "Users may consider 'HEAD' and '@' the same and
> may want them to behave the same way, but the user, when explicitly
> naming '$branch', means they want to "check contents out of that
> OTHER thing named '$branch', not the current branch"; it may or
> may not happen to be pointing at the same commit as HEAD, but if
> the user meant to say "check contents out of the current commit,
> (partially) reverting the local changes I have", the user would have
> said HEAD.  After all, the user may not even be immediately aware
> that '$branch' happens to point at the same commit as HEAD."
> 
> [1]: https://lore.kernel.org/git/xmqqmssohu69.fsf@gitster.g/
> 
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
>   add-patch.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 79eda168eb..68f525b35c 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1729,14 +1729,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>   	if (mode == ADD_P_STASH)
>   		s.mode = &patch_mode_stash;
>   	else if (mode == ADD_P_RESET) {
> -		/*
> -		 * NEEDSWORK: Instead of comparing to the literal "HEAD",
> -		 * compare the commit objects instead so that other ways of
> -		 * saying the same thing (such as "@") are also handled
> -		 * appropriately.
> -		 *
> -		 * This applies to the cases below too.
> -		 */
>   		if (!revision || !strcmp(revision, "HEAD"))
>   			s.mode = &patch_mode_reset_head;
>   		else

