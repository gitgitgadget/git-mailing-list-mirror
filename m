Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CDA2727E2
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493627; cv=none; b=K0fUBUeicxzenoMeGUL1i1NjgtlwOLkljm+AiFSF/ccxiqsoY5H9lvldfisz3u2+jXmkh3cJ6OyCitnQJVIbb++Ys2+PtMRL9aQ/iyNqJTAebzrIaubi95GhYNVhNaMlK6c8Y5NP0I7KYWiG+4g5qUG6UvWOQbGvX5CmSUrbo4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493627; c=relaxed/simple;
	bh=C3CZW2Pf/MhtjIG6t991yTEmKamKu06aXlMU7XeB4kc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kEiFBesJ+TXqvGMSL8wIJQBEzZOK/8QO1FDbM7Gds8iVXlsvzVSblpwE79gZdsfKlNxz1G3w411nxSLUf4opG5+r/O88ghdL5gt+7Xh/Iv3IGiVW+VRRGHiBA/B8LhDXq7FGDRLGF2hp4STFLk/tITgDVGTgoangMOwWqBq2I3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HImSsNDR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Phfmhvco; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HImSsNDR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Phfmhvco"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id F0E3A1D0008A;
	Sat,  3 Jan 2026 21:27:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 03 Jan 2026 21:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767493623; x=1767580023; bh=YL7k0lpU4L
	fXcKMdqzv1wkJNIOp+GvuRe22NGkfNA80=; b=HImSsNDRU4WAu56pLSE9lNnc64
	yCqW0VDDjpnKbjJM+QdYQu1JtfrAWUUeKTDNwy4OU7MfCQwkiNNr17D/sPU4j/Ep
	1UiH8CJ6OOYpZLd3mmlne+z8s9v2rewQvO7XFjk3OnfhqApzar8hzouO1XUCDOjK
	pDWV6auGT0DfuJyRHIwcWII8wTnNQWlJazzR6V8l/DL6tj08L1aTgDKwLBkMJwQb
	bPwf3xeX0VZU2y6FsuiAeDZysP9GO9bQPBNj0kmYexsX0PKyTvxH+N0N/avFmEG2
	672xMtnh7Oczn8lcHeG6CeU1GN1qaLey+AbIFhm7CF5Xu+LNSpfIXbi0lQjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767493623; x=1767580023; bh=YL7k0lpU4LfXcKMdqzv1wkJNIOp+GvuRe22
	NGkfNA80=; b=PhfmhvcotAXfH6007vNa/pRJ7mMVf1dEOyh/EGI0WVdjdR00RNt
	JWDjLdrsZdvTZmavOv1I0SAu0//qtIbMF7/BzmRagRVdTlewCh8KJt0U1YuGbxRf
	HPzOcovfmte6f8Pb/mvr/3pIrsC5Ik/H+sM/84wx5mzxcpB5xBEcKCLsANAr1ftY
	KMxsTUr7kQVYHgrkmMXf9ZONQTTDly9X4sP8jaCqPkIq33fgyWQrWmO/oX6zFzlW
	IVvijxbGiFz5ycXvbjlNen6VlIhVwxo+n0XcZIKEFi33Gfp9UEHTsoU+vmkrrwFf
	39qIvGK0b4qYU5WBLjgVIh+XF2gmsi3tCjg==
X-ME-Sender: <xms:9s9ZaZw8zMggofhxoR_qH1WRb1hYuICFKR6k2iVoDDJF4dU-mBKIhQ>
    <xme:9s9Zac83qxzNqU8Mxt2jlUklf21xK1yZVCkOHPyGyB3W0xXxcvlIh5ramRSH91-Yn
    kgFQBwAIh2eTvADmla_ox7dv0ZmKyjw5gtbst8aPNX-9VEftWXeYA>
X-ME-Received: <xmr:9s9ZadIXokapZf4oSYgg0Hx9dsgSRZ_RjM0KCG3z5enhh0vLIf9pibXvz7Uz96Bu4ucIy3c0cr4LY1UBwuadXl1MAKRYFqjQKvt4Luw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrgh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprh
    gtphhtthhopehjuhhlmhesshhouhhrtggvphhhihhlvgdrfhhrpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9s9ZaSdA8Km-rwUNCBs_Yel2ZL79AO-agFuOPhhyIlI2MoZvHC0VKg>
    <xmx:9s9Zac8pWJFCMZnmnzWpVo-D-MRagFXrTpvClvnRwuCqr4ZoAPeqTA>
    <xmx:9s9ZafrlHbQ67EhynkD1VgrDe4SR6aGKBQTdW5zAfpg0UeuIHVnZ3A>
    <xmx:9s9ZaRD-2Wl2oqBbntAM2J8n9OYIjkqSbcasSzb2qMEPEdDsZcN0Xg>
    <xmx:989ZaTqL61uHKjgDvmCHyN4zpgdHYjgJl79xC87E0ykU6JkvMjDxd4Jk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 21:27:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Julien Moutinho <julm@sourcephile.fr>
Subject: Re: [RFC PATCH] builtin/format-patch: print a warning for skipped
 merge commits?
In-Reply-To: <aVkKmcER2K8D9U4T@codewreck.org> (Dominique Martinet's message of
	"Sat, 3 Jan 2026 21:24:57 +0900")
References: <aVkKmcER2K8D9U4T@codewreck.org>
Date: Sun, 04 Jan 2026 11:27:01 +0900
Message-ID: <xmqqy0mep0y2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dominique Martinet <asmadeus@codewreck.org> writes:

> Okay, I can see this being confusing to people not used to format-patch
> even with a range, but I agree it'll be annoying more often than not in
> general so I'm fine with this.

Yup, nobody stays to be newbie forever ;-).

> It makes it a bit cumbersome to print details about the commit(s) being
> skipped though, so it's probably simpler to do a generic message like
> "No patch generated. Note merge commits are skipped." like this?

Or queue these merge commits in another commit list instead of a
single boolean "seen_merge".  The warning is issued only on the
error path, so as long as accumulation phase is cheap enough to
record information necessary to later create detailed messages, the
location you added a single warning() call can call a new helper
function that gives more details like commit log messages, etc., if
we wanted to.  Or seen_merge can become a counter and the warning
message can become a simpler "skipped %d merges".
