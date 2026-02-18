Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB4322753
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431713; cv=none; b=ZleGxHSfybLg9/YadFkTs1jk6jDROgrpoN0IhRW8XeI4ui5oqgX7y/kcd5qNp1H8aohSRK5VrBuML6/TgWwxLFw5uXvmmQjlE46yfzKd28PSfqOpyp4Peb6jUpUblZvrpMr8wBdpjJhnBEiSbQcuF/GskQqbObTb2aXBLPDENiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431713; c=relaxed/simple;
	bh=GcKqVfG3CnGoI7vKewYW7TcMF+V5bLnQA43apZ6IzC8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Oy3r93Kft/3WEl9EQB1jrsWWumAnHyXfj877wFRt7iZzvX2HQResZR+5aPdcWbX2+N956uWuFTp1jnLY3wW6P8gHM8ugOqTP2ydg9/c9Crcy5s+ZlBVL/HgXg155ySaj9uioUQYTaMFxSVk6MQEimqYa3TV+qPnCVejpS4yLs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EiQLn7gs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L91t11FH; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EiQLn7gs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L91t11FH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8FE47A0010;
	Wed, 18 Feb 2026 11:21:51 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 18 Feb 2026 11:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771431711;
	 x=1771518111; bh=GcKqVfG3CnGoI7vKewYW7TcMF+V5bLnQA43apZ6IzC8=; b=
	EiQLn7gsfzS5758/2jfF07+vTPiw4endBYkBwvrqaedlPkle2eYEMYFOw/WUDF/6
	jtBa986DOoQxrmeSvOLuwp0wJ1qLASKLEp9mQ9gjiYa5YNjzRpkEcx256JLbtrnC
	8gypxhjufsgaJt9DZYQ+L/LfLbsYorSqCkz6l7AN+xnTFbMGqjb1yq26HYtSZtqG
	jSIAAcZYarsgSkmwh8aBJSTBQS8SzmQ09TJvlvuxxjVqfF+cA8JV5spBACGQEm45
	7H1UGE4cxMzRuxVm4iLMJfuIpbbBfFcug7Jf2NuGfsuTzJ8A4AfG4xIQNYEGcPi9
	tKqJNZoGJcszOW5G4UTJ9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771431711; x=
	1771518111; bh=GcKqVfG3CnGoI7vKewYW7TcMF+V5bLnQA43apZ6IzC8=; b=L
	91t11FHRCZCoH54Ce/UFi8RBaVpHKTly218IeLbhQRGXpzxgxtbJHhji8Lj3UKce
	/EG2mdl2wn3wanufUpKB7J1VrrSeE0zPK9OuhWC2eQ+8pqVsET1VtUq3w9Tl4O4l
	nHIGD6tCfWCTtWnQBvJzqJtWEd4ZT//IKkkwKvSLIX+t1GK8abLzAgWVVHZ4itjo
	8H0T9ZLaVd/Ftyr1kbRnuBT90gGy9aKdEXbR0Nrm/9JvE4NN1WrK0RakWd2axnx4
	7LKVw+AMfSX2nJRGDtF9hufJTazl/W80VicYkds7DjPNWgHojslpz2ijsGMwwMyF
	luaiaeq01hLTxXkKBpXow==
X-ME-Sender: <xms:H-eVac-jXvKAiXn7tYf0S4PJVPeD1sRm0Ocs82WxtgWUYNIdkHDMXPw>
    <xme:H-eVafiM2plvjRX3jgKwuoLitMhNsFBpNczEruB6eojpTA5UFbfTyXpNtWYO5WUGU
    nLLUbRdQTdZ381WoJmQ6auCxS9ewUT1DGrBwJdfLCgvBrR_8OyCTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:H-eVaepWd1m77nh7Q_r4riQoqGno-RRkepQyJEc4Zsit8mDI7EnDSA>
    <xmx:H-eVaV-tiz_larwehyuElESv-2CV77lC7esy-uyKt5TA0fVWTWYXog>
    <xmx:H-eVaaf6RSiGuP-OwQdXF_Jfw5S7xAcFqPvFZEzO0uIeN0gYEn7fSg>
    <xmx:H-eVafLhIXglcMuQmZMSpQkAYysVKcfwkDNpB4GP83CtBGyM4RqGwg>
    <xmx:H-eVaa6yETjku7R79RJR_mNzY3ObvH3C_1HuhfMlFVKvBFUUGEmGiMhU>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 538921EA006B; Wed, 18 Feb 2026 11:21:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANb5zQf_K6Tc
Date: Wed, 18 Feb 2026 17:21:31 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jonatan Holmgren" <jonatan@jontes.page>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <81e6846c-457b-438d-99b5-6412007049dd@app.fastmail.com>
In-Reply-To: <20260218145214.581460-3-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218145214.581460-1-jonatan@jontes.page>
 <20260218145214.581460-3-jonatan@jontes.page>
Subject: Re: [PATCH v6 2/4] alias: prepare for subsection aliases
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026, at 15:52, Jonatan Holmgren wrote:
> Switch git_unknown_cmd_config() from skip_prefix() to
> parse_config_key() for alias parsing. This properly handles the
> three-level config key structure and prepares for the new
> alias.*.command subsection syntax in the next commit.
>
> This is a compatibility break: the alias configuration parser used
> to be overly permissive and accepted "alias.<subsection>.<key>" as
> defining an alias "<subsection>.<key>". With this change,
> alias.<subsection>.<key> entries are silently ignored (unless <key>
> is "command", which will be given meaning in the next commit).

Unrelated to this change. I was wondering if it makes sense to use a
trailer for commits that break compatibility? However unrealistic it
might be that the break ends up mattering in practice.

Authors might use different terms and phrases in their commit messages,
like

=E2=80=A2 Breaking change
=E2=80=A2 Compatibility break
=E2=80=A2 Hysterical raisins

And the commit message might be using these terms to describe how it
breaks compatibility or how it *avoids* doing so.

>
> This behavior was arguably a bug, since config subsections were never
> intended to work this way for aliases, and aliases with dots in their
> names have never been documented or intentionally supported.
>
> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
>[snip]
