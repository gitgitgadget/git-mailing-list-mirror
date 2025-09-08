Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC329C351
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313721; cv=none; b=Pj0rsW/zVwJ9MUIGaXywVxluwMSxE3LTB1jCH1U5A2pFfQpuZig4QqWU5/pkwosBMsQbO+XykD0mTWW5UXARJw8qTfzmMljXxounoZ1fDA+o5W+Pnkz6ZsHopa9Cz2P6CsXJ7ZjYahPyluPEQXUw1awDr3N0E+gi5IZNFJYD6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313721; c=relaxed/simple;
	bh=goRs94hEom49e0otRxvaPFGDqlH0vZEUV01u7AObAyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jur5smfxGWZ96Q7xJam1E8l0OURBwXRD8W0jhJzbcBfNwBbGHnk336up2X0YaleJF9BY8j0WpqzTt8Iz3tYYWLJIHWSHgCuJlP82wJna+LBK9IGMtHTW+OTWHpwdvc0jXcxcpGQlEqzyHdAZCg9/gjKCXs64mbew01wYYiFieU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qjyNDz30; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ey/K1KsH; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qjyNDz30";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ey/K1KsH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0AFE97A0044;
	Mon,  8 Sep 2025 02:41:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Sep 2025 02:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757313717; x=1757400117; bh=WeFX+3lnlv
	lmZTacFKVz+hNX3pIQ7eEuwXzZdex14BU=; b=qjyNDz30E1j0xhomtRwMX2QSJ5
	tEWV/DSoTboS4l6FKijYcReoc0My2ZeR/TYS0q+vE581LYCufJA3bL4noLp5Psc5
	gmrcwNAXl0AfNcoyrvDZGSy+SQfTfFmJCEWqQHVz78+t7kL8DPVjkDYPoCwgdO/1
	8qohjCB/Ym3JaIz34Rq083IoOFtsj/nqGbj+r2FE0u2nzNpjnlOknzZlRgdUubBC
	u8A78+fF+193Ajj6uFWOsDSIQnO2Vjj07XInipEzgYs2LK02SWLinrfynwhiGpx0
	aHc0E7zZrJ9Yze5Qnyp4zqEnCLFdzaCcACthyyPd9oPj3Y9xFTL+xize4ncQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757313717; x=1757400117; bh=WeFX+3lnlvlmZTacFKVz+hNX3pIQ7eEuwXz
	Zdex14BU=; b=ey/K1KsHfhAF1WudefEsWRPvQlCUVphGkRd+Fse/sIyc1oZAw6I
	nAjSk7rUX4QLfpauuAjktH0++oUylIfBrPjCQrMy4rmgEpKYtsiMg4972ULqhmD8
	CAFAKpnz3F9txUBtxE6IyGJHNU77+28fM9DfGCkOj1ra0luOFo+/AwtOUmax7aTZ
	dQIzSjal0dhtFv9GvZ04t58NImoMc+rI8F3vnBY3gMfYVTU8CMfghPHHTnbNoaYX
	g/Qi8+FVBWg/I3i979ytQL2qsuYRBYKYXKXy0FO/0DDk46M6t6LWiK5hbTK5h2+g
	eh3HG/R3u4hPdlm3y/BhK/srzdtHFSy/4Rg==
X-ME-Sender: <xms:tXq-aB68lkmKjpEF3lB62T8USw5jpONbfHz1XjUs1Guv1OEDWEHRRA>
    <xme:tXq-aPCdlHTO3TyX9suy5w8Aei0LKHlYif5dsOvO_vrwcjAxxGq7shSZp9zzEaTlo
    j_HIJ-tyN18mutRJA>
X-ME-Received: <xmr:tXq-aP7zoWkhSMXqO51YZ6Uc0bngYgsh9RMfZSC6JqfM-cdSu1atmtZwP4w9TUVI9GL7qZQ1fAgv32gPZxK_JLRpaA2IhMjvYDH4Wz0Ag7vczg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fhiefgvdffvddtuefhlefgleehgfefveeuteffudfgheetgfevlefhueeuveeuvdenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrghdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghonhhtrggttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:tXq-aAu3GVqIDJ9P3GRRXDE6-iqujdGKOom-k84BuSDpde6igstw2A>
    <xmx:tXq-aM718dokOIhVFiVrQB7VfkjNwDcJ528XX6z_3I2FxuKRU90heQ>
    <xmx:tXq-aM3B720rJ-WAWv9VjZL2V0Zr6wk4et2JKARZzPZ4saw_NlTNTQ>
    <xmx:tXq-aHgl2tlzNlglB-mT3PjzOG_6QvOd9NkuZkUiePm9Ltk0wqsCHw>
    <xmx:tXq-aIMKR80iIQavQctos9oyuGvbRjKu-3Lr-tiurDGjyTy8Wb5mGTg2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:41:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85464985 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:41:55 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:41:52 +0200
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
Subject: Re: [PATCH RFC v2 6/7] ci: convert "pedantic" job into full build
 with breaking changes
Message-ID: <aL56sBX-omMKIp2y@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-6-6939cbf4a0b8@pks.im>
 <xmqqzfb7yuw1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfb7yuw1.fsf@gitster.g>

On Sat, Sep 06, 2025 at 05:21:50PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >  fedora-*|almalinux-*)
> >  	dnf -yq update >/dev/null &&
> > -	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> > +	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> 
> This drops "make" and adds "meson ninja pkg-config".
> 
> https://github.com/git/git/actions/runs/17506343802/job/49765327830
> 
> seems to indicate that AlmaLinux is unable to find meson and ninja.

Oh, I completely missed that we have AlmaLinux in our pipelines.
Should've taken a closer look seeing the above case statement. Will fix.

Patrick
