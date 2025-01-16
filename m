Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA191DED42
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035853; cv=none; b=p/oKr6YUTIRCBPdcJHEvdQj4JJ1W1C2T6f0bwywwP85OObzwCsTo3ZO+99iobjOQcNvn7jVi360ndnXF6zqj//8DOsQ6t+TKQXXyOls7EJisPYUdb6Z2vqZbHuz5ZDRmAXBi4XpiruE1lfUQxpq6wVNJHgcOPcWq6qXOowh+iTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035853; c=relaxed/simple;
	bh=rLC9QvsWF9W7VuDAyTnkoPXnlU3XPH9Fl9tUQN/yFRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZtzUJVmY6XnZ34pVAD50r/OkpesY40EFl5WYMEnVYwOxN4wRkrS7szlb/NbfdB4tmx7JS1gitPyNmE7yOZ90iyZMG/+/fNYMiorSrYJ4IEUlqwRFEYYTJjZPIgrm+Pulg6ZsYwxOWdjbYKcuPVRTn3Noo3JP36FMvP7QFgmG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B+t8DVHk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLc8j+AO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B+t8DVHk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLc8j+AO"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0373925401BA;
	Thu, 16 Jan 2025 08:57:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 08:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737035849; x=1737122249; bh=5xsblAho8h
	PO0MFtBKyy7derCig30x9vVm0+Qmk3W4g=; b=B+t8DVHk3jkoYJZ2yqfoe1EIJi
	gLR9acDhjahR0MpP+4VN8Yz/s8yf0IdCkyN0E1SiANZ06OMbDiviR2hTmLtcR4Ba
	Da5Qmg9E7ZNSVQY5p9JHMfOlCrpBl3Xpj1n5a0594KxnQaVV05vtvot9UDnxoz6b
	h44WPFxVqT1JtH5btPoBRpcRb6fdxO/rfvLMEgEg3ZpllcjsLl8+9W3jbFYwicq8
	X5tf0Msds1uccVmeXuq1YVBjbYbekivIHejSyvJretUtpFFrTbZhrs4SlESqClyT
	hFsrDvRCEvoM9K/YbeM5GVJ6UABjJSSS2lJ8WovWeC+VDb99tzGC9sF+SUkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737035849; x=1737122249; bh=5xsblAho8hPO0MFtBKyy7derCig30x9vVm0
	+Qmk3W4g=; b=nLc8j+AOOhA5xfROg53iNYGBivdaMxkF8K7h9s3zgEbRtHh7Hc3
	rNL9Ba27lHtzcrVpBSs7Xh76b+8ACjGr8nQ6AiBtT9wvo1TQ2V7iBshQzMUqR1g5
	2BcbyKL+5SZR8OeRzGKs4j4EXG4807OUEwkNM2Z2/mgDaaaal5y0APa+Rj18jae/
	lsmSuL3r7y7cBl58hUqrLMVYbf1Kyf4ugEJzOPd/1SJSnFT3uS1d6Txeq8M1ySQW
	DI9TLDRzKDbLvEld4Z49CaCGqf2XX3zbMPC/1G6hcCITTHvLELrnsv5XQFD4mHwP
	6stcBxAc5hj01OW2q7fCBsL3pT8dmPJ4s6w==
X-ME-Sender: <xms:SRCJZy2TouD7wz59dnelKfWH8XuiaYzLOqwk5eZURMdre21A2SNH4Q>
    <xme:SRCJZ1E05bCXxBTPvo0dSLgbS0mm3KFOdtK6ZeGvADNDvNJStOpNY-CnD3bi_c8tU
    ChSQ5oNHjgakyoxWg>
X-ME-Received: <xmr:SRCJZ65kpK7n88q2Ncrf-E6rcvhefP_ANMiEsAa6mkLFPzr2LOtYWe3AdiGmAvesJalDYGcLG3olKOHVrfk376moqQFHDjUabGl7dfI62AGqWETVYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlh
    humhdrmhhithdrvgguuhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:SRCJZz2evgdT9xVM9oeQRhP_Eg0MloFca3pT5uQ-akrzm_HOEhYnZg>
    <xmx:SRCJZ1Hy05BetHHpzgXeDJvt8CTgxPP-TrHcp8A5BDk-T1RpkLQa-g>
    <xmx:SRCJZ8-OhTeWV_uRZUcJkJUERcCVpJfrhihjrFu_FWnmlY3STmEOJQ>
    <xmx:SRCJZ6lZnT0bCNM0UQaQvP3WQAR6V20tE9WLBlhSheRhS4rEXxZU2w>
    <xmx:SRCJZ-NK_Uot6Qi9PvNG2c6GN_FesVj6AyiXgQfHSju8mj4D3sSw_NLz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:57:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1484365d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:57:26 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:57:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/10] files-backend: add object check for regular ref
Message-ID: <Z4kQP5PBlgjXYNhs@pks.im>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN1T3lJoj82ckl@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qN1T3lJoj82ckl@ArchLinux>

On Sun, Jan 05, 2025 at 09:49:09PM +0800, shejialuo wrote:
> Although we use "parse_loose_ref_content" to check whether the object id
> is correct, we never parse it into the "struct object" structure thus we
> ignore checking whether there is a real object existing in the repo and
> whether the object type is correct.
> 
> Use "parse_object" to parse the oid for the regular ref content. If the
> object does not exist, report the error to the user by reusing the fsck
> message "BAD_REF_CONTENT".
> 
> Then, we need to check the type of the object. Just like "git-fsck(1)",
> we only report "not a commit" error when the ref is a branch. Last,
> update the test to exercise the code.

I wonder whether it wouldn't make more sense to put this into a generic
part of `git refs verify`. This isn't a check for whether the format of
the files backend is correct, but rather a check whether the refdb is
sane. As such, it also applies do the reftable backend.

So should we maybe extend `git refs verify` so that it also knows to
perform generic checks that apply independent of the backend in use?

Patrick
