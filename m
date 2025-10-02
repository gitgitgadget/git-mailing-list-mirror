Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AF15539A
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430841; cv=none; b=sBD9noHGcRvfJcDeb3Ws97N0/A9FAglFsr7W9rhllLFOX/Nt5Q9AtfomckbVCfjzgc23kvGAZtllb6Uh94/7K9f0DXmHNeeJy5k5Zq3rDvq3HAz8fZQRBRUi/lT0L6YbbDFHMPQLJ63TRiJosXqlySOcf0TBULqef941UroQk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430841; c=relaxed/simple;
	bh=vy/24/Wb9FPtYoPw8apqXoP1rHPdybNapyjlv6oDktU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bpqIJ9hpKvIpVD43vH8FdkM/f6NYRARWwjB2HMwPbskLCK8YOFkzd3oZJSLa6WUYLn5abyGvUL06s5FQkY7rZ/xKlb9mTsKTRbSSQOws0GwNZcaVkH7FkyuN1baJsDC36sctiliNX1gQ7P3F3g+a3OwOOkK/H+zDKKRoUCzO4D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HUNv+6Qw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rj7bYxKL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HUNv+6Qw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rj7bYxKL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 74F2D1D0013A;
	Thu,  2 Oct 2025 14:47:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 02 Oct 2025 14:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759430836; x=1759517236; bh=neZLTNIuxU
	MlpeBvMADwVjfEfp+4iyd1J1wifoqTINk=; b=HUNv+6QwBSRqnsgzEFMI2d3OIu
	qxd26x8SMtqI4S5cON5aeAiIP9lufqp8IJiKfXAxWrj+kc8BHt748wMA02n/D7mN
	ppv6IgocOPC6aV1p8C7LxwhfhTD+lp3PFXoSqLBafv0mZtf+IsXB04iHWOkzh0GZ
	y+fhYZ5YcdrWQ+dtZbKQDF2VGtMO6yudGpcGLBBDZZIrXh4oYqJHg9rsaritTRIm
	Z4uJf0aoKxM30kiqfvNzAaptCA7HTFGku0vvoLH1BX33pxf8PGDvsayFGYu+tPAx
	LdFBcLhvJptT8IKwZ2S3nFWUaXUd7ElPPnFkxDNLYTgiHqP3m2kK9pIFDO/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759430836; x=1759517236; bh=neZLTNIuxUMlpeBvMADwVjfEfp+4iyd1J1w
	ifoqTINk=; b=Rj7bYxKLU676OlYjdkPj8zKpd6onpeGQT5XJHO4qvrK3veiRkI4
	wzkLtl8B3A8Ekcgv4Y74pT2qxp1N7xcP+POc8BGZ2afRp++RLvUkjqGvTNdMDBVG
	oeoA1ARH8K/uVEnUPQxPLlytGWj6/Iw9liJIzyny5OSCo/byoJAWgCDmwW1gw6Tm
	XFMBFAl/3mXh0Uz2qfCKxn7upEoSWloIxqQLvorqJ8vJvdrmq0krU7+cRTA/Q5BE
	GMvh/IcdeeKfNF7CFL9aIE8rzB2OQKQDFnl37YYlMKRS6aF5ywsyMAuuwVCcy0KW
	uVxwKUQFvw8utAPu4OQ95cCpxoM8kh9nl7g==
X-ME-Sender: <xms:s8jeaI4lrKylofcyNtSfZdS49dOjq75Bdjkbq51w2YXt4FEoriFvYA>
    <xme:s8jeaMdxpSQGCQk6mWXvvZOaaW26eXizO4jMTr2_1gvYA8gc8mTsp-idq9TDuJzwh
    3W7Ads8_KSzw9J1GWLE5Hjx_e__UQDlJlX45tAvzxFKWc28_skunw>
X-ME-Received: <xmr:s8jeaLEQPDvLebm8cwkWUuITE8Wnjr1zxHM_NZs0_WI__BWWdLK8q3MHv4BrTLpnTFofr2anfQKJ-lqIPZ6xhQXrj7ZO-9hPmygh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehmshhutghhrghnvghksehsuhhsvgdruggv
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepshhorhhg
    rghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhgrshhonhduudgthhhotggrsehprhhothhonhdr
    mhgvpdhrtghpthhtohepjhgtuhgsihgtsehjtghusghitgdrphhlpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tMjeaNTWSh5iunqL-CvrAjTGYoXfgbM5h3HwbSLzHZv75-W9HUZISQ>
    <xmx:tMjeaBYg0IcyA-EoLsC7wpHZgL3jKhDWk0068CPcyZHClYVMqKmdWw>
    <xmx:tMjeaI0jW4rLS_3gS8SYr92CFh0v5HqPnZYf9YdAnyNs7YIu0tZ6rQ>
    <xmx:tMjeaErNwZ_W0NGqiAc6W1mx4kEvFcDPGfLF8ZOHhY0HpRdy3zcIZQ>
    <xmx:tMjeaAYsR7Ai-7aoe2G3g2PQBQ-RhcIm2i0wTR9dhsNl2seKwmQtLm45>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 14:47:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Michal Suchanek" <msuchanek@suse.de>,  git@vger.kernel.org,  "Eric
 Sunshine" <sunshine@sunshineco.com>,  "Sergey Organov"
 <sorganov@gmail.com>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  "Jason
 Cho" <jason11choca@proton.me>,  "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH 2/2] doc: git-worktree: Add side by side branch checkout
 example
In-Reply-To: <dd4027d1-4148-4171-bf17-b5c33881a446@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 02 Oct 2025 19:51:20 +0200")
References: <xmqqseg1xwc1.fsf@gitster.g>
	<1d5b41562937d83be261d054989b04db6cb94a86.1759420102.git.msuchanek@suse.de>
	<dd4027d1-4148-4171-bf17-b5c33881a446@app.fastmail.com>
Date: Thu, 02 Oct 2025 11:47:14 -0700
Message-ID: <xmqq3481w37x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> This works for me.  But why not this?
>
>     git clone --bare <repo> some-repository
>     cd some-repository
>     git worktree add some-branch
>     git worktree add another-branch

Do you mean "some-repository/config" is the local configuration
file, next to it there are "some-branch" and "another-branch"
directories, and you have to have some way to tell that, among
direct subdirectories of "some-repository/", "some-branch/" is a
worktree while refs/ is not?

No thanks ;-).



