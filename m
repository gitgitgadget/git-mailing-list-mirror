Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F230C2673B0
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332470; cv=none; b=aowqZZCnBKm2nel1lLt4+XiObnpcvj1V58eHrK/axckS898kENQeCHOt+uj89zHRCHYlGJ2qSSpvu8oDDOS5V+BfqJLXOMPQsHif8pPUZ6pau5ZNSqhBRQnlm9QKBxZKJ9ZtvWO+6UsiZmIBx7TieZPpabtHKJ9Xn87mgzKKjUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332470; c=relaxed/simple;
	bh=rYykukezeFJOSrZ1mwIEp6S1Mf54ZHLm9O3/JhFwlY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NQcsioqijC17m8wnO4LlZ3/Rld4Z4+xdGh5ENnheQUjJnZ5HlKNw/G0CgqLFLpz04oS7+9X+hnWIRykZxAEbeFQbF47YppI87Z6nRYAMEesFbQggretCnyN8h6Am0VKJMbcN9+iWUTufqG8qXsciQ5mhLV/YoLXVzfKsB7er/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l8ZB5cef; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NA+5LIoj; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l8ZB5cef";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NA+5LIoj"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A699E7A01D8;
	Mon,  4 Aug 2025 14:34:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 04 Aug 2025 14:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754332466; x=1754418866; bh=lkmmXimUIL
	1y/l0E3863bMng77Pu1hoOIGXaBk68wBU=; b=l8ZB5cefxFe47R2jnmEGowv3IG
	P3tD9oniMQmO4ImYsDRDBGMpajqWxUPO5QL6UT/Oz+mQI3Y6xhcBbGM1oLxlCYP1
	64a06wd4S5TAuMRLbjq0KO+KoKYnGoamiTZ1i0XVfx0mZwrxwFuuBDTO+pQQfC+S
	1MOtqtLoBbD/TW/ycMyDwj4DHNyamMjMvhlxVZSj7PbnrZBltwBBDHoHHcP254Sl
	EspXhwg7wEKtpqiyY+rMl5Y4ugx7QXVWUK/AKM1Pf8QdFNs7ghppyUsFnzwNf0Gt
	27CDPY+Z+PnIulNt6LN1o5Mt0QsAigg1DLq2RB1Kz1fhNl8kvkKVXWexDInQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754332466; x=1754418866; bh=lkmmXimUIL1y/l0E3863bMng77Pu1hoOIGX
	aBk68wBU=; b=NA+5LIoj5zQsp7oevnMAL5a2NdNRSMnky6hYuLHepuJf4ifOyAR
	dWrkNm5JaAgq1BTCqmX8nprZu25i+jtfkHQUpsVAsKse+BLp+4tcwmVHB2nxxSs5
	/oqVuMta/2qgbzQ8MVbLO8BvX5TCit5NbPVry9SqkTMggn186lqGTxCu6EDGxJdk
	0+1/r/PsuaoQCjx1nvQytAkj1FVtBVQakxi9/8alA1eBkGUG0IJEPOQMIaJmDxIb
	P7FRUlmXnuM22j4Rbt+VeZlIZCL3mIZNbt7hGtvbtB8tPX8Pn8wJ7YodT4qgOAcy
	Il0FE15vZe+ule+w73mdlpYlQA7tp/EoaKQ==
X-ME-Sender: <xms:Mv2QaJi_pumAgdh_2EHO-54O-XLfYTreZkAL6U3bzEIZwijWl1XyOA>
    <xme:Mv2QaDNrwuxKu5jgJXv5AFGohY3lOgkLJGk9AwakRPYaakvQwyWibglrf0cJ9lDcW
    -H9DqgGlJTvOrfvXw>
X-ME-Received: <xmr:Mv2QaMf-hafM-7_Slgj_q4hImFYij2pfnh5-nXu9LhyxT5OQZuns4sanRMc977dQUVywA5ZPrSlTkfY_DfJZ3OEEcgb5j1XaJjucka4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeftdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopeho
    hihsthifrgesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhiphhmrghnkeeksehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:Mv2QaNyDhsbZklUjcMeH9qJmkfaze_3cHQSoQMDncKyfa_efp-dfXQ>
    <xmx:Mv2QaB1gCZuMQUNosprWUSvt2J0BUu5dEMGZx3BjrXG9SSgk-TJvqQ>
    <xmx:Mv2QaEd69HBV7rPBxzUbtEd-Zcf_frLoGNFUOH4zSh2JmluBPB0wjw>
    <xmx:Mv2QaGVrI0zca6ssBQvf9TSo--uwfY4NO7kzj2PAHq7auWo4pwhpUg>
    <xmx:Mv2QaB3-dGJVuatknsZPCIk5I0gH1IxRbtvW2_4e8qbPM7aE2a2PZ9Tr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 14:34:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com,
  karthik.188@gmail.com,  sunshine@sunshineco.com,
  phillip.wood123@gmail.com,  =?utf-8?Q?=C3=98ystein?= Walle
 <oystwa@gmail.com>,  Aaron
 Lipman <alipman88@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>,  Derrick Stolee <stolee@gmail.com>,  Victoria Dye
 <vdye@github.com>
Subject: Re: [GSoC][RFC PATCH v5 1/6] doc: factor out common option
In-Reply-To: <20250804092255.1092973-2-meetsoni3017@gmail.com> (Meet Soni's
	message of "Mon, 4 Aug 2025 14:52:50 +0530")
References: <20250731090040.1625303-1-meetsoni3017@gmail.com>
	<20250804092255.1092973-1-meetsoni3017@gmail.com>
	<20250804092255.1092973-2-meetsoni3017@gmail.com>
Date: Mon, 04 Aug 2025 11:34:24 -0700
Message-ID: <xmqq1ppr5427.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> In preparation for adding documentation for `git refs list`, factor out
> the common options from the `git-for-each-ref` man page into a
> shareable file `for-each-ref-options.adoc` and update
> `git-for-each-ref.adoc` to use an `include::` macro.
>
> This change is a pure refactoring and results in no change to the
> final rendered documentation for `for-each-ref`.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: shejialuo <shejialuo@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
>  Documentation/for-each-ref-options.adoc | 79 ++++++++++++++++++++++++
>  Documentation/git-for-each-ref.adoc     | 80 +------------------------
>  2 files changed, 80 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/for-each-ref-options.adoc

This contradicts with Karthik's "for-each-ref --start-after=<>"
topic that has been in 'next' and now in 'master'.  Mechanically
merging the result of applying these patches on top of 'master'
before the "--start-after" series into 'seen' would leave the
description of --start-after in git-for-each-refs.adoc; there isn't
any textual conflict, which makes it even worse.

Rebasing the series on top 2.51-rc0 may not be a bad idea.

Thanks.
