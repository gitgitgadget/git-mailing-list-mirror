Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776EC281358
	for <git@vger.kernel.org>; Mon, 19 May 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668655; cv=none; b=cp2+84IXpOjr42atNaQtbPCKR454re10jVUrHqrwb52W8jox8EpOy8cMF2IRciYHfKYrGc+2Oe0fhRG2JYvW6bL7n/CPS7oGl0Uzl5yzU6XmD8zPABnbssxmmI+sEjASLYXSDKWGGn0B7ImnSTWfRGsAyx1Hv/DtILlovoXrFzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668655; c=relaxed/simple;
	bh=HpYw+8EqnxOu8rwlml0Sl3AFwS7qB2mTrcA42LkEfPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uT6vCUtXTJLlkvrXTCOSqSOPT7+cAEVQY7xNeWtpTSzJsuP73WUoWrtMeHiEYwjSPMc4rLrvM5VKwG4Sh8KgJzEZfKidKzUP3htE7lacGRWCKosW2ravErjpjH2YrgOh6wNErHjmr5qxTELHzfo/V+lRPji5dSPajUhQV3BHpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J2hlEEQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Njycp5rG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J2hlEEQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Njycp5rG"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 63AFC2540142;
	Mon, 19 May 2025 11:30:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 19 May 2025 11:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747668652; x=1747755052; bh=HpYw+8Eqnx
	Ou8rwlml0Sl3AFwS7qB2mTrcA42LkEfPg=; b=J2hlEEQXBvxAbHMJf5Oiw2gSGM
	XBw/7rKSt6MewpJiw7ueO6u2fq6IsI82gW2XU1xzC+Z+wa13bfzrpum9couU4RPi
	DTOL86qHgRfQyVcW4kElLb9u36KquwMFJ2U3n+XnpR41zNsRK7TiIpF/fckx4z9w
	BxZtG0AU1GlrX6scW6c8Y74zw4tGOW/nQmCmBmkJNQyoiWuofLDSdN9buc5ziyiN
	Cafh1yUM+0PyIGeEzyueAzg0Q5iHzmi6v5PBHouM9g2kxw633jeILtXz+3OpmxK/
	VP23e0iBo8FZe9HpFcONm/K5y9mSTmJvzjpYCtldEixaEBZTMH5LzweiodwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747668652; x=1747755052; bh=HpYw+8EqnxOu8rwlml0Sl3AFwS7qB2mTrcA
	42LkEfPg=; b=Njycp5rGtgHMeGFZFQDfQVGcOaO/s8AY1gmu/GZqtbiAxQE7zZa
	WQOhuzw5wVpxQAJpjTbUogasakYy4VUpfLb98zz+CPkEC3ZRoEagHBczOWvuIfM9
	wxcn+0N2fv0rPYm8e2HCPR+3hzheAkStKmtncFbQR57Gevk2ba84j9zR/dIDKDmI
	r7GwY35DH6QIvlEstl5GWXUnFEVaz1R/gnfLPtN+LNLxloPb+i8i8pielbstRkuC
	bEfdNADzjU9nML6gN+f5DawEtk5jL56/YAw/kLfVoUOVvxVl+fdoNQRq1LgUlQ/w
	+9im9JgQKtcgIuMkYIkYjgYhdp2UvNAo43w==
X-ME-Sender: <xms:rE4raGP5H1RuccdzFjVVnucgEB2hVeENWtU9pBNELN3De0UNQ0xI8Q>
    <xme:rE4raE895pQhfI6aAfZEaDgYCJUDhtEha8jjOCxNd1mJwzdM3N690e7NC0kAMHo0m
    zbKarssC3ztwKhPSw>
X-ME-Received: <xmr:rE4raNRsUT_MqvN4iO5m_GRrtcUt_AYG6dm31OISAJtusDL4iYMXM8f3Owm63Gfu5oqKqN28ahtA3z4bBLYcgWSTvzEdbP2ZIX9T8ws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:rE4raGs6xY0JfdWyiJszDqAcXUq6k5VG44yoQ8GTqKqSlN8E_ouNfA>
    <xmx:rE4raOfFXXBl3hSWfga_mWK9y8T7jorvLCruXpvPDJFi5XeAZ2pJYA>
    <xmx:rE4raK1plVuURNEN3YmEMYRxYZgGDRwr-EZIi6aFva-GYuAJ9nFIAw>
    <xmx:rE4raC_-qB_Zn64dDxelHO3IZDahwAqgqrpeVTPG1B26dCpH08NqVw>
    <xmx:rE4raJZsjsgHpDXFWJv54ncGCPHMh4OzpaaEFop4NwwSD7og7WQnu1Po>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 11:30:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/13] hash-object: handle --literally with OPT_NEGBIT
In-Reply-To: <20250516045010.GL22242@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 16 May 2025 00:50:10 -0400")
References: <20250516044916.GA21985@coredump.intra.peff.net>
	<20250516045010.GL22242@coredump.intra.peff.net>
Date: Mon, 19 May 2025 08:30:50 -0700
Message-ID: <xmqq5xhwpqhh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Since we recently removed the hash_literally() function, the hash-object
> --literally option has been simplified to just removing the
> INDEX_FORMAT_CHECK flag. Rather than pass it around as a separate bool,
> we can just have the option parser remove the bit from the set of flags
> directly. This simplifies the helper functions.

Interesting.

I never anticipated this coming after reading the previous steps,
but when presented, it is so obvious a thing to do.

Indeed, the code path to hash_fd() gets simplified quite a lot.

Thanks.
