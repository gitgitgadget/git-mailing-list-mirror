Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7234414
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769472668; cv=none; b=Egqrw/lJiUMW7ajFdGSZVtPTbv+w4AI1QNwOoPbW0nZAspTqdbNW88phUm3cB0Ma+hWF4PYHhEI5pgDjPpjnldiRHrBv/RRdnC/8z53PYXZUDjx3mNED/3YtPuSMcJx2eUyN/n8yYqdmwNLUkMZKnGCIRr3wRec38REGOYV1Zxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769472668; c=relaxed/simple;
	bh=QoL9Hij8wH0y4ZGsv7HkOYHF8cuDgJLpfd7z86skdcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTbHctYxbxkJ2taK0uUpy0Ux7rFEbzuwAudW41q2JY3tutBah2mJe1nvZJGzUk/RxdUjHw3tMf3eD4IXRTK4dc2R+osAViS0W8QNR+RbbXAj6nTlMmNg9B4Hk1h6TIoqupP3YIAgTqsWNEM/7D3mAgpoqIJ+nZRstzhmf6mmmAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fCecYBVW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pSGV887C; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fCecYBVW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pSGV887C"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9530A7A032E;
	Mon, 26 Jan 2026 19:11:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 26 Jan 2026 19:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769472665; x=1769559065; bh=YseEFAlX6O
	QU7ioNdVZwV8RnlcGjWRvEmSm0UxJK3XM=; b=fCecYBVWJs+fSmo4huSSji90qN
	zKP31XtEqfZTDkME6BvwlZG9mGITVopwuDOrtMyLV4uNWMJ/b1wQGKAUE2I/cBZ7
	SY62EGjHdmqLCb5ErelvBPkfJBTpg1w0gqioXSCuFwoxf8trOB7lIDLsZnvk9463
	xjPbos4Dfxf8lL1Vhfms5SZ7Zq+U9cBA+O1X6VzaOUUTrdtiNipEXwJS/zw/NYL2
	D6aMd8p2fnC2/wnuiYMPDargrxxVt56tnCnUMmkAe1m8PNU+nGoLEwqDCopnWr4A
	8AXdM/gzsnxUefX08uK4pkGUAb6zVxOueEZxVPJ4g/Udp6ozam9vNkdiPJyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769472665; x=1769559065; bh=YseEFAlX6OQU7ioNdVZwV8RnlcGjWRvEmSm
	0UxJK3XM=; b=pSGV887Cu1Cw/bSklOkPLXgxEElCgdfcf6ulIK64qc8iC/vUkiv
	fYX/NnnaKML742r+Jmgiq4FaikQ4lq/qHXYKNNQvfa1Lnio3igMje2MHEFpGUgme
	mwcU5CMuvBp+TcUvMbx4En8qe7GbwcWoDuH7NbJO7Vd+1qI78aTkLZgKuCk6h6Vw
	02I6w9ZnvewfhcPcV9bwzeqBFXnsb6g7Cd2NYVyS4MNz/xXTzcyJjlvdllYupFBZ
	5714j8/Gl8/qhvwlARxJ5K/FGxSj4hBksEOoTNdKRkD0DX8MmRp3OfnYD0W42nBn
	OIz9+ZxAwxpOsvBi/hSZrdD4jZZkJ7IQx1w==
X-ME-Sender: <xms:mQJ4aa6LdTFzotQBiygcDpUza2F9dESMlI1TiX6Cin1MtU9L8mI5nQ>
    <xme:mQJ4aS_IW-GeQ-f6GB_S5VGepdLh30SHpxp8pcPT5DaJlSAMNWLHcqI-6uxL5xorH
    AyhedijpIfxl9mBPWQaIGAvvdp4pKHgUbf9eUFiW8SrdhrUBAvQBA0>
X-ME-Received: <xmr:mQJ4afozz0rPIJHot0_n4TsEey2o9EgZPj2doi4UqIjsiUmpRC1V7g6uJkzJuqG3YzV2_gV1C1VCB4leaAyCFgR-Atuh6jLslAjOdf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheeltdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteeijefgieduheffhfetgeeggedtvdefieeiuddvudetkeetgeefteejjefg
    hfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mQJ4aTrbTC7vsm2HrlO_7syiPUFU6F6BsgaiBJsjMqtEX73FmbAnHg>
    <xmx:mQJ4aS0CZlE0TNWHtPLl1Bo-bdQRxlL4P53vXES1TmrRAAQ83gRgsg>
    <xmx:mQJ4aRFZlzZPXJyY3uDc-rrcQBwuR8CeWEJcGXVslee_qx6Cnigx5w>
    <xmx:mQJ4adGC5ZTxh5W_Q_rQFU6JxFeqr0KB9FQaKOCwb17XZnDisK68KQ>
    <xmx:mQJ4ae_ThrNHYwdyEI9hQMqydKkAdC9f6qH5de_tFd7hFcqDp3jhA41S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 19:11:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Jeff
 King <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 10/12] run-command: poll child stdin in addition to
 stdout
In-Reply-To: <CAJoAoZn9Y1xqtc1hWDvM+_rmcANkGUtfSA1HGTaHjtw0DuXyAw@mail.gmail.com>
	(Emily Shaffer's message of "Mon, 26 Jan 2026 15:20:53 -0800")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20260121215436.1473800-1-adrian.ratiu@collabora.com>
	<20260121215436.1473800-11-adrian.ratiu@collabora.com>
	<CAJoAoZn9Y1xqtc1hWDvM+_rmcANkGUtfSA1HGTaHjtw0DuXyAw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 26 Jan 2026 16:11:03 -0800
Message-ID: <xmqqms1zhq3s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emily Shaffer <nasamuffin@google.com> writes:

>> +       /* for each potential child slot, prepare two pollfd entries */
>> +       for (size_t i = 0; i < opts->processes; i++) {
>> +               if (child_is_working(&pp->children[i]) &&
>> +                   pp->children[i].process.err > 0) {
>
> I only had the one tiny nit on this patch, which was to wonder if
> checking for pp->children[i].process.err is something that should also
> be behind a conveniently-named helper like child_is_working().

We already have

 - child_is_ready_for_cleanup()
 - child_is_receiving_input()
 - child_is_working()

What should the "child is working and process.err is positive" be
called?  child_is_spewing_error()?

Thanks.

