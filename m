Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA51C5F09
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332467; cv=none; b=tVbdfvXV5FKkYqclD298nAdGSgorwmLPQbzTY9c3JAeYlqIAvvcjTYhPVqtz0ynxhn+SXaoiFcw/PdIM1JKwMpIH0rOIdocAZe4ZrvXm7lNTqQeioiZMbu5zj9+q1K7WL0nK7MFHnzcDoKVWFBSJgOjXFiSH75+WEsAz/3nKIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332467; c=relaxed/simple;
	bh=L6Eh2xR9rSoK6eyO9t+pmFBOc0cjh68FOPxR76XU1hA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIfBDUA+GlsF+ygl7MH28x5ZA8l48CU7kz1b1prKlZaMHo91ZcnDUFBT4XOON8TlNGKYOibuxdcUq/qou37LUv5FdCEbzH87yqgZ2i17z7rps1aZ9KaHbHM6ERolIGbtAOfAgWFPZeEcyuxbMf1qZj+JBPlPo8R9FXRcU8DLWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ks31Ewlg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I+OdVQsq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ks31Ewlg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I+OdVQsq"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D1BA7A01B8;
	Mon,  4 Aug 2025 14:34:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 04 Aug 2025 14:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754332464; x=1754418864; bh=a9Nhz/IvpY
	c0WBGnkarjjOVpDL4UqVlvJroC0GJmdzk=; b=Ks31EwlgcIjyNDMOBe2up2T9iw
	E+c9iILYjAo2ndlD4f8OQS50Mc624ccpwpVjJn01Ils2KhvDHNeYFkKLNXUID5Hb
	QxKro4MaCHhNtPyUBxGGNEpxGSeZzhDmpJeMK3fKOx8vkfLVyKZJ5v1D7Kx5/O9b
	/5BuNxWIdmfEBzI8T2Vqw/60dyvJiSJsYAi9upD68Z5dq/5IP4BFh9ca+XIzlB3R
	QvSrCNxf24pIWvUWq8Icpefep9NGqfOxYd4ikNPHjhF51xlmBs4UVh5x3Xn18Tpx
	hpqmYHj4fF/2pRvL8MOJ3wR1gL00faFxtUqtpaOMWRzmRXTtRLEGLO4/OYVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754332464; x=1754418864; bh=a9Nhz/IvpYc0WBGnkarjjOVpDL4UqVlvJro
	C0GJmdzk=; b=I+OdVQsqgzqZNKj2H7zt8dujrVMHp/R2b1m3+q71d7n7X15sdeh
	q/MU0pM2W4okkd/9nb86z8EZbHlTXz2h9g6NDkRCH2pUxpqbimvwu3JJ54p3BvkU
	3WUTp8W/YHhKYy4iMqs75yubU/AH0TVGafAzRirFrmNQ2hn/w5CE1qxYUVER0YRJ
	VIsH5tYaKvtRKXJGFUix71K9xLQhgG0H0msXZUksIYM7SvQ/StBwqj/mNxI9I8zy
	vJlC9WbgfYBlJCou0P+L1w0kozzWYiG++YumEaE1d2edaGloYoBxjG5i9BIlYBFS
	2Yxb3QEjj6secuVHUeUbl8mbpcuTxNRhiaA==
X-ME-Sender: <xms:L_2QaNII7IelySnCfVqs7UiKfgo96qRpF4rS37bYp7Eus1NJBgaQ_Q>
    <xme:L_2QaDt77potfNP_YuOdc9oAFz4OBGnkOBZS-79re26PcLvAen9XjGyGN_vHqz3IA
    iPA0TeoGT0n0ZZOxQ>
X-ME-Received: <xmr:L_2QaCSIxddfOSG8PtlZ3PuPkOQDpKuDhfLPer_uuJtc-sLROjDuVKOWcAKQHH0g7F9Cv4A9sWBAs9MjUy1ATbbLdMG1rBjPytrDYPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeftddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehoshifrg
    hlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:L_2QaBOF3L3NVTU9q3cCYcgv5bAHBG1Hnwbn7WaVhEftfOa82O_DSg>
    <xmx:L_2QaPYIjmw7q1ix32y6-TNvj5LQtNAUWVQhgc5LMuXU2AHnDXKwQg>
    <xmx:L_2QaDzoOfM2YJ8gN8V0STQjUZBRVeWN0NhwCXiTLZW59G0z2s7UTg>
    <xmx:L_2QaCKwytD6zl_6h4P5AiV1wXj4pE6qMKkdBfqzARIGFosjd8FLlg>
    <xmx:MP2QaJNwGaQaZkPHXwwsWFmd9NeuQOsSL9epgCbydSpPJMWkCSnCBE-g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 14:34:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
In-Reply-To: <aJCW7aYqJB20LDNg@pks.im> (Patrick Steinhardt's message of "Mon,
	4 Aug 2025 13:18:05 +0200")
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
	<20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
	<aJB5uKFdGybf-IbN@ugly> <aJCW7aYqJB20LDNg@pks.im>
Date: Mon, 04 Aug 2025 11:34:22 -0700
Message-ID: <xmqq5xf35429.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Aug 04, 2025 at 11:13:28AM +0200, Oswald Buddenhagen wrote:
>> On Mon, Aug 04, 2025 at 10:17:18AM +0200, Patrick Steinhardt wrote:
>> > When writing a new commit graph we have a couple of counters that
>> > provide statistics around what kind of bloom filters we have or have not
>> > written. These counters naturally count from zero and are only ever
>> > incremented, but they use a signed integer as type regardless.
>> > 
>> > Refactor those fields to be of type `size_t` instead.
>> > 
>> mind elaborating on that choice?
>
> We tend to use `size_t` when counting stuff.

And I would have to say that it is wrong and we need to wean
ourselves from such a superstition.  Unless you are measuring how
big a memory block you ask from the allocator, the platform natural
integer is often the right type to do the counting.

Each of your "stuff" may weigh N megabytes in core, and if you have
M of them, you may have to ask (N*2**20)*M bytes of memory from the
allocator.  Your (N*2**20)*M must fit size_t _and_ you must compute
it without overflowing or wrapping around.

None of the above mean you have to express N in size_t, though.
And more importantly, nobody gives you any extra guarantee that you
would compute the result correctly if you used size_t.  You can write
the right code with platform natural integer, and you have to take
the same care (e.g. by using st_mult()) to catch integer overflows
even if you used size_t.

> ... Regarding the data size I
> don't really think that matters much. It's not like we have hundreds of
> thousands of commit graphs in-memory at any point in time.

Aren't you saying that a platform natural integer is a much better
fit?

As to signedness, it sometimes is better for a struct member that is
used to record the number of "stuff" you have to be a signed integer
that is initialized to -1 to signal "we haven't counted so we do not
yet know how many there are".  So

    These counters naturally count from zero and are only ever
    incremented.

is not always a valid excuse to insist that such a variable must be
unsigned.

In short, not all but much of the recent "use size_t" topics are
misguided, and -Wsign-compare is usually a wrong thing to rely on.
