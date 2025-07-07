Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79892221FAE
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927762; cv=none; b=DehtIEEu+lFFH9/qvpOoNuO+u8LVku+RhRU7WS68fB7R3N90fWaf49BDH62MoLj6ZHZ3fUg52wJuKrwlZEozC/aVH716fwriUbF7Br5sxvuYHDp+JVtD/hjeNSyFHdrz4RDXHxND7MtBuv5b4OdbrwSJsoUeSc+fODrPlkk+d00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927762; c=relaxed/simple;
	bh=0yqB9zM8KdoPczo6BaKxklnnAvjG/qQkRgkI0QYOZNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PpXb6nVESm8+GwylSwpZU1ktt+LHvAMgaKUf3nXnEkEYDk/MSP1DneR1MSlCNFeumHcd5sQ9S0MI6QYEhIf1DaUCvy2kgRYr//bob8p8mJDJOh2VNGLlzs33CDTqOaIff1B8CYoVBdSvdxgRzM7IvzCfJWPPOAAE1kmLwCo4IoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T5/Kqnvt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIy4Z74w; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T5/Kqnvt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIy4Z74w"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9360FEC02BC;
	Mon,  7 Jul 2025 18:35:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 07 Jul 2025 18:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751927759; x=1752014159; bh=0PADbAH5Ph
	jXCCVMV2Y5mW4rwABrvRrNeLlyqzGsIT8=; b=T5/Kqnvt9iFUp6zN5dAkNWtqLV
	EGTuxFE/yNnd615bDc/ZQsnJztpWBfmSMeyY3vrTo1ztaXaIFEkg74JPfgVDs0S/
	/kltuuKU0NJGezHfbTidwsGyTJc2BJcSfqhTZvrEjIViKtVNXnzOps+1EYzE6AVN
	5R67kqipDf/MWfV4Bd/5PLKX3MUzrfzVUeB61jB06k2QRMpj3+MV2hEODm+7Wwcf
	q/9OCbZRh4cgkY+rNomtyVeFxNFOKV29vKxfyfrilBZnoBVYhRqNRxvRCtokAwmh
	ddjmXKmIhaTdwIR9urH6LHn7RuOiGgFwmcJFmXvS32FoLXUPv7v/FpAZC5cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751927759; x=1752014159; bh=0PADbAH5PhjXCCVMV2Y5mW4rwABrvRrNeLl
	yqzGsIT8=; b=eIy4Z74wii9eUN1g5wrJkuHDgXdS4/7gh05+GIMPmzIWY5bjjtR
	ZnNKxtfbZ9FATewH+2frIYc7plXgDaRz30REyg09QQWC74ubUJejAdddvPb96wPy
	eW07pC2A5j/AT2WF0YmHu/yl+EV+Af3vfBQS6eG/jKD2ryM+rNrPeyOEIxINaa+3
	3fkBm7SF4IaoULZEdNtVmm9ziaz68Yzmuo3xhbfXFtySC3KC2w1uMXuLvaW0DEFZ
	TcTwh0IIHjNhIMz06xqD85LaSm4ERmKpacNslr/DWKDMoYOpbj/UruECMzfRKEei
	f/oAlAANCfzMjVLJMOEtdVfLPrkG7XAe/ew==
X-ME-Sender: <xms:z0tsaFAIoPGaUTzI_tXDuzn1xsDwRJ3s3vUSflfnRBHis_SXyOBjQg>
    <xme:z0tsaBFGn53QwQVzsnHrO1wQQXUW7mRwWZ5FsDIxalQvkC4BFpnqc4XaDOvMCMcPv
    V3SoEnyrOMeuOECyQ>
X-ME-Received: <xmr:z0tsaHCJHxoTY3gADYwA8s4O69_uk70CiVchI5HRvyjNAqtGbOT2FnaVKcVSGFIBftm_zQD_IJOoSPSfZVYhhQaH-xpMs9REsk6YfII>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:z0tsaBX53I8BR99A_831cWc2OS6Cpz_VMTr89AqSeJSKBNbTk4yLZg>
    <xmx:z0tsaLpLiPC9x9-MPmwKJr9oTP7bmEoZGlkHltJSOAiWcrNqm8KQIA>
    <xmx:z0tsaNS1Y22RzQMcm9lqILqv0cAiFL8c-r3_-UB7EOtZxZ9Nd5VBkg>
    <xmx:z0tsaF3eqS7aqR6K0odnShDcPLB9EzHM0VwDr3dPRYBFuub3_AEGJw>
    <xmx:z0tsaJe43hdX1t-q4NxDztN-VupDLxvt5_agOYcCAkd7RwcoULOON6Ae>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 18:35:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v5 0/5] Make the "promisor-remote" capability support
 more fields
In-Reply-To: <20250625125055.1375596-1-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 25 Jun 2025 14:50:50 +0200")
References: <20250611134506.2975856-1-christian.couder@gmail.com>
	<20250625125055.1375596-1-christian.couder@gmail.com>
Date: Mon, 07 Jul 2025 15:35:58 -0700
Message-ID: <xmqqzfdf1ve9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Changes since v4
> ----------------
>
> Thanks to Patrick, Junio, Karthik and Justin for their comments on the
> previous versions.
>
> There are very few changes compared to v4 and they are quite small.
>
> In patch 1/5, in the commit message:
>
>   - a few sentences were added to explain why using 'struct strvec'
>     for the new fields wouldn't scale well,
>
>   - a typo "use use" was fixed.
>
> In patch 1/5, in the code, a BUG() message was improved.
>
> In patch 2/5, in the code, some code comments were added in
> fields_from_config().

The topic saw only a few comments in this last iteration.  Would we
be seeing a hopefully small and final update to tie the loose ends
before we declare that the topic is ready for 'next'?

Thanks.
