Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1F231A3B
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313659; cv=none; b=pVF8cr8dTm8CoEk1aXxBLEpHSi9CQaIPs1o9lnxkgnvB/99+kX3urDtx+IeGKuz+B7uadlpLKjrsSxmosoc7htOehtkezdsfvzcCnKGckZkUw2DXRc/3dv15E8pkcmYdMaBnaj3Z7aaoDynppn/ngUD6jK2vvS9SO+d+6Z5RmYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313659; c=relaxed/simple;
	bh=ee1HyOu+krxffQEokgYOereesHYB44GIoWlEJn5b6IU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j88uweL2E/ZLJLjxHp1ILuqoPExVOOVjV+VvuwOy/wJEcHMUqzHrSga4+vlsi6a6jLkdYtwIV7YzdymUOhohHh8F/2dNm4CBDu996XGtOo+93jsL1/fKS8L18iihveQvb91IGoWyP729j8fczrb1SpjceHIw2BI8d4jnjN1I13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PmC/+M4J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DgPu3i6Y; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PmC/+M4J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DgPu3i6Y"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F36381D0013A;
	Mon,  8 Sep 2025 02:40:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Sep 2025 02:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757313655; x=1757400055; bh=3g7tt5Hker
	9ob1YoprbCpCt/jyXhRhuOigpimnL5Gq8=; b=PmC/+M4JqXo6Wxm0NhXRB12/0w
	L87VVDnH4uP18hr5JqeGANY2LqyjTq9LXo6HvbgjsOdOB4mvlZPuHaD4vBODimuY
	/ajO7Sqh4qE/Wm6meK64qWyQakbuk+khKTTiIjkOPOdKF38LZHjC0IlwMSo9ABbN
	WUp2Sti8Ml5tC23D7W2gbV17cRJgxH6RflZMvPTMSWc+NKvj+MTVaGgtajfsVwZ6
	6xTvYvgyn9k8NdIIVT0shcmgqfjxLY2y68+1ZQBMplve0nMmdCkzBxlyYmGWiJY4
	I7iXi6FtiRc2sFtGpUqubLsxr13AQLHlhVr9pB0eusyna6YyIPINVNhGIgCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757313655; x=1757400055; bh=3g7tt5Hker9ob1YoprbCpCt/jyXhRhuOigp
	imnL5Gq8=; b=DgPu3i6YbxDajUEM6wvO/9EVNoZytF/9yVBvJFHulpm7IySvWgr
	aRZvv5w11gwVFPLQNfA8Ii+sIcGbWP5FMQmZOiHjsdz7v/uNM6f3w9svZP8aTACW
	64PEGgbZazEoGQCthf5KoDEDqMhHt4kMDmEHJanSz3ScoEHMCNba1Zq/+cVgOa7V
	4X8UD/oFFpDzz8Z+bRF7lUtttyxPJcoqRHhQ6vc5E8rRNDiRz8JT4XN1Dqsh9Vlh
	+yw1TpBPdZwFbo692W6R/5bvftTrRabrm04JPggwJXlsqnD/yM5V9cPZgEkIXnyC
	M6NePfQkxvsLiMyL9wpGIkkXO0rGzsEPQkA==
X-ME-Sender: <xms:d3q-aM9eKB-3-YRtI_Jn0WWi0LWzD7jVULQBTZWa79yHcXDRk5KDpg>
    <xme:d3q-aE3p7bSLd5cBQOCttLd8NwO03FUhO72QMYMhSUr993bjPkuUE7kxZrkKrLKaM
    H5T9MsLqZBWZXJkqw>
X-ME-Received: <xmr:d3q-aJeYGClOP9pZGGxvndRKkSqYWcGMc-t9v55QCuZOGQWRknCzTVckAugvPH1Icnwl9rfc_x-4irJzOh6guGGh8rcEz0iRI3wVOqZuDM3K2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephe
    ekfeefgeegvdegvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtohhllhhinhdrfhhunhhk
    udesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvg
    gtohhsmhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhr
    ghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheptghonh
    htrggttheshhgrtghkthhivhhishdrmhgv
X-ME-Proxy: <xmx:d3q-aDBCi-KEEjCZK320QEAYsTTmTwtebuRxmNi8E-y2WUpqUSkuSA>
    <xmx:d3q-aI9yaVLmqpWes0mgtufQ0AexybX7aB4ySNbJ_Oi2KFq42jgGkw>
    <xmx:d3q-aPpF0QUtzN7dXm56xNB8yqRiQcpzL_MvjG4yWi6zX0rAi1J0Vg>
    <xmx:d3q-aKHaGwEP_O5Thu-QBKUCbWvUJwvmcsKeCFS_-O3XTVkLrSoW_A>
    <xmx:d3q-aAixdYfx5kV96oieE2o4DkZUbHcZMy5cm0HIKoxazWhk9l4-d0Av>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:40:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac5f9301 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:40:52 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:40:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 7/7] ci: enable Rust for breaking-changes jobs
Message-ID: <aL56cTrpAInqPJbJ@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-7-6939cbf4a0b8@pks.im>
 <aLtAXYUQ1GRRL6xg@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLtAXYUQ1GRRL6xg@fruit.crustytoothpaste.net>

On Fri, Sep 05, 2025 at 07:56:13PM +0000, brian m. carlson wrote:
> On 2025-09-05 at 11:51:03, Patrick Steinhardt wrote:
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 4eaf3514d6..4c58c7238e 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -31,7 +31,7 @@ alpine-*)
> >  	;;
> >  fedora-*|almalinux-*)
> >  	dnf -yq update >/dev/null &&
> > -	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> > +	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel rustc >/dev/null
> 
> I know nothing about how Fedora packages Rust.  Do we need a cargo
> package here as well, is that automatically included, or is it
> unnecessary?

Fedora uses Meson, which doesn't (yet?) need Cargo for the build infra.
I'll probably adapt this eventually to use the Cargo wraps, at which
point in time we'll need it as well.

Patrick
