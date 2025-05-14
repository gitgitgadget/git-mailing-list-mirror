Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46AF28033E
	for <git@vger.kernel.org>; Wed, 14 May 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241711; cv=none; b=p5uM2+yx0/n/z9njEnDMMq+ud4Yj2aC7MhdXqusBU7Vh/5cFazMoRY4yujzSC45RESBTZ+I571+BdV/FEoFxpFBg4+CUMmEW1lTBvenYmGCR1uuL+o499ruY3JQ7Q9TbL261Yws0XltsKlXjj7EgwDjjZtVizcmEBXOG5r/3Oi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241711; c=relaxed/simple;
	bh=DxfbpmLqHVnnPv3gTvoOu9NXacvt6frJI3aoEHv784A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e9nB9FhN9IXGJE9dFyRBsllpaOx1BxEKhMHXgnPjQhGBt1RfDrk9/3bqW0hCXvlRP7felEv5KRIH8HYVhOiI5RxfLJ5M3u0w2hcUNZ1JsNaqtb28Q+9TsX+MtoZKfRKjweqM4iFEDU1VYt03fLeym9O37akgTjiSQAJ4cmCoBOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RUAPnv2l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W8kIw5r5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RUAPnv2l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W8kIw5r5"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BDC7B11400EB;
	Wed, 14 May 2025 12:55:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 14 May 2025 12:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747241707; x=1747328107; bh=37x2y4toIW
	KxFIlAL7tjZtHmhpGCFcDJr4ZRhZ08AxE=; b=RUAPnv2lyU6O82aWkyRsmM9zOK
	FytOn2KdxmKrnNujm/FEsXBcalpqlBk51F2xH3sXquB8I+kqpu2A5gaoJQomYMWc
	gWBoNKcDIR9TUczb5eEN3b/nwylbVKqWqRnuGbocTpUx/Q00ycNI89U7Z3LRxVa3
	tYeupr1py2tCOg6x3nJ7rMfCUHnrP/ejp0rLHa1ZtZooxHA04vrfMj1HsJv6fPP/
	hI97RbZT02AkaaIc7kcu8pu08ZhuaAEyJPWpXEGFveQYBrW1Pma5jCQ933qiNiU/
	5M5iPk44knsGACECIcelx41uhngqZDrCUCYQgwpk0IP3Less4e5KiAk8NlUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747241707; x=1747328107; bh=37x2y4toIWKxFIlAL7tjZtHmhpGCFcDJr4Z
	RhZ08AxE=; b=W8kIw5r52JxdodmLWmYGAyCxv97K2ls90ioyhnfgyazUrtn74zz
	c0YQD1+2hEeMiCHHWjxl5So/212xpEap1D1J6zsNXb9HLm35RtV8dXqQUKym+E+g
	7ZDdUJ5pjJwcnMKDWXqOPyDslvinwOsgYa5V0mtFJ+YT+F85/AJUZF6ZEzjgZjO4
	a7Y/s6h5BDHjejzgHa4lEvJR9uNwoi1n5cfL0b/PktzmKqOTAgufT/C+C63gkj+O
	OYkrkwct02jBAKCUWvp/RhPxR23LwNvbCxZTZlLeC5mGqAvPztgrYSyNwoOR1G2g
	jjt8S91/OprSzZQKzoR43aSAIH28ZiQHuYQ==
X-ME-Sender: <xms:68okaJwIbFvnd024rMbYxRB_hQwGpTOPhI6JIy3s7ClFkd9BVSvovw>
    <xme:68okaJTugXxgQTg6lD_Ogs3JkeReMKsegK6DtcA0rRnSSe5EvMzxpQErgf4dej9Aa
    yM20UOoz-zlnSP0QQ>
X-ME-Received: <xmr:68okaDXle_9hJU6Fldub19Qd_kk7mHJ_kDQDGqdUT2l62ZkdAASK__LbIH34Ci5dxfrR805_IT7IB021gVki9k_roeng6lPVSufLSjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:68okaLihbZ_skOw9o2RNwh58WChTnsPoMEpcMcpd7NzxXxfaa9ZqOg>
    <xmx:68okaLDv3ELlcggdC7MLC9AB0SMM_o9ERJ4Rb31VZ5A6LvQ0uJzywA>
    <xmx:68okaELKkA5Ath3ekpKX2PpC8e-g19hJ-jB_Bq9Re1xrVjZst4JmEA>
    <xmx:68okaKD70mzPbZYK47XGdXOCeJVn0fxQ3nrtR--smCEyOkePrGWyIQ>
    <xmx:68okaAWt4G9Fmb79XgfYzQdV0stNRk5XRzcSIZC2XAZp9FxPaj89YaGF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 12:55:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitlab-ci: always run MSVC-based Meson job
In-Reply-To: <aCP8_YiMaFfv8P0D@pks.im> (Patrick Steinhardt's message of "Wed,
	14 May 2025 04:16:29 +0200")
References: <20250428-pks-gitlab-ci-execute-win-meson-v1-1-f68683552b9e@pks.im>
	<aCMNGUlfBcafn97s@pks.im> <xmqq4ixoh28d.fsf@gitster.g>
	<aCP8_YiMaFfv8P0D@pks.im>
Date: Wed, 14 May 2025 09:55:05 -0700
Message-ID: <xmqqy0uz9lp2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I expect that this should help us at GitLab to decrease Dscho's load as
> we would see the same kind of breakage that he needs to worry about
> every day. And being the primary drivers for the Meson build system I
> think it's only fair that we help out with fixing any issues that happen
> in the Win+Meson jobs.

Alright.  Let's merge it down.
