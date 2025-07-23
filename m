Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9FA2FD59B
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283008; cv=none; b=FQSKANKeFm3O7J/UgZLzlOe+c6IH4oD4zjkfvgVSIT0N5DbKrv9cP3V0f8YJSJdqRetvWJZHwCED84ZhV/lHom6Hk3qcNlOD48VS+oMuLH0rL4aS8Sh0zs8zuTu7kZ3sxOeULMDJE1vF2U78wkuw0/mp36Mhgp3a32bMaI60iXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283008; c=relaxed/simple;
	bh=3x22tYMsvO+S5Bsmrcz6h90aObDIpB9PBbQZJflvX24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s8GiktVey58iHMnuzQ95IVpp6bFV7UHMTKaJzn7FTPn2FQHXSNyQ2C53UzhVqCFHRiAhTAVlJg5CiEHjHuVjawNttWMRF2F6DWLjgsbRKCN1kOgEG7eUs4xUE6xy7T9RwrmdiM+bNEgILo4PhA5g8jDrBnf85aIbUmhzUsEAbLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MJ1s8kVJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZGr5k8A4; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MJ1s8kVJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGr5k8A4"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B331914001FA;
	Wed, 23 Jul 2025 11:03:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 23 Jul 2025 11:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753283005; x=1753369405; bh=YavQb67wUT
	Nd6D6zXwt0Pqw8UgoF1ND8M9y42VonRCU=; b=MJ1s8kVJ0M5BPJfuIxJuVk92hr
	1MXaGp+kvDpvUl5XYw1kZelxb+azdv/oPdyO3O/q/KKRo4ceHMXJnL0XG9pQfcca
	069Uwsaax1dVMsDDRiFwwiNYfdrUthJkzGzHdrHpcHsMQMGIR7DBQYGN8lrHDbzK
	H+8BFZ9/oq6E5ZtZfR20C5XQQno+/7hgVjrxCVKNqsYCPtQELfZ6hM2N7gbogvLd
	81BK+A9Zt1ZjB8HyGjIJBahWKmNAjX+T/SQIeEz4xf1lXdaXc/jZibR98yANLsUK
	l/rwZKas/5OrWKJg+XYlJnI1sOBd4CluU3WO+TED1gDuaMjGf4JO24gMfwKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753283005; x=1753369405; bh=YavQb67wUTNd6D6zXwt0Pqw8UgoF1ND8M9y
	42VonRCU=; b=ZGr5k8A4f29aZ1dsIbTNKMSLqiKYgvHHSTvDA+c8v9xn50Kl1tF
	77Y9f+BH1UaTaNoWsdUYArGtvbg4YmaZC6+tnMVfOCafVQkeXcbo9lISFI78Id7d
	yGoAIXpxqkdLfFEvfVtCt2K8YeOwWGBwm0s1YMwfe5vS8F8qD6NItzmYpy2kWNQ1
	QEUJGBdSO5wnAJFROHqpkcRMRgisjr8n5mBRvX1pDEg50D29BaGi7hQUDDyVwLdd
	glsgQE+UyZ+9zdpiI0gbAf7dT/PbHMv1glKWqTykx50t/HWH4hkXm/UBWjs5v8C6
	aJeSIntzbBNVyhyJ4iS6f9JJ8qNw1ibiCKw==
X-ME-Sender: <xms:vfmAaAYznK6U4TEOYztSFmYG2lcivbgCRxT4sAm8fB_qMT2I8njAQw>
    <xme:vfmAaITy_nJkpqeP7iBI-pOegHpNaFO-GWmupeMnyR-HqUtQcMOcMbcG_b5AaFUxJ
    l_HQCSgC6_CFyOnjg>
X-ME-Received: <xmr:vfmAaKuPrBtyCWSXfROTrbDRvKaOCXf6RwtHK3amrwUr4VvU5bFtb7LM-q3VDW_YkdSnxK8gP1ZEiLtTF0BuvdwoSVcKi_20qa9RqAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehfihhvvgdvfedutddtfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vfmAaKH9sA5zgBgvJ4VObnhNvi9voKcxMhLPQhI9UjeNyG1mAWYeuA>
    <xmx:vfmAaLxZSMXQtG-Iv7qGoNPa8pWh3eXX1DUE7dXmsle-MPhEf69Cpg>
    <xmx:vfmAaE0ZxIrS_QIWSE3_0MLZ4RZiN5Yj-aYzByoCXgV_j1kWWcvjsA>
    <xmx:vfmAaLraAdWuhHoK0yaBFg1NhbkpDw1U1uuv5LBF4tR8psdj56G-Gw>
    <xmx:vfmAaPRLNPPcBXPpUJBQ-L5SNhxTE224UVMEx-haq8tI3fc_j75_T4q->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 11:03:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com,
  karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>,  Kousik Sanagavarapu <five231003@gmail.com>
Subject: Re: [GSoC][RFC PATCH v2 2/2] t: add test for git refs list subcommand
In-Reply-To: <CAPhwyn0wLrTy0MnNYdQvoVPXUz0PyXDB0MBsDHnDR_zgA8mZmg@mail.gmail.com>
	(Meet Soni's message of "Wed, 23 Jul 2025 10:47:41 +0530")
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
	<20250717075009.26262-1-meetsoni3017@gmail.com>
	<20250717075009.26262-3-meetsoni3017@gmail.com>
	<xmqqbjpi5y6w.fsf@gitster.g>
	<CAPhwyn0wLrTy0MnNYdQvoVPXUz0PyXDB0MBsDHnDR_zgA8mZmg@mail.gmail.com>
Date: Wed, 23 Jul 2025 08:03:22 -0700
Message-ID: <xmqqseinosp1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Apologies for the delayed response, I was away last week.

No need to apologize.  Everybody knows that summer is a slow season.

Thanks for your contribution; enjoy polishing your topic.
