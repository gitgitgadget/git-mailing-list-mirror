Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850823315A
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648687; cv=none; b=qokZwZjFSJnUZZd5c50zulOL+A/a8tAkOAcDK7OSGSa5e/xdvpt9zfuQVL7k7TCVkgLcCks+9ThfLo7EIFYdKGZX+3xfodb3wulx0rySEaJqXdHEWO5L1YS1nms6v8ZNkI1f1GV0cU55h/L7FwFS8f7fMUagY+g/rCYkqYEy+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648687; c=relaxed/simple;
	bh=01KRLxY4AMZhgwwlb4JLCAUMPwck2ASv5Q4YV/w9EMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XX6Y4iURNYj7U7pi9R1hIV+sEQt3ed/kQe0yD+U8fsWxq9vuHj6ZO3NF+1rnW342Rp1Ywv6KLIUajgFZBu/YalRm4DTk1khiczi03hwftEWbIbiiMkYodJxrhMus5AJTx0ewz29U4d7vtX3Hmmxwb/JZJwcX//OY6Lqw7LvOLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sny/QS2A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lpw0tBTx; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sny/QS2A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lpw0tBTx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF22E14000A1;
	Thu, 16 Oct 2025 17:04:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 16 Oct 2025 17:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760648684; x=1760735084; bh=D4Bv6Y2K1K
	kBbnvbHKS58EZ6tDqwUFLDXHx8f2R1TSE=; b=Sny/QS2AwNXxfmTzA5rgxt6R1C
	DY8qVu4CfpU0UzXdkPxjqHsA3LxUyFF5ER+eT0yAheQAAgV8ew6aViHBzO1yvanb
	NKAEqbRMlu9PYOZ4xxRXIWqPqATWzbONtvbi1EB28mOowm4o335pACLchOZxJliP
	1a4erZoKvAgrZCh9cbESXIVzcxQrJ8JqudiReXHmCDyQuA43VDJ78rGowlHkma9m
	4QFfNATM+IC5qhm1bzV8UdLpYBM/FJ88F/SHrEfTnKB6zEAiO4eZ5grYsyy6qJZO
	BXSlp2XS9NzvJemmyvE1yq2Pff/RLTvUv29kJnUZUgcc2WeNHL1C1Fc5HFxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760648684; x=1760735084; bh=D4Bv6Y2K1KkBbnvbHKS58EZ6tDqwUFLDXHx
	8f2R1TSE=; b=lpw0tBTx7LMrCIZqhutIJzWH4D74hfDMXXiyvddXhjn955himE+
	Ggmz669d9SwUsuLKE5bWzJ45qbxeF+Q0gov8N2B4O1dNFNXuehbOymBcYNo4Vbfb
	84hgOCRSDeyRGjN/2PqCcs+AzFdOCNixkL1zmxJ0oJo8Rmn44nXobw4CQ/WZxNXU
	GMZCiSuQoF+6LzfMUNYiFMOjxWXoB6wTaIcLSFz+G+XKwoKveIs2dJD3dokj5YUG
	AkVvsX6WsXv3KnC+dPTY/sP5c9MTzB2hYI30BQe+yltBvs+DTH7Dwc2P4LDTRjCc
	HXWHEEPk7bSxVgrzcrZM3atSXiRhYHdAQqQ==
X-ME-Sender: <xms:7F3xaGGDwkqWU8W4gftxzv7omp-Eexjh4PtB7hNHxJE_7NNtHiiLgQ>
    <xme:7F3xaOwNGYSQpexkfVvDJOp5UXXSJnSbcWN0qaPpxt76uIbJpjZeOos9vOSrtBojn
    T-1z7NjJY0XP7Dz6f-mjSYYCsP6uXsdzsHWN_LRYVswzu3mxsuvmDY>
X-ME-Received: <xmr:7F3xaNj9OnNM70xYFNljch8vBhoGJfxg7LqpOu1MO-zA8JJmQPNuZWNcoSlMhdeP3m0qsQpyRLMK-9uQ4bG-xRlugiZ46V-sX2Ik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepveejgefftdefgfejgfelffdugefgvefhudetuedtkedtgfffkeevvdehjedt
    vddtnecuffhomhgrihhnpehsthgrtghkvgigtghhrghnghgvrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:7F3xaJyoGEx8_BzXv4f30ALN6lVFnWvzOFId_TwZr04nmZJrCaa4mA>
    <xmx:7F3xaAJuLbAqiOklE_ugwc48r7IEVs7x8ph3LJc868lNCZTRXp5g6A>
    <xmx:7F3xaAQklwSlsBBJ8VPuwVtFCjNjM17bnu1DShVqihlKhEgaVrMh-A>
    <xmx:7F3xaIr3ONiK3Z3885u7aGbDt1UuiswdVEtuBotXpu2RWaAb_YWdaA>
    <xmx:7F3xaCzXfvG14tOFkJrT-Tpm9cxwuADsxiQnQl6NPPCNWteoB9g61rDZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 17:04:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>
Subject: Re: Signed-off-by & the law
In-Reply-To: <CALnO6CDNRw3UcU9UM7rpkAoQsSmfdkxMKVihmoUmUOCv_fpbJw@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 16 Oct 2025 16:15:09 -0400")
References: <CALnO6CDNRw3UcU9UM7rpkAoQsSmfdkxMKVihmoUmUOCv_fpbJw@mail.gmail.com>
Date: Thu, 16 Oct 2025 14:04:42 -0700
Message-ID: <xmqqy0pa1rth.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Any contributors/users with an interest in law feel like taking a stab
> at answering "Is Git's signed-off-by legally useful" ?
> https://law.stackexchange.com/q/111158/26698
>
> Having a solid reference answer is usually a good thing, if one exists.

The meaning of Sign-off is left to the project that adopts the
trailer as its own convention.  Our SubmittingPatches document
governs our project and nothing else, and defines how we use the
trailer (namely, you sign if you certify your patch is being
submitted under DCO).

So the confusion by original questioner is understandable.  You
would be confused if you only see a Sign-off without project
context and you are forced to answer what it means, because see
above.
