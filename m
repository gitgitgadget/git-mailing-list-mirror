Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91E4F4727
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370539; cv=none; b=W+RpMKiyLIegHU5nz/XjFc65Wym7pAAxDHbiIMqTUQuJ6hkRKiAT4MP/3pmRfkZ0afqkzGv2qPrwruKr+zOBgbiWP/SVuRORyHMBYuYJozxQ55L41GOj0nUSt4j2pK/JGLbtkAU5mJkcqg0w5WaQtxd8QZ7qOJz8+MoseTV2Q4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370539; c=relaxed/simple;
	bh=CYyA3WwMQGacOLEIYyERthWFG4sbGQAnoH/PldR9QLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dYZXW+OJzSuLAD4e9hA3o/Jq5GKNJRBPpiDjfdvIG781oXaOiam8FCuyFAD0nFpb+P6Ee7LGYyhhVO1ZHbPrmkbiyoPcGmGNA02dsDMoKabA4kmILgeLcVLnRlO9Z9CXioJc2HTinBgcwLMoE9ozQR16JrxHc1SaqFgdmDR5AAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3zf45GQ; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3zf45GQ"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3429bca3880so529796eec.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370537; x=1790975337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UDDIetQRKIs0XlqKaZ7iWmUzvlhldGKiUTvd2OgWPO4=;
        b=e3zf45GQyhvdXONHvqC4o8DIY+HTIcLppsIfs5fOLBsI9HJSyr9mzNZs81U/Is+CON
         yRJzJ/0jvR1MQqZtgrg+60TD5+u0i301GC6eQ7Sl5ziVEb9ejE05tb4UhQakPkvMJxNj
         8wXgZplrMr2ToTD0g8Gj/ZJmvCXXXK0toFPQhtoH6aAcvYLNAjo51dtehDke06QEuR8U
         kK0Jk/x80wboFfScqF0HTVN0hxO7YLfWSZBmT5hdDSMuzUYKAMqFpK7tWje/n5QXmN5T
         0aWKbmTAK+nVNQo3I79GYHEDZhUo8lGjTFo+du1wx5iHFarC8XsjSaxfSFr5d5SCbGv8
         7RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370537; x=1790975337;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UDDIetQRKIs0XlqKaZ7iWmUzvlhldGKiUTvd2OgWPO4=;
        b=BjPUAQVelgvPEezjfXHvyHa6frbCqgmWIojsTZYnrFBKJY8pjwu3I9qdQvJyCQhONe
         Kk149XkbIBnOz0HketZqeD73F1BfyzIvTDLAiEAsY4e5EQ1VejbY8xgQei7Z/l28E/LT
         cgw1PCkYPP0fdtU0ROpQor7cOmbClq2CerfNX8QJEc9gWCF3ASDT74LqbMMA2kAlBvdj
         xX7WlBkCYA+yM1VnAmKxbOyKobJTePW7zAhWVC62EhmG3+x/pX5bZ9/vZ+AwAjm1qD4W
         dt5mlbhrFGbI1ts7ds/PbFA0vTuXR6EqN9dg94ZwJRYSZJc+9m45dVlyvbaXMxei8GFZ
         4y6g==
X-Forwarded-Encrypted: i=1; AKwUvBwb/qhNLDjNTJ+T8Z+dC7JO3tU/Qvmrg8FcmiXxTU7yW8D9Fuy0dwkNFUsFjQIYezW8xjM=@vger.kernel.org
X-Gm-Message-State: AFuF++kOoc3Nn5j2y44LDaW3pPKieh9+2av+SxpvKSLpKIV3PeW6jvSS
	JrG7aUMr1JZ0dQogBiVfh7/pwXM3vFD4wdQMG8IfYPD6vycZRTHobcTVKNSACts+q1g=
X-Gm-Gg: AYBFou025ca77kZ48RIhE++HWxOtfMlP8J4YccN8W2KCOyZ9levAwCDgKUXTNbYByhV
	lVbHVg+U+FxSan5G4qIawSpXOBtELmlhz4CHvedsrQFj4/j4dZJEouUCgPAEqmzmMy/5jjtxt3Z
	fNdRyGBL9ZO0lto+E7exluHgJfQq2gSdx8QtejGEf34IRO74IPXihvjk24kKZgezFRUGmsUhTOq
	rRCKd7UEXO744Jsi/bZXA7R2J7ZyjhSVG8vYwMkooFGe6CFuBDhcYeR36bsvII7aytNC+y1w+or
	1Nbz73qyCiR913RDdHszQ+CK7KtR0cy/y4XQvRXl+rOycBfpuOL9YDuDOdtLikszL29b3kv8ddJ
	UYlFek1R3XV/dAqIYaN56PWoPpQoCR76VNJBO3aRtSkBEodUEL+FfEuUAGhG29rf1z9TBx6F3hO
	wzqIqgylBnqC0E4OsntYC3AOZJJompP/DwWvM6yDs4MU6Ek3ksZFCWfb4tSmKFlwR3e1EdN5Fuh
	WRIJ41p4PcCMqHiAwUcBQ6gSFJBZj6CiWsoJFUgN44DxWqYBJqd8Q==
X-Received: by 2002:a05:7301:4d0b:b0:334:7f2a:1188 with SMTP id 5a478bee46e88-342703c0f8amr1293028eec.14.1790370537323;
        Fri, 25 Sep 2026 14:08:57 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:a5bd:5e99:a91b:f02d? ([2406:7400:12b:61a6:a5bd:5e99:a91b:f02d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145d0fc9fsm8226889eec.25.2026.09.25.14.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 14:08:56 -0700 (PDT)
Message-ID: <d783ea21-12db-4bea-82f3-a784c428b712@gmail.com>
Date: Sat, 26 Sep 2026 02:38:53 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] setup: enforce repo passed to `create_repository()`
 has no state
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 14:49, Patrick Steinhardt wrote:
> 
> when creating a new repository via `create_repository()` we pass in a
> repository. This repository is acting as an in/out parameter: the caller
> expects that it will be fully configured after the call, but the
> function itself also uses some information from the passed-in repository
> to figure out how exactly we want to create it.
> 
> This interface is quite confusing, as it's not obvious at all what
> configuration of the repository is relevant. We have thus over a couple
> of patch series reduced the use of the parameter as in/out parameter. So
> now, the only piece of info that is still being propagated via the repo
> is "core.sharedRepository".
> 
> This patch series cleans up that last remaining part so that the repo
> becomes purely an out-parameter. To ensure that this is the case we also
> start to `repo_clear()` it as a first step.
> 
> Besides simplifying the interface, the intent is also to go further into
> the direction of unifying repository initialization in a follow-up patch
> series.
> 

The patches seem to be well-split and the changes look good. It was a 
nice read.

Overall, this series seems to look good to me. Thank you for making 
create_repository not rely on state from the repo given to it!

-- 
Sivaraam

