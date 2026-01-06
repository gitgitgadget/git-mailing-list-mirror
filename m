Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B9254849
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714092; cv=none; b=arOLSWuviuGFnQHs5qXigQBbdGKWaTBaVXgei9BWGbEX4pbLg12Abu/r3MxGLum6D8AsWCCjCVOkXQp3gWntL+huTDv2MkrT9m2OvoOKkSUYH8TwtKYLOFsFd3zXryg+xetRv5+BP/adUoWKbb6RCE+SOnKfrRdfsYo5Utwi5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714092; c=relaxed/simple;
	bh=XjCbNzY5S5HU37H78cFZPFtv++U04G17UDmcCGyBA4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2Gplkn4uMcmkeaJA1NMiJ0vUzHJOSJXqeTGdJkkdK2yT2T9dYnKsdDi3aN3fbjhJa76mKODZKB9Y73ijqnEhVh8Jyzpnegz1vIY1AGcIRU4G807NlJV8E2SbEk2PdCm2w5PzZhS9HKlZS8ckyGp2DogFh0VBciXPLpb4TFYmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bULKW4np; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TewCtkmy; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bULKW4np";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TewCtkmy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 31DC97A0040;
	Tue,  6 Jan 2026 10:41:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 06 Jan 2026 10:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767714087; x=1767800487; bh=560E2srz8+
	DV7fCbAZYOj3SEOPeuVGje/TuFz+rpeNo=; b=bULKW4npYgwkBAq0P0bUJ1OlmF
	BQ2ei8oai3ZF0hn4S+mGfs3Tsf0216fFVxvUc0Ng3i929ZxqdbdLpIVfzJ3vYrdV
	26ktXO9YytktBz55+pdwPmbbhgeMjdoCkz5z0rfjMgcPuo4VIuDArqMDKBw1ZSxJ
	ySK4vB3BANM8KzD+CCja8T+NUP/JBehyV6mgbWincO+qBRuyUcCQpsIbyiM5rMkh
	Mw4LC1HuxncYoKjCIe39jm8QdWZAZM9ALng2AwomIFbjUbFAEff/vJD3e6JGT/Im
	P86FmzhuyWKLaRgXSnZZDN7bxpbZX3IZ4BRUsrxvJNPaZylKCIiqHo5kmkMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767714087; x=1767800487; bh=560E2srz8+DV7fCbAZYOj3SEOPeuVGje/Tu
	Fz+rpeNo=; b=TewCtkmyYufilZOY2oc+iCs12uCJTsSIhvaosWmAuubQSR8iq6M
	6meUQqwU48r9V1h6fqWX9yT2CD33QqJkP7m8k/Oznj1lPL8s20txiUVl3zjjn+ra
	PiRmuyMDO0zgG9BsW8G4VXU0KDBzyGIMrFtJKrgFQVIGHcgYPvv1EbCGCaNSpqVI
	/iGZxd6udkApZQDJmUXKIvYjNY4yLZkZcJ46INUN4V7cefA/oJSPIkq3m+LaI9xm
	AilmjBEQe3bdNp0ffdxWQ1chNHLggSyLaCXfahUqYOYinxDckU/U7nIOb+oVEruc
	7j1fZu65XmUk/bFVG8zctylpfYMlfUatRdg==
X-ME-Sender: <xms:Ji1dace_nn4m9r4K-kHq2gtfa5xmntZDTudh_Vd5_61Jd41y1RksVA>
    <xme:Ji1daQxSDBpfmaWAgJxL7NIi1o9ZnptmJx2TkfdGgWHjl25s2BnyXZnw5vQH5zzjE
    Oom6_3jxTHp3RwJc0-bNJmbn5Hedg-7IKLNV-peLS0zEuHSZpCwPr0>
X-ME-Received: <xmr:Ji1daRKMI7uZTNPi2PWvRV9L0XHSnGebXYW0yMftWJ-s_5sD2sds0h1BD0MPFI9rtdHMZf4OdFLWS4PKEK0h0tC8oSKM_qjAZyKGgsNb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrg
    hnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdr
    fhhrpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Ji1daSGFH2iqtItL3kXZii0QaEO7_vObpFT6fcqjFcSODaVTY_SE0g>
    <xmx:Ji1dad-E84DuZxR4TmYkflY84Df7mZJj1U1wutloQlSFTAz3YPUKQg>
    <xmx:Ji1daSKjRaJMXc2hjrO55a-NIy6uEMRaISs93Z4eLvGvSLG4wZWK4Q>
    <xmx:Ji1dabv9lVCyEWFTVkwS-f0jlvInTVkKTAVsnr7i52weL9x81nrkmg>
    <xmx:Jy1daXp8IAdq4vxMJbOt3K_sw-WdgotNN2pQRdyF1eIFK88pOBIqolRn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 10:41:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63bbe940 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 15:41:24 +0000 (UTC)
Date: Tue, 6 Jan 2026 16:41:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 04/12] builtin: add new "history" command
Message-ID: <aV0tIc_s_oKwFx7t@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
 <20251203-b4-pks-history-builtin-v7-4-9e9f849bfd0e@pks.im>
 <247aa9d7-07f4-4163-bb20-0dad2852ce86@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <247aa9d7-07f4-4163-bb20-0dad2852ce86@app.fastmail.com>

On Mon, Dec 22, 2025 at 06:11:38PM +0100, Kristoffer Haugsbakk wrote:
> On Wed, Dec 3, 2025, at 11:48, Patrick Steinhardt wrote:
> > When rewriting history via git-rebase(1) there are a few very common use
> > cases:
> >[snip]
> > +CONFIGURATION
> > +-------------
> > +
> > +include::includes/cmd-config-section-all.adoc[]
> 
> Now there are no config variables listed after
> `include::config/sequencer.adoc[]` was removed.

Oh, indeed, good catch! Will fix.

Patrick
