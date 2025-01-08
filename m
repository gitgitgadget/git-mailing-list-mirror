Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A517E900
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352846; cv=none; b=m04HMLcrk5S1mKuP3VT0COhEpAwbL1VtgMk1ZE0dh9ODMKouuRhRtKb8Mq9Ig1pdqll+BM2313MFaKbJZi1kwhSnOI4E+eILZusyfV6ZdCZkuomqRX5WqMOO3Eo2AYu8D7ez/jwHF5UB6DXLPzShMx45gW216QiQpxr5vpBBloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352846; c=relaxed/simple;
	bh=Hbx8A0j6WxQj7nmcY2py6JB6SeEfOwSkBtsFfuh4fJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFysOFUtM66b1eNvOs6N+b08ggF9tTtnoIPDP7XXsoBdEV8hAASzRjTtdZLfqfaVgfhy8XNdGAmumfV8/js7W6lMXFHL65UTXFyedhor7f7kh5r6VXHA+J/FBZO6xvnIec2/4utL3YOOSzkrz1cm40aonfYyK0Wl16cbI2sqhgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D2uPkJ2e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQKiaXaG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D2uPkJ2e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQKiaXaG"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FFBF138028A;
	Wed,  8 Jan 2025 11:14:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 08 Jan 2025 11:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736352842; x=1736439242; bh=x3nbfJ/NEP
	vS+n++QE7zUQEp/nCu3Tc+nN196k4TnHE=; b=D2uPkJ2euPrx8heicMF3u8i/vi
	VLaJzVmdnyJOkJieU9zynbsJNSHXuCzs9Sv4GvwI2ur9zGyBj+lFTWU9IOf34xyS
	MfWq5wWFetWudvrGV8h5lBjFedZqCWV2rhZp7rrkNMMhrrTMFjjKWBKBfQAIAXEY
	CYv8CdOPnJBVTA23giTt0Nk6McrDGtNeFETRoabBr2Gq9C7AiscjRaCHg8jRSpB8
	XPSLf5R5IQjR8UkomPmHKsOdsG5CrKoKtB94iRbkbRYt2HtMtF+jxOT5mBPVpXQU
	eJZ8khjQj/ei370lvOQn2LuM+X11SA2/rKPNmMYCK1wxS4n/39J5wkMO2kSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736352842; x=1736439242; bh=x3nbfJ/NEPvS+n++QE7zUQEp/nCu3Tc+nN1
	96k4TnHE=; b=DQKiaXaGBj1T2XLiY04Qcch8/g2SrBf3xl597pb9BSog58WCsoc
	tGy6+1fWpaAMaMLgER3tiEm75tcD5M7IjUPiFReijF9YzHqiPKdYzal69UedvR1v
	cmIPRsQAlMXElGKGljIfIh/q27uux6wiANW40oPvpqsXTEyaVqdEoaoadm4O1j6i
	AqdmtvKRc3MReTlbQDhNLWtT+4P3vJxQWXSsvJbipzYs8QHVfR9oqt2lTRajyWgT
	xdhBVROJ9SGqR/DZcb71OP7XQeBvxXjLd8djN4EMv1pr3+HTX6XGdNkgoMzQM1pI
	TGBrZWmym2iINOKbhVnakBUC+iBLMo+xhfA==
X-ME-Sender: <xms:SqR-Z4VM-pWFYWJweTudALhX8OINLYYj-kgn5SE1_bQirHtaLs_prw>
    <xme:SqR-Z8ku5OQ1Qbv1eg8fTfllExVlF1kuFAD03-C5pFeY3lLGWc0GHBpjAYZajpL-S
    JBmI9rV6_M4zXgz5w>
X-ME-Received: <xmr:SqR-Z8bZ3N3Xa9zJAyptxWwMW2nY9umzctgs5mE7UE64rBEveMXtDBlwNaUOMV3ZmcBv7OxmW2wONLjLA7hWNUbYQPgQK_RsNuu5zrKH7mQe4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghr
    thiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:SqR-Z3UJHJ6NTGRMW9dFCAsdjnRQoDMxHGHpdtTEX28HWdYT6IpBiQ>
    <xmx:SqR-ZynpjuyfUZdycJMysQkiDucjP4_CICk_MoXEn54tQ4gmey5o5A>
    <xmx:SqR-Z8e4Bh9H5w1FpaufMLSFOspwNZ6pV8LQOPjLlhkpQbMQjn-n0w>
    <xmx:SqR-Z0EI8Zt7CVmFdRkhMWoy654455YOknvWVM5iwoxtfUt2ScgMDA>
    <xmx:SqR-ZzD-iLNBxLytR36N9wCBDrrZUuk49P2WvC6-ftyI66sXA85c5Gwa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 11:14:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 036c8e57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jan 2025 16:13:58 +0000 (UTC)
Date: Wed, 8 Jan 2025 17:13:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sam James <sam@gentoo.org>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH] meson: fix perl dependencies
Message-ID: <Z36kRQpoK5fMXFhk@pks.im>
References: <371571630df201b0b0c680f6437decc6c60ecd3b.1736307757.git.sam@gentoo.org>
 <Z34Zv55SSDexBxHQ@pks.im>
 <xmqqfrltnvbr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrltnvbr.fsf@gitster.g>

On Wed, Jan 08, 2025 at 08:07:04AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Wed, Jan 08, 2025 at 03:42:37AM +0000, Sam James wrote:
> >> `generate_perl_command` needs `depends: [git_version_file]` and the uses
> >> in top-level meson.build were fine, but the ones in perl/ weren't, causing
> >> parallel build failures in some cases as GIT-BUILD-OPTIONS wasn't yet
> >> available.
> >
> > Thanks for your patch! The change looks obviously correct to me.
> >
> > Patrick
> 
> Thanks, both.  Will fast-track to 'master' before the final gets
> tagged, but we may want to advertise 'meson' support still as work
> in progress in the release notes.

Yeah, agreed. Thanks!

Patrick
