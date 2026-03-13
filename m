Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A8315D5D
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383530; cv=none; b=b7oBq/qPoBIVFdlIE8rZ/Z23ikNjPJ6yp5ygWQ7TQt/Dz43UdaCDu56gbsv/sksyXFT2HyAFnp+ouaLBeI8VaFD43zBuUnqlc9r7r9EGBfA1AIRVJo2qH1l74OeKUvoWxtL4M9a+oZel3B+s78cb++rkpvSP8yHeVkEtoqfpRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383530; c=relaxed/simple;
	bh=lA6GxF1exuxq4Jkxcfg2T9vlyofY2S8ujYx74r1ZxC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH/xYAv6GITDBvbBf0aQPQ2qLlt1+CrihEQMm5N8UKbMOYoM5o8O+MME3JAYjMsi9WqYfvrM4PXREixiza8O9l5vGWKTB9JRpQX9N8QWe12iE02JeunwIOGhi9cV2w4nqwKVCKHLpBffrOy+cAjr0QgOVUIET+bDr+YnTzyyD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EYsk9tZV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dSIhIDSd; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EYsk9tZV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dSIhIDSd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 187841D000A1;
	Fri, 13 Mar 2026 02:32:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 13 Mar 2026 02:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773383523; x=1773469923; bh=eIHyD31Ade
	XG+ldb9Eq33O62RUOGiYbMzY4pWmxV5Qo=; b=EYsk9tZV1pgpEss0ZQ5ypRoelO
	XOsIWJrZrEKsR38pA79w9dKsUzGfiDinejtgHKgHvuCYMpEsrmd22bEeno1f2nBy
	EPavB05VL6V3IeRfEoK3MUAie5XJveNoRBG8hhw9qNUv5sIiWvr0sNaLZtC1n85l
	dXGk4KSayOq99IfsSEBHeaiaYjHQf39kK+4jJ2KXIP7gMtCsNrkolS5Zz2AH8miw
	omfGjDHIqBitI6cn2OHRQlu4CMef80cYEvI4PE7d+icGUkoR4XVheQwomV8bhRey
	yl/jiPVRrMtEVVMFfOBSGruOL9WduhKdT0aV3mzod9G4BOc6S+CJd0bfEmsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773383523; x=1773469923; bh=eIHyD31AdeXG+ldb9Eq33O62RUOGiYbMzY4
	pWmxV5Qo=; b=dSIhIDSd+813MKs8rcPZWWtjWy5qsw3cLPj2v7iNsKQzQww0v3Z
	JyrQwSmiDVe0sXkeV97lzby4rhG2gll5YeAZN0pvUe31HSMJDOoQOWdSSD4L4HIy
	3egRrkB+7uh7DJvhJAv11iptyCUZ0Da7aWRuVPOaDyQGXUSha7MX5VagGVkUWiAz
	ue85czrS0cbKgt1+PmzpmAnJrKS+r+z3TqWi+lr+O3OBqX5keC9tc+1lzcKgb2/k
	q9b40AJ7/3sYI05JkUD3vb1ysffZqCnpXQ7SIu3Lrp/WVKVq2vRRDRMEVpIckZ87
	qsXbDIhGBt1JlAVuM4xX6yMMe3/1jf3WopQ==
X-ME-Sender: <xms:Y6-zaUzBs0XRKQ_tju-JanLdW-PQRqmMiGvbvYhFAOv999X2LS01hQ>
    <xme:Y6-zab_WtD5ik3pVV7p8Tu5lOstMTrrvkgAnUeFCR4PWXzEHMhzog2cCwatxZQI5a
    Mlx7FAdZN0yeic0MM7B0bwiioVqU0bZHMiBxzeRTNW_vRBwigYOFC0>
X-ME-Received: <xmr:Y6-zaQJkxg5so3HijBkeHKZp08yGDxQNONQYcDJCF7HIBoTeNQftphoz3F7h3rd0vJy3GZ9MMacyEO2qmbPYB4XkOJJwg7J-4JRzzXZFsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Y6-zaZfQF1qct_WpBAXxOMI-hKJDg5JTOJmkEOEybZ4oZQ_vVvB5Rw>
    <xmx:Y6-zaX9JNWXTbR2_QzSvN6iWP0cpUZZuB3cTNZn9xds7AsAjmTKRbg>
    <xmx:Y6-zaeqD_Gk9VZBBIErQZ8btz48ehF74nucKpUgxTtJCkLr2w6piVA>
    <xmx:Y6-zaUDdyJSKzoknYvd9TcgEJClF3CeDMyK0pVJtKY5A16G-AjarMg>
    <xmx:Y6-zafCbVVOlLNnby4q7wjBwdCtH78dn3T4cPwkF5M3DecI3J17z16CA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:32:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd170534 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:32:01 +0000 (UTC)
Date: Fri, 13 Mar 2026 07:31:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	sandals@crustytoothpaste.net, christian.couder@gmail.com,
	peff@peff.net
Subject: Re: [PATCH v6 0/3] fast-import: add mode to re-sign invalid commit
 signatures
Message-ID: <abOvXzwDLppM1Rzn@pks.im>
References: <20260312192228.481134-1-jltobler@gmail.com>
 <20260313013938.2742124-1-jltobler@gmail.com>
 <xmqqy0jw8i8e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0jw8i8e.fsf@gitster.g>

On Thu, Mar 12, 2026 at 09:29:37PM -0700, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Changes since V5:
> > - Fixed a test that was incorrectly referencing the openpgp-signing
> >   branch when it should be using the ssh-signing branch.
> > - Changed warning message wording.
> > - Added some parentheses in a conditional statement to clarify operation
> >   order.
> 
> All three of the above look familiar ;-)  Looking good.
> 
> Will replace.  Thanks.

I'm happy with this version. Thanks!

Patrick
