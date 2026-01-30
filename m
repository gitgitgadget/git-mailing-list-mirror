Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9BE322B6D
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792200; cv=none; b=CY1Mpf3MshEf4pFAkTUstClluy6xqggiF464GhfCjkyrHK4SQWbTtp/fuEeTKLBlRQhwRJl1TJtQXDFW9jNjvwDtWv0xnXCTa3zZ7N18aO4FrEXnIHJUBOIhKLI7IHBJdfL/UV8w358ZiDpMV8ghR13yuYy9Puvp/iFBIgZ35bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792200; c=relaxed/simple;
	bh=BIdMDGbDjPjPIsJ4DyWelkiJW2bNa6NrbFWh1SQwLUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r3rPOKiuT1PBSrwGQ2LnUKaYjYptptx0h1N16iFAtS1xfc6Do9F+riBCD/AExjCpVdtisQnoMJHpx/zgBF5H1zoy1UI43N0SEtkSeOkfZ5K3CE8pjsBNJjRxcPBYJN5B3auiFt8nAWANZV8AfB2oTfetzss1eNQ/ZDieu2RC+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BfuFlsqp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m1g6Tc1c; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BfuFlsqp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m1g6Tc1c"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 423D61D0009D;
	Fri, 30 Jan 2026 11:56:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 30 Jan 2026 11:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769792197; x=1769878597; bh=BIdMDGbDjP
	jPIsJ4DyWelkiJW2bNa6NrbFWh1SQwLUg=; b=BfuFlsqpOnSaa9KgrCGF+6Xlp9
	33/0SE8RPaZ6ZmIU8r8ze19q2CeX3nXZK6mxsqti9Vp2GzrD/u02MUiaEn2O/qg6
	SICsqE2d7pdAPLXHeDUtH4wUCyom8iiMBYn/d/pmkp1ExrBqsYgcrfvo4zlyudQJ
	vr1rX7rOYNed6oGvm0pil9AnjBkTX8lc1jtQ807+m2fFRhSD5DumcdASna1qiVHi
	6geUCGgDEEk6zEDpkvjpOxDYqvjID29ZSSKrRgNGBexUL7oQ2fc7G/va39P2RmLW
	edlESzFrmXo6OacOlRhB4otueLAgDzWpAqNatd1Y+Mc5PAorihwc+PtlM3QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769792197; x=1769878597; bh=BIdMDGbDjPjPIsJ4DyWelkiJW2bNa6NrbFW
	h1SQwLUg=; b=m1g6Tc1cdzeTr1gg3e1ezK9PBH86/xykYPimTdoqSUg5VkVtdog
	tv0aJFqycZVYblTMTPxnVRAn4ZJCAzf2ZA9lc0HajgJjTwWW2cCo8u6PowJxIU9u
	KUHGQpnHn1FtUJF86iyljXLcHqYtmpmlP6/1PxkALNPsZs1eO7yWItkOyXpFFNmC
	nSkTAJ68sm81q8V5BABpmK21C5cVptp6jY1B9SkR0bHbtwGWTCfNnxUYDVB6UgrK
	ghOmSzjokrTUU8yozp2UGsiqE3D2bGocgyX7llumb8aDKPikZt9VKSXawfiP6tan
	5JwpSyyiZX3tYtieXLHu+9dfPXX13FpeYqQ==
X-ME-Sender: <xms:xeJ8aRPmmhOm56BjRJaI0tBaxkH5huggElt8-E0SGoWAqJ3EfdIdAw>
    <xme:xeJ8aa3uWTIojYigwKIxP2iNW6qsyvfuHGMwtjpqj5_vryKoRpCgfM3pUaLsL8Bm3
    xn3Pc9Pt7mfoxW9ezCsd-SXPeII5w4-KOwr1WuiDKcsA__9tVs7Gw>
X-ME-Received: <xmr:xeJ8aYmgSO3aGNLYTKpfyW6agNCXxaUJGa2Zl9IE8s0TXin7bTLifhsNczc7omv9cHrTaja9rDh9UzXplnF7MHWESgx8MXPmPeyc-os>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xeJ8aZWaFJoWvx_DeMdl6Jx0Aqgn7drK9L3OVRp5c5IzgyWdk-H36A>
    <xmx:xeJ8aWtsGQpICA7bDhVjiFYGTvg0r3uzWCBTrFTisLsuHW-wKmnKOA>
    <xmx:xeJ8aUal2-R7AF0IkiGJ6UHqF3wHmHUbGSjD0W1NnrVHqZe-egcwsw>
    <xmx:xeJ8adWKwy4a5HkF7ZHglfgVv7-0LlIxT_LKeDR8fFNevj-Za_9R-Q>
    <xmx:xeJ8aQkpUcGqTqv8I32yureqr1fGdrOA744z_KqQMujJF0C6gXxlsLTb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 11:56:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 4/4] bisect: simplify string_list memory handling
In-Reply-To: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-4-0449b198a681@pks.im>
	(Patrick Steinhardt's message of "Fri, 30 Jan 2026 14:27:45 +0100")
References: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
	<20260130-b4-pks-fix-for-each-ref-in-misuse-v2-4-0449b198a681@pks.im>
Date: Fri, 30 Jan 2026 08:56:36 -0800
Message-ID: <xmqqqzr76nuj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> It was written this way originally because one of the callsites
> generated the item using xstrfmt(). But that spot switched to a plain
> xstrdup() in the preceding commit. That means we can now just let the
> string_list code handle allocation itself.

Thanks for an extra attention to the detail of the way to refer the
previous change ;-).

I think [2/4] is a good direction myself, but I'd prefer to hear
Taylor's opinion as well.

Thanks.
