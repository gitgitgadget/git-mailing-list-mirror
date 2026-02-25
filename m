Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3E2F12A1
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045814; cv=none; b=JOmlUFnNgw+oIbe8LH5ueodbxqu05alujAzapmv519OnYr8VIFpCx2fSqbpuJc61DWpIHJILFcQhGvYxLsHwkhBdZCmOgO+7eR7yv0RTA2a5LW13pmfa+NZaGrdCCg7Dc2QBIW4gTiJIgXp1QJJ10fnu0g5ShEKAVq75wtZko10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045814; c=relaxed/simple;
	bh=4bYDFWegrt/oJTAJtOs7mkod81Rt3DvS5rdhzfVKImk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qBQHCTULuysrb92HoMhU9xQgX/1etfc8HnVo+AOXvsrIDrfJ9omZkMMSZB+4Q4H7sez9o0/bNatVpFtmgczboSczNILloeoFWEKO11EHjFqzHMwrL8iAPARKZs2idHA2Vb5HeYZWVPdH1hh+EjR0YlYMfTrTyVT6b+cGo+BH/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FkyIw3OG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WRiC0mOO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FkyIw3OG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WRiC0mOO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4DD4FEC0630;
	Wed, 25 Feb 2026 13:56:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 25 Feb 2026 13:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772045812; x=1772132212; bh=sn3R46R2Q8
	dL0THKcoh/botRQCNYKQCt+9BRqP5SO8g=; b=FkyIw3OGpWDJRmbiQjMNUYtTP3
	lx04/mwC78BB8iZCHwy7GYGS2B/F8K3IyWx5xJVDkjooOCd8ubM/Ils6befnrqKs
	H1HlqqpB+zYmUS9C+w1VnWsZ7cE+FwcAZ8cweYUss9r9/VhyWDylvwkL8J9TiIpo
	4Fanq16iAhEhaSz35RlIrWbi9An21ahRQ0FMVx18QUiKLrWaSIl7oCwwJpAq9O3P
	o7UyNVp3qRZENxGRREs3mu/5dTq8Wm5+umZs/xAVXNgYl7QgxqNBEaNu0kvgoDV/
	+cVTbG1TYJiaDgKJei8WEXdBtD5bbOSVUrtzT9qBczgj/zSv40fHa09oDmZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772045812; x=1772132212; bh=sn3R46R2Q8dL0THKcoh/botRQCNYKQCt+9B
	RqP5SO8g=; b=WRiC0mOOT/g1+mHxwQw4KwOKusmIWs35f4le0T97OhxcLSggjct
	Pl3wAp880wQkqr3N+7K/x/jkVxZTR+lZOifMkX0pUYGhRmMbM03pws3f44iWmI2B
	qS5Ob1/vMW32q031Q4tXuvd59EG9kkKJl7we1fk4r8oiJJfUaoZBe35pCL/VEqjn
	rSO/eW552wf1d1C2g6UWL6jDzGrJKJBtH0hQVNRrBU/5WjHqQVN6PymkpLf5PmkW
	0eb29xfPDXLARYSL5zswmAnDcqjLhbhRiHzpmSBozfTwKk2/J4Akdf1fd2SWlri1
	+IgcCJJubaFxFUrxjJwEN6DxEwsn3+uzLUg==
X-ME-Sender: <xms:9EWfadv0J1PrPUOhu6cyhJxSjEX9XVjjNSJHBKT5dvaJwDf30KmXpg>
    <xme:9EWfad76taPgWuPMGc6jirZ3hjtTsqiIG7BE6sJ5dK0TMZ5T-EgKAH2-gKFyA0I1W
    _iWteCXg9Gzm09KPutIIshFRsXviZAwrwbtC5GPgepstyeAq3od>
X-ME-Received: <xmr:9EWfaeJMBTFy5WPcYWUqhYHleBoMRqmEmVuvmhjjZo2UXsFwEcM3WjznbeIactOTy2p15e5b9Tj8X1GvWOqlBwak2hk8DVLNqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhigsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9EWfad5Ld2fXS7lZ5kKS4JAEZzhEezK8KtoIqZ54f0YRES2Mlk5IMQ>
    <xmx:9EWfaRw9_hrCjQX1ARQJ-qvMksOdj1VjbRoNZkxVV1PfslDhA8qaug>
    <xmx:9EWfaRauiJGrzF0YQHUHWPhNodIQwYLpjHS9PaM29l-nyd1MJjidaA>
    <xmx:9EWfaTTttMEuwwu4gAiDbRcfg8ZAsljMqbd9x9qNnjA9fHu07yEsxw>
    <xmx:9EWfadLODtJwlsf2REpMBa1pl-yI9sRzi7e7xRmzNDCSg1daGVtO61S0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 13:56:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: --no-decorate and %d in git-log(1)
In-Reply-To: <aZ9AuD3dYzCKtI0s@devuan> (Alejandro Colomar's message of "Wed,
	25 Feb 2026 19:36:24 +0100")
References: <aZ81X6ERyx5fcm6L@devuan> <xmqq4in4brt3.fsf@gitster.g>
	<aZ9AuD3dYzCKtI0s@devuan>
Date: Wed, 25 Feb 2026 10:56:50 -0800
Message-ID: <xmqqqzq8abyl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alejandro Colomar <alx@kernel.org> writes:

> Alternatively, we could add another level to --decorate=.  Currently,
> there are --decorate[=(short|full|auto|no)].  We could add 'never' to
> also exclude %d.

I like that better, actually.  Nice.
