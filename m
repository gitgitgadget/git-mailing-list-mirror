Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621DE1CEADB
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821269; cv=none; b=Ssuq4uFspEIo4DthrVIX5jTTfWmJ4h0dV4IwKhVE/LNSsv80Ei+idDvgf33X1zd0x4BbNmzHwzZICW3ffENQ5GFM8VZ+tzFCqjLSY5ydfWEkL3QsIrwTt+M8sJAfgTkIUixohNy3YTSqkiSKJMwFATDdmTftlrskfRx3iLFS/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821269; c=relaxed/simple;
	bh=krlxIjnsFSqKgf93YH04ie1hXyH6ltj2W4bm2rDD5es=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nZ14zYJqbPJV/47JWjVN7MUFHhavC3Vpvu6P5uca/1R8E9sMB25e5Ib4C3FsBynsSUO3wG4FK6KEKqkHqgGKWdrUM2CzXRIz5fyhlsVGZAmZ9r13RGUsIvZ9dnbzLir0BtlgdYW1gjpI7crkyFXilIgZR3C9z7ewz78AKNFb7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bImX3ZQZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bImX3ZQZ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so531359f8f.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761821266; x=1762426066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16VuvQIGfNFeZfSigsfHC2ewhPrAHlrPxi8msNlTKlc=;
        b=bImX3ZQZpeYWCmDRgbEIBfDSRCPLg2zuLs2FzZ7e9FQSAgc+Nf+Kz+XfyfTmeswfWK
         rW7gpssTbeq4PzKawDJ3wY8qgLwh+JoNe9v5aing3rrl33APegF2thUhTpBxmkKEsM50
         4GdUjGK2Hch55umt2Y5+Liws60iyntqKtEF+dl4Agb/4h7YUHBtlLFtB5aljbHwh2PJK
         rkLiAe1/2cmxCTHicmn2uM8EVpgCAhO6mwTRgFu4F+HZ2wrBsRVGHYUC45w+bxjVHVDP
         OZJp97Mr7wmnGzMp9E7Aw/bikOLWPzE7mNlkCJCvIoaxYBEo5cWINiUIGeVGVwE2Ygk0
         Vwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821266; x=1762426066;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16VuvQIGfNFeZfSigsfHC2ewhPrAHlrPxi8msNlTKlc=;
        b=GAbgUlNyDwf41GdeJ4Z2jZxT4MJMJT9ExyEdHMc1L4DXvBsYND9UYIor0Lc71XjXre
         imGmBoN6O8WG45xLTuOyEikATWWPIldQZJbMo1SPhxsElyDn9YrldXKpjrRF5KJJXAzL
         XRvi7EzUFxjFHi6Wb7ZUZHfh5IvFvaDDr6DBwMkTVkgtkrY8cx82oDlGV5QkFqFk7GD1
         UUCGnuL034JyOu/17zclWUKAd3Vhy+1DMAi9znmBknfXsFnfIlfpVl6v7kBwxc8JZpuU
         w5JRvaP3jLF4J6ukNsgihu6ga68R+UzNbm93jtYKcKBGN8fLkkqYuGsZ89PAsxLt0RS4
         ShNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb9H1robf5ilPYGH0ZEA7i2peiHbUnsp4JB2EIn0c+FkofrIQTEgBlqPlKorePOw93bRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk4q7qjuxjT3qQdmqukuFcGAiPe3JZ6kEP0WDKK7p3i8vAfW2e
	ThTLvPfKu4SlQYvRZi+xlSqebVBmUXKN9BkmNjpaiDT9rXRYdi2o85xn
X-Gm-Gg: ASbGncsZTabK149tYGBW9kFV8umqVtiqxqFklTIjZyCu+b0o9X8TVmR//qEI0PwpL6n
	ldU3VXQeedZV3yKBdDa/DHTldaLtZqsSk0CsbjadAdzSDtdCcJANbdfihUz3j5zpvnvqvsylsRF
	dzmHZ0SNe3to2WHJ2SjNWwW/9+EQPNh+OiAKfhlyWz4fajxJcY2E5sjs2JJhUMLxIPZt3U+7eKB
	Dmngn4yRwhPvHJi9BG+DB71FZNw3IB7/K3vLGryigFz64qSXFC5OWpiodV0bQQiIm1/fd8GNfn1
	4f8KNX+ahrUShiUkJ7xhXhe6DmQd4gbB37Axnfk6FcoQgQQKo9ytOrTUsUV5jwd3nG8q3gHX6Fj
	0FNYeeGvQSHx2k0kl/ypitCXJVltmcXKOK0AG5Xz+gKhEK3OgcylSX3KxzG8TRrml2aNeLZGeL5
	NqlK80ociDBUYS1slwlsewHEM7yPLIX6xrY8n7mxO/E/KNQxvhePoh
X-Google-Smtp-Source: AGHT+IEl1fEGV7g19dJRjVz+4+SdHl/ZPEISTBKB9cgp7Bj1MNOnatYsKP3Vg4JT+s+Otl474UwFRQ==
X-Received: by 2002:a05:6000:230d:b0:428:3bf5:b3b8 with SMTP id ffacd0b85a97d-429aefcaa93mr5616991f8f.44.1761821265383;
        Thu, 30 Oct 2025 03:47:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df3c7sm30868225f8f.40.2025.10.30.03.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:47:44 -0700 (PDT)
Message-ID: <fa9c953b-a03f-44ab-962e-3eb4ee335b5b@gmail.com>
Date: Thu, 30 Oct 2025 10:47:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] blame: make diff algorithm configurable
To: Antonin Delpeuch <antonin@delpeuch.eu>, phillip.wood@dunelm.org.uk,
 Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2075.v2.git.git.1761658643278.gitgitgadget@gmail.com>
 <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
 <fde3dae1-bb11-45e8-9211-50ae003ca497@gmail.com>
 <33d44dc6-36b3-4736-b3ed-96861a3c4003@delpeuch.eu>
Content-Language: en-US
In-Reply-To: <33d44dc6-36b3-4736-b3ed-96861a3c4003@delpeuch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Antonin

On 30/10/2025 09:22, Antonin Delpeuch wrote:
> On 29/10/2025 11:16, Phillip Wood wrote:
>> Unfortunately XDF_DIFF_ALGORITHM_MASK does not include 
>> XDF_NEED_MINIMAL so if the user has a config file that looks like
>>
>>     [diff]
>>         algorithm = minimal
>>         algorithm = myers
>>
>> We'll parse it as "minimal" rather than "myers"
>>
>> As we need to reset the diff algorithm in a number of places I think 
>> it would be best to define a macro
>>
>>         #define CLEAR_DIFF_ALGORITHM(flags) \
>>         flags &= ~(XDF_DIFF_ALGORITHM_MASK | XDF_NEED_MINIMAL)
> 
> Ouch, good catch! This problem is affecting other places as well.
> 
> I'm wondering if we couldn't even add XDF_NEED_MINIMAL to 
> XDF_DIFF_ALGORITHM_MASK. I've reviewed all the places where 
> XDF_DIFF_ALGORITHM_MASK is used, and it seems that in all cases it would 
> either preserve the existing behaviour (potentially allowing us to 
> remove an accompanying "DIFF_XDL_CLR(opts, NEED_MINIMAL);" macro which 
> becomes redundant), or in some other cases it would fix a similar issue 
> (for instance, in merge-file.c).

Thanks for taking the time to look at the other uses of 
XDF_DIFF_ALGORITHM_MASK. I think adding XDF_NEED_MINIMAL to 
XDF_DIFF_ALGORITHM_MASK is a good idea as I think we always treat 
"minimal" as another diff algorithm, rather than a variant of "myers" 
which is how it is implemented in xdiff.

> Is your suggestion to introduce a new macro motivated by stability 
> concerns? I'm aware that xdiff is used in other code bases as a library, 
> so I guess changing XDF_DIFF_ALGORITHM_MASK can indeed be seen as a 
> breaking change.

While it is a breaking change, tweaking XDF_DIFF_ALGORITHM_MASK seems 
like a better idea to me. I wondered about it yesterday but worried it 
would end up being too much work to review all the existing uses.

Thanks

Phillip

> Antonin
> 

