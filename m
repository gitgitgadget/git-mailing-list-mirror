Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032649CF29
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944075; cv=none; b=ANKlUoPP8i4qrmpe/Xd5RFXoWZ64hwaVnUMy0E8IMplqcasF7L5auTek6eTPcKDle3Kj6DtMRmCrsO+occhTWRgas4SfiMXFdNnyORXrVSxVm21RrvvQ1XxbcG/WtFitCbJFqEaKC4jKMGxvBGOr8pB1r2lLOb+j7fYeYoL3nzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944075; c=relaxed/simple;
	bh=N58uD2Yr27qoxjVTzQb13ltL8yWuv3tt3jarJ3oblHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjmDj4axSnR7zvvyhVSe0AijpPKs/n+lKcg+F/Syj8yRGLuVZlZ9WXy22GEIdVQ2Tk1eX15W3oMrH4v28gGK4MuuJo233uMpMBvQKF87lNwHTRB2Dwbycg3pd9+5+SDFTfFzk1h8q2hgik8Wma+KQvyGHO5ZvdFspb6WJ1kSsog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9NVC4/+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9NVC4/+"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e04df8c46so6098186b3a.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788944073; x=1789548873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=otL4VAuXdwzbQdw24qhZV0FHht121KR+HfGcSvmuxPU=;
        b=a9NVC4/+D/uM3bwWYv3++ZZQbbxuNcIkGZWBhG6DTQZ2HTYQbeNvS6fqSSkzkiU/2i
         NVzz/nFi2ep361DAihhCQxqLDQ73z0cWE76RnyMeEq22e9vrABvxtTGl0IKglafPJI89
         Y13qDOOPRj3GCUHqlN4z8aWAaLItrKrL/omVid15N6ykW6o63yjELcuUFT2HRiUPQrvm
         fwiCTu996F6XtEtguLNxOjIL1tNpqz2EbGJTSNzr56zdsm13BJqUPQqQG0RzMn5Xl8cu
         4gGZS7Hr5em8FP8R6VxciVEi4qMZq3GeFX7OZ4kYMFg2bJuPK8cmHX4hgsRK4zY9putH
         4eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944073; x=1789548873;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=otL4VAuXdwzbQdw24qhZV0FHht121KR+HfGcSvmuxPU=;
        b=gyjXJFjLBS2K1ifiLARc5jPxX8MA93vD4G4y5Ke87c5t72VzAUCxjTvLQSe+D+at1d
         5wq6rSfN6kCUd+MYJEutfUiKw7y+LAWZugF6obdxTm/8RfUvvS/K3YmYzzEnXCbPCcZ0
         2rPWbSvVobK1DVD8G2RlxvLzx49o1q6ELPvTuFdO2if8bq2g0s9o7Xg+x6dDYYAQI4ir
         2BBZ4xJ0KP148p/ztjywWo+j0fHF16r9GB9E2fqPPAJnRjESXVaZhjWCpIqVlNzYGurk
         X90DKW0IQjXhZy7A+mCjFf7jzpi2aZPfRfd7An3TTeH/jBEpKs/frkeIjONGCpWd4DCJ
         ypLA==
X-Forwarded-Encrypted: i=1; AKwUvBw3ntEfKY8S7fcF0Z6gRfTnaSqBmiryniatJNPNDU0hltBSw6/1Dl3sQitt4JNMqSdcn8E=@vger.kernel.org
X-Gm-Message-State: AFuF++nIr6RgGrpF0kwoUI/E12/Be1AYsnLoMtqrcwm+tu1b/6s62jVV
	80Ko4wIGig+9q05JYw21Scg24u9u48fP2HXaPIw+ypXuxX0Amw1sLN32
X-Gm-Gg: AYBFou2OfL3LdaZap6wQMoAEU0b8V6LZBFCwIrxIlT+u7L1UH9VOvofRZpGuufgfRJe
	vhgE8Mjr5S/r0D6reTvIS5gjuORZnLwkpmaGU5q/lLFPTeTlV8zQpFOJlBybF4HncOs4/87hy12
	1urUSgCs5AWuVJhGkNii9o9R2iJoRl6o45f4SkImBmIbFsf3xAJu/j3g4MV5Mh9nfgNPKA04L2q
	YbCBtbRLXZpmawfWVWmqc1xXPL5bNsi7aEHQcqTm7su99ZLRCmWAQSZbnzE02qBDiHT8aNR+BmC
	qx4HxqOzQ/DHQsic6KPNtV5AWuv8pjZmw3lo5D9YgbLMPWDuT7j35q0XmKxsITpVvp/mHvqvm2V
	SNnoeHxG7PdwjhYb41IZCw89lxSyRsrenQ6v9OIS0ZgjLYQsVjUZ9B1hV3OflqK7GTisk8sVcIl
	/1Q61wMaHcp92wQqdiPu+ZyurSz7IhmfrllZRgIKMQ0qBzksL1fa4GQUEYABD2DvdrQHaGGLScI
	5k/A1CWzJD4jHFYZ635zVR0nhTvmpQIk/kg3HjOO/2cScQxhBLu5vs=
X-Received: by 2002:a05:6a20:7343:b0:3c3:88a5:83e4 with SMTP id adf61e73a8af0-3da39ee2718mr49642769637.10.1788944073220;
        Wed, 09 Sep 2026 01:54:33 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:e00a:2dbb:bdc9:907c? ([2406:7400:12b:61a6:e00a:2dbb:bdc9:907c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1434c745a09sm10637623c88.7.2026.09.09.01.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 01:54:32 -0700 (PDT)
Message-ID: <b2e0b347-5847-4ed8-bef9-441fc4dccd8e@gmail.com>
Date: Wed, 9 Sep 2026 14:24:28 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] setup: allow "git init --ref-storage-format=" to
 specify a payload
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-11-6733c90ca5b0@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-11-6733c90ca5b0@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 16:48, Patrick Steinhardt wrote:
>   
> diff --git a/Documentation/ref-storage-format.adoc b/Documentation/ref-storage-format.adoc
> index c5e29ec831..21d62557b7 100644
> --- a/Documentation/ref-storage-format.adoc
> +++ b/Documentation/ref-storage-format.adoc
> @@ -1,8 +1,12 @@
> -`files`;; for loose files with packed-refs.
> +`files[://<path>]`;; for loose files with packed-refs. The optional payload can
> +be specified to change the root directory where references are created. A
> +relative path will be resolved relative to the repository's common directory.
>   ifndef::with-breaking-changes[]
>   	This is the default.
>   endif::with-breaking-changes[]
> -`reftable`;; for the reftable format.
> +`reftable[://<path>]`;; for the reftable format. The optional payload can
> +be specified to change the root directory where references are created. A
> +relative path will be resolved relative to the repository's common directory.
>   ifdef::with-breaking-changes[]
>   	This is the default.
>   endif::with-breaking-changes[]

I think we need to be a bit more careful when modifying this ascii doc. 
This is also included in Documentation/git-refs.adoc and 
Documentation/git-repo.adoc.

We need to check if support should also be added to the former. For the 
latter, I think the inclusion may be fine since it is only for 
informational purposes.

Rest of the patch looks good to me.

-- 
Sivaraam

