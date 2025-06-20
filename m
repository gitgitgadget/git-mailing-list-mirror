Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00117BD3
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750463720; cv=none; b=h1LpVO0qUD9GFz0zePcVgggC6JTzni7Asey4gdRekNqgNix52M5zIJq0VAtukx/V99qSHYIOQ4+6AycHP4mRIjSgcBfs9JMg/+Fe0dh9RhiFGFyxSzZ3N2zAOMf4VZQVHuruN1xaQeKoa0aQgQjQzlzefLn2fPirGi/MHBhhZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750463720; c=relaxed/simple;
	bh=phugW8Trx5qpfjiQM4nBUE3ljkz2Rh0sry3zvWh3lh0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DqE3S3Mn36UQPGNnKWFQ3w+H/R4bvyzxN4x6tYLl1XafrmRmfBel7Gm+w7B7D7gs6A2lq8MWlnhHzPf0K7jYf9iHhMHHM7D5ko/vXsilZjUogpgS+VfPN7jqSRXc/U1/L5pv9ELKzorZw/MsOrwXI9ltEScjFipRLAky25Hyc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AbGvOUil; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+CdE3yw; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AbGvOUil";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+CdE3yw"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9BA5254018E;
	Fri, 20 Jun 2025 19:55:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 20 Jun 2025 19:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750463713; x=1750550113; bh=EVn6TsK1zT
	JJnJNS8lBnk7ltWzOzmeO1b79Tz3cSDZc=; b=AbGvOUilQ+X43gTcvIL5PvdK5o
	K8l3M9LMKOQ0pUyeGlfuAoh+ONkj8vnX2vJMBUv+2GWaGkYedEO7Ub4pELIjIEv8
	iEYThvZF8VyIeuL0RUssGDN8jIx5RUxR7/bXZk6XGGP6HZbvK7nmvVBbdHUUJIGz
	CdNQTW3BotwkTnZH+/k5NW3AU6N6kCycdgPVmw7TAb3vV8nMfAui2sLJwWqpunSh
	z7axqIC9aVwovky5CkCcR5v9UEFEP5RQ//7gcuMeactFKQ2GXVuYAHYJunnlVPhX
	SBdOdRXLrfcRPlnV7IJcg0lQlR8VB7c0VJgcIowHPXzQDOxYuwC9AksDJldQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750463713; x=1750550113; bh=EVn6TsK1zTJJnJNS8lBnk7ltWzOzmeO1b79
	Tz3cSDZc=; b=a+CdE3ywm7H5fzaeCNHWAXLTW0c3kwMna7/0RZKF9E26zOQxiIQ
	8ly0pgosn39pJd5nDJHOkyytcqRpiKL28BX1gSGRohNFzbQ/pKoo3Sw5VAhSLQLj
	0kk7S3BUp5MZropXpXgbVzqUhbA/1xIYuWXj7ZtCpU2yXjdKr/3wlhBL2WPo6TNi
	XjP07pdYFxOcyXWirZ02RUCa9u4yy7h/m+RAnwwEpoIOJpT2md0cGxS+eaGWHGHI
	2rWM9meZC2/PhqHCZ6Qzw4GZO/8XLnbvl/AWMTl1RRfKnuSrJS1wsGLDZvx4G/Xd
	htQtgRYKhpWwWojEaOsJlR5YosQF1mt8HjQ==
X-ME-Sender: <xms:4fRVaM8oQqXteu7ziUVNFrZoO21LBt61-TmAdHjs1dVV2bZ3AfurPA>
    <xme:4fRVaEt2nzZ4aYHDIFisVt5p9F1bY-6Mp4QB0_XkMsKCiDkPxZdbt10-42vomMVlZ
    wMRP8rMm6ZMvfzJGA>
X-ME-Received: <xmr:4fRVaCAYsZTDhVy4dfHcl49bIRbnBrSglvfSMi3Bil81viXsfZdBME7cuaVBcUbzIrmHHenZd9pDwY92nY_MNgcucdH7XsIkEWZ9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeljeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4fRVaMdxd62ErsiVMYf-ZoHuXsTlw0sABYg4Xkt7WhBCQYQnfKkbCA>
    <xmx:4fRVaBMAzN0O7ZPe6eIvnlH5Qp6gNiJN43_MFuvEdRhwumxzzA7P5g>
    <xmx:4fRVaGm2V8Qxs3cdZ_sMEdtYMFaVkhCzkknTCr6KyksIy97wauMG9w>
    <xmx:4fRVaDuSpBDJ_0y9TzAQNkyN-b73zrn97OjJv6BUrKzu5mQadGQTgA>
    <xmx:4fRVaJZgeWDIvTgw1jLKH1eiGYTZxVhhaGPvzXnUSKUEDcMEqmmEuQZi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 19:55:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  ben.knoble@gmail.com
Subject: Re: [GSoC RFC PATCH v2 1/7] repo-info: declare the repo-info command
In-Reply-To: <CAOLa=ZSgFYXEwdTyAfC2TSgVqpCSq6D1NDBwPU9cY-unX0Jx6Q@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 20 Jun 2025 00:36:52 -0700")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-2-lucasseikioshiro@gmail.com>
	<CAOLa=ZSgFYXEwdTyAfC2TSgVqpCSq6D1NDBwPU9cY-unX0Jx6Q@mail.gmail.com>
Date: Fri, 20 Jun 2025 16:55:12 -0700
Message-ID: <xmqq4iwa0xzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>>  .gitignore          |  1 +
>>  Makefile            |  1 +
>>  builtin.h           |  1 +
>>  builtin/repo-info.c | 21 +++++++++++++++++++++
>>  git.c               |  1 +
>>  meson.build         |  1 +
>>  6 files changed, 26 insertions(+)
>>  create mode 100644 builtin/repo-info.c
>>
>
> Something I mentioned in the previous review, but hasn't been addressed
> is the addition of documentation for the new command. With each patch
> modifying the command, it would be also nice to add the respective
> documentation.

Bsdies, the lack of Documentation/repo-info.adoc causes "make check-docs"
fail.
