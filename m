Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986AE1426C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516190; cv=none; b=pJD3xa/KQiw8XhdfwQPadvLoynlyAjR/o7SZeRTRUpDmXsvD7txnOIbPn62ACwZ/I4HMwF9Cmewstu6m87z4ja0l+3R8PCGq98RFGsqoWmdFkOqr5seXMbrNTJbKcPKF4xBbumboC81Zym7x5LqqzwtjkG9GAQDO0OX2RH/R8TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516190; c=relaxed/simple;
	bh=ktnw6QOeB9KX1oNHLGEWhuIuq1gqjdi094yDgZHMnVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiYcpMWrl/sPBcPSlqnBgss526JxqBs/wRMQB394fU5VFN9p/l7fuwdzOknkkNBF7O36CDvsqC5MZSdVwpSRgc0/7OLbBIfs886fuDrbJZpHE/L02dtEmmRExFWDpL7APVXCzH172NltTSBNVoWIff1d9VEKa/aRC45gRzzzuVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YIlBgLTt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZG3vffuU; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YIlBgLTt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZG3vffuU"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A35AD1140126;
	Mon, 25 Nov 2024 01:29:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 01:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732516187; x=1732602587; bh=AcM9I2TLRu
	VwIn9a1PoQA2fwsLpQ7Kips1U6edppUAE=; b=YIlBgLTt0PwrQmF8ddwDj5egSQ
	MTVI7g/fecVD6i4MAO+9gZl+vhYO+zzzFlsa6zbnTVWwrTAxnkgkradQRFExrU1L
	qb80PM9LJA+O/+uSorJ7lYMn40oPSSCXEx87FiXunSMMuOZ2gZd1sp44Vc2z2UVe
	gcCFgUIvwJIf96rdYiNeO1jpmMJQF7F0gpdRJefT6KYV00FlKX5X0O+pRmIvxv42
	60TnBS3qsqKeklSW/85r+Hf7Bh6Lwp9VZZubmeI46/Zewfg5naktEf5IfhwgXPgM
	DuY+eZ9ZfJjcMaVtUdvLjMaKE8aHPR0tGddRmfzajRaW2yeyQnGnsQtf5qHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732516187; x=1732602587; bh=AcM9I2TLRuVwIn9a1PoQA2fwsLpQ7Kips1U
	6edppUAE=; b=ZG3vffuUgfyWqQ3y447CpHvXVtGDniKbPD3XDe3qf2QZxFv0s9n
	qhUGMGLt2xwmkXyiVzoKZ6IeErqI29AWOg9ydXEb8iXUAtrT5ZQmIYTNiRQLPN16
	YeehiIQGOLVgxI46W/NmEFTupQ79x44rqLQF78K0RIABqIS0PJkxy3KJ+6I3QcxJ
	FFi8sEe5nMPQQ06MevegQjGONfJVVm57hynpKA4Xkh2l8IC2b48Nk8uiZnmFkzZB
	SEjvJkc4yeQ97tJVZL1anNYmfu1tddWCcfkf+GPuAXZQqEzFi6gvMSSfdT8ZrF+O
	2cKF9U+oUrdH4kOJVi9iCO4GyfoWmF4IqZg==
X-ME-Sender: <xms:WxlEZytqQhc7DYnD_OUSnAG3ySnPJlQkAW7EugKfI8UZpXENbi2mkA>
    <xme:WxlEZ3fyQwTmoS6IWNdgz5SfXTYN3R9-_UvtOvRYoxncMeGdtjyb-0fmKlmqAthvR
    Q2d4bUUQU-4cAxNMg>
X-ME-Received: <xmr:WxlEZ9x-2YuSxbtlNkBWzVWm6X3pPGARl0xN-R4dv1ORryn3jxKHcogDMZWX-3oIkZy8Vjt2BndqUgs-rjjf-B05IxMwFo7dViHu4R79ywPjww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpkhhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepudejvdefieehveeigffgtdeitdekgfdvleeftefgkeev
    tdetjeeiueduhfdvheejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpkhhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
    hhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:WxlEZ9MXSPMVoNojqX0BV6ORwXb1m2N6R_mPFFzqfBSzKPU-rhUzyw>
    <xmx:WxlEZy974YcHic593iwJnVb5JayG5745G5mzfIdt0bGcqylBPvNsRA>
    <xmx:WxlEZ1VJ6EEJ0P-f_SWFskyErIB-eL9CGk8LnVZriiwxvFrFduzVfA>
    <xmx:WxlEZ7cow4Q5xVNzoJ9bVynZ1zKW5DxiYly-J2GaNDByi6enbFEdCA>
    <xmx:WxlEZ5lw53vGUQQCcLasE2ZqI_omyAN2x5pHaCzD2jo6fy0qFBqQPa9e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 01:29:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 012f6e53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 06:28:44 +0000 (UTC)
Date: Mon, 25 Nov 2024 07:29:33 +0100
From: Patrick Steinhardt <pks@pks.im>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 00/10] refs: optimize ref format migrations
Message-ID: <Z0QZTc79otZPn4aa@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
 <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>

On Mon, Nov 25, 2024 at 07:27:05AM +0100, Patrick Steinhardt wrote:
> Changes in v3:
> 
>   - Mention that we store the ref transaction flag for access by the
>     backend in the first commit message.
>   - Fix a missing word in another commit message.
>   - Use `unsigned int` to pass `initial_transaction` flag.
>   - Rename the scratch buffers and provide a comment for why they exist.
>   - Link to v2: https://lore.kernel.org/r/20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im

Oh, I just saw that the merge to 'next' has crossed with v3 of this
series. Not much of an issue, these were all cosmetic changes anyway. I
can send these in a follow-up series.

Patrick
