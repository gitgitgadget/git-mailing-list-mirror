Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB126CE07
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753305734; cv=none; b=DYG6gYgwlIL/dLMPpSrthZuzl6p4CaHqdAsKBSmKkQITmdEKtpf8WEpdiuS2W2SfbDZPjdgWLFptACNfEmV2fipJSt+crf/0BuRjBhZ4SETOEOehOob97WJpMpgYb29cKdXYz55mTGgdf6PDzfJyozzv678GgH7Xn4ASy8kZYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753305734; c=relaxed/simple;
	bh=XqUfU03Tpq/FV3pA7g/u+MNbNk6QIcF92cIuIvIK0uQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YPs7KrAp7Q9mUtypK2RP2IFMUZVc65rY2L6pVCUazcAQYepqfdxuWNybnhhZwUlmnTzA3tiWYpWy2sak4+ES8isCnlEy2Ut9SBlBw4xXvFAiBe/met+oBMjucm3xMN6ZFEsroijB2mRQ/8h2HclGPpwFm9uo3JhmdP5MX/p1Zl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mY+PUZiX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e7nhtiit; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mY+PUZiX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e7nhtiit"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A58DE1401452;
	Wed, 23 Jul 2025 17:22:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 23 Jul 2025 17:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753305730; x=1753392130; bh=KiDBVXueXh
	Ex20eoT/c4ptDBgujbLhKIdGNsPyq1jJs=; b=mY+PUZiXvd7h9iEb7CTWwopMAE
	gzVWLr0zqZTLIPNZdE4L9yft3WEGvy+fbBnUCWGKAwVZbXNiVL4VVhqnI4q8rsT+
	tj/LGtleLNqqgW20cJZ9Y8Om+b/S/jeHsklnj3KJAbfWfp1nGqQPsb6odn0RvhVu
	3EAY58JMaFYj0pu5v+UyScdq5LjtFre+fhT8mjS7ytIN+2FnrEhZWCrXTCd84787
	7jqlVBGwJ5MjEYS7rSy4KRT75KWOvExJfq7blorgH6VaFqjTUqGmhY5zAmLWV+kS
	MzP5gf6+4T+V6qixSPAW7fwK934FDec6euWLiF7LkRi+xFEMmAObDvmFRnUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753305730; x=1753392130; bh=KiDBVXueXhEx20eoT/c4ptDBgujbLhKIdGN
	sPyq1jJs=; b=e7nhtiitpEzUz2l6sGmDM/U22gxU8DEgXyTFqpxkb0laXD5UKkU
	PxzAOkDclgzg8thIZReb1U6DYNGzNFleAWCmcLIgEqpGv63is6JCmez0vVcmCF7X
	4B9F+fXCHpVhfGOaPAPTRVVMGUV2wMWqxvJ0slJZuXOvyvolo/a6LBwi5dDUVMtP
	0XiNzBYzFQQcvkN70CW3rCjPOhgD3Dy+Do2lJLdedscwU56z44tMoNrIAjZYpdkp
	hfrlDauoU3DNiJFf+HWVYvvtH6bcKSYrjAEHsJiBrNVx/yBQdMpg2Govqy9S2orV
	up4LFQHh6ZXkjGZMSoNWRk2DjVbWLrIVDXQ==
X-ME-Sender: <xms:glKBaGWW5ZyBJc-cBB95XUKIFXoEiz__Ejuc2hYt6Tz7wP7UQ7rzWg>
    <xme:glKBaOFZDvFxNx29qfSJJUnPLb1N0q8xynhSLrsVQPMgezt9dwYnE95P5iFlVwmTY
    -NDG9THaCz-yy_UZA>
X-ME-Received: <xmr:glKBaA2V6QYHA9GL7AazahISh6ZDpFQjBhIIS5HPsN9lVy3PKbWkvHEeLpkZ4hVD-OAR5sFLMAISRBKW-ouNmI5QauWYVQ5c_MZ4JDI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:glKBaIPhb7BtIX1q1rhEMXGypjukgWK_Rigjx03Dk1Hsylr4hNXuoQ>
    <xmx:glKBaH4Q_yZ-JY225WFtGLC6AkmPqPbCZ0zuHG-1dg6epxzKxbw9LA>
    <xmx:glKBaK2BzJGv4mGVJG1vclNhPKOtm5T3NDgltzehPyx_QEl1SgaaYw>
    <xmx:glKBaAzmgVleJImjviCDWHhO79teQI_ubEFAce0RMrl_AdCM8FkzSw>
    <xmx:glKBaGI6UCpryfpHyDVvjhOltbr_FaGDFnjPQViUAQN63_-swMBZAISv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 17:22:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/7] odb: track multi-pack-indices via their object
 sources
In-Reply-To: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
	(Patrick Steinhardt's message of "Tue, 15 Jul 2025 13:29:17 +0200")
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
	<20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
Date: Wed, 23 Jul 2025 14:22:08 -0700
Message-ID: <xmqqa54umwlb.fsf@gitster.g>
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
>   - Changed the base of this series. It is now built on top of
>     a30f80fde92 (The eighth batch, 2025-07-08) with "ps/object-store" at
>     841a03b4046 (odb: rename `read_object_with_reference()`, 2025-07-01)
>     and "tb/midx-avoid-cruft-packs" at 5ee86c273bf (repack: exclude
>     cruft pack(s) from the MIDX where possible, 2025-06-23) merged into
>     it.
>   - Re-explain the split between object databases and object sources
>     to help readers out a bit, given that this is a rather recent
>     change.
>   - Rename `struct odb_source::multi_pack_index` to `struct
>     odb_source::midx`.
>   - Fix some overly long lines when looping through the individual
>     sources.
>   - Drop the patch that guards re-loading MIDXs, as we already have the
>     guard via `packed_git_initialized`.
>   - Remove some while-at-it changes to make the diffs easier to read.
>   - Link to v1: https://lore.kernel.org/r/20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im

Shall we mark the topic for 'next' now?

We haven't seen any comments on this iteration.

Thanks.
