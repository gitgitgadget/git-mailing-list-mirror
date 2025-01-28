Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D81DE4CC
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738085579; cv=none; b=Ui3UbVkaGjX0x+vnBRKs0SgQ9IIRFSB77xfBol6ItTuM2WNsh+Vp/3NOJVSywzZJ4xMge6EGA/YdwmG/ahDrdVgOXqitmMwB0i1XUflukUhbCPDydViHc4TbaCZAa8NByZf1ix4owLjQ8GU6lwTRI60vJGhXDUM4sw+rc9WRUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738085579; c=relaxed/simple;
	bh=i+uoBjqSbICJqh+2aeaAe7aCJVjQMpF0bYCdztgbZGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jC5QXyoFQ003WRL9G+HX3+/LX7Lsm/gAmrWZ2TC3ySocoNyi/4ihs0aX7ZhPA16W8tIRyrtKrcryxJqbqJuvXAzqfFnb885bFEI0ah3RdazoQ3Yyt5uVbCckyD93HWUvEzYlWNSPAc973CKZyJTLa4B7ptgKPrWvDLFei1PSjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EyZYYtFq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U1C4F5wS; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EyZYYtFq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U1C4F5wS"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD758254025E;
	Tue, 28 Jan 2025 12:32:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 28 Jan 2025 12:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738085576; x=1738171976; bh=N0B2g83ZAd
	v0pITpFaMxuy7hsp5Tn0hUFtycAJ2vy2s=; b=EyZYYtFqoSVeTNS55MLpeRdMCQ
	QbvKKeaaPATVen6LhOnd/sSCSepntXIzZgXMr0bUMJTbnlwsQ6+AIU20AbiFcG9n
	aMQG9whhPNKFhA+2UeBUxhU96VrfUWISXe1bDrBpnXolgEkenXejAFLbRE1fGDoA
	UGW53JwsDDbvNDVNpfxRXj/ItK/Yx7mALS0MyKFToZF+e0pMNoLZ4SEzS+BEVhaY
	+0eRn7jAMheLXWJaB0Rqv9vI1VX/mX2E0uvyNTXeQmSzq+ntTT7mtC/dqha5CnqJ
	C0+Bh/eF3SMUBVoi4YpZpZrBTEQG40wCmQVy87SUpY69026N+ZFlZ4FFCv/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738085576; x=1738171976; bh=N0B2g83ZAdv0pITpFaMxuy7hsp5Tn0hUFty
	cAJ2vy2s=; b=U1C4F5wSWYYmU8X1tnleTiPKGji/WFHPYFpODErZnAgtmdNvCJU
	9fsPT3E1QI8Q4v3w41NzeCUgHPrY3bAtdmAI3T/no0vw3ONuYDXbmz/Xr1PCG+ZK
	hUeQHNvoEq1zHTcFE2h/u1i8bgpecEETmoBFNtN+7BzbE5yxrKniYlc+6skkHboY
	BKCcTOSfoYjk2k+onjDMOzPAkSDmHA8VFa+QQDk7vdmQoe7gCvJglv7ciynmuGXW
	SrJTsHtLCtdFzB5nShaDMyG+W5eEf6CYnwff0KYzgkTrQaSTj10HoyN7eZKYAqsZ
	2xURJfmyUB/BMfT1Qcfh5EBjS4hTudVvcTA==
X-ME-Sender: <xms:yBSZZyMkd4rihOtAt211H2ISpmHNYqPQPH4U_B3JAMYDSu3UPP5pWg>
    <xme:yBSZZw_xa_FpX9Zoh22VBbGLjuulcZMgCdSefpXzPTjlX6MFzcvMS9rNhnvW77krh
    LU1XG4iq6LqC7PgCQ>
X-ME-Received: <xmr:yBSZZ5R1vfiytAfLTUGjB6QFCRI7Itjni4rziBOP6qqhwQ3mpVwXqx24NUw8n_9ECMR-hEOHQa9uIs0XZrqkdo3o0kvGPTLPekEi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegv
    thhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yBSZZyt0oSEP9FNvPWKtXVpwFl_Q4_-4LHiZ06c_5fHdOYnwM9pD7w>
    <xmx:yBSZZ6fcBP6DQMnDTsItjN2Oyw4DDyKkFwJmc48EcTOhW3VhyWbiVQ>
    <xmx:yBSZZ22ZKkP110nf6lfZofUq4hqYnIsrewHY_FJ6arS3iDr88KzTbQ>
    <xmx:yBSZZ-_SFEgwfka2X-iZxXw5GsYPOe8PA6pHAYbAVPpmmJ4I8pTJAQ>
    <xmx:yBSZZ54wLnwM67I7iDfVGMHBNXGw8CXfU1Tqe9gsVQV_yTT7pdTFwjSf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 12:32:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 00/19] reftable: stop using "git-compat-util.h"
In-Reply-To: <Z5iTz69yq-IF9qU0@pks.im> (Patrick Steinhardt's message of "Tue,
	28 Jan 2025 09:22:39 +0100")
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
	<xmqqtt9krw1z.fsf@gitster.g> <Z5iTz69yq-IF9qU0@pks.im>
Date: Tue, 28 Jan 2025 09:32:54 -0800
Message-ID: <xmqqo6zqoncp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I guess time will tell how much of a problem this really is. As said, my
> prediction is that we won't face many bugs in the low-level code, and
> then the question becomes moot anyway. But if time proves me wrong I'll
> think a bit more about potential solutions.

Sure.  I am OK with the approach of playing by the ear.

Thanks.
