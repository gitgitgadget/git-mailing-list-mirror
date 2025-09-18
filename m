Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1502110
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206859; cv=none; b=Izb/8uRC1cKI8/X34Cf2sjCg91vsZG/ZwyT86FHg/ZjJJqS8g8zP0UpNty6v16I6B+npIkzIfemEU8Sd2JIdzA8CUajXnHueSKAxpyuwJw52XlvtIgwtYxzq7gbvV1t9SFMOypjcHnK9t3IXeywlDnq0brWUA2yFT0eBysN/xOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206859; c=relaxed/simple;
	bh=PpnWUJgejpbb3P6rFHxfj/cNag7PY50e3gmhzxh4/9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MpwaZUpTf16F65GV9xNSVk7tAxgf63mEXWVCehzaeS2caECBhPSS3LQqoQXKhL++DaSgBwnLvR3R9J66piGlisI7gr73OuSG5ZLUSJerZOdi5gC4W38Sbm+mi+iPkm9qCFRkjiZQBVq6V4MXPG/HxkmQ2NqOWOtDCqDiqXJLVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YgJ9ypDm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B/v1I/Cc; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YgJ9ypDm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B/v1I/Cc"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id D9EA4EC0343;
	Thu, 18 Sep 2025 10:47:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 18 Sep 2025 10:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758206855; x=1758293255; bh=cFYY9ReRdN
	QAryuqkSjQrPtoBNqYqnnW6Ft+VW6QjCc=; b=YgJ9ypDmAOv5rOYchqZigbfGt8
	pvaQDcXX6VlO6IbqQd21hrz4WOjgyF2+dy5TQ6ngqlyng3l3oteJ449quHjuaxgJ
	7U1AdgoCfjR7w7+xVTCzWbEkOsMPN3p9jqgEDx6eCx1/Mon+Kkw/YR+PZEhFL10c
	FTDyFQ12lIkwxBdi3DycDBtXj6c/5qgvvJQKbY7lfx4d2UZhpyJO6+4p+5ale+Sa
	6p2OJOLwBl9zmEvkC13gX5mq5SQKERFes+f+RcHWOdOc/GhJx9+7e3B6LTiitChh
	JtFnS/tfYyDZiga+1ahQ4kVSrbJTTuy0o86MrlqBycgT8NZqpdK/knvTWNqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758206855; x=1758293255; bh=cFYY9ReRdNQAryuqkSjQrPtoBNqYqnnW6Ft
	+VW6QjCc=; b=B/v1I/CcArkAnrafYeSkDY9SWFVZ/XxK9MpBJD4d3lmIjGk6XLZ
	JCEK54R6ph2zDZUgGrAdGbh6xWjNhzadKjURKTYJU+XbnAX6IJZZW3ioulDV7/vb
	m+CL8BRU1YT73wI80w03FEcHTfBYOm8KBkOV+E7K2WLiAj9+4a2yxz0RAlPcpCEP
	Tedct6qhyYKpOsAI2PpBsIlDsLi/lerR4oErZ8D64VJwBNP5qVRnGqaAHDoRfqlD
	49yf5LIcWT90G5sp7JXyASoIva50jZtV8pWlAo5N0N90y/O7IHPG7UH2F8oWCBpw
	EMyiox6Zz8i022c/JuxdDccSYF7Ib5ZlN7Q==
X-ME-Sender: <xms:hxvMaKtesJknZ917MTd15fMnKgmQTh7n6gQXfCV1VBTXAet0mjB4qg>
    <xme:hxvMaK-D3Bc_hMMZ6HApN4-tP4ZWD0s5u_Akp3CO8W0OLmTx1fEPymjIJKqcTFmSH
    4NeDUps9auj0m8IFA>
X-ME-Received: <xmr:hxvMaMN1KPS3stDtv6yM8NByOaNUNZQoSxM4qCUFOouplw8m_dwL1bq3aSPsMJYw0GKzhJbigH57YW7a8cay8WC1cKRa6xoLYZDTxHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hxvMaAET4S2hZZoy0j_vB9WmQQvi_EduSQiGT83a7H3Enynl0wYvtg>
    <xmx:hxvMaCRX0CY4e8fXuIs2tTsYOd0tXRUpzXEVGGoeBiNt_-tcmUHQJQ>
    <xmx:hxvMaFu6aJhGfuoLKzRLsFfqtK6hx1t0Yoae9LhBlM7xMwF7EHBe-w>
    <xmx:hxvMaCJcWqnCBCvvLnoHtcGCNETICSMnR3g_OHFyTe16Lh0_JkqqXg>
    <xmx:hxvMaLJis3K316dJ9eOnsMASCupr7UwAEoOegHUnYm51svdmErNUuabp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 10:47:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: [Change] Git build issue on NonStop
In-Reply-To: <aMwCcw-6l1x85Wz-@pks.im> (Patrick Steinhardt's message of "Thu,
	18 Sep 2025 15:00:35 +0200")
References: <01c101dc2842$38903640$a9b0a2c0$@nexbridge.com>
	<20250918022912.GA1135133@coredump.intra.peff.net>
	<01c601dc284b$24496400$6cdc2c00$@nexbridge.com>
	<aMuankGhjxXNKErO@pks.im>
	<20250918063152.GA1168297@coredump.intra.peff.net>
	<aMwCcw-6l1x85Wz-@pks.im>
Date: Thu, 18 Sep 2025 07:47:33 -0700
Message-ID: <xmqqbjn7akca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> One thing I missed: `uintmax_t` doesn't work on 32 bit systems:
>
>     ::error file=clar.c,line=879::clar.c:879:8: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>       879 |        (uintmax_t)p1, (uintmax_t)p2);
>           |        ^
>
> I'm inclined to just use "%p" instead and accept that this has
> platform-dependent behaviour. Means we'll have to drop the test for
> this, but that's the lesser evil from my point of view.

As long as %p works everywhere and with stable output, that is the
most appropriate solution, I would think.  After all, this is used
only for "oops, the test expects these two pointers are pointing at
the same address, but they differ; they point at these places...".

To test such a test, wouldn't it be sufficient to perform "does it
give a bit of output or not?" check in isolation?

