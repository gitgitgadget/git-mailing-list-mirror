Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1FD2F4A16
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058843; cv=none; b=CTqfkZKX3SaL14bgrfpUIPUozwe2nRe/KKAOAHv1THwetfEIy49qVjzwfh1Zk64PZrlWEfSjgpHHtUhdI6g7B3RUCotezPauFNlXSphCm6KCMfWpmYVv7LvFjWqVRZ2ge1NVg/GaRsEU6qT+W20KWhE1FmRscrFYgn/gly5j2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058843; c=relaxed/simple;
	bh=GxfYsKIkrJGmdwkwJv3nQK+ibjZ1g6GwiMSIfZ1D07w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T10N7gdD7YrHRP2HjzPTbc946gv2+WBDtuAEGcs5PQClT8EHLKz6gjAytN+O4tK6Zj/TsiRAtgM/raIHIdfPeNoIvNXp3YN2r4o20DNXhKuhOSUYRZFyuQy3PqRpo/CKbVkYiTD8SjBuzd+iBeJ+MmqsZx6qYEGNRej+2IfMKv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CoFLdytG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fUNpaKGf; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CoFLdytG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fUNpaKGf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DDA151D00253;
	Fri,  5 Sep 2025 03:54:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 05 Sep 2025 03:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757058840; x=1757145240; bh=OjLxrsBkBn
	OXEau+Exn8by97175LPaOKKLwa2L1ETY0=; b=CoFLdytGtsDER0kohIe4ZUFIfD
	b8Q+ashHQ3Ia+nbD19gK0j+NOSiz7/prFDOKI9NzgDpxuopK4yNG0aUj9dEKtiqO
	LEA/NLZBo4k7eyd9H63cOBHx0oK4HsZ5OE43vviHPD3WUnIhFtRUBaAiKH1uHp5T
	ghYjucIC9MlcTBc8RLk7Q9TcNea+M3HrA0bM0Zt53KMLal0QnTYRaG+y3Fm+tQy4
	n+Nr4e8LEcRBIt59pgZnepNFDLFm9bgEL2m4JAnupfm22ow3pXd0Zq0KIEnsuT25
	bazMn+dEf8NM58ouFSO3LPb4wUlmScfkGbrXckgNAQ1U0h4FHEvXReM+Huog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757058840; x=1757145240; bh=OjLxrsBkBnOXEau+Exn8by97175LPaOKKLw
	a2L1ETY0=; b=fUNpaKGfhxKGg2tbRfyNWIQy25g3LHiyQwrtM1Sv8MQV3SDA1lz
	sImVRmA/hpCEuh2frKJ+GM//QBA8JhuiC/Q/z7IuMvKg5Vj2Xfymo5yBd7Mb11Tk
	7qUyCsrzjgP25nPPk2XIoYQdMJRapPu8oepXLJs/IE9fyiVQ18X27QzZumjeBNCA
	40MrrZO/ivP8j8PfINCxR1wJ6qB4FKGjXjasjAl4gt/JJiTE3L4iFI+5XMi3ZMe6
	cvMPXUnQB87PPWOXlF/PeQuhDF8+3gr/QYHGo6qIuUMVgEaG1skkB8/6lWKprGO4
	JhbTV61qNcfs6GhqlkEpmOG5GjOagfS4miA==
X-ME-Sender: <xms:GJe6aKcDBrPGi92pZlfUfHfIf8dCF-k_gi3Ozi3A4BYRZLiIgdsv4w>
    <xme:GJe6aEUphxNt21EvOJUvO5Od9wBU2jKj3DzDnuV8_63yBq-iwAIZdcg-LsNXXNFLD
    sLN6Qi-sBsl3iondg>
X-ME-Received: <xmr:GJe6aC-lcSjDsGlvHyf4Au4yz_QoBG4wyb1ZXfUofA1o-Gdu8E8bC0JV2P58rsHgk_XHkRMZPRmtowta6oqeMtafb5FqsaaKV8aIa4UgQRCZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghmsehgvghnthhoohdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghonhhtrggttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnh
    huvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtghomh
X-ME-Proxy: <xmx:GJe6aOgu5ghhcHgurz5c3GKCgaI16fGUkvkouqOCY6HFPp33Mb9Jag>
    <xmx:GJe6aOeMbSGEl5vwgZpQDulYlihcwZXwDeBidM8QmzWsPFiORn1rWg>
    <xmx:GJe6aHKNW3P-9af76DnlrFzQsWcSPiO0RNWRfxT6wn3M-iOWPcJKtg>
    <xmx:GJe6aLkY0tPy9yiVUSt7Q425BpF-8I_A0uTTZYaWdgsy-lRgLG0ugg>
    <xmx:GJe6aMAGb4giwIxbTrJBdfa6AauButEOnjOmWydGG3-OvY8lvxVw9G05>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 03:53:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 04cb7b14 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 07:53:57 +0000 (UTC)
Date: Fri, 5 Sep 2025 09:53:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC 1/3] meson: add infrastructure to build internal Rust
 library
Message-ID: <aLqXEcTMH-qoRHNs@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
 <xmqqzfba6oih.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfba6oih.fsf@gitster.g>

On Thu, Sep 04, 2025 at 11:50:14AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Add the infrastructure into Meson to build an internal Rust library.
> 
> I am a bit surprised that Meson needs to learn Rust now.  How have
> you been dealing with contrib/libgit-{sys,rs}?

Neither of these are wired up in Meson right now. There aren't really
any users, they don't expose a lot of functionality, and both of these
libraries aren't actively developed right now. So I didn't yet have any
motivation to wire them up just yet.

I also think we should reevaluate these once we officially support Rust
in core Git. It feels way more reasonable to design our new core Rust
code in a way that it can be pulled in as a crate right from the start.
Maybe it's just a matter of moving those libraries out of "contrib/" and
into our core Rust code?

Patrick
