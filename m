Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133B136331
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685063; cv=none; b=qyw/EcZL4+pg3ao3maQWaWKFNGog7Z1Uv491N/CpmmmQafh132sxxIqqlE7i1EwbSxjIBWwnMiZRSkT64BDS9ygH1AMqYqhzzQaGY1pCVedU9hwvF2as5/NpZ4Zbif3BlE+9Kts9RqKiWaGw+1lvplHhofX3Xrkr0drSmOAAqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685063; c=relaxed/simple;
	bh=bAIg7n3hNECGn11NnOKiGK0yWtwdGWxeDXqKLz55+Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtBhkA9m4G31q5jvCXhqyArzaFCYfZ+Of7ys2jy5zmNZb27OaVwL7LqP2PsrkucPtRn+C/oz7fTyK15YTBQWa2pU6P4DVkeV2CbUEYfTwHkEQWlZXHyq8CGoaUL5rQvZZFuEa8qc/f6TGokZckMusPaLY6HkU4QnT5aliDPiPKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GMNj0506; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BEWqCAkT; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GMNj0506";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BEWqCAkT"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id BD92613800D9;
	Wed, 23 Oct 2024 08:04:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 23 Oct 2024 08:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729685060; x=1729771460; bh=vBL5Qv8Rf/
	2LJW+MDNeltZDsqAmHyQXTCyITgMZPS4w=; b=GMNj0506idajinGB5CMUsLNnr1
	N1U6x3UX2rPEVARtqqzuWcIf2sljPjYLRD/qXsEtWX8TjhiES52u5r/mywDIstmT
	k9rjDQtzgwQuUoktGpXhODxKOjLaLD7yrl8kb7+hOx8W6o5Eg/tXOlA83rz5J3HM
	KGwD8P1g+kCaESqr05hzrhgKep4DgHTErhUbpyoPlP0cnTxx41Yj5CPZYchYZT7i
	N+GPiXIJX2q6osO0KIGMOv5pgUFSx8GPLghIEUfJoWj0zNl7qqAUfagFH08few/R
	sD5ad0pjQjqSr70oV6XPsBLHSXlPaSO0jcMWetgG7gEzdVSmP1zfqFIiZCsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729685060; x=1729771460; bh=vBL5Qv8Rf/2LJW+MDNeltZDsqAmH
	yQXTCyITgMZPS4w=; b=BEWqCAkTDah39T9jTIlgZktjyZtSzaIfqL5ano0eDwAP
	MeaFYPuNImKx9nSk70gNl7Y4zmXl9FxwZpW7IWlWr3MY1gkC3nvvwY1mse6t9Pmc
	7IxHVspM1SXDbK2bQk+Xxm9u3bVeLjA7HXpMg+yh9GmaY6GfQ3ZRlc02CC3ghfBV
	5+cbTxQGMmSeAzeOQZ88JLyUIkhfkOZHBE5dPVGedhk9IzVdIjsSiV104BriIDAo
	c8MQtmTDYGnBDjooao8YdKmgoBlsL0QF/WAw0Knyw8Ygr9jJDcmE7hqIvB57hPul
	8gzVMJLtlv5rJ5YcGXqEe0P77noFj5cjdSO2v0SpLg==
X-ME-Sender: <xms:ROYYZ538w30OlbkI41bm32XcbCz0tqJ_3usvGKYQEzdsJ-CTRokGIw>
    <xme:ROYYZwG5GfASIdEpfrE8DvQZ9eSEfvikCyCdOttBzVDh2ZRT3eHnnzk6RaXoB7O_6
    zzTqXOtimUbwKqFfA>
X-ME-Received: <xmr:ROYYZ54Dd7llCqW-GD2fshYfkViidMgtwC6Hx6to82PwcbqWoXX43SUdLQWdMpvERFKrfBm__n3RkHR6ZbVAzJXyEZGURIHWzGORSi9ZUxJz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:ROYYZ23qd4PrxE7r2FanIreCHH0CbEM4MswkUjCPwzH-v795ur5wWg>
    <xmx:ROYYZ8GCbJWN1IUdnco0FD2XetfkhYo1EmCfD7swxDkjItD_FZBtSw>
    <xmx:ROYYZ3-uf4UEdpIsNOLRp9Lc-v1jIRhdpm96ROHGj3weKY_tTEWB2w>
    <xmx:ROYYZ5n31P9yMN-YY-NkToz9sH-T7hp0_waaRT4Na7UKafOdR-Evag>
    <xmx:ROYYZ32F11C7AymiDTw4c5u4V11J2RbzWZcZFgAPVlDJskUv59qM_Z4o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 08:04:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 911a3443 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 12:02:47 +0000 (UTC)
Date: Wed, 23 Oct 2024 14:04:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <ZxjmQQ3MxDlaJid7@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
 <ZxLOlx69KQp9jXDF@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxLOlx69KQp9jXDF@nand.local>

On Fri, Oct 18, 2024 at 05:09:43PM -0400, Taylor Blau wrote:
> On Fri, Oct 18, 2024 at 02:23:47PM +0200, Patrick Steinhardt wrote:
> > This series is based on 15030f9556 (The second batch, 2024-10-15) and
> > has the following dependencies:
> >
> >   - ps/cmake-clar at c6d3e52c91 (cmake: set up proper
> >     dependencies for generated clar headers, 2024-10-15).
> >
> >   - ps/upgrade-clar at f3501edb0e (Makefile: adjust sed command for
> >     generating "clar-decls.h", 2024-10-14).
> >
> >   - ps/platform-compat-fixes at 80ebd91b83 (http: fix build error on
> >     FreeBSD, 2024-10-16).
> >
> > These deps are mostly just there to make tests pass on all platforms,
> > but I wouldn't want folks to go test things and discover breakage that
> > is not caused by Meson itself :) You can also find this version of the
> > patch series at [1], branch "pks-meson-v3". @Taylor, I'm fine with
> > keeping this out of "seen" if you prefer to wait for those dependencies
> > to land first.
> 
> Of the three, only the last one is marked as "Will merge to 'next'?" in
> the next integration round[^1]. All three are in 'seen', so this should
> apply cleanly on top of those.
> 
> What is the state of those first two topics? Are they ready to go, or
> are we expecting a new round for any of them?

These have been merged into a single topic now and should be ready to go
from my point of view. But they still require reviews.

Patrick
