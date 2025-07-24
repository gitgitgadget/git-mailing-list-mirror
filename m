Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107F223BCE4
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396385; cv=none; b=YaIVPkg4sdU1i2OIIocr4nhm1G92sc25+1pAYzt3/AXZSAAPHqIMeTMCOjW9PSDa4o48Q0dX5nSTJhVQDEOKzUy9Rv4RJXxRZCWrtZSHY0d1zKM+XdWoCvclR9wWoPj0oONpTlGNI20Rfa9KbNYdlJCScuVySihBJXNHE80Uv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396385; c=relaxed/simple;
	bh=WeO7V5rQs5OEB4RpppCUdAam0TY2sjW+4q3WEpNqZF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUJJd7UpblxNHiX2ThwRq0aiahtqpVGLwRBGKQszkgDyWipz83uqx0tyUccf66K5fdyoaOOsmd5pXWs8Y9mp6XjFCTlF/UV9+t89ZDor9+DQ/WaRd3ple8CCN5zgsyaQSmWNkwMyfzeUbiqv5PeHlCJxHVfcfAtReasBUcLksow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IIHzLXMb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dn+Poaga; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IIHzLXMb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dn+Poaga"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33DCC1400033;
	Thu, 24 Jul 2025 18:33:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 24 Jul 2025 18:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753396382; x=1753482782; bh=WeO7V5rQs5
	OEB4RpppCUdAam0TY2sjW+4q3WEpNqZF0=; b=IIHzLXMb2H3BimlRGHsFug8KTj
	+sQ/d3MDiYVKv5GbcahuDCmbBRzw11wW14jG4b8ayJf22gevf/a7Cp6t9L/Z26/N
	jWVDAunw/JZ3o/dliceemSCrBPXJjnMP/Ot0twIJtQNleZBakUeKfSi1Vpmmu4Hp
	Dthni36L0f84gWQwWhS6APERi8eK3jQiP8woKKeydq2NxZioHDQ1sZsEYmTNjFjz
	9By3y7qEzo9HXswbVORHNMwal3zfoUDpfva1mSmqeenjNzL/jd0XfoZzdwIOSoMP
	412l+Mp7KcOW99T1zez6X34Xd5HA3XfxO6qkvaDTOMBsxcASOzyG2S+dnthQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753396382; x=1753482782; bh=WeO7V5rQs5OEB4RpppCUdAam0TY2sjW+4q3
	WEpNqZF0=; b=Dn+PoagaTMr5OXaH4Akw3pt+cyFxFRbHinHomycTdYwfhOjaFck
	cWVaI3vE8LVd6pC2WrQtdpI97a8QCnE9QumQg7ejo0B5Js1nLTJpoD7Ylq65cet5
	H2cBmldok+9IaxdR7rbuBonysp+BQa3hbc2VUjWfeOMUcXff+9opArHdNJ7A29us
	jnnotEJqSeig7zKe44LnIK2OxIQxiA1EoRZTQTu2x6RVBqI8cYlCrYY4xaQTxtd1
	vRVsds0dwoWi79yUCpFeQA0014ZVHBhbC2eXkiFb+umis0zkpua4K3SgT6BApC3m
	6hQWU61YEh4Zem/eGRH19dOMdqTgQRujf8g==
X-ME-Sender: <xms:nrSCaGUF01XC-leqJVtLlmswNn4wUcOmwaIHNbwjB_YoQMdziE42cA>
    <xme:nrSCaF0STOVWyDECpVfzX8l1Js5cTzcCYw-M1BlehWh0EPllik3SzMgBNqHLiE-TS
    n0b-Ty94UZKBu36ig>
X-ME-Received: <xmr:nrSCaD3jaXZE9iT9r1FlKKoVW4P8k2vSz4jTy55mgQYiZfhbVvNH1QSk5G8823kSTs-B8qEwLshDfzgoeS3Ic_ExGyw-7Z4z-gTD45c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nrSCaI8K3Fkgo_09oztLWV_wa5KFSVBgB4ZyVC_9lgGLi3TIrdHrNw>
    <xmx:nrSCaA16krzDFV1N8joZlDQSyI03ilAQaMwzLSGtZLuS8aTGQND28A>
    <xmx:nrSCaF-v1BvrXYq4Fko7j3mxBKiJ2DaqTdIsV6QOxgyX-PF9K2QyTQ>
    <xmx:nrSCaAvG4F8VCU9p_wwQ2msaVPyJHbr6-8HYhof2rXtscGrhQ3BBcg>
    <xmx:nrSCaCc9b-CwyDFPkj_0X36ZarzXUgrxsOQi40uCk9nObdJ-qtJ9OXYp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 18:33:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] for-each-ref: fix documentation argument ordering
In-Reply-To: <CAOLa=ZRvyBK9vVz4+OhLUgAyktdVTb44VC=e8KQNB6BszJ0ixA@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 25 Jul 2025 00:14:06 +0200")
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
	<20250724-kn-small-cleanups-v1-2-0c70f591de3e@gmail.com>
	<xmqqy0sdh529.fsf@gitster.g>
	<CAOLa=ZRvyBK9vVz4+OhLUgAyktdVTb44VC=e8KQNB6BszJ0ixA@mail.gmail.com>
Date: Thu, 24 Jul 2025 15:32:59 -0700
Message-ID: <xmqqo6t9xlr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Indeed, I blotched it up somehow. Will add it locally and wait a ~day
> before sending in a new version.

Hopefully no need, as I've tweaked a bit locally while queuing.
