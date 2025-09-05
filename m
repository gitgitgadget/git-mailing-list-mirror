Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0AFA55
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757031961; cv=none; b=ZGDMAy/OyZiIq9C9pWSIt2qYCHf4hnl4XMY3eJWEFaQxAhtaZKdSMISdx8nt4ubbCTqS9EnVD+VlQdjnwx/hM3KrimRLBwdIlHR8liwfaxPP6IY8a/ROskjGokL4HuLb6gnZMT0YKop80XTYT5ml5IylhLmoTSqP+/py10UO+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757031961; c=relaxed/simple;
	bh=CV/wdBbXCbcSjDDqCQOcfxNP8nyWcl7DWZGiZSWCE+k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kyeffhcSODHuXhKefkIillJyAGhLHXOivM2LoF076GZofuBVAU4oBqXwsU3Mi6sLtVol7hs4fFp5+2DExvvxHaE4J6U4+8Z81Nq500PrZgNCSoMBSyVmOTo44s+U9l65u4EzU1SRp690QDXUsrDiW2UF+0jNIh+MqfGXd3sJ5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EV4i5OWM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV4i5OWM"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d44d734cabso1120052f8f.3
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 17:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757031958; x=1757636758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yg03lhXSpSol7fR+xmaC89AbaDf7Lp5fMS4hkGOdFt0=;
        b=EV4i5OWM3X8EuZE+CAwxQNyzGpmX3TVbY9/oBzIF+MaAjpBZOCRZ7NT9cR0uMFN7Yf
         FoTDBv9037BJIzbJzQ/2iEJVUFncypFjQzbnrLG4Yg+B5WE6YCkcnEn43nXrGkD8oI9x
         /Az12o0l3X5J9olIIAdtbvhI4lGrZe3HgYWbmNqeI0zUg9wf6oEnvLgr8EwSzNomeO58
         4kOHVrXTEsaE3PkIEtkFEY55ujZpZwUv+Q5tB3t5xACaH+VRJOAXvE4YOcTnmrtPx9zU
         uymkwmLm1bAbubrvHmOcBpjWN046rq2yYJGPD89caa9mZyx+CIEQ3nZSV3wh5MiyE97H
         6YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757031958; x=1757636758;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg03lhXSpSol7fR+xmaC89AbaDf7Lp5fMS4hkGOdFt0=;
        b=BVlNTUM2YfA2HTt1ToGdClupvSKOFoneuElXMdfaTqqnoNxHqhrXOIOd1pn4CGREI2
         aMlvmx0Os6k9NZyG+f4buWPfH1DVySlj9CXZBsSmcr1pC6CYLJdAQNn8SeFnNsV8eVg3
         IWj/ktpgB1oUIVvm3jBZj35xv5d8MFAdDvzLTaM7/qpbbpjHzQ8PW6HGMm+9NSeEP8vW
         kcJ45MDq2wggdijA6UM6E1iEOvmBYwCZGf5km3fJs0kO8d1uHJCyGCihcIO1S2BbTZCW
         IsFMVFYP1tBwU08z8CaDUi0JdIho2y3uiDda+KtiaccEWjEqIxFmBrLIib58QtzuqC7n
         lcoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG9JexNiMYyT8572KXTP27t9hL/t7yTXrzSSbL5mRIAMAj3SBcf5OWzyz63pc11xS2A5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5l+pUZJNcx/VJAybsY3/FkmZv3+wJiA8Xmx2NddG4rJ7eZ3Ij
	0ZicsEU7rn4IedD4RQTkjKbhKUp3BaGuvr8Lra1W1VNw7c+TxgITXdSl
X-Gm-Gg: ASbGncvwqLsBXU7r/BWKjSdKoKxzX8R0FtgcWv0/+uBwglVi5zbaVcg3tH9CXy+IGgt
	am6Qwqjv1lTR2+51j+zM4pibPC+k9bLfmltbUE9QhGE1dP+Bx3GP1m62/MWfD1tcJeOx9JQWZOA
	eX/74p18CtFBnYMdx5iUiSykfDB7LcNBUU1NWyxhF+Y7+tZ10oyDKnj99r0EH5UxsCvs5UD5A4X
	014XdVMUvtMbRn/Blis1ZM17hywAOAg1nDfxI2xE4a8I3KWgtddkKCpuX1QQakpX018Cyj8HjzL
	7hs0IJZNhZmZyficKcgYm1QrIW9VJNXkqJtnR9ktAM2oDod3i/Ns9GvJ5MwgCR0/m4W2P1xT1fM
	+pRcDz3taLLUREPA1pvh3beXArbQHFziRtGqSHw2bLp9PPWLcxz2IrLo2QpJYl6aURpxDZRerae
	PvQw==
X-Google-Smtp-Source: AGHT+IEXl3kdgF2MFIozRfn0qVBWWK2hRos9/I8fNMaSOK+huWYuSwmon32Y9htc/gFxMaSXvwAWCA==
X-Received: by 2002:a05:6000:2288:b0:3cd:7200:e025 with SMTP id ffacd0b85a97d-3d1dd81e7b2mr17209233f8f.5.1757031957771;
        Thu, 04 Sep 2025 17:25:57 -0700 (PDT)
Received: from [192.168.0.4] (ptr-178-51-192-26.dyn.orange.be. [178.51.192.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3decf936324sm7748949f8f.9.2025.09.04.17.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 17:25:56 -0700 (PDT)
Message-ID: <88ae6c7b-0a69-48bd-9e73-672331a22197@gmail.com>
Date: Fri, 5 Sep 2025 02:25:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
From: =?UTF-8?B?44OO44Km44OpIHwgRmxhcmU=?= <nouraellm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: =?UTF-8?B?44OO44Km44OpIHwgRmxhcmUgdmlhIEdpdEdpdEdhZGdldA==?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
 <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
 <20250904204932.GD30633@coredump.intra.peff.net> <xmqqjz2d7t2q.fsf@gitster.g>
 <52fb3fea-4842-4532-8572-df41537da5f9@gmail.com>
Content-Language: en-US
In-Reply-To: <52fb3fea-4842-4532-8572-df41537da5f9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

By *s I am referring to *s_ so a sanity check with: if (!*s_) return;

On 05/09/2025 02:07, ノウラ | Flare wrote:
> No. I am confused here.
>
> > It is a programming error, period.  Do not silently return. That's
> > not being defensive.  That is sweeping a problem under the rug.
>
> Yet
>
> > +    if (!s) return;
>
> However, I agree with Peff. After calling alloc_state_free_and_null(&foo)
> Having foo == NULL is an expected behavior, especially since the function
> Is designed to free the memory and null out the caller’s pointer using
> A double pointer ensuring the helper is idempotent
>
> So, calling it again on the same pointer is safe because it simply
> no-ops if the memory is already freed
>
> Regarding the sanity check, it should be:
>
> + if (!*s) return;
>
> The reasoning is the following:
>
> => s is the double pointer (the address of the caller’s pointer)
> => *s is the actual pointer to the memory we want to free
>
> Thus, we check !*s to allow the function to safely handle already-NULL 
> pointers
> But if we instead checked !s then we would be testing whether the 
> caller passed
> A NULL double pointer which is a programmer error
> So silently returning on !s would hide a bug
>
> Finally, I'd appreciate more explicit instructions.
>
> On 05/09/2025 00:26, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> It's probably not worth going back and forth on this too much, but I
>>> thought the happy medium was:
>>>
>>>    if (!s)
>>>     return;
>>>
>>> That is, it is perfectly reasonable and friendly for it to be a noop to
>>> free-and-null a NULL value (either never initialized, or already 
>>> freed).
>>> The overkill was worrying about whether somebody passed in a NULL
>>> double-pointer. I.e., doing:
>>>
>>>    alloc_state_free_and_null(&foo);
>>>
>>> is reasonable and should be idempotent
>> ... when foo == NULL, e.g., after alloc_state_free_and_null(&foo)
>> has just successfully returned?
>>
>> I can by that argument with the reasoning in the updated log message
>> below.  Does it good to everybody?
>>
>> Thanks.
>>
>> --- >8 ---
>> From: ノウラ | Flare <nouraellm@gmail.com>
>> Subject: [PATCH] alloc: fix dangling pointer in alloc_state cleanup
>>
>> All callers of clear_alloc_state() immediately free what they
>> cleared, so currently it does not hurt anybody that the
>> alloc_state is left in an unreusable state, but it is an
>> error-prone API. Replace it with a new function that clears but
>> in addition frees the structure, as well as NULLing the pointer
>> that points at it and adjust existing callers.
>>
>> As it is a moral equivalent of FREE_AND_NULL(), except that what it
>> frees has internal structure that needs to be cleaned, allow the
>> helper to be called twice in a row, by making a call with a pointer
>> to a pointer variable that already is NULLed.
>>
>> While at it, rename allocate_alloc_state() and name the new
>> function alloc_state_free_and_null(), to follow more closely the
>> function naming convention specified in the CodingGuidelines
>> (namely, functions about S are named with S_ prefix and then
>> verb).
>>
>> Signed-off-by: ノウラ | Flare <nouraellm@gmail.com>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   alloc.c  | 10 ++++++++--
>>   alloc.h  |  4 ++--
>>   object.c | 26 ++++++++++----------------
>>   3 files changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/alloc.c b/alloc.c
>> index 377e80f5dd..533a045c2a 100644
>> --- a/alloc.c
>> +++ b/alloc.c
>> @@ -36,19 +36,25 @@ struct alloc_state {
>>       int slab_nr, slab_alloc;
>>   };
>>   -struct alloc_state *allocate_alloc_state(void)
>> +struct alloc_state *alloc_state_alloc(void)
>>   {
>>       return xcalloc(1, sizeof(struct alloc_state));
>>   }
>>   -void clear_alloc_state(struct alloc_state *s)
>> +void alloc_state_free_and_null(struct alloc_state **s_)
>>   {
>> +    struct alloc_state *s = *s_;
>> +
>> +    if (!s)
>> +        return;
>> +
>>       while (s->slab_nr > 0) {
>>           s->slab_nr--;
>>           free(s->slabs[s->slab_nr]);
>>       }
>>         FREE_AND_NULL(s->slabs);
>> +    FREE_AND_NULL(*s_);
>>   }
>>     static inline void *alloc_node(struct alloc_state *s, size_t 
>> node_size)
>> diff --git a/alloc.h b/alloc.h
>> index 3f4a0ad310..87a47a9709 100644
>> --- a/alloc.h
>> +++ b/alloc.h
>> @@ -14,7 +14,7 @@ void *alloc_commit_node(struct repository *r);
>>   void *alloc_tag_node(struct repository *r);
>>   void *alloc_object_node(struct repository *r);
>>   -struct alloc_state *allocate_alloc_state(void);
>> -void clear_alloc_state(struct alloc_state *s);
>> +struct alloc_state *alloc_state_alloc(void);
>> +void alloc_state_free_and_null(struct alloc_state **s_);
>>     #endif
>> diff --git a/object.c b/object.c
>> index c1553ee433..986114a6db 100644
>> --- a/object.c
>> +++ b/object.c
>> @@ -517,12 +517,11 @@ struct parsed_object_pool 
>> *parsed_object_pool_new(struct repository *repo)
>>       memset(o, 0, sizeof(*o));
>>         o->repo = repo;
>> -    o->blob_state = allocate_alloc_state();
>> -    o->tree_state = allocate_alloc_state();
>> -    o->commit_state = allocate_alloc_state();
>> -    o->tag_state = allocate_alloc_state();
>> -    o->object_state = allocate_alloc_state();
>> -
>> +    o->blob_state = alloc_state_alloc();
>> +    o->tree_state = alloc_state_alloc();
>> +    o->commit_state = alloc_state_alloc();
>> +    o->tag_state = alloc_state_alloc();
>> +    o->object_state = alloc_state_alloc();
>>       o->is_shallow = -1;
>>       CALLOC_ARRAY(o->shallow_stat, 1);
>>   @@ -573,16 +572,11 @@ void parsed_object_pool_clear(struct 
>> parsed_object_pool *o)
>>       o->buffer_slab = NULL;
>>         parsed_object_pool_reset_commit_grafts(o);
>> -    clear_alloc_state(o->blob_state);
>> -    clear_alloc_state(o->tree_state);
>> -    clear_alloc_state(o->commit_state);
>> -    clear_alloc_state(o->tag_state);
>> -    clear_alloc_state(o->object_state);
>> +    alloc_state_free_and_null(&o->blob_state);
>> +    alloc_state_free_and_null(&o->tree_state);
>> +    alloc_state_free_and_null(&o->commit_state);
>> +    alloc_state_free_and_null(&o->tag_state);
>> +    alloc_state_free_and_null(&o->object_state);
>>       stat_validity_clear(o->shallow_stat);
>> -    FREE_AND_NULL(o->blob_state);
>> -    FREE_AND_NULL(o->tree_state);
>> -    FREE_AND_NULL(o->commit_state);
>> -    FREE_AND_NULL(o->tag_state);
>> -    FREE_AND_NULL(o->object_state);
>>       FREE_AND_NULL(o->shallow_stat);
>>   }
