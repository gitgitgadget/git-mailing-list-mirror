Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF620240223
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807242; cv=none; b=Adm7oqiill8uddROZEv0yVwerpwA62+4BIIZ+AJWD6Ab1CToG12/6MavhtyTkjMNZBMuExma1BV4+BUCzRwZMYPKxx7DBXKikBaRjBeJdF8Fbz9dTrgx45YthYymRTSZ3vSjOnqllRbi3pBVxmpufTcXwCRixMPq9ylwnK9cn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807242; c=relaxed/simple;
	bh=qVzvEJU5y6lboJeGoUwVRHfCt4JMCfMdX0kxGU48Om8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zh5SuOTv34SF6yCtfnsvkWX2ifdB4+xWy/Mp1fPTZAludWLSKnXvzC4/Igzo++pOtraU7Xj/EacdBLGSJb8ZLBI1VoRoxtgVhrLhCKx2o78yNbcGOmtHoyKraWhj8yORBgxm7REqIgkXG0ycDhZMhWg8/zmsOZjgNfXaFtdHpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eX0Ggjcs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rQ+MgVkL; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eX0Ggjcs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rQ+MgVkL"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EF711140171;
	Mon, 13 Jan 2025 17:27:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 13 Jan 2025 17:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736807238; x=1736893638; bh=etu7CnkSwB
	zfzz+jGBVDviu5z0xpQzGtzP1O2p7D2Yg=; b=eX0Ggjcs5ZOni10kinUWm0v5gZ
	wT4nvvCQd8tr4lFNr7tzpTRC2bANIZsjE3bGSbiVe207dB5LWrU9m0jxMniZI/r+
	2j1w8/W1+/9GuuDTEG3wtmqUQBpq+KlVb3Ijtbh+RuFP58bSvJ1IxP41GX3Nq2v3
	0qU4c1VMrVcVRJX7qxB/a68nzZdRdDc9TvEhqxdfFyMUAq8ucQObGFOHfIkfyvHQ
	fJV5mjjCFX7HPUIPpaounhY95dwJEjUOXeQrfFLVlA5BF/53W3AjhawvwbdliMyt
	aoL+HyF8T4JKMFdEW95SbAdpjj7r054UfCrIfDdElK6O4oTSc5lG9bboB+mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736807238; x=1736893638; bh=etu7CnkSwBzfzz+jGBVDviu5z0xpQzGtzP1
	O2p7D2Yg=; b=rQ+MgVkLVmnTH4crZJoSPeA+7wAeA8c0dyeEpeEPupc+a32dKiE
	V1Feampbw3UaLZmTu9WcOELY8x4lvtzhnxKcYPLjP0egT4HO0u5+iq39LzjGlKLX
	Y1a9I9sOW0Ha/XEvFqS3C55x5uXtDcVOQoDFx5KFmF64DESE/JCK3sBj1Os1Gcjr
	RvtHrZLsPYLQIjyP69IE9MwUIcVac4KLz9U7PQKj+qqkp7rudRNJ2wuvcx6goDFU
	xq9W5FLdjvlro6gsuKArwgqxNOHCvltuq1rcW+5OXjXwUiKij8r6+ai8GiMTO8Ni
	J6rYyL9Xdl/B7OygAQ+4LXREI1QphNc3ILA==
X-ME-Sender: <xms:RpOFZw7mYrT3FD414FT5YVioiTbdhq-uwH2ccnhHG7in8WTy9cByBA>
    <xme:RpOFZx6kqin05isiEhigZh8UjoP8YzjDtOC3A80iUApuapu_pSgCFP8PbEGDOc7-k
    c4_biUjLbl757RumQ>
X-ME-Received: <xmr:RpOFZ_csI1SHtXKUdpeeiimu9BRRNQF_Rht4_b-I1RlMDEfAlJYOEuE16HCwadLH9OUAkGn_Uh3crgr7f99Wzv__8kyKXlb0l1HN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmihhrthhhrdhhihgt
    khhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RpOFZ1J791d5exX83kD85yKtaM7VNUaxNU9At2Q96o1x_7t9EKoHNQ>
    <xmx:RpOFZ0LyBtWT-B0_5TomQzBoTsC7HFpNtY6akogM9mUy7SCzllabog>
    <xmx:RpOFZ2wOWwN6TsZFznrK-azZy9N8nON2BadPSPXU0svibgu7RGGYRQ>
    <xmx:RpOFZ4K956LbRWHnkmh4ZsmR5QKiwIjwkaAgkIGF1JM-y2pebfffPg>
    <xmx:RpOFZz9B49q1PXq1DNSQNst6R99LzWAg28a7z6c-f9q8vR6B0W4q2puo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 17:27:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: M Hickford <mirth.hickford@gmail.com>,  git@vger.kernel.org,
  sandals@crustytoothpaste.net,  stolee@gmail.com,  avarab@gmail.com,
  peff@peff.net
Subject: Re: Changing transfer.credentialsInUrl to default to "warn"
In-Reply-To: <7a60c9ec-8f98-73d3-4539-d96b63a4f442@gmx.de> (Johannes
	Schindelin's message of "Mon, 13 Jan 2025 22:53:46 +0100 (CET)")
References: <20250111071500.710169-1-mirth.hickford@gmail.com>
	<xmqq1px6br7p.fsf@gitster.g>
	<7a60c9ec-8f98-73d3-4539-d96b63a4f442@gmx.de>
Date: Mon, 13 Jan 2025 14:27:16 -0800
Message-ID: <xmqq34hm8i4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The reason why `.pushURL` was not handled as well is that it is way too
> common for Git users to call `git clone https://<user>:<password>@<host>`
> ...
> There is no similar indirect way to leak credentials into `pushURL`

Ah, so it is not primarily between .URL vs .pushURL, but the
difference is between "clone" that leaves the URL used on the
command line in the configuraiton, vs "push" that does not.

And because .pushURL has to be explicitly configured by the
end-user, there is much less need to remind that they are _storing_
credential material in the configuration files.

The reasoning does make sense.

> Having said that, I would be in favor of letting
> `transfer.credentialsInURL` treat `remote.*.pushURL` in the same manner as
> `remote.*.url`.

Amen to that.  Thanks.
