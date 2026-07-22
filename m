Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5844379C21
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744879; cv=none; b=Xk3alNp8W4hRSvrQ8zLgdu6d1lPgfUoxyl3TsMtCToiernODqOJ4uzj71y1gqMEQWufW1TZboT7TAX6y1wwch9wwZGEMBl6VBXzCFl4qBt2X6ojU4OQuKYeSHXoJFrYD6wg8xhSMEnTNNWXiAIMW3aLgLNo+P+7G3LJ8uwbNl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744879; c=relaxed/simple;
	bh=n3AkiTx3aaw76jKmOhnd09iIWiN4erUMqqjJW06mYvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SPafld47Eu0ertT9iB1EoElQnFqCv60KhD6QvKHmzWch/+mPS2rlYQXlCpfluBt6svZnnTAM/tI8QAYW2Y0SYYBAspN44aLvpjU6r0O0MzddyNAETwH+z2ctw8BEpF29Aj6eFL6K+j8vn1/ZSkPX69jMWNWKYZTjACpMEV2uKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AVrkrCV4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cos8VheP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AVrkrCV4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cos8VheP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 06B55EC01F1;
	Wed, 22 Jul 2026 14:27:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 22 Jul 2026 14:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784744877; x=1784831277; bh=92IN65HunY
	VKqQ76CJEbcfyczErxrnxti7cpw9eHN/Q=; b=AVrkrCV4D27Eyjz+prA2V8Az6t
	3LDp/73LNvlHBVmnWfwDJmqgp2kqJS6YhdpHHLX1EZujPC5aska1syOTRZJOk5X+
	BHH+E4uX/AaailEKIqTOOT+PuKfuwi1SpLHvEiGIiOyqamouCsCPXVFLiqDSL9mC
	Y3pKmNBrKM8oqk5bFtyYypdfVIWOmHeFth47S1/JozZ1KHaQkFfWelBLfv5+O/lB
	d8wS7K+r+4avzjPCie3+kcVZItFxlwwh2j30IxyZFZr/1S6BuZtKGQIZZ4Qoxh94
	BNIeEhbSqtgE62Oo0Ke3KaDdkTIfvA1ud59tWTw1O3SZWPjEhh8BvTlcaJbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784744877; x=1784831277; bh=92IN65HunYVKqQ76CJEbcfyczErxrnxti7c
	pw9eHN/Q=; b=cos8VhePWi9S8cZzfadROMDAGZrRPYCEHEDXxE/ZxH55q3NOX3a
	E2CIgJNvyr33dudIXp7Iz0REfKH2zxtQonePmW/3NrCBKTRru4oLZWpLTPmEkCio
	/GR4A/9gsqDyA03RO3JV2iAYSeLO+sSLqc7wyW+iI+jL5wwYDhkzIG1RpeTAfX95
	BmpBGo3MpDCpTOQegPE7/lwPUgoGFbfP+kA2c4sRZxgVp6NLUnPwM/AYEv10Yd4z
	vFa76Aww/dIeYemgH9385d0tRUpGaxNV1gUFMjuJHIi1YP4HDRNBkAdEkIrYWCwf
	T6Q+C2BLfbSZTcmA+y73+GUR4XcsyJuKHqA==
X-ME-Sender: <xms:rAthah6tkWrI2THl8MfxpltD5KiQ3oSEgCGrwSi78pAG2oaZMxgyAQ>
    <xme:rAthamWhCY9bUsLBFiXb8xZc_sGQg2W1jzVKB7lZTdo4GZOlnykvxKNt02wPcHqIL
    W4JYfvTqCL4YMd860ZJaO-J78ddVUyA2tcENzZsIVHJJF4f-UUS3g>
X-ME-Received: <xmr:rAthal1-tCH2u1m_avKX0mnLQEbDEZl5zQDCXsIKbLhhccOKncGPn55K6gJLn3mGcCxK6CZ_HypWbGhE7abKby4d0eZIjScvxw>
X-ME-Proxy-Cause: dmFkZTGgnYkoMefm+I8RrtwscZUHNMpJUakEZQBXAujj4pV6KEUDNhzBGzj9R/VrvF96U3
    TouIRlEFPwIQp1gfsOQ3dUzfeMKb/m6NqZreh7xuG1139AEmfRxM//Z5vtXbdKWtIzuCbj
    Pw824Mb3cSNFJsvNYxWn13Gcwdpoge/HMuhTPFPSLSGM98rDDRB+6PUsyrDEZFpzR2fJAs
    j5ll2zkuFXmovwCnJ6pam6BucRRzqh/sce03NvtWI1bhlGjpd6tX25Hr178NfRd5fY0EWk
    hnI7s0CtlDauIqgYbjzKn8GptHB28Q4R3oagWKog9AgNouilYiyA1EZGu2pfwTTvO+hajw
    rVNR0CRmva+Y3Fvp7O5qi9L1n7mmSkjg0ewFYOcdHqHzoa5akSkCTgbbMn1vzsYwudh0/J
    8PMLCYOWdbJSxkfzKoP5soHDRuUkCE0+24Q8F3hVcFJuwQwQYpK45DWMHVhnJ/FCvZNsFt
    AAB3BBODPMCE7rjaFhiXVZnXVsTlmBkxGvvEIknZ7CfC9yskm/PceX2aPGY7TC0ELxCHNn
    8Oe9JxqHUTX3tOAcmRn6sVexXg2NLDSmUJye289piWeTYygYR7ZyttKiFhWIN/ffTeJxIv
    yB3H4ZAknBkFtsoU5DmPoq7xHFHtL1CohcdfttGY5xoOGpJOXi+WM3nnh1vQ
X-ME-Proxy: <xmx:rAthaj3f549KPqiC24EAAZvLx10Uoi7QaukiODj5yb_5GfGkzsbHKQ>
    <xmx:rAthao9W6LTFb4mv-eZWbRdQEFY7puA9aC3T3KHJLQhjD15Efs2rpg>
    <xmx:rAthag3WFp3rm11v0YUZgzzQT7O6GJisWSpaMILOKguAYxuFXgwWPw>
    <xmx:rAthal_b126_KXAy6axQCd7ChqSxe0WlftZzEM6pGepP-8DCLr83CQ>
    <xmx:rQthauUbhMZ_fnh9CL6Vw-NOQoCWszHFbYv2C2GQQsFn6DqS6I1H_7HJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 14:27:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2026, #09)
In-Reply-To: <CAP8UFD3qTPak-RGtJ6cG7JkvX3_NZGHUB9N+rQk8ea2S_MDssA@mail.gmail.com>
	(Christian Couder's message of "Wed, 22 Jul 2026 11:02:52 +0200")
References: <xmqqbjc19j9k.fsf@gitster.g>
	<CAP8UFD3qTPak-RGtJ6cG7JkvX3_NZGHUB9N+rQk8ea2S_MDssA@mail.gmail.com>
Date: Wed, 22 Jul 2026 11:27:55 -0700
Message-ID: <xmqqzeziop5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> * cc/fast-import-usage (2026-07-16) 7 commits
>>  - fast-import: use struct option for usage string
>>  - fast-import: move command state globals into 'struct fast_import_state'
>>  - fast-import: introduce 'struct fast_import_state'
>>  - fast-import: localize 'i' into the 'for' loops using it
>>  - api-parse-options.adoc: document hidden and OPT_*_F option macros
>>  - api-parse-options.adoc: document per-option flags
>>  - parse-options: introduce OPT_HIDDEN_GROUP
>>
>>  The usage string of 'git fast-import' has been updated to use the
>>  'parse_options' API for displaying help, and its SYNOPSIS in the
>>  documentation has been standardized to match.
>>
>>  Waiting for response.
>>  cf. <xmqq4ihyehyb.fsf@gitster.g>
>>  source: <20260716165517.433849-1-christian.couder@gmail.com>
>
> I am having a vacation, so I will likely not be able to reply soon.
> Feel free to discard in the meantime.

I'll leave it as-is (unless somebody else comes in and crashes with
the changes in the topic badly, in which case I may eject one or the
other from my tree).  Enjoy your vacation.

Thanks.
