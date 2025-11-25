Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219326B760
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764111254; cv=none; b=uW2RVp7ps1fLsp/bUDY3/1VYb9z+PW3BS002xoLix9tLNp+ZucdA7FMplTaoZJzHO1Obc9CntIPMoGIY00K1jWI6Kpgjde3BJZ2a7YftLFNrqEGMPSRJGYC3PopYqXqH4cZ07oxLUDdUJJixntS4pMqiqdFCmgZWkf6HFmumw/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764111254; c=relaxed/simple;
	bh=amnqQ1/0leKNbrSFvT4I8x0RT3Cg+mlYI3iRT/75/AE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h8hIESli73NGcy+cPnV4gvgMPK2hAyHt+Rh84tVtVGA+idzEULr3YyMU15bhmyoUhc5WyVXEoUocHSL+XresYe5QRLISbsoFR4UUdsIcpIf048Wp0mGXehlg3wvDwO3G6EUE3VuqGaFgdsf03AUhIT3FDSW4qj5/MDpGvMmq3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fqvbbH4+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QSQEVO4O; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fqvbbH4+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QSQEVO4O"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F38A1400078;
	Tue, 25 Nov 2025 17:54:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 25 Nov 2025 17:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764111251; x=1764197651; bh=lxoXWQYyFT
	gs27EYr9gGbF803crWsqRQCtzjay3HViY=; b=fqvbbH4+9IJwGD+igHXXMsJjih
	vldnruVs+VhxieXAYAi2aiLSiHCpc66Va+wOgjgmJnpVcb2Tx/odz0mgbMnsyEMr
	uGXYq6uPH53Nv4h+Et5K8re0Kv0dtgBYDIVYp46ZUh+Z08gArNp8h+b+gVGZR+dj
	yQlunZHVB9IaNFV3lQfYT3nqdHQunQgsUBMAW7T2dQ34pDuuj1jwMfowdr5dGZE3
	Q8XwAXghzLBokyB/v5dqjoUu6irozihENPrM46Bd+4+8tSoF+oCO2PNsDFrm15RZ
	roMGhIfWHq+5CQFDEu64VTS4qvP6V4i9rPjkZvQnMW5qL/EOcR/ZPYVVFYpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764111251; x=1764197651; bh=lxoXWQYyFTgs27EYr9gGbF803crWsqRQCtz
	jay3HViY=; b=QSQEVO4OdgotByyRSYDuEt5x5olQuMCZUP0gDPRJkavwBzFwFs1
	d4NHccMyBJ8NK2y8fsIhJ+TR8u3jVzD32zpi70Qz3hVAH6jy3KnGIOF/+e6Mqvzm
	oBSwZcrdtJBRIj3R55NXSR191YSADz5bfciKoQLuSwXbvW58knvpxMjXK3trS9tg
	EsnwG18xrCGN6fIttfBpSIDCJXtLmHVPeKQnllvqH9ku9eymAmRiZ6ox1YqRdAqu
	Wppdu29AA6zMuDE+0VhsDws95MZnDwGRLdRLQF4k48MF3y3TZkdjWNi/TW+ljwdH
	0EiTd29ESig2usuqzPVAFS3ijESEhZwxyBg==
X-ME-Sender: <xms:kjMmaXcHxetf2tU6OwOMo4j3ikj7-PrR_vXMhovJtGO-LH09fhOkjg>
    <xme:kjMmaUPYe955-nBa9-aIqzPCVnE1l4EjXG37NF8nt895lVYdlfD2WT2rGzCvSIt2Q
    QMF3iUNtCJP6Gt-1S2IHWBZZo2OVLRRLkk7YA7O_dn-GRE-v0RwPQ>
X-ME-Received: <xmr:kjMmaVhUteTJZaXMt8_JkF09BAfWAuv-MYbUcyIbB-TRygNe2bUhNxy_J83bbiaH8zhzHNF5k_bzFVrrXLntcMTqNkfIDPJMil3v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kjMmaX0HPDVgpZbIXTrl_MVnZOQY3PT20egbbc4xeTpub0sEDuXBBw>
    <xmx:kjMmafizxpN0T2Ite2qi9dAe9N7xZef3-ZwWS7_7CjvTKQR_YM_46g>
    <xmx:kjMmaXe-gbgSXHDCH-pNrQtyHi6tyuIXyW2AB0s5OSt2YYXZKstL3A>
    <xmx:kjMmaSkW_G-g1yxFGw7TBNei6wY4gl4tW5115y-eZZs6rCsLuNIrwA>
    <xmx:kzMmabIKHVuYHdBQMG1IKjPTFuyv6rdCrcyr_grZJA_rWFnaTXXFwGdZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 17:54:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] make strip: include `scalar`
In-Reply-To: <235775ef-d12f-4b19-0b80-672c4e5e1812@gmx.de> (Johannes
	Schindelin's message of "Tue, 25 Nov 2025 18:47:42 +0100 (CET)")
References: <pull.2004.git.1763409086322.gitgitgadget@gmail.com>
	<xmqq7bvoiadg.fsf@gitster.g>
	<235775ef-d12f-4b19-0b80-672c4e5e1812@gmx.de>
Date: Tue, 25 Nov 2025 14:54:09 -0800
Message-ID: <xmqq4iqhraem.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > -strip: $(PROGRAMS) git$X
>> > +strip: $(PROGRAMS) git$X scalar$X
>> >  	$(STRIP) $(STRIP_OPTS) $^
>> 
>> I wonder why the original names git$X here explicitly, instead of
>> using say $(OTHER_PROGRAMS) that covers both of these.  I know that
>> the undocumented INCLUDE_DLLS_IN_ARTIFACTS knob uses OTHER_PROGRAMS
>> by throwing in non-programs like DLLs to it, so that artifacts-tar
>> target would include them, but perhaps instead of working around the
>> misdesign of that target, wouldn't it be better to correct its use
>> of OTHER_PROGRAMS and use it here instead?
>> 
>> The change (including the "strip scalar, too!" part) should look
>> like this, I think.
>
> Sure.
>
>> Also do we need a matching change to CMake and meson?
>
> I am unfamiliar with Meson, and do not see anything about stripping in
> `meson.build` apart from a `--strip` option that is mentioned in a comment
> (and which I would assume already handles all executables, otherwise the
> move to Meson really is not worth all the hassle).

That's a great point.

Anyway, the original patch that started this thread is not wrong, so
let me queue it as-is.  Those who want to improve on it can build on
top.

Thanks.
