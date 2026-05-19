Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1E1E1E04
	for <git@vger.kernel.org>; Tue, 19 May 2026 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779160764; cv=none; b=Dzt92mjTKwEigmZJjGWzNhpFX/impOakuqdqUQXQuYwnk3T60G43Yv+MOjg+lEuEiAdwFT/SnZbB+yoHaDa70NwCF17GqeQuP7okmcgwS7QREqDhRnLHj19b2l+WtE818reuHI5F/6suT2sXqtzQmsSyJOlSWEDnrxVzNFZqaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779160764; c=relaxed/simple;
	bh=BRlR1ZlEkGCr7D8/Sl6v63Vs/m8+UyN6aR86Ylyzics=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FEo7FTvEeAEvkfwKe8zSio1ahCDUs1++Cv8teQtB8G5Lk6Gpplm9KGksIh0H6XKPKmGn+i0j19A6jvRBNqxbHQawMYM/4xZ9tbQeXBIGg6es52sTm7mF31CmouJoRDTk/6AphLEO/F6wywmcQguGfdeg5P/EAY94tog73zeyRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JgY+GyLI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eKynj5Ej; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JgY+GyLI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eKynj5Ej"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CB4EEC01F4;
	Mon, 18 May 2026 23:19:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 18 May 2026 23:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779160762; x=1779247162; bh=P/CMND/bhU
	i8vq7F+sjSlvv0IhauBMElDEdEkiduUzE=; b=JgY+GyLIUiSyzrsnoIx4HyycKY
	swyMgfZgBQthnAJTvw+dNBogGW107a7h6HFD/jOtHFfm/DgOU+Vq1cZdyjGiwGHe
	byPQ8U0NSGRDxA0f1TvnphwI1KuIDm18azVZq+pckENnWUykxZRu0HhE+UyYx70G
	yluXRnrCkaTXi3NbZz6K31bJ8+0TfPfR9J2OcSb2gVF4vICnRHS/VGh80A+E/ZtP
	QIkGtAoOQASagEJMWCto5IiEaKGFbrcdSQV7P+9vONcBi97e84018ES0gZlnpzCM
	lH4ahUk8B31L5BcINec0Mhv+TeLwR6urC6Cb9gjxt+fkSG1kLUVdlD6IvFbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779160762; x=1779247162; bh=P/CMND/bhUi8vq7F+sjSlvv0IhauBMElDEd
	EkiduUzE=; b=eKynj5EjLrY3PduoT3TmNLB+WHEG02T1JSAs9Z6YJkmWJoyBWW6
	uLORZ+oMn+RwPGbKAm6e6NXZJC6k/PIpJIRsxFqJJA8Aj1j6S2kLIcQKo8Ck7aMn
	LqkHUN5KM3zXzxKlMEIb0BuB2QZ7FCBAfdx5Nn7u8fjz+RWVAdHTv6xoN98pcPRG
	OlfvPba0d/1j/MwM8QupORi6NRLmLxqAHPQmoEwBRRMHgXTlJP/DdDGbdDBXrWuD
	IUbGf5L0O4AEie6q4a2i4mpXn/WxOrKlZSO7VbSCpGMYWUs77MZkqBWySDDPnCHr
	uC7LftEZbf16dnsYY1wM70+ypOghp5AxeJw==
X-ME-Sender: <xms:utYLamXP-_Oy6WGw5uTvI3lfOR-6ROAR_7jirW_AGldgN1ZwSdYFxw>
    <xme:utYLaqADepfMxtcAFOEVjjwIVMSYxAnMTsGqJOy0FEk1JlxpyAJlREKfBanrIX2ik
    SR6d1EgOA0Zy2FURVEQ7RrEF1nJO-YpNchK1oJ1-Wtf2AFrrk83eQ>
X-ME-Received: <xmr:utYLanxTM2qIt9Yp1hbSinjef3R_y83sVzX7o2TJSaZMGPvPb3bSaBx7ahHcRy2ugor3SErS5nRZ9e6Q2HD8Th5-6dFhl6Iahw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:utYLanB39rvpqFy_BMhFjV5VRo0FiiE1X3XoJ_c1dFaFTuHC02VqpQ>
    <xmx:utYLakb24BxJjGLBFnMRF92_RP9z0ixJBpyekX8otu1TmNu1ytujIA>
    <xmx:utYLavhAJTCiHGsglpvgK4jnmfLNlHaPzwguyEioL03svs0qP39PYQ>
    <xmx:utYLam6Drlrt6mtYfldqfLSfNRZ-SrtsX5q1IXlsx73MwnlsA6JTcQ>
    <xmx:utYLauzndRp7Xnd83WEl8dDI-eZ06LjwctXPqT-l1hR2QDwvfssQPyTU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 23:19:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] small quote.[ch] cleanup
In-Reply-To: <20260519011837.GA1615637@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 18 May 2026 21:18:37 -0400")
References: <20260519011837.GA1615637@coredump.intra.peff.net>
Date: Tue, 19 May 2026 12:19:20 +0900
Message-ID: <xmqqjyt084sn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I noticed some unused code while looking at an unrelated topic. So
> here's a small cleanup.
>
>   [1/3]: quote.h: bump strvec forward declaration to the top
>   [2/3]: quote: drop sq_dequote_to_argv()
>   [3/3]: quote: simplify internals of dequoting
>
>  quote.c | 21 ++-------------------
>  quote.h | 14 ++++----------
>  2 files changed, 6 insertions(+), 29 deletions(-)
>
> -Peff

These were very straight-forward and pleasant to read.  Queued.
Thanks.
