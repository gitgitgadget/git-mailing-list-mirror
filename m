Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097476F2F2
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068479; cv=none; b=i4PmZ8x2CTxcOgYKTnsy9oiEb+dXz8DKLtTxMhRhRK3+gxtEScfFzQK6/lzgPopEwl4OqpA+oWkqi8sKCt+GdXbKTHNPDEsPLRUD0/nLVj5bGrQNqN70L5MVtenI7vZ9fifU4K1EyoT8EDiLqvJDL1Kh6A6iaqB1+/t8M27zuIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068479; c=relaxed/simple;
	bh=bv9WqFyaV3LRHW+3PxtMUbysN2EfzjbftD1Ka8kSnbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HdUABm6/gLYdjTCSJ+O9uIXIByGBIenH2wdSfUPz8pfi9lP9c0WsENJ0lWQy2yFG0yTELDOx+kKOr15389shiDTdw8oT5Uoa7LQm10wX7UIlsMRzJYMtjVZhZNdgwHjaX0TzmpIGK8Lj3qTux1T4gyU5Zieq4KL3P4ytpLwa8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ReS5VAHs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQ/NsnoJ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ReS5VAHs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQ/NsnoJ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 188A07A084F;
	Fri,  1 Aug 2025 13:14:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 13:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754068474; x=1754154874; bh=phT6zsycAD
	OV9nWXASOBZOwA3pe2cjnEyyQQMAq7hXA=; b=ReS5VAHsQFT4je4epxgmaWsVkh
	5r71OSbBaGUsSNY8oGfb+XNsszRAjBpiRLevaNfogNOy9oK5no9D60wL5tDEvvXR
	7ZnGIymA5Y8K1sed7iynrKjNyZ901TgnKE4uyUCO0u87U3gG5Nxrc5WXA9OSJP1y
	XbQ/LKtQZysJwSu0dyIaOSWXeZjN8cu0YcEytbXzMLHA7OFJ823NnCpXAy4I9Bsh
	oW+8siFXAAiCmFjJgYPg64iOoiaxyn+KUSdeb+K0j7Bpk8q3AQ5d91er/K2/65A/
	wY+Xyq08ga0tiKYvvTQDBfGFZGrTojwcBro+vfIBpN2tga5tVddJsNrU38vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754068474; x=1754154874; bh=phT6zsycADOV9nWXASOBZOwA3pe2cjnEyyQ
	QMAq7hXA=; b=aQ/NsnoJnTv2K+04QmBLymauevbYRT0XRFM4rT+ssl4eYEil8RK
	fESt+4XGakyegWoVwGG3+Z0loS7hwvioGwnpCtyAtAemBd955cNtaW/0AyK5tS8N
	7zbZVNQT7sR7SwAVeEgjAft+NIQQ3Ry3+t+18KEFxV62YbKELOHLoTfD6AbD7Rum
	ZseR2yCu2LUcx4oRHbA4osGooD+3mzbaLvnuxPOpj2GaeYauHBKrdmn6GEskTOwm
	1WLlJUoGFrpqm6fX9COXWICjgbVrBB1vspK9oVwb76hABdFCgo6iB2zAb3w+0O2M
	FhpRRNFa05UuvmY1ebuiKguON1jZJESCC3w==
X-ME-Sender: <xms:-vWMaAbci6tFL34KBQGKXchFF_5bzvP7ez4wfuAOmrGbKCQn4kBs1w>
    <xme:-vWMaITn30LH0M-aLX-Ki-sOtilUzDm6qVLYu8t-PzFpL5_bhUt2GzuhavdusXscB
    SowTyCjm06k-VasCg>
X-ME-Received: <xmr:-vWMaKvgkpaVuAXHFnxShTHsAmyo0eSDzys2yaCejCQCl14Y8Cp11dZQzKhrNo62baLjof3rCmcz9k6BSipmqk2clo371CqWo4WpAys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepjhho
    hhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:-vWMaKF6h_v8xbwzRNPHdlm-xeDR2M7CnR1-OOUI-df_VdUzfSTpZA>
    <xmx:-vWMaLyS6YzKh1rptkSLk1pbgJgBuB4lrwKDD7vYZB1G8uLtMTyH2A>
    <xmx:-vWMaE1en-_B3YdD7i2ATqc1E4MunEqzVWfAW923xvdqPt2vm1bdUA>
    <xmx:-vWMaLo7XGL1gdXUYGtOku0VFBH9gN0qxDF5exgC9tW97S9i_CcJRg>
    <xmx:-vWMaF9_QLeCKqc2gWZDHheW6TWCNeuQpOG1Ru__cnDHemLFuzkzrLFN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 13:14:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  shejialuo@gmail.com,  karthik.188@gmail.com,  sunshine@sunshineco.com,
  John Cai <johncai86@gmail.com>
Subject: Re: [GSoC][RFC PATCH v4 3/5] builtin/refs: add list subcommand
In-Reply-To: <c4d9b25a-2a62-41bf-90e6-455c62b03aa3@gmail.com> (Phillip Wood's
	message of "Fri, 1 Aug 2025 16:49:40 +0100")
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
	<20250731090040.1625303-1-meetsoni3017@gmail.com>
	<20250731090040.1625303-4-meetsoni3017@gmail.com>
	<2d2f823d-6e85-44a0-85d2-d45d4dc287fc@gmail.com>
	<xmqqseibm7ap.fsf@gitster.g>
	<c4d9b25a-2a62-41bf-90e6-455c62b03aa3@gmail.com>
Date: Fri, 01 Aug 2025 10:14:32 -0700
Message-ID: <xmqqwm7nklqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> It is confusing that refs/heads does a prefix match but refs/heads/m
> does not (unless there is a hierarchy boundary after the m).

And refs/hea would not show branches, for the same reason.  It is
what "anchored at hierarchy boundary" in the message you are
responding to means.  In other words, it is not a simple textual
prefix match.
