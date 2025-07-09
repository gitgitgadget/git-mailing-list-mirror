Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5622E716D
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072744; cv=none; b=lQ4LxX0GDOQ/a1QBO9cZ6q7Is57jUUyDIELBS/n9WmYOTih+w+ctcqTxEw1qk7FhXKY0sjU2B13TX86Cvs2lEwKmQMeJut57FuxJ5RyAODYHudfwvkBGsd5Wua2wig/3schiI+FRZvNjFm/0GR4S+nXBeiQpSDzxPTEzwD0YHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072744; c=relaxed/simple;
	bh=FF+zIJ9j8MctmPZOvMIqBDlnNqiDdwGLxxL+kqMzktI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XX/KCwYKI9qAZ21iV3vbyWnaRIFjbwtnqXSdQdlmLB/sa5vTfzmXpxFPmyzFk41OEc5MFP8VX/daI6X/vQ97/4x8Irl8NPXGlFHokt2XSj8Jq/ExJVpTSRA+Bey/7e3pa5jmoyeVl2k54/hkNm4eBLOEZd1t6g9uOB7o9Gz6yXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cOVn1xIa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SH4GNkPm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cOVn1xIa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SH4GNkPm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B0FD1400181;
	Wed,  9 Jul 2025 10:52:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 09 Jul 2025 10:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752072739; x=1752159139; bh=V5vXQ2itpv
	GljmFXGOFHa7Q+3whxTEBMYnq159Pgo8Q=; b=cOVn1xIanGQv8YWUqLmZFJ1Xo0
	Kzmx+J5CLQolx23R4GDyQxd22ELBwUP7+rkxpXpjjTlsUvOAk7plSgChHTYMr4BN
	hgzyaE+WFWOKKtnPHInLDNXAXtb4Xk25EC8SmdLLWrDThk5M8l46wFL5RHIqCzkx
	Qa40VW1aH9al4KsGBniOJOfllR9PcILChIbO4OITzrUUL11uq5XA860xAP8of6vf
	ZZwM98w3wPIDLcuCPmvh6I9H4Ytu8iG/ZDiXElG/M65jaUdtFVqupRsZTKlNgfE7
	X5LMmzrkzRHariAPWiDphMA5cErnma4nMzvzhYxUy0wsVXrkYugVaXDlur0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752072739; x=1752159139; bh=V5vXQ2itpvGljmFXGOFHa7Q+3whxTEBMYnq
	159Pgo8Q=; b=SH4GNkPmLKFbewnEA52gChta22vX3w956fE04HaMQvE3ar8BjDR
	VbFrbN2wpJaFvlIMEdWexaFCP83HGxLt9SU48BMZ/ir4uuCHscxK1BCjRLN6jDVt
	fslVzONDqrtMOdeV/Tgv8Q5hEUgmHlkWQT1zSkogtoqmkxrfhilA/hdYN/hNmF0A
	h/2cQyRomRNHlvBsli6wMZuJukg/Vj0VRyILZNIp2ZBijnLx77wor3HsxTQ79uHY
	hYjRDUrXYsp4cXa+O2UFLk1jOooG2Uxj4zX6XbcXVDxTvroJqpKBIv5uj6BFPl3t
	+g/K54y7qbWi7+hH6UB95WQBb3qGnb2GsWg==
X-ME-Sender: <xms:I4JuaOYeaUDf6nA6ulZxyA04SxnTKpwLi4CWLmzSBiEjbx7iGh80MA>
    <xme:I4JuaL_ZdjziCN5C4lX0IytOPGaPlyWgf58LbkEZRqjTG0HSAWOJ4GNVBZKigviEX
    mQLsxHhpeR7jcCE1A>
X-ME-Received: <xmr:I4JuaFhecL1DLBuE0PiWnv_tgQ30UKBG0msim3U59YvMI7KgxeT4iLVAg8p5TUsdixKRSKkmKCbebWkHkQ3-B_84E9rem0ystx-HjZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I4JuaDdx_JMZggm-5VId3gFFblYnJT59ZEF_wbeU5Nid-JyK9rCN-g>
    <xmx:I4JuaErsfS-LbpRIC4G5jnpOUySptrOI_Rxo7vzihsLuDDQNoAl5tw>
    <xmx:I4JuaAArC-MyAQhMGfgLzk4En6wewVLeXVkOKT_xD0aHBFkwAu-ehg>
    <xmx:I4JuaJY1kHPPiVGEAMnE8QD2dWS2Ko-tFT1aM2CUenHwmTTk4WxIVw>
    <xmx:I4JuaE1CEiStAi4qeRjKH1PYbn6OfZgiIVqFLvpBJpphqqeDLbFLMAok>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 10:52:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v8 2/2] submodule: skip redundant active entries when
 pattern covers path
In-Reply-To: <CALnO6CAXermmya0UjTHU2gPoEAb1m32fOt7Uzf6CL2mSJ=RkTg@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 8 Jul 2025 22:50:23 -0400")
References: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
	<20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>
	<20250608032705.11990-3-jayatheerthkulkarni2005@gmail.com>
	<CALnO6CAXermmya0UjTHU2gPoEAb1m32fOt7Uzf6CL2mSJ=RkTg@mail.gmail.com>
Date: Wed, 09 Jul 2025 07:52:17 -0700
Message-ID: <xmqqqzyppgbi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> +test_expect_success 'submodule add skips redundant active entry' '
>> +       git init repo &&
>> +       (
>> +               cd repo &&
>> +               git config submodule.active "lib/*" &&
>> +               git commit --allow-empty -m init &&
>> +
>> +               git init ../lib-origin &&
>> +               git -C ../lib-origin commit --allow-empty -m init &&
>> +
>> +               git submodule add ../lib-origin lib/foo &&
>> +               ! git config --get submodule.lib/foo.active
>
> (Not my area of expertise) Should this be test_must_fail?

That is certainly better.  "! git config ..." would succeed even
when that command segfaults and dumps core, which we may want to
notice.
