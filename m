Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39251366566
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916792; cv=none; b=t2r3LcIX6KsdhwvXvYACcaJHZP88tD0aKWEG5txOYjFHhzt0WRhBbAmnYZJFLnhFmMcfLg6Z2duRiuyVVpjtiHsJZcF+Ts/D6a9ff7CIP/jXgc116Ht7YDsyhz+ULEO7zSGe+TChVXuh23NF+GMECTBD6w9cGHZ+UGKKm/4eXSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916792; c=relaxed/simple;
	bh=huGY58eZb3BFq0JSzf6G8ox3StINEmSRvkrfP34y3SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0JEV0WGoK3hoC7WrxdegwpLGPZbFr3DbNE2xpZLC2OrttIIL4btmAfd41hlhcWVg9NoRhg0ZznqS73L0eojOKWqbWvl/Rw0XjaHiUoyeu9wocLVILSkoHcrYtAFeVL6c0weDlIBld6by9Gb455byaYdY5fI0G9lY3QnFqj4+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEKwVC4F; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEKwVC4F"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so39098445e9.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 05:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768916786; x=1769521586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVzoulTJ0+MFkElOZ+f11nEM7Ok2EFg7JMN4uc/QdUM=;
        b=XEKwVC4FeXCImZ9GFia6pwkifnmbjk1hbBvXKVdah6rxnJ/ijpBVildVrSFpQHSRfm
         jl/y9FQlHZjGEZUEDIwrnEa084yDuSwzE1rVFOglKI5GAZy2drkpDj5BykqrhSw/ZJ1l
         n2M9z0AoIjmpllXYnbOimg4SBdXW+WQPIMbpGoS9CovhjyZTzewveUkV93rHhzSNyLHU
         FGVWK5LLhamFL0ksBM/W4iuK4/d1mIHOagWey9prl+31drZv77W54hXS6G6CfxxEAHGa
         Gdx7VCPPBR1KOojdVXSoraHCLjObif89XPB0wRBC2VDvN4u5iD/DHXuwEEDZD5NsnbLM
         lyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916786; x=1769521586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVzoulTJ0+MFkElOZ+f11nEM7Ok2EFg7JMN4uc/QdUM=;
        b=hQXc81YI7ErVPXlpxT8RB43J9HwfzTrg4NFHGz8vhVHJDbQvZqdXhEMhPP3G57lTEt
         Z06ejy15bBu3vj1JgprMo2ArHgOdPV4cJbxAZ2oL1hWa0danRCQoejkAwg8LdrzB0Axn
         OZnycqyJsIV3f8J88Kz5xve0Pn3Ln18wsjd2W4xc/oG1eX56AKJY6gFs25ki66KWmJ26
         rqwhxz8KE/Jl8WDPowiOgPjIQBPjgPUB6NFJxAvk216/dEavv3CsAKTk/U+sa5pvBZ5k
         jpIldTjzAFv99zXPkeI6iH/kqlBPFpWo4CeI8Nu795MsVMrf4t1URByOnXJb0ZAbFhln
         y2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr0IWwaebS0azRk9CdzYzBd9uSx9qmZsHXM01VS+crti3Ac9aLAjJq3QjoFpdVDrolsqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeENbxuSrgLlrYMLdt/diEq2q9VJ7QZeRNS1pKA5b5LR0vZdxC
	gngI+yylWYiCvI/QuiWr/ySQkVaFB9V7TD5JjjEEPBbNfa+T16+1/6fS
X-Gm-Gg: AY/fxX5A88leOm31dyz+DU2E07TTkm0cl+7hSBOjWJsxJd48+bo9dYaeU0AYKKtsD2r
	Pj3/1iDWNZSsLSgOSWePh9TLMvId29VzHFt5AxqX29oHZjcn75t9hkzpdztElC5zA8FUV6qup+T
	fS6Aw0ETQNerpOdiagDEFbJV70Ab6NQENNWE2FLeGxTwVgO3sc35/jtNbg7etKETn+8ilzXniTk
	OnGfOK3qqDmC/Dm8Tjm0sd+WaCBePH7dEhd5qeWGrAHZWkXrd99O3362UfKTHHjASF+w6YS/0lU
	GrCykMgTVxRyJg1wjRQccwqZ5L2I6bSy5415qzBiSA4dXSwX+RLfD6CVvDzWpACleVLNdzQumBs
	mtRa9qjPwZTw51deZabGyFcKWRZpZtA8tur70hsMfwmzCiJVgM8OPlBTkFfR4yxfdxz8oWcBBtX
	Z663PQTwg92MY9udeBB+hptM3GcsqRPXxIAsAHpgTdL94jZv0Jv9icOHfzb+Ejp/DpoBdG/Lk=
X-Received: by 2002:a05:600c:638f:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-480418f1128mr1443355e9.9.1768916786132;
        Tue, 20 Jan 2026 05:46:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:d097:d38c:2c4c:9266? ([2a0a:ef40:627:1f01:d097:d38c:2c4c:9266])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8c0475sm294993415e9.10.2026.01.20.05.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 05:46:25 -0800 (PST)
Message-ID: <c1846365-10d8-4252-bb38-59bd652fcfd0@gmail.com>
Date: Tue, 20 Jan 2026 13:46:24 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Jeff King <peff@peff.net>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, phillip.wood@dunelm.org.uk,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
 <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
 <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
 <6ae80903-3cc5-4017-9eac-0b3100b93b04@gmail.com>
 <20260119055947.GA3100271@coredump.intra.peff.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260119055947.GA3100271@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 19/01/2026 05:59, Jeff King wrote:
> On Sat, Jan 17, 2026 at 05:40:08PM +0000, Phillip Wood wrote:
> 
>> On 17/01/2026 16:14, Ezekiel Newren wrote:
>>>
>>> If the size of different kinds of pointers ever differed from the size
>>> of void* then wouldn't that make all calls to malloc undefined?
>>
>> I believe there are (Havard architecture?) platforms where function pointers
>> are a different width to data pointers, and that's why you cannot store a
>> function pointer in void*. I agree it would be weird for char* to have a
>> different width to int*, I suspect the restrictions on casting from one type
>> to another are about alignment.
> 
> The standard does allow for different pointer sizes for char and int.
> The key thing is that a void pointer has to be able to represent any. So
> you can cast a smaller pointer to void and vice versa (and the latter
> would presumably throw away some of the bits, which is OK as long as the
> void was made from one of those smaller pointers originally).
> 
> More discussion at:
> 
>    https://c-faq.com/null/machexamp.html

Thanks for the clarification and the link - the C FAQ is always an 
interesting read.

Phillip

> I don't know how malloc worked on those platforms, though. The caller
> knows that malloc returns a void pointer, so it could cast to the
> smaller format in the usual way at the call-site. But I don't know how
> you would tell malloc() in a standard way what type of pointer you
> wanted to get out of it. I suspect they may have had specialized
> allocation functions. Or maybe it was enough to just throw away the low
> bits if you only cared about a word-addressable pointer.
> 
> At any rate, yeah, I agree with your original concern that the two
> structs are not compatible. The layouts could be totally different. And
> not just due to pointer size, but IIRC pointers to different types could
> have different alignment requirements. So:
> 
>    struct foo_void {
> 	size_t len;
> 	void *ptr;
>    };
> 
>    struct foo_u8 {
> 	size_t len;
> 	uint8_t *ptr;
>    };
> 
> might need different padding to properly align the pointers. In the case
> under discussion the pointers are always at the start, though, so I
> think it wouldn't matter.
> 
> -Peff

