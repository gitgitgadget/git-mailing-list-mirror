Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A942741AB
	for <git@vger.kernel.org>; Tue, 27 May 2025 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352970; cv=none; b=gKtfNAUkXMcJwMaIYG9A9NWDNiuC8eMxxCFpZPJgdUh5JiYOZA6kwsohV7YNYw/JTXZLj6zOAGQvB3wozmWPQuVNvZUnbkBuDhtUEmApXBNfGGR780FAw9nua5xAqHB26Bi7/sU3ZA2l2ggFJUo25y0EQsEIxGjGBxzUmaP9rjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352970; c=relaxed/simple;
	bh=/5ZbiOtIj3yex5K+kCGpBPdDeVmSOriPgcaMERuc0UU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a7M68aQvPpyTGHuF/8LCFbMzoCv/UvYM22OJR2zTF94I7YEJBV4lMIiTCTx2jTMWc0H82RLmioKNXDFnB3btwyb8LtEVAKOtG8sBIUDcL8yz6wwKTi3PPkROvpXctVjx0WxKkN7a5Vqym7ofMlSaY2NPIdllbdz5gTeYQzCoO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gq/4zwrX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kxhuj3Rz; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gq/4zwrX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kxhuj3Rz"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E48811400B8;
	Tue, 27 May 2025 09:36:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 27 May 2025 09:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748352966; x=1748439366; bh=LTdkRtF7NU
	jh3WKzYEwuJy89xm7gcfmX3C4S5Hy2Q7g=; b=gq/4zwrXPSLRmWVPweIVqU5Y+X
	7AytnkOdB5aDW/EHhWZIQXStZkioZ4ExozNjrqlRHpCAAhlna0Ytl1/RCEO1J3DM
	MkgwEB7nlZJGUYFc0EYtzjgSAT5XLr4h0vQqnmQXccrmdTgCs8H++ckQ7bIcuvjX
	w1Xu1OcGGUVSfib8VJRA910TrjK3wGADQxcoaCQuvOHondRODihClZzuZQkzN7lr
	s2jw31IWjQwkIrhOoaQr8MQvBI6xcm4Q0W6K5dE8Pv04yDhUwhxU5Y9yTIUMFvTZ
	75r2N+e6jGZNHQuZzM/Yun5Z4LlRvXIs4U3i4ykQSpiH8qAFC+k+vxFIPuCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748352966; x=1748439366; bh=LTdkRtF7NUjh3WKzYEwuJy89xm7gcfmX3C4
	S5Hy2Q7g=; b=kxhuj3Rz78nuAty8x2fYvk9JIgQyNzzR+ohjZJuT119+9cc7YAd
	q2ubxLu/lneNCy9gHUE9534AGrHtoeSvdINR2D1HtoLqRjhBA1/9ODX3EV/+yuml
	Q3c2kYCe3snmOkzQIv3+oYAJ9jxSWSpeYtqbuPd3aqD4eWl1XL9IEGFU3tlFNf3c
	5gn01kummWNHwUbP6KIxln9UuwOIWlyUXcrxHScuO0pYU56n9nYUPCpdZt8NkjEV
	7aVx+kgHG5o8VtuXFR7Zgcr++O3EIFvadpIPBei1vs6DAZu+2umHRUkI23/cdAUb
	opOIcSjEst4Xg1YaiQChkcmd2HT24ijBQUA==
X-ME-Sender: <xms:xr81aFStyXHJkodGo8sXPK6nXpbvMSD1tPjhrVCrLY5bGTjaYR5BFA>
    <xme:xr81aOxg_o0m5pHElepHOofB0R9cmRtpQKuRGjhwOHI7P2Pv7GEEi5vytWRepkMf-
    YOFh1HWKTa43-bgkQ>
X-ME-Received: <xmr:xr81aK2kU_l4ApL80lA3lrYBl8PxcH2bG2Th0tLe59-tg3g9zTMYolIM-fZhC2aLENyrffWBr3aHpVrhTo9z53CEiFXSjulMrjzMzDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihj
    ohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xr81aND372gO9Df1zDI5SaM4t932OaiFLk9QFUtwgSOTUK1n8Lh__w>
    <xmx:xr81aOgn1VZVl19EgadwV0NOSsLYAl6bz232Ic58fRbbucmrSVc4fA>
    <xmx:xr81aBoKY_U_8rYPsj7Xm9yX1bhaFHLMYdYms2CXhuEbXK7mbqBNPw>
    <xmx:xr81aJg61MSVZPO06ONo1nJlLroeQdL80mAuhEOXvkscRhiE2FLWUA>
    <xmx:xr81aHR6qiR2ifh8a1hp9odS-3y2twL3NAnmyN21r9-boGGg-AuQ9_tS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 09:36:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  git@vger.kernel.org,  Eli
 Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
In-Reply-To: <aDRiLdUCEVQHq26z@pks.im> (Patrick Steinhardt's message of "Mon,
	26 May 2025 14:44:29 +0200")
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
	<aC2xp4Cdb0j6OX-G@pks.im> <xmqqcyc2aqy7.fsf@gitster.g>
	<xmqqfrgx8xkw.fsf@gitster.g> <aDBH7G-oKKxAXWBp@pks.im>
	<aDCNqRAoGygwnAbq@pks.im> <xmqqo6vjz5cn.fsf@gitster.g>
	<57de5690-f683-4e8c-a05d-a91198b352ca@ramsayjones.plus.com>
	<xmqqwma7w29o.fsf@gitster.g> <aDRiLdUCEVQHq26z@pks.im>
Date: Tue, 27 May 2025 06:36:04 -0700
Message-ID: <xmqqzfeyrxa3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Yes, it is a very good question.  I do not mind if the answer is "it
>> should, and the make and prove shouldn't let unexpected pass go
>> unnoticed".  The difference between the build systems bothers me
>
> Indeed, a good question. The TAP specification [1] has this to say:
>
>     Should a todo test point begin succeeding, the harness may report it
>     in some way that indicates that whatever was supposed to be done has
>     been, and it should be promoted to a normal Test Point.
>
>     Harnesses must not treat failing TODO test points as a test failure.
>
>     Harneses should report TODO test points found as a list of items
>     needing work, if that is appropriate for their use case.
>
> So if my reading of this is correct then Meson isn't wrong in reporting
> this as an error -- "in some way" basically gives it full permission to
> do so. So this is plain old undefined behaviour we rely on :/

So, what should happen to succeeding TODO is left unspecified.
