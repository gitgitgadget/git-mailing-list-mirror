Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1027FD4B
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700546; cv=none; b=TzAEQKf4FXrIsVswxnrcMlv3aiQy3yKn9keNtc3sQb//Wvfcpr1bOT26C3uXEcNOWIkXZTPSW8mn8xQ+F9r5k0SS5M2vlqn3aPrcd+rIGE8i6IUH2enULcwWGBbfiEHkv55Nz6gO1O+nAZzhOl0Ws/ym3ey98Uut+UvQKSS5za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700546; c=relaxed/simple;
	bh=TrFajfNTxUw3RxLsh35vrQs5sBIzfJuoSmNhgv8iLWA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+CnpXUGz0I1r0++XzrfZ8Lkgpui8gklylTr4yy3+Yk8/Zko+Vio9vr2tsgFrLJjtx7bKpquure7Z8Trp91de+McQIYI5kYxQgBuuHVcE5XycW76KF6taVxlU6+PT/FY054c9zLkp/uNqjTQqHW0wE1OhFvA3CnsIwhHYdoVWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rQFBP9HU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GygwM3bv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rQFBP9HU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GygwM3bv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CDE8EC0121;
	Wed, 24 Sep 2025 03:55:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 24 Sep 2025 03:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758700544; x=1758786944; bh=C6HBCECq45
	LmbUMxuyYx0NP/Lqthk1K5q+VCUW8fNVs=; b=rQFBP9HUyu3B6z7ZQ495fhneC+
	fHT18C7PBHinnZIUuBMwWC2frzMUM9f4rWpm5PB7BEokarLBlnGAn3dckMZc4CXc
	aRXPDKHjAbtdg7eI8oigYy465CdyvaDprxVtUUse5gexDiqHtSX/SYSNx2pLEHYf
	Kc1HyszJyiSbmMRcc8MsEwSQOocgpABeaS9c/zJ8xQ1xTEMZiuTMEJzxNezLcPvy
	nm/eI6FCTGSqXYQZcznU0119AzUW0nbFEUZ3Ab/7pwklWODt1Wj1uVHY0ed/Qvj0
	BjWlLvWECV4CCUOx10RQstqXo3YWvOu8esqe52PgSL+vzP1bG8EYatdFCL0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758700544; x=1758786944; bh=C6HBCECq45LmbUMxuyYx0NP/Lqthk1K5q+V
	CUW8fNVs=; b=GygwM3bvPXV6+0YFPle5chawZ1pOe1K0pT7BI2GZnodL58Scioa
	0oq/BERKhh2FSAzKS8I/lApa+lfJ+2G2flHTsig90kUZoEiOb5A1hmDquDCf+uMi
	xd2NSENE0V6/OC47+baO6UOzWJoAZkdu5zJIxf0NCSqlGWvCR/wcLDkYQM4jjW2B
	IY9Y1Ryc/9lH/wHf78b109kxer8fu5FgrYjAtdDEgme3phSB53amg73spm3WMlFJ
	TAPirn+LTcpHcR55j91Mqy8RlhXIBwq4gSr0aDUu5Vyb2/r63w1DO5XajOLSqjs0
	L2jmuRDLA1bQSbXrS/Q52L4mltIFllYbk7w==
X-ME-Sender: <xms:_6PTaEgaPqsO5ed86CV7V-s5KO0d7xazpKC2K95TOnheJOBjWPGOBw>
    <xme:_6PTaEChnMJq5R6T5CtTJ_kQ7V_s5g6Ds9QB7lR4hPJ-j1VIwe7b05lQ0aN91kIyX
    SDbeJZejSUcAn9vk4slsN0APVUK1CvCBbyvAlhojWL9xTERCAWP5w>
X-ME-Received: <xmr:_6PTaBE2eirRoK_DXsudT639swexoXsmA9glTvBk8HQJTy1cAGp9Dj63dlYUeyKHeUVjcMXKpv9FtPfPtiq8mbcDDFmrRryw8jAkljJvKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephe
    ekfeefgeegvdegvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruh
    hsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_6PTaEJZaFF3IX1Qowjo8JH4-uGLFUHv5DqYLFH3D7YjMnHlUSBoBQ>
    <xmx:_6PTaNmCuJuWv9zLTbHRrDX1vFTe6AqEogvRncVBpKQVFZpcWyfkvw>
    <xmx:_6PTaET6wC_Ia1gpEsNoPLxxA3vK2DQJK4gjN_Aih_eL1i6TvMJK8Q>
    <xmx:_6PTaHK6nuwBhwQMVRUKtWsLVf-6O6PNegfYzJ0uC1WT4nnRvGqsJw>
    <xmx:AKTTaAWzlRWg47A4xsjpsh3g6TYx98gPcsyoO67mFda6Y0uFr9bTOf_S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 03:55:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d061be9c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 07:55:42 +0000 (UTC)
Date: Wed, 24 Sep 2025 09:55:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/9] docs: reflect actual double signature for tags
Message-ID: <aNOj-1xy-UTP_3E1@pks.im>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-4-sandals@crustytoothpaste.net>
 <xmqq348i138l.fsf@gitster.g>
 <aM7IQibwwKFJZcYE@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM7IQibwwKFJZcYE@fruit.crustytoothpaste.net>

On Sat, Sep 20, 2025 at 03:29:06PM +0000, brian m. carlson wrote:
> On 2025-09-19 at 22:34:02, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > > +an in-body signature and a gpgsig-sha256 header for the SHA-1 format of an
> > > +object or both an in-body signature and a gpgsig header for the SHA-256 format
> > > +of and object.
> > >  
> > > -This means tags can be signed
> > > +The signed payload of the tag is the content of the tag in the current
> > > +algorithm with both its gpgsig and gpgsig-sha256 fields and
> > 
> > My reading of the previous paragraph is that we cannot have gpgsig
> > and gpgsig-sha256 fields on a single object at the same time.
> 
> Correct, unless we come up with a third hash algorithm.  Hopefully that
> is a long way away, and we are not considering that case here.

You mentioned a "missed patch" in the commit message. So is this design
here intentional or merely an oversight?

I'm mostly asking because it feels weird to me that an object shouldn't
have both fields. I would assume that it's easier to implement and
reason about if this signature always was a header, or multiple that is.
But I'm not familiar enough with the logic here to really judge, so I
assume that there are good reasons that I miss.

Patrick
