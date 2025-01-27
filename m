Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0035B14E2E8
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995060; cv=none; b=tS/bYeoOfQ9wk5xJ5SXz7ZrGm9xjjy7cDooPHQ3dFiLM21LldGWM8TbzCLHRf3BzFd/BR4BqjUlXsPkLm44gM2Oe9fZryLBQSY0+sESLPdyOmpM1l1lPrFzeaFG1cNJb7NxQI4U7BivCnKRem+Mh3hr12phrfhrHACg/YVqrk5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995060; c=relaxed/simple;
	bh=a5PDWUH1w9oL30Jf/4DEu26M/GZUq/5usOTNK69gQUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cj9MVE5A/GIk6lPsdIk1FVzomtLJUHYRVzjlW70p1gB3slpoKF57jkORzZdJCUPuxJvmji6P/fHOHKaOmsqcmbbDe0z0pCodqvOxGq7KFr5+/zE3/WiEMYFT3ltd8XAxPrs32zxbzSVg/Ds2jRhddINAqbOEXMYPYEx9lS/K83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Icck4hHo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eVcKVQhe; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Icck4hHo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVcKVQhe"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 036B91380B20;
	Mon, 27 Jan 2025 11:24:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 27 Jan 2025 11:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737995054; x=1738081454; bh=ZQL18W0HCk
	/5jgdZK+0yA0E3pfbel9L51o6Tr/LvZXA=; b=Icck4hHorWNgIOBcJS8RoOYJn4
	2MRLq6lgK0xBQnwhff9SkXLuTu4V7cPe9+ZBguUB/fnXEoTFgFDt02xS7abGaKk7
	oTdkOafZNN06cULPsFgT+fIuwiU1huruqjqTFOGMTYUuDvuaRYIm2U5ibU0afUHP
	Uqnsyl9f9jOUXO79jVuTEOePbovm3P0LOsQvudnJiCKaYSlVlOAGLJtzeQCKElYL
	7NGZjWB2gzeTYvHeQDY7r8jBHEugqMJrrICuz2hoJFmgw6KF+2l1JMzoZ3UFkMTT
	TXT1PmXLiW9ohcM5j8vHN+a4dEk85fSYUV1MJLeGp1YZiS9ZZJUFzVCfqo7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737995054; x=1738081454; bh=ZQL18W0HCk/5jgdZK+0yA0E3pfbel9L51o6
	Tr/LvZXA=; b=eVcKVQheNmFVOoPb0/yR9hLMdv2m3UYYGILp83jMxGNBFns/KWZ
	LGzvxaxi8wusrerQlCtJHgZoHICGalFepitagoqPqz1sSOBiU1ndflfayzkmM0mg
	jV66Uzz8ZsUcwcVdo5G5GsfQYfts4HfzHF/YPx6zCu1EU3QpnNBK2bv1Ex2V5dXZ
	KpDnxvTaWlzQV2w23RbZh9SnuxUkoobMUU1lskIuYeU6KSsdiU7rrUCfF9HxZsEX
	C/AOqtV53rK17r4gq6jvI771wl7PCz1Pt5UU91io3xCvVQT1sPW20d1zH3Ny6jk4
	aUjetn48OQI8kw8QsUmTlDz7pJ16zLB/92w==
X-ME-Sender: <xms:LrOXZw-Sx6XqPIN0aD-Xzwa1EwvE3KSN3R6nlbWZ7GoSxZvnnFpWpg>
    <xme:LrOXZ4vG_NI_0uwlK3-DP6NZb_TBRsfxO4J5N_pOmKZf7HFt-urfRhQ5pPPsCKZ_H
    CgTee-7RDOn2v5flg>
X-ME-Received: <xmr:LrOXZ2DDhXnvqc3FzTc01X7xXQLP-FQ72hIegD6PAwE1uGd3jElfB1i5QxJ8Y0u8eRL5SBpylg57x-43Qze1D2ZyJMdPIsVfvgqt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepveehgedtvddtveekueehgfehgeeuledv
    gfetudeghfejgedtkeduudffieekkeegnecuffhomhgrihhnpehpkhhsrdhimhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LrOXZwfc34ygVVxXrtwswm-TF7db_jTmQJHDCHmMsit-1kNhVgSnBw>
    <xmx:LrOXZ1O9tj8MkuvK7qvZLk68447QINHzj7GGzJl5B3RQwvx57Jb3cA>
    <xmx:LrOXZ6nKUVL3aHARNU5F-TkaEHg7HSidrA3AFZTAujKOvQulBaqrDg>
    <xmx:LrOXZ3uxUF3TxfA4_8d9byZh-nyObqDGbMLK-NhdLolO1eugEUM4QQ>
    <xmx:LrOXZxCZCSGzpUxhx85-We48BPq7_u0WGGdg26ldvwDs_0GgkXnSZ5RS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 11:24:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Johannes.Schindelin@gmx.de,
  git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] refs: fix uninitialized memory access of `max_index`
In-Reply-To: <Z5dd1YOYytx7kZee@pks.im> (Patrick Steinhardt's message of "Mon,
	27 Jan 2025 11:20:05 +0100")
References: <xmqq5xm5s80e.fsf@gitster.g>
	<20250124140203.886324-1-karthik.188@gmail.com>
	<Z5On1waE-2uwIjS2@pks.im>
	<CAOLa=ZR=Hz+LU0n-uC2dpk8_sLqAyaxO0NswJH8bP_kEdDdbUQ@mail.gmail.com>
	<Z5dd1YOYytx7kZee@pks.im>
Date: Mon, 27 Jan 2025 08:24:13 -0800
Message-ID: <xmqqikq0uswi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jan 24, 2025 at 07:48:43AM -0800, Karthik Nayak wrote:
>> Thanks Patrick for taking the time, this seems much better. Let me add
>> this in for the next version.
>
> I've sent a v4 of this patch, but forgot to set the In-reply-to header.
> The patch can be found at [1].
>
> Patrick
>
> [1]: <b7e3dd3cc870024f0e80dad26c5a7a96483c6cf4.1737970803.git.ps@pks.im>

Ah, how very considerate of you.  List-archive spelunkers have
bidirectional links to see (1) from an older discussion, how the
issues were resolved, and (2) from the final attempt, where the
issues came from.

Thanks.
