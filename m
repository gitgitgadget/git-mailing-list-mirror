Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7A524F
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695561; cv=none; b=ePDUC3TbJvJIbbobxGYn5IpdXvWflz7Yii8yC3imkPOo2eVeMKR3DwuJcq1E1qS2Mktjxh/OjOml0m75GJM5ls+3TIyjrXlfkkTKUf4yIliHhl/owzywcxPOOne3FC41s0b+w46MtDYqT8upzF5ExpSKKUufaAaXSqIdCG5/HHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695561; c=relaxed/simple;
	bh=BZff+vItcEg1RT4Gcen/YC0yQUd+aug5BDUtTJ23hjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT3BKX4EtfVMtNPe7/iUWA4P9vy9LDiws/1MdfbxClC9T5kdJGvctTtDJvUsHB/C+cyj4ESowfBCqUfG7CBypcJ457sTP3gjWzsvjVz6fuyKAn4mt/gP1uUn1t2L2RxmyCAp+R5tanSpYjNq3Uwk9LZPJXY5zb3sWLNkimNR8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NSAILy+0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iW+XgTxQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NSAILy+0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iW+XgTxQ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 88123EC0082;
	Wed, 24 Sep 2025 02:32:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 24 Sep 2025 02:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758695558;
	 x=1758781958; bh=YuD2YkVCYdHZ6pOBXagfaHqO29gCXqK2/jGVhjd35K8=; b=
	NSAILy+0AEXwt2POEB/voZ6aVUAUpZwhvWYaeYXkQR52AMpS0+1Py0IGF+9RcXmH
	3gM+upNRS/RR06NNIs4MxNJhFVhVQmTvOeQxhS/wthIHuLFLAFW+hJuUWp9wf4dP
	VRjVE1v8OZSV7eEKsqQVhISwAGYb/N2EzlYOUg5gB++rtDQSlL3aa340YTRrFXu5
	1xGbCeuePkwlbtAGbSZrjL0UzW3jtgyS72Mh713cSnfDITk3KN/z9VDBCQ7Qt85F
	4eoSki9BTPVvLMbUAG11ooyKcomoP8rOHLBXLeJeE1kS9BFvAXK/5MYesqY1yXy3
	fvulQ66cytst3AIzWKis0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758695558; x=
	1758781958; bh=YuD2YkVCYdHZ6pOBXagfaHqO29gCXqK2/jGVhjd35K8=; b=i
	W+XgTxQkggWAnNOjZ9QHjZMvzfWmzY02QLOPie3quHEOah43BdpzAHWzvNB+BGTR
	nRV/HHcA5hWQilc8VCPMDtLQ3a4eM1c8VAoLZEqnhm8gNmR94RLZNexgZLMlR2yZ
	jtC5SwlppNQmXTl2llf4z83TS/N8W4vFryZ/+7SvyVJlhnwEjAQ4GrImB8ftxHkf
	v6MPnfBRPnBAqDbDGYlfVO6xbUt9xB/iH09wrEcC85qvRwXk2et0Rl4RtGGEttR6
	+bbi82dIv1LY/YK5yTcGqGFIm1t2j3D1gCF/0G79BvNzGzSwkycu7z8TC0vWjvxO
	OLo/y3WS+H5hrkY2DSNZA==
X-ME-Sender: <xms:hpDTaNQFEn_OB2q1UeMccbHMfBjsFAnhHutvRDxchExPER7WxPKGDw>
    <xme:hpDTaNyzh-bg07AUEG4BDz04YZiP_VWEzrNLVqksWiar5gtzVCc67h6tFIrPZDc9h
    IzJjhgGuu6OTlLp7E2AOQP1Pfbd5Mnc4Uk6TtXOXcgaharHixMxoYI>
X-ME-Received: <xmr:hpDTaH1KGRio9qIlSP_xDttS5Q9bfSzn_Kb0-e8AgIqXsz9dPGHryJKAf2lotgWt1Px5qwe83pHiNxXUHaFgLXRiTYYDElD4kqYOd8EqQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:hpDTaD4TDeabRAZQxhGx6YEEnuXiT8dELb_1YtTstDRvCyaZSh64og>
    <xmx:hpDTaCUbROEyJZ-w8fexDp7atOX6o2YT5ipso269j3ejSAq0syZnew>
    <xmx:hpDTaKAaFYWPiAH49bRagUtEdzHo1AnSxdFTlQleuz73Q8n9at9jVw>
    <xmx:hpDTaJ4pU3P-heSLl2nJCuUVPOSeLohJ7g7ShmfScxTq6Y0i1Y9afw>
    <xmx:hpDTaMLkZBpJlT_A7YQkm1556DeGpcvrt-4v0vHClDvc5iFKsWqySJr6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 02:32:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d64649a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 06:32:35 +0000 (UTC)
Date: Wed, 24 Sep 2025 08:32:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org,
	shejialuo@gmail.com
Subject: Re: [GSoC][PATCH] builtin/refs: add 'get' subcommand
Message-ID: <aNOQgLmVTZ0JRzOm@pks.im>
References: <20250923104533.21165-1-meetsoni3017@gmail.com>
 <ABB734D1-EAB4-429C-9A36-C00E114E4207@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ABB734D1-EAB4-429C-9A36-C00E114E4207@gmail.com>

On Tue, Sep 23, 2025 at 12:57:04PM -0400, Ben Knoble wrote:
> With apologies if I cover well-trodden ground, as I haven’t been closely following this effort.
> 
> > Le 23 sept. 2025 à 06:47, Meet Soni <meetsoni3017@gmail.com> a écrit :
> > 
> > ﻿While `git-rev-parse(1)` and `git-show-ref(1)` can be used to read
> > reference values, they have drawbacks for scripting and discoverability.
> > `rev-parse` performs DWIM expansion which is unpredictable for scripts,
> 
> [snip]
> 
> > To address this, introduce a new plumbing command, `git refs get <ref>`.
> > This new command provides three key advantages:
> > 
> >  - It requires an exact refname and does not perform expansion, making
> >    it safer and more predictable for scripting.
> 
> What are the disadvantages of rev-parse’s DWIMmery in scripts? I would
> think it makes handling user input easier (e.g., my custom script can
> take a local branch name without writing « refs/heads/ » on the
> command-line). OTOH, a script that wants to precisely identify a ref
> can do so already, no?
> 
> Since rev-parse presumably won’t go away, it might be ok to have 2
> ways of parsing (one with magic and one without), but that might be
> back to the same boat of not having a unified interface 😅
> 
> Perhaps later we can add a « --dwim » flag for looser parsing, giving
> scripteds flexibility but strictness by default?

I think having such a "--dwim" flag at a later point could be a good
idea, yeah.

Patrick
