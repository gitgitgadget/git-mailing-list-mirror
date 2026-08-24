Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8802571A0
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787548430; cv=none; b=UqpgF64x3EpOvxPTyJnSu4refKuXmo/z84fvXWfKVxyTl1TUdsLR27wR+WmSoGWWR4ZtTfaWUSu6oOyg5PGj++jZO4jl8b1fLEJu9r3CkFjwwAksqbT0QQzsuAxmy9vMAG8nxqoks9I4DSwrAHcIQbuE+BtHNyAJbJDCO7YTt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787548430; c=relaxed/simple;
	bh=Eh2TDDzelV5zJCxGCXIbL2y/UIcqWh9uabJwARjCxF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNbJ3V3mxodhYx1N0DVSiY7Ro53qTXmpRcFrAI+fa8Z+92UJE6Gm/pPlrf05bZ7Su7ZHE7aMjAqg8+Gs0QeGsHBUC8kGHgoYsjzy2DtBLqhzB0Hi7aP7j6OTfBglfyGzx7MMoiUufOSxkVivRAOdXtdl2PN3wfpDOTe0FO/MYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pCJHcpq3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ktyJODrv; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pCJHcpq3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ktyJODrv"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id C10FB1D00031;
	Mon, 24 Aug 2026 01:13:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 24 Aug 2026 01:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787548427; x=1787634827; bh=Eh2TDDzelV
	5zJCxGCXIbL2y/UIcqWh9uabJwARjCxF4=; b=pCJHcpq37btcqlED2b+PjQH18O
	/GLYd159GfvDN6p7E7gKwB2AvuYQiA1sQlhs/tx4ywiUDOP8oW8CbNTzjMYadZgj
	g7z5/NCiRMwQw1GV1bbijVlxwQWhoRpp7zETO/RNzQPZG0XQu6vnFUMTz4EblYUh
	Rx7ZxJBDKuX/P00nWmyARx3ckHC8/hX6w4Suu7WUDf2ClPEKbE1Z6aGMRA1IIWVK
	OlxeTmNOph6r/ELjsFlLzTOKA53KWRm8C096R8oLEK6dAU1+cco0t2wGBX41vuCY
	Ch+g3/NrzkCPWcat97DAGn4bvWx8LsxBKEd0BneMJPYkx88k9trqxmVs2VQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787548427; x=1787634827; bh=Eh2TDDzelV5zJCxGCXIbL2y/UIcqWh9uabJ
	wARjCxF4=; b=ktyJODrve9O+4/9q4JSIRujQNrPEwRctHBw79s+ZvcKye+q3igV
	1S2+1ubAuzn3NO86bwVJ0dFK8ywwHqjn+pADCom9rUlI4uanVndTV8fgax5IIlZf
	AyADGkCUmBqGz2KuJl4bDHmxKGNHGRtqC2RUSlskgNRfy10hPVjyn2Ce058vSpSf
	Y5K/WG9GTrXQFbCYQiitxcg2eDB/T3p+o8iR2XdQKZfPoMCgpY777BiuWAGwBwVL
	dLHVDGS/Z7wnYm4FP3Ggntj7gBB9oEm/QSU4D40770F+r7n9T8qnqWsec/+W0s3o
	JLTuapXxtNnUy6jZfylG12KZvH3AWqo0UDQ==
X-ME-Sender: <xms:C9OLatk1r1_wPiPLUOuwtFKwQc7-pYQ_0zjFk4XZoUYXKOtdPmuUoA>
    <xme:C9OLav2jNV1RDCmnEQJ98OPbeXdUTW3SYhckDHEEOSP1DpXr7fvuDbPb4tL7WoEvR
    FNVpGf4pidZ8h4qiToseSjkEH68H7fevla5ZKB2AciG4dYp2wEB5w>
X-ME-Received: <xmr:C9OLaoouUuJBXxqRDj4NRaWO4gjRAgAXC3B-TCpSnWF6uy-WopAP_flM-wGHExhSXchhMS1EKbBxE0WqB5FdnZfVSbdjGAR1rYgDrUW58g>
X-ME-Proxy-Cause: dmFkZTGS2f0nnIix+XlYJjLIUd2PMMMmFRzNFn8ZPfyH1iUbNssSVpXUecECp3Pp5gRoEO
    RGC6tAdWHZNkxBVIuKHajLRm9srHk1947VkiqTFXD9GAroWRVfgwNvrVJAz15B7gbOf4yo
    3FfX5Dj+YZcv9XmDdO6tKAbc7OIDEMLxgI3u+NjH/wVT6ARlMleu5Uy0mWSFIPoFZBygNK
    Wkma4fRAzPJsQXxBsJXSlj4bUvgQSeie/WnfMH5mQich4WrnsfY/+3crs9FkYszkps3W4H
    Ka1E6ChQcnXCpa7QOQv5QmRbrgoigGS8XirF/1VLXCJSc/nCAoYKL0hazWcaMEGOioyfTl
    t22Q9LRxRmV/pLcIPWMdS4VGgeA81JuyOsrVrTzHsqJ1Co0zDW2cEhseXFILDueuJN63NP
    FK22jqg7lRmwSLb46AnlLD71+poB8Ap9GTjE/s5AMaeiHbnsryhXSu5qevCxrwkZCS9CH9
    PuP05sv7xCGEHkaYyrfIgdOrgXOtFv+GXsU/P6xI+szIVcuEUIggjIrdOVOWHFRW6LCILi
    WV4dvts5lUg6y8KSc5SkNMnmuHvD9VRz2dNeLcNWX3Sv0dGGLLBoRGKXSGyICgbVv5DfUi
    mipdJmwXV7JOyGsnwZbhnq5N01TnDXvGQtIVanrt7mCF/6ORBhIJgfqhmItQ
X-ME-Proxy: <xmx:C9OLasfaJZ_pGjcoxCY4ZHDK_3GVDZjvhIyO1NwuqyZuM52-2RXUVA>
    <xmx:C9OLanomYrTuqynjW7_br1PkAGWJxEaDmW0SVZnL9A_vRWppoGs6ZA>
    <xmx:C9OLatFLao9ffGDd_rKDBufoe5ifJJuKsWH0wefNAKAF1pNpqmlZ0g>
    <xmx:C9OLansh9zrrEF93rDcx4f6Jz1MCPx8Padj2l-s7f36VsmJa_5NKlA>
    <xmx:C9OLarv6JWTDk6Q81mUfUs6c_H2EjiZczgoF2y7vGbBLJLWD7xz44uH0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 01:13:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c03365e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Aug 2026 05:13:44 +0000 (UTC)
Date: Mon, 24 Aug 2026 07:13:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Elijah Newren <newren@gmail.com>,
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <aovTA4F04aX8SPTU@pks.im>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
 <aoayppoxHAkcFTBN@pks.im>
 <CABPp-BEBbdmE9q+98gWq-wLzDdhJOyazcHF=pP95o5AcmgCv1Q@mail.gmail.com>
 <20260824044822.GA142844@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824044822.GA142844@coredump.intra.peff.net>

On Mon, Aug 24, 2026 at 12:48:22AM -0400, Jeff King wrote:
> So between the two cases, it sounds like things (or at least the
> low-level lookups) are working as designed, and there is no bug. Or am I
> misunderstanding something?

I agree that QUICK is working as designed, and that callers that pass it
without being able to accommodate for false negatives are buggy. But the
patch sent by Elijah still fixes an actual bug where we may not find an
object that is contained in two MIDXd packs where the preferred pack for
a respective object vanishes concurrently. Filling the packfile entry
via the MIDX will fail because the pack vanished, and the lookup via the
non-preferred pack will fail, too, because we skip over any packs that
are covered by the MIDX when doing the non-MIDX lookup. Consequently, we
won't find the object at all.

That case is broken no matter whether we pass QUICK or not.

Patrick
