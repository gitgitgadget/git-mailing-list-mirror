Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF11FC3
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030564; cv=none; b=iJ8J4XJcXTOFEvtMmte8CFzO9WOZ5sDPxl+fWAdgJZerF2IkbabcGfiMVZGYI8V/lP994qSaoWoL6jPsvmQdLcEq4kHwMf8GuCk2MnhpJTCdydeRATeUzsiDtky0yMiEcHFyyO2yY6eT0HnBlGeLbW8ySyqbopK5O3cVrnD84+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030564; c=relaxed/simple;
	bh=To8iFFmttzLbswQ+lzdQ2N/3kZzQTdixe0zx3RrCS98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7IEQ8k4774AZjQnGspJTxfepL7BsFqY2S405pxcngeDa5isEkJhx/tWXh74GO42aW6jgxw48obn1L8u4lr/a0C/J90BQmFtZU22namgZJBcYx9omYlP4hLz5QEsIXMDnDNqoXDl0AZ0n2HP63VsS04QOBlYPKWMwCyiStMw21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSieKcNC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSieKcNC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45cb5492350so10735825e9.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 17:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757030561; x=1757635361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c9OCslP5+to20RbmwCtSj5+ONdge+NSERx+4RjqKB+E=;
        b=cSieKcNCEXfe1ukleWXv5TBva53iE1BfT0HgfhT3KU/WKsi+sTEKwHQtLh50lQ2/Lz
         5Mj+pmXJ0pXrfKPiGe5YkhPvp92JYzy6/N2wPfaXJJwWfX5BTGbeO8sAopGNERFKC0EI
         7IJV7bYo0JqjeX+Vz4gG/ZWioaniMm73rPVX4aqD4U9vNP1LFLXn7WKvAkOqfJAwEIP9
         nDtp5T8Hi43AAHszoJ5xxR5pDyUfWku2M1/caj+nu7ReIgzrgEZe2KVk2UUldmK2kPk8
         9IyAVLPY1fSa9BMu3DqF9NBNk+qUIXzrO8qsmLgv9UQBGUDT5qOwfEWcl1i8f+72bLR6
         DFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757030561; x=1757635361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9OCslP5+to20RbmwCtSj5+ONdge+NSERx+4RjqKB+E=;
        b=B7LVHoRy5djrmzLKxit/7+olgcHvBsan+Wjkqk5//qB0LfiIRzJq6SWf1N6RT4NvzM
         Y9fjNJFbpjNB2bF3xUZQ5FD3yp5yeBVdjNPF9Alt51KgNHYTts0etvCfIHLHq6W2a6tW
         IC5oi2bzHbS0rMPVHXQlvvntivGAx0aJ+V/MAs3yc1CtDD/EGHmy1CARGR17dYbmkWtt
         tNJqSDCYk5R+jUab1scC0ntafaeHjRbcEri5q7HYOVWIsbfxwp9i3In76lRhOAcJm6e4
         fYQy+uhw1frjN+EjjFaPd50obPOFErjc3z4gFEl/53r3GhsJojYxbP6xUAVStBgg21N5
         iXAA==
X-Forwarded-Encrypted: i=1; AJvYcCXkUt81OE3/HnHnnfG5aUJNAMgJAySalwYy3pQ00LMCsCNB/NHAaOi4rmeGBwnN8YMtNwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76TgLjxerykFjyIl/P3Lorr+WuvCa+2MyvHnjG9Q+LM9y3xlf
	ZyJaRqKXeNLg1gJyRPs6lLpry+8Z8fpvCMLX33PDDIMa/wTuxPX+ZEvkbAKdcb2uBso=
X-Gm-Gg: ASbGncvNqrYyZHIVs+0skVga/DsAd0xqW5uHETluiJyMVhK55U3ImHAW1URyzgRDweY
	p+yq5W+MpaVJ5cG09NlBy4muvfdITSlv61NtShiwYNofxEJ/BYiwHvJ9IZX1YOj9itacth/m4Sj
	AsRRB71clD9blG18fa25XUmg2Wb0dBWQYLi196t0aAgyKz6USRBBv504h2DZOS+URfHY1DiYj86
	gjSfqTBZwQJkjcSCPx9cvIanjC/jyZBvKIbDsC2FJFmrEjHzUe4NPh7hl06dN5NdE+TyCeETOVV
	VkOgdylkKWGavbO70ADVInsb5yd11fS1ICMJ4uUHxkmhtyR0Cp92o3OMJ4fBaphYKbwlb1eeAyV
	KZMLIAhNXRmWluUGcyEBxCtt9juV/f0JOqP73exff7iy3cmLp+6TRHTz6wnc8PkEQLKjwiujkFn
	1RB10LJif5rC7R
X-Google-Smtp-Source: AGHT+IG7aaemo5xkrn5aNCT+UdX9WqmS9mwwT0fcd9PqdbJ2C0EM44X3vBEvQ6A2tntGbASS7viGjQ==
X-Received: by 2002:a05:600c:314c:b0:45d:d356:c358 with SMTP id 5b1f17b1804b1-45dd3a26584mr35798115e9.16.1757030560703;
        Thu, 04 Sep 2025 17:02:40 -0700 (PDT)
Received: from [192.168.0.4] (ptr-178-51-192-26.dyn.orange.be. [178.51.192.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b81a9e971sm318729905e9.18.2025.09.04.17.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 17:02:40 -0700 (PDT)
Message-ID: <8f831259-7372-4357-b059-cc21f7a04864@gmail.com>
Date: Fri, 5 Sep 2025 02:02:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: =?UTF-8?B?44OO44Km44OpIHwgRmxhcmUgdmlhIEdpdEdpdEdhZGdldA==?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
 <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
 <20250904204932.GD30633@coredump.intra.peff.net> <xmqqjz2d7t2q.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?B?44OO44Km44OpIHwgRmxhcmU=?= <nouraellm@gmail.com>
In-Reply-To: <xmqqjz2d7t2q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

No. I am confused here.

 > It is a programming error, period.  Do not silently return. That's
 > not being defensive.  That is sweeping a problem under the rug.

Yet

 > +    if (!s) return;

However, I agree with Peff. After calling alloc_state_free_and_null(&foo)
Having foo == NULL is an expected behavior, especially since the function
Is designed to free the memory and null out the caller’s pointer using
A double pointer ensuring the helper is idempotent

So, calling it again on the same pointer is safe because it simply
no-ops if the memory is already freed

Regarding the sanity check, it should be:

+ if (!*s) return;

The reasoning is the following:

=> s is the double pointer (the address of the caller’s pointer)
=> *s is the actual pointer to the memory we want to free

Thus, we check !*s to allow the function to safely handle already-NULL 
pointers
But if we instead checked !s then we would be testing whether the caller 
passed
A NULL double pointer which is a programmer error
So silently returning on !s would hide a bug

Finally, I'd appreciate more explicit instructions.

On 05/09/2025 00:26, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> It's probably not worth going back and forth on this too much, but I
>> thought the happy medium was:
>>
>>    if (!s)
>> 	return;
>>
>> That is, it is perfectly reasonable and friendly for it to be a noop to
>> free-and-null a NULL value (either never initialized, or already freed).
>> The overkill was worrying about whether somebody passed in a NULL
>> double-pointer. I.e., doing:
>>
>>    alloc_state_free_and_null(&foo);
>>
>> is reasonable and should be idempotent
> ... when foo == NULL, e.g., after alloc_state_free_and_null(&foo)
> has just successfully returned?
>
> I can by that argument with the reasoning in the updated log message
> below.  Does it good to everybody?
>
> Thanks.
>
> --- >8 ---
> From: ノウラ | Flare <nouraellm@gmail.com>
> Subject: [PATCH] alloc: fix dangling pointer in alloc_state cleanup
>
> All callers of clear_alloc_state() immediately free what they
> cleared, so currently it does not hurt anybody that the
> alloc_state is left in an unreusable state, but it is an
> error-prone API. Replace it with a new function that clears but
> in addition frees the structure, as well as NULLing the pointer
> that points at it and adjust existing callers.
>
> As it is a moral equivalent of FREE_AND_NULL(), except that what it
> frees has internal structure that needs to be cleaned, allow the
> helper to be called twice in a row, by making a call with a pointer
> to a pointer variable that already is NULLed.
>
> While at it, rename allocate_alloc_state() and name the new
> function alloc_state_free_and_null(), to follow more closely the
> function naming convention specified in the CodingGuidelines
> (namely, functions about S are named with S_ prefix and then
> verb).
>
> Signed-off-by: ノウラ | Flare <nouraellm@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   alloc.c  | 10 ++++++++--
>   alloc.h  |  4 ++--
>   object.c | 26 ++++++++++----------------
>   3 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/alloc.c b/alloc.c
> index 377e80f5dd..533a045c2a 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -36,19 +36,25 @@ struct alloc_state {
>   	int slab_nr, slab_alloc;
>   };
>   
> -struct alloc_state *allocate_alloc_state(void)
> +struct alloc_state *alloc_state_alloc(void)
>   {
>   	return xcalloc(1, sizeof(struct alloc_state));
>   }
>   
> -void clear_alloc_state(struct alloc_state *s)
> +void alloc_state_free_and_null(struct alloc_state **s_)
>   {
> +	struct alloc_state *s = *s_;
> +
> +	if (!s)
> +		return;
> +
>   	while (s->slab_nr > 0) {
>   		s->slab_nr--;
>   		free(s->slabs[s->slab_nr]);
>   	}
>   
>   	FREE_AND_NULL(s->slabs);
> +	FREE_AND_NULL(*s_);
>   }
>   
>   static inline void *alloc_node(struct alloc_state *s, size_t node_size)
> diff --git a/alloc.h b/alloc.h
> index 3f4a0ad310..87a47a9709 100644
> --- a/alloc.h
> +++ b/alloc.h
> @@ -14,7 +14,7 @@ void *alloc_commit_node(struct repository *r);
>   void *alloc_tag_node(struct repository *r);
>   void *alloc_object_node(struct repository *r);
>   
> -struct alloc_state *allocate_alloc_state(void);
> -void clear_alloc_state(struct alloc_state *s);
> +struct alloc_state *alloc_state_alloc(void);
> +void alloc_state_free_and_null(struct alloc_state **s_);
>   
>   #endif
> diff --git a/object.c b/object.c
> index c1553ee433..986114a6db 100644
> --- a/object.c
> +++ b/object.c
> @@ -517,12 +517,11 @@ struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
>   	memset(o, 0, sizeof(*o));
>   
>   	o->repo = repo;
> -	o->blob_state = allocate_alloc_state();
> -	o->tree_state = allocate_alloc_state();
> -	o->commit_state = allocate_alloc_state();
> -	o->tag_state = allocate_alloc_state();
> -	o->object_state = allocate_alloc_state();
> -
> +	o->blob_state = alloc_state_alloc();
> +	o->tree_state = alloc_state_alloc();
> +	o->commit_state = alloc_state_alloc();
> +	o->tag_state = alloc_state_alloc();
> +	o->object_state = alloc_state_alloc();
>   	o->is_shallow = -1;
>   	CALLOC_ARRAY(o->shallow_stat, 1);
>   
> @@ -573,16 +572,11 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
>   	o->buffer_slab = NULL;
>   
>   	parsed_object_pool_reset_commit_grafts(o);
> -	clear_alloc_state(o->blob_state);
> -	clear_alloc_state(o->tree_state);
> -	clear_alloc_state(o->commit_state);
> -	clear_alloc_state(o->tag_state);
> -	clear_alloc_state(o->object_state);
> +	alloc_state_free_and_null(&o->blob_state);
> +	alloc_state_free_and_null(&o->tree_state);
> +	alloc_state_free_and_null(&o->commit_state);
> +	alloc_state_free_and_null(&o->tag_state);
> +	alloc_state_free_and_null(&o->object_state);
>   	stat_validity_clear(o->shallow_stat);
> -	FREE_AND_NULL(o->blob_state);
> -	FREE_AND_NULL(o->tree_state);
> -	FREE_AND_NULL(o->commit_state);
> -	FREE_AND_NULL(o->tag_state);
> -	FREE_AND_NULL(o->object_state);
>   	FREE_AND_NULL(o->shallow_stat);
>   }
