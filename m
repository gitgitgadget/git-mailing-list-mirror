Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC041E32B7
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738181706; cv=none; b=gDElvBYoe24rM3j00y9XlsrIZHlPRzKS+3nnVrorS916ZsgBoFlJbTZNhUkjclIqItxhm19Ird1bkRTMo/t88UsZjHMbRFtKduI0tPC4eT12fxPzAk9TJaP4/xHRCeRHdk89pQVL6aKtMozyXwla8QNY2GipJVf8pX+4/R6KLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738181706; c=relaxed/simple;
	bh=y2w/YWg9tfirXE3OIlUE1TrOYfoTUDNIzf1s/4scpo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4FhnRvWwjYVzOJ3geHqbiikQ65Nn5pwhNf40EXzWFweXYv66Q9vgGyLdrRBXJvzuQGQE45gus5llqhi3ZWYxAhDimSW/BEEz6hW0pbkvDq/SXFgZLUMIO/u0rVNf9HWJ61ZPXRWsbTvbzZtZoyBq0DRvYV2pw5LBt4bmHE5gaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jLYL+bhW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0luLraun; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jLYL+bhW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0luLraun"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id A9FF911401C7;
	Wed, 29 Jan 2025 15:15:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 29 Jan 2025 15:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738181703; x=1738268103; bh=AftUUVVlNB
	PmMGCq5EHoOU2v8nJAZoVyDgOHylX4UYk=; b=jLYL+bhWwfg8Nqc3/rvbwJse/3
	RUjEIbsQJAhXaKvmK0x0Dc8tokNL7dHTPSz9n9JF7SUBqdK1JBZzRuWwbjv+7+hI
	LUyiVJ07XOaXSIKErfHUR8fpyGDf3R6yY5V+Mm+f9KMFENqe6/UVWwyqG0fXoKUD
	kxY1pGnvF1AoXgNk0VT1N1g6Xz/nKoM2n6aqrEl6+lZ0sJHvCEhn8fx3y0BtwsFj
	RVN7IJm25ySq/ktNsthiheXSGxWhvTHOwBDlugq25v4sP6xDyabdgpABxXxeB6Aa
	YIONCOxZCu5rnCVjdj+x1EWRIoRR2dauXMAOV1IyGMne3RA3TKZMow4fvEtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738181703; x=1738268103; bh=AftUUVVlNBPmMGCq5EHoOU2v8nJAZoVyDgO
	HylX4UYk=; b=0luLraunW+pd1oSa7INKTWV9BHJbC+DALMZ9F8Ef2tiHYaH3kjY
	oB83/3lQzgihxsR3ziQRFXu2/kFgVjsuGb9673uc6hZt+l8pyHssILijaoZdSvZZ
	Lp8nw1IzBf+TPsUO0xvhaDA3YjvPK3Q1eojXsQ3fY122XLnDyJfpy9fO1gfX0A/b
	8NR/7xnlsXeZUiCucDzjYVsb9RmWLQAclOttD9YzQo09CozEvfgXlMheQ2TEQ9iq
	J1DYcQD9eWfEdEhbGdkzrqRzbXZvfaR6PtF44DaAAQUUq7LCVgfJtQ7XeoUZhr0G
	Fj1OcgP8aQ9XT3aXCVm0yE3bqfDICg3GhGg==
X-ME-Sender: <xms:R4yaZ1ZvsHlOb3jVMdPAk6p_loGpnzNCvi4Rv8A_yiXQv2s45W1rnA>
    <xme:R4yaZ8bHZNPXcUmQfSqT0CbwW3dawhxGCpGkTVTrFwaIGrz2d54ryIL9dIiNi5BWx
    uKHwkuIimC06FkYYg>
X-ME-Received: <xmr:R4yaZ39LTWNb9FbpnGB4OqUHpFmtTOduq_T6Y_nuY0N3X4mN1bCcf2wx5qR4jsBwGClcO1ui_p1Vz6EtNvIVSKt1qvrowlxbMr_B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:R4yaZzqrtLlJmXeyej9BTuFRL8jYeMromtDoM6g2gEleGQLVNh5rJQ>
    <xmx:R4yaZwrIfsUU0I0gZ88GLKX-AcdVnGztu1UyBVJvCVR1TZ9SHIfTuA>
    <xmx:R4yaZ5TE0pRz7EkIrNOTANPDEwguBnR5tsO4WLx_Z-TNnyhUEjlCuw>
    <xmx:R4yaZ4o8aL0URrlsucV-CMXb5PhUjV6_NDVcoAS7pTRqEUUnCB3fCQ>
    <xmx:R4yaZ7WoT1LvG2pJ7U_6fJMYW4uL9fPyuVtOOrqHg1dyJokusl1wBPuB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 15:15:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [BUG] PREFIX environment variable ignored by git config --system
In-Reply-To: <008201db726f$6e6990b0$4b3cb210$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 29 Jan 2025 12:01:19
	-0500")
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>
	<xmqqbjvpk1wo.fsf@gitster.g>
	<008201db726f$6e6990b0$4b3cb210$@nexbridge.com>
Date: Wed, 29 Jan 2025 12:15:01 -0800
Message-ID: <xmqq5xlxidh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> The documentation on the Environment Configuration page seems to imply that

Sorry, I am totally lost.  Whose documentation on what software are
you referring to?

  $ git grep -i -e 'environment configuration' 

comes back empty.

