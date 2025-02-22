Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ADE1F541E
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740252993; cv=none; b=cZjsNUVFVlhNKnIm9XSeLwcfwFw8nVJTOf1lyXA1E8O/KZbHdrTJwVO8daBwtiGV2pSW7ncULWfEhNmSAvGNbOSbUZ6Mh0t/7cpfZ9ZeOAT8X4u59y4grJr4wog4GgzbYpWv2kgCTBm8fJuevN36B4vBky8fiOswV/muQBpVHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740252993; c=relaxed/simple;
	bh=+HBtruE4XKqKhmbZ8cipJjV8LsyimINpgi7KdOXc2uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoZuQsrDgtO06yihkV5Hwr158twMAuQNPhmRfSS3qT8x2Aqi81u8Tl1xaWwJWpcW8tcb2KFK2PeXK3V2scfQa0gmeOyK5ABrDOjsGRc3aIfD0Yrj1ZSSaAfF78vKIpVLTEMzmkFHaEvZ68V7dVWdyLqPv471esLda+DZ4ON2nCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuuFUdbC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuuFUdbC"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc4418c0e1so7346711a91.1
        for <git@vger.kernel.org>; Sat, 22 Feb 2025 11:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740252991; x=1740857791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MX9J414NfDl9qGc9pbbBVng+1NDEjRJu6q0e+eGyKqs=;
        b=QuuFUdbCVTxc2lkYhJpy/CveiRklrFHuiQV/CDOWwb6o3yriU6m1ZpZ71DV8J7ZhX+
         2DXhS+J+KMlfdxvbHhbYH52aObXUJEo/teF7SQxxDVTezxZqEYqaeaEG6MSCXakv8WJH
         H6XFgBlb4+gWQYmESTk50pfpawuZsQGcMrv48HTe3Xx8W5z5H+QKbq7KrzYdOGosqKCn
         a+GgW318wz4HRRZ1LUgqQzzwaZG6hdq3WoDQvmqItpTMF2ehuzh4kZ3sri2Gbetr9yNv
         ZpvDcEaQNjb13y0RokOeW78oIJrKSUSpJ9nZoQVKJrvrxNoh+H9jE6LHaQrccgtt9P8J
         Yy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740252991; x=1740857791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MX9J414NfDl9qGc9pbbBVng+1NDEjRJu6q0e+eGyKqs=;
        b=CGyhXuqoDpW1hRo1xPtBmPbrbvgUm/swAh8ELCY+DziVTBmxMND1+VIgB7V0bWCZ/c
         H+98HD80bQyScL+x9wVa0SJmo8MbqltF2Odydjnq9khUOH33rkiLwywnXaSP0UViobLz
         UvkXhScrQqnzB4esnu9uvDiqmMrSxxHPmPN8uSfhVP1aZ3II4QV0vGDLi8TjVs7rdar6
         Zs+/qK8Xpv84Eux+qckw7vqL0mh4TddDJZUERgCdkabI5Ir/kAYh/Lelu0p6hFofK19h
         7SEcV+wy7+zjd5cV2C9YopW9W+RCOhA4kQPZgPziwkBU/XZvxi6dJdzNpUFrjnpwrsxx
         YKPQ==
X-Gm-Message-State: AOJu0YzRHQT4aF9tL0zg7bDME7Dhlt0RLpMbhyrbKTZDdnhmbiccKIpJ
	pHzb5Mm+ifyvFvtwFXedFdRjNMB3iU/wrT0tP1TPDW6on40AXR9e
X-Gm-Gg: ASbGnctgl2dEhF+UwGRSHWKkYv0BMrdLEXrh/xMU2ETev+XqHE8BKm8BKW5pPSYrqWO
	VQtPG3JKnUV2n7FsTFr7nbZsntW8cduckKH089sajmKENaDyrV5AP5hVcui86kALW6BT6VfP0yJ
	p7nPVVdHba1CShEyDz+veFgbl6S6zl1WKv3b8LUOsMJmFe4QE3sR5Dd4TRh7Xz0LR+TYIAgiwlO
	6X1upy7hPo62m6OF2TBeIVPzEyrawrAsloQKtXOIIAh+6rY2sZA79v/cTkHbeUstm/2kw7uFmwz
	n5ZyDDR6yinJnewsGTYK6TP+GnKCSoRc4fN1uA==
X-Google-Smtp-Source: AGHT+IGb61YRVRITkA47+hUdqcfpcO6jLTyrW4G8cS3ziMaKggGXwJcoXmBTFhwgWuuhmD0BWUt71w==
X-Received: by 2002:a17:90a:d445:b0:2fa:21d3:4332 with SMTP id 98e67ed59e1d1-2fccc97dfe7mr19347263a91.12.1740252990636;
        Sat, 22 Feb 2025 11:36:30 -0800 (PST)
Received: from [192.168.15.3] ([189.62.150.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb088c7dsm3903759a91.39.2025.02.22.11.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 11:36:30 -0800 (PST)
Message-ID: <0256f214-795d-42a4-8319-4ba79777face@gmail.com>
Date: Sat, 22 Feb 2025 16:36:26 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][PATCH v2] merge-strategies.adoc: detail submodule merge
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Jean-No=C3=ABl_Avila?=
 <jn.avila@free.fr>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
 <70b76a89-00a4-4ba6-92f2-4fb46981317d@free.fr> <xmqqy0xz9nno.fsf@gitster.g>
Content-Language: en-US
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqy0xz9nno.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> And of course a 6-line paragraph is not large enough to put in a
> separate file to be included.

I'm a newbie here, so I can't have a strong opinion on what's
the best solution for managing those files. But, given that:

1. `ort` will sometime replace `recursive`
2. the last change in the content of this document was in
    f5a3c5e637, three years ago, basically copying the content
    from `recursive` to `ort`

it looks like to me that creating another file only for this
paragraph would harder to maintain than that duplication.

I mean, if eventually `recursive` is replaced by `ort`, one
will need to remember to move this paragraph to
`merge-strategies`, as it will be used only in the `ort`
documentation. On the other hand, given that this document
haven't changed since the introduction of `ort`, this
duplication doesn't seem to me that will be hard to be
managed.

Anyway, thanks for the feedback!
