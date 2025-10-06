Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67C213B5AE
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759788429; cv=none; b=JFWfOpq++m5Qdqe2nQYFPWVl/TM8owiDQKlPM2TiXJVDFqn4nfBQtEJRGuvcfbdFdQR/Klwzq26DRLyz8bvFL4hkspLDmlNxdx1CwRu7aw7+bT434fjI7oBYLg9MbSOU7VmmeHgzNEuM/63pYL5xtGaVrALDNlhCP8zh/ofQYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759788429; c=relaxed/simple;
	bh=nxTCusK/mdOgxBILvD/og1p15YFe9Kk6TxzA6AA4XvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XyOp2YpavJhDgQEmGsbSJ/70dNXpz1x6aKzA1FQP0PmPZ2ASMFt61z0qK8Z7vaJuqKR8ZiVs8RoPeIhbG/H/6GqHEfX+ZVn2IRJgXY0mqKzGMemJZG9tjaIAgv43ZnevH5PxOPOaVgtXoNRwLD/4HnU2WiohYN5OGhi6AEEdMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TZPMUK8D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p0JuQ+zd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TZPMUK8D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p0JuQ+zd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E16EEEC012D;
	Mon,  6 Oct 2025 18:07:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 06 Oct 2025 18:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759788426;
	 x=1759874826; bh=T19Ixl0Njto+e9zv/qfDsPlMW6CCOCOKwE28i+/0HZ0=; b=
	TZPMUK8DAtEY/fsxb6FGuWuwvHjMPqBloJQq80Epi8xB0MikZZZaz66C0anKbFn5
	PbwNmRuOnzW0tbip99Gv+9Ie5WXGn+2MmzuvQ8TrK4eapSmkulz9VfFq8O+0PDdu
	35o7AtK3nMLhsz4rpUQnu45SSc9Z0HH0DuWJQxKV3z0V3DP5Z1+LDCSpUbTK3tO+
	yM0sAPoROHyXpH1QL/QpfrMpg/sdvInPSxJcueCf35XCIXb7XYJzvANp8Rzb5A78
	ZUMHgwZwDIOBbb5nknD3m1KttwN8XjYyocDGUAY8epYDL80sHgf+q39YEwUvHS36
	MygTFLiZBsmgCWNJRoqxuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759788426; x=
	1759874826; bh=T19Ixl0Njto+e9zv/qfDsPlMW6CCOCOKwE28i+/0HZ0=; b=p
	0JuQ+zd96Xvqghp6S/a9KUvTu9APuK5Mnmi+GinWlgu60Io1ybmpTCSzaDD5AwtL
	vxeNYzt5w1C8hOU1FnLMvNn460Z18n6G2c9NJbdLTW/zjtZ8lv6/gwX5bIxX7fDl
	LRku5OUabqmIPvk5Ti2cpK+Lo7udy1tR1qwHkIZQXTwNYy9Zg7gQj80tV/0EmJm1
	k5lJHfaHHtiRWlJKozlFAT2LG8Al9Rz23e8oWhNS2oPQb+2SyV2ijCmP5GTxpUft
	qv128Vx0nPw/VXVJJXCSMB+sE/jXWQeVCpOObQwDsyNAZKL4hkGwYtXt/ta0vya8
	rRK5oYGv/NZrpKeSHXRiQ==
X-ME-Sender: <xms:ij3kaH7uTUQ1lbTTJE7YtSHx_Z6yhBUCNN5Q2Q1L9E_0ephZnTEX8A>
    <xme:ij3kaPLDaTiKLKyY1bngCvoYXL6peE8mkQt4wMh7qOYXzO9tb_RZqA5UpfJnBbNSM
    pbhejvY6OHgvARcHNlNE7795ZPbUc2ylTCVkaQpkHIhuosk9kB9Qg>
X-ME-Received: <xmr:ij3kaAu2b3Wk1NlhZJMSd5wkEzbluM3TAgQspHh2HSK0U92v7uNXUZ-aKT0qgmuWgVKFiLDev4pZkpfHWOeFAGhxhoku6fTlL_Zb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehj
    nhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtg
    grpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ij3kaOLS8UhAtMCWAcUVZfi1Og_ARwlNEb_tYcuZeFPKcEoF1AipIA>
    <xmx:ij3kaJ-qev4QayG-Z99MMW6EuRxH1nwyVaIT6VKXmNeiyZjC4J-YpQ>
    <xmx:ij3kaHzfZg65i_yU0Rg-1pr5m4by77ihSpNQevAJTr-tOKFnoaKLFg>
    <xmx:ij3kaG7rwJAZAqOLKzHUZnxKLsYKFReFrbxE6OA-Nzz66JHWw4wxKA>
    <xmx:ij3kaMyRzisX23VBpkZJnw9BQLLfHYaFRUMSkhK-ihrJ_tqBpJPNC5GX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 18:07:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean?=
 =?utf-8?Q?-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v5 0/5] doc: git-push: clarify DESCRIPTION section
In-Reply-To: <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Mon, 06 Oct 2025 18:58:46 +0000")
References: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
	<pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
Date: Mon, 06 Oct 2025 15:07:05 -0700
Message-ID: <xmqqa523ofau.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I surveyed 16 Git users about the git push man page. Here's a rewrite of the
> DESCRIPTION section and the definition of <refspec> based on the feedback.
> The goal is to clarify it while communicating the same information. The most
> common piece of feedback was that folks didn't understand what the term
> "ref" means. Most of the users who said they did not understand the term
> "ref" have been using Git for 10+ years.
> ...
> changes in v5:
>
>  * remove a bad example of git branch --track, from Junio's review
>  * fix some formatting issues, from Jean-Noël's review

Thanks for working on this; I have no further comments to add.

Shall we mark the topic for 'next'?

