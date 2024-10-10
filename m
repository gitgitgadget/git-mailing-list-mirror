Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1618C03D
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591612; cv=none; b=W78xq9XugSaMXyR4pY78G+SVIeGFdLcTWqTLFD4cpujjl8m34gcP1sXguDEVh497EjLUYdsIthKBoAablZabYlwlDBpKnzQug9o17oqNDvlodjsDojjsZ5+GRgOieD3NUe63T0Qme2IcMJM44g4zb8C7aL2O5vRXHaweam7VrH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591612; c=relaxed/simple;
	bh=Xwqd8Uim/7oNLikZW3tV1RgrfFT2Iaq0SvvP3cHgQoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hEpJaq3VMOycy7b+tIjlL5Ia4hWwz3Hj0m+4j7Wfbn78Kg8aEDPqQ9VfPlkPe6dxyr1jNhUUxT+d1ehUiQ66aAtsXqqmLXe2bMztzXXJr2cjsBVDucYbb52XDc+N/9vdNHIrx5oh06UQ7PTM8YalZXMFE8CbmrQXHgxnk39xJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bi3alpEt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PffhurKz; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bi3alpEt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PffhurKz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A900B1140095;
	Thu, 10 Oct 2024 16:20:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 10 Oct 2024 16:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728591608; x=1728678008; bh=6ld/skaRRw
	utTJ8enihZCgqF9Y2BWRIFPG1Mc/mZRRU=; b=bi3alpEtFKDSenkWQrTc6uSD6B
	ltJZPiXCsCJlqbbUg5PEdRMzwZIf/2N7hq1IZzJ1wYHNL01bnZesneC1pFFikJii
	t7IO7L0u4qEiKTkl0LyYnFlDFsxO+ikqQ4CkrD8QHHIUJCwSl9OKscsmxeJOlcZt
	L30CTU2brG4+jf+7KMJio53deAvvYIGVtNfj21tMYfvoyLMaVE+jj5AlkfSYdQI5
	kJWQVof7B1e4cBmDnwd3aw6atBengTLSM56Eu5PhOOCybGJhyBkkL6C9hsPpJPIR
	zGbAgU+b73MzFpE5I0GElLxRukFimj/dgwepZx7V0V1xy3VApC4bxtOVDwJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728591608; x=1728678008; bh=6ld/skaRRwutTJ8enihZCgqF9Y2B
	WRIFPG1Mc/mZRRU=; b=PffhurKzmlk0DEhIhwNuVGcSYPuPH5pNH9wte1xAIsJ3
	JoTnG64Z6VakGPpCV8BeygNWatrh9u2Uu8bMUvNMjlxGa7DxxABE1tTKEop7d7r6
	STyvvE03urZFrE6F0nHrhdKeOie7I0k9cMZIWhiB8V0KZLoeyPZwNlmk5VKC/1HH
	rFWCZDErSRaZpAFuxhf8iSOyCfLb4dEUPP3bRi/edvHpICFJySwHTccQyLAq8ZbX
	TAIcWbHBC4Gxu8nX3PC1CuNfUgl6oespV2vW3I62AQRWEJi0+S7tSgGn0wyV+K7i
	FpFZJROGMzoDbUxVXTk6O7uLsujB2kZung5oIHkdDw==
X-ME-Sender: <xms:-DYIZ0UvQ9hIzXpxgga2q9xyFyrVYlbZ09Br6g1CLZwZgx821fKG9Q>
    <xme:-DYIZ4k6pSI1AyQ-D5JNDKjFtQGNE-i4WP1h0mIgn8nYGFNyMkLYMaJ4cRmqIApRX
    ZqTuz7eA7owKt1B5Q>
X-ME-Received: <xmr:-DYIZ4Zane78Esx5ZaC17iwhynm9BsCRB7-EciX6QhKdk1JOHq-U9Bp48O3yOnHdeVw_CrkVA6Gg0mTSo2eegqyCRMxCjNRUqLWmynQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefiedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-DYIZzVbv-SPPy7PyXt5Rw4QlLL68_6gXWtOnZz4aXW9i24gsT26Nw>
    <xmx:-DYIZ-k3i5itwgB4Dp5XszYgFBldV0KpYarxR-P68nlC8os54mSY-Q>
    <xmx:-DYIZ4fANCHLGkGSqWpxFkiDpXYtqWvLGGho1Ti7uXOTZdo0w4_4VQ>
    <xmx:-DYIZwHVgImm5XZs9ObNHBtwUpUP0wLKDw3jLDfkonogVWVhbaAz1g>
    <xmx:-DYIZ8bvHma4gPMTSsF5NXjS3CxQQqIynJjDGdyiTwykVH9UgkE-PwJl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 16:20:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
In-Reply-To: <ZwgJt19kWVRTQhld@nand.local> (Taylor Blau's message of "Thu, 10
	Oct 2024 13:07:03 -0400")
References: <cover.1728505840.git.me@ttaylorr.com>
	<xmqqzfnblxdj.fsf@gitster.g> <ZwgJt19kWVRTQhld@nand.local>
Date: Thu, 10 Oct 2024 13:20:06 -0700
Message-ID: <xmqq8quvk8w9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>> So when you pick the copy of Y out of another pack, what's so
>> different?  After emitting Y to the resulting pack stream (and
>> remembering where in the packstream you did so), when it is X's turn
>> to be emitted, shouldn't you be able to compute the distance in the
>> resulting packstream to represent X as an ofs-delta against Y, which
>> should already be happening when you had both X and Y in the same
>> original pack?
>
> Good question. The difference is that if you're reusing X and Y from
> same pack, you know that Y occurs some number of bytes *before* X in the
> resulting pack.
>
> But if Y comes from a different pack, it may get pushed further back in
> the MIDX pseudo-pack order. So in that case the assembled pack may list
> X before Y, in which case X cannot be an OFS_DELTA of Y, since offset
> deltas require that the base object appears first.

That is what we have always done even before we started bitmap based
optimization.  If we happen to write Y before X, we consider doing
ofs-delta for X, but otherwise we do ref-delta for X.  We do reorder
fairly late in the pipeline when we notice that X that we are about
to write out depends on Y that we haven't emitted to avoid this,
though.  All of that the bitmap-based optimization code path should
be able to imitate, I would think.

