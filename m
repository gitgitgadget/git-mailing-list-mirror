Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10F70808
	for <git@vger.kernel.org>; Wed, 31 Dec 2025 05:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767157936; cv=none; b=EaLDIJ4d6TSfhDQhR9/cUdP8+V2fmw7TBxOFF6/T9rJlt0SVtN9YKDqSJtmZr/kxhuVovMT6X5I+lmFEy3GzSojUfhJFYlPjx9nwgzHECdPM0AOypSqAcPvCUu8KhHuT0jL4cWTZM0w5W1CkGAogDrzjyf4oq3zcX0KTjUBDx+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767157936; c=relaxed/simple;
	bh=YRcC8H66X32Ob/fGMFnW3JRsk6QVBme4XpLWXwZCN7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CT17enokt6WKUzmNcVoPrYGcNBufANyolBfgK3NI11FzWQ/hMyuN1Cu5BVNkURCJdQqLTzaf/jlSUGUUYFHYOj1XxmibTI6wRmDknOwF5NP81DB7eNmkgyhlJgoqWsXe7rF/+2yvLLwGJUp0rIiU5rr3etVX4UbT0o7OPEdNMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GEr9Y6gE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cDqaxp6x; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GEr9Y6gE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cDqaxp6x"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 489A1EC0080;
	Wed, 31 Dec 2025 00:12:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 31 Dec 2025 00:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767157930; x=1767244330; bh=fcSRJFayef
	roXIgvFD6QNh5SpwoflD7WuBCsN/CbPf0=; b=GEr9Y6gEi+oVqbMPg9U1bjEOtA
	9M7yLTDahpBSwbRc4G3v/t9SrY4ej40OHtjGpUSKML7XsjTGCHdiXLy/qT9QxHBe
	00fgDXwr7H9lAm4+cLNdV0+AwNzD+Iz6nML06O7H0Ou8mDtN8uVJlgilP++vIP4r
	gbifOVGOl9AzvcCqXMyDE1pW+ON8JjDgEpDppa1Nn3l7O+YRskAcRt82+oQd3LFE
	q2UMjCRUR4zNIfAaGeVQfkdO24sdxvJ9RP/9kV3HHg7ABrTmlvFRbdJq2h5ySFmO
	WFq6/N+BwCZQailIrbCVDHwtm1B1dNYASX1Z2sukXo9xyabFfnGdfEhLTgRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767157930; x=1767244330; bh=fcSRJFayefroXIgvFD6QNh5SpwoflD7WuBC
	sN/CbPf0=; b=cDqaxp6xUk+nuim6Vp6HlW1v7DSxdQO+tretOjRMNqcLJ8Ilxyq
	ltWeFqjY/8AJheevKLorls4WTf/B9Nmvbvc22hpcPJIGasY11g6cF7QqbF7/CP5e
	+NIolOC7bMPcK5c+4WfxZ/SiVGxEAwHQMlvCeTEle3GqLc9QjZvUo2ebK2Wu85LI
	DL2wgn6QeEe0SkytbanDfm2eEiDkmzzKR1+RiWZ+4YdNKa23tsXnGsE3wSzuLHb5
	CZXYNJVO7MNwxT7GBo1fYhMGV1+Uk05aN0x6G1alNCQFqJA7VvY+piZ0VQ9dv/z1
	MZF+HCNHthjbJgf+BB9swMKlJI8KhKaCVRA==
X-ME-Sender: <xms:qbBUaVlqynNYRyBNwoHZbFoxkU6NGgKoAXZOVVArpMG_tonVsy1ekQ>
    <xme:qbBUaXsk9HvNXJwqBVYsyHYxD53o4lgYrVyAGvN74dw0fVYV7FCi22anzVczNZohy
    F1k8E4pTOGp6nylwdefsa-WEybuzO3qdHdzE1c_05zSWqtMokswjw>
X-ME-Received: <xmr:qbBUaT-dMA4z7vaLGv9tzdHAH6GXLwSbSX4PZehvuArIGpvhICtx6Hf_8DodZdDLbJCkq4g6hpAR57nsyEW7i67bRr4nYl83Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrgh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhulhhmsehsohhurhgtvghphhhilh
    gvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qbBUaRO4rtUEKzZT00G-S8eILOXchtDcXdE1GIx81oadCXypnTj4OA>
    <xmx:qbBUaREvX1VwxG6H-Qrx8v5gOKOMQKw2k9qiiA9yAcqSRVLtbMO9Ww>
    <xmx:qbBUafSpeAPiZIafcOHkBOLb2x4vBXMs-4tsIn30r7cm3FbIGEW2mQ>
    <xmx:qbBUaevcOn47R63Ql4f5MIwLzNT1Tv5Ymf5Q0gvXcxCFcuyqYs7ABA>
    <xmx:qrBUaVifCcgmvsMf3EiW03-BShWgfjy-YPb_Yfc1QA8Nnf1URV1ix4qA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 00:12:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Julien Moutinho
 <julm@sourcephile.fr>
Subject: Re: [RFC PATCH] builtin/format-patch: print a warning for skipped
 merge commits?
In-Reply-To: <20251231034217.2498648-1-asmadeus@codewreck.org> (Dominique
	Martinet's message of "Wed, 31 Dec 2025 12:42:17 +0900")
References: <20251231034217.2498648-1-asmadeus@codewreck.org>
Date: Wed, 31 Dec 2025 14:12:07 +0900
Message-ID: <xmqqo6nfdyl4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dominique Martinet <asmadeus@codewreck.org> writes:

> This RFC patch illustrates how we could easily print a warning, but
> perhaps the warning would only make sense if no other commit has been
> formatted?

Yeah, when nothing is shown but the given range is not empty, it
would not be too annoying to give an advice message.

On the other hand, I do not think it is a good idea to say anything
extra when the user gave a range "trunk..mytopic" that has repeated
back-merges from trunk into mytopic, to format what s/he worked on
the mytopic branch.  They _expect_ these back-merges to be ignored,
and it would be purely an unwanted noise.

Thanks.
