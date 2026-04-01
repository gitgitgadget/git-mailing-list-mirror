Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAB23D7DF
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775079642; cv=none; b=Nh5u+y9jsrx5mFFoXGMKmn+s0y07nnguPPh9Ymm7lyq7HcCi6NmTQJ6a3honaxfat4K5O/08Jxp1RvWTx+w56NrDkMATOeuPgsDqi0/2AhCq6rBYamm/fBpm7I91fg3bNbTkCGlq8nQ7Vr40SPNtHDyO6yQ5MBSfawMeXl1ZftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775079642; c=relaxed/simple;
	bh=IV02ct3rO/0/SR5T/Z9bFBuux4/jPJVIA/odTbhZ7mk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M3UMhN+fXax2mMepuFPB8GGt+4Vsp7eVPExuzpjcEm1Eraz7MQalCqbMSM5DGPLmNuNeytNAr8Ribhe9yOQhwJhtzg2H3FUz6Vj8MDoYq5IHhc+Fxpy1LRY9IInaf81j4qAAWYYCsXTzHw/uPSmPTGsk3MWgoAC8OtOSu/2yslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tSX8PkTO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WhcD/xZp; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tSX8PkTO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WhcD/xZp"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 378C57A0185;
	Wed,  1 Apr 2026 17:40:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 01 Apr 2026 17:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775079640; x=1775166040; bh=IV02ct3rO/
	0/SR5T/Z9bFBuux4/jPJVIA/odTbhZ7mk=; b=tSX8PkTOSFS839DnkGmJQoenOB
	lTwmAZqWwptxc0t8RsisY4n4ALoMiNnxuirxR6x3XujGE7oIWd89AM5PK4ZM0eVQ
	KylDXGorKp6o0andrqvFxPsw+6PZBDjE1+QOJMC9MpLTCGrU3vs9YRtB7LotB90o
	2x0hlUvheM+pKyvyTyGoIg081u7wvpGmzEChDvGiaZUvwTqunRBu1kBswTzn3OXn
	r442dS1nChnZTrE/VwCLcXriE2hQJi3ru28Q0pgEOOjL2kLiw7r4+1FNvOBNgE2s
	nbVDbO0ClmHHMwIv99pN2T/TcYdBdiG05ZFaGoyGWYm+t9XPzD9GhHmgtSNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775079640; x=1775166040; bh=IV02ct3rO/0/SR5T/Z9bFBuux4/jPJVIA/o
	dTbhZ7mk=; b=WhcD/xZpBTePY8SCvgZK1ZvDvWuK2Clm6XRsQvLUn2UAFWeswu/
	xDJdOCdrTFYjEO9Mk3uju+gFrJ/Uo/+cE5vFCmTL2h+QPRjc6Xhc0CoicjJ2is8f
	ISEIJUYSw2USHVeODIKdATik1XqFmkCdyg+KQ7SnVrG/bwYH0X8TIPfkeLZy/Z2b
	x8BRnsq2ODFTdQSa49M//0e7ZU6S2GAwbWNNfVlMJ4ujjIMB9URttZ7wvXStD3pq
	54/ckvYeEcUXYZoVi6TjnYqDEAVIDhOMcTi+9Xh18xyXV2GX7yCpPvnkCQGDYvnv
	mLFfJkU54DSbWDj784T7tasVK0f3aNw7IHQ==
X-ME-Sender: <xms:15DNaT8JN5v6nSljFaFQi8t3O_sXJ0FfMEluKxeTrb_M9T79eap8-g>
    <xme:15DNaTbLQqjkvCotBkdotSbC7S7By13ytAIEnYB7HEBYf0j3wVltw4O7pbCAHxv9K
    iLaBZGAtW7ckL4OJ03AThEegGwzAOMVwCnm8JHrzQjohvUrvX-D>
X-ME-Received: <xmr:15DNaa1kjhlm4BGJC-6JjYG6EKUd8xpEASR4FNq9uJZKcm0JC--KkwC-xshxpNeiou57R_MAN_6B5yuwRHvyvSZz9Iv9WUL8jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhn
    khdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesghhruhgsihigrdgvuhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:15DNaWa7fYmAkFj19uO3u4uaPiD_Ni_nbfWHMFwGdILWzF84cmbJYQ>
    <xmx:15DNaaI9ZB1XQeyDGhCdvmOf3l0VANoHiF2dWC-GDkPJEOYVUVzEuA>
    <xmx:15DNadHolW9RyXmMCce8c2j5fp-vpZgEpB4GqJ3A3gBYVfCKImXzhg>
    <xmx:15DNaZtdtB7bBu1dq0DPNqTkOHEr1sgQZSAoi7FQWvWHqpRPdN0rkA>
    <xmx:2JDNaXBWHqXUpVkeEaX_JDNY-dCpFWEgYcHlk39O8fPc8AwncnyoeQYq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 17:40:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Collin Funk <collin.funk1@gmail.com>,  Michael J
 Gruber <git@grubix.eu>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 07/12] pseudo-merge: fix disk reads from
 find_pseudo_merge()
In-Reply-To: <20260331235637.GA2328851@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 31 Mar 2026 19:56:37 -0400")
References: <20260331233856.GA2327197@coredump.intra.peff.net>
	<20260331234622.GG2328529@coredump.intra.peff.net>
	<20260331235637.GA2328851@coredump.intra.peff.net>
Date: Wed, 01 Apr 2026 14:40:38 -0700
Message-ID: <xmqqcy0iuzop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Mar 31, 2026 at 07:46:23PM -0400, Jeff King wrote:
>
>> So I think there is something wrong or missing from the test setup, and
>> this bears further investigation. Sadly the answer to the second part
>> ("does it work now") is still "no idea". I _think_ this takes us in a
>> positive direction, but my goal here is mainly to quiet the compiler
>> warning. Further bug-hunting on this experimental feature can be done
>> separately.
>
> If this is the wrong direction or if we just want to keep things minimal
> in this patch series, the absolute smallest fix is probably to cast away
> the constness explicitly in find_pseudo_merge(), along with a comment
> that the fix is almost certainly wrong. ;)

;-) Together with the BUG("foo") at the beginning of the function...
