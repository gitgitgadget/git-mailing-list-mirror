Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89BD14286
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079245; cv=none; b=kYn4gF79ruhciUMYqmGVB8GTgnpMBQszlt8YteOwtg7Nifc094H2+sSf0+1yA36GVA2guCdkuV8bwN6nm9xxzlblmIwWUYV/aPKwX60Z77LnqQdE0j8+6+KoJsvgCHzDRF4WmCVwVX3n7z4c13c0TW1XJjWRsGH3nXxaFV4YRT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079245; c=relaxed/simple;
	bh=mz+/Fl8lfy/MdDDn98KXmCbCc0dBEEAkXyDk2CbUo9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0pg/Dr6mrpGI5DLH1ObeUBZKqcS4xunX3PXZSTIGjsIcfwUlAV0wU9lLcaJGKzYSEbVtW2sWLufdr1g19IoHKhk9oBLJ+H6b0bnSRKk4htOyJWHjR/CNit66rxPq3dAE+dmavX6B2z9TkJdGV7BbAKZBGIcFLRuQC+du06nXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eQGxb4dr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nHIyfJAe; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eQGxb4dr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nHIyfJAe"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69E41140019C;
	Fri, 10 Oct 2025 02:54:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 10 Oct 2025 02:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760079242; x=1760165642; bh=PC5n3WTYim
	Iz7aLUNiIOk9rNE9phIAhgpFjP/6L5o1s=; b=eQGxb4drLD0Fuf5AMVO4YaxJmf
	TqPQT7htA+hYc4cJb9iLwigYEbGHyxOQVZ8id1ApGYRBBw0v6zUPNiZaYR1dS9Ii
	qUODMHG/KwBZcNmRw56CwZdp/YIFHz8/lFbEOdGGFHrXdY/jeg332j0ldvV/4B3A
	2nZ6J9bOjRj7kacCPM8TRwg4mZHHp8+qOAQE+MUnYRDWh1atyi7GdLAUPs3Uj36u
	tRINYmKVdkWIq5n0mwqBh71vnJCAZO3bLFj6zFh4bRkAqm12pDJakYof9Tzuj0k1
	H+r13LC2+eydnPgoZJKghQNIGgg39/s83awD84HziDGK2Fy+wfZl39lkAJrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760079242; x=1760165642; bh=PC5n3WTYimIz7aLUNiIOk9rNE9phIAhgpFj
	P/6L5o1s=; b=nHIyfJAeyv18i2dwNpOSPhoHvGFOqSgiR28O/mVc9laX6ErnSu2
	+vwA/u920qCF2jeDrotBKZKyoogeTxFhFRrCLqLzw+uIljEozB2XkXyMJXLXLTzU
	Koaho75siqQW9JB5GI83s3UQUofQdLH5Dzzrx6QdcLt6DumYa4v5cvtohUxCHU1E
	1EKHgBP4369c+3sWgxgSzuCZi4jrawxW6PZ0jEUOdVXlGoFoPVxJLyp8tunN4VtO
	rWXIhrez3nqYg5plqQIkZXRFAAiGkrW2YTGZTduBbi+VrfyREG61ve/ctRnMDHYp
	jtvh6LP6M8V6F6z/s5vG4q8Y9eqcBUuj6gQ==
X-ME-Sender: <xms:iq3oaMwAP0BkAKBQOEH3aUIa-pIuvzwN_wDKonEz34Rj2cZ3Mv7pxQ>
    <xme:iq3oaD_gC5GnRPl0WxllTSKThmCK5yan818I7jS-FDDsk7rp55jkKhDH10LUnmYcg
    gRSOo4NivEi7L4Y0QkQZa20tH1Gr7xiEHjNlZNFuda136397uLr-g>
X-ME-Received: <xmr:iq3oaIJvXhJTcZvRlEfrMNPoO96S7mrOPCeFXEcNQZxFTYucK_EUmGWwjFM4qI1q32AY_mCbhHV1-slieq6bpHIdmusOI7xHQ1bNqU2sdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:iq3oaBe2KRbJW5DdNqcKTvbeRheT91K1PgLMEz-IfXEGC4xgIUtRIw>
    <xmx:iq3oaP8ABR_k5-LjExmy3x4qriGWZt8eIz9cEYFaKCsO4XerN4qUDQ>
    <xmx:iq3oaGqlSlATN9Rfh9_UfZBj0KQcfwxpzLQT-zKuNvfU-tVdJxaZKw>
    <xmx:iq3oaMAgJriElvP4uaA8W3NeRbQT53X-Z2gMZ8_TcYlzCqHrfXbJhg>
    <xmx:iq3oaF0WcgPSizZWqA7RBrdGpuTUwn7dWrETUJiUU_bVLoRek8v6JKLT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 02:54:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 94804f77 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 06:54:00 +0000 (UTC)
Date: Fri, 10 Oct 2025 08:53:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	karthik.188@gmail.com, sunshine@sunshineco.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 4/7] builtin/repo: introduce stats subcommand
Message-ID: <aOithKtHf_U9S_m3@pks.im>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
 <20250927145049.723341-5-jltobler@gmail.com>
 <xmqqfrc797pk.fsf@gitster.g>
 <qdot36lscj2jzuej2zixdlgocubiimh54dkxzl2xgcy3g2n42m@gpdi7jwc2oyd>
 <gzjaa3nmv6s44dszregri7kcnfxg6optkycg2wggtib6bxvdgq@elearr6dishf>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gzjaa3nmv6s44dszregri7kcnfxg6optkycg2wggtib6bxvdgq@elearr6dishf>

On Thu, Oct 09, 2025 at 07:42:40PM -0500, Justin Tobler wrote:
> On 25/10/09 05:09PM, Justin Tobler wrote:
> > On 25/09/27 09:32AM, Junio C Hamano wrote:
> > > With Devil's advocate hat on, a single command that gives a set of
> > > stats that are "key" to a goal of a single use case may not be as
> > > useful as a collection of commands, each of which gives stats on one
> > > aspect of the repository, that can be combined to help you address
> > > various different goals.
> > 
> > Good points. From my perspective, the benefit of having a single command
> > here is to provide a simple means to generate a report of the general
> > repository shape. In this context, "key stats" reflect certain
> > charactistics about the repository that may be concerning performance
> > wise for typical repository operations or just of interest in general.
> > 
> > One of the motivations here is to enable a user to easily generate such
> > a report and be able to share it with others that may not have access to
> > the underlying repository.
> > 
> > I think this still could leave room for more fine-grained commands that
> > can surface more targeted information about a repository with other
> > goals in mind in the future though.
> 
> Thinking about this some more, a single "stats" command is indeed rather
> vauge. Furthermore, as Junio mentioned, there could be other aspects of
> a repository that we want to display stats for in the future.
> 
> Since the goal of this command is to surface info about a repositories
> structure, may we should instead call this command `git repo structure`?
> Or something else along those lines that in more specific and related to
> goal of the command?

Some alternatives that come to my mind:

  - inspect
  - analyze
  - scan
  - survey
  - measure

I don't have any specific preference. What I like though is that those
are verbs, which makes it a bit more natural to use them.

Feel free to take any or ignore all of these.

Patrick
