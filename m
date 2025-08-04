Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC379F2
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306294; cv=none; b=PrURwFQatAdgQ7Vo+cZzd62ZkWbSgQmyoxWNBryVB9UKltOFe37NBbL6h0zzQQDK0akeDJftx1jvFOHHOBJTIaHm1x1qSLzy6kJbz9J1Osxe509ji21ib5Xyqqz5UdtFrMREuiMYmEzffRZ7zpMGZfQXoZM8sniXm29taIYdjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306294; c=relaxed/simple;
	bh=TmsGduaC4RyhpTA0R7fDJH0x/m4OT6zUm2GjDXdNzHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILQA4SQGNj011Y/jy+p4tJPdOJ3jD12ROChXOU/F/2SxpbEEhfBspvnYFXz4prFbyjN2F4GHMMb04sYJC14453BWlVARRk3RrjJM7r6lLFlstrafIC2BJDd5cqf3HA5P/9fR8I2WwJrcJACptXKNesMdhu5TFIviW8aaKNhaLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KitMZZtz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GRtPPFkK; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KitMZZtz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GRtPPFkK"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8344A1D00113;
	Mon,  4 Aug 2025 07:18:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 04 Aug 2025 07:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754306291; x=1754392691; bh=2qo3xvn/Eo
	Eu3nMkbNKqbFZtOJP237PaHVs6pVlLnfM=; b=KitMZZtzMEiumzPxnLxrfEzsAY
	P77dQ6V5QXMaCFDiEjEbccD5yg74H8PrxwKpHNOm94C3EfInW1zBDkrBCU7QMFwy
	CTLB14tLLMyF3kQKjzsUoLQUY7QJzPiJTMt1TLgXt6u7V8SVDKYNzvpW+c5Smzk8
	vDUodTvwSKK84hcyqNYYyoXLSp9vg29y0yEXFRiM3F4+zfZGUZVfJ65Abm/K/4hh
	zjZ8njo8asPO7AI6MYKU6dH7jJ7cOdfde3HKKjUBM7KpXtGnncD0OXVvLK592Lw3
	gEWRlrWQ22F6k6rWauWLdPWISLIl5F+3SmQVgMy4XdKTmpOeuXIT0oZjjvFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754306291; x=1754392691; bh=2qo3xvn/EoEu3nMkbNKqbFZtOJP237PaHVs
	6pVlLnfM=; b=GRtPPFkKeNR+lWACGnHCs/H8iS/Bp2/cv+KMKxMo/z2Xatwn8Ft
	OaVADCZPUsmALKNK3HwySC+OwghmOpUooF2vzpOI/e7BGkBbXWPrA7m4ktppj1Wn
	OwDMKSzB6kFBtvwIvgnU9vHkhcahxWe8RukrblgB8Xz7VmHJW3jXlakvx/Gk5LhB
	wH2SASZBDMefUhYlAzPwCC8m6qxGtJF1kSXVNJGQMQiSzrIlsJzvyoMHxwb8yCXN
	NKZamjfkhLGOUPsekup30sayV1gMJwEg6xqt9YP9/oW4xT8wj7m1g7cZDGyLi0YL
	3L/dDgGQV1TiOVRkTofrtLH/R7HjXSvaITA==
X-ME-Sender: <xms:85aQaBxz_DhZFnxEhGGreE6JvEJwm4LXtXLy6yIusvlvdTJ5g6iuEg>
    <xme:85aQaBchAa3BiP-CEvxEvstq4qPXd5luYSTPfLDOaAlJpRX9bsDNeHsIiDqWm1fw3
    y6Pa3eJ7NDTvpCTUA>
X-ME-Received: <xmr:85aQaNIJREg80RLUERvfrWJH1pMFbLEPgwrB12TthOA3912vgEyIwrxePN7MWCuo5AAHzPiJXsmzShRnBs3b9ALpdqWGvs9xutlSqVO19LI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshifrghlug
    drsghuugguvghnhhgrghgvnhesghhmgidruggv
X-ME-Proxy: <xmx:85aQaCFYKfnJtgoFQqwYtHpIHdwxsA98_HrM7fPSMU71Z8p025_aXA>
    <xmx:85aQaHoXzLUflY0vg_oQFv_YpuZ91eQnFxE9Rpi4jhmCikfdsSWzMg>
    <xmx:85aQaLRNChGErBaKETfKAIz3aqbh4M-7QzuqnlSuOhK99tRURuvVUQ>
    <xmx:85aQaEPF9O5atpZ2SRD7pF53Yw2xemxD4XlzEAvgJfnY20huRfcuNg>
    <xmx:85aQaAJCrodkdaUAgJ_eWqQ3fIxocDoGnnrety_yHnPIGtuM5DhUxJJZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 07:18:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45488b5e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 11:18:09 +0000 (UTC)
Date: Mon, 4 Aug 2025 13:18:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
Message-ID: <aJCW7aYqJB20LDNg@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
 <aJB5uKFdGybf-IbN@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJB5uKFdGybf-IbN@ugly>

On Mon, Aug 04, 2025 at 11:13:28AM +0200, Oswald Buddenhagen wrote:
> On Mon, Aug 04, 2025 at 10:17:18AM +0200, Patrick Steinhardt wrote:
> > When writing a new commit graph we have a couple of counters that
> > provide statistics around what kind of bloom filters we have or have not
> > written. These counters naturally count from zero and are only ever
> > incremented, but they use a signed integer as type regardless.
> > 
> > Refactor those fields to be of type `size_t` instead.
> > 
> mind elaborating on that choice?

We tend to use `size_t` when counting stuff.

> it feels like abuse at the semantic level, and it increases the data size on
> lp64 platforms. is it even compatible with OPT_UNSIGNED (in later commits)?
> that would be unexpected ...

Yes, it is, starting with my 2bc5414c41 (Merge branch
'ps/parse-options-integers', 2025-04-24). Regarding the data size I
don't really think that matters much. It's not like we have hundreds of
thousands of commit graphs in-memory at any point in time.

Patrick
