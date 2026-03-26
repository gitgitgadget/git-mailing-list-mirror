Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2433F7A89
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527694; cv=none; b=LsRH4JEPHxdIoKAbwH1rVau9QG0uc0TmfHnh6uBUR8MZronVWD6GmsL8aLKT+E2caS1ZMTDwX363kCpXrIca0ooEbOxWlV/FEFhOwsHzMN4QHgYUHG+F4stecAWd9sOzvYzdqRiYc0ejUN5Bijck7rkN5P2wWaX2GlstIiWyTjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527694; c=relaxed/simple;
	bh=MGDUQFjiqE4j5+bH5p9ATw/dHzgDgffEsnCrTGTdJ8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoMxxCGTqoMIN0atfxSW80wU/4V9HumMhN5zkeOPCvgcmiTXgcyRYf/mrPLuxdXCfqpn/oRnzg3YyAMg4WHjkxRM8QtUkmHsQjRomit9Uwfsswr7lfYOqq2iMW/J/5HMHajtXt85dxHOGmTCo+tg1j+9QaqS8s3KICQ2FdL6/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S/a2muKK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PUVkSaKs; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S/a2muKK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PUVkSaKs"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 649301D00065;
	Thu, 26 Mar 2026 08:21:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Mar 2026 08:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527692; x=1774614092; bh=t05c7V86YN
	l74FX0nbhEF2xkNGjS8qATg4etPD9J8S0=; b=S/a2muKKHo1ODrsS/HFPl78TTb
	9dr+bhD5tW0W8Jqimm5Tt6PFI6p13fZCO3hKxdzAX4nrS+yTxoqQMSLj5RrJaxLs
	XZZrGUfQdVYlB8f9miIXZjpBQVDzfMRRwAj4WxqrkUA2RO077ajrEikZBBU+IWw2
	VsPGT0PLFnzDQxAn/pZeT3oHPcHkFz7ksP4f3tBB5ZbeDBYnq0PS/b4xTCJ++TlG
	sY2TCNQV/xCzCRZxvCPxxzfq8f7eRKpY89QgFvub0rIuM4S0/ruLlLh72CtHJ4nL
	OwRfbkACqha3SooUatzaHot3deg06jJzJb+McnL6vzdiirUZjLfc1Ua/HALw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527692; x=1774614092; bh=t05c7V86YNl74FX0nbhEF2xkNGjS8qATg4e
	tPD9J8S0=; b=PUVkSaKsYAwFXx4eUMXnqdOrbhjSSldpW/njw0ypHMd7zQQGz8T
	huEyNFLmH+23m8m5kddE5uqj+r4CBQyj/XFZUyl+K8Ben7F27SDqp3Me2clVXIOF
	KlZhVTGLHgjDk6Cd54qZ1JAygMLMJILocogcgZ1Er3ic2y2Xkr9ZO+3Ya1+KdT8v
	kO9fgCxyB7PXcFIAIAsbhxXE2aIjBiIzMnQx2Xv3x/+L688f2Va5LbG5O5bbt1xl
	Od1JzOQoYfojIRxjP3UZi1Q3b+wmHaX0qt8gvD77YZb+v703zOf/AYg2zXhyMAFQ
	zYYCLRbHlYCTQORYIZ6FBu+RqsdCSdJemsA==
X-ME-Sender: <xms:zCTFab-wIVsiyos2V-3atHBqY8dZIdBR3M6_XWeROdv4KSqIYvRgQQ>
    <xme:zCTFaZ_fBaMykRI980lPX4eqXyC5Ptefein-pG_pMlSXwUVmyeEptVNYftpaqWLmx
    ma6JESCMuE_El-XzYOxln-rx-MadKxUvZkEZa_vp05XyaSYVOTE-w>
X-ME-Received: <xmr:zCTFabTsQKTN-WJGnyA_R2AIjaHr8PD1ktWnYI_oR8gb3Tx5XcmOptznhQlQhN3KNiHZ9wpXLpM2x62kB130Iv00sXm6V-HJfVPEr398U4-eeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhi
    lhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:zCTFadfu7SBDw1ZfIWE-D9SdS7PYo8C8uZ_krEu9ZDM8XgXUNHT33g>
    <xmx:zCTFafCvzLHkSbr4FbymLwR2O2DlY1BIbx4d2sDTMOylhElJ2BfvSw>
    <xmx:zCTFafnoxT1MwYcE-ZbPl7StGKhvCq9WO_0HbaW5XbwKmm92fR7j2Q>
    <xmx:zCTFaadD-kM7tdX9qpz8VEz1zSfZYFDGfZJ6qkQgzxwPl8rjaEz0nw>
    <xmx:zCTFaYuSZA4I92Yt3sDoqMAOCIE_saokq-VT8oi0hF9c3hqlKy_6gvQO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:21:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e0bb139c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:21:30 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:21:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 12/16] t5710: use proper file:// URIs for absolute paths
Message-ID: <acUkx8KwusUzYqne@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-13-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-13-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:15AM +0100, Christian Couder wrote:
> diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
> index 357822c01a..c7a484228f 100755
> --- a/t/t5710-promisor-remote-capability.sh
> +++ b/t/t5710-promisor-remote-capability.sh
> @@ -76,6 +76,17 @@ copy_to_lop () {
>  	cp "$path" "$path2"
>  }
>  
> +# On Windows, 'pwd' returns a path like 'D:/foo/bar'. Prepend '/' to turn
> +# it into '/D:/foo/bar', which is what git expects in file:// URLs on Windows.
> +# On Unix, the path already starts with '/', so this is a no-op.
> +pwd_path=$(pwd)
> +case "$pwd_path" in
> +[a-zA-Z]:*) pwd_path="/$pwd_path" ;;
> +esac
> +PWD_URL="file://$pwd_path"
> +# Same as PWD_URL but with spaces percent-encoded, for use in URL patterns.
> +ENCODED_PWD_URL="file://$(echo "$pwd_path" | sed "s/ /%20/g")"

Can't we do this unconditionally on all platforms? "file:////foobar"
should be valid on Unix systems, too, shouldn't it?

Patrick
