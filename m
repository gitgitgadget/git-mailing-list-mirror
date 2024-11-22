Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB54207F
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289244; cv=none; b=Z18VDR0Tq/CgI5kXD9yqJfDSlNawxjnCGSrKj+TsOPArDbnRIRLJgpCrwtZbqm72QuoQ+UOdOE72084GJFJwhC1nJY4Z2Qbvlw/0b6W4+0B48z5dJHQ2kTQ1LUzydRsczvSGKX4rJjefOnj7OgOtzS5mItqMV2gro3HHTh1dm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289244; c=relaxed/simple;
	bh=5kcG1Tf3kZZIYqDZVTIolDytkfklEGfwH+E5163jcM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIX6bhzH6kwcNzSkhZwmir9YJTMnX4M47Fl51M4q+jGayF0MmOF96b1D2e5UIS8uPpxOpU4+U/ZfFYOwUO74T3qtSdCdrfwFlUzQ4jB3FWhvodypnz7Hz0jg2pnhZDtg8F8mu+nvVGDXM4aXZ3l7bizFJJuXuPmPB54U2l5873k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRfApNSO; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRfApNSO"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e38c1ac8e3cso2751085276.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 07:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732289241; x=1732894041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJ1DpX2Dcqpk/JC6YRfsyQo6LKUJ8GKB3BEsiCPwqkQ=;
        b=VRfApNSOimRch6AFhCEbSx6iEwZ1sZIAEj35QLg0+KF5icKpKYq6uhXp1YvoHC5QEE
         lsqdnCnPezQiITYxl15HNnKaexk3+gN2q8eN8qzjmzntSDnrlMa+UO+pfXrYHn0gfs1v
         KX0ZixLNrW3AiPGqRmBEwDM42bcOvBD5EFd4SXbzuTQ/bUkDJj3MDyiM76WEZYo7fC5L
         PAwWfnBuCA24Pf1W8JJ+FYwNJnSzvueo7polJ2wsGLFY8jOY2KvmOpCeGpo9TT4pnOiv
         yNGeggPTzEerrp6gdz4Kch/2qvTHuqwSaNtUfDdeH2mLnIHjJ3mBGKTAVTjMN49En7AG
         8ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732289241; x=1732894041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ1DpX2Dcqpk/JC6YRfsyQo6LKUJ8GKB3BEsiCPwqkQ=;
        b=KPxCJUuA3JoV8/IG0l9Z+XoZQs4LZAjsoH4vW2aWZKj61nM6Q+ZFs9yrO/AxXWlj8i
         b9Ci4XOw8rzwzRimCIHCf+4bmN+DPZLLo2tFcMj/h6PTvcfeR8vDu5RNEbCtrC27nVAr
         cpT9NiDhCqtNFfc5ohKkirEHphtjbZLlQmvq56C/Dkoz5OCYMGjYO1Sfg1H1pSw7a6F0
         zbyftV6D0a3RcZdLzwZNsVWr1ZfinmIkmHWdDtIGZTC6t76f3Bf4/mTwEfjiGV2ZxBBd
         6r5EgfVkjXy/Yq9gwj1+R3Eo+ImPXdnJWYj3Qqn5ySDFIVVcu5B7VAGst7GmuCdqHzgh
         bH4A==
X-Forwarded-Encrypted: i=1; AJvYcCVNpkN99HXeQlrYx8BVcy25VnsCzz2rs4VwxgzgAesKhC1GxergDkO8m/ldsOs+mqNJrHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2enta+t8Cq9SGER9pYca/1r9O/BOoiVG/8RqjSR78uaaEE4oe
	Sa1nxfpb012IaPXq3ZYyVe6COQtqZwbRh+197jElzgUuUxfP0ZOZ
X-Gm-Gg: ASbGnctxM8KavbFcI80oQRaezvYRa+v+daeE3pr6e3d+A2oqjrp5WEiFfkBtBvH4say
	lm9qGiArNgK11viaERfIHnDV6/1LED8cIwZzFaqm0mJIa3C/NV9/inpDBqplKAhaRIHXCX+sX1R
	VSeh4fgplsF5nhLoKldYBdd1c9Hm48fs45AuR9kU3TcPIfWnqhVgntvQfwfMyMkUKxVVbWLoRIm
	2JwJ+4noEm/Goh35CUewt3og7Pgc7AkYuzrh/+3NO8c2+yxCHJKrVQ9WkefLy3HDjAHvd1uRKRK
	XKLt8RCl0pc88OzTxGMaihvUKLa2iJhIwPnzDw==
X-Google-Smtp-Source: AGHT+IHXCN+GOoUATmLuKUO+FdaROO2GK9uJadL+Z4g6fJETmENo7WAIXCuC5eqK8oVvOlKmSC1sMg==
X-Received: by 2002:a05:6902:2848:b0:e33:121:c145 with SMTP id 3f1490d57ef6-e38f7231406mr2800800276.16.1732289241373;
        Fri, 22 Nov 2024 07:27:21 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:313f:79e7:4a86:b985? ([2600:1700:60ba:9810:313f:79e7:4a86:b985])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f631b3c8sm642991276.43.2024.11.22.07.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:27:20 -0800 (PST)
Message-ID: <cd3df4d5-efa0-45cb-ab94-6c5c9f0ac695@gmail.com>
Date: Fri, 22 Nov 2024 10:27:19 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] pack-objects: Create an alternative name hash
 algorithm (recreated)
To: Junio C Hamano <gitster@pobox.com>,
 Jonathan Tan <jonathantanmy@google.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com
References: <20241121235014.2554033-1-jonathantanmy@google.com>
 <xmqqiksgas54.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqiksgas54.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/24 10:01 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> +       while ((c = (uint8_t) *name++) != 0) {
>> +               if (isspace(c))
>> +                       continue;
>> +               if (c == '/') {
>> +                       base = (base >> 6) ^ hash;
>> +                       hash = 0;
>> +               } else {
>> +                       uint8_t nybble_swapped = (c >> 4) + ((c & 15) << 4);
>> +                       hash = (hash >> 2) + (nybble_swapped << 24);
>> +               }
>>          }
>> +       return (base >> 6) ^ hash;
>>   }
> 
> Nice.  The diff relative to the --full-name-hash version is a bit
> hard to grok, but compared to the current hash function, there are
> two and a half changes that matter:
> 
>   (0) it is more careful with bytes with the MSB set (i.e. non-ASCII
>       pathnames).
> 
>   (1) it hashes each path component separetely and rotates the whole
>       thing only at a directory boundary.  I'd imagine that this
>       would make a big difference for languages that force overly
>       long filenames at each level.

I was confused by the "rotates the whole thing only at a directory
boundary" statement. I think one way to say what you mean is

   Each path component is hashed similarly to the standard name-hash,
   and parent path component hashes are contributed via XOR after a
   down-shift of 6 bits per level.

So we are getting something like

	[ name-hash for level 0           ]
         ......[ name-hash for level 1     ](truncated by 6)
  	............[name-hash for level 2](truncated by 12)
  	..................[...for level 3 ](truncated by 18)
  	........................[ level 4 ](truncated by 24)
  	..............................[ 5 ](truncated by 30)

and at each layer we get the "last 16 bytes matter" issue, though it
is balanced quite well. Also, the name-hash in each layer is adjusted
for nybble swaps.

(I don't think my explanation is _better_ but just that it matches my
personal mental model slightly better.)

>   (2) it gives more weight to lower bits by swapping nybbles of each
>       byte.
> 
> I wonder if we do even better if we reverse all 8 bits instead of
> swapping nybbles (if we were to do so, it might be more efficient to
> shift in from the right instead of left end of the base and hash
> accumulators in the loop and then swap the whole resulting word at
> the end).
I will give this a try in my private repos as well as with the name-hash
collision perf test from patch 7.

Thanks,
-Stolee

