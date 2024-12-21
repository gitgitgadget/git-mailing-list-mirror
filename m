Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20752AE77
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734748947; cv=none; b=tZf3f+Y+I8vLRDzGmRjjQTgIuVs1V80g+sHppSr1387zF66aZEMn51pkSnOVscmLQRTx2jSW8f7Piane5SY+7HQpYU/64Yr9rFtJedmTTjpwIFY7zvb7ccxXPBksiN221M6RskF3H+WSmU560/Wksx9NL3387iqfO4C5JnsjBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734748947; c=relaxed/simple;
	bh=6ukUKDMdTajGhMdQwglCdZaoakzxnNCLCS4zix2mVSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cWIezYPPczFfKka/TW/zu2v7QTT0hgK3LP8t5qQXHRoenAkhTewod7Fkz1RCWtAyIsaHgcwzoC03llkiyFsJkUKa1dqnnwN2bLcEpo4+nrN76fxvdT8MLnxR/09SEBjD9e/5+pxfyGlEvnNPpelX6PPgjIRc1UczZUcn3f+1JWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pDDoTXVV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dOsI2Stj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pDDoTXVV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOsI2Stj"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C95221140145;
	Fri, 20 Dec 2024 21:42:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 20 Dec 2024 21:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734748943;
	 x=1734835343; bh=DXs0odeZLPNYR3uXTvkVFrRodnrBOS/bO+7bufjfekc=; b=
	pDDoTXVVC34M9ZQ9p2bjTbAwUvIjyi9pkqd7zCN1q6+IEHfKyTPkz1bSyDOA0mJt
	Mjtr/oS8oYyUn+43OF8XIBPtyvgcs5oBiK2SvbCvkxadGexKCeIdXvOC+xJtHBia
	h6k+AxOfw+o/f32sGXYUCTtTpK2w/ux/MqSmhwW2wjcZjYgAslSEcM4bz8uBfihy
	QyFA8uzPRTgkgmL9cPnvSjyuMQlmU5DFkrcb/SFJqNjwzK6eQaeShLOUpJUWier3
	Tqx9fprOXwRJ413NuXfZrnIJeoWIYJI5pf9f1XyxizzaaO3NrJZJ2n2juXcSGH7s
	W6YKk3qpEli3PHXSXk2pVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734748943; x=
	1734835343; bh=DXs0odeZLPNYR3uXTvkVFrRodnrBOS/bO+7bufjfekc=; b=d
	OsI2StjW8ikYiWgp+P6zZ2e3TQa3cN6mfL+1bkgymkMSeCFkmh8Jm9V6cACRLKef
	XeiZXU5GQoZwS3A75F+Uc28VFDm1IhKproTdfY9HjTWGAxCgv2f8Xw15ZoivMf4e
	MYdStLT4kM66siqW5r+FtXn5cjbDkCHvIJxdIVLoTRwqC0pNDeeUT5+NkVeBj24K
	DIpvMYkkbw4r0qX7E6YEGt+xX56XbGmR1/kThn6NO5f/BbCuUFSJmPDFO/FWLRNN
	FUoXjNeCqgarT5iM3KjQUKUapAwEmm8tbbujW+UTwMxtOWAUHIdosiwdbWvZnimQ
	+zTYPScfzU4vil0oYnJ3g==
X-ME-Sender: <xms:DytmZ0NJLVaHx57rCONYWkETxFQfNgXBicIvhx6Fhsxf18EMEQGiRw>
    <xme:DytmZ69_1EwAlbIbCzDtFo6xuTPANaKSJQEfgbBnqdhfhVNVrZJQeP0v3nNCADfci
    uegWc83i9YBHaianw>
X-ME-Received: <xmr:DytmZ7Tv5Q8l515ovoWPBPbOdnOaz5NprMVgLNUprb9pTXQKyf3EoBDBLc_y-M3uz7eFOlRT9A7IVtL8eZdMeYn7gvs-0KICPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtfedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkefotddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpefggffgudehgeffieetgeeffefhhffgkeff
    tdefuddujeegtddvgedvvdeffeeljeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hrsgdrihhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhtihhnrdgrghhrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:DytmZ8szFrHwkD4IP_2bkKLFqbKIQV0T9IdaMb1_a1UvgE3H3O3lEQ>
    <xmx:DytmZ8czZF5r0uzcBwfnVRNgVD_5yBFvxJ3ZoIEZ_8aiEM_wl3efWg>
    <xmx:DytmZw1yiQVmaivpM4-owxf2sjH1dte1p-ZlGrchSldD1aPPYO14Iw>
    <xmx:DytmZw_PlrQzFMH1AdACVKUrUUeckeND_UiqtVVnDClOxiGbIedZeQ>
    <xmx:DytmZ76QJ4Vc9pA2WpwNs1LlKJa2ApB3FNOrtMixQTZvRrD0IfQ_cx_a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 21:42:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/3] Asciidoctor fixes for 2.48.0
In-Reply-To: <cover.1734734612.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
	message of "Sat, 21 Dec 2024 00:18:15 +0100")
References: <cover.1734734612.git.martin.agren@gmail.com>
Date: Fri, 20 Dec 2024 18:42:21 -0800
Message-ID: <xmqqzfkpdaeq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Martin Ågren <martin.agren@gmail.com> writes:

> The Asciidoctor build of the documentation regressed a bit with
> a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
> 2024-12-06).
>
> I think these issues and fixes are fairly orthogonal to the recent
> discussions beginning at [1], with fixes being discussed beginning at
> [2]. I've tested these here patches on top of that series' v1 [2]
> rebased onto a38edab7c8, as well as on top of its recent v3 [3] as
> applied on the indicated base-commit.
>
> With these patches, I can use
>
>   make USE_ASCIIDOCTOR=YesPlease doc
>
> and
>
>   ./doc-diff --asciidoctor <...> <...>
>
> with similar results as pre-a38edab7c8.
>
> On top of current master [4], these patches help, but for "doc-diff",
> the GIT_VERSION injection is still broken (as expected, that's why
> [1,2,3] exist). These here patches don't refer to doc-diff or those
> other patches [2,3] and could go in independently or on top.
>
> These patches are based on [3] applied on its indicated base-commit.
>
> [1] https://lore.kernel.org/git/20241218113324.GA594795@coredump.intra.peff.net/
>
> [2] https://lore.kernel.org/git/20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im/
>
> [3] https://lore.kernel.org/git/20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im/
>
> [4] v2.48.0-rc0-38-gff795a5c5e

Thanks.  [2][3] are something we have to have before we can tag 2.48
to have a healthy build with the usual Makefile; so is a working
Asciidoctor based documentation generation, so building your doc
toolchain fixes on top of the fixes for 'GIT-VERSION-GEN' does not
give us any practical problem.

Thanks for a fix.  Will queue.
>
> Martin
>
> Martin Ågren (3):
>   asciidoctor-extensions.rb.in: delete existing <refmiscinfo/>
>   asciidoctor-extensions.rb.in: add missing word
>   asciidoctor-extensions.rb.in: inject GIT_DATE
>
>  Documentation/asciidoctor-extensions.rb.in | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
