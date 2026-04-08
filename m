Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF93D47AC
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670815; cv=none; b=bwn1Nf02hpBbtkQrhb7JvjnqBcz431KyyRuGz5AP65qspxXRJJxannGKwkddsrbKw5O3kTjth3CEws4dsum/JjS50LjUnOtDp+phemj4OS6RNBuekwstXxtCb+ndUnWUithZbLe7UuTBqlwLKqBMG5MNAKp9v9NWIFCWfdgLCBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670815; c=relaxed/simple;
	bh=qL/xtUQHIhM1Gt7VFE8QuLCY8KcLZ6QxSvliLV4B1BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A8Ylj1249kmEYIHV4ICo8WWJfEIWLRZpKl3+UbCgYPcyYqBhGku/0jvDOKYYA8aNHsNqB/TBsc7XNlElK3EiK6LbvhxOZWGaItxBkg8c5sAz86rAPqwfdE4Wc07AN2gAoajHAvGP0Gkbyy+47G9V6f/AyY5isTGYc+W3NHZqy2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FssYKqLo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FssYKqLo"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c76afacbb0bso269a12.2
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775670813; x=1776275613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPWMbdOQmsmLE7f1FM448wA65XH3YUp32I4Yu23zSVA=;
        b=FssYKqLo3WKoPZ6yixiH30T1Qik4880k/dRZFLkBlzSDo8wHTV+Lzl1/i5kg5ZGX6G
         Af+mMpQdjR2jWF+rW+pg+i/PimOATR15MyAJEyqSVcNO54edjwGuUsG7djFSVOPjiugf
         CH8p8adanrRb9GpnbjuOE8YwAL7fm6ue8pMfotUZKJTxaW1L30itdZU/xqFxeMQuBxmK
         rb0wV3Jz0EBq+WkRlz5Id+kU4G4wHQx5T/rXSSRgLOkLXbqGJ+JbxKq+oPP5vJDxXKfK
         GsR8RpBWKFSJzemIEblSBFZqC41SIWL8Pcf6mqjFC1qfp5xfvsRCAU2FywcnfiRNWvW4
         +bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775670813; x=1776275613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPWMbdOQmsmLE7f1FM448wA65XH3YUp32I4Yu23zSVA=;
        b=IacNKtsO9P82a+3uQn1iKVyNSKNjzsx//00CjmFIOkzP07OG+Kwh6fOGjteUKpQcmf
         kNwkVgIKqS0rqWhdf5Fc7EWeUqB2eh3JaOp5ClQSgJyBceA3ZOMUyrLvlDzcFShmC/4c
         /cE9QCAVdwZO9d23O9ifILIaLdVZJT5rnfhaIGnPylT3+9CYTV2OKssdNEYUk7HvBMvI
         0d45cDNhVnyZd+caajzGpdAmWFFvhJFRI1fxRhCoB+SKHjF0P1qWVvPWXm7l4EUOCK4O
         EEFKmFf8ylNvHcFpkQimTUKdNvHoFbHHsm3XbC/flNePBn+13E9muWIRtvlT1F4E0JNN
         nKvw==
X-Forwarded-Encrypted: i=1; AJvYcCXwbicmr/qTS9Wd+YhTYo9CLStSoitIrmzsTPeVRgX7HydWzBm6uBSwp4o52l9CGMSMx0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy573zA06kOoP5GBY/hlVR8GQZaTLet+rDUnglAp97C1zhyF+6k
	w8+wzh2HCOVE9G23hmm3YUSN+2xqBFqeq7R16aHgzd6JZPB/qDMs7g6f
X-Gm-Gg: AeBDiev89AIwjJklARqO89N7otOEUvtxVy1niJP+VZWX7gM2qz7/N35yN0KhJFFqjov
	htAc3WGsX9HURwJDfmfSXFY4EcGf6cMnfvanHI9XU0MgFRqOsAujArnxhdeXsie0SR+h0rUwW7O
	R8nxdcBHcCuYdT6k/YeBa6HwKskkiqQ3Vt9yp+VKoE0P0ePGnyP02CGZCNSg8hj71LcqFLGHdvk
	mjv256h2fVnObTgnUhG2tWM0divVCMAWzPg6685YPpRWnkGA6ojPfwpp/2Zw4Di2iDBaq2yMvOg
	YErSczLeP483/VbIw3b2+gwZ1Q8uGUAP5NLNQFL21DDXcIr4c01H3YxDrXASPTq3HYKaBzT5qHz
	nx4pMUaF1g7WXSOyhR4lkLpbEBnSA2R+/3Mh/uetFP864R9l8V/cEFm77RPBZXyFUr1eJa04fI4
	k3uLQwzYTxpj1/0CKG+XeHe55U0lo3VRBrFqdwGCQMmICOLePCnV0K7xv+u4uroEfHfjmzuv/6s
	NFBVksq4K0=
X-Received: by 2002:a05:6a00:2d25:b0:82c:de99:3302 with SMTP id d2e1a72fcca58-82d0da41d7cmr13505738b3a.1.1775670813213;
        Wed, 08 Apr 2026 10:53:33 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca1f28sm22331231b3a.57.2026.04.08.10.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 10:53:32 -0700 (PDT)
Message-ID: <84ca1cfa-a8b8-4426-b610-c9bc24843c25@gmail.com>
Date: Thu, 9 Apr 2026 01:53:29 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] promisor-remote: fix promisor.quiet to use the
 correct repository
To: Trieu Huynh <vikingtc4@gmail.com>, git@vger.kernel.org
References: <20260406183041.783800-1-vikingtc4@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260406183041.783800-1-vikingtc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/26 02:30, Trieu Huynh wrote:

I strongly recommend you to run a patch locally before sending it.

	 not ok 38 - promisor.quiet from submodule repo is honored

> +test_expect_success 'promisor.quiet from submodule repo is honored' '
> +	rm -f pc-quiet-trace &&
> +
> +	# Set promisor.quiet only in the submodule, not the superproject.
> +	git -C super-work/sub config promisor.quiet true &&
> +
> +	# Push a new commit+blob to the server; the blob stays missing in the
> +	# partial-clone submodule until a lazy fetch is triggered.
> +	test_commit -C sub-pc-src updated new-file.txt "world" &&
> +	git -C sub-pc-src push "$(pwd)/sub-pc-srv.bare" HEAD:master &&
> +	git -C super-work/sub -c protocol.file.allow=always fetch origin &&
> +	git -C super-work/sub reset --mixed origin/master &&
> +
> +	# grep descends into the submodule and triggers a lazy fetch for the
> +	# missing blob; verify the fetch subprocess carries --quiet.
> +	GIT_TRACE2_EVENT="$(pwd)/pc-quiet-trace" \
> +		git -C super-work grep --cached --recurse-submodules "world" \
> +		2>/dev/null &&
> +	grep negotiationAlgorithm pc-quiet-trace | grep -e --quiet
> +'
> +
>   . "$TEST_DIRECTORY"/lib-httpd.sh
>   start_httpd
>   

Regards, Yuchen
