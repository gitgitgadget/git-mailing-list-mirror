Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058F241679
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590843; cv=none; b=G0qXJazZppUO4+UupUQr7ixCTN1orrGRydEIVLBmqowVaYjFP1swdGrMT7ey9xBijyVeRudaa0l2K2QCi7HVifDRNPgTT55jtsn+Sov1qDBRA57cB2XPdSsnFFKntSU2O2RDaOakiIYwIZispyJBxx6J+yrbzyNU7xUUHYqvcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590843; c=relaxed/simple;
	bh=+eAGIsiBBKEJ097B8JICCizFygONH4z0Bgo5xUHs7ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0xHAd8nNxttvN1MIYQ3FFnh8YelYGf+4ZUb+U5FglaqwKRa5L3DTNCwazWBeQc3KfdnlwjcXjXeGONVaoUVSgrES/IUYeStGVUCkCYyDcL+N9nvJ2/MkBIDsMAt6MS+EGa5n//dgCMiYvAcDk48l+s7ejPwZbRAfw0fIuqnG/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E/uU+vCa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gHJsKto+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E/uU+vCa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gHJsKto+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EEA447A027D;
	Tue, 19 Aug 2025 04:07:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 19 Aug 2025 04:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755590840; x=1755677240; bh=PMwtdhA4aB
	/2drukbLOVkE7Jcc/uHEb9GFD6HcCf0B0=; b=E/uU+vCacNL3Wn6A8K9ZyQmcOw
	OTcMqbtIBxyUybweiVVSN6svgVwq8s4VBdwpvatUO+C5Dx5Qv2j0Jk46vAUbTGBN
	Lwi2tBaA0skaG+3RAiCdmQ+YQsO02b2RD1EdvTGm9WVI/lashkiY7SIO+X7dGorR
	nxAe01eii8frIBAy1XrEF1o5X6/xfdWRLMV26emd8/oj3ES+HF+UnKjeOXx/BmWO
	ypYaEtqMVxH7eEA0lbMqyIMoMMRDHIu8IkPREhjspwuAUa2C3mFmjc35h21jDV8B
	ZyOXTwrYfqEhQN/YmVPbrkqzCh2PKc9YFl82mEd1mECPzFZZSEipQh8Ww6ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755590840; x=1755677240; bh=PMwtdhA4aB/2drukbLOVkE7Jcc/uHEb9GFD
	6HcCf0B0=; b=gHJsKto+iHM09FDftNEnUZkcE8w2yWwL9ovUboVTSn0zfm+q4md
	uOAExf2rZqx7hbAWmI0EBQMHQdHuGlrIq1vNwa8zvvBovKabKjj1LmpsW850cXCg
	hdX5v3RQB8abhHEZI1HzUt8KgdVQRCWkICY1PvtUcSCgO+p2kWmDO4ROskBpdpT6
	63Wojq0yVXJVZf8rRzaRU1K9G4YgTXJkExjv4BiyKfrWiePM1pzM6KbvgI0nDFIE
	0nQOiLPphnfmLreLIA3Ni4Ic4EUM4sWeQdVX+/nP5OPDAhNQDNEnJjof4/tE246T
	FBpQpHKw1LJMFS0oSZ885kaEG1NqiYtX16Q==
X-ME-Sender: <xms:uDCkaO-Fjvh3WsyPFPqBSEyEtOVknykjLSvVqC37zGr6edVc9GHdHg>
    <xme:uDCkaB_J1c9HAFTf5OVy3aKr_hLONMFt8KEsgzYWKc9KmtX76gKwETL4lwU_M8YtU
    BhX0vaQ7nA5XW6t3Q>
X-ME-Received: <xmr:uDCkaNf_FsQWTaGECSMeA3LGOYEJ0iaY9xfB4A_rgOLaKSCv3dazXzhsV1XnKEBgfyaVCQcHK9CnsqrIqeRn1JNIuID4aPSZF2V4W6XUpKOG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrughivgiiqd
    dvtddtieesrhguuddtrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:uDCkaCGUO94NBOjai5ZzPCq5Lk-PyBdcmp7vRNM0lDYe0mtTGw5lxA>
    <xmx:uDCkaDc5cV0RP4-QXenaZMOjJ_H-4yGg6mjTAqLTXkVDlY-lCkK41Q>
    <xmx:uDCkaEHQI2EcM0y2lAA1d8JX6zRs6MTJyRikbmRr0l0-qJAs8m67Jg>
    <xmx:uDCkaEXSdEZIMI5qWmA5JBkXgg9skZ4VOGtOEJZDRP_gu-BQr9MTzQ>
    <xmx:uDCkaKOMCsSyih1LsoXry7lR1ytkPsJZLo5Zi4MhbyYALASm246o6VoP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 04:07:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6625ee44 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 19 Aug 2025 08:07:18 +0000 (UTC)
Date: Tue, 19 Aug 2025 10:07:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "R. Diez" <rdiez-2006@rd10.de>, git@vger.kernel.org
Subject: Re: Graphical tool to merge and reorder commits
Message-ID: <aKQws631-giQS5Qr@pks.im>
References: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de>
 <xmqqplcsiimq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplcsiimq.fsf@gitster.g>

On Mon, Aug 18, 2025 at 11:34:21AM -0700, Junio C Hamano wrote:
> "R. Diez" <rdiez-2006@rd10.de> writes:
> 
> > Is there some graphical tool to merge and reorder commits with the
> > mouse? Or failing that, a good terminal interface with menus and
> > the like which allows merging and reordering in an easy, visual
> > fashion.
> > ...
> > I have tried or investigated numerous Git tools: git-gui, gitk,
> > Gittyup, GitUI, GitButler, SourceGit, git-cola, Guitar, gitg, tig,
> > giggle, qgit, RabbitVCS, Magit, lazygit, ... They are all fine for
> > normal commits and the like. However, most fall short fairly
> > quickly. For example, the ability to highlight character or
> > word-based changes inside a text line is rare. And none of them
> > really appealed to me when merging, let alone rearrange commits
> > visually.
> 
> It would be a fun little project to write a GUI front-end that emits
> "rebase -i" todo file and drives the interaction, if there is none
> already (which your research seems to indicate).
> 
> Sounds like you found a good starter project for the next GSoC or
> Outreachy students, I guess ;-)

I might have something related to that: I've got a patch series cooking
that introduces a `git history` command. With this you can say:

  $ git history reorder $COMMIT_A --(before|after) $COMMIT_B
  $ git history drop $COMMIT
  $ git history split $COMMIT

It's only intended as a starting point, and there's additional commands
we can eventually think about. I'll probably send an initial version of
this series later today.

Patrick
