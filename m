Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806D1DC19D
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983360; cv=none; b=mgtyGjFPJUhTW76WUjFUu3JSNpXFS1VT4dRQ4+chPFLGvty7ZaM4wDqsfNZTPO9BjM2GWETk6HkgGfGV6muw6IPL+HsDKFRay22l6zjv7mC93w3l/fj4+l16ntZNw+XnCGpMt0Osg0+1iNcKQ9bKCQl+/ZXFg70pSAzg+KHN1xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983360; c=relaxed/simple;
	bh=DxbkBpcmMNlMWe/iSzEeUkWXe3GtMgqzaZpaF5ev9y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avnqlFEjTiP4XgJeSa3V/ivyoyIGCdr4Ti/H0krov/NERr0ALxRnEbst7KeB4m65PKHwFUoNNUW0nbAeASVIVx78rtUXbU6/kGUWR8/VepDe2k0EVtpNCAEQ7R0ZyIVUp+/+Pdzmhg5H5JAXLatLo86R9ZlO8DUkzvYu5jdlvS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Alq873gG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m86tq1Gu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Alq873gG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m86tq1Gu"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC40725400BC;
	Tue, 15 Oct 2024 05:09:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 15 Oct 2024 05:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728983356; x=1729069756; bh=XR9EgEiXlZ
	EG2E+me3ybYV9muJc0eqHgBhSECQ+3XTQ=; b=Alq873gGm3rko3XtpxoxuHJ84p
	0o+kIUxCTAIP4ZY+9gcwbEQ9mdhmf5y81inJk8LKpG9z7bTQt/pmMWe+St5BTOyp
	NJirFI2q3oT4GjgbyRXQN0M/rRtdoG5pO2SJPOEZ1QndPwl5SQACMdGPsr+J14A3
	Oe+73vobJuts8nj+cWL3N4Xcgp1b5FDiSPQklL/Bd3OG4beBEkiswzSoeROXVOh/
	NAYbXmC7bgD5faYSF88uUSs89qD5DiQ1PtCh12nDdbik6gbDMTWOoiVREtB81rEB
	DUjp892ynyWK3B/peMnfJtqgZ9bua/MuFA4BOq57q2q123/+hiupPs0vFR7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728983356; x=1729069756; bh=XR9EgEiXlZEG2E+me3ybYV9muJc0
	eqHgBhSECQ+3XTQ=; b=m86tq1Guv3l9NqzmRqctc9L08hi0eLa0+3LkKzNzqQJJ
	vWDlmPFW1vBlWZ5KaFP6MhpMtWCw5cxrUMkjpqG+5qcao77pfzAyqolB5E5i2GIg
	gYqpsZsv+RXfcX2rAvJGyX6flrg1ZjuaZbKwQc/ByXIqahaKl1fk3gT3A9Fq5Uzy
	5M39vXVSpg/BRFO1+FvzHK4yZWK2jOPe5n8rafG9AbCo/tfmGWh3p+CTY1YF8hpX
	8YUX9HwHAnQpavkHJDKbioznfUGXL7cRxH0YmPJncsh4fmPOTe3DwkW2oHNLiCbz
	HYWSgurHuaMbrm+fyUAA2cXQviO4EXtzKxqbcVF2Sw==
X-ME-Sender: <xms:PDEOZ7NsIN2ybTZ_pGgPYChC7_irJT0ZCVpyeUldm5WoDVvUIS8pgg>
    <xme:PDEOZ182cf8kX_2dAPeSSDdxvM5W_WenquaOl6dMAVHDdOmPzD_CHk4YnmBZjtn5-
    WLOWFe290uxZOjGnw>
X-ME-Received: <xmr:PDEOZ6TYAfNKBkkwx80k85H1EEgwC3fv71iyaxmxPVAKQYBU6OQniefB8EoswyIcupVk1q-Hrs7MZM4ozz5SJH9F1lYBLxwrewe5YkB9w5wfsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggurhgvvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggv
X-ME-Proxy: <xmx:PDEOZ_sBgFSaGXHPts8mfG4hKvx1cFflKvV_MHQeojZex5JwnLmUmw>
    <xmx:PDEOZzce8LW7BJHEYdcozl6HGWiXYbBPy2nuM1hO0H4uquatc5gfZw>
    <xmx:PDEOZ73j_D_vjaDMZBkBHOOI0DWoP9H-tnOmzd43pPZPTYqP2LJQwA>
    <xmx:PDEOZ_9WIr61TvRL0CoRM138G11gCbtkWsESsB0VudBXy15MXn88sA>
    <xmx:PDEOZ64mQh-hWJfd123B6kyBOWmI6rITncD7fvvAToe0JByc-MhyBHSN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 05:09:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 66dadd96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 09:08:00 +0000 (UTC)
Date: Tue, 15 Oct 2024 11:09:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] cmake: fix compilation of clar-based unit tests
Message-ID: <Zw4xNwnrLicx2nDa@pks.im>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728914219.git.ps@pks.im>
 <b9afeffda292a068e81d05b91f759a5c53a24b15.1728914219.git.ps@pks.im>
 <Zw2RNsptlkHCyTgi@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw2RNsptlkHCyTgi@nand.local>

On Mon, Oct 14, 2024 at 05:46:30PM -0400, Taylor Blau wrote:
> On Mon, Oct 14, 2024 at 04:06:44PM +0200, Patrick Steinhardt wrote:
> > The compilation of clar-based unit tests is broken because we do not
> > add the binary directory into which we generate the "clar-decls.h" and
> > "clar.suite" files as include directories. Instead, we accidentally set
> > up the source directory as include directory.
> 
> I am confused. What is the difference between CMAKE_SOURCE_DIR and
> CMAKE_BINARY_DIR here, and why does the difference between the two
> matter?

This is for out-of-tree builds. The outputs generated by CMake are
written into the binary directory, which is not the source directory
where the Git source files are stored.

> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> > index 62af7b33d2f..093852ad9d6 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -1042,7 +1042,7 @@ file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite" "${clar_decls}" "${clar
> >  list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
> >  list(TRANSFORM clar_test_SUITES APPEND ".c")
> >  add_library(unit-tests-lib ${clar_test_SUITES} "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c")
> > -target_include_directories(unit-tests-lib PRIVATE "${CMAKE_SOURCE_DIR}/t/unit-tests")
> > +target_include_directories(unit-tests-lib PUBLIC "${CMAKE_BINARY_DIR}/t/unit-tests")
> 
> This also changes the 'scope' parameter of 'target_include_directories'
> from PRIVATE to PUBLIC, but the commit message doesn't mention such a
> change.

It does mention it, it's the "propagate the include directories" part.

> Is it intentional? If so, can the commit message be updated to explain
> why this is done? If not, is this a stray change that snuck in?
> 
> (If all of this is obvious to you, I apologize for the confusion on my
> end. I'm not at all familiar with our CMake bits, so the extra
> explanation would help me quite a bit in making sense of this.)

That's fair. I'll clarify the message a bit to provide more context.

Patrick
