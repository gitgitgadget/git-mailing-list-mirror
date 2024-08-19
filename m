Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1528373
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059573; cv=none; b=ETLwY16BCiLeoJ0ktfGdi9WDrAZjwdwGycMxCbAuskhe/IALTJjf8hlZR5Alt22TA1kE/CdnPsgzsLOBBo3dZzszrcR07mbJLdWbrlp5k817JxINJUpCxeKylAZqNZNA8kqCZaofQUSVrrfWzwEegkROzX79dc2LGmFb11uLvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059573; c=relaxed/simple;
	bh=0KS8P3coxVx0kcx6gFw4R+O0y6nlD9waBUeH3pcPRns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pusdYoBu5QvzOC0NBr2mvxW8CO2B7OB5bspLDznYRsdt9z8SRNL8qYNUJtRVmx8o+8Mbn7lh+Y6+ONJUumTvkd2I2/2C7X36+VPnogRxf7vOFx2/YJW26mNZUrWjSqD1h76hySWeUjW+SvnqFHgvDc9FlpEbRFLEjlQ0T0hOefk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SkDSVuZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kd61LXrg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SkDSVuZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kd61LXrg"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 536C31151A8C;
	Mon, 19 Aug 2024 05:26:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 19 Aug 2024 05:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724059571; x=1724145971; bh=fD7RbSIVS9
	K+uVULbMig3tyJvhxpLDLLIiRJUTRVrCM=; b=SkDSVuZJ1vcVz6eF50sGVdq12i
	cp67zR2S0dcQzjwNWSwofCZCVExS8HDFnHAvbodagUeB/4dsqpgYtX+tZHakeTt0
	yB2gezxY53W+0mF0HypjGtk0b3E8l5x5Y2aMqIh0Yoc/iDhvTEOjHnjaJst3CICB
	O+QyOPeGv0zDM5tfsHIsc2rMsGM6Np2GsaxKLvcth+i9NHxQSqB/ngI54+OXBpNF
	8gEJ4QxbP/UFsfteZXEtkJz+HCcTwr0QQqtMghCt8EL7fdjM7aY7J92s01ZigoB9
	bnaH6MTZB5gQWH/VTag0nm26b70+RCxw9j5sFp340fy4vsyRvpp51IRkJO+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724059571; x=1724145971; bh=fD7RbSIVS9K+uVULbMig3tyJvhxp
	LDLLIiRJUTRVrCM=; b=kd61LXrgiQY/rt8LdV5fdGLb/OQ1K9m4IN1wirbIJIOD
	bs5cfZ1/Nq5TnKdkxEByqIJWtVGNIZN1mojS8sa0MVacU2+y736pIcehEC/9j/E9
	Ce4D3b08huHbH+u+7+sxKpYWuBLkdR94c3Z0WwwlBwcewl3NN+6NMynzTPQbs6As
	LkSXhdTs5PwflPnZTSkEVS8Q+/U693zECIUdySbkrJ9dOII1VcfiuXPDd3eLkOBY
	ObhFpA8iuWmfuXwGFfo5RJsg/T4vcBmQC7poZrifdd2F+pBFZ1610BrExSt6961Y
	aOcQ8pALwsNYQ74gbgN7gahIw4AzWDAFRL9KFb+AkQ==
X-ME-Sender: <xms:sg_DZijgVdDjFh7Xu25jh-w3vLsSCqlluQ1aYu4eof-vhU7PzrwP7A>
    <xme:sg_DZjB9ynjv-NpcfRmzpaNOleJXRBuE8-LCCbJSFXPGsYvtjRnW0_lG5TkbD3WPA
    Z-pNbMWGnl5qvFnow>
X-ME-Received: <xmr:sg_DZqHFUFohrEMjamPP0SJEiIVsXWmbnGXg3-EMm1Raq4gEspv2jHf2wWwBDcCcC_E3WUe_yyXMvXuCCV4Ujs7RI7Ko-mODy0me4_xpWGypsWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    esughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sg_DZrQ3QhkYzWO-12fHN1NNq4YttGbJ8TxCsQUQkseWWxkxMn8Nnw>
    <xmx:sg_DZvwzce0a2oE_G2v0Yuk4PUo50Pacq9_iUjF2La51eWAjch7EXg>
    <xmx:sg_DZp4mHsOEUHtrUPQSCEt-6Un6T_V6YWohK5jiATJy5FDklb07-Q>
    <xmx:sg_DZsz2zTqsuBO5aOcVGg6ND9WRSYAyqNq3-8nFNQsShXiXdGE9sA>
    <xmx:sw_DZmyzjezsrM2_twklH_QTspEUSh56utaNX3iPAGKnw2oTbWU5Z6xi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 05:26:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8412e42d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 09:25:38 +0000 (UTC)
Date: Mon, 19 Aug 2024 11:26:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/maintenance: fix loose objects task emitting
 pack hash
Message-ID: <ZsMPqEWVOSLOi39o@tanuki>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <c25b5333f60a5920c1fade06532e3379c6686908.1724053639.git.ps@pks.im>
 <20240819085522.GD2955268@coredump.intra.peff.net>
 <ZsMLZ3Tlhxsg6Qdr@tanuki>
 <20240819091715.GB2958552@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819091715.GB2958552@coredump.intra.peff.net>

On Mon, Aug 19, 2024 at 05:17:15AM -0400, Jeff King wrote:
> On Mon, Aug 19, 2024 at 11:07:51AM +0200, Patrick Steinhardt wrote:
> 
> > > I have not paid much attention to the "maintenance" stuff. It is a
> > > little weird to me that it is not building on "git repack", which
> > > already handles this, but perhaps there are reasons. Anyway, totally
> > > unrelated to your patch (which looks good to me).
> > 
> > git-repack(1) is way less efficient than running git-pack-objects(1)
> > directly. I've also noticed that at one point in time when revamping how
> > we do housekeeping in Git.
> > 
> > It mostly boils down to git-repack(1) doing a connectivity check,
> > whereas git-pack-objects(1) doesn't. We just soak up every single loose
> > object, and then eventually we expire them via git-multi-pack-index(1)'s
> > "expire" subcommand.
> 
> Hmph. I'd have suggested that we should teach git-repack to do the more
> efficient thing. I'm a bit worried about having parallel universes of
> how maintenance works making it harder to reason about when or how
> things happen, and how various concurrent / racy behaviors work.
> 
> But it's probably a bit late to re-open that (and certainly it's not
> part of your series).
> 
> > > I wondered if you needed --no-detach here to avoid a race, but I guess
> > > as a non-auto run, it would never background?
> > 
> > Even the `--auto` run does not background. That was the case for
> > git-gc(1), but is not the case for git-maintenance(1). You now have to
> > pass `--detach` explicitly to cause it to background, which I think is
> > the saner way to do this anyway.
> 
> Am I misreading the documentation? The entry for maintenance.autoDetach
> on 'next' says:
> 
>   If unset, the value of `gc.autoDetach` is used as a fallback. Defaults
>   to true if both are unset, meaning that the maintenance process will
>   detach.

You've omitted the important part:

	Many Git commands trigger automatic maintenance after they have
	written data into the repository. This boolean config option
	controls whether this automatic maintenance shall happen in the
	foreground or whether the maintenance process shall detach and
	continue to run in the background.

The `maintenance.autoDetach` setting only impacts auto-maintentance as
run via `run_auto_maintenance()`. The `--auto` flag is somewhat
orthogonal: it asks the git-maintenance(1) job to do nothing in case the
repository is already optimal.

For git-gc(1) we indeed did tie the `--auto` flag to backgrounding,
which is somewhat nonsensical. There are usecases where you may want to
pass `--auto`, but still have it run in the foreground. That's why we
handle this differently for git-maintenance(1), which requires you to
pass an explicit `--detach` flag.

Also, we cannot change the behaviour of git-maintenance(1) retroactively
to make `--auto` detach. While it already essentially did detach for
git-gc(1), that was a bug. E.g. when running as part of the scheduler,
we'd always have detached and thus ended up with a bunch of concurrent
git-gc(1) processes. So even though it does make sense for the scheduler
to use `--auto`, it wouldn't want the process to detach.

Patrick
