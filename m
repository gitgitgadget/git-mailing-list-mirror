Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE85E1AD278
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355387; cv=none; b=bNC37mLGmzPdbgxizgL9Z/+6J37iCQUXH6acpebNa9vIcSi4W29CSXPx+z9WialjjC/lT68ZO6eFXwb5ouB5ZN1hSpP/JokUaLAjY06nG+nB8vrXhHKradpPgJalx47HCMMhFmEdOSEIalRXttliTbJQv4xs8WZH6+GFjerMlB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355387; c=relaxed/simple;
	bh=VYPTwcNQmwv/FEM8H4rjrNM1dFHLzY6YXvWSi/AMbL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgIe6erPNLlsjBzKCj4hZyzVL4rNO/VGbNqAJiz1o1lM9A1HnTZdL/vBWHDylFsHwXQf5Oinfcxse2lVZABXSp1N1rs/LT2nZQ7k3+xmgr3dwbJU82Oay9xEQ7kECPbcmalL/mHvxYoj2CVyPjVc3dJW5wlxo+B0AUX124E/DkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LXj3/exw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uAXCGPWb; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LXj3/exw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uAXCGPWb"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C55AB1140276;
	Tue,  3 Sep 2024 05:23:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Sep 2024 05:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725355384; x=1725441784; bh=CeWxDt3fDm
	mXZXF4ZyMwX2xYbdERU73FAtvCmhzoPyg=; b=LXj3/exwXq7nkxhVlZJkvS7rRI
	oNxaR2bvc8SDKHvYwZtTCUu7//QL5Qfao+YPSi0iSUWXSykVI3Om+MyOU/gPglnE
	cYMGaj/4od+qEtys1ep7ZLzOohqbRz7guHPCiI9EsoNiEx6kcLn3TMBeMniMJEev
	TVRbQou68Wwe4NW/67wikaKKVy0hKUcxbi68k7XcQAZNruaFyrPWiwKFBll0FFo1
	OyNQ1ApKr7n3zXHoPJMIVBAME1NkbdciCtGInlETG4gpVCH1SdT2Tbun2lbf15d2
	MeztGeAxoLCFBB8U5138/Wz1ud7qJ593Q0UqoITFBFAOgYE7uAjFTA7i5Miw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725355384; x=1725441784; bh=CeWxDt3fDmmXZXF4ZyMwX2xYbdER
	U73FAtvCmhzoPyg=; b=uAXCGPWblheXcp98xWO3d8D5N2CdjDtvEPjtLhHmEuXq
	pSFoquQ3VuRMuvq9opA9KCh+7EIPSk9jc9DxHfXjke4mtJaasWgbm3pyCoOSz8s+
	SosxoXxoqZovme1IAzvP2lY0DMaBRSJUTvCq7DdzsvH9oIP3mBlKaDfpEtrH4iId
	C6tM214/ou6GeMUkizjjw2DH7HvveK0EhmcJWgbg6dlYgixrM9pkpg2gJGHht7Ht
	Nsowlci9ztXPOJacaPelGjeq9xkuh1Ag1m08+Ww5JXuUvfchAyjGa1QMEakhHp3N
	aSbXlmdNa2ZHsCvZI4EDb7fLsdUwpdketMejMEVHxA==
X-ME-Sender: <xms:eNXWZjFasTMhP3QdQym7aSvGMkYZtZ52qCJXU0DhR0hWEQW31m3gIQ>
    <xme:eNXWZgWJrUQ8jSx9ItNPNuJecE3kw3dHOttqyEU6bG9so62KkVH_dyrjI3jNIl0X1
    jSBgTnOVLV_YJQeVg>
X-ME-Received: <xmr:eNXWZlIt-sQOGgyeGgQVEYoGO6fwf9Dk2X9BlgIOudr5De4p7Gjcm8wx-m6pfX1D89b19NtRWglRoYTYGuFhrgs2H1zZDBPZ804a9ypN6SJpWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eNXWZhFkuMtMlc54KhpjEA4LmESGVY_FaNT5ArX8duk_qLgX8w7L8w>
    <xmx:eNXWZpWlWaFzMYuCdN1v3mx9sCbE4T2YSJSzF6IpC41KCiIoy89c7w>
    <xmx:eNXWZsP6MZqlezPdmPMHvdC9B3LjOhW04e-1ruuDCmrIRX5MSmk2Ow>
    <xmx:eNXWZo2I9EaHJ9gzVghv7c3frQ916x49X3M1gNr-3SqZJF1OhA9G8w>
    <xmx:eNXWZmjwubD_4VyofgBJ83YZv3Mr2NM18H7yCbX1EFNU_lLmk2AjJ63F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:23:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf42102b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:22:55 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:23:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] refs/files: use heuristic to decide whether to
 repack with `--auto`
Message-ID: <ZtbVbn5rxrmLFuNa@pks.im>
References: <cover.1725280479.git.ps@pks.im>
 <9a63abfe3b812a32d69c7393004bea4f88971559.1725280479.git.ps@pks.im>
 <CAOLa=ZRGvU4LvX9kjvF3dJCTvKR6CC1CwPTp515c3Wt5M8a5vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRGvU4LvX9kjvF3dJCTvKR6CC1CwPTp515c3Wt5M8a5vA@mail.gmail.com>

On Tue, Sep 03, 2024 at 02:00:16AM -0700, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 1cff65f6ae5..261e2b8570f 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -1311,6 +1311,78 @@ static int should_pack_ref(struct files_ref_store *refs,
> >  	return 0;
> >  }
> >
> > +static size_t fastlog2(size_t sz)
> 
> Nit: We already `reftable/stack_test.c:fastlog2` and `bisect.c:log2i`. I
> wonder if it would be nice to consolidate all of them. But I guess it's
> okay, since the reftable code anyways is isolated from the rest of the
> Git code.

Yeah, the version we have here is in fact an (almost exact) copy of the
function in our reftable codebase. And as you note, we do not want to
deduplicate these such that the reftable library is somewhat isolated
from the rest of the codebase.

I also noticed `log2i()`, but honestly the only reason why I didn't
reuse it is that I had no clue where to put it. There isn't any header
that would be a good fit for it, and creating a new "math.h" header for
a single function felt overblown to me. So I decided to just not bother.
I'm happy to adjust though if somebody has a suggestion for where to put
it.

Patrick
