Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA6D2580FF
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647850; cv=none; b=npzdyLLktAxNoqBTpno9/gvYYGpje5wMq07+VLx5nT13OcPrDeRlJaLiMcEPAo7QocvAOcszBEJhsLmJ9JiaCqE5BW+4x2ROrBmGS1G3p7nkDLTPpQhts198uNzLDtU6s4pBJBFV2O/kDazIZjGsY3zcM7YCMcrNNsSZVx5D3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647850; c=relaxed/simple;
	bh=K40jLfDprHZhx20/UvAQk5ygRO5TNBC43miAx5F/O3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o1ecZQjjByJpBNjeMt2vKWe6dlYL0zzRsLW+Fu45ljKkf9Edyxurk+NQsKMWF05PBOSjP1woUfjJR2HMH+a+qlUkAYH7bzWxd2inWZr04ZtunNkeezkfYU5UgzPkRB0Cci76cgXwoNQagPiF4TPZLA0gXE6bqyq6kTaYGv2CyYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O74Owo9p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qJW/CnIn; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O74Owo9p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qJW/CnIn"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A809EC0239;
	Thu, 16 Oct 2025 16:50:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 16 Oct 2025 16:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760647847;
	 x=1760734247; bh=K40jLfDprHZhx20/UvAQk5ygRO5TNBC43miAx5F/O3s=; b=
	O74Owo9ptKZIemhznFEMTDNWz19leqslbzceox2FbhKPG97V77+QUtB7nPjUpqRX
	Mz/8w4aao4RwO6qy5cuILNfS4/Dys2BytDNxg4GtNHVz0fUNbkDQHydoYaRu5TNa
	Zx6B/7HXjWT2rPzQVJy8LWZTINP8HjicnPSzhpayI9v/yK5qY/2/g8n6yuhcZX/B
	i3ivNq2w0Ev/luWllVXR3UmIQ2NOAlv1ugipUiIqNPlgeQPn5OkFjAurXBd4um/u
	hT39RCAPnloy01H/4E7pBblMVFA7qhxuzpOtFSapXVI37ASGTTtrHTWpVxbBrwg9
	g4H5YB1paS2Cf+OPIU7GJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760647847; x=
	1760734247; bh=K40jLfDprHZhx20/UvAQk5ygRO5TNBC43miAx5F/O3s=; b=q
	JW/CnIngRT8yQWL1ys9TvEy6tZOg+6miN2eUUrUezAnjJjsq32mIRRlXTgGPZJqo
	BRhCcA0V1fxU2mK60KZjFwCZV5BTs8urBErqAWU700xF3NGXqR5OfRM2ICev+sWP
	3ud+iOci86v4H3P9VFrd54cJJwNGY06w0u8DB0uSAOwxV5SGOaPAq/ha3DqqWHhw
	wz4Rh7fxJsj58mwuJpIFsSQkMbgC6dNmUnrIiIKutAPGRSZt4+iZOIYJSjRv/M77
	QE+L8a1jxj0owX3rfLKXkPEP41PGQiHmiwzRQqlIA+2MiepvAO1D/5aio3sQbtp+
	upNkQBZ4iet+PQ8O6cVZg==
X-ME-Sender: <xms:plrxaOQg9tbzXBXl7gyXxGmDYdFYHmyZeAVUU4Cn7LRYrtQhItSHQw>
    <xme:plrxaLPQWmTsWSuPNKoErUNAtgDr3Tn4mySrZCRV8A51RNSLG50N0ZQ8RSiEwF9pa
    H1Mh7tms0hgz7Qqvr_ypKq_Qz8m9bnXfR6be0dpz34fIvs380ihQQ>
X-ME-Received: <xmr:plrxaJO2rSXR_lZ2I5mjJ-uHAfgdIGa1DHJNM-2qp09o0uocUI0fsg1HlCTBXJovxW9ayTzhCDYJ_zb23dqnlwo-FbwH07viFq9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehokhhhuhhomhhonhgrjhgrhihiheegsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:plrxaDtSTc9I2A4rm4qpq_sK9BsFa2Cq7ZACdtF7Q6tLrJDV5S15BA>
    <xmx:plrxaLWAkh7WQcmI3MuuWjFZ_lLZWcUX5ZVIaHKRHK-sGL4STNHSCw>
    <xmx:plrxaDvscEv9U8hqQwShXAfxbt_diAm6EHmJCDagj_zTCAHsddPa3g>
    <xmx:plrxaPWgiPFRXCeAyrATtemsV5pjOFJWcmC4MCIzDKMMwu8qjYJk1Q>
    <xmx:p1rxaLM4Xl_v_EzZ5wiNGBDiLUf3HyMSLPdvagidPMg4yV-fQ6Qkwmzj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 16:50:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: trim only CR characters that precede LF
In-Reply-To: <CAFpMFfBe7+pMUL8aaDkGkPUaE9RhCW25OJhJy69EcukgSFn9+A@mail.gmail.com>
	(Okhuomon Ajayi's message of "Thu, 16 Oct 2025 20:38:11 +0100")
References: <20251016184420.78268-1-okhuomonajayi54@gmail.com>
	<xmqq4iry4r3e.fsf@gitster.g>
	<CAFpMFfBe7+pMUL8aaDkGkPUaE9RhCW25OJhJy69EcukgSFn9+A@mail.gmail.com>
Date: Thu, 16 Oct 2025 13:50:45 -0700
Message-ID: <xmqq7bwu3716.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> Hi Junio,
> Haha, I smiled at your “teh” comment — I myself often make teh same typo
> Thanks a lot for catching the typo and for the detailed feedback on
> style and indentation.
> I’ll fix the tab/space mix, shorten the long line, and use your
> suggested comment wording in the next revision

I was hinting that the new function name is less than optimal, which
may not have been conveyed very well X-<.

>> > -static void remove_cr_after(struct strbuf *buffer, size_t offset)
>> > +static void trim_cr_before_lf(struct strbuf *buffer, size_t offset)
>>
>> In other words, this normalizes crlf to lf line ending.
