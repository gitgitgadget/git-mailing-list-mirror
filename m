Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEF8352940
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769718535; cv=none; b=JCJeEOo+rJj1qqd4TIOJgUKlkXgRKo/H5FpoujWRyj7pwtaLEFq/XUI9Qvlut39krzuNw+C27yxj6n/vEP/VXlWA46J3uVPmK2vbazTHuS1LsCZhFiUWJT2I/UU7biNle4xtt9E94owU3OpURdp6ZyuJ7JP1p0b1zplN2C8JACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769718535; c=relaxed/simple;
	bh=wckMW1k62qLlIftuqcb1XiLuZT5LiS8miP4rkwrJf+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZmQBwIfJ20j4ondpG/ymlq6N4UcyHHhxUeV+Hv8wvPdwB0bc6ZIwvw8tUdEQicBkeVMUmhl42q8SZ0yl3loyT5HtORvYDcn2zdByJ3XGrEBpUYMk23lNX+W8ZficPOyh/VNbVCHfX68/b8rmcY6U90Q9IYQR8fmBsVp6kuFqBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PWW2PeyL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fbh1boeA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PWW2PeyL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fbh1boeA"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A09AC140008A;
	Thu, 29 Jan 2026 15:28:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 29 Jan 2026 15:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769718533; x=1769804933; bh=cBcNtoh89g
	FdO8qNvPcv7JA0Y9t6ixHiVLNtuwzGH04=; b=PWW2PeyLGgyWR4dAMrLqlhcOX2
	ls9Hd0LlI4MmHYxQpGikSgnAUlUyBFP23LJ1CDzCSFoxxtdxE3pyjuMNqjxwLlxN
	/VIDfRD2PL1thFj6gdcyNJY1DtJw6sdqi3NiaSTCtZtW3xq5S0FR3/Rohh9ZsoVG
	ndHmIDQ2hazkF5ACfzWtlskiIKE8Sj+qXaYd76lCcJKL/ZCZccz/Nf8+Tdhgf5RW
	a27MM37iCRdC3gbnwrkLE30tKRiWhvesl9hw1gUuO8GoYCF/YthfcfhNkLTzkbkQ
	uP1VsLQ8t613SgZ5Kqc98C3INNPYrUxLylBjdKBVekjI4CNqU2CjFFhxHlCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769718533; x=1769804933; bh=cBcNtoh89gFdO8qNvPcv7JA0Y9t6ixHiVLN
	tuwzGH04=; b=fbh1boeAVrh603x0N2im9pJrf3Vo4IpLfaUEY8cxI1NxkXlpWua
	hA4ml+zPkW/54lpvMI481SlJDD3tjrYOox6gAhXuNDB8rXI78ozTamHFF/HQr2N/
	T3Yb7CSdM+6V29tr+BENv8CSCoPDrV9C89DXcfj0PqAXFXnZxb+XF9S5AWFqVA6M
	AX3u/A2DRMVL+atg3l7pzL4Bp4SaZuVWpgBVptz+uvzrXQJwtyU28S6147gRmBRa
	CSadLUm3QDdfyReapNU3icP90IhXy6M33x41Yx/XWDMJ01O7vwofNU2GTqjJ3VE0
	530fYvxnTFCQqxIKzYBXTOE1Dl1tjOrQJOQ==
X-ME-Sender: <xms:BcN7aXu1KnkVAcoB4oulMxYJBSBX_UXczm7zmUqIWVMuxIF01IICig>
    <xme:BcN7afeHzlBtExxGcI3BBf8Jo0614A9VLG98KH8XCwY0Nt6o45e2hddIAg_IA9ZBW
    amyzNd0t0_QdX3-QLJ7kSDzJQT-nf1LOfT_2bBgc_LhixTFSy2tYg>
X-ME-Received: <xmr:BcN7afzbte0wpN9qrXV2ojLHnPScIioebl5l1oe2NfNQUX7e8mJB-rH4GPm07L-9t0a75akWHbkb7ktHPHmZv7r-XmD9d1F9P2T127c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieejudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BcN7aVEgg8fXD_FP8GEFwP7NpSZNizqzAnON5sx1-Nj77ppziwkj6A>
    <xmx:BcN7aTy-ynfbrzi2lRzyhxTCuqiLfNl6li5kySYhGivvFBe2Kor2Eg>
    <xmx:BcN7aWs1I96Xa8eRvpTnJ3kkpLAoATQ_CoG6fPdEmzHWd5V_En1SWw>
    <xmx:BcN7aQ30isd__ksHfIsjczU5q3oA3yG5gs1RtFnK-gTKLChKHqv55g>
    <xmx:BcN7aVt97juIJwO545WXC8UDZA-iGZDc7rjYyLi6_-s7ETGm4OcixOeL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 15:28:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] odb: store ODB source in `struct odb_transaction`
In-Reply-To: <aXu4nttn-SWcMmLL@denethor> (Justin Tobler's message of "Thu, 29
	Jan 2026 14:12:05 -0600")
References: <20260128234519.2721179-1-jltobler@gmail.com>
	<20260128234519.2721179-2-jltobler@gmail.com>
	<aXtDYY0Ao24Mpgyb@pks.im> <xmqqcy2sb4qr.fsf@gitster.g>
	<aXu4nttn-SWcMmLL@denethor>
Date: Thu, 29 Jan 2026 12:28:52 -0800
Message-ID: <xmqqwm109n97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Interestingly, it looks like there are only three users of odb-tmpdir:
> remerge-diffs, git-recieve-pack, and ODB transactions. All of these
> use-cases seems like a reasonble fit to create an ODB transaction
> instead of managing the tmpdir directly. In the case of remerge-diffs
> the transaction would need to always be aborted. If this is done, then a
> tmpdir could become an internal detail of the ODB transaction for the
> files backend.

;-)  I agree 100%.

"Prepare to create objects that may be undone in the end", "Now make
these objects we created so far as parmanent part of the object
store", "Reject those objects we created so far as the transaction
created them is being aborted" are requests at the right abstraction
level.  "Give me a temporary object directory" is not.
