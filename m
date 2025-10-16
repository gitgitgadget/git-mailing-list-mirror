Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B921D3D9
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646691; cv=none; b=HJuOjwpIS2B2Fsx3WHdMrYr0UKuLZmnOaR9768gNlIgWsgdyUmzCiHroVGuiYFDg92XsPFlL33XNHwE67+WzcAy6CLGLe94qnsSwVXl1adY4fDXnaxji731sUH4+kVXSxBYpF/kPhRcdCDPaOLciKAC9hOjY75nAk+qarZI/8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646691; c=relaxed/simple;
	bh=LryGS9TqXJq7oQ5PGvsb/O93iC8QlbMFnMiqTe5o9DI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OnWy8knF+s34y0oREZ2TUaKniI6he57mLu5N5rcULrzBdqzcngesLavPByNiuYbLMpyjoJfcXm2+pNYzj2FmmI+tHte96iWD5sSGIoSa2lFx5upbsrV19EtnauDPTw9/zAacQ1RVenr9+xDibjotqaPi+cD09vZgHbHBftfhIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZTB8za7j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a15G+vC/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZTB8za7j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a15G+vC/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB13F7A0074;
	Thu, 16 Oct 2025 16:31:27 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 16:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760646687;
	 x=1760733087; bh=1PVAp/KY7EUPkOcLL25fucnJHMZ51kaLlqNISo5XzDw=; b=
	ZTB8za7jwfmT73Dc4GZUT0TfDBxuNUy96IfW+S9TtzyJ+gyKz1m18CdnmVmJrzhl
	7iM2hYFEC6y72cuqORcO3gERI9kIo8Fl3hgCh2rGYqY4zjkWlUT/SUFF6UychslG
	b/ZtCQ4QIP2qKVr/JlPlxDyJ7PkDLnG5+GgBnOAvWmHop33IOmsy72Ad/dyLd5GG
	oA/R9GbPBKpWzZxGt0nDv1ABb1N0+MTJzrFLpqMIX4SjnK6ZQO0/O2k9qF0LgUEg
	9sBxF/IpmzOxaUGQBsh5xbY7ED458HULAuKsrqcegk/XPKHNWcloaeDQd9SK0CPA
	iBWZzWCx95BlF+Re2stVrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760646687; x=1760733087; bh=1
	PVAp/KY7EUPkOcLL25fucnJHMZ51kaLlqNISo5XzDw=; b=a15G+vC/ci6sAuJGx
	FfbJD9QrCwJW7swEf/klKXj01Dek1O72G30VHT0zoiwfuT9zMI6rLJjfDAaYwWrx
	M5Mds91X46p3kr7Q2WI90wnyIeLQY5VeM+7PosGjp/l0UrEFMuhAMk6fGTK4QBlT
	/ovlPh+/UECxLu/Vqw6fImFCykgb1RBvqYLMkOjZu6qX4BjjW9+DgIQvRg/J8b1L
	caELFqEdT/Ni3NG6Ofg4OvgzABD0xCdT33J/kS4XVgPWJMm/FUU1YrQECTq2nNkc
	BpV/kWDGymemRom+ncotZYCc2+disKGspeJg+kdXVwVlPMqadjWpeBJfhA42OL/i
	65BaQ==
X-ME-Sender: <xms:H1bxaIccQGdHO_WBAXPJhrQs0bys-L6nvyLp_39mCKiLGt30BA3Ad5U>
    <xme:H1bxaFBD8Mke5mm1KXw1E_RorY6T-oNDoey2GHOKQVZKLMw1jyLrQy7TNygpHbTH8
    xA54K2WSw4--r4NCFGyYbN0Z0GoHnjogo78VO3gNhvFoGk779uLsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjrghmvghsrdgsohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghrshhhihhprd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:H1bxaHKz9j-Gsr1oY7pGwrt1Ae1nAcGsMbBYHcjcM2ua_AgYGVGO6w>
    <xmx:H1bxaJEcNVLwIAF8AMsT4vWFBCfCYKryLlO-QZHXaUMCoWIk4e7VrA>
    <xmx:H1bxaHTtubU0EU87qJ6ooHyD-vAdhM4m7H3JHDXRTjs-QWlnH4WXBw>
    <xmx:H1bxaNE9CIg-0GvQbJmTLtxf4-aDo5kZ65W6k071ViRFP4jlO6Fisw>
    <xmx:H1bxaN9TjyCPJdyHs5n2FAwJjRx9u1R1s74_ENsqm9bm0GJ6AlwU_6d9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 31E311EA0062; Thu, 16 Oct 2025 16:31:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AThq61FNTfON
Date: Thu, 16 Oct 2025 22:31:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 git@vger.kernel.org
Message-Id: <2a77313d-a4cb-42bc-8cc3-2811869bae13@app.fastmail.com>
In-Reply-To: 
 <5e056d3cee9453079d4251009ecd57b208285ae0.camel@HansenPartnership.com>
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
 <6fd0ac40-6cf8-436a-af73-1159f6569efd@app.fastmail.com>
 <5e056d3cee9453079d4251009ecd57b208285ae0.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/3] add a message-id header to git
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025, at 22:10, James Bottomley wrote:
> On Thu, 2025-10-16 at 21:26 +0200, Kristoffer Haugsbakk wrote:
>> On Thu, Oct 16, 2025, at 20:57, James Bottomley wrote:
>> > There has been some debate in the kernel community about how to
>> > link
>> > commits back to email, which is the basis of a lot of scripting we
>> > do
>> >
>> > https://lore.kernel.org/ksummit/a7878386f3546ba475cdf7250ab4f5a6af2=
a1676.camel@HansenPartnership.com/
>> >[snip]
>>
>> Related discussions: =E2=80=9CChange-ID=E2=80=9D:
>>
>>[snip]
>
> So this is a different beast from change-id.  Change-id is used to
> track the same change across different commits in a fully git based
> workflow ... and in that workflow a message-id wouldn't exist because
> there's really no email based interaction.  The reason email projects
> need the message-id is so that all of the ci type tooling we have can
> link a commit back to the email it came from (so tip bots use it to
> reply when the commit is accepted and things).  In an email based
> workflow there's not really such a thing as a global change-id and so
> the two proposals are pretty orthogonal.

They are not related in the sense that they mean the same thing.  They
are related in the sense that parts of the discussion is about using a
commit header to implement the idea.

Thanks
