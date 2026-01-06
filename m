Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC88B326D4A
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767698194; cv=none; b=DtRG7n3eYeQ6ZRvZaEIacE1mRwGIuoTTwPwt9iNBEzcm20hYpZT5kpnWWO6IkebhwOZEJj4niURSy6TzbrZqDiEqWExpxylqGr8lwPSAqwdxEOjeydWBO6TQp/15I4l/NY8vij+MNo14tjERkHpZntmVWAiia+k/9kBEXowSs1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767698194; c=relaxed/simple;
	bh=bEaEsJoCuVdhUsSV2waGpZs9Tdr5m0k2pAprq2NJkEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSZOxLNe4m1VPxLOfG/MEl4/W1pZgzSPMIYBiKCur0tmA4EEIc4aIBoriT2LYgaMZ71Xs9RcZdDPDxE03BIGuMPQsdGl1gCXA/X5qa2P2KflehD1+M7ddaXnNUYJXoz3tb8QHKnusvvLml2dwr6ANwnAhNTEGAUS5mAtk2priJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cd3xsVAU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FEOo8Yrr; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cd3xsVAU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEOo8Yrr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2AAF81D0004F;
	Tue,  6 Jan 2026 06:16:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 06:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767698192; x=1767784592; bh=+EfIf+SEpw
	kpRySHT6/isCPz79bVXd6fBaNR+x5AUxs=; b=Cd3xsVAUx1mLqvTqGdvhXiBTzP
	NhNlDyzAsHKMKvOVCIyKFRtPqm1ZYd8b38DTHv/MgfhSqwaRQpTsN6KA+GUiVZb2
	mfU4rJINhJfxiEu2b7N/VZFhJvI1uG46O4vAfTiQZrbeEEtPtV0ycMdVywfMd5+h
	Ug3EoZV6pGlbqDHMYqenITYxE6YAGF2kZIvWZXmQdgwDBJViQzergM3X894meMXz
	91mxVD2yaOASXjPEoTQEwlibIEEmNwYgVSMcmkxUowU4I6aSMCRBfC32b3CQTqar
	4jELRse3xUoCtBw7072FPczWszs7oC6Euav+xD2lqVaoMAUEU9v8RAgU8sUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767698192; x=1767784592; bh=+EfIf+SEpwkpRySHT6/isCPz79bVXd6fBaN
	R+x5AUxs=; b=FEOo8Yrrw/1gK/TnXm69vIAU9cvgeDbZrUSPQK9Q+v9iTvo3Ouw
	AZsItS5dvJt78BFmAo0hokUGyUIdwiOte7V0zqIpguTj+dgLvrxPXSSMvtgsWZaI
	2yWxE3Y5kNeoSIacWql4R7WAMR7N7pnLhYo1W5RPiBZfwM8o9rwhpBK4bvtNLtsh
	1RzumhOi4ZgpBk/jdBybx32Hx8HL7wIwHnNPr+dVEGpryUaxNd4+ygB3ocCRDP6h
	kuULkgiixB/gmM6SMSZzP60NrpxBDgpBMI+4Kit0DR776qPbP6ft1TvSDv/iZWr5
	EhIolrTmonkaQ/L1TTZmIqGhz/UWRIF+c2Q==
X-ME-Sender: <xms:D-9caQvVayApgwNu9UlvBIEjgOyvOq8zqHDa2-uL6CJ5RxGT2wAnCQ>
    <xme:D-9caUdYpALWd7MKUO4bCijY8vpM-jXn8mbr7ftgHPTOCYGmLvW2wrW3Os1x8EPY1
    kbBJjR-XYivM02vdB9MDbGGs1ynbyUhM5XRe1eP0rdGzbChiwTx3A>
X-ME-Received: <xmr:D-9caQxupyh2O1vlS3oEbS-k_YDPnAzGKqd5sIGBMsWu2zgfUbnXDbyEKiPQaq-wx5al33osznNWcuWGifA24nwPklva4MOKkJvsQ-DK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:D-9caSGxWHC3Wpt0O_9DPJi7nNcm_AKRne5M_WY3dG2tyo7WdpADwg>
    <xmx:D-9cacxGlBqClxdCDcc5ryR6vdk167VGROdroLd2SHniQTYXkVFMOA>
    <xmx:D-9cabu6YwO7a6dOist_NWati2-oKPwGF0g49yxRug7vnLbMqI5P9A>
    <xmx:D-9caR2XieEM6Gphh6u92ig87HtJBcgECsvieURUFbzHQRWWxUYaAQ>
    <xmx:EO9caZ10uKdaiM2SiLnTM1XQs875GSNp-IOq94hXt6V2S2dBahSE43cb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 06:16:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9779da7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 11:16:30 +0000 (UTC)
Date: Tue, 6 Jan 2026 12:16:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/3] t/unit-tests: update clar to 39f11fe
Message-ID: <aVzvDGVEI2qVJv2F@pks.im>
References: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
 <20251206-b4-pks-clar-update-v2-1-9a14b10c1a36@pks.im>
 <CAOLa=ZQZnYVuK8mDi6Yb8_+hqw_TMugn6i7BJCj1gbNHOruNWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQZnYVuK8mDi6Yb8_+hqw_TMugn6i7BJCj1gbNHOruNWA@mail.gmail.com>

On Tue, Jan 06, 2026 at 02:59:21AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Update clar to commit 39f11fe (Merge pull request #131 from
> > pks-gitlab/pks-integer-double-evaluation, 2025-12-05). This commit
> > includes the following changes relevant to Git:
> >
> 
> Nit: There is a newer commit merged into the clar repository, but I
> don't think it is so important to include.

Yeah, I don't really think it's necessary. If this series needs a reroll
I'll include it, but otherwise I'll keep this series as-is.

> > @@ -149,6 +150,7 @@ const char *cl_fixture_basename(const char *fixture_name);
> >   * Forced failure/warning
> >   */
> >  #define cl_fail(desc) clar__fail(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Test failed.", desc, 1)
> > +#define cl_failf(desc,...) clar__failf(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, "Test failed.", desc, __VA_ARGS__)
> 
> Nit: While most of the function accept description with variable
> arguments, this is the only one which has the '...f()' format explicitly
> separated out. It would be nicer if we simply make this part of
> 'cl_fail()', no?

The problem is that we cannot do so easily. Varargs require at least one
argument to be present, so we cannot make this `cl_fail(desc, ...)`
without breaking the case where there are no variable arguments:

  In file included from ../t/unit-tests/clar/clar.c:1053:
  ../t/unit-tests/clar/clar/fs.h:460:3: error: expected expression
    460 |                 cl_fail("Cannot copy; cannot stat destination");
        |                 ^
  ../t/unit-tests/clar/clar.h:152:132: note: expanded from macro 'cl_fail'
    152 | #define cl_fail(desc,...) clar__failf(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, "Test failed.", desc, __VA_ARGS__)
        |                                                                                                                                    ^

The alternative would be to make this `cl_fail(...)` instead, but to the
best of my knowledge this isn't even a valid construct.

Patrick
