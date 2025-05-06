Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370EB1C3C14
	for <git@vger.kernel.org>; Tue,  6 May 2025 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560638; cv=none; b=gvNM6BjETkz/315SuoH1wyyURepgE74+ndb0WTCzEg2c8SfKzotrCXFqfxp/y3GugN29TV1+WVrj+k4Hfqe+pT4FWcKFXhM0qXuz+V44iuAHYFG2PLmoL5IE7Ywuwb4hCsOij5NNevLrOD6cxPnDmV0vfIskn8dL+RWH05VDlSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560638; c=relaxed/simple;
	bh=UZoMn82BHI09v6NETVKwrWF+nvzJdIBVRA0tgZ9lDVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jjm/6zb1tW3mQq3dfTpuCkYPtgc083SqCi98acfVknCWKNHafc0kYhtlLzvOUyQg26Z89vkQQ7iYinqeQS3/Xr6kkzhJL9Fp4PQtPk+J9nULqmpEMQPOIrS0x6mU3JEWCUKpAqcqnKzAD5Nt3xzwMPSuiRrT/VbamE+UUjdQYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elCHB8uK; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elCHB8uK"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-708b3cc144cso58057227b3.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746560636; x=1747165436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxLrZ4vcg2MZ/r4vhcIGXbwV6MtqZHJefluJU91JOqs=;
        b=elCHB8uKfQohuChwpqIh9e08htC/9i5B0OfF/9x1M5ZaK2zm8hidavTxgLtENVcMwH
         kH5pNeu3uLLrmdVMT4lzpN2RG7Sy9Ks/ITY2nmd3ZC6SDvMeSFRHrBLaj8cyn4k69dhT
         SZaODqLsiDyNvQtv8QSocz4xA0F5R9VGRkhlamaOYzutI5I43AawxbBAwTuwEPoAz7AD
         1gQo9aPhbEWLVoIE/TvsbceZG46QsK8PE79UGabVEOXTDvpRsdb0fEcc/HjR6QTAshvb
         qwelTEvtwH0WLLINnWDrw/uwpQAIVaFL1WgSA3XIDByBG3DZXm28mAeboDzOM49hkX+1
         zIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560636; x=1747165436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxLrZ4vcg2MZ/r4vhcIGXbwV6MtqZHJefluJU91JOqs=;
        b=uPw1c0Hh/0kRkmqBD3NG3rhg7a96pvefEmmK4wZO3yb4Hrcr3AUXYeJvpJkC2jFTYG
         daeWLlxx0NohGxuevMmeAUbj+7uxsAU5rJtjP44jlEIUFx73XV7D6uZijuiUpAQhm4/o
         C0BiZ9/++MJZ4VX/GW1KAqV2CH0fptfQN5ml8oaoiTprz9h6a34rq8VavAt6YDuqC/No
         uy1aG5vHsZXIaULId+e9bwdjmc/AeULmStBJJexahnSBpxnQmhJMX1fzBLGl3dODWAEb
         odeAT+fXuGUqtP5XWumf/ARRgqVrdLNexjl/2diCEqRuBJJo3zODPrF3EcsXtf+aS9ix
         4UCQ==
X-Gm-Message-State: AOJu0YyzXYNe/l3CZbxCKY08/2xEBRlzLE1/XQTK/eGKJNgAxJ89d7/y
	nF3vxP9q4xlNwTt9ltdW/rOnp6rKJi8dYLqZM+vjxrT/PKbPECZr
X-Gm-Gg: ASbGncvftIvMhvQrxecFpqCd6LOYrVYJH1iRYjl65yQlzd9EO7WjNnxFA8Uu+a0yUaS
	YqoFSvGv3p0vwXc2nVLy/NlkUXWK1eJBvm3YhiNl+RPPW7+WNifBvvY724beEdY8EaqxA7hdbLF
	xv8DoZcOGpr9/QXkMRlxhsFyfMhAMQ23a1rrMSVeyQqKkovu12EeuS7rlrgOnGwfB+A82q9OVfI
	19cuLsjEiOLzYc+0/YzHrW7yEhn5FOt/1isxHSfvvvLi0Xw5bIxXVUfky+AVnoNEwlu/4rMEEWi
	2oMrAXIZiCZHItqv3h2i4fKpEoRrkl4S+PUMA5ezrDvCBQGWyJ63BV32HQwmR9008k2nD633rbz
	eyEYoeTzr5ItFpsnhcOijANI7wiS3
X-Google-Smtp-Source: AGHT+IGL1ck+td3V7/o8k4UwKrCn0wIy8yiLhKWKfx02WiwBnmCsZq5oAWdP5K5loOzV85cWmSC7rQ==
X-Received: by 2002:a05:690c:905:b0:709:8839:b46f with SMTP id 00721157ae682-70a1db0ff80mr10926177b3.38.1746560636040;
        Tue, 06 May 2025 12:43:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708c46f0edfsm28581737b3.125.2025.05.06.12.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 12:43:55 -0700 (PDT)
Message-ID: <7a919f7e-1e3e-4c30-9f57-5a536dfb3697@gmail.com>
Date: Tue, 6 May 2025 15:43:54 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] pack-objects: introduce GIT_TEST_PACK_PATH_WALK
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <0d49bb3d30add66676280ec7fabed12351d5b3ac.1742829770.git.gitgitgadget@gmail.com>
 <aBVVwCZ0NZT3KLB/@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aBVVwCZ0NZT3KLB/@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 7:31 PM, Taylor Blau wrote:
> On Mon, Mar 24, 2025 at 03:22:41PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> There are many tests that validate whether 'git pack-objects' works as
>> expected. Instead of duplicating these tests, add a new test environment
>> variable, GIT_TEST_PACK_PATH_WALK, that implies --path-walk by default
>> when specified.
> 
> I normally dislike adding new GIT_TEST_* environment variables, because
> I don't think we (myself included) are great about remembering to get
> rid of them. But in this case I think it does make sense to add one.
> 
>> This was useful in testing the implementation of the --path-walk
>> implementation, especially in conjunction with test such as:
> 
> I am not quite following... this sentence sets up a list of tests which
> I was expecting to show some demonstration of how they uniquely
> exercised the path-walk feature. But instead it looks like it describes
> tests that are sensitive to object ordering within packs and thus had to
> have the new GIT_TEST_PACK_PATH_WALK variable unset/set to zero.
I guess I mean that having the test variable helped gain confidence in
the feature since the only test failures that occurred were due to
cases where the tests relied too much on specifics of the object walk.

I'll think of better ways to say this.

Thanks,
-Stolee


