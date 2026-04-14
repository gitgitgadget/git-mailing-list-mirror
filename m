Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B437E2F3
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151410; cv=none; b=tBm3frHZdXCN8hLskSzKjMs8IxZNtQS1FVLOg9c4YMKVpjHZnVQKiELPs3VxEIzjpjyCPiAdKhRt87tQylYJjSKrBmXcy7eybbFLOZ9dALL+RT2XMIqtJELgwqsqQUggeW0vEBhxvvFj1sjzBM46ZICt9U2yZim/KpKDP2AXJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151410; c=relaxed/simple;
	bh=uygzqwJRF+Wfvv0Wuiz4CSoOzL9y7bJn3r/UMUpnFLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uljYfPHLWm4whqRcoW3nTKgMo3M+c/u58mLkvTqROb+QCRQJzOJY6A+HDjkMixxuaOaBM2xjlfz5uQrjAY36+gCjG1i1mGvbaISGvNfdb3b90xIlaDhNjHZEg/KoQ2NZEdF0vT7CtvLIO1qVAw6eqQCVDt0F6HPnWP7263Lo/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hcQ4IU8G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iKRXeWtT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hcQ4IU8G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKRXeWtT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A6D17A00AB;
	Tue, 14 Apr 2026 03:23:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 14 Apr 2026 03:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776151402; x=1776237802; bh=d6c8970/AL
	mg8XEHc8PhtT/+HXIRG+ouCBrEPEHZV5w=; b=hcQ4IU8GP1N2kbnF3Vn6BkqytV
	pWiij5zScRncu6XHtlD1XuKTDJtXo7fm2VdfxYOyMCrdxo/aoIfCk/bd9B6TgIz/
	KF6cqbUZHW+wWYsbdZGsh/4RbpHN2KcVncHdFrr6TXijh+Psg1MdTh3ncelTudT0
	7f0v+qooqWGzyIts/hVePZtrkWMrKZp91jmW7v/XSHRVJB1glcFT5RgPTe5Cs/lx
	/lSgtbQT0UeHW4+Met3vvpGMgP+wbIk066si8Su1X50TiJ3u1U7MhO0hXzxjUvLw
	lxuAChfEdzYFV5ViIeWscKaqAHEbQd6zwy/AQAGFlQ3mkbj6QgyDm9vJUB3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776151402; x=1776237802; bh=d6c8970/ALmg8XEHc8PhtT/+HXIRG+ouCBr
	EPEHZV5w=; b=iKRXeWtTP1E2odpHKoqcTNcHSykVSx0CT/zLqiFYb+K+Rb7YC1K
	aFODcKyZ1fndGtjcpfBOQkbPH7OTy35u3UF8RNuBfD/O/rn8YBORu8JxCTnaZhSZ
	7BG6YdkQksJAqSf8hC1TbLALlDMKEo03tuPCVHZZDXzqKmzSFuvOKE0urKZCRlN8
	nhI89/EfqofKP+Gw47fujOAPmBuuIryt31/ogY/7E7gq1yF25i90KDENzHCZ0TsP
	nZx4dwLlphDjqPR42Dh5ItVXMaiI0r+efinonxBR6bL5DYRN1ZKK4eTrePTSjIns
	lH5zTIsRDPdIbDoX5KIx8FtQncQnCJqaq7w==
X-ME-Sender: <xms:auvdaarUDgoqCETtylFXEtHVwFkQJQqTGGqQ7sUwM_eAav7FYpksEA>
    <xme:auvdaernrOzCLiQuShF0ysIAMO5DTdfi2j1wA9m7gswKQ9GARQ5POlnT6n-DhKq3R
    qXfSYyJQmCOUZk6Qci2mdFNavs-l40bPC9nV9USaXr2sR1bdmny>
X-ME-Received: <xmr:auvdac3w-wm4GRVThRpjQHf64qIi09GBEjHwmE4KNSM2O6LqBPyMvKkp-xIaXSzzl-TtPW2cOyG0RLuCBq6wkq26I7VRHgNKiWwm73H6KpZBVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegtdehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:auvdaVD-c4Uk45LCGOHihR8zjWnQsun62axMGQCeyUU5XW4uiVm8XA>
    <xmx:auvdacelZcTBwb1Ox2teXO_U5FxVfoaB0VK25I1KnMEq7dSbWhI37A>
    <xmx:auvdaShLRPUkM0wlvXJ2mPed1C3ROtO_7VsW3uqzToihOsF4iNMMnA>
    <xmx:auvdacqiDp5zsN7I721en5bcT-zRGlBpggc5uAgmvkUUR8yiTLyu1Q>
    <xmx:auvdaeB_zeVIczWmRg6hpzl7acMYK4MVK3kBFEq8Y6GLgMof74DYF6js>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 03:23:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 93277c86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Apr 2026 07:23:22 +0000 (UTC)
Date: Tue, 14 Apr 2026 09:23:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/12] t0008: silence error in subshell when using `grep
 -v`
Message-ID: <ad3rZoZ0VaOcAAzS@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-8-5b83763a0e84@pks.im>
 <xmqqjyuaixcv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyuaixcv.fsf@gitster.g>

On Mon, Apr 13, 2026 at 10:28:00AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In t0008 we use `grep -v` in a subshell, but expect that this command
> > will sometimes not match anything. This would cause grep(1) to return an
> > error code, but given that we don't run with `set -e` we swallow this
> > error.
> >
> > We're about to enable `set -e`. Prepare for this by ignoring any errors.
> 
> It is curious that true is explicitly spelled out, unlike the
> earlier steps in the series that used ":" in "|| :".

That's fair. Will adapt.

Patrick
