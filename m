Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B31AA1C4
	for <git@vger.kernel.org>; Mon,  5 May 2025 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472221; cv=none; b=dLM7e7jSWGt2QB0am83n8Y78TuwfVIPgkRAFDEgY//K/nLrgBwuA9R/uIzoOCZMYTNMKbgPc6pajTs9Y9+qeZCQdOG79SMVsO9u4XmB4b9KqT8QGiVTvRkooI721zdvU9H47bepmQTPk09NqswYuehoOgSa9t35zrcr5n77C+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472221; c=relaxed/simple;
	bh=YNG/FUC8cSo+g2j6HQdnbszcvFya+RhSl8c96axlYNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eaNEFpa1Iu+ftaxLtkB5vcRR8aQsKIELwrdrr8Da2cncNHuawnKjixiINwcTvcyv/SJaYFZsqsFKSS+VMdCHvWCIPfsENNrRkJj2mKvqyq7Fxh29o9uSEl65csSPRrXBC5gR4uUHyWYwrCkHo5bS8Icu7KY2jlG8eLKf23KDYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HViDzsld; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VxfjB8aT; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HViDzsld";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VxfjB8aT"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 427E025402A5;
	Mon,  5 May 2025 15:10:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 05 May 2025 15:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746472217; x=1746558617; bh=YNG/FUC8cS
	o+g2j6HQdnbszcvFya+RhSl8c96axlYNM=; b=HViDzsldC20GoGqKZ/wL14QmXg
	zUvUUKHT8A4g0BRFD1X5cYuJfabc8iBrCi2vTDsrj+bJd1VR/PvaB4RYvQ9GUtQg
	Hjxf+nl9cD6FuHzH+S6rPbk3PPoVsuS0AiBPHvUohS0joOJRVEePRkLL/a5zTiIv
	GwngyFM9u5z0WmXV9DhYifJSa1q3covjJGoEmadY4zlj7NIh09WjC3miAVQgdANt
	pHD+CsreGoBDGsVQxsnoNNDleCT0q/HKPNHJKfp2QwyzrNwqZDXFStSaghW2w7sf
	8ocB7AJuUSEhIe4HkvsI4aW18YVOrxRyn4s7oQtoA64nc9OuI4B3ECvXpa9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746472217; x=1746558617; bh=YNG/FUC8cSo+g2j6HQdnbszcvFya+RhSl8c
	96axlYNM=; b=VxfjB8aTTxo+KB7EDO00nh4IuzrXKkrv65SXPfJYdEJHtjjtANO
	iT77TZIXulCWtIXK03s48u+2tq5Pru07UKsUkpr0c2YfdpcPJSU8e9Y7LaSWp9Xt
	lDthbfEiJj2ybGIibX9NrmYOWyooSOiLXPXttZLN+7iLKqpNh6wInJVM37SSjZdn
	eCy4GjElZljiio27JRlAMUtp0EqJBGOFM1YdteyE7QrEjhihar4UApG7/nCecMH4
	WYQLrgJQOI/esFPYLhttSZgfeK2/2eURzfmq4sF22Hpircw806g1h2OTUjSiIzYH
	MT+g1h6q/r4Lp4x7T7tgJlTrmWjELtO1kQA==
X-ME-Sender: <xms:GA0ZaIVlNvja0x6bpVZLcuEZL6UGnFf8U9SbgJqEejX3gl8kGQwCFw>
    <xme:GA0ZaMnT8MLUfI8c8uFWMwzd5gDUYA1ucFPfcPO9gDlz7oI1K3pYXgzLYFSUmz64V
    L02yO8uSR0y3j7LMQ>
X-ME-Received: <xmr:GA0ZaMYafeGzyFoin9kTnt1Ib45qscxOTvcO3mBZ5gt5127t_JV78z-ASYj4NdDzul1V0Wff_DhtKfzRoS01zKX_UD7Nia595dXq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopegrrhhnohhuugdrsggvrhgvnhgushgvnhesshhophhrrghsthgvrh
    hirgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GA0ZaHW2vQ_JV3wN1yQMf4ordzTYpebiDzqgzXteLdONuAMbzNfOUg>
    <xmx:GA0ZaCmS0wusnuPiHGJ6bDx6LGUILKrhFUkNykjSgPvB33xLzpx0aA>
    <xmx:GA0ZaMetGOvWA0BTsSzSdOBU2hSmvf-yN-08LjFA-HCCV1gcYTKArw>
    <xmx:GA0ZaEFZtH3fn2hy_nrGXUlNakpLDXSalIE3OI4uq5qseYWBQ6BKng>
    <xmx:GQ0ZaGjQiT2I-2sCrWf4FKbYvW-IyLgsBNPF1OSDHC3yfrRH3CqKuDkE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 15:10:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  BERENDSEN Arnoud
 <arnoud.berendsen@soprasteria.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: Cleaning up "contrib/"
In-Reply-To: <aBhZHA7av8bWH9Ac@pks.im> (Patrick Steinhardt's message of "Mon,
	5 May 2025 08:24:34 +0200")
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
	<3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>
	<aBhZHA7av8bWH9Ac@pks.im>
Date: Mon, 05 May 2025 12:10:15 -0700
Message-ID: <xmqq5xieq3fs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Many of the tools in "contrib/" fall into this category, and to the best
> of my knowledge there isn't really a clear strategy for that directory.
> So from my perspective, we should either rethink whether it is worth it
> to have "contrib/" as part of Git, or we should at least do a spring
> cleanup and drop bits that haven't seen any love in the last couple of
> years.

Things in contrib/ should either move up (to become a part of the
core), move out (to become an independent project), or disappear.

But isn't git-svn not even part of contrib/?

