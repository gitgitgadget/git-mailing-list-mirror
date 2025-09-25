Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342D303C9D
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815998; cv=none; b=aCzT9L5yjaihBFV2T6c3uw22x0Q1kw0f40/97eeVMv5IYE6qeCkoBlaKdmVJ/MBbltBp+2huyXmazaLD8lMn7neSIxycJmpZ4rvTBKMKJwmbAl0JuOUEvF0CG+jECluoJkzoBITEOAvwA0EDvHGNUiVlin4O8YTMy4DWafdkCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815998; c=relaxed/simple;
	bh=+v79B/YasBE1VHyT5/A/Guy3M5QRKWwaOmy9eM5/mts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NU/HJFpKDATkEr0wP3SQpcjAAAGdGzwli2bajbYq+w+ANnlakN08QUSHO/p7N2OX1/wt4Brza6iO04cKjS5aY+Vfyphk02Zu9vNJaBgek41/y48+zocNpoHgGExgr0utb8uAY0itOzFX/qDcxdRaCD0RaCwOi+MVzoH4AbvKiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kdbBGObK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i4POt002; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kdbBGObK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i4POt002"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 237107A0128;
	Thu, 25 Sep 2025 11:59:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 25 Sep 2025 11:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758815994; x=1758902394; bh=MmaYr6j9We
	+oDWSeBzckwl7Ef0m+HwmATPsDrYCzAgg=; b=kdbBGObKAezJnf9snQ5y87Wb3r
	RafJljVVg2q8s4Z+6J4/mJXmlcOtox788Jy9ld1YB8D/Y5vpA4pbFkNC3cXRtUNW
	opocjyn4dxO2pez/jqAyUyHQbkvd+dYAsOcBcsoXrCKnGskDt3h69BoWl5C1bGhN
	PAbkzbvQ67um5oe3yAenf/ZmR3PYjryKuJ8vhprtsq+SSgXqq4uOrOtv0lOp+3Iu
	CXIB3mg+YTleXMYnuk0aGiSF9w8c9AGQVDnfBI3LEZUsCzB3Z34Jn1Em7YhfWSn4
	k+8Q0cqT/6Q4y/DENApuvVhfq2MvX2RKeYHR1OlJeHeYN9vcT0ibPvkQf5Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758815994; x=1758902394; bh=MmaYr6j9We+oDWSeBzckwl7Ef0m+HwmATPs
	DrYCzAgg=; b=i4POt0022l587QPFoOAOBAafkz74trU63Q3nMvPh+pJwrTgMK9g
	7FL95oa6pTonkh4xH4KKZJE1lZTlnWrw8Z9uXD2JqaW41xJRhwKdscVXQucX2GE9
	z31gydFL+d9l0uEngQfoxLx3rVBpb/tre5PeNP3q9qV1Nxbigt0LHGkqGHfbckCU
	xFnjFvSRGNJk304GrpjEdR0LM5cO7gDnVjjiZjMSpD+Avz8MVjYHFtdUgvdLza7j
	KqVefweCLr2Exo4q+tRKwirpFEc8OEESsUO6fX1SwY0IXQzYhVUwoIAgIo8vOlmt
	HtV9B6gBu1wcwsVwZ5W3wYryrBUcd3oEMOw==
X-ME-Sender: <xms:-mbVaP5kLvG0U-drtAxZPs70gUlR9o8-b3D1Kl2UV5F18_NLn7djKQ>
    <xme:-mbVaIl1FrUyw0EuAxBilI05QKRjZRbaTtotcJOcKRmy5dkFAxafibXQSHQk_PXPf
    FWQcMna23r-XGMX1RRDIKr3WI9Ir8LiufpXUd1JkCdH8MPhp_oM_A>
X-ME-Received: <xmr:-mbVaAR8OLm8_pCiXcsq4IBKT5MBm9IicHN6UqzUYjP4ZNTbcXTWe5mCOuHWJAdZsp_Zd-SCIZnWyL4Nj7Jd3jDd3W4JDUXqvmNf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggr
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-mbVaHHVFUzzJHxaQW0MfdIK-zvxdAQut8YDKbIzn2AXOk5LYRAGRg>
    <xmx:-mbVaFE2sStanhheK6DcFmqokSMKaC28mwkSXlkvYq52N5dFfihDHQ>
    <xmx:-mbVaFQFHbEEZF8bbpcUw4WCHSoKxb6j_bXnkCbQsIPPmyu8rKL9sQ>
    <xmx:-mbVaGIznUslGTyDp-KE9LHw6ANTgjNTjVcrzhaHT5cPs01MQaTgvw>
    <xmx:-mbVaPKuMxhLCQP5pG4C2cm3OYmVoCOl0Cgbpgf7qgtQnY5mbnV7ON1W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 11:59:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] doc: git-push: clarify section
In-Reply-To: <pull.1973.v2.git.1758651049.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Tue, 23 Sep 2025 18:10:47 +0000")
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
	<pull.1973.v2.git.1758651049.gitgitgadget@gmail.com>
Date: Thu, 25 Sep 2025 08:59:52 -0700
Message-ID: <xmqq1pnuikuf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I don't love the nested list in PUSH RULES but the sentence starting with
> "If the source is a tag or commit object..." is really a tough one to read,
> it's not going to be relevant to the vast majority of people, and I think
> keeping it contained inside a bullet point will make it much easier to skip
> over to get to later information which is more likely to be relevant to
> folks.
> ...
> Changes in v2:
>
>  * Say just "The source can be any object." and don't try to educate folks
>    further about tags, from Junio's review
>  * Mention both exceptions to --force working, from Junio's review
>  * Change "local branch or commit being pushed" => "commit being pushed" to
>    make it clear that it's just 1 condition, from Junio's review
>  * Remove an awkward double colon, from Junio's review
>  * Be explicit that creations are always allowed, from Junio's revew

Nothing questionable stood out during my re-read of these two
patches.

Further comments from other reviewers are always welcome, but we
find needs for immediate improvements, let's mark the topic for
'next'.  Thanks.
