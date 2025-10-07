Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD072556E
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844161; cv=none; b=IP0mTfd1ga8MSgkN+HGAJeonfE9mi/5l/fGX7gRcxPJSuUe3QvmT9kHxoNtzqnAyotzj05wBk8CR8NPIndQZ693rgfNBN+IBUbOFjVyFSxIJkuwKv0xJ2cEWACLGjHY14xEEuMLWbrjGq20idoXoZBoIZ2KwTybrHIcoFiMcTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844161; c=relaxed/simple;
	bh=6H5RB0E9tnhQx/sR110q5cjQDwChAC6188Ut8dPge4s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AFmOOI0Dxh5pR4Acd0FiCHOCgdLgdU5Qz36LBQDv0BnsDqbazXtT8BiFX0xs4T0h1p+QhCi/2izNZ0cSoqljvLXteswb502k0YAB4MVbEUxTv7tw/KQj6AWWDuyCEshhha2x62i3E1p/KLh9tzCzEQkvrX3Z19ivhA4FhJGs6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=Y2H5F4Fu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7xFGy4v; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="Y2H5F4Fu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7xFGy4v"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 87F147A0207;
	Tue,  7 Oct 2025 09:35:58 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 07 Oct 2025 09:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759844158;
	 x=1759930558; bh=6H5RB0E9tnhQx/sR110q5cjQDwChAC6188Ut8dPge4s=; b=
	Y2H5F4FuO+vG9FTi3ObzAsk3NeQhHnzY3+Xov4X39s8DOXCUWjYDYtH+XT/Mpzqz
	e5RrEb/9q08RSpILXHKpn8CrNWfB5gyPqYNDQSBsQrEotvCSdI79UxNCNZYIVm8z
	qPRemu6GTsGxr3EIrky9h8qCsqtiLN+2oTrcIdEI+9ej0AuDmUmuTJUMmEU1Pwas
	RJM9Lv78pPOtFay7BJOJZGnIi85UnHlciCQPrTQSzY7wT39/f2Js406/d3KWVhOK
	hHJ7u5WDn5qOXWUwGvpMJ23upCf/XIESP34uvGfYrqkg0uDwCyjY2SviWvBaLqv/
	ILmwFCFCTzB5pyPzbgRMSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759844158; x=
	1759930558; bh=6H5RB0E9tnhQx/sR110q5cjQDwChAC6188Ut8dPge4s=; b=k
	7xFGy4v/j8DpoQ/IEzFbBmPCG/5hqqTsHC4rbCTHZ30MwHQ16JprhGSfFmi2XcR0
	Z/9eXtTZAndoSWoDqgadPDvt6EbhEogkd0lMpuIJS/KnjMEQuGpPJLOmyPg2NxCa
	MwRa2wHfG1bKGK8IyJECqeVTLg2U1Tl3ON0Uv/Ya1Sbl69DHZitFYyBK1DAxsOUF
	uxmUohYT05klVFxLObETsqFAtK3EPZAOpE7sDtUjPknk8/lDE8Scxh4FfpBFFjH7
	YCylph4/T6LuQHsCAjviwlaAltDMcH7Q5DLoS9EajkN1hhAVMNGFJuHcUwsaoGCf
	DixbXBJv2Hp/glDCych/Q==
X-ME-Sender: <xms:PhflaNWZqUfy5_X4QRIuafUw0hbH4ZrpdfuRkGyvMNzeXMFQ6CeCjw>
    <xme:PhflaIaxVkXHOHICoAa_4BDB7iyxJ5xqJYuuhtDTLVjzEg1uJTSbwROYkh76hW5Sr
    7Xcof3tnVm0JwIPzMY7Zk5XhCKwNaAeN4G-UTiFt4QmhwGtYekwSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    eplefhtdfhudeujeejkeelgffhgeeuheejjeeitefgtdeuveevgefhtdfgffevueetnecu
    ffhomhgrihhnpegrughotgdrihhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhulhhirgesjhhvnhhsrdgtrgdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgr
    sehfrhgvvgdrfhhrpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PhflaC5ZcCqafW2dRITOmzoklpsdsvQQQaGa8dnjILTY6mC2mMtSkw>
    <xmx:PhflaNZ2_qEeLLVsY6rmiNNBmmr52seEHpVcFQou6mW-Bf6Xdi1-eA>
    <xmx:PhflaBiaeu4Tp-dFoy1JesnhSzBoc6PEwLIjcu3ZnUTpjqWFnDMzVg>
    <xmx:PhflaO-FwZI05lNyScpAfMR6Bjid16IbjoMPzRTDiRPGVrs31TmDQA>
    <xmx:PhflaHPwcUWy7paMvUmszsXbtruUDAbPnXkbB0l1Jagh9eHY_TW9XhNg>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1774B780171; Tue,  7 Oct 2025 09:35:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiyWxa7EEqz3
Date: Tue, 07 Oct 2025 09:35:05 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <80f61c1e-8e0d-4a7b-868e-876091595e3d@app.fastmail.com>
In-Reply-To: <48224822-9f8f-4230-97db-a7fdefa557a3@app.fastmail.com>
References: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
 <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
 <10a9718421aa842573a2ba1ecf58d2cc46b5edd9.1759777131.git.gitgitgadget@gmail.com>
 <48224822-9f8f-4230-97db-a7fdefa557a3@app.fastmail.com>
Subject: Re: [PATCH v5 2/5] doc: add an UPSTREAM BRANCHES section to pull/push/fetch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 7, 2025, at 8:23 AM, Kristoffer Haugsbakk wrote:
> On Mon, Oct 6, 2025, at 20:58, Julia Evans via GitGitGadget wrote:
>>[snip]
>>
>> There's also a very terse description of "upstream branch" in the
>> glossary that's missing a lot of key information, like the fact that the
>> upstream is used by `git status` and `git pull`, as well as a
>> description in `git-config` in `branch.<name>.remote` which doesn't
>> explain the relationship to `git status` either.
>
> nit: s/either/, either/ ?
>
> I think that would flow better given the long distance between the last
> punctuation/comma and the end of the sentence.

Is it the norm in this project to provide detailed copy editing feedback
on commit messages like this? Of course it's important for commit
messages to be accurate and to explain the motivation behind the
changes, but I'm surprised by the attention to commas.

>>
>> Since the `git pull`, `git push`, and `git fetch` man pages already
>> include sections on REMOTES and the syntax for URLs, add a section on
>> UPSTREAM BRANCHES to `urls-remotes.adoc`.
>>
>> In the new UPSTREAM BRANCHES section, cover the various ways that
>> upstreams branches are automatically set in Git, since users may
>
> nit: s/upstreams branches/upstream branches/

Will fix this typo if there's anything else to address (or if folks think that this
is worth a re-roll on its own, not sure what the norms are).

