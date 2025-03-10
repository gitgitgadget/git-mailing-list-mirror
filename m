Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1761C3BE0
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632626; cv=none; b=pNWS44qlX0vi88sTeDavRGN54eJeY61InB8TR7Z1vHdxSqyKAa7tBJ/Kh+2FN06O7lxUcW82sOXeihzyskyBEGnWjXux6Y5hewvIJ0ckOikaPnqZ0UFMHYPrh11fyymPDlqUvLLtm2kQMX3lD3mAoAPcaownXTv5y4Vmr4tiTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632626; c=relaxed/simple;
	bh=IlEsIcnw1pToyNGlY1AdPc8/j31Q8EhrsXAEUK0q3NI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e/3ZtHbbzyn0FHxa+gl17M/uJWelCapM/GeztBuCOmH0kjluze5F+lxYiGV98W955I4NcLhlSNNJBJCzaw76Wbu7BXZBHQDHJgZWhyclgA4XtbtZo6kHESB/a2fWfKfBiRtspZSuYcxMX8ou+qIO9zZfJiJaCupVbnO+TCizloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fMGEW/tZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVYFuRVP; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fMGEW/tZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVYFuRVP"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E1DF12540235;
	Mon, 10 Mar 2025 14:50:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 10 Mar 2025 14:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741632622; x=1741719022; bh=B6/zduxDoq
	EWRVWnQae9DaTjBCVLNItRXicBTS/po1Y=; b=fMGEW/tZ3b2LvUrQmsA+5Rqixf
	oVKMPOI+QdKNdE7zepwFPcarzali2nIQA44S+RXP+xJy4Lsvt+8bhZ4nV67ZdsqT
	NIhMzOvkn/Xu5xwBmBnXMlxWcm9wI9Uu7vUm8G6oM+mrHnhUa2hx6YqIKc1573ca
	g65fpusKIibm3DllytYjn5VkN2yYlOxigJz1aaWactsmv+1/w/bf1XHxO1yVgreu
	KyjVwZUC4C5uaJoJC74iUqKg8Md8aBkIvlQ7K2iHwuLR1bBDsLnEPZMTRiBUEvOz
	HJElAjO+mTxu/bIkWEPF2g1YdHvDY3TZlIF3Yi81Iv76wwvM5fEKoADCEmeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741632622; x=1741719022; bh=B6/zduxDoqEWRVWnQae9DaTjBCVLNItRXic
	BTS/po1Y=; b=JVYFuRVPYzkDyt09ntcXZp6avgNCAdzh3cr2NSaWoAthQJRMhdA
	Q8L6a+0FCv5GXRBOrZ/gurU/jaMRG4nPQv3LfmFP1IOJ4RHsxQa2ZIthT0Tc7yl9
	jfj/v9ugtvI6M00TZeh3Bia+P/YshO0WxPrZA12F4UbYu2d6m3SfgNl6GyoCpFs4
	LT03ip5cAICw6XFqDd9hEi/KMmCdroN7eh89KQoDbEy1zx58NnOU5Y75SkXwpT5I
	ulEKPEXaqK31Vz9HotWN+C9xXrxvgY1YC9m2tZEaxk+bWtYmwUn1n0GGRjlsQpbd
	/AAVC9SxDVli9My4bNt8JsEo208RvcATmNA==
X-ME-Sender: <xms:bjTPZ9UFeaOBtdpvJmZ4t2vT9U6AVj0LwQDNsKnPrdLRcxscUgQRwA>
    <xme:bjTPZ9n1FrQ5lwcHYO8Oskm5M5ktnITs4fhz-KRPlg7sT-ud3OcS0FitoEKnJksTR
    0olAEli5iBKFHXDoQ>
X-ME-Received: <xmr:bjTPZ5b7ExghX2XoaUj8E1bvPFe7UyKIQ2-y8YlsKIEIoqKPPLUP0bYO-CK1tTGDCPa9iqjH_pwV525_ikNDHtFFBHGGbb8B6y86>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfefgvdefudetudekteetveehiefgvddt
    jefftdekfeejffeghffggfeggeeffeetnecuffhomhgrihhnpehmrghkrdguvghvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:bjTPZwVPtntwfEZNHpdO74GSKVXgZ0fUpfBEHeHx2HY6ergS2rtOuA>
    <xmx:bjTPZ3nnfeJbsTqSVIPGKJ07xcReVSAFqp2DTRLIgj-ZwRvHeZ0lKw>
    <xmx:bjTPZ9fgBGDQrri4Ji7NCfn94FMSti1oocVdhQR9USBfpzcCEgxmjw>
    <xmx:bjTPZxF35m5zp6Z11yXA6xMi9Zh5YFQo2OILgP1yd1Z8gFugiNfVuw>
    <xmx:bjTPZ1WofaC8tbgUJRWtnTThGVGyl411q9swh8KnTI-4Ovl7E5b5_K34>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 14:50:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
In-Reply-To: <20250310160440.GA26189@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 10 Mar 2025 12:04:40 -0400")
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
	<20250307195057.GA3675279@coredump.intra.peff.net>
	<xmqq34foefh8.fsf@gitster.g>
	<20250307225444.GA42758@coredump.intra.peff.net>
	<20250308032309.GA584028@coredump.intra.peff.net>
	<xmqqfrjkao75.fsf@gitster.g>
	<20250310160440.GA26189@coredump.intra.peff.net>
Date: Mon, 10 Mar 2025 11:50:20 -0700
Message-ID: <xmqqsenk7mab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Maybe not often, if there is only one instance in the current code base.
> Or maybe a lot, but we wouldn't know because we haven't had the warning
> enabled.
>
> I guess another option is to enable it in _one_ CI job that uses clang
> on Linux (maybe linux-sha256?) and see how often it is helpful or
> harmful.

The reason why you said Linux rather than macOS is because the
single instance we know about would not have to be worked around if
we did it that way?

I am OK with that.  

Thanks.
