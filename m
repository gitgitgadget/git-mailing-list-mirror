Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4A1BD9F7
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730340764; cv=none; b=JVPahszZ4UiMH9AYromW2CqNMgabjdbeTMt+Yc1rGoYut61nXuuR7H6XcTvVhte5/U+N9x3oEl2WOK5BKyiBpB34Sq4l5lBmf7WJU2R2z8qTYQgD3CKZi0sWP1SPGCZ623k0Dj0YUWy3A4+zVf+HM1xN0dbB9jH5Vo01GU/JImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730340764; c=relaxed/simple;
	bh=caxVPlnFFDLSBYLaZIqMjs9XMWFOvB7iwLVxVdI9Wgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7e7011o1bDGPbmK6DET6W2NfU2cxvKY19O7qeM5UV8v1Dv+p4r4pDbv2rCLTuNfi6pt9F+g6dNpQfKcLq5xrSvFQzbBG6KpA689Nkh7p0g2/EBpDZnwZdYrgXxstm7IoDJYvoc8pEmBjviF409bYSraN6JNJ4Vcpx3FQA5v5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6IP0T3c; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6IP0T3c"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea50585bf2so4715457b3.3
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730340761; x=1730945561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uH09Zp09CO735Rt0wt2ylWip1377eSTSQnswas97TwY=;
        b=W6IP0T3cLOmI35D0Nk529vuO2FNqrD46qc+plnSA93lc5+a53cAtUyjVTkpU97D3Zb
         GogthCQVTCnMX0IRyY4Esdm+LSLM4VW61Qt7r/mrktKaQDUbHP3D9Ft0ukRZxNlZv36b
         DOgvbMXNPoMf2ZqEoR/aOj8uxbo/QjYf8pONLmhrGu3ZzJWGRnhrNDGiRLPylvjsbXG7
         wKC1yrVHEtdpimsFwwPZWODHZIPpMz88aTY80BkC74jTOk/022+6d34SRK1H/8hOqcHV
         AsHmLCmUt120v37f0f90/8xzX6LBhtYVxxt7ihvoCsHgrWl4dbdSUSlTbhB1AkAxk/by
         JwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730340761; x=1730945561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uH09Zp09CO735Rt0wt2ylWip1377eSTSQnswas97TwY=;
        b=ri6jn6HvzQj0xmfddK1NZHZC7r9iRohet9+UMffD20klBjHi76Ym1nKP4VUtoSnR/B
         mhbqbGpHYpFvJ3I6Uoeh9/az9cqeukqW7bXGoUfzQvNy/B1KZvtH9MXVmeydGEhG3cVj
         9RUnZjq9wTYDXvH4assCFyv49uTr4ejkPYCbfCE+tLEP/z95zGHSd+ycyQfdpphONEDb
         Me+2PKPyzHf0RVFHX1qu8+ANeLFXMtRlHCh08kdwRbuhN76E/ZCAYTdTVZJRUDjiW3VE
         CdUDaRM2gYwKJLAgh0Hj1iTjx1VFaBrZKDcVTRZAZJbey69mDZ9MFeI2QwRcVCUGr2Pq
         YD+g==
X-Gm-Message-State: AOJu0YzD1FMTL0pqVWTJG6OFcXs+6+P83mu0cH+7cacM4JsyH6YHaSIv
	iym3VYcxPN7vhcuAgIxUjT3YOrU96zVLD1hPgx3Zq/YlupDvWNc9
X-Google-Smtp-Source: AGHT+IGpDWSgolCU5lkfU0gKtT0cQk2TTeNLu38SxOOyVHjLPGokKc63x7+vUO4/OdJixWfpbw4Hpg==
X-Received: by 2002:a05:690c:4b0d:b0:6d4:4a0c:fcf0 with SMTP id 00721157ae682-6ea4ff8b559mr28892417b3.20.1730340760765;
        Wed, 30 Oct 2024 19:12:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c963:384a:338d:bad6? ([2600:1700:60ba:9810:c963:384a:338d:bad6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b107b8sm957537b3.34.2024.10.30.19.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 19:12:39 -0700 (PDT)
Message-ID: <59c0b17a-491e-48ed-840e-7eec1c2d1de2@gmail.com>
Date: Wed, 30 Oct 2024 22:12:38 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] pack-objects: add --path-walk option
To: Jonathan Tan <jonathantanmy@google.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, me@ttaylorr.com, johncai86@gmail.com,
 newren@gmail.com, christian.couder@gmail.com,
 kristofferhaugsbakk@fastmail.com
References: <20241028195404.4119175-1-jonathantanmy@google.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20241028195404.4119175-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 3:54 PM, Jonathan Tan wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> This new walk is incompatible with some features and is ignored by
>> others:
>>
>>   * Object filters are not currently integrated with the path-walk API,
>>     such as sparse-checkout or tree depth. A blobless packfile could be
>>     integrated easily, but that is deferred for later.
>>
>>   * Server-focused features such as delta islands, shallow packs, and
>>     using a bitmap index are incompatible with the path-walk API.
>>
>>   * The path walk API is only compatible with the --revs option, not
>>     taking object lists or pack lists over stdin. These alternative ways
>>     to specify the objects currently ignores the --path-walk option
>>     without even a warning.
> 
> It might be better to declare --path-walk as "internal use only" and
> only supporting what send-pack.c (used by "git push") and "git repack"
> needs. (From this list, it seems that there is a lot of incompatibility,
> some of which can happen without a warning to the user, so it sounds
> better to be up-front and say that we only support what send-pack.c
> needs. This also makes reviewing easier, as we don't have to think about
> the possible interactions with every other rev-list feature - only what
> is used by send-pack.c.)

I do wonder what the value of doing this would be. I consider 'gitpack-objects' 
to already be a plumbing command, so marking any option
as "internal use only" seems like overkill. It takes effort to combine
the options carefully for the right effect. The tests in p5313 are not
terribly simple, such as needing --no-reuse-delta to guarantee we are
using the desired delta algorithm.

> Also from a reviewer perspective, it might be better to restrict this
> patch set to what send-pack.c needs and leave "git repack" for a future
> patch set. This means that we would not need features such as blob
> and tree exclusions, and possibly not even bitmap use or delta reuse
> (assuming that the user would typically push recently-created objects
> that have not been repacked).

While I can understand that as being a potential place to split the
patch series, the integration to add 'git repack --path-walk' is actually
very simple. Repacking "everything" needs to happen to be able to push a
repo to an empty remote, after all.

There are some subtleties around indexed objects, reflogs, and the like
that add some complexity, but they also are handled in the path-walk API
layer. Some of that complexity was helpful to know about during repack
tests.

Finally, the 'git repack --path-walk' use case is a great one for
demonstrating the benefits to threading the 'git pack-objects
--path-walk' algorithm.

>> +		/* Skip objects that do not exist locally. */
>> +		if (exclude_promisor_objects &&
>> +		    oid_object_info_extended(the_repository, oid, &oi,
>> +					     OBJECT_INFO_FOR_PREFETCH) < 0)
>> +			continue;
> 
> This functionality is typically triggered by --missing=allow;
> --exclude_promisor_objects means (among other things) that we allow
> a missing link only if that object is known to be a promisor object
> (because another promisor object refers to it) (see Documentation/
> rev-list-options.txt, and also get_reference() and elsewhere in
> revision.c - notice how is_promisor_object() is paired with it)
> 
> Having said that, we should probably just fail outright on missing
> objects, whether or not we have exclude_promisor_objects. If we have
> computed that we need to push an object, that object needs to exist.
> (Same for repack.)

I think that this is not a reasonable assumption that a hard fail
should be expected. Someone could create a blobless clone with a
sparse-checkout and then add a new file outside their sparse-checkout
without ever having the previous version downloaded.

When pushing, they won't be able to use the previous version as a
delta base, but they would certainly be confused about an object
being downloaded during 'git push'.

While the example I bring up is somewhat contrived, I can easily
imagine cases where missing objects are part of the commit boundary
and could be marked as UNINTERESTING but would still be sent in the
batch to be considered as a delta base.

Thanks,
-Stolee

