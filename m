Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4574F2E6D16
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075438; cv=none; b=c9OIM7OgjLW+TWx47Zrs7hdyWzONT3eI5gLO+6TU+zFDVi+NaIaG4YiqBKEV/ZoyLMnyNLytftEvjykEvd7xWavVSv/sVWpiACmF5pyreKtMqYtofl5orWlUKYp42NALh/1XLBq3DIt1cnWuIsmw0wwPNuD7Plxa9ypIHm5jhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075438; c=relaxed/simple;
	bh=vDZQZyVgcJVfIeOCsVJR71BCYPFq5kfBPFaPzZF5GW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y0MoOuLsHWmIR05Hs5RlAJ+urgmV9pw04E9Qt4bpnVbm+pCW8x6GuKc5622feU9DfVBORIrfN8bylpYAAnxbCYaLGvLx5keTbg46aJaXXACyxZ/oM0OJeXS3n4f6OiapYytzzRAecpl/SjWDxhTKelnNXYi2C4UPNNLd9Cw8yI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M5NBk6Ca; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l2shldQi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M5NBk6Ca";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l2shldQi"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E6AAEC04A4;
	Wed,  9 Jul 2025 11:37:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 11:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752075436;
	 x=1752161836; bh=gFHLfaiHvyzr8H6l5keLKtnZqJbwGzMpwswXGxXC+Vw=; b=
	M5NBk6Ca1aui7v9177/GI0hkkXPa+CAsT3pHVtuOtLh0UJB4clEFcE8pAp+anKpQ
	ZTiUy01G5TeWTkbLbSGqGWxESv3YebPZsOUpA1kqEsKmU2E9cafc5BrURiho9XQ6
	CjFpJe6jSDqx8m3hk3WElDETo9mZdCVSoDPpOLbB79VbAO8NOgLR/iSlj21zPXhS
	/ku12XzLFKEgB5V7wgChs1fVt4gQnFH5Wb5SyjoGiYXRqbJSTUU7Dj6af0n/CO1d
	Y3tKKJzXcMM7RIvFluI7M4PeG/IP6/2CowKJScnHG285xFN80MGcziogb8VS+NBL
	mEq9lWRpAN7D0MH8nqcGHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752075436; x=
	1752161836; bh=gFHLfaiHvyzr8H6l5keLKtnZqJbwGzMpwswXGxXC+Vw=; b=l
	2shldQi8SIfks/hkrRpTNmPkmIcKLlODIzVzZ9O3GtgsD0WYZRo2fLazf0DolZPO
	4iCv1JBFStJhtFAQQmy0YqnFcdkpYaTZWZVlXEKrxwlVNy4BG9tvwlxTIAU059gz
	TIVpzErjMdQaqaip6QoxseQxAz5mrb5v+peeNpxlQGcbJA9zGrxIm2XMoyEbq6mQ
	iKjUrqxZXSuObdDBLsWXDaPiknZdTLfHdaHjhXY/c/IjIlI1Qtx4R+9LqO5iWQiB
	gHPOdYFD7SfU663/eywx4zcaU9zXNgXLIF32fYOD3zqIMkxKB9XX68vh0UK1PFpZ
	2gg2IYNoOFQKi0KxgblTg==
X-ME-Sender: <xms:rIxuaFE3c6R_4VI5Fhww7zdS0rlgDnS2iwEkf_UZQYXIHm4bWHSUXQ>
    <xme:rIxuaNlb6_nBKgQ5ybJP_gs4ROJ5CvHxqjl_wCLeI8CvkC6K4FR_novPpkA_m5kE7
    yFjU0OwFkmQDGsYcA>
X-ME-Received: <xmr:rIxuaAmVkaAmM253_PqhECYl3GrRyNFAh2FzdQFoT4jsCAKDQftvdzkjcB20l80C83sDzNw5c9upoK7SFo0RGw48LsPhzE6rGmer6TM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhr
    seifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rIxuaGsGkMbRYOXvrfJll84V-pTS_5vhyauVB82otx4HZ-24_k_FZw>
    <xmx:rIxuaLleTLDcE6Xzhwa1z0gnYlluemFWypUOyHtcW5dUQRDRxtirCQ>
    <xmx:rIxuaJuU_dvFpSzajtDgnoK0pKtKMOqhg20XrnZVBmYIBYZnxFo48w>
    <xmx:rIxuaJdIjkqOR67jbIbKUUGjnm9B5MJo7bHDKrUSGITrfxdrK1Ssbg>
    <xmx:rIxuaD2X7-067glv89eO7lnxf7hBhaDeO1HtHzUuJCLNNazn0DUFSARh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 11:37:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
In-Reply-To: <861e6166-bda3-41c9-b259-2e46a77b6d84@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 9 Jul 2025 11:25:55 +0200")
References: <xmqqplebzgm7.fsf@gitster.g>
	<861e6166-bda3-41c9-b259-2e46a77b6d84@web.de>
Date: Wed, 09 Jul 2025 08:37:14 -0700
Message-ID: <xmqqy0sxnzo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 7/8/25 2:11 AM, Junio C Hamano wrote:
>> * rs/parse-options-precision (2025-06-29) 6 commits
>>  - parse-options: add precision handling for OPTION_COUNTUP
>>  - parse-options: add precision handling for OPTION_BITOP
>>  - parse-options: add precision handling for OPTION_NEGBIT
>>  - parse-options: add precision handling for OPTION_BIT
>>  - parse-options: add precision handling for OPTION_SET_INT
>>  - parse-options: add precision handling for PARSE_OPT_CMDMODE
>> 
>>  Define .precision to more canned parse-options type to avoid bugs
>>  coming from using a variable with a wrong type to capture the
>>  parsed values.
>> 
>>  Will merge to 'next'?
>>  source: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
> Will send v2 shortly.

Thanks for stopping me.

