Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B928151E
	for <git@vger.kernel.org>; Mon, 19 May 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672861; cv=none; b=E2LN1YSL8syu37x1NWfXy6Ng4zi/5adAhFvWQxe3G4qmIcXvoo24K7jeb0c/n4E4+AufS/6t7fcms632/PZVogG/RRBYOQMrhkxo0/I+CTZV51IHOpNjAPt6QbSLeg2ndBbVC6hS92rIeNKNI/piofJ2NomYlf/vhS6Qri36jLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672861; c=relaxed/simple;
	bh=F7fELYX8e3bTHlnj21i3RpGjVj/BBRSjhxo0zXfgF6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZzsTViqsNcMnTzmRV080X1F3x/w4Eaq04PTMil+fqZvtPjMUJq/0fOjx5q42ERhfs91x73UYTD4uz5j3g9nLoN9dpiCVaGrCN/MXKv8Knh3t3z26x2NLXI01MaSsUW8U82b+BfdcixlfhcKgVQ/dwTvHnaGZ8qTvzmMPjaUitqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnSIN9BS; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnSIN9BS"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e731a56e111so4457680276.1
        for <git@vger.kernel.org>; Mon, 19 May 2025 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747672858; x=1748277658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LlzBnigZY+d8BWs/9M9sj2tPgKe2jl1jSSTiwJ61+J8=;
        b=NnSIN9BSBlls+lFKANdl+kncnsNkb3ppdbg+6YuoUdnl3YHY74Gkg/JEzWFn5PBaS5
         6H6QI3ZjQa1j5ROKpFop1AElXS4NEbTxu5htISY85FD2bK2apuSpet8G5U5RNlL8epM8
         dAxV8DAjoQNvXP/xv5jHE8A5gleLV1I9nqIHGCqb2OD4cTi4k1MtVB9JPYkDhI5d3x6N
         grCtXP0PUkVMQxGRqOCHd+lbxA2/Q32XLz8LNXk+0fakHevSfnhko2n8829FI8JhHJpx
         8iO+/wTqUs8N4NDOwgMTpT0pW4H7NCELQSO8N2pTB8BEjT51cdQKKvXVOf3zjtf/eF6p
         K3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747672858; x=1748277658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlzBnigZY+d8BWs/9M9sj2tPgKe2jl1jSSTiwJ61+J8=;
        b=gA0pV+kDx7rWBzAlrZfTKR1ELBKATN/GHimxeW3IkWzgXGtNfXalwp7hPA3/YL1TO4
         D1wCmU36zLlaA24pckbvC///ORf9TvHyiHPwooWtJPOOmx62GI1DUEawPoygJ7Qjtox7
         3GDcfRWM017iXgrDnPF99a/CQiy8GyEvh2OGPKE9Sx2e8nx8YmADeVZq8ax5k4RtBuPQ
         pZ24xjsYtcSxaUgRsVCsffVDPv8Wd0xFL9z4uwEVAYnlxnHxmL+F5MianeIuYUScuDCG
         jpWgpJWfnYemrfA+chM0lqUzTSWVS9vNi9ReMf3lSixc5/y6dObDDDJSrDvcalub7Nds
         OQGw==
X-Forwarded-Encrypted: i=1; AJvYcCV9WoRKHxMwwQNa8Egod9oC9kaiN5OvXtYeUK+OzSfKV7KX3qLSHEVsxBe6y0qVU4XB0dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj9J+IDltAxLWtb5f4NQVOMW45EKqC5CsXH0hSsCGPu64WcsUy
	k8aA3Kv0M3hrCBTjr2mG50YSUmPPsL5f+vq9GRPIDHGjGoOLNDN6ZEAgVpq06g==
X-Gm-Gg: ASbGncuJhzafIu+qLqR4fv6c/Ee/MRzgq80a9XGbqcaPOEMl+mDR345QIcdzMPa1Oob
	IYx0I7kuFmPmVbfDF4Zfk18NjtZrPmnJXfANYS65aXWI2jMkuBk4miPod9X/fr2NYnojQqIN+r1
	irXxfjoRcONB+eBdiEzmf/Ck92N3td26nNafuOCxbP3/XL/ADnMXjhe5CJVwjY3jmPOdeeHydWL
	Z+Ptf2KTKx0h0jjLUxftu8s79rGJA4hgXC3q6kCZO9N5mCEUk+K3JZS3LH/kQ4NYcinkApfqWEI
	jQWj+Sz33i4ClYOZZ4SK+wfL/SIT02Pg6CxTHxVMpxIq6zicEYUzCJh8xH/J+zOhb6sQnfl6a0k
	3joLDunBx4U2tjTB31vhGHRcyiZ6qLvdVSn9x5JxMGYyGNQveNA==
X-Google-Smtp-Source: AGHT+IEe0sdVzR6tDSQvXM1WKdouM2zmmNcMcfsV56jarZIjIrE3Smy4Jx2bA9N71R2cx6fM5GLphA==
X-Received: by 2002:a05:6902:230f:b0:e7b:9680:afe7 with SMTP id 3f1490d57ef6-e7b9680b0e8mr8470490276.29.1747672858395;
        Mon, 19 May 2025 09:40:58 -0700 (PDT)
Received: from [192.168.1.237] (70-237-88-18.lightspeed.rlghnc.sbcglobal.net. [70.237.88.18])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b6add03d6sm2778397276.52.2025.05.19.09.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 09:40:58 -0700 (PDT)
Message-ID: <88fe17b4-9e9c-47df-bb9d-ebd4101503a8@gmail.com>
Date: Mon, 19 May 2025 12:40:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (May 2025, #05; Fri, 16)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <xmqqjz6grtbx.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqjz6grtbx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/2025 8:09 PM, Junio C Hamano wrote:

> * ds/sparse-apply-add-p (2025-05-16) 4 commits
>  - p2000: add performance test for patch-mode commands
>  - reset: integrate sparse index with --patch
>  - git add: make -p/-i aware of sparse index
>  - apply: integrate with the sparse index
> 
>  "git apply" and "git add -i/-p" code paths no longer unnecessarily
>  expand sparse-index while working.
> 
>  Will merge to 'next'?
>  Kicked out of next and then is about to come back.
>  source: <pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>

Thanks for applying the latest version. There was good feedback
in the v1 that led to some solid improvements. But I think this
v2 is pretty solid.

> * ds/scalar-no-maintenance (2025-05-14) 5 commits
>  - scalar reconfigure: improve --maintenance docs
>   (merged to 'next' on 2025-05-08 at 1006cdd399)
>  + scalar reconfigure: add --maintenance=<mode> option
>  + scalar clone: add --no-maintenance option
>  + scalar register: add --no-maintenance option
>  + scalar: customize register_dir()'s behavior
> 
>  Two "scalar" subcommands that adds a repository that hasn't been
>  under "scalar"'s control are taught an option not to enable the
>  scheduled maintenance on it.
> 
>  Will merge to 'next' and then to 'master'.
>  source: <pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>

As mentioned in-thread, I'm grateful for your update to include
the last patch.

> * ds/path-walk-2 (2025-05-16) 13 commits
>  - pack-objects: allow --shallow and --path-walk
>  - path-walk: add new 'edge_aggressive' option
>  - pack-objects: thread the path-based compression
>  - pack-objects: refactor path-walk delta phase
>  - scalar: enable path-walk during push via config
>  - pack-objects: enable --path-walk via config
>  - repack: add --path-walk option
>  - t5538: add tests to confirm deltas in shallow pushes
>  - pack-objects: introduce GIT_TEST_PACK_PATH_WALK
>  - p5313: add performance tests for --path-walk
>  - pack-objects: update usage to match docs
>  - pack-objects: add --path-walk option
>  - pack-objects: extract should_attempt_deltas()
> 
>  "git pack-objects" learns to find delta bases from blobs at the
>  same path, using the --path-walk API.
> 
>  Comments?
>  source: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>

Thanks for updating to the v3 version. I was a little slow to
respond to Taylor's feedback, so I will not rush feedback on
this version.

Thanks,
-Stolee

