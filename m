Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371102DB7A5
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988372; cv=none; b=k79wcczeTvmAxuhx8b1gM0dPVmFqjmvtOetnjcebGgLvp2eKvbeRRb7bcGfWi/Id7G3fbC1++8y9rd8kT644+8hFg/M+R3aCJP3tiXzacyxxlzaClJTNePzF6XliBtZrqF1a3DwQe2SRag/1b2HXFzvK9eCZ20LjTKsXpZy1Zrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988372; c=relaxed/simple;
	bh=v/xjKTeJTnz+9WM96u9jDYEKfQ4Gj4wvO6eN5uhiMT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPRDDWin6g4m4Gfu9CvKGNFLtYqp7rtvudgmUMBPpNF6oO4erPiiJdEvyoBK7A79vW5UjKRO/HFoEsdVZn5FSm/441TRapBHIK+AzFDPUkKlHKg1A/jDHomrwg+Ev+1st+6ORC3YFwTV3eUE7avPHjQsBbabakLSH0QPHVGrQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DHRpb6D2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P14dA8Y9; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DHRpb6D2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P14dA8Y9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5CC041D0012C;
	Wed, 21 Jan 2026 04:39:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 04:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768988369; x=1769074769; bh=UgZoAAIU6i
	sY7K7ICL8TqDU24Kk3ZICVHkNpPcBupsI=; b=DHRpb6D2pyGsLl0HayMcD/MtpG
	+5eQ0pwXr8cyuXsrPFBo9zZS0bjpIEIj9HiMc3JNeYbPgmgejUneWrZGINTn/Crl
	EyKauHNCsCvHl+x9HEIseghS3GGMmTZNbUvOw/WSEJn8KxU2P1FTzXrpyByqrlfE
	6KlgNLFslCQlkgdLS8mbgF+E4TzwuAeoXekQE7jZyUIUAm0QnhaREiP3Uo8q50Kn
	G9a4LuNPFztmr3Ytpz3DFwxcLRPHbrAB3hSceD3K+HKULhz3w/QFMXWI1eiViJWT
	l9YvJlgqSNbqWSL8IgX+U0SwTopyf7P+jXLlKc8vZCNTNaiUk4uwI5h/C+SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768988369; x=1769074769; bh=UgZoAAIU6isY7K7ICL8TqDU24Kk3ZICVHkN
	pPcBupsI=; b=P14dA8Y97buHjI+H4GWpo53pKrMbS4+kLZ2cnyiSCil9YJNRGaV
	u3t4RUwBdBzVbF1lmcgbT9Q60JgOLErSrSWW4ucnhkZXC+2HQPIwzPLspxiT9GhY
	vJ+ZrF4AYTUALzmcx1ID9v9tM1yMRrzIsUtrtj0IBPtyW5cbyJjZqDL6uP8pUZNJ
	ZuUSb7kMtUPTdC6zsuOO7bPEk8Wjn1r76uQ/2DqksWTruipXeyxgp6/W/05rjRij
	w3S+jWGxgC1h69DWmpOlSbT7NMOaPsu9NMz5IN2ZGlN+DGwAs132Yk9Db84gzocK
	cwPp/PN/gMUKnYvy5Ta805wrmbn6sERm3nw==
X-ME-Sender: <xms:0Z5waa8hpMxDR0bo8TNIrZ2MUtF32ubfMco9OxG6ZkeuC83F-rPKJA>
    <xme:0Z5waSKJSxk_n4hs952i8B7we7b3bUN_pwtccm3plm7qOv_so-YHxHXLY9LDINaw-
    tiBw_dwqjLpFXQkUWqkBCkUe1GIdlMzzmoYennJgyugBe5-FWBx>
X-ME-Received: <xmr:0Z5wadb3M75WLx8N-BYFht2lRQSAJuh_6Jq6oFU_chuq9ekkBot5zgoYlUDvawbJn97NoxQAL5JoISpZN53HeBGPVa0e42NvPCmFX7ouBpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdehudehfeegudeisehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0Z5wacJN3aKnFPcQm6aVqZ9DxnAFZlpO8J_ZaBEm0Q6rRhIRWI43GA>
    <xmx:0Z5waTDjT4Etz6OyfW6B_-chc_o6XqfjhaS3TQf-s0oFMC5uo8mDYA>
    <xmx:0Z5waZpc8u8FjGo5NmECNGIbjgQk9hU2wh3i0uEqu069UKt_tkVxKg>
    <xmx:0Z5waWjTLkHZFqHvICkeWPxfAtZ8O0MDh3FsVtvhBIJKOdEQazFEIg>
    <xmx:0Z5waeIxcec0KtgC8cBMFwl5AH_j693DgXrvyoGfAqWmIugRsEJBxR6d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 04:39:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 56703505 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 09:39:26 +0000 (UTC)
Date: Wed, 21 Jan 2026 10:39:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1][RFC] symlinks: use unsigned int for flags
Message-ID: <aXCey7ysfqORONXr@pks.im>
References: <20260120152219.398999-1-a3205153416@gmail.com>
 <CA+rU_o6Mrw9ga0TST6p+8MANYaNGiKP9qud8izHL+hwxou9upA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+rU_o6Mrw9ga0TST6p+8MANYaNGiKP9qud8izHL+hwxou9upA@mail.gmail.com>

On Tue, Jan 20, 2026 at 11:36:25PM +0800, Tian Yuchen wrote:
> Me as total newbie to the git community (also preparing for GSoC
> 2026), welcome comments or any possible suggestions!
> 
> While preparing v2 to fix the return type of lstat_cache(), a broader
> question regarding coding style came to mind:
> 
> I realized that even without changing the return type, the code
> compiles and runs because of C's implicit integer conversion
>  (since the flag values don't exceed INT_MAX).
> 
> My question is: In the Git codebase, are such "safe" implicit conversions
> generally tolerated to minimize code churn, or is it considered a
> best practice to strictly avoid them and match types explicitly whenever
> possible?

I wouldn't say "strictly". We have lots of cases where we do in fact
rely on implicit conversions. In some cases it's a code smell, in lots
of other cases it's fine. We have tried to become a bit more mindful
around such implicit conversions as those have bitten us in the past,
but we're not on a crusade against them.

So I guess the answer is "it depends". A slow trickle of improvements in
this area does make sense, but we don't want to convert all of our code
base in large patch series just for the sake of it.

Patrick
