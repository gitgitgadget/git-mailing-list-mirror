Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBC1E767D
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967920; cv=none; b=VRJDr9w4F8EmoWQt/S+JBT/RRP2l6pOtsTNO6h2CqWHoK2Q+8ykqVn41XYCid3ntne08TlxhVUad15qC22wKqpLfG2EJXuyJJRUeV08FrLQCUbe/Lfyt6tnSet3CaGOixNx6z+Pap+u64lqG+a/cSWgOcex0BHgE3u00+nCde2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967920; c=relaxed/simple;
	bh=IInsz4NZXg02/aMGrSx1ZbfXIPU7iP/06Xk4InXRRn0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lLwR2LgjDCXBGicPwmyHO/MKzn9mXNyylg96SCP41DH3b7v6GEEXx3CYQWz+o/Z7qqnAMhY4aKHRhEOHYaevfzxTh8nXM2aEPriG8iiQkg4LpVEmAGboyDn8d/3mhsw12o7HdFJ4RznmzwfqdOWHUXooqxXuxA9HdhZP/ox/awI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=revi.email; spf=pass smtp.mailfrom=revi.email; dkim=pass (2048-bit key) header.d=revi.email header.i=@revi.email header.b=E6hsplpR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jE21nuLv; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=revi.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=revi.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=revi.email header.i=@revi.email header.b="E6hsplpR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jE21nuLv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE601254018A;
	Mon, 18 Nov 2024 17:11:55 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-01.internal (MEProxy); Mon, 18 Nov 2024 17:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=revi.email; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731967915;
	 x=1732054315; bh=GQyCqFwUMsv27SFquPSObNDCrgGIHy/DmE9cVQhxJQg=; b=
	E6hsplpRQGMAeOP47adn0ncq8ElC1N563++znvCLDr2dtgkwsSxKVteh4DSvcPXZ
	9kjwBfKE4E2zZqXx84HPqtgzU8omuxNAbUqdLj83TC4JtLbLU+2KvmtFiMKZwpg7
	W4ShkZSIvCYb3CSxKEbOzRVNPqKv4+BsDLBK+eEayiMQQMfe318GMJFnT+NT5OwM
	HGqVCzJJd677lp2OfTwWBiZR/EIKPnvGWTjyuwiPaXrd2fRd5s1xp5H3aCnAV6dB
	mX5qn9h0NRFK6Fj75TdcN6lVZMSq2DotORA8NPxwBXFJHLoX9lAgNCfQ4CuAq2jp
	snRawOc8YkUY3Eswnz1HKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731967915; x=1732054315; bh=G
	QyCqFwUMsv27SFquPSObNDCrgGIHy/DmE9cVQhxJQg=; b=jE21nuLvGlVI1ViEc
	lGJze5hhtuVRVg5k04b+RYjgM7E4T01hT1CLrOMBuBkSXoBSuDr67aTCRP34RJpI
	w9CzFR+Vg+ZbHQ10kqtx5pYZoJwdI5ya9Gj6ObObbZ5R0VOGpcd4HiO0LfbbO/5j
	pzFbkiUz8t72yKBsYDWEKhHxiNgFIb9I8r46VQDo74AB6VMM5svBmTXTQDQsvax4
	ib5fhwSxdLjGHWnR7lXnyEblX1/vOf95G//0RagammbWiy1mv03LTrU5I0cgiHqa
	N5cQean5I0RQ24E/NwT+BzPbt+mZexTvwlvLOskyZwc/zu+3eprYJ5pJZss/uY+o
	GR0gQ==
X-ME-Sender: <xms:qrs7Z1TIQuW6p-Z6lzCcLwot4n_IaDVFJBoOE-7BIqu9wYTuSHAA2A>
    <xme:qrs7Z-zf0GrUaPgo2xeO1wMS-39jvWsY6TvxxJlYv3T9halRF4nHL8dh4PiNGAK93
    z_uTL6bWQMJF0kDEs0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnegfrhhlucfv
    nfffucdludejmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhf
    hrohhmpegjohhnghhmihhnuceohigvfihonhesrhgvvhhirdgvmhgrihhlqeenucggtffr
    rghtthgvrhhnpedttdfgfeehveduhfeuvefglefhheevledvhffhvdefffdvuddvgfegke
    ehleelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhrvghvihdrgiihiidpfihi
    khhiphgvughirgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeihvgifohhnsehrvghvihdrvghmrghilhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggpsghughhhuhhnthgvrhesph
    hrohhtohhnrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qrs7Z623DTF0gqCO9cLIIOJAyg6MGCs34vBIRe2LhyBG2OSSqOavPg>
    <xmx:qrs7Z9AOPNQzEJ8wXt9TGmRt6pIccqxr0UgK1Kekebq_7frtNr1wDQ>
    <xmx:qrs7Z-jy5JarTibKomfnLWsrYOv2zB_c3of_ldlMGfM2HRKh75WWuw>
    <xmx:qrs7Zxp5fpAwzF-NHykrucor0R8i03CRSQYs7DRmo_8rUpbbsGyoTA>
    <xmx:q7s7ZyYkWBg_26cMUqNRiq4yrbPD0vcxtqrXdpLmXpKJhdw9EJCZ2tBR>
Feedback-ID: ie2a949ef:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 98BE5780069; Mon, 18 Nov 2024 17:11:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Nov 2024 07:11:31 +0900
From: Yongmin <yewon@revi.email>
To: "A bughunter" <A_bughunter@proton.me>,
 "git.vger.kernel" <git@vger.kernel.org>
Message-Id: <c115509c-5bc3-4e86-acff-eeacef63b202@app.fastmail.com>
In-Reply-To: 
 <iT3xHcHCZEHBfwKqIhzG1M2P2NawmBzhUtu_JS0PAE-yvlAXG5wLQquajeHJ6m2icOHeHdZybX3ppdp-P6oFgrtiA4T0tzONpvC6AJUiEso=@proton.me>
References: 
 <Sj2qFJa5yPRxluqhZvXlMwgfLuX9n6Um4OOS9IHNXCJU3jjE0YblQDUt0rOpEzY-fUHs5CiognunZO-ddQN-1IVVBEyxLz_2hl936VBW-JU=@proton.me>
 <lLSbsbSEi1ltdY3N1MKhGPVHTPeII5XsqVcYwmh_WHIjVAlNyktnNEaLgBUkh6stvHLE371tlmlhOTdoFloVic-Wq0wE0pQYLBeeVuvA_oA=@proton.me>
 <055a53b5-2107-4547-8a64-e269705de80a@app.fastmail.com>
 <iT3xHcHCZEHBfwKqIhzG1M2P2NawmBzhUtu_JS0PAE-yvlAXG5wLQquajeHJ6m2icOHeHdZybX3ppdp-P6oFgrtiA4T0tzONpvC6AJUiEso=@proton.me>
Subject: Re: How do you hyperlink a thread
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

/T/#t is thread-view, you can use 'permalink' in From: line to get a per=
malink for individual message. See also https://lore.kernel.org/git/_/te=
xt/help/ (message threading section).

I just happen to prefer footnote; some others might just link the permal=
ink, blah blah blah.

--=20
----
revi | =EB=A0=88=EB=B9=84 (IPA: l=C9=9Bbi)
- https://revi.xyz
- he/him <https://revi.xyz/pronoun-is/>
- What time is it in my timezone? <https://issuetracker.revi.xyz/u/time>
- OpenPGP <https://revi.xyz/pgp/>
- In this Korean name <https://en.wikipedia.org/wiki/Korean_name>, the f=
amily name is Hong <https://en.wikipedia.org/wiki/Hong_(Korean_surname)>,
  which makes my name HONG Yongmin.
- I reply when my time permits. Don't feel pressured to reply ASAP;
  take your time and respond at your schedule.
