Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059AE7E9
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488292; cv=none; b=Qw+1a1OSsL87204vOkOBo4QQABen5KdZQUL63G2PITAzcTgKHNV+w8lAaiVvGSy/GmCNWxqmPAd2GWVHt+xj+ypH6HGW1SHspPtqpQrFh1yE9Op127yB5bp1PcRH2zXBtenb9xnVTM+9T1icoZbLhXfbWYET+U4SqhWihti/zOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488292; c=relaxed/simple;
	bh=mFKFRl+AUFanaRGRDDaNNxMG/0dEXO1cIF98Ie7XY7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ojgj5GSHZjSOsOOewYbxIKArk+lbvWcfA5VizLuzQZNVM0ROeirMYccZIeQOFHalt4l//qbMPEFEE70qjJUEALB+Q89flCYU6sFlJ7g/HS/cfYNFFSe1zB3/iJw+0NyqlydaizXrlmEKII3+z1nGU8jH4O5T5hwcBCQ8zi7UksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jenPsize; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mq2ye8HW; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jenPsize";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mq2ye8HW"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EDD237A0454;
	Fri, 25 Jul 2025 20:04:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 25 Jul 2025 20:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753488289; x=1753574689; bh=mFKFRl+AUF
	anaRGRDDaNNxMG/0dEXO1cIF98Ie7XY7U=; b=jenPsizekcm2TygNqcn5WauBi1
	6vgFo14LSEa2IORvAVMNQ7y9+53OLDIXgLzhck94uXK3sxhV5rS+Zo0CRMrsT6aT
	z+3oytC04pFyL7lBEozHJvzOFJe0SqqUNIBFbAB6lOAcjVOApMY6rIYfih0flJqW
	Yh2E1Y8zaEPT4iiBr9thkZ6hhXSVmM+QVt+Py/f0eDLwCG/FL/CH8GeuxcpDqMyX
	TM1XyedRfcQkqOuRB7Nuiut2FKSoKWkfO4V0+XZDkFDQu2sPiJr5nmvZ6Ub7iz4v
	51EbhhTDN5F/iYmXPfWZOVFX+qdKqvFtoZFHfwZs/2bT1JUjnTPWJYWBUquQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753488289; x=1753574689; bh=mFKFRl+AUFanaRGRDDaNNxMG/0dEXO1cIF9
	8Ie7XY7U=; b=mq2ye8HWWS4wkjtM55tnILoyJ5IYZhHXqCfRLvpc5zbtFaAMRDG
	7s4O4SOpSATKD+dYdiAq0BpExHllUAenssrtZl2BnrXazxmbdzqDsVceVv0Jod8i
	g56OwgMKFmenXgJnQbDqn1PzQBmhivQEPGTBMU9R4yPnpnRy8w44T4xbOPz4zONS
	q6FwWGJexoWNBVDM2HT2wpFWDEycvt4xcJMaJtCeyw0Fk9Iwaadmc1jhKeB91BSo
	8/itwKG/w9hrP5VTpUNEDZ7qFW1zOqvpccgnJ02bBuFu3qR09kvRVdDWICsa91wc
	wr9xToy5zD0K0dqGmcmkYQx9K4bU/js/94Q==
X-ME-Sender: <xms:oRuEaIRjErNoBxs9d4Xhq7ybsMNFyxcmTU0Da-cOFsjHpyawPpRCyg>
    <xme:oRuEaGjGYmDzuXlv2nL4yWZmd802uaeGahbqdp7CPcuD3os7sjMUQq6oChaV9zhIF
    yW7kfFgszmmQPuZAA>
X-ME-Received: <xmr:oRuEaB8JYG9SQZMevpZ_VyRydtCzwSzZKqrM-_aYl0MNYBoCphVXLsk3gdkxsOC_xIf6NqcMs-0ywF0uBIV4h1U5z9AKPvf3aF2sIyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekgeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegtrghmrdhsthgvfhhfvghnleegsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oRuEaNEysgxo66R_54dxSaf1Fio49zp3ImKIg3Ua4Z7LokrA6xA7ew>
    <xmx:oRuEaEltAZdewVfso3ViTgTsWZMPSW1vPCDpxuo5j9QMaZ4mynKptw>
    <xmx:oRuEaBb6WozWfaK_gYZyYGnZjl66JoA74rV5TpxLikpctEvJHVdbLA>
    <xmx:oRuEaJGtY641hqQL3ZUmxtnq6YXgtcextWpntq5aqubulEbtG05l3g>
    <xmx:oRuEaCe7g_8Ts2uYBZ8ZRuKAgFezIOOAq59o8NhY2dciXsXvvTsCOGJg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 20:04:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Cameron Steffen <cam.steffen94@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: Show skipped commit message after rebase conflict?
In-Reply-To: <CAAVFnN=S-bu1FNafyyH797AeBxUu+8vk5yJ5xaxCUBkBZin_6w@mail.gmail.com>
	(Cameron Steffen's message of "Fri, 25 Jul 2025 10:20:45 -0500")
References: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
	<xmqqwm7xxn4a.fsf@gitster.g>
	<184ec60f-9431-43c1-bce3-405bb6b7f959@gmail.com>
	<CAAVFnN=q5nCD3K1jppVcq7qB9P5WX0M070jqR_rey2hzBt0ERA@mail.gmail.com>
	<xmqq5xfg5o5j.fsf@gitster.g>
	<CAAVFnN=S-bu1FNafyyH797AeBxUu+8vk5yJ5xaxCUBkBZin_6w@mail.gmail.com>
Date: Fri, 25 Jul 2025 17:04:47 -0700
Message-ID: <xmqq5xff3jhc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cameron Steffen <cam.steffen94@gmail.com> writes:

>> But only if we can positively tell the reason why there is no change
> relative to the parent commit _is_ because the commit we are
> currently picking has already been applied, that is.
>
> I thought we merely would need to see that there are no staged changes
> to be committed, and there is a currently-picking commit that will now
> be skipped? I don't need to know whether the commit was already
> applied. I just want to know that the commit in the rebase plan is not
> being committed.

Then your earlier idea to reuse the same message

>> warning: skipped previously applied commit <hash>
>
> Potentially we could use the very same message.

would not work, would it?
