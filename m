Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0922424E
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642866; cv=none; b=RMEnKAkirdTECvVsxpIFaphwdXlwXkKF2eFp6JejzVoTKdB/cLHhH1biRa8XFXqFXSdlQPrACAtO/Gagp53v40i5oo2/mEuXYjztM2GoHEt17BFUORQ8oydNWECnYQpfmqqbPQnHlTV3kMyFUObbHL1KRQ1TQFZ3DhkkTTwhMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642866; c=relaxed/simple;
	bh=f7WtDpMJ1U454HuT4KuSUYt4i4HkB7X27itdnfWOzh0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Oy//khD9pjrlkQ3Czx5Nmj+bIl2KqWThCjS4I5cV6CeP7toCLAAtsKsDUu9vohvw+15Bv1w2wCeKY6dQ88lXqYjoWg2wzgFd8eF5LUcVktv2nyVIAtowQNAJ/4E8iKBCUs6izNuQsA66cjIA+lUMRE0L0KdEEfQqJfxInRhzLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b0s9H8Zm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M3/IvbxQ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b0s9H8Zm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M3/IvbxQ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 161D87A0130;
	Thu, 16 Oct 2025 15:27:43 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 15:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760642862;
	 x=1760729262; bh=i3KNQAX1Q+/87eNmbb93CsuYPPgkIHkQlOd1kaAsj8Q=; b=
	b0s9H8ZmGOd0i/KdIqKQwlYlY8kbkP3j76HfD7h/DyggvBKQ7Rrtl9BK2cTPYxr1
	1lJCo8LpkvXzIp+16XadMt5KViBBp6fGlTZZBLyje069hwqjTkWwperC8YrwPNf3
	q/NgvRrZsClyyQwmQ6wxP0Y5HUY4tCjgIBKNMc4cR/w/6y5iW9UcMhjlNL4/VcUq
	wSh0egpaxv2PZrUTHpkfZ/DohVW9YeEItxCtu9pnz0H4yXzyaYsyqolM2bWcc/ra
	J7cUbpgsGxxAoAThEX3rX9jugKuly8Ms7k0jL0PMLIBTO5v+F1H0mVWaqbH5yppG
	BgwSSur408IWYTwVgNs+Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760642862; x=1760729262; bh=i
	3KNQAX1Q+/87eNmbb93CsuYPPgkIHkQlOd1kaAsj8Q=; b=M3/IvbxQRsdHedWJp
	VS8n4adwcDMqOvjsR2prp5GFnqfGNpEepd/RSklUdrOcT/9ZgvJ8+RHW7ZXxQ1Fj
	ITaaoLR7tYhTfgOxmdeDbfHctu74xO6koNb+h6Lczs46xYG9TFUX8mEgEsf8K8g8
	xqLLFwtE7wB9wp2wiyveeDrZHwsb3SXc5L7lfxC3sVKOQdzc9hZCA/rJWDdD/Yrd
	97rjSk459zeuXS7cq3NKIpT6nKp+AjhPmP5QccSDBUUKJd4388tNfRQbCiaC1epN
	yfELLxJl7HdmLAUvWG/Oucjp78/klo/sLWr4lm0+Ep27B/5DFgtI7KYqu+dr9TQ/
	+QGsg==
X-ME-Sender: <xms:LkfxaCGZqflkgSK919nrAGp7XewGFtJYLPlyQn64i67rtKZbHFtaXZA>
    <xme:LkfxaOKsxFAMTzdG6GRfK127cMx1SFqliunMEYDXByBIVdksXfMFWXy6KqM_jx2P_
    M624QCV2Y7qO0jMu9_Qpd3BAlGifFLxagexZrI8IGtgVDOHwYQUog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjrghmvghsrdgsohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghrshhhihhprd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LkfxaIyKgHUDU77UEiob4-ZPveh5Z8Q_sIHrCJN2ASmhmrd_yYKHGQ>
    <xmx:LkfxaKMOH83qg_XJLstE9xU6RNlM310h2AL7hl8-TMOjRtlCisDGqQ>
    <xmx:LkfxaB4rav9QJuyo8HNOq9lJtDkPymtLASCc6UA_mNMnO3R_4LdM0A>
    <xmx:LkfxaDM7MYR-nN7-nTSWpNqkVaeAxX6vzRjepUBOxYKXKvxt-to7jg>
    <xmx:LkfxaOHpfnUK47cwaFYxsrrYOm7a-NZuqeNvs5e2R6eRsC4vsEACfCyf>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7BBEA1EA0062; Thu, 16 Oct 2025 15:27:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AThq61FNTfON
Date: Thu, 16 Oct 2025 21:26:43 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 git@vger.kernel.org
Message-Id: <6fd0ac40-6cf8-436a-af73-1159f6569efd@app.fastmail.com>
In-Reply-To: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 0/3] add a message-id header to git
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025, at 20:57, James Bottomley wrote:
> There has been some debate in the kernel community about how to link
> commits back to email, which is the basis of a lot of scripting we do
>
> https://lore.kernel.org/ksummit/a7878386f3546ba475cdf7250ab4f5a6af2a16=
76.camel@HansenPartnership.com/
>
> However, this problem is one that goes beyond the kernel, so having
> git always track the message-id of the email used to create the commit
> will be useful beyond our tools as well.  The design of this
> message-id header is that it never shows up except in --pretty=3Draw
> output, so it will never be ordinarily visible, but can be extracted
> by scripts.  Some projects use the -m flag of git-am to add the
> Message-Id to the trailers and for backwards compatibility, this
> functionality is not changed although it is hoped that it is now
> redundant.

Related discussions: =E2=80=9CChange-ID=E2=80=9D:

https://lore.kernel.org/git/aOQWWkj%2Fq7GfKZY7@nand.local/

https://lore.kernel.org/git/20250703074952.20737-1-drew@ddevault.org/

https://lore.kernel.org/git/CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzd=
cywqUUw@mail.gmail.com/

Inspired by Gerrit, Git Butler, Jujutsu, according to the last link.
