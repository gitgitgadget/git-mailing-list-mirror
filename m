Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20F2FFDCB
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278631; cv=none; b=OBGghG5UF4S0MGJA4FAaWRE1ylsELkfMQLWeOJYfarLMOh0ECasfNmw59xHw2CcZjHRTrLZVqpLqXWEhNcxzVXx9DoUTIjEGAXLZkVtey+1jPW+KKeSifgzw0zCKoxFZdUHXn3cYSs6u9a1uZltr6j/5Ob1mtACW3NuXld0zZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278631; c=relaxed/simple;
	bh=MFUpicnfsdT1U1ka2rxrhyKTp1UEC8pJf4xHKo/0pSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kt9qAcJspYDocbBWS6g358Tz02hjiFg4JE6JxV+kcKK3mYTIRBCvxfm1HaGAkYAz7QOPzu+I3PPlRFPzwa0LTuKr+gB3XMG7icjdTtkz8aEaNiVgWcKHUQNFcxiw9maSiPbe9nobnslC0XzcuXw2osUOSV1aTm5IASUjLgiJ+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d4UcjShr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dESQTiw+; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d4UcjShr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dESQTiw+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAABA7A012C;
	Wed, 15 Apr 2026 14:43:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 15 Apr 2026 14:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776278628;
	 x=1776365028; bh=/egXXry34ZgcJOQQdvi0yHjfg7b8ili80b4lUHIV9XY=; b=
	d4UcjShrwWGlrXhAejLlno1OqQnC4us9s9fEwoowG0rZhSCR6/1w/KPJiPAG2d68
	AtiamZaFzvU5jvdUYohynwjI7wlaNEZU+XJBvvO7zr45Y6u4mvaa0kwwJeA16N56
	0D6iw8e2fRlZ2kMd6nZYQdjK9050fSyHubw43HBFPEqkaJUs2hLhpTXB/hRiLghL
	0y+XDyrRU1ViuOiH2OCk8HqLg3agZPk189+Im/y1t3qvKvzEilk2eedqvL5re4zJ
	7zX6xTA7bh9w3cPTU3Vv301lYPzhgM3/xBWoHKbVteTw5XP0+eGvBDnEwr1FFYYv
	UzfmwOuEmKdqXexBDFZURA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776278628; x=
	1776365028; bh=/egXXry34ZgcJOQQdvi0yHjfg7b8ili80b4lUHIV9XY=; b=d
	ESQTiw+7Wy5KxNrPphkvwOpsTeFM5TP7+aY0Bo5Wd+N3VgaSMBt7WDD6G545G6g4
	7h1SYenopea9w5TAcqvZPDSGH216mohTiQXefqxN3uNzBbO4RuGe7OqTGYZhdgqU
	NHnWwXTN1y6YDnRR90VaUagWTCaYA3U9+3RzHzmSLDXEY4AcRd26rb00A2uwKPvl
	DYhhKawMesLsuyDOR+0kguAJmBH8upDl/B6hXHXvcbwo9rfGj00tPp11FtHL4sK6
	Zbx9dvqOhkrb6r0yDv3oDqHh/IHmq/qo7g6JJNt95EQfLl9aZnz1tN4UlQqtdpS6
	CMwatjq8+7po95Ksaa1/A==
X-ME-Sender: <xms:ZNzfaTWEQNcJtPHxsHhxC1tv8Ym2v9IVbHssIu-2GeDxt470xFjSYw>
    <xme:ZNzfaeLIz6Y5-OqneJZEtYn0VjSmGF3LU6Tor9mj4ny1clcnvh1EuGE93jL-25wDr
    3ZFSRnlSicX5jGG8cs8a-PZ6zw2twpLXfEi_wq8ritAcRSDwJEh>
X-ME-Received: <xmr:ZNzfaTBpaWhuvCd4Ze7FHrLg-cUiPlQMtbrtQgncCtAqdWwMeFrBkjJMGrdatU2Vs3SguRujdSNbY-fD9e6XJqCy6zFEjkw63Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvghk
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZNzfaeeeL8_nWCZCifIfbM-W0dxOuvf0yy3d8MF-phtd6F7_Z2fHvw>
    <xmx:ZNzfaS1iflBaIT5kEX03N0pfBcPjq87ONRGjtnceNK-34NpcbbPLcA>
    <xmx:ZNzfaVjxIWtY0CLBsj3BvmNLRSf1-HkUZ008cmI0Vwy_LU7-u4aa3w>
    <xmx:ZNzfabnOb7KWmgRcnhwIFGOOo62ZHR7AxcgiYkQ7Q27uuVHf1KeLPw>
    <xmx:ZNzfaa6fAhRuoUaIhVRHlVcRHnf0tAQ4ryMCHhIU0iYvmTA2_q1aqyiU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 14:43:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <paul@paultarjan.com>,  =?utf-8?Q?G=C3=A1bor?= SZEDER
 <szeder.dev@gmail.com>,  Jeff King
 <peff@peff.net>,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v15 00/13] fsmonitor: implement filesystem change
 listener for Linux
In-Reply-To: <487628C4-596C-4870-A652-E1670C700AD7@gmail.com> (Ben Knoble's
	message of "Wed, 15 Apr 2026 13:50:19 -0400")
References: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
	<487628C4-596C-4870-A652-E1670C700AD7@gmail.com>
Date: Wed, 15 Apr 2026 11:43:47 -0700
Message-ID: <xmqq5x5s6p3w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 15 avr. 2026 à 09:27, Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com> a écrit :
>> 
>> ﻿This series implements the built-in fsmonitor daemon for Linux using the
>> inotify API, bringing it to feature parity with the existing Windows and
>> macOS implementations. It also fixes two memory leaks in the
>> platform-independent daemon code and deduplicates the IPC and settings logic
>> that is now shared between macOS and Linux.
>
> Troubleshooting a Gentoo build failure of next has me pretty
> convinced this topic is in there already. Junio should probably
> check my math, but I think that means we want to see fixes on top
> of that base now (unless we are reverting this topic from next and
> queuing a new version?).
>
> (The failure is a Gentoo-ism; we carry a patch that stops applying
> with this series. Not anything this project needs to worry about.)

I reverted it yesterday out of 'next'.  I do not recall I had a
chance to push it out, but my intention is keep this round in 'seen'
but out of 'next' until people are happy with it (which means folks
who test diligently like you do would need to peek into 'seen' as
well as 'next').
