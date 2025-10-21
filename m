Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE102882B6
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081317; cv=none; b=S8fjd2FMuJk3Gcn8bKP6/CwckF3TRIdQXZc7JxUgjQ0J3wvn4VDJ0oiUhQGR/eXeUnX7jc1PlLKHSKeacXZNTjmt0qUiY4ggcY9D6edu8V5sXe5Hep1jCziC3FWD/VT3CJFdisnpN4gGlzELIocYOlC31Q2zLlbKvOdzpJdOPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081317; c=relaxed/simple;
	bh=XIjIeaUtegzIpAYm4MU9TWHpxKl/1Gvjhv2eNXkPadc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=StJZy+KqaJ3w0IZ2lMbj9w/V/dU1DQRIpf2MX6UFricYmwKb2bFSfBe9QNT7fYz9WAE8abx7w24wMK55Hb/SRZLl42ANgaRspJShHclGhU+ilbUy2KXCItKV+mWss+//ZY8NdLGq8K6vRLl5cxK2UmwsHyzPNePqLKYEn330AdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a19MH6Ia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UNrfo7r8; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a19MH6Ia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UNrfo7r8"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 98DC27A0082;
	Tue, 21 Oct 2025 17:15:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 21 Oct 2025 17:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761081312; x=1761167712; bh=5Fkk6YINoU
	fW9AoOpHAopBQmfXepQhUtYIxIsfcH6lE=; b=a19MH6Iac4kXh1iQ4WadqqKXX8
	BeNwNY/abbxfmLoZoIxgyup4vOHh1ZBLTfeAK3Gdatm8uEurIzNsrvxxzWVBrCJG
	yFviH83rfnowjrnfXj5PEopCvJBrMoylMWAOCXBf8jrkjXHFBd3TdODbUCakcVsg
	0PVgh947/nImDGtv6ZT0K1fe1lUKvdIIaL+reb+MC5rVbI+vDYlrylahDPR7sLNA
	1JztzZ0aMK9TAfx/Yqr/VS9lFZwpiwiLIQHrN8Bidayjc6xtRST/c1j3Uiwy1Y+i
	ija4mHb2XV8b9Io7zx9RJTGVw5jUKTbPKT/MIkJ4qHvyma55nZS67QkOLoqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761081312; x=1761167712; bh=5Fkk6YINoUfW9AoOpHAopBQmfXepQhUtYIx
	IsfcH6lE=; b=UNrfo7r8b1/mVnKxIH/cJ/akoUZJyWFUAehj9/E0c31Uw6/yCQ6
	n040uIFP4q4zrdTXN1Y9KVHOy00/WbdrkOuPITuYUcgRJkN7dy/7t/ZsE897QwVc
	cSc8EvWnt0uOgOVKuH9ZloUJym4KtVCLL8diKx/0E77uHTTZcddE3N5xp3SZ4G/9
	3UX3R9O9SNhyKRJDCQ8DY0k7Zi8Aol9LOrN92YGly1/qqLw0ipb11/57ybj0aKag
	KaW6+9hHHQFPFnq8uiOwQ8osEL80MvSIJboc7UPfFmxN6eL7JhBjKlyw9xexN/kj
	LrU9mRsqZi94gDFKzxTB2PGaG1E54t6mEwQ==
X-ME-Sender: <xms:4Pf3aM_wG9eoy-qreBXgPx_85rqY4xhveLcP537usagR_HKPy0syTQ>
    <xme:4Pf3aBRp36m3E38Vs8ipTEAZ-P1WymxFW-pSWwyM0jluImM1lMRzkI4P13ghUfRTm
    egGyNl-6LynTrduhlfsBdLi6Hoa5KYpL4mM7A7WguuAI7hlR7lG>
X-ME-Received: <xmr:4Pf3aGfunbZtVxv2nGuXF7A1cY_C-NUDCr_CeiLopNYr11hS49izFZDiP5tJ-fABqSTJSL6KFvNlgT04a6oIyk92SdFtrPEbtYO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedujeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghr
    thhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:4Pf3aDQN2O4yeBOrGyewl07aDhZXb9RY_594FTRSqlpbxIUhOeikPQ>
    <xmx:4Pf3aCIv6G32q9i50fycLPuG3aThGMcD3oGFXl_JDYegxgQavPjf5w>
    <xmx:4Pf3aAIVjy4oEi0JCOcCnBCqKXWC0qYm8SMuYiDdo1tqL9TvPjV02Q>
    <xmx:4Pf3aNgmZA3yEAbyoTF6dPUEanK2Pf8ErcjpZ57DRsz5J4XuunNyZQ>
    <xmx:4Pf3aMNi0cgbWFSrEsugNsT9ETXZMjIVSPTw3qHiXMEg6qPld76--zyd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 17:15:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 05/12] builtin: add new "history" command
In-Reply-To: <20251021-b4-pks-history-builtin-v5-5-78d23f578fe6@pks.im>
	(Patrick Steinhardt's message of "Tue, 21 Oct 2025 16:15:53 +0200")
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
	<20251021-b4-pks-history-builtin-v5-5-78d23f578fe6@pks.im>
Date: Tue, 21 Oct 2025 14:15:10 -0700
Message-ID: <xmqqikg8t0rl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> new file mode 100644
> index 00000000000..57560525a70
> --- /dev/null
> +++ b/Documentation/git-history.adoc
> @@ -0,0 +1,45 @@
> +git-history(1)
> +==============
> +
> +NAME
> +----
> +git-history - EXPERIMENTAL: Rewrite history of the current branch
>
>
> +SYNOPSIS
> +--------
> +[synopsis]
> +git history [<options>]
> +
> +DESCRIPTION
> +-----------

We would want to make sure that all experimental things identify
themselves in a similar way.

The way how replay identifies itself as experimental, which this
patch is modeled after, is somewhat different from what is done by
backfill, for-each-repo, last-modified, and sparse-checkout
commands.

> +Rewrite history by rearranging or modifying specific commits in the
> +history.
> +
> +This command is similar to linkgit:git-rebase[1] and uses the same
> +underlying machinery. You should use rebases if you want to reapply a range of
> +commits onto a different base, or interactive rebases if you want to edit a
> +range of commits.
> +
> +Note that this command does not (yet) work with histories that contain
> +merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
> +flag instead.
> +
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> +
> +COMMANDS
> +--------
> +
> +This command requires a subcommand. Several subcommands are available to
> +rewrite history in different ways:

Looking at "refs", "repo" and "sparse-checkout", none of them say
"requires a subcommand", even though they do.  It would probably be
obvious from the syntax, so drop the first sentence, perhaps?

And "subcommand" -> "command" to match the section title.

The remainder of this step seems a bog standard "here is how you add
an empty shell for a new command" and I didn't see anything fishy in
it.


