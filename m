Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E855257448
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038176; cv=none; b=UzlNKLDcH9vVu5bzGH1rC/iENJwxHfX3RK/7obu9nqh2Ut+MlyifthC0feRAFKF9bshFY15xbeYEwCv6oCdluVZHbnM0f9vuBI/THCwDAXIgfTXWJ3M3LyvqQnSQwJfru42EHwPKpjdQf3b/YwrUc9y7/CQjUEyxtKJWZqpqNBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038176; c=relaxed/simple;
	bh=4KnDV+FO6qeTLkPltI6Css1nVfonnwKYOg1FutgkKhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ilUFbIVFSRqj0hid07oJbklWOWU30knN58+Ml1m83de9M4MvvYTeKpxa7EQBr9ugSWxxoQCmWpmFsdALVTacJOeJcALqDkO8q77SFyhDHMxYMqOrS6s+yNx1x7IkGE37tJhlCJ+a3XvfWhG6VPDCGwUQ1XwxP7P7ZAnSjEjLX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xaad4vbm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I9XY+o6v; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xaad4vbm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I9XY+o6v"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F821EC00E7;
	Thu,  9 Oct 2025 15:29:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 09 Oct 2025 15:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760038173; x=1760124573; bh=mYJWYjPqg2
	iiyuKczAkxHPH4so/HHJTQSdc+CB1GVCg=; b=Xaad4vbmrIdBuPi6VY4A00qCWL
	VgaLMDua6ir0wh1z34MMb6bgTZjE97UjbctT5Qf/evPukFFuSSyyN85HeceFGlDk
	41Umo4+WByp/O1RThTh2EkjXOIwL7FZKOZu5R+/kTQvXOxQx1QKS5su02OG+cyqK
	VZe/e7Ye3oJkcvV0E8Gzvw5xxo3MmFbhx4niOHLh2dp6wS2Ec96Jy6bos6P5Nidb
	G7X28z9xiv0XWJNlDL7qAXglCYywQvICQhHbCT3gP4fdtGO3Y2T8Ec8Yr/r2ICfe
	7ABVNqXqaaVStlyEbdyP0DPu0hBreCBBhS8epmTq9k1atSxvScDpdMNIMpWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760038173; x=1760124573; bh=mYJWYjPqg2iiyuKczAkxHPH4so/HHJTQSdc
	+CB1GVCg=; b=I9XY+o6vdIm0jvHm8unNKzLlDISJyGdexkhxIoWBfOgJ7ZlkS/8
	b3SG2ewk4DLzfYtQ7ct+LUtD+x6aqXRCJOkrA8cgk9cTPUY1LQ4yKPx518qm2tFJ
	+IfPNwLhJqY18MLBV3jxG0HLQqQhm7KlES7nZq3GyPwKta/BKFO4GeYjs2L3WRzN
	ThV93NBE8Qkj4KXUhJI+7/vFk2WC4/kRpPfjPIJS+SGJcqxkfA6W15fPdqLDT43S
	MvkaTjmoQya65G2dvVof25XwAU/GaqS4i728XWplUbpKjIL5sIFTuuy5GZoPTmSt
	o+troYQ3TDPjzA4Syb61eEMBEzxsE+zQKqg==
X-ME-Sender: <xms:HA3oaOZqCYkCm_RkZ4_EjqSsjOfjfyW7wV63VsAgrHatJAXVIaym_A>
    <xme:HA3oaD8IyQGJa5vkmglN0PkeQs66jlqIf98AL76tLK_3Sc_pHLUz2ZLx6z7ddMDqc
    MUHEvTJNOCz8897N5cN3JzO9WLvCdft9kFLqa2vpg3S-_cnqbiW2Q>
X-ME-Received: <xmr:HA3oaMnxMiO-JWU9oUL3RfctjaNIU_FdUQX30APTIS6QAI2mLo-MFz9LVH1uAGZbydjNShnPTnUquVsmmmnxLaOAnLyLnnNtlVNt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegvrh
    hitghsuhhnshhhihhnvgesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdht
    ohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:HA3oaAw-xAILU44smspEDkfTzABY5A2CQthquuFwr9uaaRlFL6v12Q>
    <xmx:HA3oaO5i3ZkXAuFCm_qFhNxYW_H_YKbYtu2tXV0VtC5wlWX9nG6ZsA>
    <xmx:HA3oaIWpLhPvi62mKzkjv-UAz14XnaxlCrLnnZW5bEMspemGbNAE-w>
    <xmx:HA3oaOKnznwA6SC25UnNecYyfoFV8ATS7noEj1fuaqDjHyThXopSFw>
    <xmx:HQ3oaM45m4VpU5GjY8puF-cteRGn5Ktyh3CxQMdukXRTOCtSJgJqd1eL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 15:29:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>,  "brian
 m. carlson" <sandals@crustytoothpaste.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <ericsunshine@gmail.com>,  Chris
 Torek <chris.torek@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] ci: improvements to our Rust infrastructure
In-Reply-To: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im> (Patrick
	Steinhardt's message of "Wed, 08 Oct 2025 08:27:11 +0200")
References: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
Date: Thu, 09 Oct 2025 12:29:31 -0700
Message-ID: <xmqqa51zeuw4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:
>   - Adjust comments for `encode_varint()` and `decode_varint()` based on
>     brian's feedback.
>   - Some small improvements to commit messages.
>   - Not changed is the default column limit used by Rust. I think using
>     the column limit of 100 used by the Rust ecosystem is sensible, but
>     if there is a majority advocating for a limit of 80 I'll adapt this.
>   - Link to v1: https://lore.kernel.org/r/20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im

OK.  I am ambivalent on the column limit one, but otherwise, this
topic looks quite well done already.

Thanks.
