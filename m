Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB22BB1D
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598928; cv=none; b=Ce+yZfkl+XyCOc2C7kWjRGs3XyioJxpG5QuH2QJ5p1GSGyHcw6pUUtD4QIYKp9y73raodibuiBMwx35Sz9g25io7ezKmYro8LFwinzHYDg5R++i68EWGQdLKM8huqyclTx/ZWFcsuAt7bmDj9Vku/56Obp4WOCUXmhDIjKm12cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598928; c=relaxed/simple;
	bh=NL/DT5lFVHmc4AILTs8xEI9v/ziaQ6ccwKBLIe+LOZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MElTTWsMeFIwkBYF8MwX03nU/xZca2kKpE1BJQwHH9AZUfmRFiZmlW+ydWd7OldygPyajT7OIArDqn1Mt+dCCL3RcKQ/7b3gVtiwmxDQeK9ibRaoWGpzI9cPGaiuW0Rm2TBscVwBXywqgRmNXtpR+fJyOhrVR6rNsv7FZV0mbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3KpZSO5; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3KpZSO5"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b872f1c31f1so920625266b.0
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 03:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769598925; x=1770203725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EqFqSwKYc5TLYLGEBKfPN0OSPOSjNF/4qqN/6JkYfM4=;
        b=V3KpZSO5NZLhf4ZJAx7nLECX6rNNFM4hFMAsLCyix+zaJ0IsOM5fjUZEgycgPCCjK8
         MSe4WtjBwDP+6z3XqzTrh1AExnYIwIuvuEZsLPlUfI+4R43F+pAOzX/wXPGh8RDmenFM
         FA05SFA4yjg5a5vFAwcYzEqPbac22svXPRH8zTNTDABtX5KRgXGRTHPrnpA1CHvGYiFx
         aIbOHz/kLKBBaG0CRtk01v3dgiYaiZTJLQYAVZ1hSnDYKxkuKlDw5WoGVTMUTR9ZOkts
         369UTpg5je83cIZa5VW/inP39G7PstE8FjiB7rwdzySzMC3ff0UFkqTdLPJF7g6RH5+d
         c1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769598925; x=1770203725;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqFqSwKYc5TLYLGEBKfPN0OSPOSjNF/4qqN/6JkYfM4=;
        b=wxg0aL0ym57PU3+dndgF1JTol1zO9P6I2vA86CSf43P5WKoUdBL3Qo2VY4opolw4fI
         SKLn4BGFhQpyJpOKgSzVVfBtoP5YGOsi1XoM+yTqqB9H7QMhFC+BsXQcYRshu+BIR/sP
         xNwHhmgX2lox9qfmMK/GMoTzEUFAXmoFgEcG6Dlyw/HDLe7JnpEcHVUusp+lv6nyzNIN
         D/VNgingWJMcBT4jsL8scxT8wpS49B6HwlRHGYXK6jmp8GkfMT3O/wEQ2hIAhJnnvQ05
         qHdFSCFp04Fv75FNyYba6D+LeOkUxuMGOBtJLvMKp98XVS7LTs9F5BUcWNlmTOqBzvbp
         jUZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBeTkC5r5y1hksyGebIR1CjkUsPdKFxJ6x7ZGmGhG+KNQxw9xzT4UwQpi5sbJxX1PxXtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjg270JtQL1bg9xt62I0yy8gmXtqpu+3ckaxTb0kBa3JxAG8hk
	76qb8dsubwNw9vaNWqmbAagI3VVual1xQC7hixLQ4sotPCpjfkZ78kiR
X-Gm-Gg: AZuq6aJScywD7DFrKHXWCFU/Z5tcm7tmcozTRkJyblvG67g6Idw+TyrY05yUwhD4qMQ
	dd50aMunzyPY5WTCqdpOCXnku+Bbefje4pi6R/mUJdwCniq9cA4e8qG0nHMfEzhwxtI/l3PFTkf
	4LxGeXlmsX9M680wRwMmf58W6bpCmkK+2c25s4m44rJWkLwLTrkThZbBcxdiob5uhPvrZUz3PAN
	lqdWRNLIAoI5PkZ++DBanDw6qzxOiAvtISZvb9gRAAzpXFgd+EFxX0ufskpVwYA2TZQO84k3EcR
	2ga4ewa6iuTIoe9KZZFuPPJuMyMyrA559wC1e/k+GhCp0jcOLHmrasp1ELwbrZG9kQiQI/QXp+K
	gx5qPkei7fzivtPBeYl61Lg3l6u6F8w25/4L8Ieu1nrcdtEIsgO6Qd2t8WNLB0KyVznD7Odn2gv
	spsxu3pzKV4e4zvcZHiD7dh/xo82c0pg1MVHIW21Zi8InnqPAwvY9FIy3Wf5fJ7f+Hv3grTSAx0
	C3Y
X-Received: by 2002:a17:907:7f8c:b0:b89:9631:2425 with SMTP id a640c23a62f3a-b8dab1938d8mr321149166b.19.1769598924273;
        Wed, 28 Jan 2026 03:15:24 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed58fsm112953266b.66.2026.01.28.03.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 03:15:23 -0800 (PST)
Message-ID: <7d6dd22d-286e-4f7b-a211-44e00e711401@gmail.com>
Date: Wed, 28 Jan 2026 11:15:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
 <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <08318339-03c3-4068-92fa-7a711bd13da0@gmail.com>
 <CAH=ZcbAiGONrOyma7YjNKKLqNFoisU5LG=nGWjtOJ1wLfqX4cQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=ZcbAiGONrOyma7YjNKKLqNFoisU5LG=nGWjtOJ1wLfqX4cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/01/2026 21:39, Ezekiel Newren wrote:
> On Tue, Jan 20, 2026 at 7:06 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Ezekiel
>>
>> On 15/01/2026 15:55, Ezekiel Newren wrote:
>>> On Thu, Jan 8, 2026 at 7:34 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>>> +void ivec_reserve(void *self_, size_t additional)
>>>>> +{
>>>>> +     struct IVec_c_void *self = self_;
>>>>> +
>>>>> +     size_t growby = 128;
>>>>> +     if (self->capacity > growby)
>>>>> +             growby = self->capacity;
>>>>> +     if (additional > growby)
>>>>> +             growby = additional;
>>>>
>>>> This growth strategy differs from both ALLOC_GROW() and
>>>> XDL_ALLOC_GROW(), if there isn't a good reason for that we should
>>>> perhaps just use ALLOC_GROW() here.
>>>
>>> XDL_ALLOW_GROW() can't be used because the pointer is always a void*
>>> in this function.
>>
>> Oh right. I'm not sure that's not a reason to use a different growth
>> strategy though. The minimum size of 128 elements is probably good for
>> the xdiff code that creates arrays with one element per line but if this
>> is supposed to be for general use it is going to waste space when we're
>> allocating a lot of small arrays. ALLOC_GROW() uses alloc_nr() to
>> calculate the new side so perhaps we could use that here?
> 
> If ivec_reserve() isn't suitable then ivec_reserve_exact() should be
> used instead.

If some C code that pushes one element at a time to an array using 
ALLOC_GROW() is converted to use an ivec then we don't want to change 
the code behaves - that means it should grow the array in the same way. 
I don't see how the suggestion to use ivec_reserve_exact() helps in that 
situation. What is the advantage in having a different growth 
characteristic?

>>>>> +void ivec_push(void *self_, const void *value)
>>>>> +{
>>>>> +     struct IVec_c_void *self = self_;
>>>>> +     void *dst = NULL;
>>>>> +
>>>>> +     if (self->length == self->capacity)
>>>>> +             ivec_reserve(self, 1);
>>>>> +
>>>>> +     dst = (uint8_t*)self->ptr + self->length * self->element_size;
>>>>> +     memcpy(dst, value, self->element_size);
>>>>
>>>> If self->element_size was a compile time constant the compiler could
>>>> easily optimize this call away. I'm not sure that is easy to achieve though.
>>>
>>> The problem is that I didn't want all of ivec to be macros that looked
>>> like function calls. I wanted to minimize use of macros so that it was
>>> easier to port and verify that the Rust implementation matches the
>>> behavior of the C implementation.
>>
>> I think that's a reasonable concern. So is the plan to have a parallel
>> rust implementation of these functions rather than call the C
>> implementation from rust?
> 
> Yes, the Rust implementation will be independent of the C
> implementation, but will behave the same way. That's why I'm calling
> it an interoperable vec as opposed to a compatible vec. Rust can't
> call the C ivec functions and C can't call the Rust ivec functions,
> but they'll behave the same way.

Interesting - I'm curious what the advantage of that is over having rust 
call the C implementation? I can see you wouldn't want to be calling 
into C for each ivec.push() call, but checking if there is room to push 
the new element in rust and calling into C to extend the vector if not 
should be reasonable and then you don't have to re-implement everything 
in rust.

>>>>> +void ivec_free(void *self_)
>>>>
>>>> Normally we'd call a like this that free the allocations and
>>>> re-initializes the members ivec_clear()
>>>
>>> In Rust Vec.clear() means to set length to zero, but leaves the
>>> allocation alone. The reason why I'm zeroing the struct is to help
>>> avoid FFI issues. If not zero then what should the members be set to,
>>> to indicate that using the struct is not valid anymore? In Rust an
>>> object is freed when it goes out of scope and _cannot_ be accessed
>>> afterward.
> 
> Maybe I should call this ivec_drop(). Though the notion of explicitly
> freeing an object in Rust is _almost_ nonsense. The way you free
> something in Rust is to let it go out of scope.

Indeed - which means this wont be a public function in rust and so why 
do we worry about naming it ivec_clear()? At least ivec_drop() does not 
conflict with any of the standard function suffixes that we're already 
using in git.

>> I'm aware that Vec::clear() has different semantics (it does what
>> strbuf_reset() does). That's unfortunate but this function has different
>> semantics to all the other *_free() functions in git. Our coding
>> guidelines say
>>
>>    - There are several common idiomatic names for functions performing
>>      specific tasks on a structure `S`:
>>
>>       - `S_init()` initializes a structure without allocating the
>>         structure itself.
>>
>>       - `S_release()` releases a structure's contents without freeing the
>>         structure.
>>
>>       - `S_clear()` is equivalent to `S_release()` followed by `S_init()`
>>         such that the structure is directly usable after clearing it. When
>>         `S_clear()` is provided, `S_init()` shall not allocate resources
>>         that need to be released again.
>>
>>       - `S_free()` releases a structure's contents and frees the
>>         structure.
>>
>> As we write more rust code and so wrap more of our existing structs
>> we're going to be wrapping C code that uses the definitions above so I
>> think we should do the same with struct IVec_*.
> 
> I disagree. IVec isn't a wrapper around an existing struct.

So just because it is a new stuct it shouldn't have to follow the 
existing naming conventions?

> ivec is
> meant to very closely mimic Rust's Vec while guaranteeing
> interoperability. For things like strbuf I haven't conceived of a
> solution for that yet. Making ivec diverge from Rust's Vec will result
> in POLA violations due to different behavior when refactoring an
> IVec<your_type_here> to Vec<your_type_here>.

On the other hand, vec.reset() does not exist so you'd get a compiler 
error if you forgot to rename those calls when changing from IVec to Vec 
and the rust code wouldn't be calling ivec.clear(). I'm not sure citing 
POLA concerns is very convincing as ivec_free() in C is a POLA violation 
for anyone familiar with git's code base so it's not like there's a 
choice that avoids that concern.

Thanks

Phillip

>>>>> diff --git a/compat/ivec.h b/compat/ivec.h
>>>>> new file mode 100644
>>>>> index 0000000000..654a05c506
>>>>> --- /dev/null
>>>>> +++ b/compat/ivec.h
>>>>> @@ -0,0 +1,52 @@
>>>>> +#ifndef IVEC_H
>>>>> +#define IVEC_H
>>>>> +
>>>>> +#include <git-compat-util.h>
>>>>
>>>> It would be nice to have some documentation in this header, see the
>>>> examples in strvec.h and hashmap.h
>>>>
>>>>> +#define IVEC_INIT(variable) ivec_init(&(variable), sizeof(*(variable).ptr))
>>>>
>>>> This is a bit cumbersome to use compared to our usual *_INIT macros. I'm
>>>> struggling to see how we can make it nicer though as DEFINE_IVEC_TYPE
>>>> cannot define a per-type initializer macro and I we cannot initialize
>>>> the element size without knowing the type.
>>>
>>> I don't see what's cumbersome about it. Maybe an example use case
>>> would clarify things.
>>
>> It is cumbersome because it separates the initialization from the
>> declaration. Normally our *_INIT macros are initializer lists so we can
>> write
>>
>>          struct strbuf = STRBUF_INIT;
>>
>> which keeps the declaration and initialization together. Although
>> they're on adjacent lines in your example in real code the
>> initialization likely to be separated from the declaration by other
>> variable declarations.
> 
> Ah I see what you mean now. I'll experiment with making IVEC_INIT()
> work like that. One wrinkle is that STRBUF_INIT is a single concrete
> type whereas IVEC_INIT() is meant for generic types.

If you can get it to work that would be great, but I can't think of a 
way of getting it to work for a generic type.

Thanks

Phillip

