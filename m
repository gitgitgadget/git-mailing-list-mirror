Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F9E3A1E64
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486521; cv=none; b=Oy3AJ+b2Hp4DB9XGilAcFt8Cr0adGRLsYySB0x/wxx5azxUrY22o1yXQsF8GyrqxWXE9MemaZKpV1MhbL9reTdKIE/bnyg+iykWMT6HedbNzzcjbcL6SsPwcyGMrt53166Zda0AruXNWzkwtpcyO9VSzIzkhToQ++hQqSPvYVks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486521; c=relaxed/simple;
	bh=84xz4DtB0X6M5DodBoL3NPIjkV3LCbtr7UqnKhweVjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NrfutQLnGVt/GuDwf6LNX5gr8jAqQ9XwI1ZRrWG5xhbe4PIgIZRYPlDoPqNkhdNgM+4prv20G33IOGvlzkK1aINB0QeYVWw3jzWkoC0Seq3eB+jQ2i6EG005488hSZPIzF9REBUm+1rBFlgCfyT4SjyosQzTRVZ6LN24I4LAcWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f1impudy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M2Jo/HzM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f1impudy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M2Jo/HzM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0ABE51D00015;
	Thu, 15 Jan 2026 09:15:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 15 Jan 2026 09:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768486518; x=1768572918; bh=EZm/GP6gmS
	zENLH4g7mUMCiN6FEa+l3z3CO4ZGOB2z0=; b=f1impudyZPk5L2ojhkN6e3x1qV
	vDEZDB1+l9guSHTDHwalX5OdtKfYFfRXfcWqw10mXSHkSxkDEXYW9GVAnahbzWEY
	QJc/otgYhBbyoWMlpukpu6o5sa8HUqzzIYFEpBkum31gLd/1M/7lTCq9S46S3aTR
	uO2SPRbnHxlJLzkHoXE+hdG0/qX/R1ezx49/dvJTs5VM6bZB8IciJDJAD+B6wEKb
	x/U6Xp/49KTB9W6KqpgVso9wx1nJceJHiAH9i3sh91qlAaxia+RHNN2SVqGri0ov
	otGkgjHI9229L6bdzsx3fkzBkjUaQqm+956ctiLSGZueJwgK/qetyhgEweWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768486518; x=1768572918; bh=EZm/GP6gmSzENLH4g7mUMCiN6FEa+l3z3CO
	4ZGOB2z0=; b=M2Jo/HzMVG6SSeDSTQrN0HT6pQXV+D1SafTbaKHfJF1XdPp61a0
	aE3kkCo2UP3DsLCJvvoQhsgtrXqATb+WE2FrGFT4ofbSnuHnBFlZxSB9vIfUXGaD
	wZ/4egRSrPfXOs+ktD32Q5bfx9cUU7rlZdHsv8DBqUEguoP05DlkbdbXw0NMUo+9
	V0lZKnkv5tlnWqxmbAwSFbXPIOc2mzQ4x73ZorZzkWd5+ggAT+yqGLEHhmYRmJfM
	X5dSlDXqHrHOw2zGZI7zgXcwrLi/vCOF+ggV3fky/WkiR9JfVVG9Qj5x2eGYJBxt
	jp6oRc5n0inEkvJQdQJeTbs/kXPsNm6M1MA==
X-ME-Sender: <xms:dvZoaeXWghWm_EJMPTDkoOZWiXHS2AJkRtg-2Q-NzHG-DJ1EqhAmmg>
    <xme:dvZoaXj7b_qdAVebh5dB2LmZPd-86HdMoocNHsXh-EZFu8B9wSSDJe0HlFHRrjuPX
    oTvx9nWP3_w4fx9U_YI70ZR9McmuWVJKcZTnzoKhg2sunv8iSlLD9g>
X-ME-Received: <xmr:dvZoaeD_JJUrtCu-a2FuJn5mMSf232gRc9FcVge_JgG13_N_6fwd0jnwNw3h1PEBwfiHo2SKxiCguUZ9q26kMTuwYXA-sC3a41tEO84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeivdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtoheptghhrhhishgusegrphgrtghhvgdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dvZoadvAYgmyAmaxvr3ITuJ6zFp8Kvxn4eZWp3o3q4o1eN3jixNtTg>
    <xmx:dvZoaSfd7Eyq47oRLJ0gDxL0BAZZaxNYvzIFqjaRrHsATxHt5JpHIA>
    <xmx:dvZoaS-EQsT8ltrWckvFnmt0QWi2Y1KXjNeq6ZH7ZdK_ZCQCDDVCFg>
    <xmx:dvZoaVRiHCPGStQA2dhwgPl3kqUZVstLoWOu9hnfDHkRyWco_tVoCw>
    <xmx:dvZoafN59PEUOshZthXzsel7UMsbAJztlGq9VCN_LwFCzp4vCl7l5MXr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 09:15:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,
  Emily Shaffer <emilyshaffer@google.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  Jeff King <peff@peff.net>,  Chris Darroch <chrisd@apache.org>
Subject: Re: [PATCH v3 0/2] Fix two hook conversion regressions
In-Reply-To: <20260114185731.2381550-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 14 Jan 2026 20:57:29 +0200")
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
	<20260114185731.2381550-1-adrian.ratiu@collabora.com>
Date: Thu, 15 Jan 2026 06:15:16 -0800
Message-ID: <xmqqpl7bc68b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Hello everyone,
>
> This series fixes 2 regressions reported by Chris and Kristoffer,
> introduced by the 'ar/run-command-hook' merge into master.
>
> Based on a discussion with Peff on v2, I do plan to revisit and
> rework the server-side hook I/O polling & batching logic, however
> that will be a separate patch unrelated to these two regressions.

I've read these two over once again, and am inclined to say that we
should merge these in upcoming 2.53 release.  Opinions?

Thanks.
