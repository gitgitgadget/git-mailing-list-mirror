Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E6347FC3
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233719; cv=none; b=Q0rSqhlDQ2L/TL/vBfHWRL6JSv0wFbgBQtSKzMRViIqQFoBSLoLOuU1aidWFPjdIM1lLTmUjWr47lRBvIEMR3SaVdoXXLwo+BTGsrkPIxxpxJSyNcE8Z8Xmj63HD7Z0X2m+z3InsrsLdU+U5fECvfyjt4ipakeHOiv14qGaWyd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233719; c=relaxed/simple;
	bh=+kr/vZ9qZgTCqZ9Cg1EbUprcRswg+5XPMNxciGz7GBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VNx5TGQel0OvHgR5M3NR52b7z10Inga2qB9xivgQav8R5j9Tj5MOUSJO6vNEj+DSdNDQjpa4Gro3k23o5qfshDwZGvkgt2fYXQOnxuOuXhWD36XYnmVVmtuYxOrV5zny8pDCebblTxH/ewoKwkqvGfmre+n75XVXqY4nYK+jT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VdYD4yQW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LyoenhvS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VdYD4yQW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LyoenhvS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F338140004B;
	Wed,  4 Feb 2026 14:35:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 04 Feb 2026 14:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770233718; x=1770320118; bh=MFGUUsYspX
	MXLlPjtsfaZcqgVDig45w+gd4Hk2gJJx4=; b=VdYD4yQWaLw6CQq5z847DCs9Qw
	aio7hC9gDBUA/iIXKXIKTu1wqH7dmZJdeb6ouMYJDzHTK9s7tsehPhcAvLA2VeFR
	pnhmH0q+3MqsYAgRHrWgZNYPAtQvxSbBasaeQpuZNK+BOh6hEeFRTM0Uxd+PKBrF
	r3ROG3EfFFXGQOkJbo7eNWUcArU3BcaNNYgbCzYq0BsO9x88aMRbNYC91PS3G5Vn
	zOtqpPq2lfjLO0cG0uvop5kOnXAtULurgH0IPoaUdK7GAn+Oout1RN7L1wjUBYnC
	bAEVprFOy0FmX1FpvOtAYy6Wb8LwbVnLrFbHDdtcRrdvTEJ9v+vpE+d+mDTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770233718; x=1770320118; bh=MFGUUsYspXMXLlPjtsfaZcqgVDig45w+gd4
	Hk2gJJx4=; b=LyoenhvSXpKNgv3DCiYz6eQmZBfS0McoRLKlDDRwFsa/dzTsZlS
	RzHemVM9TqdwF0yzuZJ/wNQS1GbGHv+0ulIdxkt8AuWFNngQcQgrUn8JkguEiQQ/
	RFFJu79r8+8nq1a2WMKw0ss1F+FEKHy3J3pZpOvy/kgT1fQhSsbGUft6FLVNDRDi
	vOrQOx8tHZKurtyy2f3oRK30HDzgSGuT6CA2TB4Vmm26t9yosmJP/LGsnLi3uWBL
	HcXA/E67U03ZGW1INcVwr92G04iu4H+Omdr16SsoYHxFoM16zDJfuLVwH8yvKlrg
	sDJUwDw6AtyO2oNpqTYCFmgsRRZp1viPQhQ==
X-ME-Sender: <xms:dp-DaZTBMs1puE1gZ9-q5cJKrXGaWw1k5NwLjwldbjKnPJKDnf_PvA>
    <xme:dp-DafVKwzze9bWztZLhgMkZd1kCq02mIx_S9ZCsU-xD9r93kFHXQtpS3w7bNYPG4
    XJYlFXirHZcoZ41KKTpAZhCcU977Rj6Hjx0OJWTwnWprWi6Qhaq>
X-ME-Received: <xmr:dp-DaTRBAVjux7mIzcGb66DLORCAN4UhqHz0DDnBqqM6StN9COY_33wgOxc-YddsUUFwRHd2KPfm1urH0k7dCZHD4h-nev86Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepohhp
    ohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:dp-DaX18gv1iKU4bpUtLFD__cMT9Nsljj8hDiEiqiT3pT_fbi4XkIg>
    <xmx:dp-DaTcnwbEEcF_GeOM4IcmpQaacZDTSi14WAyrbOnJRmpupVOGsfw>
    <xmx:dp-DafOTL-qqUWlU4Sh19DLErLexPCrkz3b0y5c2tpER2BSRCKediQ>
    <xmx:dp-DaXW58iYtcmbajNBKjH7o0ZSJrBjwHMn4rmCqvC-EGO8Ral9wRA>
    <xmx:dp-DaY_Gv8HYBQdjY1dkLdP5V64PvjU25kooDIDV0ei_uD8mlT_WiQ5e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 14:35:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Patrick Steinhardt
 <ps@pks.im>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Andreas Schwab <schwab@linux-m68k.org>,
  Ondrej Pohorelsky <opohorel@redhat.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <xmqqo6m6vdf8.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	02 Feb 2026 17:11:39 -0800")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
	<aWD2x154F5f-c3pL@pks.im>
	<aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
	<20260115211448.GF1053259@coredump.intra.peff.net>
	<aWlz-0AOlsFLaBO9@fruit.crustytoothpaste.net>
	<xmqqo6m6vdf8.fsf@gitster.g>
Date: Wed, 04 Feb 2026 11:35:16 -0800
Message-ID: <xmqqqzr0nvyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
> index 1d039cbdaf..47bc8bbef2 100755
> --- a/t/t5409-colorize-remote-messages.sh
> +++ b/t/t5409-colorize-remote-messages.sh
> @@ -107,7 +107,8 @@ test_expect_success 'disallow (color) control sequences in sideband' '
>  	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
>  	test_commit need-at-least-one-commit &&
>  
> -	git clone --no-local . throw-away 2>stderr &&
> +	git -c sideband.allowControlCharacters=color \
> +		clone --no-local . throw-away 2>stderr &&
>  	test_decode_color <stderr >decoded &&
>  	test_grep RED decoded &&
>  	test_grep "\\^G" stderr &&

While I was mucking with this part of the test, this test piece
reminded me that I myself often use a control sequence

    ESC ] 0; <my string> BEL

in a time-consuming program to say which step of the whole thing it
is currently running.

This sequence updates the terminal's title, so in one of my terminal
tab, I start such a time-consuming program, switch to another tab
that is showing another terminal, and let it run.  It will report me
its progress by changing the terminal's title every once in a while.

I would not frown at people who want to do the same over the network
between the servers they control and their desktop client.  Even
though the server is not friendly to those who do not run terminal
that support such a control sequence, that is strictly between the
server and the end-user who talks with the server.

And neutering BEL of course will break such a user, unless the user
says "ok, if I need to pass everything in order to pass BEL, then so
be it".  That is a bit sad.

