Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90B205E00
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791566; cv=none; b=Wm6z+kZ7l6ebkcouMOQRdTiwi+v2DoojnLemPJr29DVBZzDxvtIlavrLyBpYob94W0qskk0Azg8BU/hpT4LRZ5h17rDkB955p2bGgnwewPQa6eEDATXFs6A1zSmzAh+8ahTUK6r8Wkyl5ckTP5T8KC7yjVx7FOJWzg9KAM1wjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791566; c=relaxed/simple;
	bh=TRouZSLIAMX7mwYYHMn63/QErJTFPERrPynmYMOmLKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmBI24mop2LWFxzeMIBjFDQBGr1FUuohM+0j8naNjJGce1FDXDlfToqZTbCoZOBuTqdesDiyMNF/8FppEB/iFGXnSZ31l5ZFR//qeLzrOJukPzr42VcOmZJabcROyGIQPddKFPi+EhrzaVU42BQrfoQmMYceD0wlP+o0fxGznQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qMG9yjuP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=brOX4TYE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qMG9yjuP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="brOX4TYE"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DDC1E1380767;
	Wed, 16 Apr 2025 03:44:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 03:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744789489;
	 x=1744875889; bh=EFBuVGFsmnO1l2BlBYCZoI83Rz7C2o6XiTEl7+m6zis=; b=
	qMG9yjuPUKZDUP9bkRoXqTT7Y4dtE60H2B6EbrAIYYNTaayeFcXy6Bf5BELrPwRV
	vQrnFqmqTrXGPrvYqyTa8I/H08Qz0n4HHq8uWJmqRWATxt1nC3j2KiroicPmUHWa
	KMvtBb7W8taFDB/4ZXpkPo8/qoV/gE0cbeytCYVc2w+kwaqKZPfJpRjj/zHoeil4
	nw64MZKtx6l1PQwHOol3oZYF9QQO4oBEbBxZkUOVBs32O1Og4DFVXZIPmFadvlkg
	YlDPjxZKaznRAQzmrjjzTPZw6QhNNn6fHFBJ8EQVVoxt48fqvjZ/9NClRXfUIjBM
	gMi4YCwbuyLY5AlAksqcGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744789489; x=
	1744875889; bh=EFBuVGFsmnO1l2BlBYCZoI83Rz7C2o6XiTEl7+m6zis=; b=b
	rOX4TYE9Wx05Xk43xteVUotUdqO7tn0w+UrO99o/FHWGKK6KtCLyuP3dA3XXtHAv
	66RQQ4RlcnYX8xJxonooprpYC9VueMzX1qEBWNrfPC0qmnX2wYBvqd3vJHoqfata
	S863mu3vpa2WMSBDv8klWGAMsjm2g00fNkjhWn2EKmEtsqCx+a3+zqhk3IzumhIq
	U+UiBHh7kBrvxF9p/mwUT3eHnn4PHYTm7/Zy4UVeSC7/p0apGo9m1tJdd+zvxEIR
	Pjb0JkctMdo4ig84wfWDi11Ho1nsTPK067jSUi/9IQCV2huVD2GRv92hJ/Yx1FWm
	ANsiaGrJTrE63pqXbyprg==
X-ME-Sender: <xms:8V__Z1O3HudbVEyglq8OR7fo7qv8ycrA_0Ouu9vHXdDxGu65X-P1ig>
    <xme:8V__Z3-8QkM5JIY2TeytVNBXErj-2FmsivZQEBcCMwhFNZgqeDhOBPxOvoM74CjXs
    J3OL_1hUTxPeC4Dhw>
X-ME-Received: <xmr:8V__Z0S0OHeCBuUfwVRqgpoDwYy1SEta-nNzEfscvDlmtE9fYDJav326NRmrRzstkdhiWMqfnY1E6-6uKmXL9rZMvk-Xwxm1ROVlc6j-I_g9BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetheffvddtleettdetueeukedugeettedutdeg
    ueeukeetheefueevvdeitddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8V__ZxtFrSAXod_WGRxRpvpqNNt_YDa3YReC8yzr_UfZcH5zx2-x1Q>
    <xmx:8V__Z9dyBPG1tk1KAMML0Ujd0fqyqnKD06uK-FZs_KSNo0qHrNOFvw>
    <xmx:8V__Z92rLG_v6I-nWfvWzNnbUJm9sY47MsgqC8FeJMsDtzHPpR1Nyg>
    <xmx:8V__Z59MxwDSl7Q155NpQy_1qWYiS40fmszYyUe3p6XVsr25-YLuFA>
    <xmx:8V__Z1HsH8thiNl8c0EGlVfQUCu5Awhg_FT-rI_wxyb_bLoCVfbQ3tO1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 03:44:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aa7fec48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 07:44:45 +0000 (UTC)
Date: Wed, 16 Apr 2025 09:44:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/10] Split up "object-file.c"
Message-ID: <Z_9f7DqcAjiUUXgC@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
 <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
 <CABPp-BFGeJ6eANb_5m4KSWRY_r9KCWarzya_qMkQNchKD5Q=xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFGeJ6eANb_5m4KSWRY_r9KCWarzya_qMkQNchKD5Q=xg@mail.gmail.com>

On Tue, Apr 15, 2025 at 11:41:34PM -0700, Elijah Newren wrote:
> On Tue, Apr 15, 2025 at 2:38 AM Patrick Steinhardt <ps@pks.im> wrote:
> > Changes in v3:
> >   - Rename `mkdir_in_gitdir()` to `safe_create_dir_in_gitdir()` to match
> >     naming of similar functions.
> >   - Move `safe_create_leading_directories()` et al into "path.c" instead
> >     of into "dir.c". This also requires us to start injecting a repo via
> >     parameters as "path.c" doesn't have `the_repository` available
> >     anymore.
> >   - Drop the commit that moves `index_blob_stream()` and related
> >     functions.
> >   - Expand the reasoning why we want to have cached objects per object
> >     store instead of globally.
> >   - Drop `index_blob_stream()`, which is a trivial wrapper around
> >     `index_blob_bulk_checkin()`.
> >   - Link to v2: https://lore.kernel.org/r/20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im
> 
> v3 also addressed my feedback on v1 & v2.
> 
> [...]
> > Range-diff versus v2:
> 
> I read over the range-diff and the three new patches (1, 2, & 7); this
> round looks good to me.  I particularly like the extended rationale in
> the commit message for what is now patch 9.

Thanks for your review!

Patrick
