Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF741E1DE5
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766223133; cv=none; b=TEdbrejnPtPZsLIpXXPOw/SgUwHXMOKaada7RMEX2VV/vOSmKf0MH8PZBoIsn58TuVhT7yii89aTh4usUGjwJMBTdeECp2R19QZ6PUGtUqQASK4DHthfHDwuCpiwdZQ0W/N6AyYuFB+SrgFRBWJAGPCEVXUIug3aEiTjUq8Wnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766223133; c=relaxed/simple;
	bh=bzJpV6WCdCZAeVhHBqp0J4IlaZjvZdOn+X2dBBMIioI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/DUQn2gwUxLci0NnD7MKQfYAjDKN+yxjm4mfMbRoEzTRMy1sXaTVQk3XcNX+ux3nEaq/nVEC9lWycfkaU7rwDauGm5XHp+CHLu0N+kPX+3c1IwRaG7nTGooLxRHCv5nfZVyNx98lJBHr4dn3eovQS3JVw+ibZWo2UuQ63dv5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o5rWgUpg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yeKe5qWn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o5rWgUpg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yeKe5qWn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F2E0AEC0015;
	Sat, 20 Dec 2025 04:32:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 20 Dec 2025 04:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766223129; x=1766309529; bh=Jh/yCZs4rH
	wfENXvxLD8ap8UPGBU81C9FEu5gjxfrcE=; b=o5rWgUpgLliOoSfcr0wYa/ZLO6
	vGC7ffPCWsRL2M/zKvfovQHVE+ofwnlntBMCw84mT+KNAbkRYyVYdYeIbC3dkr0e
	DAl3qAlOTQD6sQSS803tMpGR4i+mNxc8Ni838d/wYf/jonu8ddEb+NxvagMw5OHL
	NssOeFvE0knL/g7xBd4UrypGFqyJjzMba6I+wRIjfNuEaUiIfrWIZqvGEvkM98U1
	9Qk65WtZl0MtKGobxWh0vWwycSIIWK9v0A7ZYQMCYJ3xDVJfojQjIgpwHOHJ6/OT
	8g5x70QnCdoyAHLSlDYO4VQjPJGH8qmi7Efq5L1w0kIyZf0gCvK4ocjgCFIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766223129; x=1766309529; bh=Jh/yCZs4rHwfENXvxLD8ap8UPGBU81C9FEu
	5gjxfrcE=; b=yeKe5qWnL3jfLjUnLtbor0U9L7sd3DOCsH+evvtMQ87FOgsXsTR
	dIc1UFSHh1dl0dfOMeHj9Qwsj2397QEOJFjv2U8Cc4ZX8fTBetyRLpanSzUkBkGR
	0ip7LP4CPAEed4H2dAKbLP9qIK9qpVwr97DwKoy2QU/ItcqLBRWQDAgNQl60CX0I
	ED/YVo6i1PLoL7pg1xFx6ZYrTPn2ntoCgBSzWDOchhNzRrWRgblz7rkJSOboUDwK
	jqjKwkZMuuqYtFb8sPKQMirFxbqxuumAC/EWhcc0EqjuaUXvz7Uihuflkf4NnHIL
	xQ3YTVFNZRHk/ex6kXEvsaN0lCR3KI1cp1A==
X-ME-Sender: <xms:GW1GackWKjkRLeC_9m2zYYtnFRAM1Rs8vvv_jaeONb80N-c0VAay0A>
    <xme:GW1GaR3pQ0-P-lZC1tW5UUqDj3mQ-PX4riqBYT0qbXzQg03ODGbpooQBzOKALOWtj
    48z1LnlfXj0zj_0jdnfiNTw_2RVBV7YRKGBr01mk0-RlpC_ii2L5Q>
X-ME-Received: <xmr:GW1GaYRFXwRqkxC9q27aPSs1zmXGD4ByiB6386eSuFfKdMPFgK-78oASFQCR82DM7rjtTj_pYo5-d2OLOpNypIbjwU6ZS6g4OZkaYmVu011J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehtdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuoggigeefvddqheejucdluddmnecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheeutdejteduvd
    eugfeivdeuveffgeffledthfduieeuieelleekgfdthedvffeunecuffhomhgrihhnpehg
    ihhtrghtthhrihgsuhhtvghsrdhknhdpsghorhgvugdrrghrpdhrvghrohhllhdrphhsne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GW1GaTt6jyrdRCvdS6T4rXO-ZC4Zm6NyQsvTsS0GnpeV-dheDMnGKw>
    <xmx:GW1GadaKEsnvSnmHcupLGtmpXcFpzHl0jYt4Q94aVp6pvAuSXVZ20A>
    <xmx:GW1GaYtMgXQr7EH1UXiufRAX9SEznZGZsrg1LqXxI3W8GKy1v2LxEA>
    <xmx:GW1GafEri7tB1_gLpkFlF7XIS54Hswj220_brWjt_LdrEaaHfRTE4A>
    <xmx:GW1GaX89Z3CBP4xWKEA1L-vgcbbZssBVobif_gvhYVfNcpmQbhT_gwcD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Dec 2025 04:32:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54067743 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 20 Dec 2025 09:32:07 +0000 (UTC)
Date: Sat, 20 Dec 2025 10:32:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2025, #06)
Message-ID: <aUZtErI8xbr6I-X0@pks.im>
References: <xmqqfr96v2oe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr96v2oe.fsf@gitster.g>

On Sat, Dec 20, 2025 at 01:47:45AM +0900, Junio C Hamano wrote:
> * ps/odb-misc-fixes (2025-12-10) 3 commits
>  - odb: properly close sources before freeing them
>  - builtin/gc: fix condition for whether to write commit graphs
>  - Merge branch 'ps/object-source-management' into ps/odb-misc-fixes
>  (this branch is used by ps/packfile-store-in-odb-source.)
> 
>  Miscellaneous fixes on object database layer.
> 
>  Comments?
>  source: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>

Given that this series is somewhat small and has received two favorable
reviews I'd suggest that this can probably be merged down to "next".

> * ps/clar-integers (2025-12-06) 3 commits
>  - gitattributes: disable blank-at-eof errors for clar test expectations
>  - t/unit-tests: demonstrate use of integer comparison assertions
>  - t/unit-tests: update clar to 39f11fe
> 
>  Import newer version of "clar", unit testing framework.
> 
>  Comments?
>  source: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>

I think this can be merged, too. Peff has positively reviewed the update
itself, the only change relative to that in v2 was to mark the self-test
files as being allowed to end in a blank line via gitattributes.

> * kn/ref-location (2025-12-01) 2 commits
>  - refs: add GIT_REF_URI to specify reference backend and directory
>  - refs: support obtaining ref_store for given dir
> 
>  A mechanism to specify what reference backend to use and store
>  references in which directory is introduced, which would likely to
>  be useful during ref migration.
> 
>  Comments?
>  source: <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>

I somehow lost track of reviewing this topic. I've put it into my
backlog of stuff to review once I'm back in office (or when I find a
quiet minute where I'm bored).

> * ar/run-command-hook (2025-12-18) 11 commits
>  - receive-pack: convert receive hooks to hook API
>  - receive-pack: convert update hooks to new API
>  - hooks: allow callers to capture output
>  - run-command: allow capturing of collated output
>  - hook: allow overriding the ungroup option
>  - reference-transaction: use hook API instead of run-command
>  - transport: convert pre-push to hook API
>  - hook: convert 'post-rewrite' hook in sequencer.c to hook API
>  - hook: provide stdin via callback
>  - run-command: add stdin callback for parallelization
>  - run-command: add first helper for pp child states
> 
>  Use hook API to replace ad-hoc invocation of hook scripts with the
>  run_command() API.
> 
>  Will merge to 'next'?
>  cf. <aUVHVMNTFWWn2xjZ@pks.im>
>  source: <20251218171126.588066-1-adrian.ratiu@collabora.com>

There's a small set of nits I had on the final patch, but I don't really
think these necessarily need to be addressed. I'll leave it to Adrian to
decide whether or not he wants to do a final reroll.

> * ps/history (2025-12-03) 13 commits
>  - builtin/history: implement "split" subcommand
>  - cache-tree: allow writing in-memory index as tree
>  - add-patch: allow disabling editing of hunks
>  - add-patch: add support for in-memory index patching
>  - add-patch: remove dependency on "add-interactive" subsystem
>  - add-patch: split out `struct interactive_options`
>  - add-patch: split out header from "add-interactive.h"
>  - builtin/history: implement "reword" subcommand
>  - builtin: add new "history" command
>  - replay: stop using `the_repository`
>  - replay: extract logic to pick commits
>  - wt-status: provide function to expose status for trees
>  - Merge branch 'pw/replay-exclude-gpgsig-fix' into ps/history
>  (this branch is used by pw/replay-drop-empty.)
> 
>  "git history" history rewriting UI.
> 
>  What's the status of this topic?
>  source: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>

I didn't find the time recently to focus on this topic. I think the
discussions mostly reached consensus though that we also want to adapt
these commands to rewrite dependent branches. I'll work this into the
series, but will probably only get to it in early January.

Thanks!

Patrick
