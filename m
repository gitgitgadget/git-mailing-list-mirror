Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D42187325
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734265577; cv=none; b=FBKe57FgmV4MDhovHxNnWSUBY31Z3r5jEPHCiSku9k1NQ0FU3bqumMFA5jmqOT38M5YYYMI+CkX+ynoEsrSuwSzCCjKTTQRaG+I4pRMaZe6EiamOaXleppNQD6s0pYxax87z5u93cP7lC5s0Cto62vixinYkMHhvm/+HIe0Z+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734265577; c=relaxed/simple;
	bh=v9D2PWfvhLV1mk/uv2GAit7GTvi2gThwCiVE9raVsOc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a+xZYpE5eeziZpM1+zgK6dMMHGUVN8b8LIgVGnDxwPeuBo4+T1fFLn+k8K8wwniuxjIWGLTVQYU72ctosKZvz+xjuxlJyc3yPX2uUYLhl22hAjkSho+jj4zF8bKufJ/bWmZ/bDCv4vhG02kx9o2FOi0MYPl01noLbEACuZc3e8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OLT7Ywes; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l+sHjoNp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OLT7Ywes";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l+sHjoNp"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D70C1140106;
	Sun, 15 Dec 2024 07:26:12 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 15 Dec 2024 07:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734265572;
	 x=1734351972; bh=v9D2PWfvhLV1mk/uv2GAit7GTvi2gThwCiVE9raVsOc=; b=
	OLT7YwesfGsqh79IQrpmcVue0NWJcFcp4ghFdDRJr4tQagUr/PWnoO+Cp91yvSmK
	XOwDLYkhezFWm9pGAaae2KpMZql4oWUHjGhfPplIsIFjMt/kYiDOOPEBp/qid/ge
	UZeFKadqheJWI/5+zFV5gAtbW0LRx5yKhhsHczRztEHfm2qsVSgHK08ET4dDVwCI
	kVyVKd7Cd9n+UBUrXzrdQdMnlrqguDZpElB2668Wr6Gx3twZSZ6nmDn8OhqLyWHg
	j33xcNPPjfuaIP6MOevofliC7eSDNGh9szeSnh1dxs0vplA4gqsrIPEp4pEiibt7
	cozQI4N+5A1GHqRdZBPGLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734265572; x=1734351972; bh=v
	9D2PWfvhLV1mk/uv2GAit7GTvi2gThwCiVE9raVsOc=; b=l+sHjoNpU5zZkmYFg
	wYJpT4Ze1Hwg5anmBjocvo58ITkjFI0cfQV9+48879Bmxl+4MOvUzM2+pLdwAQo+
	Qx5Ujikcq2QO/hsNSwGNzED6I2GRQt1cYSVfPdesJ5MOaYDEH/aG583g2wCR0tgh
	JuuqnbFKz9oMmEGILrdxUA3AyI6Ya+BkLnx88nHc0VNHop59JR/+g18Zcj145jEC
	Z7vSWNcRHTfLieC1LnYMU8/Nl76RmEJH0cKdQhOMVUIWKChG/gCCVu7GiMhcnQ0D
	xlPShUkN46cV+rKqpk5+vShQ9fjSZCVmJJCtTMVAj1eLCVsOf6pK4KGs4yeIyTvK
	ZnzZg==
X-ME-Sender: <xms:5MpeZ087JsQuXs9fNNj66vv7qyX5lj3dhTfkwikyNXI1l-TuLwU2p84>
    <xme:5MpeZ8tWWlTXq4_m_w7gqJ9MvMIx48AeUUmU5AgGlKaVuS5U14-uai2avV0KDwP0B
    T2Jt1tomhzYKd3Kzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    fkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdffhfefffejfeffteetvdettdev
    feetheegtdehtdeiudefffduleffleeljeenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfrhgvvgguohhm
    gegtohifshesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:5MpeZ6Cu9Rg2J3L1EaHE3NF9F2ViQriCMwwgNdpew_E4Ih6LevctvA>
    <xmx:5MpeZ0eG4lstKUH5QILg3Tg845tespzvoIivBpovI7L8oyYcrVvX_Q>
    <xmx:5MpeZ5O6zjtcNgJ3EPRYwdm70se6BmXcRUFLRJIiAkgYNY4y62_kDA>
    <xmx:5MpeZ-keEC0V8FNGRhF99g0sodtlL0emHa4izLCZcSLza_OySmAQGw>
    <xmx:5MpeZ31zMybeS6BB4hFm6awNGX8IXV54i51g4PHJPOEBlRYA_I7W1XgP>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 48912780068; Sun, 15 Dec 2024 07:26:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 15 Dec 2024 13:25:38 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Oliver Blanthorn" <freedom4cows@gmail.com>, git@vger.kernel.org
Message-Id: <ddc10a19-f8fc-4532-90b0-5485d5126bd7@app.fastmail.com>
In-Reply-To: 
 <CADFnu5sMEvGyGy7xH1r0NGBUZJBznCi0waJ_bJ3tSHQ5Y2yX1Q@mail.gmail.com>
References: 
 <CADFnu5sMEvGyGy7xH1r0NGBUZJBznCi0waJ_bJ3tSHQ5Y2yX1Q@mail.gmail.com>
Subject: Re: Bug report: ":/[text]" revision reference no longer returns youngest
 commit
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Sun, Dec 15, 2024, at 12:51, Oliver Blanthorn wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> `git show :/Merge` in git's git repo
>
>
>
> What did you expect to happen? (Expected behavior)
>
> The most recent commit matching the text "Merge" should have appeared
>
>
>
> What happened instead? (Actual behavior)
>
> A commit from 19 years ago appeared

This has been reported here

https://lore.kernel.org/git/CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com/

The patch is here

https://lore.kernel.org/git/20241206-pks-rev-parse-fix-reversed-list-v3-1-d934c17db168@pks.im/
