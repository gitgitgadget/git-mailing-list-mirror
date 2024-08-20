Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7018FDC5
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158779; cv=none; b=KNgpG12huqcxm6a0ZFNyse3sEEzAJixFF/OHK8piz9UUM7U9FlIQqvJaYFCp1N/KT7xrD65gSqbI7qMB8SO3iUw7HiyqTRkkgsRLdI3x57/WWeoGy+emUKJXbMyy/7m5yVKg1DNE1Oe1Yz7e0xF29gupf+e3UJV7FxAv54DFqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158779; c=relaxed/simple;
	bh=CTlPi2KIfP1RQ9Y38h/ttGSb2vddDa5SogW3R+0R/KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oq1eHhcRlKjJPSOcvHK+6ibcmXuJJcfC/yU19txaHSQ5um8uffWpv/0jHpCbST9zwmEGcGqwAQz97fKqk74uj2nwX75gV4UH7702uFTRJtWzB7H5MVxQZhjjhpONr15WGVLINzGjmYisqoHD/xqLBqasR9Q5Bf9WsKusb5r255E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=seYuYlwV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pB8lbooX; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="seYuYlwV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pB8lbooX"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D26FE138FE6A;
	Tue, 20 Aug 2024 08:59:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 20 Aug 2024 08:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724158776; x=1724245176; bh=I35LB29C6D
	8DY35fHi3oEnxaHnpT0iaySPGEanWRTgY=; b=seYuYlwVRGmPzpzPlh9Omp0MZ+
	S9jIePVTphsItua/RX/4E4CzX8kMdA5kfUOeo/NjgfjFi8Py0prSv6KNFTKKrfQ6
	6MNhdNl+ZgXiEoSItGwPr9K/N2B6Vs1euAHAQOfjNypStHbXMCCV+3uuY1nkYkDd
	yokPrJ2Tzh4uuqohbm8LsbUcUlL0XprrhaqravL2tUk64BW/u9QgsUBij8r7yrZi
	yzNroknE25Zx48XYf9r2/pa8kwQffxwDiZjqk2ez5xtAQHVECeVkSGBzwj4BJAvu
	QZHGLMP7PkbeHWhPJz/V5bHy8JoqbIihKi0hk8H6bqhE3pMBc+eK4+huAYZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724158776; x=1724245176; bh=I35LB29C6D8DY35fHi3oEnxaHnpT
	0iaySPGEanWRTgY=; b=pB8lbooXV0ICbPtr89Z71k+IEJk7ZJ4l28Dnv65/zAgg
	fBnLMwEI/O322o3R9TOot/+sgkNMJr2rQYBdk8ZMcIz0e+eusTSlQpyVfGeJZqfZ
	UGfM/TfBLwaSsaePKLmnjJm8u/X04OheHCbrfPvAUSX5RP55st3IPEChjlWDfqco
	O8jWfNqyH7MgzgeBfpGLGuYP+RCt0Yax1ozCDmd501+ydN7vt3Fc/kIxOHwQvFAd
	NKyc1p8wiV1i5suKg2UT/CbTzb4aecsLPVgTUaRjPkoophW4tpoy1nDlPiFUneLy
	9GbXW1Gp+3Ht0BvNgPiBCH7HkJreiT2FiSkShTkBgg==
X-ME-Sender: <xms:OJPEZu65yi-I_mh-lACS7YFJ4q-nrdu_8YCVqxxkLUWhEU8Mlh0BuA>
    <xme:OJPEZn4au48Hop1YhBZPOzoAUTGse611WAet-chCZvLeoRQXyBn3M8RHAMTq8t9FX
    4RrQ58c_wGLjRfKWg>
X-ME-Received: <xmr:OJPEZtfT__MdaE-zOIRi9bejGMt54urhFMX_bVZihA_-Fh-XD5wHycoqr4NWS2LHKnotcfrLBNxgqGLFnXuMKaQjtecUsnaQt4Fyx7yxsCmNDiEhqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehsphgvtghtrhgrlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthho
    pehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:OJPEZrLIV72F0aC-B1rKXbT43-jeM7N3cbBCxp4QjTHOINVoIzW_8w>
    <xmx:OJPEZiIkDBnl2dLYCi2qcsozhmaUG14zwz2xKQOuXyd2sNtChe0reQ>
    <xmx:OJPEZsyK4N4Ko7NZBOm1q8qkjWldxrft_NuvCsPhZJYemuJQziu9AA>
    <xmx:OJPEZmLy-_BPesJuGXXa23T5OuRac6uFxrCHbPabV326iC1MwDnO7g>
    <xmx:OJPEZh9gt8hO9uiJaMamfSSkKbh4ye-VRj-p7lMhu8JA2S-w8QYyxij_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 08:59:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f95d0d37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 12:59:03 +0000 (UTC)
Date: Tue, 20 Aug 2024 14:59:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v5 9/9] t/unit-tests: convert ctype tests to use clar
Message-ID: <ZsSTNV3EeTJQ3Ywn@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723791831.git.ps@pks.im>
 <ca09d19fd51cd4b3072b339f483b6b6d6e467b56.1723791831.git.ps@pks.im>
 <4aa6f557-1dfc-4aaa-b6db-e47013568ecc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa6f557-1dfc-4aaa-b6db-e47013568ecc@gmail.com>

On Fri, Aug 16, 2024 at 02:38:30PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 16/08/2024 08:05, Patrick Steinhardt wrote:
> >   #define TEST_CHAR_CLASS(class, string) do { \
> >   	size_t len = ARRAY_SIZE(string) - 1 + \
> >   		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
> >   		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) == sizeof(char)); \
> > -	int skip = test__run_begin(); \
> > -	if (!skip) { \
> > -		for (int i = 0; i < 256; i++) { \
> > -			if (!check_int(class(i), ==, !!memchr(string, i, len)))\
> > -				test_msg("      i: 0x%02x", i); \
> > -		} \
> > -		check(!class(EOF)); \
> > -	} \
> > -	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
> > +	for (int i = 0; i < 256; i++) \
> > +		cl_assert_equal_i(class(i), !!memchr(string, i, len)); \
> 
> If this fails how are we supposed to know which character it was checking?
> 
> Thanks

I'll introduce a new function `cl_failf()` that allows us to print
information like this.

Patrick
