Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108430F7E9
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500885; cv=none; b=B98VUUpmNp76hwHSB0R0HCHuVp62190h0Dl4h/KErltMseYG0Jmyrh5Iv/B+L6Rg4t+RIGhYL0rY8LA3TDp44It83y3f70ijDlNyh+lh6XpvM8Himo8X1H7cC11YaxjpfsbkhIvyX1tHUWZ7v2ssbc92vjeArxYPueIUd+qKPBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500885; c=relaxed/simple;
	bh=GkzRfrz+GTq+5yKNn8SSSCmU2c+u3N1fTNfefhG3MX0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nJDAeny7P/i+JhArcxF6avkabmhChBsbVL8vEJfqiLGJqb69FOW1w1CrVzSNWXQyYqLe0h9/TtrhGU7/CC7/A14A0oJvkK9SzOQF9QCelc2t7OUU2VV+WP7iCu6adxxna7KB4caOczxJVywtQ5qR2o6rrX2v3uHYAC9nStklaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Tbn5B7Aa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sn1Nn5Dv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Tbn5B7Aa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sn1Nn5Dv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22071140009D;
	Sat,  7 Feb 2026 16:48:05 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 07 Feb 2026 16:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770500885;
	 x=1770587285; bh=emmjXy+eSX6NS/6gbo0ehxn+4X9HzuZPYjM+oPU46+s=; b=
	Tbn5B7AamJUvBnX9hN2cH/AIXY2ydAg+otPEH4G0InOw8VTKpPuSVpoIyWSqWCia
	i2a6W1c3TJO+m2clRVg5NzMHRGmywGtju3+Z4t/KKYiIrZk2j+qkVdL/StkU+42w
	Vl6R+NkPlPeAnVxoWJJyCrG7J6smEA2xW9j2fIKnp/DzvoJ4r7fHIgI0i13fgbu+
	DwOs5+QbbRyVATXJFFpHMc0uN8jGXL8whCrFdxDTgmEjyG2s1oTJ0YRIFBJfaVwZ
	B2q85G++PfANVdlHphqvzNArArf4NnxUYzZ8k8dHPHqWyYWvyKFO0+PN4JXv7tFu
	OanAqfo4ELNJjFWgh34Y6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770500885; x=
	1770587285; bh=emmjXy+eSX6NS/6gbo0ehxn+4X9HzuZPYjM+oPU46+s=; b=S
	n1Nn5DvRyA8S6Bo8QjtFCEq4Axm5L0OaldSWcB2nVUsPLYZDAI9lnCLUjcL7tClD
	uf+FWlLT7pb9BcC6c6MLfnvuWpK7eZGDmuFKq582kLgakWoryaoSO4+uOSOhk1Qu
	UODDtB9iRbahA1FqLLbitTU/90aE8U6eTkFJmsh9ZtFX9LO9khl6HuSsAKkUccwY
	GgGscpzEHXE8dJ3uQfNDYX7xCKBzo5NcjUuLZA6/ujit8tEqDiRqOMnE+6TKqeib
	yu38HK6I1KmqQoJ0ya+yy8JKgCdOT3MyQkLK8plvYwqU2+pJK7Y0lKI2aSu7UNAG
	3ak4u4bPQ0oPMlE19JuAw==
X-ME-Sender: <xms:FbOHaRAOon2BjN3ylf-52xElKDvxo-sQZFSHBXRiPpV3Rp9sVP8dhVU>
    <xme:FbOHaaUw8cjD4S1cTd5ua76rE2iXq1i44PAsGuQkDixi0m37aqLfIguYI-AyO0WNw
    Xp_2Zaigqx9VDI9GBn8ui1Bsd2uDQXWy0dUPeeKUA4r6YUXxeqhhC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledvudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepmhgrnhhuvghlrdhlvghrtghhnhgvrhesqhhurghnthgtohdrtghomh
    dprhgtphhtthhopeihrghnnhhikhdrthgruhhstghhsehquhgrnhhttghordgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvg
    hvseihthgruhhstghhrdguvg
X-ME-Proxy: <xmx:FbOHaeFowiMSu7bNR9TS2pdiapKQxug_7WvCK1sEPyztqytWQPzodw>
    <xmx:FbOHaQ34DTdT47Ynys0GZgdi3TQXwfs-nWzWQOjmYGbmZgl9tyMimA>
    <xmx:FbOHaYMI4CRCwTEGBZ3p4RhZbkiqBxzzANuvEkLHAGAv6XScovCpKQ>
    <xmx:FbOHaX6ryXHL7TxnIlxHXfOpg1id_3oSlXwf5tUk2Ue9-JjC5DzjRw>
    <xmx:FbOHaZDYItii8PXhb-COZYT8wDsRKGchAL2LgVGlRQvskvTWDyKx8DKC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EBC991EA006B; Sat,  7 Feb 2026 16:48:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArEMSgAokomg
Date: Sat, 07 Feb 2026 22:47:44 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Yannik Tausch" <dev@ytausch.de>, "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Manuel Lerchner" <manuel.lerchner@quantco.com>,
 "Yannik Tausch" <yannik.tausch@quantco.com>
Message-Id: <825e7404-f781-4739-a37b-ae3d095fda4d@app.fastmail.com>
In-Reply-To: <3488DCC3-D127-465B-BB95-3D87BB2E48F6@ytausch.de>
References: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
 <xmqq4invm2dk.fsf@gitster.g>
 <3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de>
 <fa7fc215-03eb-492d-9af4-457482c56a48@app.fastmail.com>
 <D514F3BA-36DD-4DAD-BF73-609730390A27@ytausch.de>
 <xmqqqzqxczeb.fsf@gitster.g>
 <75AA7DD7-F8D8-48DC-ADA0-74E56CFF351D@ytausch.de>
 <3488DCC3-D127-465B-BB95-3D87BB2E48F6@ytausch.de>
Subject: Re: [PATCH v2] merge-file: honor merge.conflictStyle outside of a repository
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Feb 7, 2026, at 22:37, Yannik Tausch wrote:
> When running outside a repository, git merge-file ignores the
> merge.conflictStyle configuration variable entirely. Since the
> function receives `repo` from the caller (which is NULL outside a
> repository), and repo_config() falls back to reading system and user
> configuration when passed NULL, pass `repo` to repo_config()
> unconditionally.
>
> Also document that merge.conflictStyle is honored.
>
> Signed-off-by: Yannik Tausch <dev@ytausch.de>
> ---

This looks good to me. Based on my previous feedback.

>
> Notes:
>    Changes since v1:
>    - Use repo parameter directly with repo_config() (Junio)
>    - Fix AsciiDoc continuation, rename test files, break long
>      lines (Kristoffer)

Nice and tidy change notes/changelog.

>[snip]
