Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C22DCF41
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764577735; cv=none; b=DgSKYH43ugS4k0YPsJbyBhoTLG900PtgFj4tpUHyUGBQQ2NA7h8RYHhHhv9VhQqHPb0s/msEWRdO85lEaYyO60+ww7ztHDZS6VTehw0E3wy5LSzVBhZdSaXr1+7lqFJPi5dm0Sw0Kkx8pVmKaZvXTqnHswm1HbPROuWpox7uD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764577735; c=relaxed/simple;
	bh=PXc+sAoIUd/kT6BFHWYaC+ZX/dANWbhECgP3+Y4IN34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnBhmriqzqekygISZZYC36RZv9XJk2ay3OnRe1eOxjQ3wozXzCS6NIhZMOapgc2nUkdTYMvBiqb6+3WCFktTaqpUccOLE/3oBpPuyKa++JtzBWaM684IB15CbghS0ZDnGUtDs0Pw+PpUT261u8NxtCW3JWNvI7d1vgFlelXSk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d1lP+iJO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qhfHP3oT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d1lP+iJO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qhfHP3oT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7BE78EC08E5;
	Mon,  1 Dec 2025 03:28:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 01 Dec 2025 03:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764577732; x=1764664132; bh=pPvpmaWnLV
	pT9VHlNzivRg7JwZMEvavbvz8Q12AX6II=; b=d1lP+iJOfai0/c54ptYBp7ejUy
	y2+ur4m955kgDx3Cdl7hMc3Er5sskAoLlH7Jb7Yn7o7xJFpoywxjpj1tbK6Tt0wE
	8pOiQIZpPBa6wZxxg1G9qJ2Q8shColqMicjoPKA1VvLSq6I8nCV/Q5WzQSP+WCv6
	hqwJGTTaE/5L9vM3RMLi5QlkSwU1T+JSlPL9inwA4iz2nFyE/1LIY3X1KiZoaEHS
	/imKM5yTCwoZhqW8W/d7ZpYIg0+IaBu986x9KrwKbwWX4PdUG4QdQ3Fb/EHS0n27
	p2uTn8e7fQFLUenH3QRVR0/XmP3yHtoDn1p6XBjXd+uKs1uJzQRs7JRBnIZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764577732; x=1764664132; bh=pPvpmaWnLVpT9VHlNzivRg7JwZMEvavbvz8
	Q12AX6II=; b=qhfHP3oTIovokXa8zHxOWughZBzB1aztD4Ccogbvfh0fZORtcjB
	0mPG1D4rDaI9wAjuT3XZO8n6fnBdMzf5AA3ftHu1Wede3XsVlVqnNu48Not0VTMe
	U2i8ERQa07jkiwOZlxIbvxay0GMghPj924vPXyBq/1KStxatAq5QSSDsexBlvUr7
	Vx/5aqYnFmtYxcDKp9OCO5WgCUvCBGbhrKVH/lI7iwZjPGwGhTXE9XyVI/D34ouc
	7gHRRtCRJVRA28/jIgL1xOc7ZgnpBhrl1lrsnuT/AAbde7FBumJv8fULyDzKfQw4
	2K5uawO+uJ6jyypRR7D8xJsuh7c+qDloVGw==
X-ME-Sender: <xms:xFEtaVAeGU03lO8iZNGKfeV79c_wCbnkSQC5xyHlfOUCsB_JAKU-GA>
    <xme:xFEtaaiI3BmwUMf4H-yvIlvRfKBNyeHOBYJ-Kpq9UgwukePt69tqQvcLst3kwop1N
    J61iCl8QdLBJnC7hJmuqG6bzhjDVRSOkDsrfMlRXgZiyRqd3Xb9vMU>
X-ME-Received: <xmr:xFEtaVktdz5c2jdDpkT5SODbvBu6C57f6R2cqDrnzC45QeUhYWRnXEkulTUNpnitTPmOr4txN82H_Km9ASEH9p-ZtkfEm7oo0SbL5I2e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:xFEtaepSqIDY3qidZWcaxpf-h010d0lGS8E3Oa9d3Qcg9tew0xwoTA>
    <xmx:xFEtaWG_IgucNszKqdUJ07n9W0WXbop9Mn-jttcIeX695Nj_HhQeuw>
    <xmx:xFEtaSzwvs-lyGjryfjlI8RlhJh6gSwt-6cs4AKn79Gs2vgUsL3kng>
    <xmx:xFEtaTrejhhHiLYb3bgDD0xGFVkq5dg6F14QwCellxyJR28WsGtpEg>
    <xmx:xFEtadEc3g38PO1oa2dxIO7JQis-Vfnqx6rbSwvd7-9KzzjvxlP2ifu7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 03:28:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26cad336 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 08:28:50 +0000 (UTC)
Date: Mon, 1 Dec 2025 09:28:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
	jltobler@gmail.com
Subject: Re: [PATCH] repo: add -z as an alias for --format=nul to
 git-repo-structure
Message-ID: <aS1Rvy9J2KjWrQb4@pks.im>
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
 <xmqqms43aqn2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms43aqn2.fsf@gitster.g>

On Sun, Nov 30, 2025 at 06:21:21PM -0800, Junio C Hamano wrote:
> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
> 
> > -git repo structure [--format=(table|keyvalue|nul)]
> > +git repo structure [--format=(table|keyvalue|nul)] [-z]
> 
> It's a minor thing but I wonder if this should be more like
> 
>     git repo structure [--format=(table|keyvalue|nul) | -z]

This discussion rings a bell -- didn't we already discuss this for `git
repo info`? Yup, indeed [1]. Initial versions of `git repo info `-z`
also had it formatted like the above, but the discussion eventually led
to a version that is the same as the one proposed in this patch here.

I think this ultimately stems from [2], where you argue that it _is_
possible to say `git repo info --format=table -z`, and the last option
wins. It's the same for `git repo structure`, so I'd argue we should be
consistent.

[1]: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
[2]: <xmqqcy8frqn2.fsf@gitster.g>

> > diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> > index 36a71a144e..5a50acf345 100755
> > --- a/t/t1901-repo-structure.sh
> > +++ b/t/t1901-repo-structure.sh
> > @@ -101,6 +101,12 @@ test_expect_success 'keyvalue and nul format' '
> >  		tr "\n=" "\0\n" <expect >expect_nul &&
> >  		git repo structure --format=nul >out 2>err &&
> >  
> > +		test_cmp expect_nul out &&
> > +		test_line_count = 0 err &&
> > +
> > +		# Check -z
> > +		git repo structure --format=nul >out 2>err &&
> 
> Didn't you want to check "-z", not "--format=nul"?  In addition,
> perhaps test
> 
> 	# "-z", as a synonym to "--format=nul", participates in the
> 	# usual "last one wins" rule.
> 	git repo structure --format=table -z >out 2>err &&
> 
> as well, or is it too obvious (by knowing how parse-options API is
> used) that it is pointless to test?

I think it wouldn't be pointless given the above -- we should verify
that the last one wins, regardless of whether you use the alias or the
long option.

Patrick
