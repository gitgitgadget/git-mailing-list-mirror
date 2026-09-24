Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAAB4CA29D
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278941; cv=none; b=REQ79JVI6coV+u6KZ2rSc9H0w0eEtHHN6fGxBWCKy+FvDa8x1UX59nor4cl8lbHQuPu5V1TRTY/fA2AS5cVsQsm7y9zroIoLg+VQcMydLI8wNXvEBV0rl8o4MEDJsrvL3ScC5YUMU0XflxnBO2AxAGUVRa85EgoNARr/CSid8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278941; c=relaxed/simple;
	bh=XV/SpcbRgbLsn0Q7zXhfMtvVBgJDBRdxSv4Umupe9To=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W9HPGyOOoyOqOqBck9wreUxkmaIkEnpF/1YqiZnmyotEIaL50hqC8gE0c0Hdd1rUw4TRp47XX03VUbRdXzW8oQamDB8xFwVTBMqkuSATtR/l9UAfYsKV33ngU3uxWuWnyxANqrvH7bvfiMygcxHicG9bZT4yLhPStHD03t17dhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d8xPB3wz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lqasMAyW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d8xPB3wz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lqasMAyW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EABEE1400039;
	Thu, 24 Sep 2026 15:42:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 15:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790278937; x=1790365337; bh=crl18EbDHK
	00C4EHAqehwYEGdliIT4eyLDG8wnKOqPM=; b=d8xPB3wzJ+MhN31DRKBunQC1nr
	kQEYKZ0qF/nECP4ck7jzosc4MBf/YYtyMKV4pCXYlu13Ro4I1lNdLEtUwCnBR5cG
	mLeJhu5NYa+B+VKu75lxdRclEX2WKHLobY8c96+/MQaVdVTZhGWgGZh+08QcLgFG
	/tn/ZzttCJZAxl0CBXE6UyPDPRF+dvcjwJWQ0ockeMG6CFkf2FrOQhyfnUW4yXKg
	cJKWIqFpm0rdqL/Nu9faL7GneeP1Jm2VnrNSh2lTXOTYveLUrzC2Qb4Y4UQOiUgN
	oVm00XpPF10G/UUgRy7v2rAinElhoGdhWiOtb4fsL7bck1UzxMYTuNDQZC3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790278937; x=1790365337; bh=crl18EbDHK00C4EHAqehwYEGdliIT4eyLDG
	8wnKOqPM=; b=lqasMAyWaeuBS12LQVDeiH/krC4WGozqct98WsxUF0rldzLjCJ2
	hNcGc/fh5vKcS6panF7WTKRJNkAhjAjcPF4nY3xsLF/6B5g/u1OK5mu7RCV2BOl8
	lwV492LTykoX+vfxg4Y+RPIvIweDZxsQXRohXaUMfgW5rlSatE7CXFa7SenKf/6h
	2q4ZgczIAzlMwGe9o3ksqwhmh2dXSO0HMTfJnYCvvSG4fTPdBp+3EP9GGGcyJwzN
	Cms521zh56Qa8HgTSPovcfrVBlL9fmTfKCKiwau8hrKmzab61dVNOOuD1jpGKfp4
	kGx7k0OTnxOrR8ciSlMWB2eJuIlpMkZmeVA==
X-ME-Sender: <xms:GX21aqIZTOJa7PnNOkKsaoECxwG0VCVC5d-c1G3x0f18ZbXrn_upYw>
    <xme:GX21apBc8_FAoOT653qf3nc-aRud2HFhu-WodUBb7zCToNR6GSYV37ArzfXWjEqrw
    rtQ2FXeKoaiuJZY1QUCV1YOm3F13-Q3p6fSu1zj6_X0csWDzDvnm6VA>
X-ME-Received: <xmr:GX21ajBcmoEg_Do8aSfCwVympQ9JV5aJL_IUlr9rTuzACsy_EarDu6hL3c9azZHzRj6cMI8eKCiBHLJTWeymYo_bqDRihl4VpXSa>
X-ME-Proxy-Cause: dmFkZTF2aIvMmWIcNsJhxgqfU9hz2YyuGCFE25Pr19z4W/zc81KBGtoiAbdE7T2MMx00FV
    6dMiehE57N+WocCB+IcuFaxur4TRCydqx47skgtpiOhpyP0/n8eLsVnaK2ueFiVWbYd9o6
    7h3JazJFxLkR6l1W0XoZgDa3IKNm089xmisqG4VjxnlUmX1F7RZM8MvoplnZO8BJxyxDfW
    mmE+IlASzabmiH+5K/m56m+GZr+yFzLmzUi/a29zG3pjV9tBsgrL3pOtYcC62vnRUiaEVJ
    o+uTJ/OetOEKBLeB8l3du6gjdoWMedjp8ij4koiygpkiMX7iGS4N9/28rF0eccy2aOgrI0
    +zX5LUW682Liho/UfgofD9M1ZgX/5ruBRsd/kimYqSES1WRgaMhcGVnNfL0UvEI4ZSLcXN
    cCQ0jzFgEQsDVayCy3yLz5yY8EadoJqNuyjZzbdEQGdgif9NnIUJpDEK0FE1xUoBK3XP5U
    JA5Ch+M0BG5NP0ptUvIcFqyQPvQr+m5HkBcNtpdXfpxLlbi9jWH+qFkPOzyueNuTn00NlI
    JAvuT2r4fUkhiEYYZ6h8sDNfnIaH4uxAcQcZwTLnW+sa6tEYOHQqJD6J+ZKmbN/mdPBBlY
    D82bM7am63ZNsEq6AqCtUqyu7bWTBPLZvB5rpjy0q5BB2Pazfl1qcNrNXUrw
X-ME-Proxy: <xmx:GX21arCKbf_gM-xSlYjAzVqObNd7vOhShmV5JwkLmIkak0C1n57qlA>
    <xmx:GX21aurpk9uPSU_bNb8tP8sNsHBLgZU8axI5-Q1hpX6roryUcmfBPA>
    <xmx:GX21alku1_Vh13QzPYbjyf53BWvtZSyzlpwfVqtxspDrs7YDBNr10Q>
    <xmx:GX21auz5hz62ykcOn1mMzrJMI4UBiujezom_n-_DKu2B3zTn6CnZTw>
    <xmx:GX21alMExsY4Dq2FBJzbX7Bwju1fvVEWPaug24GNJ19njgRU2ZYMDsAE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 15:42:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Jeff King <peff@peff.net>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] ci: work around Debian 12's HTTP/2 authentication failures
In-Reply-To: <e94a9d4f-567e-83a0-e12a-908082365e77@gmx.de> (Johannes
	Schindelin's message of "Thu, 24 Sep 2026 20:59:24 +0200 (CEST)")
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
	<20260923164700.GA28538@coredump.intra.peff.net>
	<20260923165348.GA29229@coredump.intra.peff.net>
	<20260923165922.GB29229@coredump.intra.peff.net>
	<xmqqwlsbc2ge.fsf@gitster.g>
	<20260923192514.GA43344@coredump.intra.peff.net>
	<e94a9d4f-567e-83a0-e12a-908082365e77@gmx.de>
Date: Thu, 24 Sep 2026 12:42:16 -0700
Message-ID: <xmqqld8q1lnr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I think you could argue either way (and I am OK with either, or even
>> just matching 7.88.1).
>
> I had GPT-6 dig deeper into the issue, since you're right: This should not
> be a CI/Debian-only gate, at the same time I didn't know what was the
> first version with the bug, so I suspected the version range to be subtly
> inaccurate. Turns out that the bug appeared first in cURL v7.88.0. So I
> adjusted your version range in preparation for the next patch iteration.

Great digging.  So it is between 7.88.0 and 8.3.0?
