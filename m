Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8162566D3
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269991; cv=none; b=FW1f1GjbwaO0LsmqIdRf6fYQF2sme5t37UXyYGXMTcalCER1mgvBSEvIxMQycNLCpEF8fdteTdeaZvi+RHiosubSPW02L1LhTeqZStz3Myrmn8YHqAnXTsKTSAUzTkMgHv+s09ZYczRZ1y2GWVfiwOiNqvn5WTr+mJka3iFu0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269991; c=relaxed/simple;
	bh=etdjiYVXjkCF73stfglQBgdthbav11RApoXSkUwjFlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJFi4C3IrJu07MKRTIFR0+OvPKCa5b3jdTp/I5zHue13l4HWGiNVPqSltNOXqXtEPRhShlMo6evfhRs1qOvfvNeCMryq9cfZ3xZNruiK/O7BGNYNJ7Ln25mtnyO8CdxKW+uE02yv4gGSxirX4Bwwm6dx00lz3wzchi7b3NPELOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TzUkG4we; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jHRF60R9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TzUkG4we";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jHRF60R9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E0566EC04FC;
	Tue,  4 Nov 2025 10:26:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 04 Nov 2025 10:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762269987; x=1762356387; bh=5097pTva2p
	BuaCArdWRQ+pZj5Fx3JyjQyMSRpu9hE/I=; b=TzUkG4weAJ86ApKyssDQcqVVPR
	DbQIyfSKnYlyh/v5ohfd93OjeiI+JaNiyK6cgqHS95PK2YvD1ZKqYn8D8LWH9o2k
	ImbIniNYhERkbCRJRIoKEokypfvx5EJEE5nfbWJQM5hlAHlAIfxaNhr1oRCer3io
	ksEEfP2j/oGYdSdNf4qSwjIE0TSfSoaMabHVqo1G0AqOniO4fD2C2BPfc4RC5HvC
	Ulx9klOG+f1lumxgL7+cRLcEiXERjB0pDxvHSrc/20pV0h3PnrxlhkE2taXRyd4T
	XvaInJI/vEP4fUbFjwxBwhUM69lJj7n120yyGa0U4O9QZoMokbnBy8sQPMTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762269987; x=1762356387; bh=5097pTva2pBuaCArdWRQ+pZj5Fx3JyjQyMS
	Rpu9hE/I=; b=jHRF60R9Pvz10xOgYsUNJ1FoPEp6ruoHbmj8whVhrFRUICpPD3p
	GZWMFsMX9eHKd/haaceTEMpvYBsxMZUClYfvSYQFTVHmFhTb05MVTER6eeAOfZKo
	8beHz/d4Nd5kLUT9EXlNRhL8Lqn6eR04/Y40HWdxWi1SZcwAR5wLXJGjeHAP4U6n
	JgT3FsU1j9L3L9MlzcrHTtlteY8WFbeDKYHLSkjdKeYsYrtLr6n1B1zYZg1G+o9g
	2kFvBWwhwCw18zzN3S5Jspej+aPtHM+Yagsj6LwNdGjXIPU388kSwB7jgMU+ZpN3
	gjWLqj6QMOulCISK7/u7lg21dJQ1ecqAlKA==
X-ME-Sender: <xms:IxsKadgeI8RabsXYzkTw-RcGK1PGFqTOssKM2lnEqrmb0DuFf64sBg>
    <xme:IxsKaZDy-DIu4_RZqX_6Lcmdn_KM8wMwApT_MtzO7aHpmdVQdpCdUPCCUY93sQW0p
    kn9Sfj2p-SrHFVQGqbhJLdhgWzXBEwKK5OwtfdFkEEW7afxpgoz8Q>
X-ME-Received: <xmr:IxsKaSG1lkjF2NzeKKqfwyyKNMDEnwQzmgDUEXMbFDDY5sB0rlQmcnfv9vj5BWZ9GVnH4tnGzo0V2sUcMKA5rak7MO5ecb5u1bSt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IxsKaRLTcsCRlFzajdfzc22_KHXK6Cpe_1A98aJswnY1g6ueByY-tw>
    <xmx:IxsKaWlAX_hLwM-dIVNF5RCo2v6rZbns39Lo9tTJIfls7ZWG5iSGHw>
    <xmx:IxsKaZQQzxECuv9t3UY4cq4ZMnc6fYhfzNYZQY3PZZxgOktNOR5Kcg>
    <xmx:IxsKaYIaasY9DztrDjWBaaQLaolOyBmBzVAGVqu41kgcajZQ-Cbtyw>
    <xmx:IxsKaRDvio_GHz5-Fd7kthXgkw5893eZzFz-AZFjsXGA6H6E9Q5hU0Tt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 10:26:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] ref-filter: fix stale parsed objects
In-Reply-To: <20251104-b4-pks-ref-filter-fixup-v1-1-2fbca52d76d9@pks.im>
	(Patrick Steinhardt's message of "Tue, 04 Nov 2025 15:36:13 +0100")
References: <20251104-b4-pks-ref-filter-fixup-v1-1-2fbca52d76d9@pks.im>
Date: Tue, 04 Nov 2025 07:26:25 -0800
Message-ID: <xmqqikfprf8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This is only an issue for a subset of retrieved values, as not all of
> the infrastructure ends up calling `get_or_parse_object()`. So the
> effect is limited, which is probably why the issue wasn't detected
> earlier.
>
> Fix the issue by resetting `maybe_object` in `get_object()`.

Yup, I got lucky as  --sort=version:tag is one of the things I use
at least once a week.

Will queue on top of that topic and immediately merge down to
'next'.

Thanks.
