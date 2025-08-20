Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29EC334382
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709206; cv=none; b=lj+fMO5Yxep0nM1vrr5Os3hVk08Huf5bLZCsvKqS89L01i32JI33DNdpcxWujiu/W6p/icwQHUFYaX7hYamPyENUFdQDY7s+aS64QA0kWe9FWCOl99ScocLIkIbWvZp/xuRV6n6dwsx/zyFMZY6nssyDiOU+h3tWDi6KU3/qvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709206; c=relaxed/simple;
	bh=76l2pU5VbTG5we20uquCqm9llyBqC7rNbEzxJ/tcbFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZcQB6RjdQlGjMQM7PVL77IgBzTMn6zJdiTZpRFhspYXQCrhn2KqzSckNN6H4oBXaoxh5L5zbxUoA/xDAaEnNg4RyVtGNXY7LCHGhFnGcGNRjaAICmpjOEExL/yrYsVWRj4diN73SxEVEjHmjGmcDc/RiEvMM78BalGJqBKeUKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HPwbyCnZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SGXrIffx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HPwbyCnZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SGXrIffx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id ABC3A1D00197;
	Wed, 20 Aug 2025 13:00:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 20 Aug 2025 13:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755709203; x=1755795603; bh=/05VTGuTLu
	PMP8y8QehHrPrtYPUXZ9jwYYlELBKqfKE=; b=HPwbyCnZ1T87f15DqKxF9GZU9C
	XP1yVPMVs0uhxEbO5l4ZKJ2BOtnogOXX1fCqMBiQcwV/aUYEMJzr78KYC8VK/bs/
	0lHKehTvd+/jqXJuXS7y187gGSaHOQW/XU+vAePGJf8sU0aF7DoKNE8MRm3QKBTy
	ER7/CwbWm/Rx5v8K2ANz7izoNpYxdW3sHD3H5HGMpzL8JUQx8h0HUa6kTOL26iaL
	TXcUonDd3jIfzcP95y5VE/L0c26VTa2Sps6wg788JxSVthOef9tIaEENZQhUj4Q0
	damhgGeAPCEU5weevO//Dr5iASGZnWGBV3pD6ruEStg6k4mMnkXthioceKEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755709203; x=1755795603; bh=/05VTGuTLuPMP8y8QehHrPrtYPUXZ9jwYYl
	ELBKqfKE=; b=SGXrIffxacU9WGrVGNgKmeosbZ3ZJSXR28J9FmRnYYMWWBx3Lv8
	jdz3XjGl2aW55W2NVr5gt8Wuk3y0L76eFZPejpC0lhs5+Q2BB09cZGtLbJm7hn8W
	JEAGrbo3F5Bmt6pRWGNuUexnZIH621VOnUtXz7n78RWYBH65STnOXcxhy6+0HO8O
	ltGYzZOT68iGYhUg806HDf7OxmOACvYmAa/SP/LYcVEGssQK0w7gN3+c4uxxu+04
	pgq7Rzhn9NP7j9E4OhMN73fto/Hz3N5hHwBF4vCw/ukph/q231qPjPhHGbNu32/U
	jno+T2jGVJePQqxWlBPDHq+RTySmyINbx0Q==
X-ME-Sender: <xms:E_-laBH5tyKN5oHy284cYC2HHWo6Tqv-qrSqmoB1joUVfk4OZV5WHA>
    <xme:E_-laA5gsNmStU8XTxKy1PVrwpGVkbKAJodTpk3pzG78TA4ns4Oy6adxLQqQhB6ri
    ZEXIbQ83RHjfanvag>
X-ME-Received: <xmr:E_-laPuHbbCw9c34t3fVV6ij1f3bAjxaJSG9r_tiqTTat3zJJpl0FtjznZ963bdjc8iiK4_33VBzWZv44SoBmrK6LKV_9gj9662Xn-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeffiedugeetvdehffevffeuteelhefhieevffeuiedvvdekkeffffdvieeh
    ffdunecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhgvshgrshhsohhlih
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:E_-laJ6dczmyOhe59cHE9MAFNExZndyDiZpddqde8Pafekt88gNnwQ>
    <xmx:E_-laCVeFPbzxD3ySn_IJsoOmCByZVEdYDw4Sk-QqcbPrqDtCbNfmw>
    <xmx:E_-laD9nSHvi5eQnEBz_yFTjG6-hi4JsIVHxlA8naWgXuHDkS7qOpg>
    <xmx:E_-laGl213XRbmMEac3tMUmS2A2EHSZtoD7dUiwik0Zgvw74WBorSQ>
    <xmx:E_-laIVdHUXDdrC7K2TBtfBqsFFhtz3TJ9OsZ_ySxF1jCZRv2lw3wqJu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 13:00:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Daniele Sassoli <danielesassoli@gmail.com>
Subject: Re: [PATCH v3] doc: add discord to ways of getting help
In-Reply-To: <pull.2033.v3.git.git.1755679018997.gitgitgadget@gmail.com>
	(Daniele Sassoli via GitGitGadget's message of "Wed, 20 Aug 2025
	08:36:58 +0000")
References: <pull.2033.v2.git.git.1755641032154.gitgitgadget@gmail.com>
	<pull.2033.v3.git.git.1755679018997.gitgitgadget@gmail.com>
Date: Wed, 20 Aug 2025 10:00:00 -0700
Message-ID: <xmqq5xeiapyn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Daniele Sassoli <danielesassoli@gmail.com>
>
> Discord is a great way of receiving help for members of the community
> that are not on the mailing list or not familiar with Libera.
>
> Adding it to the official documentation will aid discoverability of it.
>
> The link is the same as the one at https://git-scm.com/community.
>
> Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
> ---
>     doc: add discord to ways of getting help
>     
>     cc: Collin Funk collin.funk1@gmail.com

This matches the result of my local fixup (you could have just said
YesPlease when I said that I'll locally fix-up).  Will replace.

Thanks.
