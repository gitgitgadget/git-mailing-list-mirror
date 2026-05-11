Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A236212F
	for <git@vger.kernel.org>; Mon, 11 May 2026 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778478718; cv=none; b=AzjA2UWHTjbD3wRFQ3qKWJmdc5kNRgl2ocBzY0OwL353RFTXwLmek8U6XJtFZuJCQfjQ3dNqljvHuTpN2yuzvCj/OqvQpl+lvpD4BYUDCOG3woAgmNs4ssgXw8DH5UferxhmtfaSO6OSPjeiezXhj4uen5mq6ZKUY1Y1hz+DQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778478718; c=relaxed/simple;
	bh=Ur9AskMq0mLIfOMcrQtRXcLN6eWmmsk+ANZgtPYVGDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jIYbBvKzX8UrNN0oK9U2dfETZ5veBPJ7TN1PC6wSNCifLY5DiO272FxZAZOFYhB5X2AlND7nvECe6rbeZ+/YlEv/8x4OZYiHvT6IyraINOvc0iAkiHdeHhB9j1Dj0YRdcV7v2tndxYsmxnC8OBqrH+e8duSC3kwwPsNDltxAT14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MYkuOTgY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cotAZV61; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MYkuOTgY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cotAZV61"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E46687A00CB;
	Mon, 11 May 2026 01:51:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 11 May 2026 01:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778478715; x=1778565115; bh=dPw0PNpKie
	BxIHUDbvrFOBjkq7VFRLjDQG6rA78mrkc=; b=MYkuOTgYoWSQ6m+aVnT0MAiERt
	ODShwxssUP0DsoLiO24YtBA7g79CLEYnGITKtvgQDO0iABAo9srgTnBNOOQb1C2d
	YdFnXlJ5NLk2NFXeFO030g7uKHFZ46A3vGxv3EsnhrH7JxXaV85ckbfU/W5zc1AL
	9DKhxskgPgnTtxLKT9ZsVHhe2iH+z9fHCeVS9UD32OV5LU3KtSE7HGeTv0lxIxGD
	/LiwjhRh6JEK+Y6DJicXH51XzGVo3jrCTd5NggPGbFwWXobOxWlJe7ZYyDuk0d7l
	18C2ntx6jS6PNLn8jsYw7lT+lhQeGZCNEuzzLzfEkRW+VYvLDBHdUKHjxtYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778478715; x=1778565115; bh=dPw0PNpKieBxIHUDbvrFOBjkq7VFRLjDQG6
	rA78mrkc=; b=cotAZV61HQMwacEmBtR9/SlJpYRAwx6d/1VAZ3Njt0mX8Woe3Kl
	4Jj47nzr3vmHrQpHnXInW9B2eb1r+lGSvJd2wCsDXacHlVpt6H0hBsY0BnaRUoAh
	hxwh9kFV6xmkxtB5MNuBhrgbh58EdAW8HwuvbLRVPkDj/dae9zgEKJc3bDb2FUNH
	MKlMFeLP0Y16qKBOaaHhuFhGA/ZMDXvJwNMl8uhbZ/scmuubLY24NClH9RKu3o05
	bxsTUVQuLVFBakLy8SCzKM5UOJFigKi8w48UCCdgVS7Bq6rNDJ4LjtoygcJRcEG+
	6sbv0NHcS9jfIxsRShkc2a0uGxnx9MRQGww==
X-ME-Sender: <xms:e24BavGY3kLSEt7dELLxw03i-NJmp3VcMirCSJHOdH2CMbGq_MVYQg>
    <xme:e24Bao6LJ-qwRQSphIxMa6KPDrwH9qy1eAiWbUfkujTwyzY5Tkczto3Jk0wU1nYSX
    DCCVBgltw-RAdk-LER5lO-ks4WqzroHG2mfYoOTUy71K14DmKO0aQ>
X-ME-Received: <xmr:e24Balk4xniepHWO7Ih87Gce5YhiUPzZJD4pkAmkRdJxQbRp5tOcTFQcCYz1vFwF64nn7_a_fngkXcK0ODdIm7x2_luTfuzf6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohep
    ohhpohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthh
    hinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:e24Baj71htO_AsQ-L47YmOJZ0ElBch8wDnok7CdLPYCnnk9GLaXE4w>
    <xmx:e24BamT3EYZbwyqIBH0gzVs6Mgm-67MSk2rc7rcIrF7d_nn34CRLtQ>
    <xmx:e24BahylHNvfCdGlZ-qdrcslaRZQuSy1it0qjvs9wXrmpTreatyJBw>
    <xmx:e24BaurdGRmU5mA-u19VWwtkckInLVASmRJHrUoIfblnY0j0cBZiLA>
    <xmx:e24BavSqHKTbWCiLR3CAjrq4zIhj5YZuWHUKzn02LEW9pGLnT_Tx_Dmw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 01:51:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (May 2026, #02)
In-Reply-To: <xmqq4iketzh0.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	11 May 2026 12:08:27 +0900")
References: <xmqq4iketzh0.fsf@gitster.g>
Date: Mon, 11 May 2026 14:51:53 +0900
Message-ID: <xmqqik8usdc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

[cc: list taken from <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>]

> * jc/neuter-sideband-fixup (2026-03-05) 6 commits
>   (merged to 'next' on 2026-03-13 at 5a4098b0cd)
>  + sideband: drop 'default' configuration
>  + sideband: offer to configure sanitizing on a per-URL basis
>  + sideband: add options to allow more control sequences to be passed through
>  + sideband: do allow ANSI color sequences by default
>  + sideband: introduce an "escape hatch" to allow control characters
>  + sideband: mask control characters
>  (this branch is used by jc/neuter-sideband-post-3.0.)
>
>  Try to resurrect and reboot a stalled "avoid sending risky escape
>  sequences taken from sideband to the terminal" topic by Dscho.  The
>  plan is to keep it in 'next' long enough to see if anybody screams
>  with the "everything dropped except for ANSI color escape sequences"
>  default.

This topic has cooked sufficiently long in 'next'.  I'd push it to
'master' so that it now would have enough exposure time before the
next release.

But I'd do so with a bit of twist.

I plan to hold off the final step.  That step allows to pass
anything until Git 3.0.  That way, those who work with the version
in 'master' will see how things would look like with these strict
checks that allowlist only a few types of selected control sequences
by default.  With luck, we might not hear any complaints from
anybody, in which case we may not have to apply the last step at all.

Of course, if there are huge complaints, then we may have to
reconsider the approach to allow only the selected sequences and
instead blacklist known bad/risky sequences.  In such a case, we may
have to revert the merge first before we regroup, but it is more
than likely that we won't have to do so---after all, the topic
(without the final "loosen rules for now" step) has been used by
those who are on 'next' for quite a while already.  Knock wood...
