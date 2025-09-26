Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F7129A78
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902083; cv=none; b=JwQMo8v3R6OAZceoRajzGmu5Bf8zuWmUetSPliAoWyjRhulfu1tbPVm7x2KfgGTl7vUlNw6gVsQOSB02rI+Y71WSJ+SRWbIcNSw6TqZa4UUCKmJETzc/7KUGR5rk8hqULsv+O5axtcTKlFT9ZKgJCc5DsRK5rOmIvvx3NSaVB20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902083; c=relaxed/simple;
	bh=pEyQQPxDlf4FN/4SQ+10FjLQgTSui/KotE1gpmSrlV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aBUT2B0ji3qcrmYeBvNnxmTtKgfQ+ReOI6bdqL3i2MZV1OHYHi025UTtvMpZ//puUjqgwy6+Y05R1qZpdd/XpIEc+C+M4R1rZcX9Coqp2c7Ni1+3QlFOUuv4JQl89PTQoPlyNQ9DYsLiZDmTZd73nw4cvACOVXwIujhzoEJEidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P3foiLbU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTmz2fXg; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P3foiLbU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTmz2fXg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 641401D0011C;
	Fri, 26 Sep 2025 11:54:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 26 Sep 2025 11:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758902081;
	 x=1758988481; bh=pEyQQPxDlf4FN/4SQ+10FjLQgTSui/KotE1gpmSrlV8=; b=
	P3foiLbUYwk8ZAkUksbutz6SOaBzI0/UzuRJOxmejT5lSdvTdmoAfcBwQoutPFIQ
	ngaQsgb4mkoadEXnXh4nJTJDYcI1r8ExBiWU0kdIyb5deRHdt24oy3lmVWFuXXzm
	JCrkzen0trn98XdHjgRJe1ZBkmXj2wYk4oDHy+lzM9ysUh83qJpGvKWL5EjIMITK
	inKSqSnu7AOpStVr66gjTt1yfrHbowr7uBfL1NJDkF7rYa/0NcUejZ4HjBRRnvZP
	AT6yxTEKC8aIr6gN2g0ai/7pd8/iQ8oP/MqO8U3WNSVDw88hGIwYKg3ajfPMVdAZ
	34644fjT0Rb2vQg6TUW6pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758902081; x=
	1758988481; bh=pEyQQPxDlf4FN/4SQ+10FjLQgTSui/KotE1gpmSrlV8=; b=o
	Tmz2fXg2JhlWjOY9vqoZ3i276VQT70xiA2wyFPwEZTBHOXjC5BxNrP6cDA5oy6W8
	w1VhRqo5/eetLoaiFHux273sylsnRmH+6vi160XF9W8J9EFMKY9JdEWP0uBAY2Pg
	irRNPbm9vFIBf88XWNRCBYsMEHwvsEHyi1AC6OFGXsZH34daZO6jqR0uuxcwXL9X
	FruAWZZSyf9X9WJI3gnFW9PyLzLno5s9n3cFqGz2P72o+uYN+AhzGvixJK7Ay9Fx
	2We+daID9CL1RscaFBgED2iQQX/a9jvlmWOoqMP5jCb1CpMdolo74Paun07oRbXk
	tf28yMKW4dBTLOTGLXtWg==
X-ME-Sender: <xms:QbfWaCof171GjpLuU_6u8FKxMLORraJV30KRaNb6aWKwIv0b-BOQqA>
    <xme:QbfWaLMOOq-Jbl2OyyfQgw-msiWJjxTvoGWzKEd9D12AwuBxxUv-qo0LVbKFFtRAE
    HriV_U8zAf6fKGWOfMRFh3J44JZUeXg82pJqN8aPeXOFP0eOb7t>
X-ME-Received: <xmr:QbfWaDwiEWVAeVveLrn2mMKMvz4TaowttTBwAqay08CZa30QGIiTYptGU1TlD7-0-L3_x-iZySMlkcu4cQG1te53GSmRzeXuOauY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvlhhtughofihntdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QbfWaEuxnrGHVoVZS6RPswLcnRwTQ5vpFvXGuqPKnzTyVh9f6JyloA>
    <xmx:QbfWaM4slf0S4iD2Z18ZuB_DKqrynoDNpohbzF_dh5PzaiKLQRVHyg>
    <xmx:QbfWaDQ7mHiUHDCB_KqsAnmrF-I3vKleUvceBCDdJPjw6GCb3GvbAQ>
    <xmx:QbfWaLrTHuVADvMa7Ub6PkfD_Ar2JIcZbizCTd7DmCFj2rHPfZQ2nw>
    <xmx:QbfWaAbzjuuiPtJrpyLXiJxH5MPMYjZbUhK5vgrjTmS5vnu_NFn0fFzL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 11:54:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Neal Miller" <meltdown03@gmail.com>,  git@vger.kernel.org
Subject: Re: git whatchanged
In-Reply-To: <7e3a5da4-0ac2-40ae-a96e-0e9a88a68d7e@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 26 Sep 2025 09:13:00 +0200")
References: <19a81573bf1ef7c544106e8fa7dd3b2db304c4f7.camel@gmail.com>
	<7e3a5da4-0ac2-40ae-a96e-0e9a88a68d7e@app.fastmail.com>
Date: Fri, 26 Sep 2025 08:54:39 -0700
Message-ID: <xmqqbjmxcips.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Good morning
>
> On Fri, Sep 26, 2025, at 03:00, Neal Miller wrote:
>> --i-still-use-this
>
> You can replace it with `git log`:
>
> • Given: `git whatchanged <opts>`
> • Replace with: `git log <opts> --no-merges --raw`
>
> Additionally for the sake of readability, you might have more use for
> `--stat` or `--name-only` rather than `--raw` if you are only reading
> the output.

Additionally, "--no-merges" may not be of value that exceeds the
cost of typing that many characters.
