Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65A1946A0
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265732; cv=none; b=RwBjGBt0JQOYfjOmiS3MaDgThQEVKj1WY0kBqusskDNZG3UZy6GLcyuf5faiTX4EJ3ae6SpaSOWF7ImrJaR+gC9yXm5o6ta4H0IWHP/tvHVlWosGPn9hubKiItnydliiCZiHqSyOKGqPE5UzXWQBdX27/OV9YdcjNogR6dYlfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265732; c=relaxed/simple;
	bh=KkUn6nh/WJ9jWd7dbBJFyP03AKujSp42LEQgM+bwWEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fgzu4mseCBrdXMixGlGwuvekM6iIqo4iwD6DyJA7AMX4mbj/3zprgOaPqdZx09YYJScBnMRejlpxlOVWRuSPduNmXTXj9LRfVGrbfNrZJ+quXVnvjeXGOra4XYoZCg/MevWesBsrTtr/QUB1U5Kpd3m1qxBo6IvYzsZBwUruVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PAnsrKFj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xe64ieyx; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PAnsrKFj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xe64ieyx"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 21AD125401EF;
	Tue,  7 Jan 2025 11:02:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jan 2025 11:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736265727; x=1736352127; bh=oOI3afDHbd
	RBxpDUqMk2zcjgTDfUipduOtD7plbV75Q=; b=PAnsrKFjllw84LWSxiytY9emXK
	PestbaZz0vRJMUX0QP4JZu3i5eL7FYEOE8EQ4m06cUKlGqxaBs5CZYSew+QMgZ/l
	8QTGm3XLovBIbRw/JHsO67w49djATL5SFrIbn0sPca6LA5DGdzghjWh1JyotSC1c
	tP+GYMch0W1M8vsOmFEB3r0x89UYBNqVXNMG+mBZUcVCdtjH87nIX4uBEk0eqVYQ
	jstZr8LemLn4ksdwgcjTyPLo3lNvQTTshdJbc2arC3SDL3LsCzV4wz2Z5UVC6KwZ
	BlU4QfafW8Pn2UM2sCCAXUCMs6JDQKC5i2dKwyc17snZJjX3+FyisZGFr80w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736265727; x=1736352127; bh=oOI3afDHbdRBxpDUqMk2zcjgTDfUipduOtD
	7plbV75Q=; b=xe64ieyxvsLlY4PizFEeAIk4kooTXgHjuZbzQgMiwxn/F5tQU0c
	l8IB8onU3LSMOScRAM28kA9o+gZtPoC6/Mh5/S/+PWeZJCK2oSxLtt8cCF13y8NL
	sBvMiSGRemOOjcpPNFtQ7Hk8gXeJyQauyIKKxnSk+Pr1b94Q2uPwuGZoTsymgA2/
	sYWrgvB14xxGdilNhuo2QT0haxobFN6VYNLm7FhR30G79Joh/EpLFoCFAGzf6z91
	mVQyegMhTyx5JOexRMvbuXVKg+cESkb+qkKNKttItxNvHbLRWUyYiwxaRKVBRKL5
	v27ZaNczyQbtcIOmfjUyaJGVEOgESiqSysQ==
X-ME-Sender: <xms:_099Z5jChiJWmykfqycpRKLnKaD3q-0U4lvPU01-QO7a2UHRwEgo8g>
    <xme:_099Z-CGS0KXxfTk1SQxKM9Jfp2oB2KP591nVhE5DDlF4K63dI6RNiB9XO379X56O
    o_FaSPMEsOe9rvQeQ>
X-ME-Received: <xmr:_099Z5EFNqMOPp0vQ4f9a40LsTMtMYGnVwjB4yAstFIrg0ii8IUJYgrmFDE6pTOCoYT_Uf__SiN1eyjKftIf0abXH9FBeOx3TFvz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:_099Z-QQkCvNiNZY23uPgO-XD-0QJbgmIZnE1-9E1ILc0CcW3YRSZg>
    <xmx:_099Z2zN94EOYePMWvlhsLzmc8q2q-B88r8YLRdZ777WlqXpKY3gIQ>
    <xmx:_099Z04biIFvM74g6RN7z86LJFoCUAKMJSCbJZxw55rTgS4OidnUag>
    <xmx:_099Z7xFAbJyfiuhVqjYBu7QR9NFKDsY8DJIamybn_mt-8HRFMjlVg>
    <xmx:_099ZwtQl-mhwixgLigpYp9BoqZuzYreW6YZru5fVGSvX8gHm_3dc7f4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 11:02:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 02/10] t7422: fix flaky test caused by buffered stdout
In-Reply-To: <20250107024829.GC2363@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 6 Jan 2025 21:48:29 -0500")
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
	<20250103-b4-pks-ci-fixes-v1-2-a9bb95dff833@pks.im>
	<20250103181739.GA2527684@coredump.intra.peff.net>
	<Z3u6lj_bpM7N93Fd@pks.im>
	<20250107024829.GC2363@coredump.intra.peff.net>
Date: Tue, 07 Jan 2025 08:02:06 -0800
Message-ID: <xmqqr05evcht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So I think a simpler and more robust version is just this:
>
>   {
> 	{ yes || true; } &&
> 	command_expecting_sigpipe; echo $? >status
>   } | true
>
> We'll keep producing data in "yes" until the pipe is closed. So it will
> closed before command_expecting_sigpipe even starts, and there is no
> race there. And because we're using "true" on the right-hand side of the
> pipe, nothing is read at all from the pipe. So there's no guessing about
> how much might have been read.

;-)

> Like I said, this won't help our current situation, but after having
> spent a little time on it (before realizing that) I figured it was worth
> documenting.

It is always fun to ses these clever hacks on the list.

Thanks.
