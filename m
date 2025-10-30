Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19378345CDE
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817940; cv=none; b=GBw+xr3Ps7NiW4lQBRbdEYsVGnTfR3ToZA5meD2rWqdmyCxyHylmbJu52idr+LipLGlqp3UgT7irIGlq+jzYaO8ZfnQb5U0YIRcojJqu4MttaccND28q2PmcdozaQ59Eg/3xtL2x3mGizrOLzeYiih5sKOrtw2b3hwNoFcYag8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817940; c=relaxed/simple;
	bh=xrcKvGBt9hIkcZz2XdXvs+3OUEl01K/Eqq4hVzHab64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acMEMTQHeuojB//BXHFp83F510URBICYsA/7Ki3zxYZQaoBnBr1eaN3iBIuRPuHsZQU37PnJYykKShSXgJdXCy98yuW3lYnqgDnLIbF5z4RKO1rYYkx6DL0iY/KwLY9JZpI2lj/hYLg+1sYuUq2w5Va2v3OL2dZ+FzeDyRfzLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R6SpAY7p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gFq4BGfS; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R6SpAY7p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gFq4BGfS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 58E84EC00C8;
	Thu, 30 Oct 2025 05:52:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 30 Oct 2025 05:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761817938; x=1761904338; bh=NOXw25KIbG
	9D5tNNXyp7wWUjAQKqzqWTNswAuMi4g5I=; b=R6SpAY7plSib9xhZ6SibL0/8RL
	pYxs4evLGaISJfiiz5zx1gT8zsQCLR8s071KLcgRJ0krYgA5/NMumjqciu8w0xcs
	rbhZszXoWuBpNEXpGNvuaWYxxhrXGkHE/XSza7qim7OKxVviqqNaVKbDo6g6gfyC
	wBfIlZFnBr7j7MwwhPEj7S26n2Bp+VIXp4DN4L4br0vFWsSCx5pKgI2oayE8/w87
	i2O4UaehxTXYOmP2hM4kN/G4qvxwkEI83B+mhSTOfYTzMLNZ1Sh62CqmcEaJ1OT8
	mh7HxCBqfffnT+eGOOua4jhrxKt6Y2WhOS5O1hMliVweEIsPLcPKeWOdyGcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761817938; x=1761904338; bh=NOXw25KIbG9D5tNNXyp7wWUjAQKqzqWTNsw
	AuMi4g5I=; b=gFq4BGfS/UTXrfDr/7IYqCsfS/2nbRitckvB3oJi3FTlrJoShGO
	tUcaatLV+/F++jmyCeIfnSs+AjSTxL2pSOfI47HjUl0SgluF97MzD0PkOLx6kEtq
	a2C/fGVat6e3sqh8PZtVFl389uoUSa6zeRaYDAhT1UxSu85/LHZ7PmaTNu6OS4LL
	y+vtgK7H0aLNK7c/LuuXFln1UMIdI7BzkFyX1W4DcVXRrQI5UJe4vBhH0kB2kNkT
	HyjA95Vsp8VDuT35fi+l3XbKnCgKFWiKOsdkJHGG3uXW1XoPbjFj8raHwXrexdgU
	is6kFVgPvP9Up66d2U/VQSPw+dLTyyDV5qQ==
X-ME-Sender: <xms:UjUDaTgxHvgNmIStkzh6F_gks1EwMYnn-A0gCbOy4lRYSZh88BRj-Q>
    <xme:UjUDaXAF4hfDSs9qQQwmS71GNe-f--6g2UVsFjYNtWksTM2J6yoIoLj_oi3Lt_RQ2
    Wn6whUm7Y65b7chAhf4aZDY7C2NbJfQUMErc2hpI4jVli5R1Adp16M>
X-ME-Received: <xmr:UjUDaYH-SM0o9GsJ_jEhvwxqsaUwu1gldycX2dD-zxE_BZhECMbJqxXgxeM7XNi1ap3NdutGYkj2Ubg_sANbjAleIqsRMhniDHTHWTqXCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UjUDafJQyFIaY7mjKMxsQcITv_kvHof6YlCzDsYAu4e_wjPk_zJNCA>
    <xmx:UjUDackYXWCMugzzpF5ulAN2NKYCbW1lXPArzp4La15-6a0VqwjyrQ>
    <xmx:UjUDaXRxyiH5gNu3HxQE3k4C3X23us-9Xn-JSCe1c-sEiZstSHX1gA>
    <xmx:UjUDaeKZ-_tlEWj_s_VzcFDFJ_l4vUIFAhO3Kc2OBv90be8GF5FS8g>
    <xmx:UjUDafnvicwl-Anvs2_MfmWYjjlepICg6Bd3Z3JySr6vFLbnqyaqCOAn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 05:52:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 77f9141e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 09:52:16 +0000 (UTC)
Date: Thu, 30 Oct 2025 10:52:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/8] builtin/pack-objects: simplify logic to find kept or
 nonlocal objects
Message-ID: <aQM1TJF97kpTygBE@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-5-1a3b82030a7a@pks.im>
 <87wm4cu462.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wm4cu462.fsf@iotcl.com>

On Thu, Oct 30, 2025 at 10:31:17AM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +		/*
> > +		 * We have already checked `last_found`, so there is no need to
> > +		 * re-check here.
> > +		 */
> > +		if (p == last_found && last_found != (void *)1)
> > +			continue;
> 
> Unrelated to the (void *)1 check, shouldn't this be in the beginning of
> the loop?

Oh, good catch. Yes, it of course should be, thanks!

Patrick
