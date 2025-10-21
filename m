Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8E2E2F03
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041024; cv=none; b=eOnG9tAI6pYhbbxptENWciaEnBsd0KmjS/55Mhb1uRlktq/IFn/J2Xg2PUUOoRmVvWHOnj/yO7E7f6HqyYQOT1X0dnvrLSYBvSwXRJncgliUo8fI6zsIRskHFTjM3S2p68JioY4MAO0I/fWQmlTvKJvrghb7JdKb3KfY8vcNzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041024; c=relaxed/simple;
	bh=seh20X5zS/kY3vdkeApkPPVunagwHDKlH0SJOxoJv7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbLuy4yNRa2Wct6dWyuI2p7t1LjX6uQyhA0yxCUmJ6KowuV0emUZNEwDCVeLIwLFSZCCXC28nn08YnMg5XuWiwscXWt0rVryENEW9h+7+VMjo5OAfL3CA0cxzBY95VDeKWZ4i+rC2MuSxSEgT8UXPnjQ8jCB8bWfv27mCPL/714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY6XHFLE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY6XHFLE"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso2449097f8f.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761041020; x=1761645820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NslRvAEMkOhXi86J8U8QOs9gTxVQO5q6pLOfuKm+j1s=;
        b=OY6XHFLEqTJUvQIXBCTPC002mfmld/8+omTgNKKwy06+QjP0QNt1aIS+15SCUfQEUI
         RuFMDd1oljU+IXvBx36XNljeMYrjzutcSh1rVADpbnWDWoZFoZmWXxcbeII21yPd/uqn
         /QBVThNAwqGxN8UV05QrwIBoM57hfgeugJqKBl6vJyB89ka25zI2VTYH5s81MF98KV8O
         RT06SXrWYzWhGEhQ/cpts/PITAcgE4kpm5cO9Wc7CZVOVLuq4Ogt+Svtq40sJopfNQDG
         RfeV3h2cn1jKEDklUWQ1e3G3L45rVCKfVxGcXJ8yBY2gUNnjv93fs5YcyPyOefsTkmN4
         pqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041020; x=1761645820;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NslRvAEMkOhXi86J8U8QOs9gTxVQO5q6pLOfuKm+j1s=;
        b=A9z+E1rUorvyfZtm2sDgSlR4AE40waVXNW4z+WdXmxKBC3aGNBCsWZbC0IkdQa+CHV
         3sic7CfRjyr5BqBgwGPrMPgP8YMeR3OUN3TBJsH1hLf4rVTusVsPm3ppl3rwy5GDCoRq
         A2b5ZNOVVYxX0QQcLgPOsCt9ZGqAx7aa7wXccHjrqvjPD0bv0Qr+9R/IUFVha3OvSsll
         5Po3rgu20pLsNWIylrnsLR32K7H3HPGcq5zHcbCQMy8aq8o7LGvvky2zooB2GgOgUb8y
         Ym4PWJgtF/P7MVLn1Xp0Hu+FN6P6XEbPQEhbvK5xw8SP8d6hWgRPhic7fJSyC4cnJKWN
         lBRA==
X-Gm-Message-State: AOJu0Yz3mSLbnlBReH7F0Dt1CbrRkyNjDf32g+2CKGqzIafkcHj+IAAd
	jctNHT9DqssETEH5zvwCGDI+nzLpkyc1hEqczcSyGr8XJWJxcSPc0DlF
X-Gm-Gg: ASbGncsY30v3bKfPz2vNdIsdULY7q43/U+zq1jPsksTaE9y75C4EIH1UMPQZI5XRIFL
	BP5i4K6kic3X+g6SqUljvUMgcVhzqgjpE7inNJhb/nRcX3tJJF4H+JaalLfAV2QYh5MyCfJEuJX
	EfTmKX2JLsEr6jmQ1KHI6tK6KrWKvda/xZKaYZHzeAku/KnTgg+uXl1dK5H88EmCM4RjBRk5wZ8
	9O/4RI9KVxunMW5LkACYS8sfkgGzQkqg1KHau8uwbFU1eNjT7/rM2lcudjY6Nn58N1rh47mVcUh
	YOmHE2lEeXGQIQUz2xObon4IP0xN5DlDRY1JiLV2bC3Wkeiwzt7RT32GB9c6DxeNpr2UwUHpgly
	czg0OLi/u7md4okt4hH7LFzOHeDQXNx2EnQhg1ef8VpH6slhWzUktnZXlCDuA9i83+ObA2I5irJ
	cMBSAG8N9LrDVbwPfucLR3AlZ+MoEpCjDq+KCeZhld10+1te6alUxY
X-Google-Smtp-Source: AGHT+IG2H9yJGw4zUSt9bBgKDNamqG27dTMguTYG/XwUR14Z1EBak9YMdwidsWQZEqgrKTGseddE6A==
X-Received: by 2002:a05:6000:420a:b0:3e5:5822:ec9d with SMTP id ffacd0b85a97d-42704d99f29mr10654371f8f.41.1761041020318;
        Tue, 21 Oct 2025 03:03:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0e9csm19722523f8f.5.2025.10.21.03.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:03:39 -0700 (PDT)
Message-ID: <a0711cfe-6e44-44d6-b66b-84a296e113d2@gmail.com>
Date: Tue, 21 Oct 2025 11:03:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/9] xdiff: split xrecord_t.ha into line_hash and
 minimal_perfect_hash
To: Ezekiel Newren <ezekielnewren@gmail.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <a3e706ecdae51434fd5ee112c13f8cf374faf6ed.1760563101.git.gitgitgadget@gmail.com>
 <CAH=ZcbAjX=V_VvJsRzvQEA+CMM7dWQx6E5=d4FL5CD3s+ozjBg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=ZcbAjX=V_VvJsRzvQEA+CMM7dWQx6E5=d4FL5CD3s+ozjBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ezekiel

On 21/10/2025 00:29, Ezekiel Newren wrote:
> On Wed, Oct 15, 2025 at 3:18 PM Ezekiel Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>
>> The ha field is serving two different purposes, which makes the code
>> harder to read. At first glance it looks like many places assume
>> there could never be hash collisions between lines of the two input
>> files. In reality, line_hash is used together with xdl_recmatch() to
>> ensure correct comparisons of lines, even when collisions occur.
>>
>> To make this clearer, the old ha field has been split:
>>    * line_hash: The straightforward hash of a line, requiring no
>>      additional context.
>>    * minimal_perfect_hash: Not a new concept, but now a separate
>>      field. It comes from the classifier's general-purpose hash table,
>>      which assigns each line a unique and minimal hash across the two
>>      files.
>>
>> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> I'm a bit surprised that nobody has commented on this patch.

I've been off the list and I haven't caught up with this series yet.

> I thought
> that someone would have criticized the length of the name
> "minimal_perfect_hash" or asked me why I was splitting one field into
> two.

I think "perfect_hash" would be fine if we want a shorter name. More 
importantly it would be helpful to explain why the two fields have 
different types. I assume it is because the perfect_hash is used as an 
array index and therefore size_t is a better match for rust's usize than 
uint64_t. How much more memory do we end up using by adding second hash 
member to the struct? If the aim is to show that only one of them is 
used at a time then a union might be more appropriate but I doubt that 
plays well with rust.

I'll try and have a look at the other patches later this week. I think 
the type changes are going to need careful review.

Thanks

Phillip
