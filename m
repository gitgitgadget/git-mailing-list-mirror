Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A402E36F4
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289201; cv=none; b=IOJcd43ICigolwq1lKIxWZM7CwxmhfajAFoLwsgypLxUhm/hd3YNYh9KJWGsgkxddoMaqBINCuGinp3I/8gkcuW60djodU7KEbEwO+hGtvUGEknWWcCYottf6l77OAoewrCYk91BkCq/0P1NXY6kMW54NS4pnSzcOmZjdJSUR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289201; c=relaxed/simple;
	bh=xR/As7H9ZzuQQCtktLcBDE5qP9w4pmm5XtWFN5W3k9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWwdBZVbahzLNJjy1TjQuFg8VvBqv8FWORc/68tUDNm3rvF2mRsK1JORsMdRc3M44AHa+GirmHZDHLYrCWIuuOVUuV9Qha99y9dGYa9DEiaq6sQ/wDxdjm7DjY57+zUjmd7Z/X9SnEkESn64Ix9aOuLF7GAeLENeJ3nhUACP86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q/taRNw2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LEtqhzkd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q/taRNw2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LEtqhzkd"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 131631D000FD;
	Mon,  4 Aug 2025 02:33:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 04 Aug 2025 02:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754289198; x=1754375598; bh=qBF/5DCZ09
	Mf7nNVPGSv85fQm6Tm3iymEVQdpNvhQ44=; b=Q/taRNw25W9DrSmRSPoCWhyVfJ
	vX7R9F9Z8ziXUupJeErpPRaMD2e0k+TEIrDZ1sEOQN9oLZzDTpGQ8oSYlTar69Hi
	BHL/elkQK4/z2nqe6GfJWXz34VhFkzere5QrNgRXNOhY71mDU/uz0Bh7TJTVU1jC
	qgZwlo5e2Tuj+SZr8W4QffoMGsIWKFPdEYD4Cszb6Up3eOKvAJZyG2PLRP8p0ERZ
	qbMfdodu+IW7siYM/7+9Bl7pY7uuffJsmRiIj792WX3fXNecKVnNl9fltKOW+aCY
	We5N1oXDTt4yQvhuoUhFkJUoXoS8FXX/9t/yn96oMZLpHPppdhGxFouGhH6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754289198; x=1754375598; bh=qBF/5DCZ09Mf7nNVPGSv85fQm6Tm3iymEVQ
	dpNvhQ44=; b=LEtqhzkdxSbG73fZIiSNDUb2h2MDTIK+UpzfS9AFpobono7ljkl
	0t2DkU4PRw5T+0FjjD9PW4TMafqGmjNLadl2yNEPWyT7b4mIetYXWohqGynLxlzk
	HthpaQ+w8JYj0JS2k+RYb+G0fC6mcNYamo0QmJWE/nhCn0xcfNhVXUYs7EK9ZzWz
	ZhptPk5RxhbZ0z/511rLfpEqo0T9EdsquW5EuM7b2zoi0w6kGu/97VXDWKBDEzLd
	8GQTlOFMYdVJSNN2BVx2qjT0Vr4QV0IaPkdvbedQvTEBWqmv/wB/kZN37xbVePwJ
	d2WIfHM6QufmXFAVH1Chnw5mHJ/HHL1ZAOw==
X-ME-Sender: <xms:LlSQaIguJVeIKfax5vQ71lg_29TIu9EOBkhIPYe_MHv4OaGjDoJmSA>
    <xme:LlSQaN7UIN8Ye9bRECbxZSWGu8dbEe6V0qY0T8WZMFTZZ6OPtX8YVcU6WTzH-uwYw
    yppOZIfJ2Y70oZuZA>
X-ME-Received: <xmr:LlSQaP3Lbk7tn4c9Gb_Qbg0ZRQAeCKnljajIU9_kPLjKU4oFzOTT75gOgXf8_S2-hnU0k-VtOHcjE3JWsc8a_7Eu34TPab3sYRkLcyWt6m8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghvrghr
    rggssehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LlSQaItYLuUGWBkGnRbnCZZNl__tTPSFtcuaUmX-hmz6FXaAiBuIbQ>
    <xmx:LlSQaF5LDnRheM_jHcVc8-mCO98T1n3qYX_Ks8TZ5OVx5DmD07fghg>
    <xmx:LlSQaEeHewmme0BBdStDM9i8WGx85Ar4FcGKtx9KddZkOlLOqEJPOA>
    <xmx:LlSQaCxKYsTBDIVq1KreF7W8HvXF3GOBSLjBj8ce9MRHDvWrgMqDpQ>
    <xmx:LlSQaMxvqv5_2P2x6KiBwYJ-SUhT9U6hp0LOPzZfn0BOhP486piiVsur>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 02:33:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8effc779 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 06:33:16 +0000 (UTC)
Date: Mon, 4 Aug 2025 08:33:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
Message-ID: <aJBUKa3KuxXlXMzl@pks.im>
References: <20250716133206.1787549-1-toon@iotcl.com>
 <20250730175510.987383-2-toon@iotcl.com>
 <aIsQWcHf82ipHoWf@pks.im>
 <87ms8jui3p.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ms8jui3p.fsf@iotcl.com>

On Fri, Aug 01, 2025 at 06:22:50PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Wed, Jul 30, 2025 at 07:55:07PM +0200, Toon Claes wrote:
> >> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> >> new file mode 100644
> >> index 0000000000..e4c73464c7
> >> --- /dev/null
> >> +++ b/builtin/last-modified.c
> >> +static int last_modified_run(struct last_modified *lm)
> >> +{
> >> +	struct last_modified_callback_data data = { .lm = lm };
> >> +
> >> +	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
> >> +	lm->rev.diffopt.format_callback = last_modified_diff;
> >> +	lm->rev.diffopt.format_callback_data = &data;
> >> +
> >> +	prepare_revision_walk(&lm->rev);
> >> +
> >> +	while (hashmap_get_size(&lm->paths)) {
> >> +		data.commit = get_revision(&lm->rev);
> >> +		if (!data.commit)
> >> +			break;
> >
> > So in this case we have reached the end of our commit range. I assume we
> > simply print the oldest commit of that range in this case?
> 
> Looking at this more in detail, I feel we should be calling BUG here.
> When we've hit the boundary commit, we should be printing the remaining
> paths with that commit, but with a caret `^` prepended. If we hit this
> condition it means we went beyond the boundary, but still have paths
> remaining. That's a bug.
> 
> But... As a matter of fact. I had a test failing (on the commit using
> bloom filters). It didn't print remaining paths with the boundary commit
> with a caret. This happens only when having GIT_TEST_COMMIT_GRAPH and
> GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS set. And it's perfectly explainable
> now:
> 
> With those set, we hit this exit condition. This happens because
> maybe_changed_path() was called in previous loop, returning false. Then
> we hit this exit, and un-printed paths remain. Big thanks for this hint.

Nice :)

Patrick
