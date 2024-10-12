Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932BC137750
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728721935; cv=none; b=a/qxG4/2GRSc92h9q/a8+Nq+etWE0LFB3R4wA+K0dghvCk/8rqKBXwyBdf1cSSgkIqIDVES4UyN+hJzLmXy9D5b8QEfKe5LOwH+71vTjMQ9qdou0y8RfG/oSShuane7t+D1W6BxSj9cEDN2fMddLNhLyYFBAHDkwI669MGH6tdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728721935; c=relaxed/simple;
	bh=t0uHj5NCD0Ae75GJlvzM/wQv9jiCj+TpeEDflRnN/ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWyMG2pSfziFZinRAwqCffNkGfM+YPczIgD6SULobEzfJYhEXTYkxoZ2RCYG+lPhG8+SV+3IDu/vDV8/Use0YjhbOSK3nGkYDHK5sDaJdO1BMga9ZXcL8qdyG85FcWdGmI47IMeq0cws1N7YrMJ0OvTTHO7YtIZlB3wUTfMX6Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a51ind9I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UFHw3C/j; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a51ind9I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UFHw3C/j"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 725B513806EA;
	Sat, 12 Oct 2024 04:32:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 12 Oct 2024 04:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728721932; x=1728808332; bh=0U2y/Be4sW
	O2DsCpqQN9W9cmNwdRIaIH0q0Xivm5Dls=; b=a51ind9IxX7oo5ct+c0aFp8opr
	r/1GV5mO27JVngETY12bYUGoXExA8FIpAgY2Hkqe1azCljv6u4MKr0AOsZsI72J4
	SQ6gManaGshFu2zMXQiEIUD/nKE9l7LqlN3ITpprEEhFbdYlOy48NQjZi0FxkmH8
	9fuUYjC80WIBduGVMOuGFEgC+cgY3Z6+LUkoi9FiXDMMVLyeuhiR3zPrAj0iD5jO
	PHaD4e7FaQQj+OkTkDEu09WW8yzKSQ2nzdM4kYxqQhg1n/KeA1bwlyPy+w8vm2lV
	vkNplQgg/4vOj/TyTDQXcTy3lhQmFIuEX1u1OXB7s6RdvnOWKk1kcEQAh/Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728721932; x=1728808332; bh=0U2y/Be4sWO2DsCpqQN9W9cmNwdR
	IaIH0q0Xivm5Dls=; b=UFHw3C/j4D2/5LSd11Jw1r4vUm+aUBZkzdmoZ8oMfwUZ
	mAN8whIaol/wdECORhzAU4FfITGfVLgmYqaTbj5Oid8IFobpkPtup0K6L7CMvzxv
	rY43GNP/ZoIeJ+6HfTekcdO+HEOZE03gSVmEy10fh7aphescV3q4uaY3lp5ZhMmB
	SgeV873s9pJNiSUWaE8XSRgzrZMzzYaOF7bfxHVa6ygY94T0nAztFpeGERwVOOKa
	/3oe4hsXZgQ3d6wnhpVUQMleq6sx0rbNLhPDyzkQOKncGRSQ7rztJc37OMwdLe3+
	soSoOMh8yjb/qXb6i75GsabSb+4yplVvotwiCoBfqQ==
X-ME-Sender: <xms:DDQKZ0bLWkIxGUYQWtPO4mBY1jKuVbIVMYU81cf6NmdZVz6WmngjeQ>
    <xme:DDQKZ_aMxzPSpPQDUMu6HRN76BG3yTSoVhVBvAskTAWsdnANA4DNTTmg1lSbpZJV6
    _34bnf3oeeVTllPGQ>
X-ME-Received: <xmr:DDQKZ-9gxJIV5Cmb7HBIQWe2PeFL1PJqetc1lduktx44bTe2MhonWZmWEFoIfPMbzxGB6jlIff-e0fN1cyjZsxy-f_wSDVJIMCz2xIdNT22d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeguddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhgt
    vgesfhgvrhguihhnrghnugihrdgtohhm
X-ME-Proxy: <xmx:DDQKZ-pr688I9Kca6gSeyIF3UFcm7nxEgfhO4ECpd5JDUssflDdYkg>
    <xmx:DDQKZ_ryLK7B9gVBH2_CC_Vd4yEfmM6wkH3VMXjmun6Hzqn8-knDdg>
    <xmx:DDQKZ8SsztbvW2HBV1IINyu-6AcpproN0814BFMnfbiZkSkNKTx8uw>
    <xmx:DDQKZ_o4hdTFm4A1yCiQsa1Pdr5GirwjvrUD9aSYuaMGbF2w4KV0Uw>
    <xmx:DDQKZ-Vm7qeK-ELh7HzgY-L2iY-vLayZjmUHVrpv1A1AsxT4es611d_M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 04:32:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b530eab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 12 Oct 2024 08:31:00 +0000 (UTC)
Date: Sat, 12 Oct 2024 10:32:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/README: add missing value for
 GIT_TEST_DEFAULT_REF_FORMAT
Message-ID: <Zwo0BYYBt1sU1jqw@pks.im>
References: <20241011191150.825255-1-bence@ferdinandy.com>
 <xmqqjzeecp8m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzeecp8m.fsf@gitster.g>

On Fri, Oct 11, 2024 at 02:18:49PM -0700, Junio C Hamano wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
> 
> > The documentation only lists "files" as a possible value, but
> > "reftable" is also valid.
> 
> Makes sense.  Will queue.  Thanks.

Indeed. Thanks for plugging this gap!

Patrick
