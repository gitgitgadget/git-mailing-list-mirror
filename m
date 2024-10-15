Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925AD1E2821
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985658; cv=none; b=CqyMuga+CQL4kTA3Z9PkV1ntuUSmxsekTy3U55F8QHe4ptjIxc2RlZDG312sYKKg1LngQemHhJ3JbBVIB7RYb8az7VU55nGSmXF8zT5E8DZwQqvUj52jVqVEruvns+ugZlaTAR4qDn0HoYyJMZoazn3sr9Drf/zysnmeF8XKQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985658; c=relaxed/simple;
	bh=HP1ebyYe3FoylbRVei55CbSzaZJ3i35i/A4BKJdI31E=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CyOuC4LE+H2Y1cjaaHpo8Ih7sK9/pcFSJZK/eoBmdFNYxoxftzmgZKPvFE9eRqD6TExRH5wH6fXgvdC0Qd0EpLZeqt3ktUGCwNdSkzQwlfaMCK9aXm7xVGSo9pZ/IatReoPddq6zIHjlIESdlqXVarx+TjIjhZKwwG+wZ5fq9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q1Wrsh8T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F4spqmtz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q1Wrsh8T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4spqmtz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 652F111400AA;
	Tue, 15 Oct 2024 05:47:34 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 15 Oct 2024 05:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728985654;
	 x=1729072054; bh=jyi3OyBI1MSx79VxVCe8NDAs6ET0KDpfDePljnTVBJo=; b=
	Q1Wrsh8T7bG7FzWlXGMWs9KjC24xg7/MMHSw9M45nzLFnCRQQ0egMQH0JjC+ZTea
	a3HDsXGkRvm3d4f4yTzTLNZP5iwHEZjmJap3v8XrFldAPCPN2jlDorGZIdyHNoZ5
	dcTkWhLVxm0nxJYY1DRLEEIhJGks04DmK9qXn3BeiqRRAgr8fToHLhLrJhZB4Z+I
	nLCzZQnlw2kw1sMIURKP1DNwotROoLMyvnilY7CahCuI8BAdnN+cGu+zc8X2HaSg
	YECyyLNvp2TjYLVDlVYL+qkgNki6S1bz7uJ8FMGs9QTiLoRTpyU4jLmYgMXXpzoT
	auFnpRx1TcNVuUPUeycXsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728985654; x=
	1729072054; bh=jyi3OyBI1MSx79VxVCe8NDAs6ET0KDpfDePljnTVBJo=; b=F
	4spqmtzrZ38ut7fnyFaHJPV8/cT7n6/GcWBvn315eKcczSe2Sw0TN8y4Tkma2OIq
	f25ROvmhOBB11huD/4TV4QWUSTvCTk2HGIyhuR1vv7np2bCvrZkBT6OPpfXkLC1+
	ClrrwIA0ZtETC5GcisI6Q4Gimf5heO589Bpx0iAeZ1JxZlsVApcJvKbxRYACXm8v
	mKKl8CQXmrDxpBz56UMbGdDdqijs5KmrN2q3ZbPSfRXjRj5KixoM7sAmUl5QWuFd
	VIl8ESamvKopnTDIENz8NFlluXJX+/aAwWTuYhRjGvYTG5qr+ZOIzkSHvKcekl8b
	ZtwWCOkhnNHIj9jconbIg==
X-ME-Sender: <xms:NjoOZ4HK2cZqdQrxpTtpnmeo3KB7Fv5DBkBAx2JW8j-oRWAsnhxyqt0>
    <xme:NjoOZxU7jStvESlRdvnE-vxw7IKJR5_iRHuqqLu2IqZfmMo9askscj-vb7T3Q15T2
    j1KlNt1oFshNclTMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveeiledtke
    fgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfiholhhfseho
    rhhiohhlvgdrshihshhtvghmshdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:NjoOZyJe8xJXShZNU8UgO64m-OD41CUNm5pkh7CF9ZSVtsqvthobyQ>
    <xmx:NjoOZ6EMbUApdzhu5SvQkZwsdddHqzVopng956E_8joFffaDAHMMVw>
    <xmx:NjoOZ-XKduYSm81qWactuK0HO0TKOlLpNT2qapwZ-MgAOO4n8Lg4nA>
    <xmx:NjoOZ9O94PxQXKpwcHYcQZek5-NAc3IVYwc7LMnjnmxRBnvSiJuWlw>
    <xmx:NjoOZxergvYSjOvFL7M-K6NLVM-PTD_yLEJO9ppU0OjoI9BZ22Z-oDW9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0CE45780068; Tue, 15 Oct 2024 05:47:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 11:47:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Wolfgang_M=C3=BCller?= <wolf@oriole.systems>,
 git@vger.kernel.org
Message-Id: <08bdd8dd-06d8-47a6-8b44-fa6add14d60a@app.fastmail.com>
In-Reply-To: 
 <r4btv3hmwv6haflwhmjbjshova4wnth5mkbknsuuqcvose5lix@bvy5e6gxnit6>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <r4btv3hmwv6haflwhmjbjshova4wnth5mkbknsuuqcvose5lix@bvy5e6gxnit6>
Subject: Re: [RFC PATCH] builtin/shortlog: explicitly set hash algo when there is no
 repo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024, at 11:33, Wolfgang M=C3=BCller wrote:
> > [=E2=80=A6]
>
> Was this topic maybe missed? It's not a critical fix but would solve a
> segfault that is pretty easy for a user to trigger.

I can confirm that this gives me a segfault:

```
# Directory which is not tracked
cd ~
git shortlog --author=3DKristoffer
```

Maybe a few things could make the change more ready to be included:

1. A regression test for that segfault
2. A quickfix (which you indicate below the three-dash/hyphens) can be
   documented in the comment above the code with a `NEEDSWORK`

--=20
Kristoffer Haugsbakk

