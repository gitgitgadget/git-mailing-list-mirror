Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF12F6924
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559115; cv=none; b=J7DtbPEMzaacf+HqeICwbAKJJAyFB/2fm1xSseYsT/beLAO0sMGWFfIbtfAq1NVl7OQEOXbydR+bwDYQyGd7sR1dz5hq6MZAbC72F9LVXI0QxdQ1UwIaVMQzdtgdMPrXCGsOr9byhWURx0YOeX1fmUAZmPWEM+Z3v2aY9wqYvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559115; c=relaxed/simple;
	bh=maTLEGcIe3dIGiyeuJ0fMYWdNWrzyECPNmBo6UL1e+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvUNP0Y7A3BbSGMeGba7ami276en0/xORfkvEqxYcG8KxAEVoFwUcUiIFGUASci/Jut1/5qbWUhgaQfcTjIFN0AFS/6gdFgkW2HLBqra5fihZdLHKS//C4YasB1WgxVU2LuzpjOUAWITyTEcjwF+RPcafpNf0CuftkyKma6X7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RGsI41/t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpcZzuVt; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RGsI41/t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpcZzuVt"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id E21C1EC011F;
	Mon, 27 Oct 2025 05:58:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 27 Oct 2025 05:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761559112;
	 x=1761645512; bh=skXNk7ktk+OVNSxieMVi6G/gebYYbEa/QNoBOeytGf0=; b=
	RGsI41/txQU4z5BosfVolsc2p80dPDz6Zq+F8V0FpQiQxQ3LSDCH7awnbqkxngvQ
	JlGdaVOYPn/QBHMp4jjUYG1CV2Tfi/Wb43QOmm/GFFbWE74lOcE5fY0jHCTPbPko
	utY/04YgjxUx/fgQvsIdj6HtoRL84tGGEXZ0tDbvJ9Xj1/R1WrdnEncnYZGX+hUl
	1htSDe3JTqHTxpT26tCkg4B5lf32qim29vs2ecgT12bgGh3Sn2qrpYD4yv90a/gM
	K9hcS1QKOElTH53fPK3puFWGIW9Xg5tIpndVqa50gRTARqxXvdIJuRxvJs84iZtY
	i/zFyJV7OvQUz78rWDQ+kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761559112; x=
	1761645512; bh=skXNk7ktk+OVNSxieMVi6G/gebYYbEa/QNoBOeytGf0=; b=N
	pcZzuVtQCTfkiwWmh586A7DqS0Ke73acrKWnhCXohyqOszC7wTA/rXMDX+ONUyZz
	WPp4lBoMWFjYFfXvr6CAb1pZZIcuNUu7Hv6haW/7ei1tB/kntOg2TvX0bs4VvzhG
	cp9wVO35JIuff83DpTBXeh79xE0sPQNtCpyQNInTIj4FimxXqUeu/eiVRi5SiXX4
	i8+Srww4bOhTsI1s82kPrV2J8AKc7VLsHTPgIs74oRxAjAxGiWWx9YsKDgdAAELc
	KPo7uLlxPXkx9tCrF1pxzQXe/GZnRlMl8axZGLPn8hyAiknezCDz8UGW1E3I3Tpy
	kUQ7UdRbJc7mJcdXFF8/A==
X-ME-Sender: <xms:SEL_aGpRop7xTOCkvS3BH6wWSOZdR1P-P-k3G2FRax57XHShFYFjog>
    <xme:SEL_aHPGrYy6_hiA3tT1OiRfC_HvJcTf4diUPvfa073URcVNW5pBq1lq9lwCfaF3f
    vYHbMQRqeSWWbhdj8D5Kg3MrMLI-nOIA-ub698C0WP76lY0LYk8Fw>
X-ME-Received: <xmr:SEL_aO2lajmP8yTXtT3QV9vKzMCaWk-0D8qbnm4xL7fJJv_fqL_rtHyCGweUPDxoEUhM_pVri5czedGoB0kwT7Mh9xAo1XoQgBfZQalqvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhrghgrnhho
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:SEL_aGBJhM1gSP7MOhdlDXIrg45WdJ7q5LJ6Ku_p4TV8aqRZJs2gfA>
    <xmx:SEL_aLKtP8FalI6igRIxA45Tz3pZJecP4ZbF5RzjbXpoS0V_QGA1ZQ>
    <xmx:SEL_aPmW5AuSttXZ7KSXdB3vpVO4Rz0pHVw29dpjjWW8cpl8zQp9mQ>
    <xmx:SEL_aEb6ilR4Q1bUwW6209YldxUajwPRR__IcVKq2u2dxdrvngjrgw>
    <xmx:SEL_aDmjxokbDn1u-GNpo_CCXwcEXaRZKV1dNAOZZvi9oVx3DhbaOTGU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 05:58:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 918ec9eb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 09:58:30 +0000 (UTC)
Date: Mon, 27 Oct 2025 10:58:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 06/12] builtin/history: implement "reword" subcommand
Message-ID: <aP9CQyyWnyFGx3-Q@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
 <20251021-b4-pks-history-builtin-v5-6-78d23f578fe6@pks.im>
 <xmqqa51kszvc.fsf@gitster.g>
 <CALnO6CBT+5i==AtF-_xEgp9nEUEZY2G4DSAsSL9dysxr8A-WfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CBT+5i==AtF-_xEgp9nEUEZY2G4DSAsSL9dysxr8A-WfA@mail.gmail.com>

On Tue, Oct 21, 2025 at 05:43:16PM -0400, D. Ben Knoble wrote:
> On Tue, Oct 21, 2025 at 5:34 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Hmph, I would have expected that the overall flow of this command
> > would be
> >
> >  * find the commits above and including the <commit> in question,
> >    making sure there is no merge.
> 
> I don't remember offhand if the implementation supports merges, so
> this might not answer the question…
> 
> > without having to touch any "pick" machinery.  Why do we need to go
> > down to the merge machinery for a mere "reword" operation?
> 
> …but it would be nice to not overly restrict the commits that can be
> reworded (IIRC, jj permits the equivalent).

I agree that it would be nice, but I'd defer that to the future. Let's
focus on the easy cases for now and then extend going forward.

Patrick
