Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E05175A6A
	for <git@vger.kernel.org>; Wed, 20 May 2026 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244462; cv=none; b=PmQJmmP9PzysYIu3yorh9mHgDNBoJcS9D4NjNZO3xAHYotBnpiw7lswgJbHNULBV2/bUNnEdLnRlt91lyHSa8LnaAFaoK8ieoz7aaJID9SQkhlPp4hd5T0ejYsE9waw18r+0TfRuV/K+jzj+tBxWAFxqIrPE81UmXFZOfTDNhYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244462; c=relaxed/simple;
	bh=UZh16Hqh3IrTzMVOKvwoqU9MqyfdkbaHxDg+/9QKXSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kpEaw5ZI/DITVKeQaDFhDQXhdjtgt+E412KAUzCU+pLwvfkDZjHwgXzxEHf6+UVo7P982FxWUajccMzAYT+SF2WtcRaU9D0xsGpH6kTHclhpUo9jH4NNPCqaLPGoX33MlepgRiXOrliIhKm5GJvxQ71WmFagye44tgfawM7Ubko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JCk0mwqP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LG0AedPa; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JCk0mwqP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LG0AedPa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F1321D0013D;
	Tue, 19 May 2026 22:34:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 22:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779244459; x=1779330859; bh=EdsJFgWMTk
	qHMDVOvBYfydBrIIzAYaVHloGrxTX6Tvs=; b=JCk0mwqPAOiLcUP0gOt9KgH4GF
	MfqiGhgaBlDcaHa19csY21Ps9Atx+1iNhM+SED3k3+vOCT7Me7EDyDJbJN0m3xSi
	O40Z5xXrUMUCEIpHgkeU+cQtLBV8/ukU9EoJWT/00V5GHq85GpuOH/q/4UZtzvJp
	3ZjhI0JtpwEGMZeJARao6Al8ec7yH3COCiZSvCVhWhfu2otjhr28K/yLZnefZ4/T
	0OwAmSnOI1kVe4O0BRgiBZcaQpLH53mMgL0nnL5g01zf4xV7VUw1bOQWsiEcIdYX
	4Q3GWp3E9La9cGsNAz5XRSnevs1vNbYeCrg2f2+fFshXounvMSe9e+NbBUNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779244459; x=1779330859; bh=EdsJFgWMTkqHMDVOvBYfydBrIIzAYaVHloG
	rxTX6Tvs=; b=LG0AedPaZkjasSHcHQgxndJlUSOO1DpbXY/U/TKi2T77vopJ3Yr
	l27PUtTspNHzuVLaBCkHUJH2kD3xTV6CQdLmYoQCIjW2SlH6qxj2fNMCK5mGP56q
	pVEFuGNz2Y9I02RLZMVTtJSXANVun9qcqhtEt8ezBu66KIWZnuRoc+6f3+NjOAXM
	WbAGiwKJMW6OF1TBQPR7ECsxFvEQfQdHbqFVYkoRDAuftOZfnNkSs+QoBFc2w0dc
	oY5nvr2bRXi/O6oIz59idYFGMngCANrVq+DGcBVfulAuuMWOF9LG1T7kxSsxT1PQ
	ChxwyYbZw0V2PFRNRi55Ptbgror0iPn9Iig==
X-ME-Sender: <xms:qx0Nagq2mRmCfEFe8d47waoQQ4Y6nz4rkNQCjbeTCg0MFrStVx88-w>
    <xme:qx0NaqW_qHQzGUY6hMKinLjFoVDHpXIXR9RG29rLpXtq4yCQ7Zd-9IAio1jZtxR9_
    yDGmnVRio9BfRPI5cL0iZMcX35RyB2AjxGlKDW_YleZ0WstA36IuNU>
X-ME-Received: <xmr:qx0NavAx51Jp9DftwEgtMamI_kjqcVppfYRDLRatNPKxhKR429VbM3ifQZYoeJjAQmRrUfSJybd1SUY_68Gq5NEJ4l4gSEzR7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhjtghhvggvthhhrghmsehouhhtlhhoohhkrdgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qx0Nau1SexDJyCDIaY0tGg063PrTS4WWt-xbvm5EXpqjx1riPAFJWw>
    <xmx:qx0Nah0M9S_ByYobLGcOD5G3Rx0pmOvS56vwTN6P_V4OeFk7A5LHYg>
    <xmx:qx0NajBVJHQtLoAK3vBsg92BqmP8ju_l5giEqR6mpkGnVwyYJX-2Xw>
    <xmx:qx0Nag7cSU5z281SVFAj8RAlLr3rmPtzM8vLwKIdFZhKbABJlxaGEw>
    <xmx:qx0Nas83mHQAT4smEmTv6TAG9JJ2dA2tArYicVR6csBBkAYapg86EjOM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 22:34:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matthew John Cheetham <mjcheetham@outlook.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v6 0/8] fetch: rework negotiation tip options
In-Reply-To: <MRWPR03MB116167F956F0616EE71F527EEC0002@MRWPR03MB11616.eurprd03.prod.outlook.com>
	(Matthew John Cheetham's message of "Tue, 19 May 2026 17:48:17 +0100")
References: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
	<pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
	<MRWPR03MB116167F956F0616EE71F527EEC0002@MRWPR03MB11616.eurprd03.prod.outlook.com>
Date: Wed, 20 May 2026 11:34:18 +0900
Message-ID: <xmqqh5o26c7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew John Cheetham <mjcheetham@outlook.com> writes:

> On 2026-05-19 17:24, Derrick Stolee via GitGitGadget wrote:
>
>> Updates in v6
>> =============
>> 
>> Corrected reviewed-by annotations in commit messages.
>> 
>> Thanks, -Stolee
>> 
>
> v6 look good to me!
>
> Thanks,
> Matthew

Thanks.
