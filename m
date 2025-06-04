Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077D1FECBD
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022141; cv=none; b=oMWg8MsWRzQgMtQ9vwhgIwZqsChn34cNCzBURgbXjY2a8J/lg9X+3Gim82iPhIvqQSaqXI8zWSIR8z/JrnDKFjMWelwHVe+rrIxgTJgS1pSpTvazICaugKzrGlL1fR+wfmeC+Uvz2NRDleXH7HclnqmKGauRW6FkJ25/zjO1XVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022141; c=relaxed/simple;
	bh=nlh85euDA7Brw6Bllwv+4z+3fb5qD1WJNHUI0xRCdIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcjwTeNqAC1oDcyH9+E0LlkRnRvhJSHKchnOWc0AHx1wPPiakUZ/8KdQfZV5nfPajsGyP/oGxUE9G914eRbDgbQ1KDzc8E8/U0/AI/ygZAEIky0Et+YQjy5NAW2f2KJUAwoP636s1ZnAJxMfPaj4OCw0DsDRGhThgItdhGmDStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A5GFA5kc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pguc1HdQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A5GFA5kc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pguc1HdQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EABE511401D8;
	Wed,  4 Jun 2025 03:28:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 04 Jun 2025 03:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749022136;
	 x=1749108536; bh=42OXwLPvjHVFE9+Qtu2FZqSJQbRSpMxfIXhFWM3fXk4=; b=
	A5GFA5kcMbatr59W3x4ra9XCWY5deCRYTeTbLPOQap2tiNFOMvYKyenO05jTWNGj
	PsY9AUtrU8wb7VHM9nHHylG8x3lZ5SFQw8YizOFujs54SKs0XKTOgDCWU43xTXmV
	rbfHG+JVHw+WGnn8tTjUGzPayl6qK5nuw156OoIViMIX3pCYaNTl82udxiP8NXVG
	IpMVoyoPTdB5PTejrPNxzPpLO6MJ5dr1hBBGvOub5Dgc6jXyhbwW9Zr+Tdv6qEgW
	pdH/BQdZrvdkRfrSQQs8kGKjVXxrnGQ+l5Sq/LfoDVgKAJ7T1AXuBkyzue10SeeF
	dBnqq2lw+fB5pDnCO8bgtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749022136; x=
	1749108536; bh=42OXwLPvjHVFE9+Qtu2FZqSJQbRSpMxfIXhFWM3fXk4=; b=p
	guc1HdQHJAm9+gJ84yLnXPdhQ7Jbg0UxrDDDVf44BpbFP40/7YSpDIJz51BKJOzV
	8JQRSG+TZ0eSss+aOg9vwiWkZ4fhMM+Al+e2vS+a9cF50fKP+9PlfIXHnS1o2DHc
	tC1wwPffn3xDy284AGKuWzxXKYaIPnKD3DxcVFC6Wczt/tQ2fW5q5huS7EkOkOOI
	5VU3tXmYYi7zpTLgEE2Hp0RJLPAexsE4fTQc5ZgO7wjTen0HMvmwebkVwFnTS7uY
	naD4uq09f2x5bS4XzFu0T7cI2y9ag5Bphe7MfdsEbLwSZE53zb2uMp36aMphHfXl
	tUX1H7BpCSzaCQVsh+P1Q==
X-ME-Sender: <xms:uPU_aMeprkFa54wYcv-Y359Ww_o4hRF4pL7w8Cto2UJEYHEB93I7QQ>
    <xme:uPU_aOMvUUE03WX9D9uKf8xnT8i8hF7YJB3ttQFc1IUvcpHV9XFsF-eiZS4NLIURX
    Kg0yhqjIsTySOH-_g>
X-ME-Received: <xmr:uPU_aNitO7eQgSd9_nx6jXa6De9OXOTvV8XCcOlsxDL_W8E5wFt9Nz9n3ewSoWlhVO9En-9GnkVlSr7sWMBJvLppSm0Rm_X2smR333JhksLH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtph
    htthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:uPU_aB-BnHo5wA1ocIfwvYCTA1yDbsBUtMMeB5oTzXmXMEMFjZnihw>
    <xmx:uPU_aIuYfPdsSbDMStIyIZMt7a4OUJKY4YYoVel5IYkOITMtVU7dCA>
    <xmx:uPU_aIFxJPwWv0jKni36pyph70zqb4QnW_fV1QyTlu2sAGxUiZC_LA>
    <xmx:uPU_aHPLBw1lnW1oz5fzXUBqQXqQWLCXZncX2_t5u2hNAYSBYmWJfw>
    <xmx:uPU_aH2VNXchgsYFFm5R0ylVOtc5tACGvEyp_xTX7IZ3NpVxeR1BkIks>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 03:28:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 73a55526 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 4 Jun 2025 07:28:53 +0000 (UTC)
Date: Wed, 4 Jun 2025 09:28:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com, shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH] environment: move access to "core.sparsecheckout"
 into repo_settings
Message-ID: <aD_1tD-H74SOh1Xx@pks.im>
References: <CAE7as+Y0hzkPUC-q7dd-eSJVi0H_nwzQL1AGZJnKMyYcrX1dLw@mail.gmail.com>
 <4F074544-4E25-472D-A42C-C50A1E1CAC69@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F074544-4E25-472D-A42C-C50A1E1CAC69@gmail.com>

On Tue, Jun 03, 2025 at 10:20:38PM -0400, Ben Knoble wrote:
> > Le 3 juin 2025 à 12:21, Ayush Chandekar <ayu.chandekar@gmail.com> a écrit :
> >>> +{
> >>> +     return repo->settings.core_apply_sparse_checkout;
> >>> +}
> >>> +
> >>> +void repo_settings_set_apply_sparse_checkout(struct repository *repo, int value)
> >>> +{
> >>> +     repo->settings.core_apply_sparse_checkout = value;
> >>> +}
> >> Getters and setters only really help in the case where they actually
> >> provide a benefit. These don't though, so it's dubious whether we should
> >> have them.
> 
> My thoughts exactly; see below.
> 
> >> Also, shouldn't these functions call `prepare_repo_settings()`?
> >> Otherwise we cannot guarantee that those settings have already been
> >> parsed at all. And for the setter it could happen that the settings get
> >> overwritten by the next caller of `prepare_repo_settings()`.
> > 
> > Oh, yeah, you're right. So, if we use `prepare_repo_settings()` in
> > them, wouldn't
> > it be better to use getter and setter functions? Otherwise, I'd have to call
> > `prepare_repo_settings()` everywhere I'm using the setting.
> 
> Aren’t most of the consumers builtins? And from a recent look, don’t
> they (all?) initialize the repo settings? I agree it is relatively
> painful to require developers to make sure that prepare_repo_settings
> has been called on each (new) code path that reads this variable, but
> OTOH I would expect that to be a straightforward audit during this
> change and then (see following) relatively easy to catch going
> forward. Is already a code convention that reading things in
> repo->settings depends on having prepared them?

Yes, it is a code convention. We have two patterns though:

  - Those that access the repo settings fields directly _always_ call
    `prepare_repo_settings()` manually beforehand.

  - Those that use a getter/setter rely on those to call
    `prepare_repo_settings()`.

So if you add the call to `prepare_repo_settings()` the getter and
setter do provide additional value. So in that case it may be sensible
to retain them indeed.

Patrick
