Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3530BB8D
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405570; cv=none; b=nArayLe7VuYU7eBLMgSrmhWmpnev89E35wMZpK9B18fsMn7non8NKaa8jm06XRJcG5Wccp52ANvr2bak2JPWB7LT0iea/oUv7/Oh1Rv8SZ0HYnpn2akBpfpnI4sd3XfbqPWll9MYUQ7Xz6jw/nWwW2Ir1smvYELoNIF9z2mTLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405570; c=relaxed/simple;
	bh=84owmVwkNUhaYcokI54pGky0sqewuZZholMzy4zuE3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iTL9VVp9nVGQPEtMztYcdm/FU48wMnmjNxtoA4AidvSe0Hjo6equmpcszrEnN2GgH38mu5/qnGmiVzj5RkyR+DmdT8/OBrTXqQAb4FPDo9Vak8FF2jPWHVSetPgkyb8yefGnNE9NuEfWpPfJJgTo+eKEaabxfjnTo7Y/lUzexho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=z/q81vhz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FVBInSsL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="z/q81vhz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FVBInSsL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FAF6EC05DC;
	Fri,  6 Feb 2026 14:19:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 06 Feb 2026 14:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770405569; x=1770491969; bh=2BCHRzka0z
	fkrLIlxCOoCVy6ggwjaxFuq/O2Awi8874=; b=z/q81vhzfoHsx7VbJeDlnGQ2Zq
	5G7GZi7pTUAecExzTUfgQGw31wfX7GmI1mP1/Hwfy/gwFkDxBURurScSexnSVRLj
	sYLqoIMSvp6U562dpL1BSvXx3My/tQlIsb6jdJNqaz8UlOoSMiAnZX+SZjrTnONK
	QTXifNeYx5WCzmm+wD7K+RUAnFmnqktCjQi8PAQkkhMIqIcZXQ9kyOpxj0yFXSCD
	aBQJ/VFzggoFfqOrVafRXnqsBPdrYLsnez1ywphxdHfjTyFVgEa8LtWWZnmk+0cd
	wt1wLOkx9YPAV7ZghvUw1Zl22ECzk2grvJikPzqYDk/aTz26n2Z4si7dgaeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770405569; x=1770491969; bh=2BCHRzka0zfkrLIlxCOoCVy6ggwjaxFuq/O
	2Awi8874=; b=FVBInSsL34zHGIyw7GjK7oYo3aY5qPG4muoc5pvwGdDSdUe+6eQ
	Df50oTgwCGKdGK3Ll/mVWHRMSepvhiXwUuUe/xrrbvWksiPLXdvPapFC23zJV0J5
	tvgfw8da6IycFj3ZixR2zUq+sYz4qSMVXv4plSPSAUZ6YjT+DcC5PF+P+ljq7tDm
	wQNNV7EaxFc2hS75DGEosces+0Ec570BbZmRXsjSU6ytW309nFJ6WyyvJKlGM/qt
	NXDQTawZb8XNautSBXmFEKOenqGVMeaZRNn9s7jFW1+yyt9J6WKuKPHOLSnBEkYo
	NoCR18hgYCEVEnMj/aXO/pFO4LNU1qFdxHw==
X-ME-Sender: <xms:wT6GaY9Oe00DmA_dkTqBBprMg47Nst00UOD-ldBLuCs4g5wuB2arXg>
    <xme:wT6GacYlj6fhuIdiN9KenP3c7H-9ZmmjgRZ7olnsKZVf-dv4ge9F7MQ858z3p6vDQ
    W-5mrh1O_2rvwuKiuKkCBq-ygcQiPdLRn-HLKxNtnc5Unij-MO69Q>
X-ME-Received: <xmr:wT6Gaaf636oCMZlN7wW54nK9r7-JxuwF24o0UNocTM4MQ5oVaKfCne2g5gVHaoT2-ngQWAGpZVn5q1PqRCHtc4wuoyGIHvkHog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wT6GaRmboTxymnMCFTNU2MWLK4n74bvN2mYBcSiq7uFM6GpOr2UZ6w>
    <xmx:wT6GaS33NYRElFcBshfT9xQIuu5XNpBRBqQxVnWRFrYa9r7VT10yTg>
    <xmx:wT6GaScVST5fukNhdKoL9jC5Q_m7B4-S2wx1h7-W-lvGGtXdhVj5RQ>
    <xmx:wT6GaUYchUIziaEAR6ofQak-fjtMwYlGghutci6y0ul57JrD4k1xMA>
    <xmx:wT6GabM0_eiHSfLpzRDJG0KCbM6Z-eh9jSomHOgPC1P4WXeRh6DFfewD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 14:19:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 0/3] introduce new option `rework-with-file`
In-Reply-To: <cover.1770390576.git.abrahamadekunle50@gmail.com> (Abraham
	Samuel Adekunle's message of "Fri, 6 Feb 2026 16:52:39 +0100")
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
Date: Fri, 06 Feb 2026 11:19:27 -0800
Message-ID: <xmqqms1lel34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> Abraham Samuel Adekunle (3):
>   interactive -p: add new `--rework-with-file` flag to interactive
>     machinery
>   add-patch: Allow interfile navigation when selecting hunks
>   add-patch: Allow proper 'git apply' when using the --rework-with-file
>     flag

By the way, this series is conflicting with your other series that
has been in 'next' and is ready to graduate.  Perhaps it is time to
consider rebasing.
