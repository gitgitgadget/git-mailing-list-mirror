Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D11F3FDC
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 06:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754287416; cv=none; b=rvFkHq8XvCDhKARR7FxrfGxP51Qw6Hn1/euyTX0tBORDndz6qIA/hI0zuxk7b6GBH5MT0uPiKAjxApEvuCA7ume7AihVik3i20Ri4nhIe9RRWSg9GCGIs7mQjNm820BcqtJP/olyghry1yQx8M4G0CRGPRPkC2+hropIKwJrDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754287416; c=relaxed/simple;
	bh=zFkrWprSaysxXPAWil/dQSyofNQ+JjqlmjaLZ0oNdJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SosYCSFKFOdonBfm31/36FqQxAy0pxm7MG1GUFiwetFWkcNKU/ETEWeMcJkFwuYpmy8enTcQ6pgNRlcfzWO5IPgL66vzbnZtYNgLYGSmqBY9I2hTPUyYAUAxKcXVCSnMACvHx9yEWfofPs0r4ZqNpsGQmBK5fbp92083Xz8ackE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J/PnEGtT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UGROpcDV; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J/PnEGtT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UGROpcDV"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D0B141D000FF;
	Mon,  4 Aug 2025 02:03:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 04 Aug 2025 02:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754287412;
	 x=1754373812; bh=lB5J3te+FQQqFAYLc0u3o1j8MWZD/WdMjDfiOXbkbz8=; b=
	J/PnEGtTQvGcjyaKqNOKqowjHnM5TWpt7g9PqC3vEQgSBjDn481Q+4yhEedh8Xt1
	qkII7/yLkk9Dm1QBrbA6ZsWacQ+dYIqYKwaifpydXHDEwTaxy5Uld5CujflBCyrh
	5HNAdfaivKke30hGK2VqPYvaPXSZAJylJQE1adQ6QPozSr6Q6LPmPvb+bp1FUELm
	CTSJAY4WoBhlVswgY0j81GuaY9ID4OGnQ3g1Ccsmzy06TnjufJjYbwo3WxG0/zjc
	Ye9i+HxTVYCx5BOOIZT1py5w/dEnXRvzqQuCQ8GUGkd4T/KZm9m0TY+jDQ/Ng5Hi
	7BLUf1QBYo+cGYJxeQEVBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754287412; x=
	1754373812; bh=lB5J3te+FQQqFAYLc0u3o1j8MWZD/WdMjDfiOXbkbz8=; b=U
	GROpcDV9XijAt4ax5uU7ZvUiMU2+Siv1+kOCfHYcAoKLiGRI2mvnS9Df6Tl5+L0j
	g6tZoR+e8C2OCwSplu6mM0iPYPdQfPWRUZyOCK0li5l2laJILvh7sa9wKqbPnhHD
	QSiQZypS6ZvMs+p2ZoTZrfACgppW4CB1HZLLq46M7CLc8U0zAVtpQwEf+zrM5A98
	mF3gp3xTmh4iCQbz5M7pwMkSR0pSvzAclbRl3D7rPRCgm/D53c+StpQ181zvwTPY
	+lhGM5fZYg+IZcxX8+KJhY15eigkV0CKITPSZwq7SR0QsxDnx3AMl0c4qs7gI836
	riqfMvUXPwUPEHeSfonaw==
X-ME-Sender: <xms:NE2QaPUxUXceVpW6iv9FwADC7LACvdm_urIjYA8n3mcQCCZcTZYFXg>
    <xme:NE2QaHxZmXgVPBX3fbSwcXSTQHiyO4ndmY0MyZ1OCbJxSmXha4LQoL4cH2k4LeSmG
    lrs6ZTd4AWvky73ww>
X-ME-Received: <xmr:NE2QaNPK2k3kQpECtpuWSMcwqaxdn41Ghi-UU65M2fV31BSXa_zpig07KGifajTLDE2wuovyjfzpk39ofH-LtmeSzEQH5RR__6CaSUib05A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddtveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhm
X-ME-Proxy: <xmx:NE2QaI5rrJYIjPtTRdKCa2xGOBpgs86y9jH36Epheno56H9YMBng4Q>
    <xmx:NE2QaONKi_hYXUGWb-e26ITNp4-jzirI-HvxHhYmop30beCCOjHFjA>
    <xmx:NE2QaGmHb7f7pbqVnlYFC8_qZTMiooiaBmx4V7QEPRZOUT8aSNrZaQ>
    <xmx:NE2QaFT1wuLKST4KWxDt3wsBzA8dDcCqJ9NLCPAXB_VDx9NHJSsHVw>
    <xmx:NE2QaB5MUxeGteeUNn8JtUEe4kywTtnXwiYJdvgA7VVa4nRGJ8GKCp3U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 02:03:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7dcc1f0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 06:03:29 +0000 (UTC)
Date: Mon, 4 Aug 2025 08:03:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] reftable/stack: fix compiler warning due to missing
 braces
Message-ID: <aJBNHzE3RQBZZTcU@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
 <20250801-pks-reftable-fixes-for-libgit2-v1-3-f446e1c33cb9@pks.im>
 <CAPig+cSeYUenjTm54higv6ANCOw0RJsF1hevS_p71=sH3c+E+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSeYUenjTm54higv6ANCOw0RJsF1hevS_p71=sH3c+E+Q@mail.gmail.com>

On Fri, Aug 01, 2025 at 03:19:52PM -0400, Eric Sunshine wrote:
> On Fri, Aug 1, 2025 at 10:48 AM Patrick Steinhardt <ps@pks.im> wrote:
> > While perfectly legal, older compiler toolchains complain when
> > zero-initializing structs that contain nested structs with `{0}`:
> > [...]
> > Silence this warning by using `{{0}}` instead.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > -#define REFTABLE_ADDITION_INIT {0}
> > +#define REFTABLE_ADDITION_INIT {{0}}
> 
> For what it's worth, the last time this sort of issue came up[*], I
> believe the ultimate response was that the project ought not pander to
> this particular instance of buggy compiler and that, instead, an
> individual developer should, if bothered by the warning, use the
> appropriate compiler option to suppress the warning. Whether or not
> that attitude should apply also to the reftable code which is meant to
> be shareable, is a separate question, but at least that previous
> discussion thread provides some background regarding how different
> developers feel or felt about the issue.
> 
> [*]: https://lore.kernel.org/git/20220710081135.74964-1-sunshine@sunshineco.com/T/

Yeah, in general I'm also of the opinion that we shouldn't bother. But
in libgit2 we have pipelines that use such older compilers, and we don't
want to drop those for now. So I think we should treat the reftable
library specially, doubly so as this is the only instance that causes
problems.

Thanks for digging up that old thread!

Patrick
