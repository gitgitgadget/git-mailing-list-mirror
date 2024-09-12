Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFFA1BDA9A
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139837; cv=none; b=S8D0STG4rVKINrVUqzDfs+d0X6n0dzSrbWAnYEqGMKv3UE9/oKfb5sOsPAM0lcdLD9aVAJJVGIq63zFdsxnBxZozRanYQpINMftY5GbqeD6HxEt05s7ms9dz4wJG1SrX4wUoSGXxKVVPaVxqrzmbiOE+hCc9T4HTGuAsIRvZDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139837; c=relaxed/simple;
	bh=prQybh5IDi5znB+F5J7IWiO69YLeDnTHSf2TZ5qxl4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzl05d4m5/c7UWwsQcQjSz/8Lgb5Kag6BqV+/wzN48vGtAkLZJOPaVVUYDrZg/9v5SZGIhcQUN5MeMxW2Nc0lZzmV5dkGacaaDrFuSifXdxEG5M7HsYFf4jpbkicQq+krSMMsHcRLT4SegrL8wmuVopvomfdWsnMGxMEFqvsOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q7DvnxpK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fk3GLpXA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q7DvnxpK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fk3GLpXA"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FA0D138061C;
	Thu, 12 Sep 2024 07:17:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 12 Sep 2024 07:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726139834; x=1726226234; bh=5qCOIWIBdX
	TXfxxC3RuVWXu044xS9b+R8kiRa58+UGI=; b=q7DvnxpKaf53tk9WnZ9siyDgSx
	+MPKgWW++XZhuknGX7Mmu2UVIXx8yP2lYoYjeJYw7WlpWXkeisAytXV0qSCjNIWS
	TOBiH728DU8c+xM2E4OTSVkdaOqGLQyk4RyjOLbQzBKwZa4xoyW1KaUasPb+7QaS
	fyjgz5wvmvhPJfoQssllB2IuZtv/AXH2Ad5LPdzt/NY+NdpuRGQVczxtIxJ2tAfu
	Z1DPudkFutqsjtpcHwMeQu0HFRdTpIOXi2jQG00bNCuwzPbkPRg8sFnFal4XVy21
	fEY+5HxRiIB7in9aKIqyZIQkNymqXKmn2JuF8ZjlqbcCemTNmvw8NDVIrUzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726139834; x=1726226234; bh=5qCOIWIBdXTXfxxC3RuVWXu044xS
	9b+R8kiRa58+UGI=; b=Fk3GLpXARzcgo7xsQUQHo8P8/Qwa0xJlY5qgJ26d/qCQ
	xBhuBDbKR/re41R+UI+O0z3fSaAXs9wttEjbhL20Im63UKeEehfSDp3o/pERQeJA
	fYD4NhgbeegbcbvNMscubpgFxk6KyPmtUIj8DESWyspTmEHPiJvZyXnjUCasWUX4
	X+m+RUpAXhIMe9ex65EPufbtQeVecJuU05CctNoddQCBj+kDgg8FlW5VOcwE5Fr4
	TiC2Em2cAXVcc0xOtaPa/iuiTboobe8q7Ub+rW7m8gCNgRityhRXKmjaq7rFDDI1
	xmShpa2VSsAr38KqV5RqZ0EGOR4rv3opov6dB8Tb7w==
X-ME-Sender: <xms:us3iZmFEEMPClaAbWvXaefFN8xvub6MVQUPkdxpes7sm7a7iNfxsUg>
    <xme:us3iZnVfvhqt3r88_FMMU0jDvP8Y_MiTYuP8xTlEIrkgzhKyWcL37iCCnAixqDBqH
    6yMk-j8AYjCb_BasQ>
X-ME-Received: <xmr:us3iZgIbDtpjOE_HqMpbG-sC2SlFU27RYyDOJDapy5HLq3j_X0vOpCR9mAS5B1XcFxdLCeGj0UiVePQ1n5An2-DDjq4KhDOy5klQGVv7s8UW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghl
    vhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:us3iZgG4AGuGRjSFB3a64ini6Sjn30bRVPN3Z4g5fOCakhJCkcYxPQ>
    <xmx:us3iZsUCz-_IexYWsId30D4ZRrJPfTi4ZXrRJK_Q-4D6L8hGvXeVZw>
    <xmx:us3iZjPII_yPaOR1l4HptnV-WWmT03rMO0xpmOGqDnfWXfIEEePriQ>
    <xmx:us3iZj2hu7xIczPTmdtcXUYU1D0HmqkIin1yOaec9xR4r79ldtG-XQ>
    <xmx:us3iZmd5c4J5gMf4dTQ1vJvIsISfUy7nqvqY_z3wRWVRSS1sYNUR_2s7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:17:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a94968c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:17:04 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:17:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/21] environment: move `odb_mkstemp()` into object
 layer
Message-ID: <ZuLNuaSyamvleWu2@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <ac2cc4e03719ecf6d6a2eb4aacb8a162429addb0.1725008898.git.ps@pks.im>
 <CAOLa=ZQLd4M_CmjnJBg2ht-U9sa21bq5=WgXn7RWe2cWpZx5zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQLd4M_CmjnJBg2ht-U9sa21bq5=WgXn7RWe2cWpZx5zQ@mail.gmail.com>

On Wed, Sep 11, 2024 at 02:26:42PM -0700, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `odb_mkstemp()` function is quite clearly tied to the object store,
> > but regardless of that it is located in "environment.c". Move it over,
> > which also helps to get rid of dependencies on `the_repository` in the
> > environment subsystem.
> >
> 
> The commit talks only about `odb_mkstemp()` but the code also moves
> `odb_pack_keep`. We should add that here.

True, will fix.

Patrick
