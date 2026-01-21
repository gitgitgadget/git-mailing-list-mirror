Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EBF36AB67
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012411; cv=none; b=DGKGIxJmlIyrA1A1Sbc1DvxYFiu6GoP5pB1gboWt6Z5p9N0PRDVgy5kpJj3wB3E9JiNH0mBh26MAUk7SYgPfXvN3zpKbQf9ot4FYL3V8UieAs1acoGAJjvAPg0Ln8bF9ymGHQW8yT5bKRWHQnG6RpdK9p3OzwV9XfcrccF+aLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012411; c=relaxed/simple;
	bh=Tbrt8tOOvzadoTAx6YmhlTvuZ7z6QF1H74dOBdZlVWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nuNWAeLfbwnI/WpRQLTRnbbSj86dVQTnoz6WXQL+W1q6xb0UmekSXGJ59M75cErh/faPOcarGiLREQm9SBRXhjDNYCVhIpEcBm3RfmNTOWs22k/BOCsBjIR1FrVmu3uLBSlzVFdEsbXQVxgtzzTSbaidrzI0ac83KCPCBRbRTbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=czs26LaE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQcPYPL1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="czs26LaE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQcPYPL1"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F40131400155;
	Wed, 21 Jan 2026 11:20:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 21 Jan 2026 11:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769012405; x=1769098805; bh=ljYDsmxtAS
	pIyrZIsNfe6rSgATF1CKQGvWGCNu+JQ40=; b=czs26LaEMqLAY36aMAWDfASu9y
	JEkfUHJarxXlzrQpFNhwDA40EqhLv0/TsuQ+5mJfLz2KrOoeJ14DUiKz3Z1dMqPC
	sYmSe8R7mDYG2JdZAK3+L0SLZ5HIriBqEZNkFcuS+HZCnvzgsHqG8+tIhLc+oyfV
	nQV0jwwhW6iixi91EobPb8ixpQRzNByLk8xgixwzFc8KmLW6vm5UsV4YqZwmj5Q/
	kTe4+kGyW2d8OXsri98/V/oSQsQEg/LkSMFdoRwxyoJ3Vl5ritpUL/yhvx8AyTuX
	2CZ4q75kZJCcZpWhe+7FGlGqsdeKi3yxAa/laeQZk20RQUbQ0c6JeMiFTMFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769012405; x=1769098805; bh=ljYDsmxtASpIyrZIsNfe6rSgATF1CKQGvWG
	CNu+JQ40=; b=aQcPYPL1iNLMJBWiWBM5+PP7Lnuz0UyXcIpZOEKG0a0p1W6vbhh
	0T+92P7OXW66Nooe1K1dcqfT5umDQFaQaTKHhNi2ez3A1UcKSj69e4K0/Vjj+tzd
	te9jgDvbg3Q8VZKhHLqC/D5ieMJN5k7g/K7oKgUKgrV/nHPrk6f3f7jAmqLXEOB0
	29FWoJkdVj9FUIe3y2dC/If107cwNQuvUmV1VkY8N+N5/OtfLKwMbGDL/BePpySG
	tPDrhmqn6pTO1BbXf2U3nMzfulFGpwEGLLfewYvyWcc4/arOYf/vk8Dz80GNbT4z
	eSh8yttJ4T5A6EdotU091o/Sm1avvMUgWBg==
X-ME-Sender: <xms:tfxwaYqi1wOS325ALTqFxVGsMNp8teP6F_NnIgn3NVSq-6y6gVn_jw>
    <xme:tfxwaVgXPf1O-wtuNjrIlS6To9EvirnNpb0RU6s_urTTrIQpn0KeNRm1cd_C_GG_q
    mlq4TBWLWANJG5tbMhA7CcjQ1pSbSVcuLMGnhc3IYmYbdzaPQvz_08>
X-ME-Received: <xmr:tfxwaViTLi7cyruNdUIuawnMpGE9nTg5SdW2k7mfyNEuMxsV_pAnZi58Ls-LYTePuUbFY4Uk9-prTkGmsG_HjFSeeFe1y152EagzCIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tfxwabj29iwnr9SSwYBB-npplEAS74mslkMyH5jEZ4A-27ox3uvN7Q>
    <xmx:tfxwaVIZhj114FcvORapgltYK5lun2tMrCxJf1W7Gro8EIzX9byNag>
    <xmx:tfxwaaHNbCSN_qcMoXib4OxVHKQGPPkEPWIm1NQDzRvE0ipcFLK7tQ>
    <xmx:tfxwaZR7t8ePJ_NVzAvKKQiT99DEn_ELiIfv9hjIelzu1iR4wn1ZGg>
    <xmx:tfxwaVVHPDYy1OxmHWHSru-zm0-H69UNr91uZ3KLuKnRshTxhF0KtEzL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 11:20:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org,
    Ben Knoble <ben.knoble@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Jan 2026, #06)
In-Reply-To: <xmqqtswfvvf3.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	21 Jan 2026 07:26:40 -0800")
References: <xmqqa4y832ok.fsf@gitster.g>
	<97d8645b-bae8-7f5c-8e59-0f4f0efd92f5@gmx.de>
	<xmqqtswfvvf3.fsf@gitster.g>
Date: Wed, 21 Jan 2026 08:20:00 -0800
Message-ID: <xmqqh5sfvsy7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>>  ...
>>>  - Merge branch 'js/prep-symlink-windows' into js/symlink-windows
>>>  (this branch uses js/prep-symlink-windows.)
>>> 
>>>  Upstream symbolic link support on Windows from Git-for-Windows.
>>> 
>>>  Expecting a reroll.
>>>  cf. <5fe64b77-d10b-b66e-8622-14bec1e96f4a@gmx.de>
>>>  cf. <14388349-d1b5-fc8f-b6c7-4a7b43e64494@gmx.de>
>>>  cf. <704e952d-7924-00ce-b8b0-ad355e659335@gmx.de>
>>>  source: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
>>
>> I do not quite understand.
>>
>> v2 was sent out on Jan 9. The three replies you are referring to as
>> blockers were all sent out on the same day, as replies to the respective
>> reviewer comments in v1. Naturally, whan I did sent out those replies
>> acknowleding problems whose fixes I promised, I did not then go on and
>> omit the fixes from v2!
>
> Sorry, my mistake.  It is very possible that the references may be
> stale for this topic, as I can forget update them when I queue a
> newer iteration.
>
> Will take a look later today.  Thanks.

I think I understood what happened.  You send those referenced
messages to v1 review comments at the same time or after you sent
v2, and said "I'll drop this" or "I'll do that" in them, which
confused me into thinking "oh, after sending the v2 Dscho realized
there were still some things to be addressed and responded to v1
reviews?", hence these references.  Sorry about the confusion.

Let's mark it for 'next'.  As the "prep" topic will be part of -rc1,
I really didn't want just half the topic in the upcoming release
while leaving out the other half out of it.  Thanks for pinging.

