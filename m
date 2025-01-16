Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02622DF9C
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056120; cv=none; b=MnbW6FKY6nFfZKGdlmPH9+dqoBa21amPTYQyEwW9K+8Wl5v2VNg1pVeh0THZjHgBwd5nBmIzDAJEzQKAOqyDXgNCB0RionnIO55X41I+cXulZrTWZs5Xxx453zwLtFcimB3taIZ+iA9071btvySFC5n5XjIJ4TXRYZC5guE1zQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056120; c=relaxed/simple;
	bh=8lZANnBhNon4FkYxDUkv7hIqfD2Y18WwHiavxteeiiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYP/RgpYtHNeQwmdsobbsvcvCwX/YzyvVjAOUTkMlRCCyRg4/2dreXLbChOlj3JJYsBp2lc+vESgp8hpWlbcEdtscjzxVtMWARJKPaaDmL7MGwH/EDjSrCyxuEzjNJneRhvOBN3HNsDSRAvHqZFQTTGUApBBBwDpxsGBL7MiD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=65enXMrU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TRe5BViA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="65enXMrU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TRe5BViA"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D26C11401C6;
	Thu, 16 Jan 2025 14:35:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 14:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737056117; x=1737142517; bh=f5u13u90Fp
	aznsxlRu8b77bjm/9LrsbhJc5crj1Cij8=; b=65enXMrUqd49CCih9Q0jruK7dV
	H2vXihoW98/IdhY4WZbbGj0gQSn6FX/a1ufBf0AbsiFcJEJeXcibYYYp/1InXMvL
	NDDuBdc1kv5A/p4wzzCJRrUvFJ8lwQxqyGDOyDDmk2FMuf1jPedl3nXmfGFRe1ee
	1rXyWsxP3NyaYLhJWkQZPVcTNp9Ult2uwOSwPVY/CKnVbRC49pZBHL+WmP1vm7tO
	H1ybYmUDzkdacFq+VHLHWJfTXR5rWHH0FLLShLBLQ0pcTA7JQmuQlkCPJrizBnME
	zr0l+eoKNZKHzpCxdumDSSnkrqJJy/FKfFPrSu1trYMAtkXR87qRlk7D46Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737056117; x=1737142517; bh=f5u13u90FpaznsxlRu8b77bjm/9LrsbhJc5
	crj1Cij8=; b=TRe5BViAoivtH/g2QmdSYgIQzoEhoAmappk5HaqzCbn6DZXzZCK
	dZn2s3ssMozcsRuGNaQ0UW0FrEFHKAaDd4FN/T/llc4HNkujryqPyJpCtUxgDNqx
	J+qjrkNz6ak1cs4D9Gp7Ar4nYNuoPM9axQKT3Tfq0K3UDPB7Elkx110YTMXXhWfo
	kJNXvDXuBU2py7MnIxHoCrtTYhyU9EhEA33X8d3nk43pRgt5NeD+qJny1VN08HwD
	/g3TOGAGAzaBX9A9YueZ3YoQNAmZh4b1lLvXtK0o/xtolP4ve6wMSM3EWNVCLN89
	1i4mZ+6GqPgbbcNx8kqUkokvu79RDZk+Dew==
X-ME-Sender: <xms:dV-JZ9oFYQ-zbi24sWMTbkJr8IlS_PaozUAXSD8X6GuCyJKLGGqWDg>
    <xme:dV-JZ_p1f3D0EqE16WWTk_WUoqLhY9fmBXGKZVOaxiCLBQTyQITjvuePBGndqd5tP
    9ZOh6ab-qea_fwMmA>
X-ME-Received: <xmr:dV-JZ6MvHPBCJZV2m6Z6qwfcIn0R7f3tt40Ngo7quqv2nZE_sihRbeBw4iqzE3mR1ZhbKQRHyINttGLdJ-T2S1OmQPmMs1j9L_7N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvnhhulhhlod
    hkrghrthhhihhkrddukeekrdhgmhgrihhlrdgtohhmsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:dV-JZ44m9Bfb4NxyLEB-cEqeCqGbwDhUl-2yRC7REN1ZhgY0OBuQPg>
    <xmx:dV-JZ87Cw3gl3FoCe2IdT2424nD7aIv9ljjPABGOjrzScrpfYdCasQ>
    <xmx:dV-JZwiiLQeaQ3V73kzSOLbF_RyE1uREl7-vtAezPuc-uXH61prsOw>
    <xmx:dV-JZ-6-_s-lOqGR3VyWjZxpUqh57IYJfZZNH1uja-s-aTf17ZnaYg>
    <xmx:dV-JZ339w8d9JeRlGF5SdetsNeMBe2FIS3PTDThq7-NbNhpF_UYsE1vI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 14:35:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak via B4 Relay <devnull+karthik.188.gmail.com@kernel.org>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 4/5] pack-write: pass hash_algo to `write_rev_file()`
In-Reply-To: <20250116-kn-the-repo-cleanup-v1-4-a2f4c8e1c4c3@gmail.com>
	(Karthik Nayak via's message of "Thu, 16 Jan 2025 12:35:16 +0100")
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
	<20250116-kn-the-repo-cleanup-v1-4-a2f4c8e1c4c3@gmail.com>
Date: Thu, 16 Jan 2025 11:35:15 -0800
Message-ID: <xmqq34hir1qk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak via B4 Relay
<devnull+karthik.188.gmail.com@kernel.org> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The `write_rev_file()` function uses the global `the_hash_algo` variable
> to access the repository's hash function. To avoid global variable
> usage, let's pass the hash function from the layers above.

There are a few other functions that got an extra git_hash_algo
parameter in this patch.  The changes to them all look sensible,
but it would be nice to mention them here.
