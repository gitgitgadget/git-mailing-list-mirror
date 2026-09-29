Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4693A257C
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706670; cv=none; b=N8n/F87d6F9iIb7DVUHy4IkgMB1b2PFoKwW/nMHTu8vi4Nbkjf+27zVrfu9Ry5jtsS85ySMfrsM29km+DBXkYjLBbigduAuN96RG66gjKPTUivk+h4PcaZBe2CulxP+AEbT9T9fDdvJdEppUA1sVSfy472YRFdhPowHalyl4NHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706670; c=relaxed/simple;
	bh=Xh7f2Unu2qJq97ziU2hS4J9fmn584epWywXSRKIdBaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VvYKAGCpxLxyVW8/erokWYJ1+jJ8bOzhJGscSj2lz7E8ll7dyGbJaAtoybJa0MoSZGY16u6xrEqvmLvH65NWqDWWBY2qc6plYXyX0aIEAraTnbzDMXP75wWUQEbsmCCO3h2+bNPnGivPf9E3u3PEWW667ZW+PvhVHdpBgAdBB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dmX0miaU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V6ZeLsd0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dmX0miaU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V6ZeLsd0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2402C7A0533;
	Tue, 29 Sep 2026 14:31:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 14:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790706667; x=1790793067; bh=Xh7f2Unu2q
	Jq97ziU2hS4J9fmn584epWywXSRKIdBaA=; b=dmX0miaULlvVbttwCdb9By/W3l
	dtKPx7emJaBa4AGXh35T4ZndH4qd/IFekCD4I+S3vbeEt2C1ksMugq6XGiaKeUnn
	pQpYO7P6iCaz6MHoeTasXJDKwg00rkwh2Hfar5jsFA8n5T0jA7uUn1EFENVWqQsv
	vIkLmIxK6J4CR8yzspP9iNenbgS1RFw9G2M8+kuGjwR/ekTB+Sljd/wKPMLrGBeW
	QzhpD66tMc58TedugEHILGX3iv6yZASoXb0OULXbIV6ma56k477vPhUr8iAayS5g
	+C97ASpifZRZZuUq5LGBrnaj76MGKf5H2ybjOUyacew+l6IlBmh86BpfcrzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790706667; x=1790793067; bh=Xh7f2Unu2qJq97ziU2hS4J9fmn584epWywX
	SRKIdBaA=; b=V6ZeLsd0ru1ZRn40iH+mM+rEmlLD6qzGty4vLAMwepc5GYeDGiL
	SwAyQ1vmyzxwJ2orz7hfv2jxCHxBARwoAq5AL27eJhpBYbvNPYY9upNqzqCsYIBl
	xTGcygLoEvxx586kar8HsVr5p+L82k50zcE3w1a1YtXtyDf9p/8+vZHsT4LPvGM3
	A2M/a1JgSWT5NIhVeEM22uVWRrOH0faqSV3RvxKjq+xTXKUSNQurfENWSxDu9nID
	7HCzE7k8pmzDNQJAOc/ppMaPK51kjt4Eb9B7ujBrDO2oC9+vJp+038MDjTkw1OJC
	XAYxyjpbUOTxX6rMPxsBpfVWD5Bf+GtAACQ==
X-ME-Sender: <xms:6wO8amAVhQge4BcH5z7orp8T4RwTEyFJu8ynrMdrwNUYflxP_l1CLw>
    <xme:6wO8akObzx1ZTHO4W1oSem8_xlwyTgcJFUR0tyVUtHWMnvvN8NwTa0Hlmk-KoaLSf
    jm3vaC92w1jDOOCkwHSi7cBIlO-joIiqG9oDoMMq4N1hdjAWpbq4Lg>
X-ME-Received: <xmr:6wO8ajaoartAqRthdx3dW8qR3U2yvdDRTRMTng2wH4s5AgLcfzuQJ3C6uHx_aHpVVkbcEYSKgv8nXJEkfxfDZWz_EVovHHC0uNdp>
X-ME-Proxy-Cause: dmFkZTGhvCQLdcsERhgvH3I7jQ9xNwwIUXG8KEGB4VixVViBbAsGGkG/hPmTnLYJkqEd31
    3lyjaPbvNtGvmwMvZ67OgJu7lvtMfOWTtqft63gqNBpl46B4rIbupHjDokh94Pfak1Az6F
    +f8kcrSRsMzMFqTAesjX+/vqE8DOezGf0MSWgTJhCP8vtygTD39T6P92tETbjLhhIweXkH
    zu8tQH+TqkyRIkSg1s1VHkO8ro17Z9DqI/IgoIApdh0nrXU/stAMQFcUfDi8FtHE0gQONS
    QpLg14y5iuiu36BojgoOo34iYrGws/9N4wrirYWIg2Qto3Q0t2+xTlVED8NRMRFldmwRNe
    RKeIrPpCG7RWsB3Nhg/VfWdakNZ8ur3MUuJ4H0Zf5yKpRbfzFOR2FnXjiKjF9CEadMg2LN
    6N9Z8pNhgTPA9W0QX5U6xFa0Qh9HU9EDChOudNMSlPfF5k0S48jdryQxDrlpVTUoFaUpe3
    x3J9URbiOKa5Ufi4I1oB4yKslfd2/U4FHXWm7s8H5j2R/+NaN9loIkMChy+Y9u6VFVAfiS
    UwVuek82PycucCMmrsMcbtG1a4iT3NOqkjnrcV/eQ7Kti+MPKXuezuOZE7JzRQaICvbEWN
    rZtR2mA+po4iqvcq2LerfpHi8GKd2hHAer2HZ3QySgZc8Tc6G4CwamvWcPQQ
X-ME-Proxy: <xmx:6wO8aruSP2noYHXKJuAKRqp9aEgTpeUOZfHbcSXM8oEE9JHvEug7RQ>
    <xmx:6wO8atNKv8IxRct6Mz5mIf2J9Nz0In0b0u5DjZK2MpMivn2ebEQjmw>
    <xmx:6wO8aq6MYExzQrNKolCFcuPUXbcoZy4K0f9XRsHl8YZdLSOeXDAfsA>
    <xmx:6wO8arSw8OXVzobC1FBg8FhIqnfa5e8bR6lVEMGWNvNDj4WzFVcN0A>
    <xmx:6wO8ao8EZazzQgWQ7itxzuNA2ZiHYVRFz42KUb3r7wFNjQuEu9MoF-US>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 14:31:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>,  git@vger.kernel.org,
  peff@peff.net,  r.norouzi@proton.me
Subject: Re: [PATCH v3] reflog: fix default expiry periods
In-Reply-To: <artQhZKf6JuRhmRl@pks.im> (Patrick Steinhardt's message of "Tue,
	29 Sep 2026 07:45:41 +0200")
References: <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
	<20260924175843.8383-2-pushkarkumarsingh1970@gmail.com>
	<aroQ_zZvUXKKK7--@pks.im> <xmqqy0clo2em.fsf@gitster.g>
	<artQhZKf6JuRhmRl@pks.im>
Date: Tue, 29 Sep 2026 11:31:06 -0700
Message-ID: <xmqqfqyrhpud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So even if it shouldn't be 89 days, it could very well have been 88 days
> without any risk for test flakiness.

That's fair.

Thanks.
