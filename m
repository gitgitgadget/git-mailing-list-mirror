Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFD302CCA
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662028; cv=none; b=kmpmoOIvNrgTSE1mOKVEK0OzijP121f+FvYWOkEdDC+6DS5XEhb9uAPL/GCH8svLwDGeDpv9HoHgTPf09sO6cGUX9pPSN+kq9ZVXHcO2udf5tgEz/b7OR8FVtuAz2tvPj9VXfwd2VIvLnddbCPK078kyXlJqH6FRkPXhFA57jTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662028; c=relaxed/simple;
	bh=qgbf5fePTNt4UZt5eKY9g/3N7FDpcTwTWIsv3vhdPLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpA8t6pon/gb52fUVYktV3/FQfkwXyvjw1QRspyeBb8P444uAhLt5Zf1FcK6F+4CfLf8YCTaizWvvoqeB1pHKyU6milV8dtbPh9OADWt+kvxwdX7tWbjjfB+xzBRUfG5vtyw5vCcfkjXFtQrDshFLyyFLp0FRZKhvRjPbmyzx+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pV+RUf33; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZTGi7r4a; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pV+RUf33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZTGi7r4a"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2CB3F1D001CA;
	Tue,  2 Dec 2025 02:53:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 02 Dec 2025 02:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764662024; x=1764748424; bh=ULWcnXlUvz
	duVL8RyoPO9zW9foLRe2SruXS8z7ViLlE=; b=pV+RUf33lvdeFdcCextvU0iKaY
	0ntjJ9yPYJEyRKT6DIrJYyKUeyK4dUTetstJgKB5TlTv27XLGj/VDNsMHwMOkRiN
	QwMm1lR3t3fK0NHRodwk14XytwzzB5j+m2VKT29IlKRYDbJWL/XMf2J9NANvSuDj
	13504/xnJaYByg+31f/gxUJhtLASFQFC4zQoB0Y/fGKltDpcRtFap0GNsW1NbFEZ
	Qyo4Fcd2MyH1G6pJtjfT/BTD++29uQSrGtvlJMawjOsCKI6v7Pr4dU8fDt4SqVrg
	10OjSE+qwdz4jZxPGU4OW3gRlx6q9wXJ2ROFw7rNq7uPHd7Hz+Cssh+tqi+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764662024; x=1764748424; bh=ULWcnXlUvzduVL8RyoPO9zW9foLRe2SruXS
	8z7ViLlE=; b=ZTGi7r4aJgxfvdTfivo9lSgaR6orxzSNPvTE3W+eTYdo3r5s9vX
	v9gKFgsZQbTHsVcX+KBP0C0u41eap9HADyOjlCqE1EGUURVYrn/7z+dRllxXGFjr
	xlbzLjvgq+MT7UcardPnMHxcUewckfVKmeIQLNOe4WBpBIcsS78Cw7vpqAIY6hXy
	tGlJ+scgs5UUTvvD7g02gcUaGgAsMthFwr/454wjZoKUdPIyod7IDvp9VoexEhV2
	s4hyFdiQXFg9BSfEKb9/oomMDjbqHmjgXtKNbZWGmLWUDeRfFDqX1FtEjRJEKYUP
	JdjrmNOeg/8GeQAQ2mTje4zxFQ2/7Ruwqxw==
X-ME-Sender: <xms:B5suaVNZI-kdusfXwTkT0Yl4WZsmoeilOp1PSiplTi89iD1Mqwus-w>
    <xme:B5suabrbQlAhgE-4s8Lk3OpKVreSkftltjong0cpbBjJw4rcZ3yDVum5sd2X5meRZ
    A3y41Rx7QogWCbcXyDR5YC7aPxeYJPgvwMF63on4kK1o9lU__Q0gw>
X-ME-Received: <xmr:B5suaeEEHGK4e3dP8tbxaHa83S4jvECl8ImlaGxCD1jbg0xBKrUi3Ej5WC6pr0ecmWOFtoGmEGzhAKzlxzJ_1mKzl7Tdy6f6a18FXquBi8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprghtthhhvgifhhhughhhvghsleefgeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:B5suaYqpqXM5wNEyxOB2WeKvEK3I3VAlcfBuR-6nAnFoX1LIPMULZg>
    <xmx:B5suafb6PAuq8vPQI2L-IU2Q_I6eMebSLHqrBLafH2xlkU-cdyF-sQ>
    <xmx:B5suaZX9Z9DCF6c9Op3WReKWiAjxoHN5sJntPRiNU1qnn0Ek61F67g>
    <xmx:B5suaQ9NfzMCtvSsJY3yl_1F8f2OUNoFuGarGPcb2RJeRtXANMOP_Q>
    <xmx:CJsuaeqmfEN373ra-r_8AnCYvaHLdn1A4GH9XGbxSu8FDPmFcIHJqsu6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 02:53:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc78406b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 07:53:40 +0000 (UTC)
Date: Tue, 2 Dec 2025 08:53:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, atthewhughes934@gmail.com,
	johannes.schindelin@gmx.de, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/5] scalar: annotate config file with "set by scalar"
Message-ID: <aS6a-K--2acXnIFY@pks.im>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <639ff98c44c45bb570fdde5123127aa099c299f8.1764607847.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <639ff98c44c45bb570fdde5123127aa099c299f8.1764607847.git.gitgitgadget@gmail.com>

On Mon, Dec 01, 2025 at 04:50:43PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
> index bd6f0c40d2..43c210a23d 100755
> --- a/t/t9210-scalar.sh
> +++ b/t/t9210-scalar.sh
> @@ -210,6 +210,9 @@ test_expect_success 'scalar reconfigure' '
>  	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
>  	test_path_is_file one/src/cron.txt &&
>  	test true = "$(git -C one/src config core.preloadIndex)" &&
> +	test_grep "preloadIndex = true # set by scalar" one/src/.git/config &&
> +	test_grep "excludeDecoration = refs/prefetch/\* # set by scalar" one/src/.git/config &&
> +
>  	test_subcommand git maintenance start <reconfigure &&
>  	test_subcommand ! git maintenance unregister --force <reconfigure &&

We _could_ make this a bit more solid by adding a test that:

  1. Initializes a new repository.

  2. Saves the configuration.

  3. Performs `scalar reconfigure`.

  4. Asserts that all new non-section-header lines in the configuration
     have a trailing "#set by scalar" comment.

This would ensure that there is no callsite we forgot to add the new
annotation to, and that there are new future callsites where somebody
isn't aware of the comments.

I don't insist on such a test though, so please feel free to ignore this
suggestion.

Patrick
