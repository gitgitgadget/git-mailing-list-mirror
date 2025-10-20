Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488EA2773D3
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977035; cv=none; b=BbQyoaOUrhDCg7Qg6Vw6CnnD+hRbsSer0EWbAz+59i0J7gl4yvL31J19UFQLNsH7/Z4cvbrtvdN5wMEm3lrWWK1v2aiHc8hGIjfpkjeKHWnNinLuibdfHfCDo3q/gfx1L0M9sWRbjv7CIT3rUGjyHwYM2PDNsPSlx3fOlcslPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977035; c=relaxed/simple;
	bh=kiZLsfT74ZxZ2VYY08FDlIMd/g+5KcK/QbuYpJAHU6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FVI6t8tgbmWOH5O71MDohgJ4fC5gkwqhso5Hd+N6eqHrr607VUTQGwT5BHtqHSwlkFXkBZ55HX15cUc6RIFaX6h8SiYmaSyRlItSTj3vjgXWszZfVaA1NoDAdMxT6I92YEdv8nsaXqdW8fSfGgRQjku56pxh8H2c13f2H+O3U5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hJqM35KT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=clrhcGnt; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hJqM35KT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="clrhcGnt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E3AFA1D0003C;
	Mon, 20 Oct 2025 12:17:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 20 Oct 2025 12:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760977029; x=1761063429; bh=PWpbFqkQbf
	rzmyO+ZMEwjHh4o2aIsLJlBltUQEOvlF8=; b=hJqM35KTwulFek7ceyTKx/Ne6p
	AKc0EL+IgY5RWNegdq5uHwYr1Wu8OQW19IucHvkSD/NMVGdjgEhWDsUtV5pDmY2y
	a4O9JbGQQLN6z+YCGRo255PQOrhkwAXh7QxFDXnwY2Xf1rkzhPWn8Sx/HSK6MoX2
	tKA23xYfFkolr1YL5BX1FpfzJCJFmrs17NzyrbLrpgthmeV5t8HDq6JkUSYDuiW1
	v7lotO8cf0q+PjrCrW9egTEck7AH9NzpBm/QY0iWy+WeLRWdws4bk9JhwpWyjIKf
	U5l2HCcHfoBP3bG15H9MqeY8BHUbd4IrPLfhj4qNN2YVkpkFd4hyI4wSH1kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760977029; x=1761063429; bh=PWpbFqkQbfrzmyO+ZMEwjHh4o2aIsLJlBlt
	UQEOvlF8=; b=clrhcGntk5oLH0YVyazCzJHAyYMevTir0B1TpEWPnMFiRLcVrYo
	U81HBGFKAO7FMa5m8qamIIjPXvxKyHF7dfwCwKlkbQd7cO4ZhrFskAlF6w8LNsEe
	20zSDhU6FJByEc3x4K0mNVaeLUv7RxQeu+/DWmFb/uoG7KoZJavcUvjYMQlmHalP
	8C8/Bl8EdGOcoZZCOyxHHr5mllFzD6hHZcrq8bq2Au1TCxN53ANSGGp+zo6qvIGb
	ZqncIQxzf3PP17YoSLNwIKjc26vByYG6QchBNlb7sYMifrggESTvZxOM6sZai7UI
	RDaLQCP08rb8PtDaRnWdko9S06nTstiDwnQ==
X-ME-Sender: <xms:hWD2aFcCJpmFdR0E1qnCv7BSfc9zOFE0Mb67YS44Jv-IF0FY8XMJSA>
    <xme:hWD2aPwPSW0Jvc66dWfc0UJcq-p0FrURYk5wQlQa4sdyagw1-puFt0gFsBHaftXik
    xSDv3PGV5TggH11nLnKj25jlhaZxAt-FHcAXJbhGIbyKS7jHTfK>
X-ME-Received: <xmr:hWD2aC9vbuQ90a8irEJkpFDhjxNi_fXUrd-WkiFnzDhTS3mKasMVgm0BplDyAne9QEMjCyQaJU0RrojA6JcywD93nGfYtJlZoKQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    gsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhhorghhrdhpvghnughlvghtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepthhhrhgrnhhurhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgrhhoshhsvghrrdhmihgthhgrvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hWD2aFySsuxrsp0UzPqHqu43nBTdz_DVuLOpC9jzDjRT0gX-TfrYFQ>
    <xmx:hWD2aCrRdEjQP_W9BLLHPrjbczS7ciNhV0jBskf4qPMSbvsZY4lxDQ>
    <xmx:hWD2aGpCY-U-RjvHhEk174YFmKDzsLWonTdtV8uB-EVvo8V8Q4IndQ>
    <xmx:hWD2aCDsZpKmx6YImN3kj4sxN8ul_AFD4tZrycYaYSP96XsxWmkaDw>
    <xmx:hWD2aAOWENz2vQsdplXoUzYfEKd0z0LBJzrBEAy92NnPT_idTAvQDxOF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 12:17:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  Noah Pendleton
 <noah.pendleton@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Thranur Andul <thranur@gmail.com>,  Michael
 Grosser <grosser.michael@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t7500: fix tests with absolute path following
 ":(optional)" on Windows
In-Reply-To: <6a83c7d1-7cd4-432e-a0ab-7b18ce3af08d@kdbg.org> (Johannes Sixt's
	message of "Mon, 20 Oct 2025 11:40:08 +0200")
References: <20250501214057.371711-1-gitster@pobox.com>
	<cover.1759094936.git.ben.knoble+github@gmail.com>
	<6a83c7d1-7cd4-432e-a0ab-7b18ce3af08d@kdbg.org>
Date: Mon, 20 Oct 2025 09:17:07 -0700
Message-ID: <xmqqh5vt1rb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Existing test cases that expect that the specified file does not exist
> are not incorrect (after all, git.exe will not find /c/dir/template).
> Yet, they are conceptually incorrect.

Wow, if I am counting correctly, the oldest one is from July 2007,
and we have been running these tests without anybody noticing?
That's just ... wow.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  It's pure coincidence that I had a closer look at t7500 today.

Thanks, will queue.
