Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC618BC12
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296295; cv=none; b=ZBlw7LKTEFrvhXbgtUuGNyicsnMms5HYsCyEsU78tK0FptnIL/nE3b/lF8R9rbBALYbDfSw2/kDM5yQVqYblWzAb48DV3fGdEKGmGa9TvBWORv84hyW3Hj8xLTU/HcSQyWrEE6SaVqc6huoMEMCUIDWAr6fdYCkG63ZOemEOBRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296295; c=relaxed/simple;
	bh=MB/2XaY5xr7JwEptReN9i3zD5CjZkhfiWWEEHjg6oOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFdCWI9E1RPcs0QAWBJx5sMth5XrfMnwCJaCksNweCctttqNLHF3IkOxV+gVkKwhQxABdr06yALQWaNnitxtA6HzKr1Rbn5TTtaRqnIJKhzZOEeNMN0bYitI/pzxqJJgT/dKaCL97/fSZrnT/2aED9iTtsHcDDJvJ8VFVjXfMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TYkLf1GC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n2SC/ogh; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TYkLf1GC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n2SC/ogh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B35B711400DD;
	Mon,  7 Oct 2024 06:18:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 07 Oct 2024 06:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728296292;
	 x=1728382692; bh=S47ibidoMXFSG/qHGjyHdUacBSTLnvKZNsOyqW/RcIU=; b=
	TYkLf1GCbclRzUzRLFdstUJ8DwritFX9/7vvrxTtmHmNr9Mo3k9PWktDEKQnXjJz
	DENM3glwGXZqFzwEccSEVkLU7kRu09RcVuUuBi4noa2SEeAOzrxtFGDDN8n+Vs4M
	LBACJO5gGSs6rnQFu6mMc1kmFbnu2ETPpHl3ijFQAEi2lHEL5uH/WryOR5NliyRf
	YDDCezw5J8Ug5JY+seJEvXjBeNMF/v8YO3AGsc+r0wC1qPAp21AO35MSihHo8chs
	jB22xN80ijQTHvHvt7dxiMueNeJeD9jf9/WjnWpX9/37NJe9JykxA1ceAB8CzwX2
	NDjywL9r5qFnr1EnsMNQFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728296292; x=
	1728382692; bh=S47ibidoMXFSG/qHGjyHdUacBSTLnvKZNsOyqW/RcIU=; b=n
	2SC/oghRIQsM/WL8v9NSu+1mjyeuA2dSb8QVGstBoJn3RiUBhAGEa+QPs33WJnm5
	PCF4EgcrPzSRF2OwLXnhnouvlRaKUfR6NLXo/Qsyo7LYPPcIuFRsAHz5rmojVpkw
	97qfn7bz8D+YUOatZb5lxwZhNCAmnP+vnjmw3Vxba9KTH1rXRpJR3P9XoeT2UzbF
	txIrIK3DPLz6XBM+TbS9aUg+SU2DWy/dr7fY8//njO8YRvia7Y8Q1obHDFOX2Bp5
	4KxFaTcgQGChG+gAL6ne66MWdfvw4TE/MeMgztmm8bAJ32J1RskITRQBJbZZnS0e
	ZH/Ubc3efjRSkzlX0M6zg==
X-ME-Sender: <xms:ZLUDZxlb8ArQY29UtOBsIlILFaQRRavM4ZpOQIixzngP35Q9CFP_kQ>
    <xme:ZLUDZ81bMYtJa0OHX203VhHuEbatgyoLT0p6AVronZJlMWTMyyv8l7ERaBL0d4xG2
    M414H-DEnRXTdFn3Q>
X-ME-Received: <xmr:ZLUDZ3qc2vqwfyQlHiW7oAPDbLtmxYp2RU5pACGtWkRtP0LdFTA_24tl7EjAf0mJb0iauqsIFJtqZe3YB-89vF5y-43PMSYnLTy2kQZMZMWggDkUWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZLUDZxmoBYnwjckapKju52-6AQK6NVaRkW3-si3qIer_oq-yN5V-JA>
    <xmx:ZLUDZ_3Mvk0Edi_KrUZr2cCuWC0F6vtu85RQArPnSYnAHl-nSJ2ZsQ>
    <xmx:ZLUDZwsyi2aERxiL5qJ1sOwThdkkyXvu28XAZDTvxsFOFLrxREX6Yg>
    <xmx:ZLUDZzXC-9Y55sMHxPCw_17bSnjQ9Nv-Kp01yqHhLHPaOwIFCVvWjQ>
    <xmx:ZLUDZwyuRaK3psiHaakAhtMEmO3QX1_xRplW1RBjl1zeqpZuyDdfN1HN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 06:18:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 24da7a05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 10:17:13 +0000 (UTC)
Date: Mon, 7 Oct 2024 12:18:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 04/21] t/lib-gpg: fix setup of GNUPGHOME in MinGW
Message-ID: <ZwO1X1V1R9Eoy7_L@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <b5c116396da61f44057fbb5a8abcefe7ab1b67f4.1727881164.git.ps@pks.im>
 <CAPig+cRNPmbAY=HAkxnioXeq=gDSaYQzytE8Yj0DLanYMT7rxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRNPmbAY=HAkxnioXeq=gDSaYQzytE8Yj0DLanYMT7rxQ@mail.gmail.com>

On Wed, Oct 02, 2024 at 05:49:10PM -0400, Eric Sunshine wrote:
> On Wed, Oct 2, 2024 at 11:17 AM Patrick Steinhardt <ps@pks.im> wrote:
> > In "t/lib-gpg.sh" we set up the "GNUPGHOME" environment variable to
> > point to a test-specific diretcory. This is done by using "$PWD/gpghome"
> 
> s/diretcory/directory/

Thanks, fixed.

> > as value, where "$PWD" is the current test's trash directory.
> >
> > This is broken for MinGW though because "$PWD" will use Windows-style
> > paths that contain drive letters. What we really want in this context is
> > a Unix-style path, which we can get by using `$(pwd)` instead.
> 
> It's not clear from this description why Windows- vs. Unix-style paths
> only now become a problem but have not been a problem up to this
> point. Is it because PGP testing has always been disabled on Windows
> until now? Or some other reason?

I guess that nobody ever ran these tests on Windows with GnuPG
installed. It is installed in MinGW though because pacman pulls it in as
a dependency.

Anyway, I've amended the commit message accordingly.

Patrick

> > Adapt the code accordingly to fix tests using this library.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
