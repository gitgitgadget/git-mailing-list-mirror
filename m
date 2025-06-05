Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F5275118
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142572; cv=none; b=fQPWM857mLgtewC4eJ+p1tphtxayjROH1HjajhcPvJTckYkL2MmpPvGyq92yM2bwFH8UXrlwqAbSZWeqmEZzrgBxzca4sViY6kcdPAI0pLFYi6qFirCEGR4rbHxreIeRfO1SjHuP19XVZyYYYP5lvoba4+gFe1WB68Fgquqtozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142572; c=relaxed/simple;
	bh=grPKw2wGXYdDmnRLqbcYIKKQZX2Cpcxm1jKO5UwtHIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kMsZISzB4fLiicPg/ZnncpBr/IIIy6A15mMkXKWlvXkYSPHVRgaNsTX/zCJy7GvCIdL+vOaeeGOY8tQWP/XGq1WcfigkEq3GIhDRuTBIia6+J1Z9YnEmxCemdjFbt6gvOkZZQgOjLoknuCaoeDsTAQz/Bi4QsgTmBZVEeOTwrkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aDezc4ky; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQbkWPpr; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aDezc4ky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQbkWPpr"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E9922540123;
	Thu,  5 Jun 2025 12:56:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 05 Jun 2025 12:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749142568; x=1749228968; bh=grPKw2wGXY
	dDmnRLqbcYIKKQZX2Cpcxm1jKO5UwtHIw=; b=aDezc4kyJibyPS73UixgQRKHUh
	DE/C8KpLQRgNvAaz2CCcprD/R7A2oKlQKn1WBhyVsstX1r0Z45vcRcpFp3e3e5Ok
	WeUMoYFBkoiCWunPweF11Yz5PJvSnhj0TpNCdjZq4xsbH2nEvvhCeoT/dWzAP5ZX
	BqfcDYM323CyvOBnKPKRGmgpNT3U4VHVIbSZoENpNjB06j2mHYCKJkoc+58Tokux
	SJpiVtZBWVwIUDKuRdxAegfMVcovMqq2QVDBi+KGHoJYE0JRMkQbAJ+de3h40IhN
	nbcM+saf+PX+QsPZsy9b6b3FxjH+TderAfMyqYyOYag6h3T/Xa63CJp/rkNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749142568; x=1749228968; bh=grPKw2wGXYdDmnRLqbcYIKKQZX2Cpcxm1jK
	O5UwtHIw=; b=QQbkWPpra0zqyUlnbEFhv518BcS0fZsys8hSBfb/OiVJh7Rl9+V
	ruZCayYjpPqqiaWh5GTiGTjfRXT02tB3tI9t+OSxQz7iR78nt1wYIs+NppNxtlmB
	bwftKlEayDJBSrL8UHMBXexHUOiE9s59+a+rkeDsO0QKC6ncABPVck9CaDA3x+JC
	6+NRwWoFCC+nABbesHj6wg8wcagxCeTXQhJpYEDrngDXXUhr0/uHT+iOLGLp7AgE
	tCVZEIKHXFgF0D3/EbmMMiZi7qjM7nOv0TktrdtrQb8ZLkpY6UjXpK1mlp21MuFP
	U04oJxWAvR9MvwZO+xbZRN5PU0aZx0uLfOg==
X-ME-Sender: <xms:KMxBaOLZJG4EImeQZ3bRJ7HKuDI34cXHb-D6weIP3WKBIccV9AULwA>
    <xme:KMxBaGLtvyF9_f5HjUwxdAKhIKwCF3ESjj5j-rxaIf4tk8wxRLGT11Eaw-Og4rSzQ
    0a5qFafGs61_Q3mtg>
X-ME-Received: <xmr:KMxBaOt2tpd1ingbVm2uDXOWeAsxzyaozZSITDxJNNzC8Cfgp5C2IlJ_rCi5CJT3RWbMCFuwJ_PX5x4HmRd4WGXXw-opveoHGsJa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:KMxBaDYwDzex6oVe4CN9GPOqz0TsfE1YvjXcGwvVZ_Y_yzGXXSQCjg>
    <xmx:KMxBaFbP05i4yLU9c5QbkYNUqzPckMtJD1tcglhLBFODKvjyzI-07w>
    <xmx:KMxBaPAnpZaQ2rZ_PKPpQZ-blP-tJGlPIYJsXHgmBrvAM6Of2gRukg>
    <xmx:KMxBaLYyEeqMC4w8-sN4I311v96qkJU5UlBIV811v2erSVpYtwphjA>
    <xmx:KMxBaJwSiy-POm52EPusMC2f2RlTIZrZkU9EcFJa5wgk0PsSmhZ38Cx3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 12:56:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/10] t/unit-tests: finalize migration of
 reftable-related tests
In-Reply-To: <aEGaqZU2FdLqL79L@pks.im> (Patrick Steinhardt's message of "Thu,
	5 Jun 2025 15:24:57 +0200")
References: <20250602122559.208780-1-kuforiji98@gmail.com>
	<20250602122559.208780-11-kuforiji98@gmail.com>
	<aD793WJpsHm3d3Q8@pks.im>
	<CAGedMtdaDR1E9YWXQOQKKtKj7rgjmRy6cLMC+A+7B39r=u5Amg@mail.gmail.com>
	<aEGaqZU2FdLqL79L@pks.im>
Date: Thu, 05 Jun 2025 09:56:06 -0700
Message-ID: <xmqqplfi86vt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I don't think we can just yet, as `t/helper/test-example-tap` imports
>> the `test-lib.h.h` header file. Fixing that would be beyond the scope
>> of this patch series, don't you think?
>
> Yup, agreed. It may be useful to point out this detail in the commit
> message.

Excellent suggestion.
Thanks.
