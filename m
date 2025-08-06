Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8785273FE
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459631; cv=none; b=TVQrE5PCEztOoq3X3AEH4Zfrbkq+fwt20lgDxyzcEAWZ0U8gPw0phouJBROCWsDO5R2y8x9hOGh9gTlEMKtKC/i3nLmG2DFwat1gZ2Gsrdg8rsfjBYGzwSJkbWzMuQdhneXSiGiEn9/SLJZlGvms8gLg563/jlLMgG2L737VSQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459631; c=relaxed/simple;
	bh=K7XmW1KdrtxrhCDUsnKjmYaTXCerD6Nr1sBUd0XUiRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT4sptRSm7WT73sYi/BGyg8woj2EhR2DJK0yVQbKTbyGS4sTbqf5rYlYBGX9DFY8Oub9ezTWdW/c1Plf9ZMWiWg9gkAgDVO68Z/YWeMm8sgO59oyhWs/g5LMEIL9DWSuULG4ur2seUfzOSyYq/iVCfrlray3qaPyYv5Y/6SyWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AxFf3+B+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvSZhMjK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AxFf3+B+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvSZhMjK"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E3151D000DA;
	Wed,  6 Aug 2025 01:53:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 06 Aug 2025 01:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754459627;
	 x=1754546027; bh=zPDJ+IQ6SqGQKkIhy+lEMlkeIVKfhe9Ido0b+uEI4BQ=; b=
	AxFf3+B+0FQzT8KooZGdR6+1DZuzJY0ZRnr4q7xmkcu6wt2dqddh/sFUowyzO+it
	7hQ9AgDwfcuIYlnn7frnf3KhwoPWPAjiEgkJ+UmknD+FVGm/tz/cSiCiNRsXsBmW
	/x65Wsu9sem6uLylTZT9iWf2iq3+BbD28ZFUJaZRFqPE6mBlUpMZe3aq8mfNUeOT
	eIRFoZ6xOhgVrw7aSSxS+Uc4GTlEM3ABAXE5Ko5EH+N5FdgaIihnyNw1+4Pj2Neo
	Wf7bhDqFWFVDHAPBq/8aisAgniVTRnD0Ejv4+APpzMjiOV6A5dPv699IvAbh0RUu
	qoxx6CKrNymgLmCW8/9Eqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754459627; x=
	1754546027; bh=zPDJ+IQ6SqGQKkIhy+lEMlkeIVKfhe9Ido0b+uEI4BQ=; b=X
	vSZhMjK4o5LB23NhkXYSaeLHwXDj784rJ9hhRgEUzYxGaYQZFH/3iNx/wxIPzd+A
	sm1InREHIFGjPipV06uwQR4FzlOwfmvA/e50SCWPOeNVXrS0U5Nh8/lloTtvQb2/
	0O0ci/JD6BtgjLy6Q9fxWQEYAtzswYpq8Up5K+/G30z8Jox+WwPlAkKnPp/086f0
	rLYChsJMb5mM0HiIJNohc/OQpowGkjGtkljr+PIHfW/qCxPPJQXgTCaT9b2vOfyp
	YG1ngubFzTK51WXOrhc1wbjtjtdT3sbBoRmdIfIWU63YaOIQV06gtLgQvD/HTIxK
	TSjomrIs4hw/wwTeVeAhw==
X-ME-Sender: <xms:6u2SaHwOn9DxVBRY2dPl_dwKnvWMryPohD1aLtcco0M04T8cvO7kLA>
    <xme:6u2SaK_LshB-3EbyQQwnZWcQMBjFe7AxY3j-YRMm9PvvGNK8NFY_9EeOg0D3kTmgp
    08uAdGmnqmWyhyUQQ>
X-ME-Received: <xmr:6u2SaNz06HaY1dmQnUyMz38XW7dDqXOAyEf4Zf3AYNVVR1OUHFOHPP0J9ZNZbteS4i2DwJBoteHPH6TecwiK8X4WAdXjkugn_HCotR2K6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivg
    guvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6u2SaKrBG8xHISk4nUgiB6Qo-XAkKJmsLPjVMEVLhSHSvfVgK53HPA>
    <xmx:6u2SaOqoiqXChiSLvrkQ9OcfP1OBkuD1INatE1HPf-3vW2j5Oj8EfQ>
    <xmx:6u2SaKCQREeV7S3_RDBq8bROGQvxH_oi6Syp7Gi8aIacg1athsBwtg>
    <xmx:6u2SaMtkE8i9agsYtMmFcfxOunatDqP6na9EMSKY3F3Vl1RgU1sz6Q>
    <xmx:6-2SaAGLND1AIf1W4PAcW5Q48DLhTmswkVnO35tfmmvdT06pxcf6wRDv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 01:53:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42490e0f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 05:53:42 +0000 (UTC)
Date: Wed, 6 Aug 2025 07:53:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 1/9] Documentation/git-reflog: convert to use synopsis
 type
Message-ID: <aJLt3pkBpIuPYA99@pks.im>
References: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
 <20250805-pks-reflog-append-v5-1-050997db09d5@pks.im>
 <5910515.DvuYhMxLoT@cayenne>
 <xmqqqzxpxwxu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqqzxpxwxu.fsf@gitster.g>

On Tue, Aug 05, 2025 at 02:47:41PM -0700, Junio C Hamano wrote:
> Jean-Noël AVILA <jn.avila@free.fr> writes:
> 
> > Be careful that with the doc lint series I'm proposing, this change will raise 
> > a failure: one of the tests checks that switching the main synopsis to 
> > [synopsis] is linked to switching the definitions lists to inline synopsis, 
> > using `backticks`. This check may be too restrictive though.
> 
> This is what I've queued on top of your topic to prepare for today's
> integration.

Thanks. I see that the fixup commit cannot trivially be applied to the
first commit due to a merge conflict. So let me send a new version that
absorbs the fix.

Patrick
