Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A65826F2BE
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189849; cv=none; b=uOLN7aW03F3Px998pIk2CgZUn8vvLfE5QVokLC0JbzC9EJfzKysdNYQ/YKMDVejXKvXISIj4CMY4qVgpxoUpQsZmIffS6BYix/6uLDH91IVVuLe4Fmk0QclXtAjYppuVSSnL4DuIVkFExprx1I+n9Wa+nj1PlucNJARkXT3WNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189849; c=relaxed/simple;
	bh=oGa4mOYiuku+XTzohJLUEP1k8MdPg7Ogz1Wn5/pGQs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OsAKUIAFddYfRUxQmM2hVc0zsVapSwLlkk5P3wk5IKx5/sigqNKn3JDC/C1Yz4jcNWLlbR8cmTNKTmsqfPrs5M6f7uqufC/r3xKHQDp5zHD2CNl2a0fBNqdgeddB9U/kd2sbS+J7UR7VkZZgEPcE/0IOKlo73llqIBtQC23hMaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ka/TvyWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UOYR4QvO; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ka/TvyWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOYR4QvO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC0307A00A2;
	Fri, 23 Jan 2026 12:37:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 23 Jan 2026 12:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769189847; x=1769276247; bh=xpmf1Rw0Kw
	+uz89tyGzsWCfDh3jnS30dZJmAO/IYP1c=; b=ka/TvyWowatjdg6DVEQYAQ5iGv
	v6mu1jXJLyCNexEiTk63QdsSmvfE4SKCnCuoJSZ9PQdSHXvdVmFBdWHuBKJeuxVc
	6wI2C5p0ic97zp1Us3xDvfT4QssRBH3CWF6Vlk3RKQ4a75apE1+x4U/LzumiseDi
	/icMdqX48uLIUUaoO63hLZVuBk0a9Jvz5ZEB+PbMmJ+k/u4DIou2c+qPk5s4cgJf
	cQ8mXcxprG3YY1JSwoOFboWq4vM05Co2X4fUAqZPALs8RjNIfF5s3814IwEXsu5f
	UOrs3CFhvst0VliY3JgOaBDTJ9s1bWVnaG0gHpN2N0xeM2hLNVH8IkLqpYWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769189847; x=1769276247; bh=xpmf1Rw0Kw+uz89tyGzsWCfDh3jnS30dZJm
	AO/IYP1c=; b=UOYR4QvORA41EymsC8+xtnisrEc+7VP+27gOscZK8Uf8Aw/oJRP
	5a7M6IHgkoy7zydH5tfJGRflR9+TkwGBxM+s44zmpOE/d9+YrY+BS+N2oeXuufef
	JDpNVc8KFOQoy1pg0D1q7AN+SDAToeXlTRrWFN6qJffAe3Axlmw0+ZaMf9eY14AM
	gUhSCu/btAbkQVGxXZwRKzA78r30FMq4pKj4Q+Vv9/ATSYKIOqDoBU30MkA/CUjF
	UqBZltk0lmpSKnznRKI8685UbsMZPFqInBk3nCrtLuVfAHebcMJXGYCMU3BBe2Mp
	agi9LmkziBJsIDs97KfYRLEDO2uWlzGmPMA==
X-ME-Sender: <xms:17FzadpzajnSsFrFRCyf2VU15wGI8CI2SdYumUci7fu36SfmfFKQHg>
    <xme:17FzaXEnM6FP5kEtFTdF6Pa5JvQ4kdLys4Gm8EhrP-7rYAk01FUR8QtXR0uhUkW5Z
    CAhILnzV6cT8hcFvbQshqkXsebX5tSXhTjimzc-I-UZVuu7B6gIcPo>
X-ME-Received: <xmr:17FzaXlZ4SYPKJn21IFIxLp8d5xSjjjYPHJVrHIFr0qvUBOdYFGamGDTkW3lELWRibhxRLWg3jw1Baa-xW_Ld4UY2-l7_0TLyPfnhe4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpuh
    hshhhkrghrkhhumhgrrhhsihhnghhhudeljedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:17FzaSlSrFbK8302bJaUzpZCKYWwTADh9QiNtsCQD4sNPkllVsKavw>
    <xmx:17FzaQtNXW-S7zPpcuYt0lVepQdZEZjjOMBEUBL_RLk6JfwmGbmq3Q>
    <xmx:17Fzadkwp9ioGvMxABqMYo4wBT301keDeRNhrtEpy2-N3TWajDHggQ>
    <xmx:17FzaTvM8Rg02wPN9ZEEQax3h1sOUxhO-frRvbiXdjaUXQSrKeEcdw>
    <xmx:17FzafEoAbRaIpmdTMUWeCpUco_YfXDQkQmlJFAgwmKH5luDP9VLyvR9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 12:37:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/1] subtree: validate --prefix against commit in split
In-Reply-To: <20260123142658.15516-2-pushkarkumarsingh1970@gmail.com> (Pushkar
	Singh's message of "Fri, 23 Jan 2026 14:26:56 +0000")
References: <20260123142658.15516-2-pushkarkumarsingh1970@gmail.com>
Date: Fri, 23 Jan 2026 09:37:25 -0800
Message-ID: <xmqqwm18grhm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> Changes in v4:
>  * fix indentation in the case statement
>  * add a regression test to ensure --prefix is validated against the
>    target commit rather than the working tree
>
> No functional changes beyond the above.

This seems to be identical to v3, which already had the fix to the
case and addition of tests.

https://lore.kernel.org/git/20260115175403.3971-3-pushkarkumarsingh1970@gmail.com/

