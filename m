Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4718FDA7
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095582; cv=none; b=EterbaqzGX4HpAcf7mtizknPfVvp1fIQvz7IppLJ4dZ9Bh26KPbQukAK5kqDaEXekJ2MFCgRbJe0cCy45rWle1cA6aQX6fM0qFv5dqNmjw/3pmL9TZiOmuEXGCoNRHfi53LTZu0dFDxGOPMMwzgFcvlrpFJyQ4Vc++s9m0rzJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095582; c=relaxed/simple;
	bh=WpimuFqYE5Sm81D1qQOoaunzMZ7mZY73e8YMT4aEVXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5PuMmluJYJYNMCN+g9gXn4y6dqSjXnjmz7AGE66yt/8i3eM4vd2nsDatJUhgZ/EGmXTTr403SEonXjrT6zsvtL8ioxLW8n7p+q9mcqVoqNcYNrX9JvXnvBqBhjRIUJ+zSC8La/dLlIDhporaJAfuDTP9LPk2C8tsvlmDl2rk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Eex664IW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1z+AqTg; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Eex664IW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1z+AqTg"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 11DEA11400ED;
	Mon, 28 Oct 2024 02:06:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 28 Oct 2024 02:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730095578;
	 x=1730181978; bh=bB5+2QE9vSpr5t3Thw7enB1WyunqqTsFAaFSUeeo1kE=; b=
	Eex664IWQQ/vMacFjdJ6lt7GXItgqvR4FT9zpnkfQf1B6ZmKSwvhBriP5Y/qWpHB
	IXYGse/j9C7IHi5oHFAjwBMWr+rEuUGGwp8oXXL4O8o5r5TlkuIjhgvk56rQidC2
	cr35ueq7FdUIanzJGXvYmqqKI1hgadVhozOKVzHCLiZ5tp5vSpOLLsrp/x9iWn24
	y6iW5hQDYvnKQeuTrIGQkoi/vswVWs8neQyuvsewwIpgwzPpxJiCOvfvqp6Whz9a
	0Veg7n+uZlAdlB9ULEOFZuzEtDtCKoGsv2+xR3p2hjqN5kvRBCZSNStUs9auCwmC
	FemOGUXyw/ag4ccTpmmk4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730095578; x=
	1730181978; bh=bB5+2QE9vSpr5t3Thw7enB1WyunqqTsFAaFSUeeo1kE=; b=W
	1z+AqTgUFcaxo9ZKyZ13J9aIiQayPagkg4mqujhaE5g2zqJLtAciayOq65UQQsqw
	cVhtQkpp6h2BuZtIXv0rt12Zf7RHu7EKuv+HkopNyAIsKf/+T3k89uL4NKT5JW4O
	Uav+iqvLB2Z0wVvaMlc7ZWucWQknaLxj/C1HRZ4EfPLeMWJ+CFyP6AGdNeFLnx3L
	Xy/xowrZ5GRF74zXJU4eZVkA4tdu+Xf9j0o6W3d8P3s71eP+jnA7xeZyT9Zk670w
	X3qLd27mNa2aA9mPUy+EwGmP2mnW5wip/52Nqc2PeP33nv9gBQxT7c3L+Xc3gGSY
	+iTK/Oy4Z6lwqNOkiHnSg==
X-ME-Sender: <xms:2ikfZ24_DnFNVB3DuyHaniejfFc0D4t6UCrvs2w4R-1Z3VNYF3zouQ>
    <xme:2ikfZ_7xaxVsYUfOGKwQgzNjJ4N6d9gOFa8zlvsVfCXPW4BsHjN8-YObhS1E-rmIN
    DckeOiMlv-72TflYA>
X-ME-Received: <xmr:2ikfZ1eV6GtRX_0iD-uE8Y87mpOqArTTRmFMed5YZx8FVCY_FFi4_6rSz240XcFEQC3h3OVi26qSOUiGLv8s0nW4EB793z_cB6WDJ6cMv3SAHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2ikfZzIsS0v8k92uPWGqx3SAS5TT8qxUD3cOyuT1VZZ5BCfQp-FB-Q>
    <xmx:2ikfZ6KBEu8Xozg0yMnAqtmRoTbFPZphPtOGGG0guW09gX8LFxna2Q>
    <xmx:2ikfZ0xal-nZkqtkMosbVHEJgd5g8d5ZXhBCIiLoFHaX2JG1Tv9LDQ>
    <xmx:2ikfZ-JLPwkxJwMtQgqx5EQJYndpHI1TwLz7Cy9mkYHXvZ5VqnTuPA>
    <xmx:2ikfZ8iG0xHpzeXo5zmRIdotJRgN8cTMfLqqW0iuulL7QXtzs9Dz9bMp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 02:06:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d6776eec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 06:06:11 +0000 (UTC)
Date: Mon, 28 Oct 2024 07:06:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [Outreachy] Final Application Timeline
Message-ID: <Zx8pzrgsI-S_LbzQ@pks.im>
References: <CAGedMteoVFfZy1jtHMPJvByzfq9unomcA7qkCNKx9R6_ZQ6=Cw@mail.gmail.com>
 <Zx4bEOGr8Hy-ZfX2@pks.im>
 <CAGedMtfrM1NZ6SY3SEy3+zSSvbB+D+Z_03jo9235fXoyuVXW5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGedMtfrM1NZ6SY3SEy3+zSSvbB+D+Z_03jo9235fXoyuVXW5w@mail.gmail.com>

On Mon, Oct 28, 2024 at 12:17:21AM +0100, Seyi Chamber wrote:
> 
> Dear Community,
> 
> I hope you are doing well. My name is Seyi Kuforiji, and I’m thrilled
> to connect with you regarding my interest in contributing to the Git
> project as part of the upcoming internship. With a background in
> Software Engineering and hands-on experience in C Programming, Git,
> Python, and other tools, I’m excited to use my skills to contribute
> meaningfully to the Git community.

Thanks for your application! I don't really have anything to add, so
please don't forget to also upload it to Outreachy in case you haven't
already done so.

Patrick
