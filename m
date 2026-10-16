Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02865368D74
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164841; cv=none; b=hVJdeya5BSHcb6BH3DQDAdl8dc+0ALanHELazv1WBdf/bcdQNMlgG+uMv9NR3Y25iYFn5M138u94ArVox4G9bEx0C3s6vGFMAtyBCvo/8MNTD5eYVBGSSD0cXTyqCliJTc9Abp5nuT7ZX0/jRHdtVZB11FXE3y03fvs4TcH1Na8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164841; c=relaxed/simple;
	bh=J4cYaYDrffjtjcFXUycv8077uZqCPWWp4+rCQPqcn/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dPNElCRWEIpTbX+5hjtC56SgNRHEJu9pJwg509qdAytnBaBo+wXyC2rwK39CCkZ390aSgL7uTKsy1zyVSWGHFoBF1uKRm8tum+P775wOhozy1MxS75wWZgtgiLyruMEPUo1mVkqjyIrQ+2xY4aSollZ0LmlknVi8Jc/MBCUubiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h1jvYO5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L302SE6w; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h1jvYO5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L302SE6w"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 463F3EC01FB
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:33:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 16 Oct 2026 11:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792164839; x=1792251239; bh=JznBQ44f7B
	tWL2Bl4zUuER3pofwSNMrryE9naT7xYNQ=; b=h1jvYO5kUR1QAsUqtnWYZCeP4h
	eXwb/SmSxpGYZ6SzEQIDuIUWK5EQJORfzydn7fKcA0wL9Vu106cX+xkGt2FCFKcA
	rjcmpSkxLS/u1pCmJbYHKc8g3rh9HhZ+NdIVmL0zw1W6OrfeQFssFLCa4zASY5Tx
	Kex/Uq5uW2E2P81UWkJ9HNVPUKwVKz5Vqj+MRXveshsmpbEFJ8JvJZcxnsaU6QRc
	VXxMFnyYxvq/9no/ZwMo+ECUwiRwQRtNdCODudRYPengQohhPXAY5WQbuGzU8zjG
	DcxY4V07ba/OYcODDkCBOzLsHw5E8VJcLB+Uri5TtbET74yVQHGGf+qEAi5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792164839; x=1792251239; bh=JznBQ44f7BtWL2Bl4zUuER3pofwSNMrryE9
	naT7xYNQ=; b=L302SE6wx2Dy4Z30gMZ4ljuVb8XaC6KVXGQXHhPBxjiLoLH0qoh
	KQE9sKkFmEShGXRH7ber00L9VPVJtuiCh4J+JFStWOSl/f1cRfTy8BLfdumk3ZN8
	g28Hu7xOTtpxeXVgdRVm1Slv6xQfeOMWek4sN6r1noiefUi8N/6uXHo0ma/XjccN
	S8y+F4CFug8XiswD19wGRF4mt8V5B78PjeVCW/ToOxnXI/vO+L7MGLv+h5wB/bZg
	BHfa4dHwu8+V9OOLBN6wKYvHFyqDmHl8TMWGmjcVUahH5PEpg03O0f6Vx+o8Bo/+
	PgFIirEi4hkfDXxcaMx/3QuyJ18os0NcaHA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792164839; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KBPjwy85XCoi9p8IJ7OVS/+0wzQgZM5bBI2RtQ/jsFtFI7r
	VcskeUEx/a53nhPUjv42FmrCZAfKkIIICtusn0LFZReJ5Fm5pkQcWKa3TsrH9f14
	YhG2O+E7lnuE4IUJ3oWM+Prey5bYe+FM0JWVCV4vOLPDUft/xNNirtX5Rfkdobkn
	zEQfU/Yb+A0C/UulJe0m3dW9wMHVhRzoRtCwzAjuuYP05CPwv7p/aqHdwdxla9+P
	T8rsHFrz6GDgB4zLwRnEilHOyNRNkb87r3T7OfkYjpMCXmN6em9HFQtEk8v4m2sM
	oVo4y0DauxbMsnSUMCGswhDBiWwdEBHhHSgED0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:leHR4XEVa2VRbAuxXWK4d69Nr6iJXn5flvqWjRyRhWM=:J4cYaYDrffjtjcFXUycv8077uZqCPWWp4+rCQPqcn/M=;
X-ME-Sender: <xms:50PSavHxeU91ftKWIGRSOcfYEMxh8JLA1Ego2AuqMPtUXe57xZhZFA>
    <xme:50PSaumNRG2bCL-Zj8XEp-ll6FayzMmvMy5iusAYICr1MtiSNBGB5ve81bDSJTbfW
    2rIYaltJeC78HxOIa-lLuW3clHcK1naf3_JlDrtJfyK1C5un_9vwZw>
X-ME-Received: <xmr:50PSajaev-nSLTSPHsnk8vgr1JfUicTIxXokAzTN_zHqXNd8nM7Wbi9rYC90JSqLVsWKwux6BdHAkRNq6pDwjh9t8oniH3Ds6jNs>
X-ME-Proxy-Cause: dmFkZTFC9rNzqRHbT3fao7UbYZZjPC1V2V0UnshBWWgTfn1Vyedt12pudWXdMV7RG4/V8D
    QXCr/38w16CiM8yMusg6UvodBaXGYS4Gvdc+2V8c5gr/wEd6dMvkY5qiBO8/LONFPdKz+u
    3i6fE9244wcXr8BzWjD0OhD2ah6+dDO/0qaLMj750QktNQDz7c5e8aESaAfRL6l/c9yjw2
    gP6Pe98ZhCeS3Dhwl+s6fSqczmAKGaudvFj9i+CWZsmFvgkGwNNfpiRjlqsmbN6YokiDa3
    OaQ/+6IrRscvIuR+kKBJjeuShlMP0u83igr4LqeLIr+ZjXyKSWnk4FxBUmYJZcbT5Vl5DG
    X/rLMWw//Ry6yB1iCPUph8B6GH5Ik/mCIXGVT3ei6LI6Pz1K+wuVU3FRqHpGUpoif+IBdV
    KP8XvazJm+GKAZfyQkAF3ml4Wt5ZPXhnaxDJpcN91V9N7lIaNIy0lv/RV8RO13+UT+jsCt
    4aXqj9b5+RZl2APKKq46iCRcUg7b0JMNO3oRvV/e3BubZUi5lZEsBh1E/gwl7Mk7THPevq
    kzj+sIAhB3g/mAwpFwal4DfTdz05FBloP6PWeN5XtqYWMphyoE/mWtMJPk1556NIVN6Ptk
    gjm9je0WFpqbW2tEiBkydXeWhta1wnlZIGOez0vdH44sYo5aEF068dnXnRlw
X-ME-Proxy: <xmx:50PSajFPMutedb1QbxUsBqKZP7fKcw046vZiIVklxq7stcT-0Mt2sQ>
    <xmx:50PSakKSch5K4FE0yBS30A5ZlLa_nfW5P46dEcmaEAbFGFidNHCU4Q>
    <xmx:50PSauPxVEnUODo9ZyGznqkXFDlxEVo32vsNUQuBCUai66OUUpi_Bg>
    <xmx:50PSaklLm9U-vLXpV8pvzqqfFEVv9lqO6hrslujIOx50yhk2exlyZw>
    <xmx:50PSapzfCoDb9cEeI2Dr9vIe81mDw1ZBskiZS1b5pXPAawYZdBjT1b36>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 11:33:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,  git@vger.kernel.org,
  Jeff King <peff@peff.net>,  Todd Zullinger <tmz@pobox.com>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 3/8] ci: drop unused "linux-clang" logic
In-Reply-To: <atCdWdE74-4K5aWc@pks.im> (Patrick Steinhardt's message of "Thu,
	15 Oct 2026 11:31:05 +0200")
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
	<20261015-pks-ci-housekeeping-v4-3-c2c88f1b198e@pks.im>
	<e6550ed3-351c-451e-8740-f9f449e98402@gmail.com>
	<atCdWdE74-4K5aWc@pks.im>
Date: Fri, 16 Oct 2026 08:33:57 -0700
Message-ID: <xmqq8q3xirru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> On some digging, it seems that 32d5b90590 (Enable Rust by default,
>> 2026-04-09) flipped Rust flags of CI jobs and retained NO_RUST only for this
>> job and the linux-musl-meson jobs. That means, we've been having the NO_RUST
>> flag on a Makefile based job that never existed in the first place which is
>> a bit sad. I wonder if we need to fix the intention at least now and slip
>> the NO_RUST flag into one of the other Makefile based jobs?
>> linux-feature-testbed? Or have a separate job for this?
>> 
>> Of course, this is not really a problem with this series per se. So, we can
>> handle it separately if that's preferred.
>
> Yeah, we probably should fix this. But same as with the other things
> that we could do while at it I'd prefer to do those in a subsequent
> patch series.

I would consider resurrecting the no-rust job is in the same spirit
as 8/8 to ensure test coverage for reftable by shuffling jobs
around.  I do not mind seeing it done separately, but it is not too
big an effort to throw it into the feature testbed or linux32 job
just to make sure the system builds without rust, and doing so now
would mean we won't forget.  And it is only until rust becomes
required anyway.
