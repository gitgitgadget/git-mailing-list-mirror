Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A42512D7
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176319; cv=none; b=gFE7dbabegPeLw7ZYDBEiLZp89NVuVgSuR5Rse7KoVXh4a8vpgLSs/AEt0kxSYBFXwmFqxnAJaNxw2fDNoz6qacbmyqsVPMAXwFAEIYCOEtB7wb/O9K3hXJfXaawo0kUN0kY6A54+AIu7+GB+hc1q1FzZseKKhb9o82kXXLfvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176319; c=relaxed/simple;
	bh=uto7k1vMPiuUlVBYmLfu0rTGw/mB0jN77t0Db9nF4Lo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BdSrr+4RvdCISAsLEWPqvk/5lYHuNazHJXnQVSR6uXzw7nBJSJuxjaHwxg34MfLpLsQjSoZHfLSM6rTmy+yTvES59/cNcdP7IH+QkgpJ7j8HtHH0nMV551t25WIvAl7UyyEYKTHmjTThbsPuesjzWWEp210rzZ3dO+mJ9UF0CkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OuGv51tc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bm1cgF9s; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OuGv51tc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bm1cgF9s"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id CD04BEC026C;
	Mon, 29 Sep 2025 16:05:16 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 29 Sep 2025 16:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759176316;
	 x=1759262716; bh=80cmLdkRfbdOnRK+jyKIhDWEpsMBbYy2TTmBXXaLW6M=; b=
	OuGv51tcVkhWX7R2u+irRi4xJ0eZTxO203AQkMwe6EGBeQVVd5rW8bPohKSC5d5z
	m4D+BShF6ERMsM3ziKgci1D1y32LtA5End36+EjOOA5iXYtGKOiWJJcOlaZzg4KZ
	QDuv0vJTKCcQW/x41goXNGW0TG6Nu5Jh1xSdEBAhzN4jMcB21wRSWJ90t4rnn8gd
	4Z851ixmgYKoabgZVCcSt0xeTcIGIu4XQAUgvDB3xeoQeq4RrgOc25ROimzso7w5
	9/Dq0Ma5qscIzyQNguOY6nsXdM5Kae6fjUGFHIfu2fujcfILziuuWimrMvVfm84M
	Jyyg9PIboJIWmbG548lPhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759176316; x=1759262716; bh=8
	0cmLdkRfbdOnRK+jyKIhDWEpsMBbYy2TTmBXXaLW6M=; b=bm1cgF9sYBZWnpIEn
	4t4c9z7VNViLF0/sjYlx0u9zCDNDMvJTG4CdHewO7Q12oJBjdXJXBYmbdRqlQuyV
	phuVYp0iWJ1vnXyHxY1Rp19XBN4Kyj9mNgsQJV1CSqjlBHw1mkPB9oguDJsjsUDw
	ohkmjFW5ko6nT3FRGYU0fSHinYJpza0eYOqu2XU6mAGzyZ4Bv15lAqBbOTRg2MFL
	3BGSeWYfahYcoalOJBvfXDSalAhkd7Zsatua9UvVL+VbAmAe1tnldxLjXDktmNU6
	9XeLBIRlVZfzDfPN+Phrc7nGoV3MXqj2p81ZTK78YtwX2uyyDsJ3ZF8vGDVIMKE0
	fhFfg==
X-ME-Sender: <xms:fObaaC3WTUyFVblOiVhBzxVGAICEQYN8YFG2suFoZkRehEsLYg6Vj8A>
    <xme:fObaaP5ym74hUWfN1gTz99CUtXWO8xly8d09XTSkuqD0REaHj3M-QN7463MWhqveV
    S9fLaKrziNuZLhpzNYGWtgzlL_M8MYuHB27J8Q1Eb8-fFQN2_arnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejkeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeffieeftefgheekgeeitedujefgveehvdevieelfeeiiedttedtgfdu
    hfejiefggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fObaaJgiHuMYGk4O1aBa5VV6wJQZdoFJmnoSWjcsFMgniWlE0bRodw>
    <xmx:fObaaL-T46KoFE_QXGP3gxNbozwD3AyLTRWRROf60zh-lqs67uJ_vg>
    <xmx:fObaaAoAfpHXhot2WyX5ltvfgPEDcxS88rdDmt9_TNkL0zjDJwQJ9Q>
    <xmx:fObaaK_rfnkI0_-V2bQLeWA5v79LfX6QWpvloQKqlUPSlueQGR0iYA>
    <xmx:fObaaPoL7e0tiW7Aqp44DmPO95CL92mwvuoMONle0OVzXD3Qgy25LjFu>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 71D3B1EA0068; Mon, 29 Sep 2025 16:05:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4Ma-RQ-GLU7
Date: Mon, 29 Sep 2025 22:04:49 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <87792693-58d9-4047-beae-38aa4c59ed41@app.fastmail.com>
In-Reply-To: <xmqqldm0am4b.fsf@gitster.g>
References: <xmqqldm0am4b.fsf@gitster.g>
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025, at 00:24, Junio C Hamano wrote:
> A typical lifecycle of a patch series sent to the list ought to be
> as follows:
>
>[snip]
>  7. If 7 calendar days passes since the topic was merged to 'next'
>     (or any incremental fixes are also added and merged to 'next')
>     without any further finding of more problems, the topic gets
>     merged to 'master'.  We often call this 'graduating'.
>
>[snip]
> The time taken during 7. is pretty much fixed and unless we are
> willing to sacrifice the quality of the end result, cannot
> reasonably be shortened (note that this is based on the assumption
> that "find any remaining bugs while it is in 'next' before it hits
> 'master'" philosophy is working, but we have never run experiments
> to shorten this to say 3 days to see if we see more bugs on 'master'
> yet).

Maybe pure documentation changes could cook for less than seven days.
Not for the benefit of graduating to `master` faster but for the
benefits that less integration time brings:

- Less integration overhead since things are less likely to touch the
  same code (docs) at the same time
- Less likely that you have to base new changes on pending series
  - Integration overhead that affects both the contributor and the
    maintainer
- Potential second order effects like not being afraid of splitting up a
  lengthy series into an uncontroversial preamble of pure fixes since
  the combined series won=E2=80=99t have such a long potential lifespan

Given a documentation series that either fixes something or subjectively
(by consensus) improves something, what=E2=80=99s the risk of cooking for
slightly less than seven days?  You might introduce rendering
regressions, which is not on the same order of badness that a software
bug is.  And as for the subjectively improved documentation: people who
disagree on a subjective basis with a topic in `next` are already
considered (?) a bit late to the party.

And you also might miss out on feedback from people who run
`Documentation/doc-diff origin/master origin/next` when they are
bored.[1]  But again it doesn=E2=80=99t seem like a big risk or downside.

You still keep the same standard of review.  But save integration time.

=F0=9F=94=97 1: https://lore.kernel.org/git/df251b0c-c593-41ed-903e-8fb1=
c323b874@app.fastmail.com/

--=20
Kristoffer Haugsbakk
