Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E0281368
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083299; cv=none; b=EHjvb6hipRQpmvounXtIFdL63+zopD9t6aRBBKFw3bfHLK6K8EarMeCBY99a67FRF/LM0ZOYO+Y4pK1exJVEk/G8yDuC079BbXC0msfzN112MuuBHGATi9aEqSrLBBDzEtJbbcJ70WYptZX32YSRhPgPF24CwX1SdepOfAp1j/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083299; c=relaxed/simple;
	bh=NdFF0xArfYWiJh1LPsKKAr5mQ4yZ1H++6MgZIk3ndnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tgli+wVik0vFBbauVwHxQ5v1278iC1AF7lRj+amPnkHZ2f52356ANUJEpNTME138OYxkFYkKPnaSCevE+lm0BtYqkVSuDKGGpJI9oEIohyAUoF32McY7ZYv690I/Z4impQa738Ni/sVYe1S7ChhiGv0GH44M3sl1GZbPKDVNj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G0iO5L3h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fU0UrXO4; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G0iO5L3h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fU0UrXO4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A3CF7A0097;
	Tue, 21 Oct 2025 17:48:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 17:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761083296; x=1761169696; bh=XLGwLZKDPI
	DQOmz4NOxUgzqVjivCBlYNpPH2S72UwVI=; b=G0iO5L3hCCbL7mWF+ozF17V3Ro
	wPfrD+70oUV5MVRljNXKcpyQf7EWpg6/+IUZisCZIp4sCQ4okfJjr1wPwH/RKrgv
	+UUud6QfnT2/wpmxnGUa/q60Wbw/ylQ8vB3kMY9CF3zFJz3HNvhySts1VcvcRyOj
	JbcjtL7YRTUGxY/wlROj/7BU6IPpnyUCNVKvIqoF4+5Ds/+QAxrVZj0TXTpC437V
	tU3oFboZVtx5EnCd/yrp/aZo8WkWNj2o3jhNlv0yMBGDnMJrGaJf2slTCZgbSj2c
	6bYkkMY/59v9/ZOe5RhJQClz3F2buzBl1TOI5E8ppvw98lxTNGYJQeqMRhoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761083296; x=1761169696; bh=XLGwLZKDPIDQOmz4NOxUgzqVjivCBlYNpPH
	2S72UwVI=; b=fU0UrXO4BmuVE4RREX+Ntw1+mCgmLUbDLKsI/b7v8+2gT6Pkkq1
	z5aK80JbOkGF/HkNMJKBQUZmULByF13+ofoJpuPzExYFqkPCf1rtD7HwzjHIJLCm
	N3SF0I0eFLRy8wWUFGyngIIcjnilwUCd+AeJzWw/HWz/qAQFm7eH86FMLeJHzf2C
	oxvy0CQm+KY/lWshQrnfp2olDsowL9mt4bSluH0vhtdpFrRoNq4pUj1FdmCa2Joq
	FkFUd0B5OjJXC29ouzd4+EbJF/JV0wehlXEKBzqsC4yqp8PjSCUWu89FmhzoKSRA
	AshKKSkIn3vxeby34raQil1NuG5Wme81k+g==
X-ME-Sender: <xms:n__3aEPWaYwvpBmYZaWfW58Mu4TAEek2bncQ3eeed3cSsvKCbiSTiA>
    <xme:n__3aCZkJjGWxYgh4B0xbjW-eRFlwID2g_9ZEAKpDVptbz5foa_3SEdLPl6WUfTV8
    x170ARfF0_7YqW2JvQB5-z6AjtYp28w5WDTgtVWzheDeWpU-ZMHbQ>
X-ME-Received: <xmr:n__3aIrQ2OajwZFO-6ymMzqpbVoOumoNR3LdpU8IN7BxQn88vbSXUPHfpAmfTjd2dbEfUPReFiuzg2EzM3SAeBNUzK8oOqGIj-BX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedukedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepiefhleejleelfeegueeiieetudekhfekgfdutedtuefhudetjefgveejgefg
    ieelnecuffhomhgrihhnpegrphhprhgvtghirghtvggurdgttgdpfhgvvghlihhnghdrph
    hsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:n__3aGZKr-mSD7Xbw53iM0tsF1n9MPor9PXzsxJvyD1DGTtXiGOxAg>
    <xmx:n__3aATN43Bgv_zv72Y6vVq0qbClzbrIGTIg_da-XZWgvl4LkqClBQ>
    <xmx:n__3aN5jcT0svU7G5Z0mXhHeKgN8n7BbVAF7xgnZpoUE7VQYFyeMAw>
    <xmx:n__3aFwDfAvIGHZmatZuYSsXJvTrqd6mLtGvuLAWU9yQY3FMtKy4fA>
    <xmx:oP_3aCjdlBviMlRiv6F9QdEqgYhESsYhp2fNfEPI09MRrWwXSd_aos3x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 17:48:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #06; Fri, 17)
In-Reply-To: <aPcZTzqCn3VeGwIW@pks.im> (Patrick Steinhardt's message of "Tue,
	21 Oct 2025 07:25:35 +0200")
References: <xmqq7bwpz3pf.fsf@gitster.g> <aPcZTzqCn3VeGwIW@pks.im>
Date: Tue, 21 Oct 2025 14:48:14 -0700
Message-ID: <xmqqy0p4rko1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 20, 2025 at 02:02:52PM -0700, Junio C Hamano wrote:
>> * ar/run-command-hook (2025-10-17) 10 commits
>> ...
>>  Comments?
>>  source: <20251017141544.1538542-1-adrian.ratiu@collabora.com>
>
> I'll make sure tho give the current iteration another review today.

Thanks, very much appreciated.

>> * cc/fast-import-strip-signed-tags (2025-10-13) 5 commits
>> ...
>>  Will merge to 'next'?
>>  source: <20251013084857.1646783-1-christian.couder@gmail.com>
>
> Should be ready from my point of view. v2 already addressed all of
> my comments, and v3 clarified the documentation in one more case. So I'm
> happy with this version.

Yup, matches my feeling.

>> * ps/ci-rust (2025-10-14) 8 commits
>> ...
>>  Will merge to 'next'?
>>  source: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
>
> I think it should be ready. The 3rd version only saw a single minor
> fixup relative to the 2nd one.

OK.  CI changes are easy to handle as we would know breakage fairly
soon ;-)

>> * ps/remove-packfile-store-get-packs (2025-10-09) 7 commits
>> ...
>>  Comments?
>>  source: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
>
> I think this series should be ready once the below series is merged
> down. v2 addressed all of Taylor's feedback and saw another positive
> review by Justin.

Yeah, relying on an in-flight topic has to block the topic until
the base solidifies, which I do not particularly like (as I can
easily screw up by merging the dependent and drag the base into
'next' before it is ready).  As the other one does look ready, it
should be OK as well.

>> * tb/incremental-midx-part-3.1 (2025-10-15) 50 commits
>> ...
>>  (this branch is used by ps/remove-packfile-store-get-packs.)
>> 
>>  Clean-up "git repack" machinery to prepare for incremental update
>>  of midx files.
>> 
>>  Will merge to 'next'?
>>  source: <cover.1760567210.git.me@ttaylorr.com>
>
> Yeah, I think this one is ready to go.

Thanks, concurred.

