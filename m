Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7954329E46
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768559973; cv=none; b=nB44QH2WZcHS+4dJ7wJaBlmdx+JAlUksAJ+vhWD/hxeFfj4zTUuerzwDaW9vaKMgRYotbCGx0vg3eMn20Cg1m7OZNDjiSP6PDUG8NZRlWow3QQ8P+rhXJ79P1PomyVtUhsWzPtIGIBsoilV+T6skWTsIFWP3+kNMCZlw41J0hNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768559973; c=relaxed/simple;
	bh=NF2kD902wN6G4KxETqWgZMEvWGwDFW6uC/L83TDEeh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMbmevg7W5E48ZGcL3bIHjcnIEl/4mm0ix7YtKelePKPWJAHXlQ4WGigjov5QX9a+KvKJ5XxFeEa9WyvZdrAh0bOKo+yhC1G2Dtq8jNcmD6LV38izzObSQVVD7MGcOzDSCg1R7iNORKdGehe9zcYqxYN6N3PeBOtfvMaA7vbi4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUYRgAv2; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUYRgAv2"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-432d256c2e6so1473907f8f.3
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 02:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768559970; x=1769164770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MrFZV1+UpoPp5W6Ca7THq66l+yercIVYhYMLmohfc2E=;
        b=fUYRgAv236ZxamwRY2wXXbe3L4Re89HPfnnona9D02JUckHHKXflT8wUM6UZLtWvsp
         sXWtxcXpfTHwsFcqYCQ9Ikl+7hZy6NYJhkjsYohD6d/qDOzHGxhBKu9ROT7cbZ0jIiGo
         qo4uqLp1Egxw/9cBk14LU1z6OlzTeVSJ0cuJM8+qgd0l8rsRP1sIfJ636GhvkQNogVtX
         F6yDYwIznw1oJAekjsl5Y4jOk+n4nS+STEp3qHoqBCAyA2ZHSGqBK39YIrduqe4KU8rK
         mR/XT3LbXATRa3u7N1suY68YTIBhGtoUnkYRjspOQdhrPXuba1JPoCEg4b9mF9wCGKJt
         RgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768559970; x=1769164770;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrFZV1+UpoPp5W6Ca7THq66l+yercIVYhYMLmohfc2E=;
        b=uX6NcavAnAAKbA2BlTp3DS/0n88qbhAgUZNcRK66mj6F2OnmslRijsJuBDNxcAZZoa
         2a3HX5QVpaluiWTd6cc0sq8GnClCJzcb/E1zTYgk+ECTjqMQnb6XHqYs5d41zdQNAoIY
         JWy+fQA/wWMchMwtIUPxDGFeJ+Bwi6t7RRPPiZnDhqzq4VIxzAfMxxv4+Ik/mYyApJZ2
         oqEM5mzUCqh116EqRC0+7XVB9njYnvwQ7mgOT39iUasyn7P0TroXYlp+eaRGNHWKF+3I
         7XIqkIyzSdLPLUdY5q3/ZpKutFYeNMURkRrXMARsGjgT0SDz15wBILKxgudImqSl3Xpl
         AW+w==
X-Forwarded-Encrypted: i=1; AJvYcCV0DExeWYtI/8I+GrsXtCgaKmxuLCvbZtjrcNTa1POZth7DWWaRIOHn5jTDYL1HO3z/VfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57GmRNNlIfMPZ+2aSkhs5VyvZDszqxMfuESqx+/5FOpthlpw5
	/0LxfQ7mVO1sAHVkssc8EMs4PEtUdLAQdSi0kx5KSmL1RjS3qWMy3oYC
X-Gm-Gg: AY/fxX5IBDx31oC1eywMnvRV0ZkrDwjoEqB4sHzr/BR4lPOtiYHJBtLUzljqrzzQ8ec
	taPmEbEMephQ8cfNeti9/qDdw5SLaGjWJO1vYmjiqp/Q4r4TsW8aPeQo2W/seZ7Bqz9sSitNmtd
	IPZ24SIH9Icj/ShmLNX3YSOYQ3SwMO7KjdAl7tAP+qTdP2KVUP1QZcl/0Y4Rf70selYqDHiBLCM
	uhhGTdNHQ9skBTVPJAmyp3vJPXks24AmwWoWCJnO6KKZ9sqAcFWPHlVd5jJvndQuORgfuiLagea
	/Tub8P7TO93vhDgjTfgVvq8JseUvBUFLVm97gY1jrFFIW7F5DEtfVgFxVSS0QJ0k4tyGo5TSoc9
	HudnJ908Ou25FKFgi/UNbJ9yJ1rp1YD8XONwW9aFrYo3bKV+71CfdqUgaZfz8uNx0INX2BRK6Fx
	9JfrK65OVrMGcpHnt+8WhpuvMUDib4+4S+X0krE4r5la9qCix4wZiKh84C8gAFBBp8+g==
X-Received: by 2002:a05:6000:2209:b0:430:f463:b6ac with SMTP id ffacd0b85a97d-43569bc58b4mr2853264f8f.44.1768559969775;
        Fri, 16 Jan 2026 02:39:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569927163sm4258679f8f.12.2026.01.16.02.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 02:39:29 -0800 (PST)
Message-ID: <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
Date: Fri, 16 Jan 2026 10:39:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Ezekiel Newren <ezekielnewren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jeff King <peff@peff.net>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
 <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I've Cc'd Peff and René for a second opinion if you have time please.

On 15/01/2026 15:55, Ezekiel Newren wrote:
> On Thu, Jan 8, 2026 at 7:34 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
 >
>>> +static void _set_capacity(void *self_, size_t new_capacity)
>>> +{
>>> +     struct IVec_c_void *self = self_;
>>
>> Passing any of the ivec variants defined below to this function invokes
>> undefined behavior because we're not casting the pointer back to the
>> orginal type. However I think on the platforms we care about
>> sizeof(void*) == sizeof(T*) for all T so maybe we can look the other way.
> 
> If someone finds that this code does not work because of this
> assumption I'd like to know. But I can't fathom a case where it
> wouldn't work.

So we have two different structs

struct IVec_c_void {
	void *ptr;
	size_t length;
	size_t capacity;
	size_t element_size;
}

and

struct Ivec_u8 {
	uint8_t *ptr;
	size_t length;
	size_t capacity;
	size_t element_size;
}

One the platforms we care about they will have the same memory layout as 
all pointers have the same representation. However I don't think they 
are "compatible types" in the language of the C standard because the 
type of the "ptr" member differs. That means casting IVec_u8* to 
IVec_c_void* either directly or via void* is undefined and so

	struct IVec_u8 vec;
	ivec_init(&vec, sizeof(*vec.ptr));

is undefined. For the compiler to see the undefined cast it needs to 
look across translation units because the implementation of ivec_init() 
will be in a separate file to where it is called. Maybe that and the 
fact they have the same memory layout saves us from having to worry too 
much though I'm always nervous of undefined behavior.

An alternative would be to pass the individual struct members as 
function parameters

	void ivec_init(void **vec, size_t &length, size_t &capacity,
		       size_t &element_size_, size_t element_size)
	{
		*vec = NULL;
		*length = 0;
		*capacity = 0;
		*element_size_ = element_size;
	}

and have DEFINE_IVEC_TYPE create typesafe wrappers

	static inline void ivec_u8_init(struct IVec_u8 *vec)
	{
		void *ptr = vec->ptr;
		ivec_init(&ptr, &v->length, &v->capacity,
			  &v->element_size, sizeof(*(v->ptr));
		vec->ptr = ptr;
	}

That's safe because we cast the "ptr" member to "void*" and then back to 
the original type. On the rust side the implementation of IVec<T> would 
also need to split out the individual struct members when it calls 
ivec_init() etc. It's all a bit more effort but the benefit is that we 
don't have any undefined behavior and we have a nice typesafe C 
interface to 'struct IVec_*'.

Thanks

Phillip

