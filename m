Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFB272E6D
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766950670; cv=none; b=Dq0zrgDDhtQagIf3StLZUHNX7I9ocMXYf2QIet0a/zR+TC0MjEudySXp1SRU4+x06ZigO7k0yh0SaCgYjtncLcebScbCHu22Y7ek4r5HVY6Jz/+uKxB1yO/FjtLJudpOh5PWtot6bmESl8EnyMHluUXlteXXRU61WQMF2FHLpnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766950670; c=relaxed/simple;
	bh=AIFyBtCx1dUPI7JkMYOlXrJCoUNb7KLO9wtqBolqOv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hlVHtPh8AxRC0i4478KdEdRbfWjXvpmpBLdEI6v0hnbc7cK2Km/YsSbzqEFWtCm5qGx3Ge8YXriu0jDAhmT9haidiTi6WmLJoWE8aU134Gi7jjXwukB151UWqyDj2/U63qQvQmQZh0mAhFrJciP8y9qOfeII13KTyGnunU/C+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fpgeCfm9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XXBG+zGE; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fpgeCfm9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XXBG+zGE"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 78B101D00326;
	Sun, 28 Dec 2025 14:37:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sun, 28 Dec 2025 14:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766950667; x=1767037067; bh=AIFyBtCx1d
	UPI7JkMYOlXrJCoUNb7KLO9wtqBolqOv0=; b=fpgeCfm94Nhv9hu8I+01GoUQ/6
	Tyg7K1QnrYTDf8n5nhhMVov9yNT5Hn+eWZ4RRGJ+AzZub/hIj8zfoDQF440jnb1n
	DbBeHhEIADCJ3S96/0PFFesuoZQwmpbJcjOos3KLQRPdypWSjNjuwrsoXcqmTv36
	lXz25dxCxDHEjKVwTywIT62MV7aGe59UTs2ag2iSwmXC8II8Kdk4ZoqyxfcFeJ09
	hbGd4Trlh/ql+UyxJMOl8qMj+5JrpSXpZAMPQIpR5NZF6Arg1sJmAgC7WclhZArk
	fKSM9KgWHllRx+srbDAgkEqLVE5Joe1NeRjEIL+V4hFTCAc2ADLMvFoR/LSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1766950667; x=1767037067; bh=AIFyBtCx1dUPI7JkMYOlXrJCoUNb7KLO9wt
	qBolqOv0=; b=XXBG+zGEEU0R1mpg6HPt0DTJkmLQdWr2KOUp33/PH6OdFEay8GE
	II/1NnzAX/XpndJwtso23VsBTDT2bi137baJbeO2RnJRseJvj3Kuh8Gf9/8/QEZI
	70aqvcmDkKK0/P9m1hhnHzEosp1DtTBE2U1f8HwBSSKnhPd4Om7YWQigvp0DrOu2
	taxvT/WHml2zj2qIQw0Lv2SE+X1HMU+ag06WdN0SWvlcRt6NEEbWIRwoGWFfWqGx
	JEznNw1pm87Dw4oxbQ5lUJ0IqNT91n+OYgMsiXP+dXVa9MwF5Zm08Uf2fIdLYBtx
	Is7ow7DMF1Q1cuYrD2qF+jidC8x9ayq0xZA==
X-ME-Sender: <xms:C4dRaQzy1ZumoUm59npnXVcMzRYDNI-yqqP2f4i2kh0qMNlnISA3yg>
    <xme:C4dRaWjbbBvO331yRzUJEspT37dk3xMcx5XXMvp6s3glqDQQEB7TCqkunQ8T0wVrG
    _mTdIp0RBK0As_Ej3pEY8BZJqrkZPwhHYC1pBSUlp9QxvY9U9J2tg>
X-ME-Received: <xmr:C4dRaUm3nNlGhBQu_k6_sVC1tv-M0tnnLdPmyojO7ZswQGYHlLR1wykRpYCfypzhPybbQZ7FUEV1ycDVQpLdfMaE8hJqnxE2yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejheduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephigthh
    hinhdrmhgrtghvihhmsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthho
    rhgvkhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthi
    htohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:C4dRaUgOYUj3wueP11fepyrEg-mt3fDRZen128cw9YTz7znl7okqLw>
    <xmx:C4dRaQ2ZPObSfC9mOBPfdg4JnKXXMVe3wPfOOkERJJEvIWoa_DV97g>
    <xmx:C4dRaVI4mCllYiUT5Pc9FZ8ewZ8nIkt3noWysbuhAxjNt_jjedsvog>
    <xmx:C4dRaYwC3PMDveTINqxJ2pTYk6L9A46Ro9WecLnz_mrsf6kw2nsHTQ>
    <xmx:C4dRaQOxmqX8IMakQ4kK0LDrpIGIAVESUVl4di7jctKG8B2mbY6jsbq5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 14:37:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: gitgitgadget@gmail.com,  git@vger.kernel.org,  ychin.macvim@gmail.com,
  chris.torek@gmail.com,  sandals@crustytoothpaste.net
Subject: Re: Code review?
In-Reply-To: <20251228091607.14896-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Sun, 28 Dec 2025 10:16:07 +0100")
References: <pull.2138.v8.git.git.1766666006561.gitgitgadget@gmail.com>
	<20251228091607.14896-1-haraldnordgren@gmail.com>
Date: Mon, 29 Dec 2025 04:37:45 +0900
Message-ID: <xmqqbjjijt2u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Could I get some code review on this? Maybe it's ready to be merged?

At least not from me at the code level, not yet for now.

I still do not quite get why you need a new configuration variable,
so the problem I had were still at the design level.

A happy new year.
