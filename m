Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4047D7464
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949576; cv=none; b=c+E1uP5+9wTEOx3NHTEhcypBZ0LeB6ahiserFc1vYmSYMv4kCVgGDfEBL95jK8BRb7tpggUmIhvV1PLyDvZeEPpbNsjHQQO9PO3VoSl0NyaQ8ascRqrxSmCPIb2ekik6E40E2rFRo8jlEqCnN+TTxt2aXYUui4MNR1EsharO7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949576; c=relaxed/simple;
	bh=d9D6meVZeMYq6EE/b9IeiF8/OOkEZr6h94SYj8pcgxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AwjupM9NbXMa8QFHfA8qgGesVpPs1CyEE1WCZcDlFtvErxyVtthQ4Sfo5qRHF7q1vnDozlf6U/79+iP9hs2xIcfxnuQoo7fENv9kBZLuQSOrmNwqQ6dso51RIoTef9aGKv2ia36ybwCYgrr1dRdBFG4h0ZWTygHJxdo6BGKtGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZE/O7ueo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AdMn/LJI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZE/O7ueo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AdMn/LJI"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F2CFEC0BEA;
	Tue,  8 Jul 2025 00:39:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 08 Jul 2025 00:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751949573; x=1752035973; bh=Z3dm+/2AxO
	aVIs2y9UFizfcdX3a9Jw5hhdo3aLk5wHI=; b=ZE/O7ueomCK9G7MF4E7xoP+kY9
	2IVLW8IPXHX+hNBrQx9D381l4gI+ExkUjLjNM5E/wxFg9SpiHBpOpKV3fKJvfrt7
	NdA6DPJv2brabiXQLFIlJztsaExAZCgbEfFX9j5wAGtjAoyqyCvXVl/rbCy25Mla
	zBuiCx865SgOw3P8otjRpyhax2AGdXWnBWfoE/BG2emQtWAc8CBtF0IhS+ZnIAZH
	Zdjdl+csmC5epsHpUh0R73z4IkAcVCssMSDQeA3xgwJhceclp418FKSmykbj9TUE
	QD9wmYrQ+coZddpWn377UAsQFYpXrgldKkMm5x9aP98/rvNBnVANLKzogaDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751949573; x=1752035973; bh=Z3dm+/2AxOaVIs2y9UFizfcdX3a9Jw5hhdo
	3aLk5wHI=; b=AdMn/LJIsXlqVjGuV174SmpUtxs2pc+1Zw+TuIwGqQX7+fjySVp
	XjneExS52Sku4N0pGE6k+YmUN3uUPWdCxYUexNNd6UJuH6gbu7xV64ft4O8rz+uZ
	p5QIs7pI6Lw4tZxuVQMNqq3wH2gQ2+qYwBw9XpUMw8AfwFqRALXO2o1Ykhgygdhf
	SMAcQVCI4mPq1FPw6LiT21W9SpRcafsKKhU3JXP7lHrB7ho2RWDaaeydNauJ5tjp
	lnXkzArZZxGAPSQN14BPPIWB9WoN5u+XgQveWAIXQNBGXei5lX+1bPlUjinqQKkB
	mzrvVhs/PXh7CYsNIaJdJSBj8apL39gz6yA==
X-ME-Sender: <xms:BKFsaGa7MIiq78flUZEHJqcz7rWuP_Sjwmw95gQQxq6jbGTi26s2pg>
    <xme:BKFsaNNC2kKO42aa54SNeV8QkAmMvXwNMOknl3HxiOwNbFIVYQQ5i9_BYd7N_8OAk
    57xAFXeuBawQ2CUDw>
X-ME-Received: <xmr:BKFsaKBlyXWztHh45hv0hdy344BDxqQ8ILtrP6wX0YQ9MR13CbBbqZpvyMPnFHcRslL9VUf42dHClx_9UWO6f09OkfnB8cnAGGOq2TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtveekleekffffudehhfelheffkedvtdeugfekfeekheejteetgeekvdelvdfh
    tdenucffohhmrghinhepmhgrthhrihigrdhnrhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrg
    hmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehirhgvtggtrgdrkhhu
    nhesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhooh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BKFsaMJgaPvMjovuDAlpCwJBPbI7SkkPkJv9vDZoHkp72KtntGnl8w>
    <xmx:BKFsaLN5oM_xThTLBzlFR8FzjI5MhmE_81voQi_ldhVs9tgPqqQVWg>
    <xmx:BKFsaC5hO5P7XTWmimAJ8wpLhB6hMW123YCRPU6B-tWtSMzD1BI9hw>
    <xmx:BKFsaF7S6PjOd82oP-8gZ4DNDZqpEoHKznPj8uFY2_1mltxEduCb8g>
    <xmx:BaFsaJgQRn1haY0p8F_MTggWiv69d--ETr6OE0sPPAlrPBwWZjGNDKWf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 00:39:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  irecca.kun@gmail.com,  Eli Schwartz
 <eschwartz@gentoo.org>
Subject: Re: [PATCH 8/8] ci: use Meson's new `--slice` option
In-Reply-To: <20250708013935.GA549322@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 7 Jul 2025 21:39:35 -0400")
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
	<20250703-b4-pks-meson-cleanups-v1-8-2804c2932abe@pks.im>
	<xmqqldozzge4.fsf@gitster.g>
	<20250708011249.GA547084@coredump.intra.peff.net>
	<20250708013935.GA549322@coredump.intra.peff.net>
Date: Mon, 07 Jul 2025 21:39:30 -0700
Message-ID: <xmqqfrf7z471.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That does renumber the job titles. Probably not important, but they
> wouldn't match the non-meson ones anymore (though I am not sure if we
> even slice in the same way, so maybe it does not matter at all).
>
> Anyway, the more minimal fix is:
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 673b1c44b9..7739bd2d76 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -306,7 +306,7 @@ jobs:
>          path: build
>      - name: Test
>        shell: pwsh
> -      run: meson test -C build --no-rebuild --print-errorlogs --slice ${{ matrix.nr }}/10
> +      run: meson test -C build --no-rebuild --print-errorlogs --slice "$(1+${{ matrix.nr }})/10"

It is confusing that $(...) is not a command substitution in shell
but somehow performs arithmetic X-<.

>    regular:
>      name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
>
> with the additional bonus that I can put "PowerShell Hacker" on my
> resume now.
>
> Curiously the quotes around the whole thing are required. If you do
> just:
>
>   $(1+1)/10
>
> you will get two arguments: "2" and "/10". Definitely surprising to me
> coming from a bourne shell background.

True.
