Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941122DF95
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759367; cv=none; b=lJBK4jMGnK/UvqlvOdJBJxVr4b3sKADJVuLSEHaU9Phm0/htLh0CB/uO8sf89uU98Esj7iwCaEAMIY81kvQcjNtrUjZVyBOev16rq2zHie1Oz5afO5pqjC/NMpbhhou3SO6DU3fjMkvdLaoz4hiIJnwg5nIZuj6cDYDT9HVBEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759367; c=relaxed/simple;
	bh=vGRilU51wBvkOPgI/8K48hp4Y48fgLvCnvzMeKiu9/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O6P0UNJswUlgZeC9/lh0/dxbPo36iZ6LSzPEKH7yRnPA0DgygRyo0DYiM6R4Y7r0fLYjov/Z9ZMxskRfECMp5BmK9g+uoV2BnpFLfL4ZXDePvX7d2Sba0Fs6eS3itU+60OP2u5n5hIZ6TPdEpgVo91O/pQZiN0Bp0iETnZ47/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rKBd77CN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igesbJLs; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rKBd77CN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igesbJLs"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B8C625402D9;
	Thu, 12 Jun 2025 16:16:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 12 Jun 2025 16:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749759365; x=1749845765; bh=zAQupvAZwn
	+UZNdqsG+7dEENd/3EkpgP7OfywbWlCxU=; b=rKBd77CN3yDkBKYR6MhUDe85iW
	ieJc6vitRqYYdvKrTcHoiR9I86XviIUZ2IS1m4xTDU3R7YK3MvDMvspBTfRdWhj+
	0jbQNXq227WIKj3v1rhC02LGBHqBm5fZ2catZuRAn/a5gpszVNns0vnN3ilxJXdd
	iRRZK8J5tBNxT5zQx6YuDqFqf+ak2IvFzgg7kfgFxJA1X5ya47FMBPpfvfCzd04R
	lheHLEBsUh1OcmMkNAi4JmnR2LFztCC4NfI35ly5Z4xr03L291ZDSCFbyucuzKV7
	eAEMTm0PsHhvt1BnIBa2wT1e8S4VAKFJIb9PdddJ/JaHQqwLMDe3JYZA/l+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749759365; x=1749845765; bh=zAQupvAZwn+UZNdqsG+7dEENd/3EkpgP7Of
	ywbWlCxU=; b=igesbJLshAPTjwPLe4BbUK9gpEGXBStmuMBNmM7qloxhrtwBssi
	r2EcBO4dytgE3d4RV9X02KaJI3Nfj4AslnoSX8mT6yHO3NDwPzNCtSfgByLrQWSq
	vwix/OXA/AeWTfVkQL2a7mXWKu3gsl3SDpDsEU3mZPDIQ8/Nr47fp8pxTWIUmncr
	YK2seoIVOg0vXDsH3hDdyHA/ePBV/nTiQF/Na4PHFGXTlNi/FnEaSyd/tC5vSiAC
	H8EalCifM1GLDVDMO2n2pkI0Yblh/GMy6XKlHIKF4ag0tCnrGjLyFKyLrTLk2AlH
	NjG444begehvJCt1W9RVD+ERt3E6UFzIAZA==
X-ME-Sender: <xms:hTVLaE-dgAJc6_hRJDzfBOCjAw1pJaZGnw-Gkk3gwN3zGvLm1I_2cQ>
    <xme:hTVLaMsQ4myqYEJu06LGoWsI0MnEb_MWJxqlnzWYE7ZyDicWJ3QO9a4duyh7ASfcg
    9x_XqqdRWsPpiRxSg>
X-ME-Received: <xmr:hTVLaKDg2_N5vc2BRMtjVpklOeVMtlc2wN7db2mipShE04oIJRx1D4DeyBUMxRNEu-Iy3lA_WpR0vOGGCoiUyENH0S3XTwOy2CSO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduiedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpefhjeekleetgeetvddtkedtieejfeehhedv
    vdevtdfftdelvedufeeifffhudeljeenucffohhmrghinhepghhouggsohhlthdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshht
    vgdrnhgvthdprhgtphhtthhopehsvggsrghsthhirghnsegsrhgvrghkphhoihhnthdrtg
    gtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hTVLaEfQ0XhjL25VvkrUA8C3VlKemuHhaMF6DGXD5E4IhQp7Qj612w>
    <xmx:hTVLaJM8LcLQxDAxKmhWXtqefEKt-oPMdg28oixtXvx0JNryaNX8nA>
    <xmx:hTVLaOl4GSSduavbBHjxFmo2ALjPPcPtGWCNlkfMJwR8gGAgNK122w>
    <xmx:hTVLaLti4zhk69zf_bketfFIYq9PE22mczjNxVhdnWW0Sjsm8peHXw>
    <xmx:hTVLaPvJA9VCaKo7Lt4Bm18vxwg9j6rnFuXVkgi7WEzP_KdcKkEXRd27>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 16:16:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,  git@vger.kernel.org
Subject: Re: [PATCH v2 4/6] bswap.h: Always overwrite ntohl/ ntohll macros
In-Reply-To: <aEob-FXAvc2Wqmlr@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 12 Jun 2025 00:14:48 +0000")
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
	<20250611221444.1567638-5-sebastian@breakpoint.cc>
	<aEob-FXAvc2Wqmlr@fruit.crustytoothpaste.net>
Date: Thu, 12 Jun 2025 13:16:03 -0700
Message-ID: <xmqqmsacd8cc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-06-11 at 22:14:40, Sebastian Andrzej Siewior wrote:
>> The ntohl and htonl macros are redefined because the provided macros were
>> not always optimal. Sometimes it was a function call, sometimes it was a
>> macro which did the shifting. Using the 'bswap' opcode on x86 provides
>> probably better performance than performing the shifting.
>
> I believe that the peephole optimizer will almost always optimize them
> to the bswap or equivalent opcode, much like it recognizes how to
> generate rotate opcodes from two shifts and an or, so they should
> actually be equivalent.
>
> GCC and clang both emit simple bswap instructions with `-O2`, which is
> the optimization level we use: https://godbolt.org/z/1r8P1Pqo7.

Good observation.  In short, we do not have to redefine these in
terms of bswap32/64 for performance as the compilers should do a
reasonable job.

The updated organization to separate the two concerns in this file,
namely, (1) figure out the best way to write bswap32/64, and (2)
override (or supply on platforms that do not offer) host-network
byte order helpers, does clean things up a lot, so I still like to
see it, though.

