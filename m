Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9833CEB7
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769751788; cv=none; b=f3Y6oHO82/x4zDx2qmm723Erpo8kOYIebed4rrcDC0MO/FmITgQCFroZgo8+Ru+ZqoQrUwxX+ASakg5wROYKl8/vNy8QXkXCodjgMPr4juLHlYsZMesynPyOZwWe1GjUL7FniZjrcx51mHtAIfyfW5BIc4R5Osx6IQn0lkMj6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769751788; c=relaxed/simple;
	bh=0IGFy1/c3xguAdl9j7vA8WBNxkaqzO4R0UuobJwxayo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=onpCIIj3LFvLQW+dvBH3lfQ4/swJMVC0mmPBS3RqRElWvRG3QByYUtuiMDwZLn5p/DxSaV011WH5sea2CoHUyyMvlD3uUGpz/kn/gl50qp0QiZ120aqlxsAh8I9UunYAp3gz668RTuGX/eG4IMQvl+hQBFx2hsdrM9czDAiKp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hQb+mMvA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pvnUBlNX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hQb+mMvA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pvnUBlNX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BF4E4EC0249;
	Fri, 30 Jan 2026 00:43:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 30 Jan 2026 00:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769751785; x=1769838185; bh=aVgMopbGAD
	jeYLELOjKc0SSp3dSOi5KWc1D4TuhAgdk=; b=hQb+mMvAr9KKakVb7/YBQCOKBX
	YLNn+MppWVn+wcD4bni5D4xmlQbO1n+TZ1bPt7pIG47o1Exztm/tjRS4aCV5lnkW
	4D7ObHfnezyc2yh46+9xFLHRLFvmnvWZL2K4EN2fBWeTExg3JsNKfyHlW7xQrkMM
	U3XVvU9cVVTz6EfRa5OJ/wKtJ06dP6CYkwSHJw8i4yaxypnt2IUj6xSuxa0G2C3z
	WqFHzX+AmQL6O34tTV4Y9r4vC3tzMJ5tzLluvIlOFeKLiVnE8e7qBQ4kLpprC07V
	7Ckz807Rl57CjiIS5i3zSfiCl8LlBNCGPlfKpWglQz6lH1yCDyXRDW4heVQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769751785; x=1769838185; bh=aVgMopbGADjeYLELOjKc0SSp3dSOi5KWc1D
	4TuhAgdk=; b=pvnUBlNXOZMYAchZeTvJlIpQmAkogqMNtp5q6ady9q15S2hpESj
	y2EEXa4fPWWsx896tsS1sxQkkHjXA0VW5fTYeXm4Y+TGxsoUaLfMwYni2OqnZZN3
	B/pvmWJXsbQHeDkRwxNgVPl0mY/PzOcB11ucFjgwKXDWAGJGuvf3RMoG/9xdia2A
	5yXNOyUVqJSRmP+sz64/7xHulieBUDzvKC9AWebGn7uMAeUQoKbOTEJZlyYUHBmy
	Hn+QleRG6x1WNs81/sn8O3aSApubQvkI6u6LAtjMQc1cgVnp0PfQTRU9dL6WDIkH
	Entuuw5K3rOqB6OsDxY7/OeeG9276JQbY+w==
X-ME-Sender: <xms:6UR8adG1EkjQ1Tr37xpxWoIsWG9paniRUAxPJdP-tGCTAmLyghFTvA>
    <xme:6UR8ad3CD_10rD5OK-6zzGB9ovEo186iePj36w-4EtPSnbT7a_UC6f0S7l7Zg1IvM
    PFg_yoSHlLpvGOLAAi-7H36bKlssndncBvzxN2yNAKuHzleQLyiWQ>
X-ME-Received: <xmr:6UR8aVmwJbjduGeKMYBdOpt6hNgK54Qox1No1PYTjeGMRyCnGc_DtrPlnN3fd1vXqVR86Jxl2vQcPUVS9gHwGxs2O-adeSbPGq19k1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephigthhhinhdrghhithesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:6UR8ad_InTlNbwAE0PHXLvPyYWzI9dwIP44vF6ilgwg4wmVUMu-bFQ>
    <xmx:6UR8aao6N94LVOz4msTnZJEypQeAWtPUOehP4HqbFCcnSI5Hj6VmjQ>
    <xmx:6UR8aWn-KRO9cR-WsSNVg9HanOhnDKAEawA37PXLi8aZURsb4pMaqw>
    <xmx:6UR8aRjqsHGDtNtp-Io9MJRDiTHowA-M3l3mJ5ZrbfAtnRhGhHF2bw>
    <xmx:6UR8aRU3bXqHeHN0l9gDK88FIbPbrAXU6DuxZp8uCozJgAyxipTz_FWR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 00:43:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Yee Cheng Chin <ychin.git@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Yee Cheng Chin via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using
 histogram algorithm
In-Reply-To: <CAHTeOx-TLwqbcdGcb2drD4vE6D3M93EPMjcAeTNR+XNTbmTVZg@mail.gmail.com>
	(Yee Cheng Chin's message of "Thu, 29 Jan 2026 17:58:18 -0800")
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
	<xmqqikcusn8p.fsf@gitster.g>
	<4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com>
	<xmqqy0llk33y.fsf@gitster.g>
	<3aeb49dd-8618-42e0-b9f9-6a4fb8065793@gmail.com>
	<xmqq343sjn4x.fsf@gitster.g>
	<CAHTeOx8SOZmqvi0pkcheSjFpbEALmOwaUiX0tKLmNP7fqvjMXA@mail.gmail.com>
	<xmqqsebo9lv6.fsf@gitster.g>
	<CAHTeOx-TLwqbcdGcb2drD4vE6D3M93EPMjcAeTNR+XNTbmTVZg@mail.gmail.com>
Date: Thu, 29 Jan 2026 21:43:03 -0800
Message-ID: <xmqqsebn8xlk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yee Cheng Chin <ychin.git@gmail.com> writes:

> Because of that, I'm leaning on keeping the current code structure,
> because it *is* indeed a cleanup step to be run after the previous
> one. I could still refactor it into a separate function and put it
> into the the case #1/#2 if blocks if you think that's cleaner.
>
> I will also add the above to the test case in v2.

As long as the resulting code is explained (perhaps in the comment
and/or with the code structure) well enough so that when read by
somebody else in two months, it won't have to invite the same
question as I asked in this thread, it would be OK.  I do not know
offhand if a comment with the current code structure is good enough,
or calling the same helper function from two out of three arms of
if/else-if cascade would make it even clearer.

I agree that the case you gave is tricky enough that it would be a
good idea to add it as a test.

Thanks.
