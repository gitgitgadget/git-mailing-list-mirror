Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7380181317
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542711; cv=none; b=eoQ/gPWsBzkmtkHed1RlftimFJfFNQ09Mh5XRf1HhrHh+mB7zjYj+0uAtP94lJRWa998MOmP97k46WOIypF6bwT5zVAzfuO01dzLwLwteHIa94RnpbPLnreKyOrN7a0/JMnJAN+k7RS2LoMjXTBpbeMwSnR6Zqdds8mOhNyjZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542711; c=relaxed/simple;
	bh=Dwkzg3KVy7ZAJkc9A6SY62Ipz+s38w39V8cCfD0nXUE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=JqcL+BINlWvij2JReVZTRo8JLcw7K/MArvGZP1SFWOaDHZqyRgjpFnDmTRfRqrFqlJXGvLmwJFMN5eJnxm4pNZ5FZpe2qLT1F2Me18Cmmx2ZOUw8sTo9DWLHT3YAutV+PPG5u/zdtxGaZuGKTgjqGICxtwbl2UmABom92PFvxgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGoPaoZl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGoPaoZl"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428163f7635so41389135e9.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723542708; x=1724147508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKZ1QDNTRwnPgekaa+2bK8Wu4XUDb5HJ3mU5DwuQnIA=;
        b=SGoPaoZlIpBoih/8P00Kzs9le6zL8zGxv1yoYACmBp2tSxSt7kb6nDFvJ73H+ux3ud
         CdnfK7/6hiJbBmKuQdwZcrz498XmdjlGE/SDI9tL+8bjg6VlqPANeKqHNCKNDTMD6CZc
         pGzYQp/xNQGA/awnWGTKh7TnCGH+78432eLrfjJFazgXB7ku7q+Rtpo6bQZqTxDPU1z5
         V0A9BKQKo09QLHaW8hSyo3i/xWo7uF0x99VcU1Lzw/asCOHvnR8LantNCqb5WyGXpN+T
         IoSMNO1wrKSaJn2QwSxCsseBPyYJkX12DYJJywEPGYmaVa4SyqNXi6SPV+WtjjFd1A4Q
         /scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723542708; x=1724147508;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKZ1QDNTRwnPgekaa+2bK8Wu4XUDb5HJ3mU5DwuQnIA=;
        b=n0XoYYl8UMzxBcbfA060l/y9JLyg0wnxnBfYYbhUt2YF9XWd0ZSMBaiD1fOPPqW8L0
         vXMIXfU+ec3kjNxoCwS7HeztzohiDCDvC5M4uT6iBB+R6w96m/dqqNAnrLJnR68ZANgC
         k0JHrqOAR08nsulIeP/xAtKVf7iGdTiRnopvHgOPZJRKkElJXpuabh65js6bMAf8GEEy
         ZW8oggxkJRMX0p1FfU31GEkVWb07Lgd5oJuxgls6BALYI3pZpduP3R7Z1Dp5IKXNz4+2
         WJ2P9n982Y5rcMKGDiVtzyPXyYBO+D8WoboRh/Y9bGuKt8cBEB+ECFdIpOBIIN7ETMiT
         9RIA==
X-Forwarded-Encrypted: i=1; AJvYcCU2tlvYJObMB4QjAQIhfEHX3QvpHv1Hg5fsKWnfAEWUUKw8zT55Cp895W+lOHl+VAWefs5GuqR1XVT6Qzw97dQ6/OOv
X-Gm-Message-State: AOJu0YzxVvKtVaREZ50DU+cP5g0W4hf1mF7aUlDS+dpmmQkQQhbZIF7G
	wi2dCdrYJB8kVseHPT66obZ/tvUFT9RmzCYsd8+R6OceKm9Eq3HN
X-Google-Smtp-Source: AGHT+IFtIIoMyRIV1kr6/+pur3YXqG251ZlebxaaU1vhj+SRryiH/Gy+3kkAhppViRH2e1MvkMBKzg==
X-Received: by 2002:adf:e04a:0:b0:367:998a:87b3 with SMTP id ffacd0b85a97d-3716ccfe7f7mr2163008f8f.28.1723542707713;
        Tue, 13 Aug 2024 02:51:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd3416sm9653844f8f.100.2024.08.13.02.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 02:51:47 -0700 (PDT)
Message-ID: <92278af3-0ade-4e7a-a024-f66b008b9cd2@gmail.com>
Date: Tue, 13 Aug 2024 10:51:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/5] config: add git_configset_alloc() and
 git_configset_clear_and_free()
To: Kyle Lippincott <spectral@google.com>, Josh Steadmon
 <steadmon@google.com>, phillip.wood@dunelm.org.uk, git@vger.kernel.org,
 calvinwan@google.com, emilyshaffer@google.com, emrass@google.com,
 rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org,
 sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <908ad0b82fa084fc4e56d7f6dff49e4f255af6ec.1723242556.git.steadmon@google.com>
 <47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com>
 <bifcs4ijz4gsnrfjs3naqclo7nj7ajhek6eppgaj6a27ixp372@6oariraac4rz>
 <CAO_smViBnmc4r3MizV5kE406_TvXiwCWtC0jyDb-FT-zp9H9bg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAO_smViBnmc4r3MizV5kE406_TvXiwCWtC0jyDb-FT-zp9H9bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kyle

On 12/08/2024 22:55, Kyle Lippincott wrote:
> On Mon, Aug 12, 2024 at 2:39 PM Josh Steadmon <steadmon@google.com> wrote:
>> Hmmm I see your point, but I am also hoping to keep the symbol export
>> shim as small as possible, so that we can try to autogenerate it rather
>> than add entries by hand. However, if people feel strongly that we don't
>> want to add helper functions like *_alloc() or *_free() for types that don't
>> already have them upstream, perhaps we can just put them in a separate
>> rust-helpers.c file or something.
> 
> I'm thinking of this patch series as two closely related but
> technically separable things: the creation of a .a/.so that can be
> used outside of git, and the rust wrapper around that library. I think
> these functions would be needed by all users of the library,
> regardless of what language they're implemented in. i.e. they
> shouldn't be thought of as 'rust helpers' and instead just the way
> that the library is designed. _All_ functions that allocate memory
> should have a paired "free" method, and that should be used
> exclusively, regardless of host language.

Thanks for writing this, I agree we should be designing the library 
wrapper as a general purpose library, not as an implementation detail of 
the rust code.

Best Wishes

Phillip

> So nit: I wouldn't call it rust-helpers.c ;)
