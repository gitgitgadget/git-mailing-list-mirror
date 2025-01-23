Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD31537CE
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657011; cv=none; b=OeRLo+mYy9Lm1l/rUn4xVM4l9uTb/uS0E8dRLCWBxJZlmWglzqp9v9MLfMJlJMZk4+s2A4rLNlD7v8sA5qB2rLn6EUVRmM4YVP0j4dm6CFit7V2TExJFT82gQ/HFjhdbqS+cNOeG60GGZM4Vu9rr9kUpmUGjbIgoAJbB2Ep1y9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657011; c=relaxed/simple;
	bh=CuF//oVdqwX3Z33C4zYRmPmtfAhG+Y8KyO0h1GDMr04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hPAYhbSJ4t5PoDQtYssCaZNnAoKd2Mp0Tr+I2JjU4USmrB5zE1bL8QPLl1y3Oo70fzxX8Ma0rfEDN5gOAa/pH9O2VScDtI0NeV9Dae873xq8ZmsnUU3Doz3bFwnCiFIvqPdhzTlEtGk5EByc+QpMAbF/8gheSr2HHPeFCsWifKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=so962i5A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n2Yki9vN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="so962i5A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n2Yki9vN"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FDB2114014E;
	Thu, 23 Jan 2025 13:30:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 23 Jan 2025 13:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737657008; x=1737743408; bh=9kF1wwyCZP
	xUPNjACeNgWprzqDbb2NP8eqvmMUat68I=; b=so962i5AoNuupakRUChQM+yMPD
	bCv9MQbOV3Ce3QUVrpK3gcODXmfzqdO5czBVcajz77UFhdqaUnQ1nBDGJ1BwWc95
	5/qlQn3YtZPOcn5nwOMhk0yKMTok4riocrJjoKXLUpnmqrlkb41IB83PpmNdw8tF
	DzF6YVtbVWBkoCPccWR6NyDfkcerHRboVaaxbOrwOuaCjHMw12V4nD/J/FY2hWqT
	nZzMk01NaDtqH1vzyUuD7C76njYQFpAXWsME3VnLLc9Q56IDpJllIQkc8mf1ZxW4
	5OfZvZ4gDJOa0MUTiBh4LKsAPwlEi4F+CyCiEvdSdTu0vLXaXKH6OTUf1gSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737657008; x=1737743408; bh=9kF1wwyCZPxUPNjACeNgWprzqDbb2NP8eqv
	mMUat68I=; b=n2Yki9vNXZGqxC1rxXpz1X82XX648aU4nvUynIHJyo10wUUvXxe
	641pwfBSg6BhPAhjNKfakw9KPgGv2lbw7JA5Eo4uQxF1SEhpKtmZ+R5rdA/LlbHG
	9V2CKolfvIBFBUOkyU+eG+x9nMgZ7xcYfEH5/ZY1Na9NPYtFUBRmP7ongLjkm0V6
	s+305t8EoLMKrQkGQLBrB7UQBekWyvgumIpewy3H92G9DEnsU4CmPjxyTOsHh7yc
	szYA0BwhAY96a2UFeDpIF2keFLsWQNTMKQoQlqwmY6axh6Gq1u31CLPxKng0y333
	64sv7mTlIwR/VobuONf19Vayg8FQtXkvrOQ==
X-ME-Sender: <xms:sIqSZwQ4kvHRRUO01qsn62UYC0PdunciuBaP-KCgbJbgCIb4fJnoiQ>
    <xme:sIqSZ9yNO53I2qI9DRRH5oWQ-5Y_2Svynp7QQoaeiuB7A_3l51A_V0pl9PQrztiU9
    XRIH0PJiR3h6NPTAQ>
X-ME-Received: <xmr:sIqSZ91m__lyugfoba3EuEt2OxKL5ACnQL68Lxsd7Nw_Y7WhNkNJY2lmqIJpIM0-fO8Jkux4xW1_lYtctUkpqEkLQYRP88-I_M8G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sIqSZ0DGyKbA5IuTrXlQPsEBToYjolVQbwmtAfcYzigCmdsqRKgU8g>
    <xmx:sIqSZ5it3eT94LJ9owaiRPfnof9pitSIhs629opf7lvGisVt3Swcyg>
    <xmx:sIqSZwoWYPWYvjo6Zos5BiCJhje22z1q3oDycyselOcBNksOfwjA7w>
    <xmx:sIqSZ8jviz1Kdv2keLIoLJ3DzRR__ImEgmpHLYjVJQeH1XWGyXQ84A>
    <xmx:sIqSZ0WmzQeCEIiBc5PwYy8Xf8lERKo7dDxXfUX8tkTLFvk7FTmJi5qB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 13:30:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
In-Reply-To: <cover.1737653640.git.me@ttaylorr.com> (Taylor Blau's message of
	"Thu, 23 Jan 2025 12:34:12 -0500")
References: <cover.1732130001.git.me@ttaylorr.com>
	<cover.1737653640.git.me@ttaylorr.com>
Date: Thu, 23 Jan 2025 10:30:06 -0800
Message-ID: <xmqqwmelqt75.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> (This series is based on 14650065b7 (RelNotes/2.48.0: fix typos etc.,
> 2025-01-07)).
>
> Here is a hopefully final version of my series to harden the unsafe hash
> algorithm changes added in v2.47.0. The only difference from last time
> is that hash_algo_by_ptr() now returns GIT_HASH_UNKNOWN for NULL and
> unsafe variants, which is a strict improvement from both v3 of this
> series and the status-quo on master.
>
> As usual, a (small) range-diff is included below for convenience, and
> the original cover letter is as follows:

Thanks.  I'll mark it for 'next', unless there are any further
comments.

