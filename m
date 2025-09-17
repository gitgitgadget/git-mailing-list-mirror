Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15392F7441
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128859; cv=none; b=msavYuUKWn/R1cI4ymAz7ShnH0Sy205lqDpZ2jmIgEHISMQo7JhVvgfqJl4Lztv/HBf8/u07qYwfUAKuX0CrlrcFeTvBPOGDyEA1S/eWp3IJg+tIXacI8Uo6f7TMytsROm+PJfVLU6fDdxNMb7GpzfB4OpanPIaMSr3CqH8FHLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128859; c=relaxed/simple;
	bh=Lcp2sXxLBQ78bGYhCgZ/mT9NMYA+rT+SwHPSrB80CjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WW6ATOsMWC798Cpx9czc30C9lQR5pezLa9Htfz47CM8gmAeg6u+WtsJ2i4IxHudYVP+Ywq/ggDpQssnQGRaTVvdolNwb8NiYeWGtCpcsDU/T0fBFr4BNogAl/yIBKGr2oDW4rK+8bTYWOukXhmahfmq2bz64eKEFZD6lTUIXjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xhL+Mxqv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUI2w0QC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xhL+Mxqv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUI2w0QC"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C62A6EC021D;
	Wed, 17 Sep 2025 13:07:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 17 Sep 2025 13:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758128856; x=1758215256; bh=DDVgyo4nde
	uigK9mYMcYlZbX8V9q4NM3MlQC++TgI/g=; b=xhL+MxqvP573RxY57Tfl8osqpA
	uZ4ncmDAMUdwkgdKUercZEudNeSMXltkRoo5/IfX+gKYVyG/QOdsI3jgyKiWqahU
	Clo5hvbFjE5xmcMqZHyncuBXlAkD7c8fzxTT950psTBDCehU1QmqgxgaHhgJP0UD
	4KB0wpiPzSv4dR0IlvT/hpN3ZFEX3+GJMtvw5OaKFkYewP5Icg4YZo4ug1amVSwY
	P89rKnzG6WIEWuUNyDbxfRoQSlhi76sIDEtr9r56Df5pqVKh9hPykSz5cR7CVbjj
	Iloc4hJkNM8vh4xOOLVex4cfj0fRypWQexlQBW6l6UV5+D0fOOlXcc2Vs4tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758128856; x=1758215256; bh=DDVgyo4ndeuigK9mYMcYlZbX8V9q4NM3MlQ
	C++TgI/g=; b=DUI2w0QC3nTDh96tmI1uNc8JsT5PkHPP8rrq50gIUnJYLC21uJz
	DC5lLehazIFsgfaCT6sLJHF1glCC/wlQSoHRq987sXYoBnwWLUDLEDRlchNera56
	JaQ9QtAH+hgW/gHHMPj2rklcv/33pzkuVffex5tGtEngXfpU5rKgkx+kraBHWLc0
	gNEHXkHUgCEr63a/N5oChs3RBCNBodr/tYofuC/j0tRzWh1gGztduES4Pr9+vv+R
	zPUGQYqMcnGnMLThDXVBNZfQz+z1Epp3kIWnRVYqnlCgcq2CpxfyVc4d+PUvB7ab
	YmjS9qzJSUddwXruVh8fLPwkJusHsveyDgA==
X-ME-Sender: <xms:2OrKaJsHGE7vhzJRzRj-FHNzg7PZOY7ucM7gbAflGIdabq8unp-jkw>
    <xme:2OrKaNCM3rEsqNQMb8RWO8LoJCNw5A2PFnG-1xYnLkIelP0v7tnCJAEg77JEaBHXe
    rcYoOfhoKtG0xao8w>
X-ME-Received: <xmr:2OrKaJXiJLcX3_v3jkdQ5fKfR4nD98brCtCNftk_SeAvfyqbkZO6GZ-g0-y6cgJWD90dc7Om-9Ckeb80X-HjJaSHX1L2bZm8UhcsVww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2OrKaDCN4-K8iHNJU8Sn3Bsk-eEaEFRnyUZNQGQDvpf0NOEGBN54bw>
    <xmx:2OrKaE-LkiJFxXZG2VrG0Jm6wjEL7e2Chqkxi05ekAZs91FlE6gRbQ>
    <xmx:2OrKaCFeTdjKbGHfu9TmGq5e7kDwOj7MwOZ1xagAFJWLyAWfaTHWvw>
    <xmx:2OrKaKOgGxuplCbJJ7NPH9uw373ge34hnM2tRV9P4iPzVO4z3FOPhw>
    <xmx:2OrKaJ88vCl-WvQdlO11hAmvVASchl4QNIUWW2PtsnmXolOhuS-G7PL7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 13:07:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Wed, 17 Sep 2025 01:16:20
	+0000")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 10:07:34 -0700
Message-ID: <xmqqcy7pc8ix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is a continuation of
> https://lore.kernel.org/git/pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com/,
> but I am removing the RFC label.

Continuation meaning that these patches build on top of that earlier
15-patch series?

> Suggestions on changes that I could make to this series is appreciated.
>
> Changes in v2: High level overview:
>
>  * patch 1: cleanup: rename variables that collide with Rust primitive type
>    names
>  * patches 2-4: Makefile now produces libgit.a correctly
>  * patches 5,6: Documentation from Brian and Patrick
>  * patches 7,8: Introduce Rust
>  * patches 9-11: github workflows
>  * patches 12-14: introduce crates build-helper, and cbindgen
>  * patches 15-18: varint test balloon
>
> I would like feed back in two categories: big changes, and little changes.

This seems to also mix in some patches from Patrick's series that
are already in flight.  What's the intention of the inclusion?  Do
you expect us to discard Patrick's series and replace with this,
which would lose some from them and then add more from here?  Your
"pull request" may target my "master/main" branch, but it needs to
play well together with other topics in flight that are cooking in
'next' and also with other topics that are aspiring to be in 'next'.

So I can figure out that these patches are designed to apply cleanly
on top of Git v2.51.0, I am somewhat lost what you want to do with
the resulting branch.  Having duplicate commits that happen to do
the same thing in multiple branches "git" the tool can handle just
fine, but that certainly is a bad communication among developers
that we do not want to particularly encourage.

Before talking about "big" and "little" changes, do we need to talk
about the series organization and working well among multiple
developers?

Thanks.
