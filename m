Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BB43CEE4
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918013; cv=none; b=p/HhaxqRA/sMnS0gsXlhbQI1xqRRvRChwYrJ1aWdASeL8L9vqgo8aiOpJaW3fN9kbvBzUcucRHJHd7m8mOvOqzXhC+UTGqdn0Q7iDziyE+71KINvH22axBqJLptzyvQ6p8r7e2Msd271ixZ5Uzq/4TOxitWhMAXGEk6eZdzBksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918013; c=relaxed/simple;
	bh=1Pt7bXs6vzJd0HVo+/U+PjCn8JcG4KXgahrmPhiHmKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXanNsoM9sMiDPYeWAx4VVcidpWHBzotmVXngdCuWkfkAWWTpLDvzJPQJ/CkP/gXwq2ahL/UGbv3RJ3a6+J8JvGhQB76aYR3HhpYuUjf2Hs42C+EKLYAMu03satSy2ZU7VP4FBfF2+jIskyQGsMW75w1gVaFqV5Ec2WjuyF2Sn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEy6UanT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEy6UanT"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359249bbacso298358f8f.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 06:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768918010; x=1769522810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0btiDEVFw4D1aCkN+kiIQ1Mxr6lEZSYoqpOPa+A0h0=;
        b=PEy6UanTU1wpjBHEUHirzf6G4kukARisZwben1kXHJ0RdJc00kA+/blw4L/Xpta9m2
         xlihbG6I8hT3Erd6u0kgzJ3p5B8S8obNUTA1s4EXT/8Eg10FGzkegG+OeVpJKrgWuupz
         TzhBfIEENocouQ5+qmgMJwfX63F0tlcUUEWavTcrZCkEGSW0BNgnX6Invx8Iw43yua0S
         QkNJMzFZT/ze/6h3lSFy8CLRc0cNxE0DXraI48KBE/2id0sqSBEKcE6OzDabvS6ycb3j
         VMMkBjXnt2HJzlL+ZcHEUHQ0lBS3Tj7u4KjH8PUymK4dKNSCdDqa6vMe36s4IFD/Deqz
         hjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768918010; x=1769522810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0btiDEVFw4D1aCkN+kiIQ1Mxr6lEZSYoqpOPa+A0h0=;
        b=p9FLTb/eAbHRGDV0JZvz2juy7pCcUmcZ3vNZLGI9/4DygbP2ModlJPJjVmgivIefb9
         yj5dQNuK86XLfkHwk55HDIsHzADTXhA5H04WPQsF8j+Cl/n+Kf2wAS4NMOqSLhYEyTfU
         Ih+VTDUqmVAulPhi7A8o4C+dC1xX43oTVeeXAHDJ/2OlBqndqaAHlJp8mmAYjk6e/G9p
         ubC/s5mNQKKqJbSc/rkYUgYzhqJY6It8Finz9s3JYnioREM4Pjkmcx82CqtL41e0ZklE
         oUSzypP3wjE1eWu30JVD/z3nbNb/NhgcnJyNV8To9m+xs5e+0HKzGDXUkWAnHbOndlHZ
         4ZYw==
X-Forwarded-Encrypted: i=1; AJvYcCW+dC8MQS4uGzGLCVzHaELShTP9rcfd3fLzPFNzmqmHpgF0MkRb0+XO1rSAfAFxMFeOxgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUEubgyEL5C+138jtznIU3g4Lp23LA6rwFvbTTxnKnO1vWwlT
	E4VLZJ+I6t4bZNNgicxTkba5tOknrWJaB+uKp7fOfU26Yktaj9Aw5ke0
X-Gm-Gg: AZuq6aILFElu05E+LCem/Vfc1oTd6NTNLiHamDeKlt1aVUK6SkQG7tTDzkzWcPtwqLu
	0HfYpHG2BMHQnwL2LJfsCrroZaiatptWPcJOcH8zKTllQZaszPyaA6w75dcXKI+P3rsbIdz1yAn
	VSjh9c0AkJPyhcf38PtJmLhrCsoHXURoR8VqM4xLZIVRlEnuqhSyCDSDfnOr8fIKGRntPzE3Wde
	XQEMgv/NgF1YL7uNfJcoT2vzZ5osUcWWpmCLgw/EKizFpokkAwvyoyLPqPyXM3psAgIDmIv6GIh
	CFlIDd0h1kurG9kNuVqRBh4ugxVviIqTc2gcN05CuY59ugWOc86AsfuM2GireAgTziF+9M10yGo
	48A8BRJIzqGaw2z1LpjTGuQoABELL/dPCAs9lQLSAK8pPDyC0l7F/xlTE+ZkmoScmz2LAGpkJfc
	mS8aSuVQZzCbJ+bBmC0MFpnIUc+rvuBJM901Xsf2pONueIMFIS7CXUx6wrXL3DufUptCFIQcE=
X-Received: by 2002:a5d:64c5:0:b0:432:5b18:2cc3 with SMTP id ffacd0b85a97d-434cc998591mr25126491f8f.4.1768918009680;
        Tue, 20 Jan 2026 06:06:49 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:d097:d38c:2c4c:9266? ([2a0a:ef40:627:1f01:d097:d38c:2c4c:9266])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921da2sm29665108f8f.1.2026.01.20.06.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 06:06:49 -0800 (PST)
Message-ID: <08318339-03c3-4068-92fa-7a711bd13da0@gmail.com>
Date: Tue, 20 Jan 2026 14:06:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Ezekiel Newren <ezekielnewren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
 <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ezekiel

On 15/01/2026 15:55, Ezekiel Newren wrote:
> On Thu, Jan 8, 2026 at 7:34 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>> +void ivec_reserve(void *self_, size_t additional)
>>> +{
>>> +     struct IVec_c_void *self = self_;
>>> +
>>> +     size_t growby = 128;
>>> +     if (self->capacity > growby)
>>> +             growby = self->capacity;
>>> +     if (additional > growby)
>>> +             growby = additional;
>>
>> This growth strategy differs from both ALLOC_GROW() and
>> XDL_ALLOC_GROW(), if there isn't a good reason for that we should
>> perhaps just use ALLOC_GROW() here.
> 
> XDL_ALLOW_GROW() can't be used because the pointer is always a void*
> in this function.

Oh right. I'm not sure that's not a reason to use a different growth 
strategy though. The minimum size of 128 elements is probably good for 
the xdiff code that creates arrays with one element per line but if this 
is supposed to be for general use it is going to waste space when we're 
allocating a lot of small arrays. ALLOC_GROW() uses alloc_nr() to 
calculate the new side so perhaps we could use that here?

>>> +void ivec_push(void *self_, const void *value)
>>> +{
>>> +     struct IVec_c_void *self = self_;
>>> +     void *dst = NULL;
>>> +
>>> +     if (self->length == self->capacity)
>>> +             ivec_reserve(self, 1);
>>> +
>>> +     dst = (uint8_t*)self->ptr + self->length * self->element_size;
>>> +     memcpy(dst, value, self->element_size);
>>
>> If self->element_size was a compile time constant the compiler could
>> easily optimize this call away. I'm not sure that is easy to achieve though.
> 
> The problem is that I didn't want all of ivec to be macros that looked
> like function calls. I wanted to minimize use of macros so that it was
> easier to port and verify that the Rust implementation matches the
> behavior of the C implementation.

I think that's a reasonable concern. So is the plan to have a parallel 
rust implementation of these functions rather than call the C 
implementation from rust?

>>> +void ivec_free(void *self_)
>>
>> Normally we'd call a like this that free the allocations and
>> re-initializes the members ivec_clear()
> 
> In Rust Vec.clear() means to set length to zero, but leaves the
> allocation alone. The reason why I'm zeroing the struct is to help
> avoid FFI issues. If not zero then what should the members be set to,
> to indicate that using the struct is not valid anymore? In Rust an
> object is freed when it goes out of scope and _cannot_ be accessed
> afterward.

I'm aware that Vec::clear() has different semantics (it does what 
strbuf_reset() does). That's unfortunate but this function has different 
semantics to all the other *_free() functions in git. Our coding 
guidelines say

  - There are several common idiomatic names for functions performing
    specific tasks on a structure `S`:

     - `S_init()` initializes a structure without allocating the
       structure itself.

     - `S_release()` releases a structure's contents without freeing the
       structure.

     - `S_clear()` is equivalent to `S_release()` followed by `S_init()`
       such that the structure is directly usable after clearing it. When
       `S_clear()` is provided, `S_init()` shall not allocate resources
       that need to be released again.

     - `S_free()` releases a structure's contents and frees the
       structure.

As we write more rust code and so wrap more of our existing structs 
we're going to be wrapping C code that uses the definitions above so I 
think we should do the same with struct IVec_*.

>>> diff --git a/compat/ivec.h b/compat/ivec.h
>>> new file mode 100644
>>> index 0000000000..654a05c506
>>> --- /dev/null
>>> +++ b/compat/ivec.h
>>> @@ -0,0 +1,52 @@
>>> +#ifndef IVEC_H
>>> +#define IVEC_H
>>> +
>>> +#include <git-compat-util.h>
>>
>> It would be nice to have some documentation in this header, see the
>> examples in strvec.h and hashmap.h
>>
>>> +#define IVEC_INIT(variable) ivec_init(&(variable), sizeof(*(variable).ptr))
>>
>> This is a bit cumbersome to use compared to our usual *_INIT macros. I'm
>> struggling to see how we can make it nicer though as DEFINE_IVEC_TYPE
>> cannot define a per-type initializer macro and I we cannot initialize
>> the element size without knowing the type.
> 
> I don't see what's cumbersome about it. Maybe an example use case
> would clarify things.

It is cumbersome because it separates the initialization from the 
declaration. Normally our *_INIT macros are initializer lists so we can 
write

	struct strbuf = STRBUF_INIT;

which keeps the declaration and initialization together. Although 
they're on adjacent lines in your example in real code the 
initialization likely to be separated from the declaration by other 
variable declarations.

> ```
> DEFINE_IVEC_TYPE(xrecord_t, xrecord);
> 
> void some_function() {
>      struct IVec_xrecord rec;
>      IVEC_INIT(rec);  // i.e. ivec_init(&rec, sizeof(*rec.ptr);

Thanks

Phillip
