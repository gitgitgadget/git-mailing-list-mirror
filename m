Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3F266581
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287807; cv=none; b=uM3v7E5b3yM1XL0fVEOnKzofTFwuq6VileTzw+xevyTHSNvOPZeFNIi1wF/OfB5DOLtGg8heL840SGOEUV7iFH3RxvLhCaErjf91PyZ43VTmr5uRFQzcweSwCorA4LTiRLzv4VkcQkumERJ0uSpXZ/t5O84r/xvsn1ojCdxP67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287807; c=relaxed/simple;
	bh=QuapfBDmPZOgxL+snkfhz/KzGs2rBdTUjgYpZDOIyKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtPIgDuNZKkhHZeJpTU5YGfxElISj/X9p+XRiOtDHVGYLqrr2C28YqeVhiucWWfr757wxwfjLoxPTO6GhPlT9Wk1/JbJ3k4URFbbuxG9prZgcYmyDvR3LGNA1ho9zeVLuPyOn7u//aesDybvQ2lYYFiOPd21EpxwHqgcB3wcoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZmAOV/yZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lyK48PjO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZmAOV/yZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lyK48PjO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FB7BEC02A1;
	Fri, 24 Oct 2025 02:36:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 02:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761287805; x=1761374205; bh=dGJZqa8ffI
	V4sBwaNiWU/oIzSkkdQqYUQCReBdsrI3k=; b=ZmAOV/yZtmfmNbr5neFNtGKQGO
	mZI8sa0xOWY86Aqp9iOksJKaKgEGw8e85mQhNSOhulD+KkYAHgCX0MjrVXzOCQAy
	GHqqethC3DSxa+HuGQyN2PSxIrfxIuf4EwAcR7XbOzdHYV7uhQ0vSKGBg/gdzZ4F
	7c+HsJVE0QiGOSWT5ZHgBOp16OgccbZGHfMP88hs0RFwZ5Id6/duYbftlNCt9omV
	x4fXBlD+LXjiHxqhL854cnS2+yQ1t8okoLETkZ28hG5e0GbWpJ3kr2njFsaHb2Km
	x8u0DqVKs99V1Vt7sVkCx/rlzfRmXVzcFflFh8ZaBPHqa45V866NFzhvdxNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761287805; x=1761374205; bh=dGJZqa8ffIV4sBwaNiWU/oIzSkkdQqYUQCR
	eBdsrI3k=; b=lyK48PjOJs7NPW58WA/loC9ez8nhl55p8qYNgJLLIiS6M57bczC
	zfcWQ0Jlt7N4W2b9NG0ul2j3lzEO85wGxrOWiKv2VjOy7nzWe0rDFh0nMfboUi5h
	ndJdeVC6/iP9D2e31ZhpnsFat3FvEEOrAjjGDFUl7brskiHh7vlyXD4tu6VHWcye
	edYuWwFuTHIMa5QDvsUMXrarBc5xmpMjIGr29j4wOqJ5PupkiAPr0ksh6WZ9GMCo
	cGA28B9OraqJyElABRkOsH5yCW4WAAbdf5oGWTvwopPpGdFHC2Ig03Fy/iYmIc/F
	tWnLJS1yGyH/o4Vd0nKYFe1HsKC0Sy0LfCA==
X-ME-Sender: <xms:fB77aPOGSFyE_jybfcG4LHo6CbwAI_RW07vef2i_FwkdX86HeOUOUg>
    <xme:fB77aA-IUvnIH6fphoag1QdaCC004dde039ix97kC-D6EJk6ZRyJPuM4xV8RNPL9n
    MR4DIeufIE1duN07x7FOiwCki4X30qaEL-kK1-CIQ3raOsYCDpBuw>
X-ME-Received: <xmr:fB77aDR2HyzGxADsyvuQwpxhcMz-cC4Vq_zTFOYT4CMUWklU4qUDe3nkUYJTthxLATB0NMnAd-uZsXRJvGVR2ZIKHSZP5ZUbImjEQDSKtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:fB77aCkaqPYKY5k_oMnP_VnJriUm7dkklDEsLLz_jjlESEHOFvfaGQ>
    <xmx:fB77aDQvIWbDqIyWMLR-2UUzrWvEc-asY0Quv4zGhGR0BJGxHdMo6g>
    <xmx:fB77aAMfEDceqeal6S_zC2MjVrcV8boietI4IhL1AY8mGiK54PoLgg>
    <xmx:fB77aMX5aKZq5z0gb0SXHhEcO0vrd_ZRvJVQJRuqSMHxrmPv4kt9dw>
    <xmx:fR77aNAFP_eNiI4DRYU07U-jc0x9KTya1G1np9ntQvMwhHpua12qeqop>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:36:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e8fe35db (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:36:43 +0000 (UTC)
Date: Fri, 24 Oct 2025 08:36:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
Message-ID: <aPseeELtGzHvn2IS@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
 <xmqq7bwls0qh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bwls0qh.fsf@gitster.g>

On Thu, Oct 23, 2025 at 03:37:58PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index b7b3cf35edf..3bce6f47f87 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -37,7 +37,7 @@ fedora-*|almalinux-*)
> >  		MESON_DEPS="meson ninja";;
> >  	esac
> >  	dnf -yq update >/dev/null &&
> > -	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
> > +	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo cbindgen >/dev/null
> >  	;;
> 
> A single ~120 columns wide should be line-wrapped.  This seems to
> fail with almalinux-8 CI job due to lack of the package.

Thanks, that's a test gap in GitLab CI then. Will fix the issue and the
gap.

Patrick
