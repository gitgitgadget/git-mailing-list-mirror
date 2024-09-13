Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F77E782
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726196926; cv=none; b=Pt4ZZ43Ai4Y4m3COl2SlFHeAVmeOwkIQ/M1IbvcRnvl4VN5IUVHON1fx0CcfIDRmG6L3eJQ3kY/sWQITzm7cgz5kFegaHvBTasNhto4uQWfMHP6+JutHQNuMcJqoSHMB1Kj2I5cdWUHO8oXDv1Va/qJ81ithPvsrtap+SQRbZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726196926; c=relaxed/simple;
	bh=P6TNuKYsh27UPR/aHDvGLOZEzOQqDkeXseJltdDS4F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKnCsUL1D7J05exknoYXjcp9vBqSdKtYBqbba1mc58ZHktmYliv4ARaikUJxu8FqvBfLlRVEdu9v6EQtFP3zGV8WDrj/CEiMQ6IqPerUzFhWF6NGtOCwm9nKSkgWrvvrPWbNkMeqTV3Z2hDW9VZeMkldSZXBkhFFytMzG8D6ISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yjccz9Vu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S1X5OdVw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yjccz9Vu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S1X5OdVw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F1031380271;
	Thu, 12 Sep 2024 23:08:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 12 Sep 2024 23:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726196922; x=1726283322; bh=ihVkxFQSIP
	JfZ2TS+PBUkG4jrtvbUsX6HUcoMd8Oy4w=; b=Yjccz9VuEuCJYdXgA6yg6WtBCm
	mEm2h3DpFHDJQK+atG7IYczpSQh3ALPBxoUoR8YmJ3EskZeZPsxAI9HHmIOuGPmQ
	T9heamMcJWG7ECx00D1EzfGlrhEAIH1rn4d4gVkykIxFiyW2IcHpi6hrFGWoQM58
	budXj+48C/5DW9b1lQKRHZOCUr5/yZjmO82mRSo/YdjZ4J/Kt9bS0OM/j3sZNIWD
	HrRfr+JHhDKuLGv0c4U/8MsoK2BKtmGsWAPkdUaE0Aa/TIEBdXYNxjArKaC/U0RE
	7WnBuDN72D6k3oXLUWkBu26PAbBcp3oirBskuODba9ug5PPsgmE5e7dRhT3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726196922; x=1726283322; bh=ihVkxFQSIPJfZ2TS+PBUkG4jrtvb
	UsX6HUcoMd8Oy4w=; b=S1X5OdVwJW8q4rxok8E8cmfFH1NHpj6HGqoJH18Gico2
	NQcp4MJfag7KWfm1HQ25rBMW0I5P9albP6uKUY6FV8IChESeC4SbLRHLEt2mPBt0
	wYNwLxiLNeO3w1Nsy9hycOQSNuhWPK83RLx/30cMIAHlF9aIKaHlITv/GjDIgQAP
	XQKPvKLhc2+tdFX/hCUFylSOwsLcC79MN1vjO4CywV11wnKzZ5Xk+6VldvrVcxiz
	Bo5JkF15tzHCzB4aEJJ7JWrOF4jf+7JS5K8yBFuN/tllhkZfRfEGm8wIRoNrDleY
	nsANOF2BipndO4KpdBIdVk0ABQCzk/M6glBMxzYleQ==
X-ME-Sender: <xms:uazjZj-zRupee0ucgg_H18ftMg_SQUSWy55_SaZ7TNDIol28saJqAA>
    <xme:uazjZvsHL22NzSPxEqJBXK9ZbHVMvGlCukJd-J3x3jCkWy3Xc57Z4paBw-SzQgNxV
    IjW4E4kd6iIrxkyIA>
X-ME-Received: <xmr:uazjZhBA9rpnNC0F1CLY3BXsM7G33zWJikLDgvnbmxflc7fFAATJ9HQhDozZyF7nA6YVRCLvUPzsq6BQXa4fZD1bH9_ObmUcvBuSYSR0IhX6ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejhedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjhh
    gtrghrlhdtkedugeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uazjZvcSCwwax6GnL9nvSN_sNYIpN4cN12-8h4M3mkLj3dr431y9nQ>
    <xmx:uazjZoPBuP3WsrFcoWwSQV-aIjQD5H01ct4pZt5coxoSCdhVoD8K7Q>
    <xmx:uazjZhmzMIX9VusGo3AQ3_kk_hpxP0SIh5iFhP92m7jh4XqMvLmWbw>
    <xmx:uazjZitJTrJPVYJ7TMqH3GOge7Wns7e_Zsumm2vunafOzwHqGSof5A>
    <xmx:uqzjZn3CJnVhfv6fb6DgKHSb6w-CCM52EGHKutltcCUpJmXGi_ENrU-V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 23:08:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0088f93a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 03:08:28 +0000 (UTC)
Date: Fri, 13 Sep 2024 05:08:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Han Jiang <jhcarl0814@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/4] remote: print an error if refspec cannot be removed
Message-ID: <ZuOsr8k0JapOx0gf@pks.im>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
 <a8dfe403d0683aec4265bf920921e45d5b59cec3.1726067917.git.gitgitgadget@gmail.com>
 <xmqqseu56hhb.fsf@gitster.g>
 <ZuK8yihccDjgQGZV@pks.im>
 <xmqqplp84zbe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplp84zbe.fsf@gitster.g>

On Thu, Sep 12, 2024 at 09:22:13AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I don't think we want to return the error code from `error()`, do we?
> > `set_branches()` is wired up as a subcommand, so we'd ultimately do
> > `exit(-1)` instead of `exit(1)` if we returned the `error()` code here.
> 
> Hmph, I thought there was somebody doing !! to canonicalize the
> return value to exit status in the call chain.
> 
> 	... goes and looks again ...
> 
> After finding the subcommand in fn, cmd_remote() ends with
> 
> 	if (fn) {
> 		return !!fn(argc, argv, prefix);
> 	} else {
> 		...
> 		return !!show_all();
> 	}

Ah, never mind in that case. I didn't look far enough indeed. Thanks for
correcting my claim!

Patrick
