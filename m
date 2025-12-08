Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C9B2D238F
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765201062; cv=none; b=Cow2a4HMz1epPESxFQr4D/CwWr16xkOn0j17/pWSPQqhjcwIp/vxOvI6qLEQ6c4YqlYZSntnmZX1PCSOo+jnNeEdFlreDQo4NM6UmyBf2OwqVRWNe6EXfXmTPVPcQOPkNg06hdiJfOyz2GBVGLSuLUJG+3rGKdi9GjIICVdehLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765201062; c=relaxed/simple;
	bh=zAErcaDb/8yi8pM1adPOtPeLYZUIHT5O/Zstrc6ebm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cIethDGOPymWu65IJkwINP2gPpMFrlQ6nHQnoQKKOTizknGJhZy2OV4MZGIjUn6CM20xHgUeWr+rIB+zoYNpZxkH8s7I+yD8nx2sYI88NFQSUwzeuDSFvoc+Pqm/UcmecY51lUQy9Yk8vIMMrsNAZIU8uos560HxxtzryOdp7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SGifjk7j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ApOx7w2f; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SGifjk7j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ApOx7w2f"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 930501D001B7;
	Mon,  8 Dec 2025 08:37:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 08 Dec 2025 08:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765201059; x=1765287459; bh=5yr7JXYZdf
	vl6tcECdPvclj7prct4jCACrZgt6Zx6Jo=; b=SGifjk7j2AnsY0JDYtYNfWGs5f
	MtMjK7zzCjBbRaOzCY3ROmm2GcGxF6WUzIjfSUqoBwgpkdlSxzwRY5m0OU7j94BQ
	L0a8uo+2pGm069AOO5Wqgz8udGtRidY9yD2KsVRF56YHUHGv6GWFt/RBwT1MWpk7
	JQxUidNgUy+KQxeP9a8yQKQTrjs5t3bvlyQjlX4YFPXkTrcpeb3zMZEQB3ZDhd6f
	LGf9Xu+NssRI7YFItRRRauLpQ0SR9X/z+Uo6CnGIdf26BTP0NpOJHylo+YU9BVhk
	qTqoIJnHPfGtcq+Re03MrtQcnW22BElkynuXSZglG+/y1YUStwpEtGs/RUTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765201059; x=1765287459; bh=5yr7JXYZdfvl6tcECdPvclj7prct4jCACrZ
	gt6Zx6Jo=; b=ApOx7w2fHMEruppxdlpeqCgegUSMQ/DOpaae6K+x0ARc8D4wSYn
	9srN0ameeikvVZvSFW1E4Y+8T2YBJwPh3n+GgJ0GoM5YEmglDUFuv1xI2yqYDEfW
	HJtXTYbaldk9e5JeINzaVCKalzDpLj6sRo9kNGOOegP+QZ9oCx6Pa4RliChK8unw
	r52uPdMYwsXYxZFM9rRbo2UBF+IYDXctmliqoLJISGU8ikNUa+xE5bCSUYZplelR
	LcvQ5GZaZ5KkSnew0etVbDE8qAbwijIhP4bG7CXqLMxJXjRmki6bPqVgX/UCiDj0
	spbN++ak3rghetvfTM4vl0S5x4EWw4dY3NA==
X-ME-Sender: <xms:o9Q2aRsq_0rJJCEYolFLJCNS6L0UZkgP-FPH0_TT0ztxyVOFjjXSaQ>
    <xme:o9Q2aR4nLxvwonprp8smFhaxR-dx4_ZYJOGGY8bJihpaXS226JxvG28VL645Yc8nz
    e91m938Wwy-aqE2sSF2wFeFpX0ulFYmpUBhMQL8z6r74FgQPrwpfw>
X-ME-Received: <xmr:o9Q2aSKkXjgawob99avnW1aSQmaJIxa2VknpfQLw7t3CXoOK0Sn0PzwfkY12JFMR4sr4_rSe_4cqpOjFkI2lNPl2VgxiF4aX1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:o9Q2aR7y5LvSqMnurAU479EsrnedPDF5GlhqGrAW_aYKuwbIEWdhqA>
    <xmx:o9Q2aVyGC1SC9PEEO3JJNN7ZSjnnVJ0UH5_3_YBmrUjAu8cPNzQoFQ>
    <xmx:o9Q2aVZeANNL4pQQZ58ZsZdNhHk_qd_oYeeFWc1LoIHavxMhDqjyMw>
    <xmx:o9Q2aXR4BCVwRCnC0sGQ44vpPFBhnoECbxDbwuZEkMQs3qMyqRvfXA>
    <xmx:o9Q2aSB80uiUzreZl_UN8CyEt8aexgGky1HX2kuPLLoFIvbdcHapcRAG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 08:37:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] connect: plug protocol capability leak
In-Reply-To: <aTZ9iMPKLAfd-GSt@pks.im> (Patrick Steinhardt's message of "Mon,
	8 Dec 2025 08:26:00 +0100")
References: <xmqqfr9mnbu9.fsf@gitster.g> <aTZ9iMPKLAfd-GSt@pks.im>
Date: Mon, 08 Dec 2025 22:37:37 +0900
Message-ID: <xmqqecp5ksbi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +++ b/t/t5565-push-multiple.sh
>
> Nit: we have several tests in t5505 that are related to push groups, so
> we might want to add this new test over there. I don't care too much
> though, so please feel free to ignore this nit.

I did notice the one that adds configuration but it did not look
like it is actually pushing there.  In fact, I think 5505 is more
about "git remote" futzing with the configuration that defines
various attributes of remote, not about the push or fetch operations
that are carried out using these remote definitions.
