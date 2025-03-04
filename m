Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC121294EC4
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104262; cv=none; b=oyAEA+4QAjp2++7oooidOhc5EySf6wSeG2HeesrQc4yWyOfZGLGQr7liy17Sa9CZgkJd8gQHsFGhUZPjGZe6BIAwkh6KedS4raNkWDHhrDQnG471AuzHl4muxxTtXPQoQrHxVZelGOaoyBzPPPKA5Gaqn4M9wjBPxpTgckYy6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104262; c=relaxed/simple;
	bh=atStW8c1nCuxhPez6nBV7kI5FpGaSfXWA2PftbO7n9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DaO/dOAH9BZuuzZnuQgObZpnnMkXUPwZ6IjUNw5PUsyKiLey9oSGM3LdUxb3ytpqH5qvEqBJ2Kqe4Q4Mrrkde139edqBuIwOEHPCKLoqvfRV/BKKHvId9RYjrwbUKbtTSndFg7IQylxS+va8f0+ZOcHq/1vKVuivfRG7h5nDPQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aDNImnSy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R0g6X0nc; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aDNImnSy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R0g6X0nc"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE3531140222;
	Tue,  4 Mar 2025 11:04:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 04 Mar 2025 11:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741104259; x=1741190659; bh=atStW8c1nC
	uxhPez6nBV7kI5FpGaSfXWA2PftbO7n9I=; b=aDNImnSymdNJgf382diJWPY1P3
	34nADzJNvWqW6wGDiliGlJ6HuvLklxIpxNogrF+trm4eR5ciD5VQBVs8/IZYghk4
	rIo5hlVvj/j8+IRtrOzxeZmDaPzB9xBCPv9mdumfCAEBzl0mLNs+qqU6X6QKhVh4
	QBbbmoSsAb1W6s/0hV/gY45ZlTHqBxutDLeVG2cWieVNkwCfCNqExc/S9pWYPbuh
	O5abFQz9V+GzjosOFMVYYqYOrznqik29PM+2p9s5UF/oyIRDYft3yzhXMntnVaeq
	JuwDltYOYFLNyJLqiHm2xXS6D3AEZhnKOBdxllsEVY49q2rHqZEMAx7HnfVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741104259; x=1741190659; bh=atStW8c1nCuxhPez6nBV7kI5FpGaSfXWA2P
	ftbO7n9I=; b=R0g6X0ncS/j6+dop7klmSwWZn+fmWczQFAiLGb07WBkoSjkoiv5
	kLV3UQWBockSMglckcbRKW06Trftu+6FLaoqv8b4XCAzGX0CGSbyKdZeZkknuKWj
	EtlzvkJ/sw/71q8By+bZdJ88ui1Q+L8NVMzTwVfa2wiMRhf7IlfPQOP8DlW0IAqC
	RhlmwMhZJCYUZ7/z9rXAFblYx3JgxZSvN5eWm3+UdRxWpcO1lqCUIpD78P+OPVXl
	n1gjUXJOlLFwqZiw5/UZPgt8j/wEHhhJaJ8U7nB+Kg5poAe4zKTbhcmL2LxDxeJS
	Rpw2hbEaXgdQwlm5ZaVvJVMz53hQqHdt9ug==
X-ME-Sender: <xms:gyTHZ9UQri6aWBxyPKBm-Qe7qpTA1qKEtIpFbEiLTFOwc2MerYz1Rg>
    <xme:gyTHZ9mkjsWKgrN8miOf2YTmUJwTHizQPq7ItwnopjDGQChJJ6mAhHv9-SOyD_s2Y
    gFg2xTvtjQcYw6pyQ>
X-ME-Received: <xmr:gyTHZ5Z-Q2NndBf6hz1lpnAt8_cNaL5LhA9pE1FHgqayzbuXW14oavUr4rbu0RnIuTcprmkDK1NAu2ia5Kvt0b8h24Dqak8RhDNP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gyTHZwUWo_IzcfUTSr-WRaEt-3Qj0vGLBMkpJdcMPqDSzMJuiYjmRg>
    <xmx:gyTHZ3miGLQKmVWG-5JaQ8mPEQ8-N7WkPTd2We77NF2YCGBYRrUfJA>
    <xmx:gyTHZ9d_6AZIX-PO3SxfT74ymzIpKtpRSkjVoeEAi5SJpytiBR35FQ>
    <xmx:gyTHZxEqq5Kx7ChuaRDiccIlFY3GKFuqNx32CnIZg1Q8px-TjJePMQ>
    <xmx:gyTHZ1ZVRWKK_hQcbGdB35PYfR3bMA9JJm9spLK2pzlqknrBX6cFvZsQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 11:04:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Phillip Wood via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] docs: fix repository-layout when building with breaking
 changes
In-Reply-To: <2583368f-c7ad-4088-b78d-f6d972c4ee47@gmail.com> (Phillip Wood's
	message of "Tue, 4 Mar 2025 10:23:25 +0000")
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
	<xmqqbjuivuzm.fsf@gitster.g> <Z8afGexTdlqDnPV8@pks.im>
	<2583368f-c7ad-4088-b78d-f6d972c4ee47@gmail.com>
Date: Tue, 04 Mar 2025 08:04:17 -0800
Message-ID: <xmqqr03csry6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I remember not quite being happy with the double-negation myself. I
>> don't mind renaming the prerequisite we have in our test suite for
>> consistency, as well, if you want to do that.
>
> Yes, I can do that when I re-roll the patches at
> https://lore.kernel.org/git/pull.1863.git.1740149837.gitgitgadget@gmail.com/
> to use WITH_BREAKING_CHANGES

Thanks, both.
