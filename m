Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07299253F21
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376813; cv=none; b=jJ7gqqZsE+wOXDWUtz6wNsGVa8XyxeM7Y0tWycGg5Pe6/VVVMHYd3iMN6GLu9G2sfgwLAVAs1osAXGs48K+CXCImfJF3MEQEy7SA4s8qBqIXMq/Prsgc5SQ6iRWu93IhnLeVDnZcU1bwrvzSBJQPOA5IIU3T4cwlJV64L08PVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376813; c=relaxed/simple;
	bh=tzR6v2Dbp3HN2V6okPcq91JBgQq0TI0ycVbXIoK9ih0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uP+l96HpRRuPDv9oaXKwJk0Cyq4A8abKIBBy+MGC1/pADrtNc6KQUGRSKXXFB+x7Az5+lXA36jBFTdTVtiuyx8FkSaF3nxqUyf9va9WzYOWvrXLdNfZFx9mI5TshcrDxrpdQRdCvTB66mVKGd6iCutcRXTQVRRiu1p4W6lgdyVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L7Ak4Yv5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LQgVctlf; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L7Ak4Yv5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LQgVctlf"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 02D5C114012B;
	Wed, 19 Mar 2025 05:33:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 19 Mar 2025 05:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742376810; x=1742463210; bh=KPB3pCmOhe
	eeGm/eefS/rxhpQa+74/j4Nx1ELXsX7V8=; b=L7Ak4Yv5gvj/QvB057RCxEJ1q9
	QVC4hKBJbtA2mvrFMyd/ToB0nHSDMr0UnaI3ZxuL1QzasP4/BHbWlDGRwg5g6Lvm
	fPncVePI/Gsz2HbqoCHupf0lavQa4EWFoBXRLHdPFbQiBhSM5y4XT6VKQNYJucGT
	ZNeLSnmYtB68Ix1beVAWMtaD5tsU/PhoB2PQumV0WAYr/jnYjjUCAz1Gb1GyGo7B
	0GLQ5wWS8MkWn7BHSYE6+e+pTyaXQOsxUxFhXlxHOtWcyciH0mp60FCO2X73qcKG
	xVswhT55JJz5PqWlp2uaMepUHnR1d/xP+kIWglSRHQ3zaPdrDHvUjl4VhEAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742376810; x=1742463210; bh=KPB3pCmOheeeGm/eefS/rxhpQa+74/j4Nx1
	ELXsX7V8=; b=LQgVctlfREgjfUiRdOhca9hMSTvaDHIJMEvWvNNfNGB7VOJAjn1
	mFcUtkAm/175FO9VpJPi2fJLWz6eHSzmbYP3mqf0eJlcHabpYiueJSFhgaEMPkK6
	WyVeCBBLplY0ry4yKGgbSjBFcyxbPuoV+U//t46SMtBixn0BlIjhyxjKpVXhyjWX
	AUxwwIeWjDfkK0kd/r/DYy+mArEX8NrEeN9Doml4csXYnCdJ0xRETmyD8WUNfcw7
	go1P8kUcWSc7fNXO1cJY4aEy/2kv0QGDmmFpB2UW1qCeIRK1Kb2naA3CxOBDlbUv
	ZQvDTxcHFS9GyVPbGRSmS+xxlUr1Qz+wEjQ==
X-ME-Sender: <xms:ao_aZzAGP2JuoQu28qtdsbDnsUqW2Hsm39FW-fe_ssRkEO9Pd3HFXw>
    <xme:ao_aZ5jemhBcHqjweeDXz_9Xc4j2qZyxBEVuc2d6k0T16y0sFvOomkkf5V3tQ37qs
    Y-otqsF3fo72N_uWw>
X-ME-Received: <xmr:ao_aZ-mubTGB6NCk47g13RehzJkjh7RRBzenliWJ8geO0UPu7Te-henHna3OMT_O11IPQwjOM9v-6TZbM41fEI1p0T9uobLn4L90SlCl8iCEjRO3Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:ao_aZ1w7iCj8KpRI6xe0VqkLuqDzdnUgXLIlqJyNgUNba7tLNcYA6g>
    <xmx:ao_aZ4SyaWTWjHhayrvDxbo-OtLrcKf1l4UlF0TAUlq8a09bpdrIVg>
    <xmx:ao_aZ4Y2-kGrNGdBIqzkvND0vtyVYk0Dk3FSZtVK1lDRpWRqAJhWOQ>
    <xmx:ao_aZ5Qsq844ZI5iBJ2kpZvMB1zgYZ7FzIXDviXAnVp4YDriOYekYw>
    <xmx:ao_aZ-emJOrQcv3PSgfK5sT3bXwe1WN7k9e2D4Zc8QBGaW011AbdankZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 05:33:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 65f1d288 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 09:33:28 +0000 (UTC)
Date: Wed, 19 Mar 2025 10:33:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] docs: add BreakingChanges to TECH_DOCS target
Message-ID: <Z9qPZ_7VVV6L95WE@pks.im>
References: <pull.1921.git.git.1742308900290.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1921.git.git.1742308900290.gitgitgadget@gmail.com>

On Tue, Mar 18, 2025 at 02:41:40PM +0000, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When BreakingChanges.txt was added in 57ec9254eb9 (docs: introduce
> document to announce breaking changes, 2024-06-14) there was no
> corresponding change to the Makefile to build it. Fix that by adding it
> to the TECH_DOCS target.

Makes sense, thanks for this improvement!

Patrick
