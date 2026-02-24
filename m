Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16AA330659
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771964730; cv=none; b=l8MhL/hDRQQN0vscM/irQELDCsZG1Eo82W4nQmWgbIsYKEYovvvuylavo1BBoB7QADFOCOgnnHmwi36PFSNein38q8Bkb0NONAsa6ODNElpNSwjaAJmrSq2jFpxZSqYlGs+NGotkZmUVVtawI2IBfvcumdlKaNLYiz2gYfQ1ejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771964730; c=relaxed/simple;
	bh=PrEAnkoZGtsFR+Wzk+e2g05c0D5odgOsm0p4FF7eh4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W7DzTCP17l3/eajVvkA6zGhFGcDemkffoDrfAJOqOZmBOkwzQgdOYlMbXjx6Pjr+fTf0Q6AzwV4v0yFPvGDnoxjQGXvLPlheC+iMomClwHJcGmdoErnp3aGk+HTPO8D+U5Rs8w6wB3XTtejjlIdj2rsKi+fuc0mYW4wXL0rOyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qD5OMqza; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HhRwMuDZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qD5OMqza";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HhRwMuDZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E1F47A018E;
	Tue, 24 Feb 2026 15:25:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 24 Feb 2026 15:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771964728; x=1772051128; bh=gxSFZ6s0fg
	eEn9LVTjNJmrRsMuU43HkQqWeAcEBEJ0I=; b=qD5OMqza0Au6m9J554RfvV+XZH
	cl3LPpfSE/7Qq5RYdrj0UvuXUAg8XMOKQJCK8qz2ddhb4nnbOKwatDonG+CYc0vC
	qh9/j+wH6JiNrvuj7uYvyggfA1146BC4h673zgkqKga+VjUL2ZJjMdwmRDfkKvT4
	D7fRIwulWpbjUjZDaEgGMBRYrvthdRHocDoLqQSGcKuLEi66xFlyqlM3yHJjqIRh
	KBf4uLeiiX1oxgmhLos5LGqAj+b2O/ZjZ8QAr7jGAZkP2Cj/OBIkDwf/8CgCfxfT
	HS51uEPJrvih+iyul4bHDObES8kxm/+3bOqeYKHgQQSe/fY9SwtPxagoiN2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771964728; x=1772051128; bh=gxSFZ6s0fgeEn9LVTjNJmrRsMuU43HkQqWe
	AcEBEJ0I=; b=HhRwMuDZsaEu0iJ1C6m8qy0mePaIBiONa+epwXVv7R6ZYZW06F+
	dLXcpkVbFvwT5DvlFRtTO3C9eV7me4bH1PUQnZ5wBpT76af308+FGfipcOdBT227
	9CHhJYVXpGV4sRSuwU40gquAa9tsC7wFxi381vpcIc4IegUOCwnuPQbdKWSbm6Ui
	qL522m0CEqrQfcAjN/qwTqr+LIpr74qxtlFS9o3VwEk4ie1AGqpWGndNGWOWBIll
	mg9X10967TAgeS7f5K9L6L4s/pOak7cqCcpD/qHBGjPOUd3mDHLUZCGOytt8w7ym
	8FxN3dq+2UH3+7xDcExws5wgCwSyLO7GwJQ==
X-ME-Sender: <xms:OAmeacoHM2bzfWC52i2uerSjOaoKFEFzeozDIgRiITY1ExvmquzPFg>
    <xme:OAmeaZqNIBrCbz7aOBIzvNKfcHFfAW4v3YcYVDnqr1VnqTZ7YOuT4OE80W46aEFbh
    71e9ZALRsz0-FQ7lPyMPgiWSVz3epBnVsaaAaiUHD_eeyW9qbNDGg>
X-ME-Received: <xmr:OAmeaWO09uKMTvqqMqZGkTLxrfCRcvSkhP3h1c9Anucvrljeu4hUf4X2KyYr_BBUgLwsjfv4j-T9mCyF88dB-gM8_wXZRgDvDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OAmeaSzOf0cD-3EKUtuYL9i34steol2PETjg4NYmu-iJuyj5f_veHg>
    <xmx:OAmeaXuGdyptFsIMamBBSukrIiIOFgp4BIN00H4qMeu76j5zfVp8MQ>
    <xmx:OAmeaT4SsWkU12846VDajbjHOydkGR_oI_y5tijdlgVvytrCXjNcXg>
    <xmx:OAmeaeSL2zOMhdAXgLrWmjkp-4Ja2tgFeMig8O4qOkyUi4Am42JUZg>
    <xmx:OAmeaZv0Nl4Fgi6EKjvvFpyeEvK5lohQ45w7pr3ZNOMNuq-B9dDI0ujz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 15:25:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] format-patch: add ability to use alt cover format
In-Reply-To: <66cac565f8a40f8de3dc3d857feb681bb80cb136.1771925291.git.mroik@delayed.space>
	(Mirko Faina's message of "Tue, 24 Feb 2026 10:29:01 +0100")
References: <20260224040400.751247-1-mroik@delayed.space>
	<cover.1771925291.git.mroik@delayed.space>
	<66cac565f8a40f8de3dc3d857feb681bb80cb136.1771925291.git.mroik@delayed.space>
Date: Tue, 24 Feb 2026 12:25:26 -0800
Message-ID: <xmqqo6ldga89.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> +	char *cover_letter_fmt = NULL;
> ...
> +
> +	if (cover_letter && !cover_letter_fmt)
> +		cover_letter_fmt = "shortlog";

The compiler flags the above assignment, which is understandable.

builtin/log.c:2442:34: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
 2442 |                 cover_letter_fmt = "shortlog";
