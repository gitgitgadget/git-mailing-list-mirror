Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF71273D6D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640206; cv=none; b=hvOQtzZW4Z08XpY4/baL7LVJcb6G1DUoqALiB46bkC4plaAR4vEc4hGrv3u2p6i8qg7dIdCUMKNqy8IsDjI3CiO9N54uyAJiOce8H35Xa2LcM2//uiiGQvlYslUB831qjKA+IEPeq6ofDpM9AMycrXERcm7+AtMuoaqvyPlU+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640206; c=relaxed/simple;
	bh=98kj1tRdxiCIcwGki4vVDkTJayHwYNYLitLJD1VnwmU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eGjt0hPlib1qz3Qu/rDwXAC4nb4EsPp+l/lOonAABDW0USwo6h3YnrEvyHB39ZlAEBUK9vCM4uWHEGZmUabWvct05LDUs+7zPFsifTmTX1gJAsATSSfB1laxHkRN1tOdRCzd3xyP2lG+aLpCXUD4+U8GIWFnuSCl9fUHjxZGwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=boV8cpGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBsA6KpD; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="boV8cpGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBsA6KpD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E5CB1400262;
	Tue, 19 Aug 2025 17:50:03 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 19 Aug 2025 17:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755640203;
	 x=1755726603; bh=vWr+3k460cbWhEpieTnAf7jKhi1wsVCC1g5VBF6c3yE=; b=
	boV8cpGxdHw6S1aGklkgiUnr/cgJ2KzdvyvsQuyztoAucrMUiPuWem4zXGV6/JdH
	CtpFIRQSoLawXDupUO2FKGYLzGTEIVpl176W91apjTcMZbAnxULoNGs1YijC0hGQ
	60NCF6//5m0tqBWLG/eZE/hyhPkSi3gSnOxau21E+essyvO/fMM7x3KuYb2TpyMD
	bImejGPScBeHDjjE7x1mHUIfxU09yTbZk63Y8tq6FZUWTIrKqEHxlpD5p/UFe6+x
	psc8hMbt61g5SLygm1enkhBjo0ICldXX3hQhZfnu0QivWrfLWQxGLx/72mtdBDKb
	qSRzDXEIkN6YkObd2Yod2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755640203; x=
	1755726603; bh=vWr+3k460cbWhEpieTnAf7jKhi1wsVCC1g5VBF6c3yE=; b=k
	BsA6KpDzI8AkWkzbC9Xv3SvnM82A2+Tmix5WpNlhNE0tCVu78IeL74RGGEYsMgdh
	eMGP+Tcjk8ascbJrpPw5VujUDQEXz+OIn94kPIxSQG+Zikm3+T9/I6QNciEaSGe+
	K39shozOjZM0bMx8NposivIBQwPUMu4p9VyjSCn9gJms80I8s53UsBKzuJuRCciD
	duCTcRT6zAcvsJp1vPeEXerZ9t1qL5LJXZcFlt1B+h0T4JfPDe1zZ+3KL41G+eBm
	/lSeTS+YWFVVLs4cPRvRIycSzo9ETCtKzzBSngYLiyqDWwMB/4tQc+kxh0Zpes/D
	pV7bB3E8WPE+f6msp/LtA==
X-ME-Sender: <xms:i_GkaHY4RxdUT6VzKTNmE_xDXCb_IJT7HLRzMbP7ux2CWFH1qECNGA>
    <xme:i_GkaGYqy45anJBxrBFVh07vVasVmSAb_B3Fiutqm4ZwSi_elDpDaL7uvP3nqnpHW
    I-e4wIbvXTcOcvt1PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeiieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilh
    drtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:i_GkaOJCRgLvYR8bD89YzudyY5ZhXHEps_flHasizAgIrQ--0b9S2g>
    <xmx:i_GkaJ9aDgQJSseti0rMnXpoWguESQJOq3hrR-N6RUUK7CrY1tWcHQ>
    <xmx:i_GkaHzPaF5W2mp8Vj1hCDLUJJtewSCsbvtAqLQpzY1o9c-63nmwOQ>
    <xmx:i_GkaG4bNJ8m9UWzJvIGNbmMPdDUEvyRuhwu8FxUASUeaU_cRb9PUQ>
    <xmx:i_GkaA2JLikUy5tWfeUWCe3PFOjPxIKkD4pB-TxZnONc3VZfZg3e_z6->
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0F2F77840B0; Tue, 19 Aug 2025 17:50:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APe_z1e_AggF
Date: Tue, 19 Aug 2025 17:48:46 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, "Julia Evans" <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "Chris Torek" <chris.torek@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <44ba45b3-6020-44a0-92c5-0844b82be2f4@app.fastmail.com>
In-Reply-To: 
 <CALnO6CDh1PYb40UxPWj=HZgrQh6tj-PgzVqzi2eMimQrn-Ajxg@mail.gmail.com>
References: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
 <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
 <c44beea485f0f2feaf460e2ac87fdd5608d63cf0.1755636370.git.gitgitgadget@gmail.com>
 <011b01dc114d$201c45b0$6054d110$@nexbridge.com> <xmqqfrdnc7s2.fsf@gitster.g>
 <CALnO6CDh1PYb40UxPWj=HZgrQh6tj-PgzVqzi2eMimQrn-Ajxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Git 2.51
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Perhaps Julia didn't use `--keep-base`, which I often forget to do
> when rebasing for contribution to Git (it's common in my other
> projects to omit it when working on the next version of a series).
> Indeed, fetching the published branch shows it's sitting on top of the
> v2.51.0 tag.
>
> -- 
> D. Ben Knoble

Ah yeah, I didn't know I needed to do that. I can rebase on top of
whatever the original base was instead.
