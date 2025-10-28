Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939EC72625
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681619; cv=none; b=gbFZ4dZys4qiqy7vhBXrE0ci5GsJoQXJB73k474wIMcC19OybOyJFpmLI68tyHFtqP1A8qHdEgqxiWkBXtt4TBxbPX7soDWFKQ2Zq0NSUkcvl83Ddaxb3HKEa7Llhagvegn7BFr1gGO5oBinLBQHm9bH+hw5FadzqWdSlrwthk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681619; c=relaxed/simple;
	bh=XbDrGOKBhDfDuGc7VbrwYDzQ7aQ8FfZyTtYTUpbBbVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z49jg8KNvn3jOojsXC6nuX4GlN6fT3Cuf5YLiW73bv5z8Xn9R8Qmlmmek2gJIQ8/vgHfczir8cOwV7X6fMlT2Z1xfczGn3eIDJX/6zMPiopwcWjOv083yXPIzAmeMnYS1D5ItgUAMmmKgQPI1BRXLEVgjmOa7J72JUBcd5KzpuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n8O+jUkZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t229XPXQ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n8O+jUkZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t229XPXQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 92FC21D000FD;
	Tue, 28 Oct 2025 16:00:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 16:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761681616; x=1761768016; bh=Rx98tHPmqj
	LXmtMn8lA+TK0Y8x/b5jp7i9FWBa0qh9w=; b=n8O+jUkZNkdpagQM8vUGeqYmq8
	Qx3aq+9aWQ8QUiXM3aqqf/HwmurHwl/U4OFzAx+XQON+byBlZCJaR0/RoEybud/v
	7LI+YNj7yEKb1byMFH50dTiAcQK376ByFPe8fdxBeSpYel5EOPTd/ULag2P/M4qr
	QcRZSEaRr8umaMDVA9N7hxkjOlquA9+be881jYjGnc9SF+AKESZolztV9Eb+k/ie
	SUlsQFTPt8+v/il66DBDiHLQwu3QqwDGZcu0rZZqgPoGFGVueuo68xlQtL3SHn7S
	vkM9jFpj3AYXA9sMC1UDcP6Z+ETwZYtE9/KAnML9ggtNCQ32YT+SYnRmUvsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761681616; x=1761768016; bh=Rx98tHPmqjLXmtMn8lA+TK0Y8x/b5jp7i9F
	WBa0qh9w=; b=t229XPXQtE53GRhY0MViP5rCeZb7TUMevkypclJrjZx7XAsvfL7
	pRetjyayXoWV3ti8qWInbLrGY4spj9hxJ5tnCzlGBHBhV97La+iR4rxTDVv2913N
	7TTf4hLcBUK0yUNGhxR3x+xDnXR+MAHs74/CnU+JENBRzDtZf0Hj7lPPmhWfNFJi
	xnCr7MllC5IsD23JEJRAjjzis0yNugDJnfcU56newXdAWZiYz/h7bYOLv194Giq0
	3EJ3Y4PWKW42F8uU0hhne7oowN85fXB7tJ3SssjXFXwl1M6pVokKUXVWwM4MD7HA
	NLmBzq+275M2x0POc0JHdjYBVhCa7Dk0rcg==
X-ME-Sender: <xms:0CABaXSBORaDps9Ee_t049x58kheWrMcWdWkSqCmKvqSqb2DxxD2Fw>
    <xme:0CABafo85yqXK-6XY6un5T7lus1MpOQonTmL77VxQ-VeXcY3jPCESbsV0Ic8iIQ4i
    zGD_S75gOIqOIcHYwReZSbQSqnckV8PZJy6PZFO43YuLG3dQjrQuw>
X-ME-Received: <xmr:0CABaVIlyKqFT8TE0Jq_akkNzRi0Iq0fETmJW5z0njQ2hqA_VMu_YhkWqk7oNfNDmmV0YgnMiAGGmfy1RrCN1zjfr7G53B-sf2Yu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedujeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:0CABaSq6-JG0LbfLHZk96at-pGu9Pq08tsor-H5g5A5eJOUdNY29Gw>
    <xmx:0CABady89t3n8sntaP3uI9kn5ANxE5e_XXAHnBf8il3xUHhScZhFqQ>
    <xmx:0CABaWNriBaihJ39PaufiOxGALyxnYI4axNMz8EYh8IV_eKb7LX8Eg>
    <xmx:0CABaS7zDVg7-51SU8JhGsNkcsz0suekXpeHH7k16wbnf6Adz-Azrg>
    <xmx:0CABae70qj6RXtJzpIJU9eLQEiPRvZnkQp4i8pe_fpM6bMsUVnvgeZdj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 16:00:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 05/14] rust: add a hash algorithm abstraction
In-Reply-To: <20251027004404.2152927-6-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 27 Oct 2025 00:43:55 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-6-sandals@crustytoothpaste.net>
Date: Tue, 28 Oct 2025 13:00:14 -0700
Message-ID: <xmqq3472dcfl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +#[allow(dead_code)]
> +impl ObjectID {
> +    pub fn as_slice(&self) -> &[u8] {
> +        match HashAlgorithm::from_u32(self.algo) {
> +            Some(algo) => &self.hash[0..algo.raw_len()],
> +            None => &self.hash,
> +        }
> +    }
> +
> +    pub fn as_mut_slice(&mut self) -> &mut [u8] {
> +        match HashAlgorithm::from_u32(self.algo) {
> +            Some(algo) => &mut self.hash[0..algo.raw_len()],
> +            None => &mut self.hash,
> +        }
> +    }
> +}

These cases for "None" surprised me a bit; I would have expected us
to error out when given an algorithm we do not recognise.

> +    /// Return a hash algorithm based on the internal integer ID used by Git.
> +    ///
> +    /// Returns `None` if the algorithm doesn't indicate a valid algorithm.
> +    pub const fn from_u32(algo: u32) -> Option<HashAlgorithm> {
> +        match algo {
> +            1 => Some(HashAlgorithm::SHA1),
> +            2 => Some(HashAlgorithm::SHA256),
> +            _ => None,
> +        }
> +    }
> +
> +    /// Return a hash algorithm based on the internal integer ID used by Git.
> +    ///
> +    /// Returns `None` if the algorithm doesn't indicate a valid algorithm.
> +    pub const fn from_format_id(algo: u32) -> Option<HashAlgorithm> {
> +        match algo {
> +            0x73686131 => Some(HashAlgorithm::SHA1),
> +            0x73323536 => Some(HashAlgorithm::SHA256),
> +            _ => None,
> +        }
> +    }

> +    /// The number of bytes which is processed by one iteration of this algorithm's compression
> +    /// function.
> +    pub const fn block_size(self) -> usize {
> +        match self {
> +            HashAlgorithm::SHA1 => 64,
> +            HashAlgorithm::SHA256 => 64,
> +        }
> +    }

What we see in this patch seems to be a fairly complete rewrite of
what we have in <hash.h>.  I totally forgot that we had this "block
size" there, which is only used in receive-pack.c when we compute
the push certificate.
