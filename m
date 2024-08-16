Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B397711B
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 05:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785067; cv=none; b=OTpnbrlaj286+MWSlSlolVkSgBR+10CmjgwfXNEh8Sq9mowzTYaI0rnO3u53xCpVs6tfFSE3q0awv2zUD5qKPPPY95OtFxlafcQXVfK5gTlu/qvKy+Ppj/fo+AFe6Ln3oJrUgTvNKvcRZ4U9bbRY9AEOscafdm9jLWZo+1hetBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785067; c=relaxed/simple;
	bh=Xvo0MpXpVxMl0rMe19ZWacdEkHz+zTiIAl7apF3J5Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5EfN0JT+zKkU9M6KoR+eLAYpU49/eSLcCt6JgRoclyT9tIBOnwcjHph8J+YpnJpFW/SEva2PwyPdJ228c8GTBsLcoswhzXhMwduxdQI/pwYk33Nw1Qdp4NVRvVH/2r/AnYaq1t+Yw59/Mj1kGAASfNaZZEnzppGA0txsLu+KJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H6qsqhkl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBvyKE8u; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H6qsqhkl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBvyKE8u"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 83BD31151B62;
	Fri, 16 Aug 2024 01:11:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 01:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723785063; x=1723871463; bh=AgRaCBS5hF
	IqblJNWf0nDhnMu4ncNxxGI5fftMxLHHM=; b=H6qsqhkle4nZW1rUh5lfoW+n1+
	pvbQNE+Gbd+QKVFCMQR58Cd/dq9dbjAJFwM9jkFG3jENu8m+h5HN5FTn2xT2zTjU
	UGoVobV0Fbi/Fsw7nEXx76ftqnc9/5oF1pvNK62KlzIEEAjD1VjWIf1xBUuEID41
	ynAKIzUAk+U48rspObsCwCG5CUgrQRkgOBgP1OeyIAE8Lunz+arOtx77AvHyCw9K
	9jyXBJy0qkoUwCyWM0kurVob/uNTvyKEDulD4Ka2SB4WvznJ8Zz7Lu6LRdYVDrgP
	N9VgRADCJNb2DnYfoPoJ9S/IbdEr09h1dWNhVl7tsB0MROsNkfPpNQmFp1nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723785063; x=1723871463; bh=AgRaCBS5hFIqblJNWf0nDhnMu4nc
	NxxGI5fftMxLHHM=; b=tBvyKE8uqRNYf+mxufF5TYAWw9JD+p79vbJa9eDzj8ZN
	qQ6gbjCcTZ8saQAbdShwUMwPGgVYWFN23lFzzc7d0CNflxh8c+cCm2/MyAWrCfmJ
	lZBqXBlxLtLTvPB59ZQZdFQUM+eCzDTmoO4SZEdhJPOTuVU9VLE+lSKI5m07WUbg
	WwaOEAmM3S2GXaBeJB2MP3+RM5dM56cD/+V2nIZyi5NpJ4vpMEe9jL1bpyRaL+yw
	kqKrDFpafBaE41YnGHlitYa8Go9l96+g/cO87PT48GzxxHB+lWzf2f28VAgERAxI
	pyk6vFaut/fodm8T+ZqmaGnYyhSd31anc04o8T/yHQ==
X-ME-Sender: <xms:Z9--Zkn2FcqJA-3atET7FO66kzEFQSqV-sAFPg8sgZ3bsxFeFOXH8w>
    <xme:Z9--Zj2P4WeYP67iUJm5YCrFLDM8Srlr7UToFU5YYOHD07autBXqs_CZD4uFAa7u8
    zEORBXSOQz2sr4jCg>
X-ME-Received: <xmr:Z9--ZiojV8u767CEg8qKWIIwndLYnRbmxMSaN5-_WLZC1nc6M75X_FS7OxBxe1u6dB7wMCZfO5DHUihLW2uGFKNVXmoqEN0a92ce1tN5eXGGqnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvg
    hthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepshhp
    vggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgv
    rdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Z9--ZgkhTfmcVB4qnRIcgkATVTmJMdB6oHqxnj9O-UgnM_bx-8rxCg>
    <xmx:Z9--Zi3rFPAN3WTHFOOqcsVyR2wWex2NCCUS_3Ok8b_w8acKRVkm_A>
    <xmx:Z9--ZnsslVjdXeGsibEEx4oE7AxIEFqik2jzgupyeTW_SflUxz4d2w>
    <xmx:Z9--ZuUDfNua0xipnH5MxWywIp546wAJdP6rGQjOSOVJCw1JhaYrGQ>
    <xmx:Z9--ZjIqHTYK5fnz6ZOsC6Tn0aHwxHY1M54B8BFMyYV0BYwImMjl3Icj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 01:11:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca42c32f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 05:10:36 +0000 (UTC)
Date: Fri, 16 Aug 2024 07:10:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v4 0/7] Introduce clar testing framework
Message-ID: <Zr7fYYUWhkfT9_-8@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723712012.git.ps@pks.im>
 <xmqqy14xu58v.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy14xu58v.fsf@gitster.g>

On Thu, Aug 15, 2024 at 09:21:04AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this is the fourth version of my patch series that introduces the clar
> > testing framework for our unit tests.
> >
> > Changes compared to v3:
> >
> >   - Seeing that the overall feedback seems to be rather positive, I've
> >     now dropped the "RFC" prefix.
> >
> >   - Fix another whitespace-damaged line in the clar unit test. I've
> >     adapted the upstream pull request accordingly.
> >
> >   - Fix `make hdr-check`, which failed due to the missing dependency on
> >     "clar-decls.h".
> 
> Similarly, lack of clar.suite still makes "make sparse" fail, it
> seems.
> 
> $ make NO_REGEX=NoThanks -j32 sparse
>     ...
>     SP builtin/help.c
>     CC t/unit-tests/ctype.o
>     CC t/unit-tests/strvec.o
>     CC t/unit-tests/clar/clar.o
>     CC t/unit-tests/unit-test.o
> t/unit-tests/clar/clar.c:209:10: fatal error: clar.suite: No such file or directory
>   209 | #include "clar.suite"
>       |          ^~~~~~~~~~~~
> compilation terminated.
> make: *** [Makefile:2762: t/unit-tests/clar/clar.o] Error 1
> make: *** Waiting for unfinished jobs....
> 
> The NO_REGEX is there to force us to go check the compat/regex.h as well.

Huh, OK. Wonder why the CI didn't catch this. I'll have another look,
thanks.

Patrick
