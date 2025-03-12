Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73531F4181
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765334; cv=none; b=ohp/s+QXWA+qcJJscefKIljDwycYNtnvm4Yer+C2XX29z4G+Ez16fivRqWY9HGHiDqQY269I5NAF2pPK03XomsZYDtDxC26BW+UkXaFaMHqIDQy+i4S8XtAraMXV0pgYLqHcR58rAPcRUBqKYBfybm9rDh0qGUsoplNH+5p7BDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765334; c=relaxed/simple;
	bh=RIKOvyzBJHsG7niHbx1bzpCl00rLlHLI+WGchM6dW1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZ0q2059M+tlQuJV/nBmsJp5Pdi7FN0XQvvFgUW2rB2VllVUjkUb0J4Gek+tihdxaoCsFJQU75GJ8RU8zJ9e6wbjbTa3Hx1mLgttj0KG14tUaS+xr0EWfaLvSk5B+VvIYdnJ6e711kzfM7746Y9oIxV2YouqmuLKDAt0p8ronfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ScvsxTL0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yp8unK7R; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ScvsxTL0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yp8unK7R"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B017E254028C;
	Wed, 12 Mar 2025 03:42:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 12 Mar 2025 03:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741765331; x=1741851731; bh=GtxNjvWfMp
	O77EtlLtgLqlNC5/CXjfVLL41kE0EGbBI=; b=ScvsxTL06ASHIiJU5cWJ5eJBCN
	Hn+RBNAtUTAgYtyo4CuZfHuRKHAKd52gOTBRPHg0AWKR6AHVZ5J7tgdJ7G/8qq2c
	DT1DLfMxNm3tPkFrLSmRA991H5DFSg26PK4zEFCG4dOAWflHDOu81Vw5EPQvwxjs
	FotvcDOWaq6PmUPdubfOdkorZLkMSaDkZCfB4ionVnlToqhW5NjzjtKN9GYDCL9X
	9UhpgYR7abwljnfLPhds4a6d0qZIas747NRHMMzm54n8szU1VAMSY3KeN38GkvRP
	hO86jm5TjiMKu+GE02cYOxcniNQT3WJzZt0NsJXghNFRBMouGMDKpCtsFb/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741765331; x=1741851731; bh=GtxNjvWfMpO77EtlLtgLqlNC5/CXjfVLL41
	kE0EGbBI=; b=yp8unK7R/HA5zZ1Nv4xK6gawSrVv9b0lPfYWL0XlmCZm8IilvvI
	n30V5aaKOSw7xve1WOngL7zb3NOrHLk+xjcBsDHXwBsf1EGBpEZj+3LaZMtLDNAy
	SXcRN8kSZLKE43nSYfYibol4uM16o4nU2mQO8LHLIJp5uqdHDF2LfLw4PmiID35u
	MZvkDeDCf35Fj/9Ig2CLcuaRjXpkpTMQnWI78YfOTx63S0tyoxw+4T0H3YZtUzlm
	jQbmaQ61jLw/nYGTzEVnnEdS3VJLFRcRziEYCQ0d2AfRGj9t6xRu6IEuzszUm+gx
	bDUahg9i/t7HgCVYrSpYGpEy5DeiPJiNgKw==
X-ME-Sender: <xms:0zrRZ-JMIkG1OOMLIYIlQXZKDOVNbR3YXQqU1g0GxtfomcKEFk-xoA>
    <xme:0zrRZ2Lk-7Dcpx5ATbaU99V-dYyzKR1NKyyXoTiYCEysW64qiAbzmz29Zxayy0kar
    1lSXjSscsIbxA8icQ>
X-ME-Received: <xmr:0zrRZ-uhKCg36mvRieFv3jE0hzu2Gm_G1uMjygIIWyNbt8TAPiurwsmxdzZ_vGQvGuVlheNdXxWccIBnmHdiR5LNW_1SbErVifJvTrTaMCsvak217g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0zrRZzZ_Te6I5W1F9KtuxN5lRr-yuQ4oOSjSl3b6xR8RSGPTx0X7IQ>
    <xmx:0zrRZ1ZyVW0BSwGGrdLRR1_PlA8dCh12smodwRLN1K9Cj36MMH6yHQ>
    <xmx:0zrRZ_COSc65LmMdJEk5R7U-59Sd5Gb0m-CRwJgY0ZewTZ8e4Uc7Og>
    <xmx:0zrRZ7YNm0NBjIXz-lv-63i8vrlV_6jD_62l5dDZUI5FwYNtNC4Hbg>
    <xmx:0zrRZ0VdwF4tnjTkN4b4ucLRN2XiDNwuZ94uHtFPkS9aNOrvtwVMVrTw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 03:42:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7bcbe281 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 07:42:09 +0000 (UTC)
Date: Wed, 12 Mar 2025 08:42:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <Z9E60LG6ExSJzmuo@pks.im>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250311235720.GA73755@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311235720.GA73755@coredump.intra.peff.net>

On Tue, Mar 11, 2025 at 07:57:20PM -0400, Jeff King wrote:
> On Mon, Mar 10, 2025 at 02:28:25PM -0500, Justin Tobler wrote:
> 
> > To make machine parsing easier, this series introduces a NUL-delimited
> > output mode for git-rev-list(1) via a `-z` option following a suggestion
> > from Junio in a previous thread[1]. In this mode, instead of LF, each
> > object is delimited with two NUL bytes and any object metadata is
> > separated with a single NUL byte. Examples:
> > 
> >         <oid> NUL NUL
> >         <oid> [NUL <path>] NUL NUL
> >         ?<oid> [NUL <token>=<value>]... NUL NUL
> > 
> > In this mode, path and value info are printed as-is without any special
> > encoding or truncation.
> 
> I think this is a good direction, but I have two compatibility
> questions:
> 
>   1. What should "git rev-list -z --stdin" do? In most other programs
>      with a "-z" option it affects both input and output. I don't
>      particularly care about this case myself, but it will be hard to
>      change later. So we probably want to decide now.

I would lean into the direction of making "-z" change the format both
for stdin and stdout. That's what we do in most cases, and in those
cases where we didn't we came to regret it (git-cat-file(1)).

Patrick
