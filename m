Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F21DD54C
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470894; cv=none; b=K4mWl/9/tUhDTjRfzDCnB89vYI8qZmpA/9wdaA5LQr2XiUGLvQP2nY6tEahLpDN/jJlEfr21I7VewJHdAM553pCppL76HLOZaQQV5vj3i/ynJOI1Wo2E83hT5WruQ53NJMg4x8oymNRWysn0W591saXJnmi5KpNAM2lEK+LU08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470894; c=relaxed/simple;
	bh=pcnwlxoyMJfD4sNE2o7RgKF0i8VrAoMy9qy5vhn+Diw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p0axJL6mWNPxH7629nlr3TKgBMQEwr6p50lpUFrRT28LPHn2uV5eJhOHaQnvDZAu5ySdxaxZRmQUBdBz0hbgKp1Mw4xa4JAva/c+VRBrpbCUcyveDJNFTJDU3vo+oYCG2Ehkl/1Z2p1ZAZeVR+nAjZHlK6XoECxGrmR3mrMMGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TSi48izN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrZ/aWJv; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TSi48izN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrZ/aWJv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E2C91140124;
	Tue, 17 Dec 2024 16:28:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 17 Dec 2024 16:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734470890; x=1734557290; bh=V26UCDh7TM
	3oX1aEQ8n1du25e9lxU/gO6/AZUuskhCQ=; b=TSi48izNubt36VixMLhMuUsCk8
	wvtUGsABS7b1m2utaZzZFM6/zYv4ucRTSc9D9r7a1bnfe7mSP2SRzGzLxoyu3aoV
	cKeJ1g8jr7GbOTMoEmGUXlCTnQvK+BYUdTZmU7EwNVbwOg5Lt/u1K1cRU+Py2emv
	6+YDQupGSMC+EuALaFZK+WpKL+0MgPUWxU4Zmggbq5Z103/gUzq5s6f6YXpL4TVT
	4QIiFQdDxx8KGuF6Pv9fAhcwJQ7n1ZdLiLLbW+ZgeWnqVELoRoPeDhnEC20C6GWm
	EVDEqaQVPjFCsGb2SMEnbDBzDd4Qshjeb513OvnojudeWsCl7vCVF14jXwFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734470890; x=1734557290; bh=V26UCDh7TM3oX1aEQ8n1du25e9lxU/gO6/A
	ZUuskhCQ=; b=NrZ/aWJvdJ7HPRWe/KMeXxuZs9VePGDYMwNo1NY8wkLlZTHAGpE
	EVc8xbJwTh2HkC8O1mUVgoye53njCeoBEy+MX6Ka2598Us993/LUYz140kzMMj15
	dKVxuGARgbKL2ucl6nVK4RbTRotDct4W7L5Ciw0Utr5ILrMOndURt3r7M5uncNYX
	0mHG6KltdBIcr4l8p+hZ8kwUqq6E1hiuWnB35d/V2r8LXtwj0OwViAdpUxn+vNG9
	Tv2Adl7i1E+idRzhQaJ5NAZdZTgYEqA0xD24JbkoVs0g4TBVp36xQbUfw7CrRgix
	8QDzOat74xcsRbwcEUiJ2d8wOMOmIFu7QEw==
X-ME-Sender: <xms:6exhZ_zUUVyPDWnjheWd4YFRo0-bGd9SLzACPcoc_1-SwrUE-qapDQ>
    <xme:6exhZ3QzePwD1hxuKx0e7OdI5cq0wPCHP-hxLgoPCMClfzHN_byWnejF8Rmf02kYX
    1v38oUPj-etCRv4AA>
X-ME-Received: <xmr:6exhZ5V4uHsP9ZIxbsSLaTDD2CJLB8Ds_FImS9kbDx7CaUJ2qBR22FeVns3HU5vzCGaKymvLcOH8DI9QGzSveuXRcM1t4csqYPuVI8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstg
    hoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:6exhZ5ihIA6qCqlE6tQnhTPUw4eo3rvMe74ux-5gy-D57ygh3Qi41Q>
    <xmx:6exhZxAid1kLtJaYvdEoaWVYSn1N1FOwbAx3qcUO-ztd0bEOeqRvwQ>
    <xmx:6exhZyJ9-uc4XsHWVzfCBPdvHsDHE0l1UYi_CMpbcFazGfF3nwxexg>
    <xmx:6exhZwBlCRzC0aoXzxy3f_3UPxzcZJFmsU4z1SwHHUVr6ZxRNQNGig>
    <xmx:6uxhZ07fYcp-G_22fYO6yCBFFMqDS1OAv5ceC-o3obNvIvWCvsQRihSV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 16:28:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 0/8] refs: add reflog support to `git refs migrate`
In-Reply-To: <CAOLa=ZSzGk1FqiciTktTgv4J1uH6CW6VpbxXOXdKmrXJtR6iyQ@mail.gmail.com>
	(karthik nayak's message of "Tue, 17 Dec 2024 01:35:10 -0800")
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
	<20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
	<Z2EhZpL5V0LlhEvj@pks.im>
	<CAOLa=ZSzGk1FqiciTktTgv4J1uH6CW6VpbxXOXdKmrXJtR6iyQ@mail.gmail.com>
Date: Tue, 17 Dec 2024 13:28:07 -0800
Message-ID: <xmqqv7vixamw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

karthik nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> The range-diff looks as expected, so this version of the series looks
>> good to me. Thanks!
>>
>> Patrick
>
> Thanks Patrick for your review!

Thanks, both.  Let's queue it again.
