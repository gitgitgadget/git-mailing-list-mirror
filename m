Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C620634EC
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368682; cv=none; b=o5oubGimd6aAm4dZE+XjUs8b21ZefufJHbYxYmP4Nz+VjTabZiBmiIDxr5m7H5jrQLgtwwGh/HgdHcXr1w/kIKluRjh5qfjJreHvPDPKV0fcD89lDipE3CZ9GyPynT1IOGV2x3R+MAj77gd0j2uBEHYc5p8J4HPft3qkLZD6ycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368682; c=relaxed/simple;
	bh=4b+LcNdQazUyqIXFR8mHTd2rNS34jYos3Y6A4/RFAu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BKxdEIkySwNsI2N14v6d+78FXhSxIFCUOmgX1BrN2N80Int5uhcok6mn0orCk7piClfCmVg42jwbhlyor1l8Y1S88LYD6hScaSyQcbGAG7EUPu4MYTxNAmfQNWRy4RBqJ1+sLDUc/5S9bugpl2JPQl12jaa/PGOf0+35XWGZPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pKOyAwDw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fxxUBZc6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pKOyAwDw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fxxUBZc6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56750114009B;
	Fri,  7 Mar 2025 12:31:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 07 Mar 2025 12:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741368679; x=1741455079; bh=Md9+iTqQ5D
	wfVXzJ56DvxdaWQrX+krpzPyxN/vMy/r0=; b=pKOyAwDw1xC7iK/lJ6IJnP12pF
	sQJ0P5hmTTler2uVFTK0XZJdyXFflPYIeWInVK3+ZQui6nz9YmgOsLJKhddj7/75
	L423XCY/eVl6uXGzE5Eq9YtQy3V3UFAMMANyazamNULJ7zB/1OtPAkkP4iXZxb4x
	m7+NsNXKnJhD09xK+o9++wm3nD/ihGvrtlBaewKGSuf83b17rCb66CnK69IpduxU
	KFC8axlvnWN8rMk3HrmX/KI/0gMlLRFkw1GBunBEtx/4i6gF3CZyv25TwUhRAQvy
	TePvQdlUz+7jUIxyhxwDQeQOcnXAm/P/U1M7f9CbVFjMWHMUx0vVH8UsTIsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741368679; x=1741455079; bh=Md9+iTqQ5DwfVXzJ56DvxdaWQrX+krpzPyx
	N/vMy/r0=; b=fxxUBZc6LyGWHp5l5WbxcJyzp0AK80oSYeYF6BPOlLqBu+a1qXv
	zk4bV0HTaTIGPL9HL27pWWcacsVwreQ08z3vXgBjz9I5BdcfuZeZ1VfTfW0m6M4G
	EQdN3sHSItI/QHSzK508ckb67NYS8ZG+D1punrDheGKP3cvfrL2adzP6z/Z8eDTB
	2lo1wF6YoCCeKF585rp239/v0ntq7dffnZkWlcNUkek3ALW0vvdblt7PRUesBewv
	VZ//1YBYN007SZD/HlY8NxFJjFLsXp2IcCZlWHGK1HoM7fUraDG0CFjv+umSiKHB
	IdRG76wIFG7E5DKnYDBjGj2ivFRixibKk/A==
X-ME-Sender: <xms:Zy3LZ_RQqWvMGDIrg-l5WbhwmU-OsdVBXy9Fpz-P2AZbLOlQJXhYkw>
    <xme:Zy3LZwzMuHbcDzMAvGYAR54ve2IqYfiP7n3iFQvxprhUqsdcgns0Z2bkbo0f1C2xq
    hzL0XVZnHic5TYdTw>
X-ME-Received: <xmr:Zy3LZ00Bcg7avgsUi2SaK2eA4ObmXQRBgc434J_Tw4y7DHK6xiiYoX3uDEUc9wlKT-m-bjcXaL2eRhhHfiTnfgtwpwknCYEf7kko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhurhgrkhekkedtieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Zy3LZ_AnldEGbvgbaLESnBw8rMgT6644y1ZG5N-DGPLOwgblq6aRag>
    <xmx:Zy3LZ4hl52uCxD-nvaqF4i6n77RVIObnnrN8VVx8AcBq6PQ-WmFrzQ>
    <xmx:Zy3LZzoHBeE2VdDX3oRnb5NnDMzXFdePi3I0vPKX1D8Tuww6zt1GiA>
    <xmx:Zy3LZzjBt7u1jt_qWbyWr9Bk13AP2rmiaHHS9mdut2evJgKmNN_DBw>
    <xmx:Zy3LZ0hxXX4YUuus_2b9MWB4oX0iFvjHiAC1Z2Uszb5AahH35wIYq-9x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 12:31:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>,  SURA
 <surak8806@gmail.com>
Subject: Re: [PATCH v2 2/2] refs.c: stop matching non-directory prefixes in
 exclude patterns
In-Reply-To: <Z8q99U9u6HQvHXFT@pks.im> (Patrick Steinhardt's message of "Fri,
	7 Mar 2025 10:35:49 +0100")
References: <cover.1741223981.git.me@ttaylorr.com>
	<cover.1741275245.git.me@ttaylorr.com>
	<67c8c5f797833a9a35f4805059d7e759020f54bd.1741275245.git.me@ttaylorr.com>
	<xmqqjz92hxxi.fsf@gitster.g> <Z8q99U9u6HQvHXFT@pks.im>
Date: Fri, 07 Mar 2025 09:31:17 -0800
Message-ID: <xmqq7c50g32y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think you've swapped things around a bit by accident. The problem is
> that the patterns were being matched too loosely by the underlying
> backends, which had the consequence that the backends marked too many
> refs as excluded.

OK, I agree it is confusing.  As a selection mechanism for refs to
be shown or processed, exclusion should be "we omit it because we
clearly know this one should not be in the final result, but we may
pass questionable ones, relying on our caller to have the final
say".  As a selection mechanism for refs to be excluded, the logic
should be the other way around, so false positive and false negative
are going to be swapped.  We want the exclusion at the lower layer
to only say "this ref clearly matches with given exclusion pattern",
but we used to claim matches for refs that shouldn't match.

OK.  Thanks for straightening me out.

> What makes me feel a bit uneasy is that for the "files" backend the
> optimization depends on the packed state, which is quite awkward overall
> as our tests may not uncover issues only because we didn't pack refs. I
> don't really see a way to address this potential test gap generically
> though.

True.  An obvious optimization for "files" _might_ be to lazily walk
the directory hierarchy and skip recursive readdir when a directory
clearly matches the given exclusion pattern, but the result of such
an optimization (in other words, what would seep through the sieve)
to be filtered out at the upper layer would be different from what
the "packed-refs" backend does for its optimization, and they would
be different for reftable or any other future backends.

But I think that is the nature of lower-level optimization---each
backend takes advantage of intimately knowing how it organizes the
underlying data, and how they can omit without looking into a bulk
of the section of data deeply would be different.

Thanks.



