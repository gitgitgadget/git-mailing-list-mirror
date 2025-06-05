Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA01E7C03
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112924; cv=none; b=qB3jv+4F8ox1qbpCGr9G/9eHTQonNhFdaN0DsVG9tyQXb+65TbQW9994f/qflFBoeZg2NyaCDkMISUqlZbNYMfhnR37BjceK2tqVLOKREiw4hPmItYh9SuENyk4MHwgHBSCEKcADOSlHWND2kdXvGPZI5TNQy/KAxzQh7gqUWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112924; c=relaxed/simple;
	bh=Bz28Jfiex5RkJ9O/naiTtyQUjfMHSo7vjd30pLHG9dc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=svOUVpxRY7SGowe6Pu2pmtuqZmMNzN02uZGZ5kis4bAKyvfpIKV8G/mS2ekT9AMbBYDfSwarTIKL7PyRIwGfgIeFw+NhYoUympdN/1loHDHiauklnaC/D9Dw5okibx4LdTl4/39ZW2pkHWr6BCYx2ZR9NdVcpFiCTFlDBmnXkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eSQFGZSN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mmVfzdtc; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eSQFGZSN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmVfzdtc"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3276C1380370;
	Thu,  5 Jun 2025 04:42:00 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 05 Jun 2025 04:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749112920;
	 x=1749199320; bh=Bz28Jfiex5RkJ9O/naiTtyQUjfMHSo7vjd30pLHG9dc=; b=
	eSQFGZSNXEGmrGVnYVYNktWQyYm7qoVmIeyTLWpxZzmjhUCOEqBewRvI3DGbYLhe
	rPFpfuHm4E6L+06bzpUu7fTYyrQIbScyZPGHayBQTmCwkL8NMBGKux9e5K1Btaac
	Ir+9PmbzwCnWeegFo6XnooUtuRvvl1i2ocNGf/Vl9zDAhFyzpRc5+yF9hYFHFD4x
	Lrkfl8ftO+5/x/8nvvXJsd3BH+SOVUeVS2PlqA9u+Z6lGfof3/Rh2yNA8fDLy+Dl
	58lfQBxmj/2xqJboPFBn40OyPEqwSmH4qCM3CJlVKDLMiyE/Bx2H03PYZiecJn1z
	zbAEqg/OPO2T0gSHur+bMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749112920; x=
	1749199320; bh=Bz28Jfiex5RkJ9O/naiTtyQUjfMHSo7vjd30pLHG9dc=; b=m
	mVfzdtc6BRI/1yDnCnM8YQUyrZkefzIr3t9nqA0BYeqSSOgFk+zvfplOEgusEFsp
	Lq41V+0nnnVZ3lVIj9oehCqcVk/fmqF/a+JII5lTLBvjTJmLz79vvcCasA9I/54Y
	aq2jmrQmQK5fbgC5oRRZ58coblexT4/hB3rjXo0UA9kus0naR1/T35RxqyK2RBYf
	iGgBifex5ZPGh3imw5rObNYenaOVJotHJZ317xvcot0rKV4EYX66V7Kf+EwK7i4y
	Xc5MwOr3qjkI8A0seDExYEWkp99DD9JtMx7rw/Lra8dGFtzohYA/9Yx5e7GNXbWN
	IMj31W82uqOgliYx8AC+A==
X-ME-Sender: <xms:V1hBaEpcKn5M-3vEOz8NdLbnGJ93T_WEeV9AKl8Z4eooPkXjlyOglLk>
    <xme:V1hBaKrjIU8QvUYEzNbF40xuzzN31F5SeA_a1_F_JE42RiBDPAnUWtoEHLOmoIjJ1
    iiOl2OG2RtSUdP1Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefgedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhephedugfevgfefgfffvdfhffdvveevgeehhedutedvgfeuffejveejudegve
    efvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WFhBaJMDEWgxKUiM8roZcXnUyzLYYyU6CY8VUbqpUDD2P4lT9PZ1ew>
    <xmx:WFhBaL4D3KJRe8xczO45lo0175b5sFKRnCPsf2lcqw_zUdnOFwMsHg>
    <xmx:WFhBaD4QdnaomYTPJPrytixD02AFIhyHv77jMIDClD6RJH2mUj39Kw>
    <xmx:WFhBaLg668AJSks4HaZJxkdb8KzjKD0uHJNZKUtdvG8VHPVrTM3BHw>
    <xmx:WFhBaMWPSZ3WZBkDGgx3QrEGWoC7gH7g2Dq3LjvckPTh2a_iBM7qocXe>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E6AEB1EA0060; Thu,  5 Jun 2025 04:41:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T27486159c85bd9ee
Date: Thu, 05 Jun 2025 10:41:24 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Johannes Schindelin" <johannes.schindelin@gmx.de>,
 "Jeff King" <peff@peff.net>
Message-Id: <b6e10e5d-45e4-45dd-83f9-d889eacd3034@app.fastmail.com>
In-Reply-To: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
Subject: Re: [PATCH] curl: pass `long` values where expected
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025, at 10:31, Johannes Schindelin via GitGitGadget wrot=
e:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> As of Homebrew's update to cURL v8.14.0, there are new compile errors =
to
> be observed in the `osx-gcc` job of Git's CI builds:

This overlaps with King=E2=80=99s https://lore.kernel.org/git/2025060420=
5505.GA1510724@coredump.intra.peff.net/
