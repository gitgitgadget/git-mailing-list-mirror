Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FAD3A7593
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558092; cv=none; b=cwkv9uEqiRnrB7i30ikb9EQvfFd/biUKbwYfQog9vk9+V5PjBAbFSTAT6dRiYdbrW3w1OXtZ2HJtbRV8AJck5u+zreNsNr94yUdOZIJkZZFmTDCWLNAPmqSFwtTN4nPiYIHwnv3gce+c+DqHvTIO1jJovl39q3NX6u1JmGAOlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558092; c=relaxed/simple;
	bh=eE4d2TGhUThiBUmldLY0zwOiq00dB3dcUAWCt9WHajs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTn+8CnDz/RG6SKNfI315MnBmZFi2V1iWt5VDyaY9baJe2gd0+7nnvlXVK2oQ11iCn3dPTtkso6078fOzaviOzzP27o1njG07wQFzqnEP/4wnicWcMcr99adnDWJpqXQbyzZmerF/9yGNiOK9CVX2JM8i1Cqs5IBk1tC/nGkiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEtbSH5/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEtbSH5/"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89c4468686dso18453976d6.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774558089; x=1775162889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2f2DHzfi/jAwb82A5GBS55w2QRF6DwnIXlPtHDWnhE=;
        b=AEtbSH5/vIn0rN8C0IpT0n4XUp4v8bDl/lH2Ybsi9VJ3XJJjcCRXDJaEcjZ0K7qJDi
         pFLw7wIEt+Muc9/ptXmQCVNzNuFBoEeerj/L3NA2N5n4z7dEp8i+PG77eLmcyw7/ldbc
         /nibpHeYQdMnd+auPWqCa+YSDJJC+Tb3YHX6BUp21+a4UBqLAgSfqmC7BAbQIZGjtz7i
         /H0e/b71SZoXnHCxtQzq8J+FW/hmdbKZwp/3mXLb+EVdHFd/KYppBrCMezaW8LE9kny8
         b7Wkpasfzkah1nejO721RRJs9We4vyXHk4Gp620930MjZR5d29TT05S4czhdtj3KHcZc
         1+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774558089; x=1775162889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2f2DHzfi/jAwb82A5GBS55w2QRF6DwnIXlPtHDWnhE=;
        b=k+7s06siALR/ViF+zWFzoZ5yQsJHtPrWNj5OqVtV5JN26nxnDfbuVvXtWpYgncsfBG
         gYuGtxnWdlvgvY89RVWyyL4j7Mc51dZs+5mdfRjZwEZKfvJlgVdMvMY2iYLEg9F26M/4
         N8gsgppP0X+h8VpiUgs9Rou0YvRRVI96X7zpvBhpSbjitMlfJJqT8BucpqAjbrsbkT75
         nszBTAR1FI4pR4n29HeWfp4DuyMj+68ax96H+/qz/Owk7+8rB7MkF6pDJTWK3RqTer4I
         egcahWfz0dG/cPERONxnjSxUbUYRM1p5P5ul1IEzegZk+gvKXOTk1WEUG0c/vj3apfIn
         G9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWMGxLV//nRWFulWAtxywFOFVXDqhrjc/HFne+Ro5J7yuzC7m28bvJiYyxRW8iE4YBpbKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CflQJNQptBXUMHcKtMO/eyvk6r9lujEMWA3p64SEKwi1Q7ma
	hAu6gBybuFadGcJ7rluf68m6jpatlga+yhgwuLUsgKNBUjpx2DJU0bai
X-Gm-Gg: ATEYQzxkVKWdIsAjdJS4BKs2XZa3CFoW8DqmL9uMcnQVHF3hzyFE5Hbr02FMEif3BE2
	0P1Udg4ykA//bhHFiHiHCwnKni+jST92jpVpx4FkZ9CHCTM8jUdAChA1y3o3l10N6VArUu4XNCb
	nvhSlHKIq2R5aSz4kDt3jMtYW39ri84q1T6QOtttrD3oFCqbzc75dYYjBtogRplp/4b1iQoXIU3
	mVkyJaZ76BKBzjZgheDR2WnPw5zU8bxt7RVwEwqywgR1S/T479+myYWlOUdt8mqB4lcVRLNTHKe
	bzAgmUc0kE+Xncobzfd96B9ijksuQK2Pd+UIVbkCHyi1WMqWsrplR1xfRkmSFjf0I39gnpkhG4W
	pVZOF3TSuXNp6/RLg15X2c9g8cWlcQI6Q8cWTSMaW8om9gytdjLT9t5v47R5kbSilT2S+sC4jUH
	wogyWMLCoE5UvSvtqa/xJpV8mLtGtJ0cKl0QDXrMi1nLJ7li/YuTdo4VkEVxaYylCCidNGCg==
X-Received: by 2002:a05:6214:3287:b0:89c:cb1d:1128 with SMTP id 6a1803df08f44-89ccb1d1bd2mr116411376d6.11.1774558088987;
        Thu, 26 Mar 2026 13:48:08 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5aa2275sm32924426d6.43.2026.03.26.13.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 13:48:08 -0700 (PDT)
Message-ID: <124c202b-9641-4445-bb38-9cd70c836844@gmail.com>
Date: Thu, 26 Mar 2026 16:48:07 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] pack-objects: support excluded-open packs with
 --stdin-packs
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
 <e028dfbc9fb5f53d706b1cfb8ee0759b6f1c4575.1774482701.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <e028dfbc9fb5f53d706b1cfb8ee0759b6f1c4575.1774482701.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/2026 7:51 PM, Taylor Blau wrote:

>  struct stdin_pack_info {
>  	struct packed_git *p;
>  	enum {
>  		STDIN_PACK_INCLUDE = (1<<0),
>  		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
> +		STDIN_PACK_EXCLUDE_OPEN = (1<<2),
>  	} kind;

Especially because we're extending this, I feel more confident
that this would improve by being a named enum. Perhaps these
modes could get comments explaining their differences and how
they might operate in combination.

>  		if (!*key)
>  			continue;
> -		if (*key == '^')
> +		if (*key == '^' ||
> +		    (*key == '!' && mode == STDIN_PACKS_MODE_FOLLOW))
>  			key++;

This part is getting more complicated, giving potentially more
reason to start with a single branching point in patch 2.

> diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
> index 7eb79bc2cdb..c74b5861af3 100755
> --- a/t/t5331-pack-objects-stdin.sh
> +++ b/t/t5331-pack-objects-stdin.sh
> @@ -415,4 +415,109 @@ test_expect_success '--stdin-packs=follow tolerates missing commits' '
>  	stdin_packs__follow_with_only HEAD HEAD^{tree}
>  '

I see that this isn't yet the fix that turns failure into success.
I look forward to seeing that changeover.

Thanks,
-Stolee

