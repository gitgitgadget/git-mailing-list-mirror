Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43230B521
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783100301; cv=none; b=ujDjL7TsUT5wrWqAqAYI6TWMo3xu2+JElt/raeaMUFmGQejg72A2+RYGbLIMJVdwZZrKxC72Wwqh54dShK6j5D4kjCgU7XWky6uJwWq7sXRoEZNWWXUvhXSRTcra8mDR/P+KQtZI9kKMxGXGP3UR+wuD1MwaH/pQVXAlrKvLmBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783100301; c=relaxed/simple;
	bh=a6XZBNZ9Q61D6EirJtGJ3+pRZcC9UVDQEnBAosdeNh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IGKgNDl3rTbBdwY+tkPluy4UOZe+G80x4v3Q4tCKDYesu1cQ7GfYgHpCVMwDbNhXEsvsTI/6YaKNaJ+wLELgcX7ouVUV4aEDJQ9urjiQFmg71mtteiTeb86Ky02/NR8FZNhZ8aO5ZrHiTJi2VIRQeriQ32CxXAt4XNOXAL+d1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iQw4HXcx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eISLkKxH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iQw4HXcx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eISLkKxH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C975B1400126;
	Fri,  3 Jul 2026 13:38:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 03 Jul 2026 13:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783100299; x=1783186699; bh=ez2KrWOXI0
	UZZmmR0YAzapptKjjVYCzVA23EPxn1sEc=; b=iQw4HXcxr0lS5betJL1LmH/9eB
	vWQca+8ZLye6PpWROpyKBuBEKLwC6XQ37IgJqw+K9L+urjp6wjYjA9C7sqRM0ArM
	nEKKNlPftpASjFHexPZNKgOebKZrLJXa8Zn/YmUwtntZNEstnQsFIJCzKezwwbDT
	+nzZhfmp14hwb5b4snHCE2wwh+iv0pva0tLQa8O2FDgYIXKIVetJb6k4DIo0d6L3
	qn6TVc5cqP2jOW9YyLqT9ACy8aZKnYdlegGtWlfZwql1K4j6hr08ufpKbk2bdZS6
	gOHmO5Ba6y0UL+zySdtx7K0puk5ANO2rITA2x4d0U446kBO5Il3qJpdon1vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783100299; x=1783186699; bh=ez2KrWOXI0UZZmmR0YAzapptKjjVYCzVA23
	EPxn1sEc=; b=eISLkKxHMZOL/2conOIpMOrUaTcfE8QiuKI8V92NimqTKTiQb+v
	L5thume5fOyVxJLuuK3mH7vysyrAOJkMI//peWGWDQo5UTiKX1/lxntjKEy5drPI
	Ob8VukUx5SCa7qOj9ktQH6C+SfvDwv5Dwu/w4SKYKrVKibR18TY/6qVClUf+5BBr
	sc387d8CWYwkuzdxLv1q6upT+Rf3042XWmupEwh3Kgkx2bocd2rQ9K7bHGVqALls
	/NrYJZSns6trqG0wd2fDHKNDxr3Le0Mp3wJRS+HOl+QDXgzDzbNq5eLmQY2Rw9Lu
	kKQSuGe9vQUFCWIi/XraqaIKTnbXV1Nws7A==
X-ME-Sender: <xms:i_NHatwt2SvBUanSFzPyQ9z9XPR7a7pYFUxbuV1U866j6FT-ZXOdvQ>
    <xme:i_NHag9w7dCMnUpdc8e0ZCYwU8OeqdgDe03S_tQBleBNmiVT3JNCbesOXZqm6duiz
    MfHVjMSM27OwXTCGER_Gu5gpgGUv-aObJSB20u8uQn0L-Z-HjRBtg>
X-ME-Received: <xmr:i_NHahKLXeCUh3wAXsSr8yESChPddsn3i5C2MzjW3TDSD-00b7dr5yUTvtLpXy5Jip4lRCvQoaGVO2BMDxcjvq2xWLjVrYUihZE-TgI>
X-ME-Proxy-Cause: dmFkZTEF5BvGxsSsblHdKFgOM9TrorrMydUZ3xC7OQRzB7rPI5sYJ0RxR5bwZcu4SwCvXX
    S/QLBx0+NjiWkE3VRdA/cTg95M72yNe5iYzHNeX1JYVOOggpgMAvgwCu0JTYW3Cy9/Ezy3
    HVUJsAwZDEFEPfw84KsMVOrF7T76ylEc85vsotlng4+FUEJdpkdMAzFA1LT0+H0Xuo0M2X
    knMuFlwccTNqyzQEroPhryu9qkRK3A+r00weWayW4d+R9/RyY6rE/dlYsO4iumw+Um4d1x
    e4Lo2x9S9QntxLySRG7Brbm8bagknDlmg692vvRjAqSFbc0a1hfuijVCJWWXjHKLNAWfF0
    CO7X3ZDMBYrBxJJGXPkdABpwJAoOl1QghC2KDpgJOsOUfTJmpd1lGbY1ZGMsR37sWux44O
    p0emlHT+0h1C+hA8Qxpo6H72A5yPEKbcId1J1Ab8Dut7QMmjjA7rFLCv7tl+KG91oP0aU3
    MKud87xkoPbOmyE61LttiZ6gtbJYU8iQH1Tco7pBmNpboMBTf2SB8imFbkklZkcI6/qLlf
    3BKmfsh0QIPCgm/sVSchoLJnwqDpDVPanqzLpTB3sisJjAPf0jR8aIeIXnDE7roaGEN7R2
    rKZsKVZa73agzUwzwH/iEJ8lhMxPFQbuo+IPAc9Zap+E4Nz3vyhP0PQuNDWg
X-ME-Proxy: <xmx:i_NHamfSS0fv3wtgXo5vgtzuQzT1K0RKuidLxIl3anMZJ-uyVrdArA>
    <xmx:i_NHag_vuikIs1mpZVwU7vbnNl6jDTWL2VJ-_7XbiDjA4k2ERk-3Bg>
    <xmx:i_NHajpiY6pKNG0KjlPZAFZP9ZLSE-zGKefzVpChAI27GsnB2Ou29w>
    <xmx:i_NHalBlEb5AbkawSUtew0CPgcGFYnylMgMp4ZcqsedxX81t0hZW4A>
    <xmx:i_NHap462kIAKt4V4lkebKowy9I3cav6XCr6OxqYXMxNAp-Ue9_tTSXS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 13:38:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 5/9] t7508: skip EXPENSIVE test that is broken
 without SIZE_T_IS_32BIT
In-Reply-To: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-5-79076a7e0c62@pks.im>
	(Patrick Steinhardt's message of "Fri, 03 Jul 2026 11:24:08 +0200")
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
	<20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-5-79076a7e0c62@pks.im>
Date: Fri, 03 Jul 2026 10:38:18 -0700
Message-ID: <xmqqmrw8ht2t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

The same comment as [2/9] about 32 vs 64 in the subject "skip
EXPENSIVE test that is broken without SIZE_T_IS_32BIT" applies here,
I think.

> ...
> -test_expect_success EXPENSIVE 'status does not re-read unchanged 4 or 8 GiB file' '
> +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'status does not re-read unchanged 4 or 8 GiB file' '
>  	(
>  		mkdir large-file &&
>  		cd large-file &&
