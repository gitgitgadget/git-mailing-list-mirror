Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B821CCEEC
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739747; cv=none; b=Frg/GugCGWt3wNGh1tq+kbx6xXbA2lZvuDl3tUKRVR480Ss1LJrYjbcjAKT+E3gNh6ysNZ7+phdBKwixl471q+hzr0E4BP9+Xleca0xrwGTxXB8QOba9DAyLW8uFXSK9LYm3uRW+3h8FsJFUaQpT5B2T1asubf5MFpfoaDWjjvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739747; c=relaxed/simple;
	bh=TsByH/OJVgzedmkeJSyHCe9zVoVoWz5+Yy1wjK/kly4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMjKLt0rMrhbvFOCEmT/z4b85/3xjkOl3UmTRr1o/I1pHDnmAW1QiZcinyt9YqBie8SLtLubICrFShdFuwBNo60LDK4b6lzgpm13OlVFW5Y0bLbw133zjjtHOeL7K5qNQZOsfFoqN2vNIdUhwlu8XvaBrAir8CZO/t5cwdz99fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cixM+3Ic; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cixM+3Ic"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so3917546276.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 09:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737739745; x=1738344545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YutEbjF3nRCcvlQmisigsgpntpmVDml72dNVsgPzwaY=;
        b=cixM+3IcWNvxaOiF1/wsj67NdystlD16B1b8AfWKA2U8k2tw7uUi4k8g+B5xnRaWHd
         bxx9ZfS+Obxw614SH3tLu4lkWv9ZkrDoJ1XgZBBdlc/6hlf8X9K4fLJo/JgocREE8uy2
         1TupQ267sM7mRLrwozy2zLRVcBHH4GhykhjFtVAT02CBYdg2jnmsr4zHVKA+uyJ6LPRU
         VXCy/2E3BcEyhB7nNp0kvyQFtCB8k3xZBEqnd9FB3yKBYH4jgA46igaFm0y21Ox/304q
         xDGmAu8TNdLJzA4DfbP1jrkVySq1xYmVGP4CDdpVT3FUZN9srwTJSb/7Z8sVi3nbhD+E
         xA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737739745; x=1738344545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YutEbjF3nRCcvlQmisigsgpntpmVDml72dNVsgPzwaY=;
        b=Pl4R/d4+At4+TBQ83BWYaNr2dejdBYwfB104uaLFeAOmW7yqtg287L5agp0X6ruWU1
         XmNvPtbgYRf7THOXJxGC5wzyf1ygZ3rzWOQwupNJsgc+05MkqLSB0roxahg6doXAzmH+
         GY1iKr0rhMT4GgvgVVLPDZ2EnM5REJa5JncLUoeaTSiiSY6hstC/sgKnAxIiCRC772JO
         eNoeOzEa8XkUH5ab+hk+HABkouiht0R3Ka8KEFbIX4ZX/mDLu4WjzNtcGnh3BJH71/6D
         1wYmg6OSTh5tuKrKSxy/+g+7nMnM9BXEqqHkdSWtfWLgz3Ot2iScB45aawGcFhc1YlJC
         pf4A==
X-Gm-Message-State: AOJu0Yzig4IASCmpnj/A9qIsFvj+kZsyJF5SXYExxFYpxNM0Yek1qW2/
	5t5smcaEZLyNm3mk1ant2G3nnMK77JFVJeYXxRyHxPTniByrN3a80isTRC+1
X-Gm-Gg: ASbGncvlzrzKTeVdGEnN9Auj7ok9+CJBlIvnJ8tniVz3XEljut/RAxwrpE+4lHPjmii
	kTcNIS43cWHAdqaU17nBzBXUEmx+avd6U48wWKT2YHmIyBgAyiA+KfGl53Nh8k6T0UmJYU1HGj7
	37ywupqE+fHrgi/UbdS4RZPVTyb/R/g4ZfS84VRwujrehGJO09h/iq2DYTrI7+J232X91QtJRSN
	W0mWxRI3E1NGS0/NksOU56bgTxQ9W+tuykZh7nNkITy8+GGznzWpPgd0soL6UoqqRr7R078s68r
	WAM8kLFyOLTiFVaSwzy8CWOlrRC0yCb3tIqrDCApHpO12lxqNFkwJgfeDz2zlQPJjtnM
X-Google-Smtp-Source: AGHT+IEg4K1iAwJAwmj+eQ6LpgYx/iFGlTCqzcT0Vj5NyhH2knE7+Kw2j0IJnrsWoGHAXmHGqLLO6Q==
X-Received: by 2002:a05:6902:1502:b0:e25:ca37:b669 with SMTP id 3f1490d57ef6-e57b10983ebmr21487427276.24.1737739744924;
        Fri, 24 Jan 2025 09:29:04 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:c52c:1d3e:3dc2:a210? ([2600:1700:60ba:9810:c52c:1d3e:3dc2:a210])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e583b862558sm414759276.43.2025.01.24.09.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 09:29:04 -0800 (PST)
Message-ID: <d30f6373-e98b-4fec-9a73-eb3bb54b9380@gmail.com>
Date: Fri, 24 Jan 2025 12:29:03 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] pack-objects: add --name-hash-version option
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
 jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <d035e3e59f42c75760e8dd6fe8ed6dff12bc8b9a.1734715194.git.gitgitgadget@gmail.com>
 <Z5FugEXhdKjhwcnP@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z5FugEXhdKjhwcnP@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/25 5:17 PM, Taylor Blau wrote:
> On Fri, Dec 20, 2024 at 05:19:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>

>> +static inline uint32_t pack_name_hash_fn(const char *name)
>> +{
>> +	switch (name_hash_version)
>> +	{
> 
> This is definitely a nitpick, but the opening curly brace should appear
> on the preceding line. I don't think our CodingGuidelines explicitly say
> this. But in my head the convention is that only function bodies have
> their enclosing braces on their own line, as opposed to:

You're right, I messed up on the switch statement.

>      static inline uint32_t pack_name_hash_fn(const char *name) {

but based on my expectations and your earlier comment I think that this
suggestion is a copy/paste error and you meant to highlight the switch
statement.

>> +	validate_name_hash_version();
>> +	if (write_bitmap_index && name_hash_version != 1) {
>> +		warning(_("currently, --write-bitmap-index requires --name-hash-version=1"));
>> +		name_hash_version = 1;
>> +	}
>> +
> 
> Hmm. validate_name_hash_version() is its own function, which seems good,
> but then we do further validation on it here. I wonder if we should
> either move the latter step into validate_name_hash_version(), which
> would require us to pass a pointer to name_hash_version, or assign it
> the return value of validate_name_hash_version() (assuming it were
> changed to return the appropriate type instead of void).
> 
> I think that we are probably pretty far into bike-shedding territory,
> but figured I'd share as it jumped out to me while reviewing.

Sounds good. I'll try to minimize the uses of name_hash_version outside
of the cluster of methods that implement its details. This may become
more complicated later when the timing of these checks is more interesting.

Thanks,
-Stolee

