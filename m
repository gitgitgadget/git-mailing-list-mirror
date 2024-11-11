Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35851586CB
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369594; cv=none; b=bvM435faoPKArBw/4uCrdItc7Dg5wLXr46aMye3feOwPX8yycCNBnNYY2SCfuk8m5pJhAEIlONngx9C5sCKIADSDbGgF4/0nDBonCsSGONMdTgU7C9di9vdxEaCdOhDiPs616anbrv9wUdmVaosnaeX4BYN/Tsq3Q83Pg1WNxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369594; c=relaxed/simple;
	bh=QvHVlgSVdJGuMVXrhFLrFmfrVeCgknfaSiS8iFnbSds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M4mRS4LMAjph1KwjTH6OXOzO6pr+jYmr/BIFhmMsbP7QN7h5UEwkMfYMTZudq00qtgeMNa2s3DMdYEvRkqZUAywTjmq40zQhLj5rKg6SA+Us19cvL9IVlMkTjySBqtBQQqYRIQ463wsWMLLoTHnu6GaPxr48eHjONkmaqKISxlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ScTe5q9N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nPf34rCq; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ScTe5q9N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nPf34rCq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D7E211401FC;
	Mon, 11 Nov 2024 18:59:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 11 Nov 2024 18:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731369591; x=1731455991; bh=6h/h2dK63H
	uHW48+0IXOM75xnKPpx81ljo1lHhpPo8Y=; b=ScTe5q9NjOHYFqRbR2FzLOHJ6X
	yUOcmrnAVeKY5NcpjdsCZ0uGe1wqI9hRfQCHyem6cCWbD7Vkwy1f+2Z1d15dQ9RL
	Jh7hAhF96Guf0arbykNpdQreQLo+BWtzQx+3E2RQ1bFcKpNWDbKqjYcNQqa1uenl
	7qY5FGeH5qRwC+eHBWTXTDx6BPtT9Zy/e2oUeQHYgVzto5PRZef+zxxhFtAJC5rJ
	PvokXDHGm064oH2i6Q5ZwbK5WWmHoUFVWhUjJzjecqyloyTIi8E7z2l/yMWsTA9q
	yzO5j53JE+IJMzrB2GGNsB9AROJ5boOO9Rt7rzAsDYc313cQpsHPSMRDr5tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731369591; x=1731455991; bh=6h/h2dK63HuHW48+0IXOM75xnKPpx81ljo1
	lHhpPo8Y=; b=nPf34rCq2sDZX8TXJqPq/gZ858CIZkmqxWkV8w1yvCgC6P4wBlo
	E/b/jrIK3pbC51XHjxhv1PHGD7EaA6+P/HAHWzIr9uO+x1R+xeRNKjfB4YWVAOcV
	IBl+iQ68HBH2yCWoFI43FRZU/zKY1eOXQUiyVpY7k01lMuK3s7f96s48ig9nyfZw
	o2cXfCxJzuZdqBKEichzWxhCW/x6MEUlVdVgUTBRCWLz5Mh/kc5O9BMWuR0XWpTn
	0/UJ8DzL4xRizCP4B0AeuUF/whSQHC5ljYYpWGXoXBhHtYaXbbMwcD3GNp8rmTpp
	jtxvIibLxd52atJ/m2+tLyE7NHUDWiPYLXg==
X-ME-Sender: <xms:d5oyZ-1RI3qOw7evpzxJtC6WTdwvlVjX8pzUIfPJMMz42mRxUynlIw>
    <xme:d5oyZxHsFhHJVabMm2WkiKGPKfKdfaqCsDiPi4aUhe9Wm45VdFztLhbf-kzkXmcsB
    Lf_OlHnlRFQlts86A>
X-ME-Received: <xmr:d5oyZ24h5jPsr8V9D6QbQJsZ5wPPJWLat4UPEl_cO3kMNmYrlkKj7mPFVjU7gLkykcRaYvfo56FuVUNaEu7EYgSPO2FOJqafLpDV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:d5oyZ_17UFVi0RiXXYWP8znnR1LOq_3a-4CTXaPt2ug6YdbuKt6dmA>
    <xmx:d5oyZxHdKZKBHvG94GoWi-yazERy7jCXroyq08m2st_KuFHKSgsNUg>
    <xmx:d5oyZ48CA-Mzua7_u0pAtrgUdUHL9slPShEsBUWyhOyD6HKLTrq_KA>
    <xmx:d5oyZ2kiBi2kQLzHGNgBw1j6-cpWjMC1L0IKhsQmTncr55ArEckXNQ>
    <xmx:d5oyZ1g1SCIcCUdeGz5LlT9kueZCezwAC1kubKv0Hr0hMJelTUPBKgTU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 18:59:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH] diff: update conflict handling for whitespace to issue
 a warning
In-Reply-To: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com> (Usman
	Akinyemi via GitGitGadget's message of "Mon, 11 Nov 2024 17:49:55
	+0000")
References: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
Date: Tue, 12 Nov 2024 08:59:50 +0900
Message-ID: <xmqqfrnx9v9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>
> Modify the conflict resolution between tab-in-indent and
> indent-with-non-tab to issue a warning instead of terminating
> the operation with `die()`. Update the `git diff --check` test to
> capture and verify the warning message output.

Hmph, giving a warning against these conflicting setting (instead of
dying) and continuing _may_ make sense sometimes, but it is unclear
which one should survive.

I do not think of a scenario in which it makes much sense to let the
program warn only on one but not the other one.  Perhaps disabling
both, if we were to do the "warn and keep going, instead of dying",
may make some more sense than that.  I dunno.


