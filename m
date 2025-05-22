Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A85847B
	for <git@vger.kernel.org>; Thu, 22 May 2025 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747878533; cv=none; b=tzr6wAw/6JGajbxMNRhJtyQObSP0P/YendSKkg+rDUDX4fiJ1Iyg7erEgb1WDYrJ89DmQHy6c+E+fGEDVlxiHNw/mLn2aj0BoxWm7EPy+sIxIj0n4kvBY3krJcaDyt1tVsgpo7GBVETZdcuwWUsZSby88cE4xmtsAVs8EY2WtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747878533; c=relaxed/simple;
	bh=mCwABwD7xxeCLja7m/vqVa2JTmCDufIjtWFwjHTvkLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHmQp61zOlTCAz77TLL1/k1qrE1jrl9mwS7N7sxr/cURjnBsSAvBNPgcDi2KsTriIs6rypjTsG7i3kWBpbjFHfP3Ue+2I86TVGs0I9sbbGJSlnNj1sU410zBoWYVm7+HdJ3XoOS3VWOWgMe6OPc68neHjklhJKFxt7m2zPDyZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwemGLu7; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwemGLu7"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7b811be6dbso4965048276.2
        for <git@vger.kernel.org>; Wed, 21 May 2025 18:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747878530; x=1748483330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3HNCijzFasPFyboX3O1wtLkCQxceNaopeWoH77QW90=;
        b=SwemGLu7OwW+GOSoie7Essl/uvLHoz8/Dd/3umcOeGIdB/umqAwyS5wLyB0s3zt2Lq
         SFoUtGOygOVwF9USil5Mw82wLcO1Kwhf3kmCNA9+CNPnaQzc9gBSeLXdZRyFwUH5H6rL
         6oeW77UkzcWlTeZEjHgzBFgFhYhiis0waj4H4avH+jvX67aC6IcaMmRQnjAr/jwcURYO
         vveOrJTy0gYwuAnmOywIPuldqTCUMt9G2NRP3rVNYZQUYBO90a6Qt91m+Ad/wYpNwTbo
         Zmzs+u1iuQoweGXPUEY25DAsLmpjVYTG6ZA8cthN2/A9MaNTo4pDIFqENTIY6+CkBNwH
         NoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747878530; x=1748483330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3HNCijzFasPFyboX3O1wtLkCQxceNaopeWoH77QW90=;
        b=NNTCKBWNz2ez3z1PQ9eoWEgUiWv4G5rT+rtaPYUwr9QaQQAEpvcJ+Xz1ciJrYqALia
         2mqY/kYwWIHHKafVSjuF+GBCziRY7xDHLNVstEg+vxU9UMgworh4W3E1aRxfmDAwtHS0
         4/NG+Sbof6UjBUCu6j94dkD1XBp/6Ok3XI0BKgfvzIfMIH5kot4Iiw0KOghaHQwToi3c
         dZbHGme9BxPlGp5zMTMi91mHZnhaw/PurZY3+SfGI/myYvTbSGTKPvQy1QMXZ/RE82Zi
         iMxAM7lCASyzsYk9iBvJAvJ0ZysUwBbl86l2hwd7VeoYghNx+bM1A/EkxGMi8SctWO6B
         w5Tw==
X-Gm-Message-State: AOJu0YyYWuUa2FU8NzuUJ78Q3dYx7fSPeI9ZY8sWalhHKZTcxSJ9cl18
	uN2kVz9uR01ZifVGaSciBzl4Bkgo+FqK5SSZBGfYuzX40hcKZQ86kwUjAUOtvg==
X-Gm-Gg: ASbGncuBHyJNmKlDAUlPUsnTrlGWp2RIEbidDA0usgMbfV0qZ3i+j24EiitSQ+0imae
	QK7bPmKD+ya3fwBfYupn+n9P1smwHV2GUCmj1YQGt0lj4kRjBF4E8K2bdWs0mSKo2gLIJNcMmui
	g/IwSGrZDtS7PJ5KuSAoyA3lbLbLtu2lWLkejdY1VJKakqBui0lnmi09NmGSlwoRuqAFd1TJ50t
	KZHiNPvkWu5pxlBp/bRqdt4WXrXpNnTIY6oK1TsFQoXgDdjDEHwdVoaf1bin+uhmzcdSBwgqBtd
	ZMLnxojzyCgiElHU14WmWEVfO0D5dZgmmxgDWuQTR0Zwr1fShE2zApYus7526LeCszfyLEnt7Xk
	64pdX1YKJOFmd6+jcJHv3e/v3aGA=
X-Google-Smtp-Source: AGHT+IGXe11Qo0P5oqjocgF3W+8lJluw6bbV5mHiHsc406URJ5x3eOPr6+wywy95/un7gETemqG8pg==
X-Received: by 2002:a05:6902:1001:b0:e73:175c:4936 with SMTP id 3f1490d57ef6-e7b6a42d9d1mr29290650276.43.1747878530369;
        Wed, 21 May 2025 18:48:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:d51c:763d:85e7:1777? ([2600:1700:60ba:9810:d51c:763d:85e7:1777])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7d69137c72sm383491276.3.2025.05.21.18.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 18:48:49 -0700 (PDT)
Message-ID: <1ca297cc-35d8-4f8f-98d8-fc8d27cee2de@gmail.com>
Date: Wed, 21 May 2025 21:48:49 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] name-hash: don't add sparse directories in threaded
 lazy init
To: Junio C Hamano <gitster@pobox.com>,
 Alex Mironov via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Alex Mironov <alexandrfox@gmail.com>
References: <pull.1970.v2.git.git.1747858585623.gitgitgadget@gmail.com>
 <pull.1970.v3.git.git.1747862971672.gitgitgadget@gmail.com>
 <xmqqa5758wlk.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqa5758wlk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/2025 5:47 PM, Junio C Hamano wrote:
> "Alex Mironov via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Alex Mironov <alexandrfox@gmail.com>
>>
>> Ensure that logic added in 5f11669586 (name-hash: don't add directories
>> to name_hash, 2021-04-12) also applies in multithreaded hashtable init
>> path.
>>
>> As per the original single-threaded change above: sparse directory entries
>> represent a directory that is outside the sparse-checkout definition.
>> These are not paths to blobs, so should not be added to the name_hash
>> table. Instead, they should be added to the directory hashtable when
>> 'ignore_case' is true.
>>
>> Add a condition to avoid placing sparse directories into the name_hash
>> hashtable. This avoids filling the table with extra entries that will
>> never be queried.
>>
>> Signed-off-by: Alex Mironov <alexandrfox@gmail.com>
>> ---
> 
> Sounds quite sensible and the above reads better.
> 
>> diff --git a/name-hash.c b/name-hash.c
>> index d66de1cdfd5..b91e2762678 100644
>> --- a/name-hash.c
>> +++ b/name-hash.c
>> @@ -492,8 +492,10 @@ static void *lazy_name_thread_proc(void *_data)
>>  	for (k = 0; k < d->istate->cache_nr; k++) {
>>  		struct cache_entry *ce_k = d->istate->cache[k];
>>  		ce_k->ce_flags |= CE_HASHED;
>> -		hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
>> -		hashmap_add(&d->istate->name_hash, &ce_k->ent);
>> +		if (!S_ISSPARSEDIR(ce_k->ce_mode)) {
>> +			hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
>> +			hashmap_add(&d->istate->name_hash, &ce_k->ent);
>> +		}
>>  	}
> 
> 
> This unfortunately gives us deeper nesting than your previous round,
> but the conditional matches the original commit and easier to see
> what is going on by comparing the uni- and multi-threaded variants.
> 
> Nicely done.  Will queue.
I agree that this version is ready to go. Thanks for shepherding
the v2 discussion.

-Stolee
