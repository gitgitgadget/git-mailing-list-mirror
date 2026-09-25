Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872B2264A9
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352815; cv=none; b=KHNvGEeZG5ayhBh0ki1MnN+Ljrdfj4DjcEdcHRL2gkJpYGHJ2dLIItul/Ay/GCSnvIAc8q8+30+31HQ8njpl3v2wFlZqhlm8wL61IaEm4QNq3DEmTwZ5HHnLyNnVz3Pe5Vtw/KVhEXTLP5WOjhVbngGPWgarmC8WLurnF8SBPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352815; c=relaxed/simple;
	bh=hM+8tkMG5VTSOAAhcjjXobRjSrgrqOYijfZ2wZrjXME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RXmyJuQJD3io+FqBBvyUOxqya7OJDsazcCpVR18yZrNNCfyC6N+g4Z7eEX6i/KKEaBCdEVlCr3udwfWUDCAiOOIdQztmrK5GKimopiIZE/ffJdPH8VCcKywCWfloigBwrWRgzS0gtKxjl0ywZ+Hd2bHwtwO0wnh8OaP3tFhZqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G9j494bv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s/jVNHmv; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G9j494bv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s/jVNHmv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9573B14000CB;
	Fri, 25 Sep 2026 12:13:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 25 Sep 2026 12:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790352813;
	 x=1790439213; bh=jDromobMbmQcPy0aoLeJgIgwvfEOhmJjhbstU2Z9BDM=; b=
	G9j494bvWTijL19OdW9eYlH/dB7by6HcnezM47f8nmqdOOBKrgJGavMwMxvawgJE
	w3PD2JoqrRGGTy2oaUXfparvjClRrp9+6wdWVU0rNCWaJkPYh7+1Ul54aHr8eH32
	0e9dbZoRVoNIM8mSmMdkYJQqkJfXjWnm27A26bqBsyF6TgnANNXqhoTe83yjV7Ld
	BTmKLBhK8gxzSO8TRYJ1PSAYIukkukKvqVKyjXdaZC4ayHHgkEREXo2MTp/i9Lgj
	NLDkcFAIrQs8YRboI6JrFNJZUUZYlSzaYixylVzCeh53/fqiFvYRB0jNk8QFtDR8
	Q+Zj4RO2VO4jS/Zk7XgZKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790352813; x=
	1790439213; bh=jDromobMbmQcPy0aoLeJgIgwvfEOhmJjhbstU2Z9BDM=; b=s
	/jVNHmva7+bSNTlb+T76+HYZVQuHdBNXgpX1Oi10Pu3Wnxx/g3++hDftSF2rIE7E
	nH0OtrWJKmIlpQO6QTGpcuFwMI4fk0rWxJSs2MMD1u31moc2gqHcsRsfDgXCtQe9
	O6Es8AlCTyFvccdtLAHgEsEBP05I1j6M46w7YoL50wzz0+7xlLuVoP3hkDOIo9o/
	fLXHx/HnNXjZj7Zbkb95CjbUNehfUc8xci1j6izbIk2F7V8nPdNIm91qq7YBoig9
	F+7+AfprxdYht1bVguvarso38UQcE60eKOiujd+/ShNEO3oWgXNnkYcAa0x2IIFF
	M3pRp6mtvsSYmt9MzF+ZQ==
X-ME-Sender: <xms:rZ22agXKWaOIcDNZ34-l1cX3_9vkG9OaqHLahIYxOv3jrXdluWuYlA>
    <xme:rZ22am2GJcpjlYREJWpJoAMd6AUZDKZAvPIIPsJS_sowsVs8WZsZhYbjyQ4ZQvuoo
    S-eDcacj-iWNsAW5wv0ejeEv4GV6D0syX7Tdh432xEF2vkj2jcaDIw>
X-ME-Received: <xmr:rZ22amoGgCYdW4ig1wr0aUYI22-WyXtB3-m-yZnHXsWlHlfi75z8m7clY_6BqefYV7CGMUgEvBMh1YtYE3AMxQCi-aIP1mmw6by7>
X-ME-Proxy-Cause: dmFkZTGgRatzYO2RbkSFyzMm9w1m6zru11aYPFZaehCCWJhxMwG5d1lItX18tTZYqPBTki
    WICAK10yvwllOzHH31VhZ9ecs5fxqYIre5Id6+mCF8yond8H5xeSxSOTRKdtO9fEfBf6+Y
    i2yAsqclCJNX4aGTbZ7j5yYwxn5OvRjPbbQXww2xp3dKeUu0UkmPi3nz8O/3Ux6X4a8EVE
    DbqpXAn6SRpOZzWibDmRdqqgFNbn5MS0cxVzwohJ24JhhWt5WSGAMtcqS+RXmtiZDynXby
    MB7ys2Cldyr38fdrdUgD/nJo+7bqxJa6uAyBzkBRn/+bgJJ9UEA585NF1Vd4jcwtN12idS
    rC3EdbenA7oeRKDZbX/1qdRQsnvTbLl4bvX7bo2F1/89y9FOAgWXUpMjLz3zVJSnIzSVZn
    xd9LJ9zIgZ1SkKFnwOLULtPkWCZIE+De0AS9KP4rXGl/DSBMsrTgZ+Emze6r917dIat1N2
    stuneEpX5OizH2QPTNdRxel2+NbE7DakhSg6bsvIvuzSNv9QNWavb5NxQKHPKCTslofqok
    1PuLGcw/q7Dqc64pAswMuo7t4g4J2m8TZnEdYcujCmGIu5vTaaAaXGxa4bmUCfxebGNfD3
    hNeuNKYLYXg5GOPWhK0CpmRH0OYRMjHIl9JP0nvd+F/eNntV2iEX12IHslmw
X-ME-Proxy: <xmx:rZ22alVlrc5UaDBObuQn_GzH5UTNBUWlrTGuvSjJZ0OFqZuP0COnnA>
    <xmx:rZ22apZX7zAomCVyqNuhOGsizxeZoFlHCftbwfoIoMrlrZgsWhYNkQ>
    <xmx:rZ22aqduLgO5XspFyDHQiyhITFBjGTZKYuywcijDx-ZlYjsahsuqxw>
    <xmx:rZ22ar2C_VknIp00uB4I3bxaG6HoiSAr5Nwu_pA7IH8l3JEnctUh4g>
    <xmx:rZ22ar5NfZjGqkFSIpvxNkNLDsTcH4ieSPofaOO8dy-oqHbBMj1nwIqz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 12:13:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  graysongordon-gl
 <graysongordon1@gmail.com>,  git@vger.kernel.org,  peff@peff.net,
  avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <arY+2p3YZWlyL9Gq@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Fri,
	25 Sep 2026 11:28:58 +0200")
References: <xmqqecfez7ie.fsf@gitster.g>
	<20260915162348.97792-1-ggordon@gitlab.com>
	<arQ/nOH+o3XwQFD/@szeder.dev> <xmqqwlsb63o9.fsf@gitster.g>
	<arTUNYVvCNwX1pDp@szeder.dev> <arTYVLnW-2GHpGGm@pks.im>
	<arY+2p3YZWlyL9Gq@szeder.dev>
Date: Fri, 25 Sep 2026 09:13:31 -0700
Message-ID: <xmqqtsndwbpw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> Do you maybe run with a curl backend that doesn't properly support OCSP?
>> But even if so, our test suite should notice and skip the tests.
>
> Apparently I did!  Removing 'libcurl4-gnutls-dev' and installing
> 'libcurl4-openssl-dev' instead makes t5585 succeed.  Go figure.
>
> Thanks for the hint!

Thanks for collectively digging down the cause of the issue to (1)
help your set-up to pass the test, and (2) point out that the
prerequisite setting needs to be improved.

