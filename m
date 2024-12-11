Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7571E9B16
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954901; cv=none; b=a8shvF7zNHpoSw3zYWpN5xxwTfXBIcE2k92PGcXIdm1co9PU0lsLKkkA2sLzW+cqpssEmz8Z8R8k3k5bB1xtMDR8LzKAcJOLqRzCDnmi457EcyTNQpQgGNf7/yEkjALOu2CRR43QmFhWHUCgRnTClgOk74KV8tgnfmAzwVnaH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954901; c=relaxed/simple;
	bh=9JxwMG1C//iyRdug+pwKg8s/lB0s6Cus14vhqt/T5SA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OSOP1B76IF4fw/A3oIqxGfn6lf720blZQd/aNbDXrmkiG35wQfNjJMqGd8Hg5XiyiUaEs2bKMrDvSiApvaCg9L3nGZQb3i7WuOoWMwX/v1rn5oqR0Dj+K1fJs55UvwPMb6w43mtP1BrFv6e6kkvLsRRQ9rltBJBt4o8KODfC1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=c8hVl1MQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F3uND32/; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="c8hVl1MQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F3uND32/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F06A1140330;
	Wed, 11 Dec 2024 17:08:16 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 11 Dec 2024 17:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733954896;
	 x=1734041296; bh=hbhogLN4qw0urVIM2KFz/rSI9xwngBy3LVzkbNX9vcY=; b=
	c8hVl1MQxsCpEsS2DUEDNJ7MiJodhZGAmCAdzGel7o/dBCoJsn5W2c1nGMa67JcG
	75KWqV9UAgyeP3uqBx+g6yE6JLg+zsLUT/PzOPMWGnUld8Pb5OA7TC/lFWNGerje
	E7DzeCkI86ipUJ+D1oRm6+zsT+Q7F+SbgpkH+I8d1+XsRwbp1I8M3MsBhm/7W87o
	Ht+A+NGV7PAEWgxgmIioAtXlUqeP7jPOaA5hNwszzjts3BGWAcz51u08JYHBaAGn
	6UCTSZHLwuUuDhfurk/gwFlgJcJQ2vjOqFJvpx5aC0Ga/4RpOdjxhCKe4YV7JjBL
	wCoII+gGyoHMwpfDs5pImQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733954896; x=
	1734041296; bh=hbhogLN4qw0urVIM2KFz/rSI9xwngBy3LVzkbNX9vcY=; b=F
	3uND32/LurOgArJolW3vvMImDIStgYLl4HOUlMlTZ6js94aqYt+zQrbP7CdcrPwm
	Dyv6TNTM3mw69juOE3DL+l9iTWfl7+Gn4BujPZDSaO6ICrbccVc9OPjTQ9ZsWyZt
	2C4hM/ODi/7iILPfwe9+9JYpopxKO1qvEL+SNFQfSWbCjSSnasqfTQ3kcqmVEAiT
	zU/utc1B8VH48syaXUF7HUF5fEUmZuQTyNWh3ldHb8G3p+O44hwb3kDnesS3JjZC
	KRavbinlFx+D0e98rsp8t2VzXYvs3PSCaVTjtrN1u6pSZ50iuLdNC73EIp3/f1u5
	Df1gFupMLkdQdXVX3Stew==
X-ME-Sender: <xms:UA1aZ_w3_lMbzDqcODPo-i59717wIq4binVydJ5qjpAJwwKlPwKm0Gc>
    <xme:UA1aZ3Ra0JUVNcQWXhr76451dxoSrpCOFsrO6XFgmf8DtzWDxvCyxdbpoA9hovM-6
    LAGrBCtw2V9Q_5L0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepleefjedujeffgfeludehgeehueeffeeftdfgfeefveduueelffegkedtle
    eukeeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpd
    hrtghpthhtoheplhhiuhdruggvnhhtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UA1aZ5UTS-3nwql1gDXmrbHtpLMg37uKqwAhcA9Gg0Lz-2DvekkfQg>
    <xmx:UA1aZ5igzgTgB9pb9T5fIbqeYMlokXeHcmsBhcXR95to9Yx1rKVVnw>
    <xmx:UA1aZxC1psgQtaa0lSYlATFrgk2jHC_Tk4Qz4WppDZZMkI8Nhb8ZIQ>
    <xmx:UA1aZyIUToEP_70miubuH9DENo6-UzvJcZr3_vNYASMvMp1o0IN__A>
    <xmx:UA1aZwMcJBbzcCdAKnm1hqKA-vXHuA1gwq5t6aLHuW7FR7arD2UsOnHV>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 40B29780068; Wed, 11 Dec 2024 17:08:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 23:07:55 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>, git@vger.kernel.org
Cc: "Denton Liu" <liu.denton@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Message-Id: <07e3a0a3-7551-4f54-bc3c-afd8dae7da02@app.fastmail.com>
In-Reply-To: <4e8d3a75-0128-4d03-a429-59b7588f80b4@app.fastmail.com>
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
 <4e8d3a75-0128-4d03-a429-59b7588f80b4@app.fastmail.com>
Subject: Re: branch description as a note?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024, at 21:13, Kristoffer Haugsbakk wrote:
> See also this project idea https://github.com/gitgitgadget/git/issues/=
438
>
> Which also links to a 2019 thread.
>
> With +CC on the participants. I hope that=E2=80=99s okay.

Reiterating what I wrote there

https://github.com/gitgitgadget/git/issues/438#issuecomment-2381017430

I would store all ref metadata in one ref.  Either divide it
up into files or have one structured file.  I=E2=80=99ve seen this idea
floating around.  I haven=E2=80=99t seen any purpose-built tools for it =
yet.

What I do right now: store all cover letters and whatever notes in an
untracked directory.  I plan to version it with a parallel Git database
(named something like `.git-mine`).

--=20
Kristoffer Haugsbakk
