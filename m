Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB052459F8
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011680; cv=none; b=l5BJG0X8bNkvz/A4w5lZfdiX89Nju+jbGTuRTccL0F5S4M2gqqiGseMhsWuaeJ//jDMK4wqUDsddCOYnxDJSWODnt5Bw6v1aWphuR4ZC2ONoAUw5Sf1HCYE1kSw4eBmMmRsljEUu1A4y+bbbZvE+DzY+7a6PbXYnkrL2aNdDcfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011680; c=relaxed/simple;
	bh=0G4GvMSpX4k1fDAzlNkIKOi+6uZ10fy4ame1maLm1rY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=U3wp32/WkhkoEHwfFtdxsi2SkgW8gSN3T2vnzJ2Igv4l0ZG9IPbdVhZa0HiYAhvk8CTXZRZv7Dil67EP9YE/NnrgwUHKphvftGio5gm29lsfbAvnlbAsecqQXb0gBhFSe4/TadRA4GOkftDxQU8LpYsr/UJX/TCySFHlSTXkoEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYI07Clx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYI07Clx"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b87bc67a4so10196075e9.3
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757011677; x=1757616477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Gce6hrTk8dVe3AYigVque5IEO5zLv+22x+PIOyfzb8=;
        b=kYI07ClxouOmfyWKvUoGeBZ9gl8vwx0sQSuj8GDy1fJFB7xOiok4BevaIThvXQD7DK
         GY03fp+7bVnx9GWC2Z5K33qFt+gxm0ncVEWcP2T1ptDg7hktLPtrar5GvGiLwIiqhmvn
         QmofFR81DeXETpauScr2UPr0W015Z9lyH22Fjhsok25Au95EKjKSthpWRy+jm34tFMY1
         tjSIeMvd33kHh8wa02K/mZiFyymrW9XalkFErIjDVyTt96dxsIs5owAQ3joBLI4/akgJ
         Sg0F0MWSwRyJGFhosuuNICI/VwLUCLpbKKEmbJjsEYFiZBQUbgaOZsYXnwwE5oCBSnu+
         qWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757011677; x=1757616477;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gce6hrTk8dVe3AYigVque5IEO5zLv+22x+PIOyfzb8=;
        b=nX6wei1nvXDqGeLia2LWLIvJyK1j6fWKk/0jYveWDB251kTGJBWoX7qwOI2wlwIF+2
         hGL5OZUPPomnm54gYfgcbRS+zWcXWPWbDZ+Ero2Y9hy3LD4oLRN68I2g7j5UW5KYW8gE
         52Ygna51kPvQq9NifSXZRH8xa3XjGuX0RbGBkyMHWkWK0s+tH9P5vSsGSJ28qYGvDhoK
         HUzngyhKZEwuTsm55f7ZMcO1+nnQ4jjXZxKZJ7Omhm54+LP4G14WE2acJ2oHZmapAS0N
         Wv0r//7j7YQciUjekqn0agySWRo5f+lNJ2WjhYxMi0F98XVsHwPbovys70AugICfDH3w
         UF7A==
X-Gm-Message-State: AOJu0YzvkbNWAlPiph0WUTzMng0idTUBu3i3BknPVCIQ9c+NnyoHmO1h
	F1A1m4TTjUW2AEmVcKGVN2BNtvP7WGOHjSTvKzkOG26ZHTwKdmsBLyN4
X-Gm-Gg: ASbGnctBICs5MpCf2UHIPIeF9q0jHx7QpytDuc9bE7lDVVbNZ4wBsYrWoqMIqFZwBmt
	HzLCMdqpVe74+Q1w+bs3EQ6MGJEQz4JF2YTIHEmlTJwJgTppCCkJww8y7odR2S1vu9SszovEBax
	Mk6YWzTPTvs8dQg5zY980YATBRlE8AUi3jM4bmp3ocu1xTry/LZwfOw6wYPwyHyUTELHj6S5alN
	ZiU4/30wOSQ6sJiE+M1ELOLvI546k2tkxeAzZz5PqHL4BevXqRIFf6zx4cfxaAMCfTZziCxJqMJ
	B3pECx3MqGF2GNezl+c5oOCT2G7aHsjrKhW8NaoKoyazKX5DK5qNV56FbzEW0oARnSg3aQQEpN8
	T4178n4uiXGCh+RLV2znxBnmje367mbcUjp+KfTk9AT+LIEm9Xu2YgZlAmWGwla/AW45vojGEGA
	rNAR9aW3jOIkJNPhg=
X-Google-Smtp-Source: AGHT+IFYQvWYF1jVNIpsMDbXnpGsXIKyoOFMvn+uXf94+V+pg+3GosxnO7KOff+G2E99c3CgUTeX+w==
X-Received: by 2002:a05:600c:1d1f:b0:45b:8f11:8e00 with SMTP id 5b1f17b1804b1-45c055e1774mr75772365e9.37.1757011676782;
        Thu, 04 Sep 2025 11:47:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd074a3ecsm22195125e9.9.2025.09.04.11.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 11:47:56 -0700 (PDT)
Message-ID: <cca02e90-a7a1-495f-94e5-426bc0c5f13e@gmail.com>
Date: Thu, 4 Sep 2025 19:47:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] breaking changes: switch default initial branch
 name to "main"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <cover.1756992089.git.phillip.wood@dunelm.org.uk>
 <xmqq7bye9mla.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq7bye9mla.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2025 18:03, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> This is an alternative to changing the branch name now as suggested in
>> https://lore.kernel.org<pull.1961.git.1756183921623.gitgitgadget@gmail.com
> 
> No reason to repost, but for those who are reading from the
> sidelines, the URL would work better with "org<pull" ->
> "org/git/pull".

Thanks for correcting that. dscho pointed it out last time and I'd 
forgotten to change it.
Thanks

Phillip

