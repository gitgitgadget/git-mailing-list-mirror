Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00C45C700
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193367; cv=none; b=dbvzJe+e7v9WO9CNy80tJG96Nfp/KwvIH4G26o6xNU0lS9pNW8/7dCQLVBREN0SlIQrnl2cJXi2y2EMlvN3dHftHjEIUrvhX0ABz6lzCOxMDW866xvG4kUDRRnpMtmuWUYVIOXUPjCek2Govc4aZHnsXMZut2APgHrUMSmf8vZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193367; c=relaxed/simple;
	bh=9NIuQgJW3DvleVfUY/DAXzNlNELW4LK8Sb37kw4iv9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+NGIcNcjg2ikihylY4gVq7UeSUuaXHBbxDrkH847r0R5+qtItOU4lUUddcSfFv/TCL1QchH70eJUGuQvvw5hc5AJgkayQyaSK4E6gps7yeAPpPJyQwOhFvakAACAnToHHf4iT7A/847Bfdd5LWYCBzNrpNdgdwnQZBAJ94WoUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKDUKF4x; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKDUKF4x"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so754029a91.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791193357; x=1791798157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CYjCdJc4kqNIlBmVEgSaKpD42iyCwjg6JQg6hsUBm4M=;
        b=GKDUKF4x3hl63u2SBVKpsNf1oeyIbm43NFtXU3ubL2bb4AVbVs6WXkZufhKz1rWgZu
         INSmGFlgPNrXieQBHt1M/JPUY3Nj+ENsMSmPheGbcdEubfPcsjsVtj+imKjdaej6mXJE
         hFv1oqpKMrL6Pr25g23U3ZvhAaT8OdCltNyEXraPIpBdibYdfuD3tmq2ZhUfsV7hnK9F
         H/CotdhuWQsxR0JlPhJGZTywvFUdC65KuhlnDKpMkgvOi14/S6CaGhZSYUJZvIlTgObV
         /lufd2vNP6+VpORNxxlBunYLkwiHYR791zlP+uNGC2SvxOxA2Q3dgL8bP6ic8aIV8ttX
         F7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791193357; x=1791798157;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CYjCdJc4kqNIlBmVEgSaKpD42iyCwjg6JQg6hsUBm4M=;
        b=H64J4YxmmPu++pOEHbmBzrkp4IhJyB3nxchcwXwUlvphYjSZoTluXxmDaOwKQeGZmA
         TyB8vdS9VLoaRT1uiVokDoO3sq40vwas0bsClYDurKMY4Tz2Yoc/KrdchurvdxCL24iz
         Y9aDWuplxZZ7i2xX7uO2nYwBR6D70EPm6k3Tev62a8rcGzxoMb0CS4YKQw1okqpzvBfE
         2v4XCr+I2yA4adqQl0Y9GTWEJh7RtYlOrr/ens5ILALAfQ1Xe382HcM2OEI4WEloLFGe
         cRGMJsZ1cr9BFZMlrnaBvwf0YLGYblb8ph0ewcjtu8NbHq9GuxPIp8zlyczqmU6PxAkX
         sDNg==
X-Forwarded-Encrypted: i=1; AKwUvBzorWXhWfnRTQ9ASdSCR6bXFBX6a7UHzRBirZVbSYKTLA2y4BioGwcbqisA+bvto0f5rBU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLszt9DIbEgaxMEwswcx+4UfQepyGaHBtoVcw+4AX85Y88nLxjN
	eyUztwQXpBkx+LYO3Fy3hbgJ30RCXlVE0TVDoWiqEcscI7X9bDCLDnm6
X-Gm-Gg: AYBFou2TYH+Ja0IJum15F2RKXKHjKJk4f2yj9Gdj6BEsgyn57peqtG/PGwrprIvHw2/
	lpFp2rtHFKczwiWnHnrM/1A+kocJjVjXljMjaDZe1VjBf5RYE2dDtEXsvz7+DvWoeqXlW9LKWNs
	/gIQki1Bhuw6GopYfUKWVEM9EEQDWXc/lxPLzc1U7XGMipraz/mr73YyjawRCL2B66MjqighjGM
	2o05TaqeHdfuI8WpfcV1yqA+8/150hLKBvnOluCpBlCWlFYjyqrxciZmwtu5UnDxaiJWzARTzoq
	u/Wli4PGiSw6PMMSsZDIK1qQxYws1VvBBbGSqltg+gMvEo/FFf1wqF7QYGFI+nWGtgeP36cbMjU
	49Oj3nmCJh4f6xdRC2OA8UJtqpTU4Sg822oiBlRsXqHpVNedQW0xmtAd4I+ZERrZxwX1IagCvSk
	5geBMBo/RB/5rVCm/rHIIfz3/dv4HAljm3bsIeuP9m5roLsTcBemGNS0vFTjCoC7rBbL7A++cre
	afbt6rGN0KCNA==
X-Received: by 2002:a17:90b:134f:b0:3a0:a912:e759 with SMTP id 98e67ed59e1d1-3a7872b17e9mr5432225a91.25.1791193357564;
        Mon, 05 Oct 2026 02:42:37 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d6b694csm10577127a91.11.2026.10.05.02.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 02:42:37 -0700 (PDT)
Message-ID: <3de4ba2b-9b0c-499b-98bb-7077e0d7613b@gmail.com>
Date: Mon, 5 Oct 2026 15:12:34 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] meson: update wrappers
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
 <20260924-pks-meson-improvements-v1-6-90b7f79f1c4e@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260924-pks-meson-improvements-v1-6-90b7f79f1c4e@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 19:39, Patrick Steinhardt wrote:
> Our subproject wrappers are used on platforms that do not have the
> respective dependencies available. Most importantly, this can be used on
> Windows to have an almost-dependency-free build of Git.
> 
> Update these wrappers via `meson wrap update`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   subprojects/curl.wrap    | 19 ++++++++++---------
>   subprojects/expat.wrap   | 21 +++++++++++----------
>   subprojects/openssl.wrap | 23 +++++++++++------------
>   subprojects/pcre2.wrap   | 24 +++++++++++-------------
>   subprojects/zlib.wrap    | 21 +++++++++++----------
>   5 files changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/subprojects/curl.wrap b/subprojects/curl.wrap
> index f7e384b85c..d73b88b75e 100644
> --- a/subprojects/curl.wrap
> +++ b/subprojects/curl.wrap
> @@ -1,13 +1,14 @@
>   [wrap-file]
 > [ snip ]
> -wrapdb_version = 8.10.1-1
 > [ snip ]
> +wrapdb_version = 8.12.1-2
>
 > diff --git a/subprojects/openssl.wrap b/subprojects/openssl.wrap> 
index 873d55106e..e775bb104f 100644
> --- a/subprojects/openssl.wrap
> +++ b/subprojects/openssl.wrap
> @@ -1,15 +1,14 @@
>   [wrap-file]
 > [ snip ]> -wrapdb_version = 3.0.8-3
 > [ snip ]> +wrapdb_version = 3.0.10-1
>

We are using the latest versions from the wrap DB for the above but the 
versions available via wrap DB itself appears quite old. For instance,

- curl 8.12.1 was released on Feb/2025. The latest available
   is 8.22.0 (released Sep/2026)

- OpenSSL 3.0.10 was released on Aug/2023. The latest available are
   3.0.22 (released Aug/2026) and 4.0.1 (released Jun/2026).

Is this version gap something we need to document / think about?

-- 
Sivaraam

