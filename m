Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9329826D
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245610; cv=none; b=bf7son+cdsvmRbKgQoSm5XJ10Wq4zXu3ldWZ26jrw1ry/I8SyuCbbGD4t/icFhEhKQ3Xb4FFuicX+lDW0yM8oRCvZAVa9XXoJNBWdhdh+Sq6wiscuV0dtkshzdi8Xc898gpu1G8td+E2VkScYXuAvWnT4xEW11ilLSZH0Vbw3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245610; c=relaxed/simple;
	bh=yvvw4xj3qJLeQZeCItA6VtU3FmI82l70DW1FjMrVgn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UE2WY/pxQQ0BfrO7BoQLvjhiUhUTGYIFyOpmUAS3ggFYgqXde4YIBL8xvJ6a7BdPYWTQpOFlxhNIMkg1KWdrcjnUgwSFsOwvbcIOXiMVqS0lasHMs8BSSKoyYBQNa4EXkxH4YV0spAeIZBlZIszQSQ3f+5lswaTK1h8fg2Wne4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OSfh8ai9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZT+xsGmN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OSfh8ai9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZT+xsGmN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F16B1138043E;
	Wed, 18 Jun 2025 07:20:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 18 Jun 2025 07:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750245606; x=1750332006; bh=ohfB8xpQ/Z
	rSB8l7wBh9VWUSIA1aSTovyZ3RdX3AXVc=; b=OSfh8ai9JIRqIZWwPDpVu4B6IQ
	ALGa9DJ4iadiQI7NxqPRcK/McNft2//HhsEbTRROtE/dv4FhxQnF+T6KJ+eJvR2c
	OHchPi427ZdrRN7DULYTxzSSdmksfYQHO3MM3o0a0Vkm1bfLJKMk+g3pAr7/iw3f
	rGdzSK3Fxg4591/SWZC4Uc+ZhJsd8iibMz9DKiO2MZbNYlvejd2H/TDAC3maX75R
	LkrClaSVNiD3Z4yMFHVRq2pqWTboySELzUYQk+2o8D20pboby3zz/5CbeAks6rn8
	xPZsmfMM7Yd+zHtxnrKyZFWWOAk7e7gvUhGUud/Ir6mcPYjj4IZ+x2tXWumA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750245606; x=1750332006; bh=ohfB8xpQ/ZrSB8l7wBh9VWUSIA1aSTovyZ3
	RdX3AXVc=; b=ZT+xsGmNiSfcgeIo9vZjdymeoTP2wiAxc13cLEe22/r0JyXr8K7
	olnEOPgJVV1QesAr7j+9PLG4LBorjxaHtY5eMuIHr3i5FivQKA5fudouAK7RnO2D
	hTvnG+MKHYXb3jAD69GMFsMMqcSy9istch+63oVJWZwUjccAlSidMU/DvGotDqrG
	iW1YFa3J1jqG0rY7zvkzrw+cfOWFaEDakG9Et1ocTrrZnBDNpqczF/UnzBSGIWgI
	DXgmel/ptr6uexmaB+9Zxxn53CJPqY8BN/hNLef2meXOGkAeMzUM1SN5+t2ar5HR
	1PlRLFIqwPgeKQisdJeE+SxPBFfEWk/AUAg==
X-ME-Sender: <xms:5qBSaHTtZRzKl3fY8J6O0gnlWabq4mN_kUfPG5nNVWTk3M803hnitg>
    <xme:5qBSaIxuonHdwgRme7mvBhXw4z4jMHGHvClIfipgj3lWuiwe8tiG5Ni_8a6CFFPXb
    _jO3dRZIHHlIc76Sw>
X-ME-Received: <xmr:5qBSaM0x65nnRQwb9qklHqvkr43k_Xp3QaH67XIq3t7PSNKtV6ZF0EO3X4KBlSE2nvBDgENvw-gGUf894dBriSMnn3whp63ldj0K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrvgdrkh
    gvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:5qBSaHDOwcuxWLrMmiyzUp_F6B5-7zQNh_8JF41JMoyKI82e4UM5Jg>
    <xmx:5qBSaAhKgYz14CaZ1jBtRbNwZmz68EtL2qhccvFl5S-ZnX5bu0SUlg>
    <xmx:5qBSaLpR1quhHhZyMNaS8bYulHppvOjXK6lNUUUvBEluNWA6eUMdpg>
    <xmx:5qBSaLh5w83R45W1-iGU_TGzmgzixipfHHf6OGnWmvqOy2xnwD5csw>
    <xmx:5qBSaLHN7CutHKdmxQ1cE3JwMFu1Xjcz_jqNZu-MLigEqrkLsZqnDVWG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 07:20:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>,  Lidong
 Yan <yldhome2d2@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/6] remote: fix tear down of struct branch and
 struct remote
In-Reply-To: <xmqqldppu98s.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	17 Jun 2025 18:30:27 -0700")
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
	<20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com>
	<xmqqcyb2uhth.fsf@gitster.g>
	<d72fb411-2e05-441e-aee4-d8a26d652fea@intel.com>
	<xmqqldppu98s.fsf@gitster.g>
Date: Wed, 18 Jun 2025 04:20:04 -0700
Message-ID: <xmqq1prhguu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> We initialize branch->merge with set_merge() which is called by
>> branch_get() and which is the only way for callers external to remote.c
>> of getting a branch structure.
>>
>> The issue is that merge_nr can be non-zero because if no caller has done
>> a branch_get() on the given branch, we still have merge_nr is non-zero
>> and merge is NULL.
>
> Meaning merge_nr and merge are both uninitialized and unlikely to be
> 0 and NULL?  What values do they have, and if they are left
> uninitialized, shouldn't we be initializing them to predictable
> values?

Ah, no, I was just being stupid.

We read configuration files and accumulate things in .merge_name[]
while incrementing .merge_nr but until set_merge() is called, .merge
is NULL.  We need to clear .merge[] only when it is not NULL, of
course.  And for that, it may be more readable if we had two loops.

Thanks.



