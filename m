Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451453C8C52
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788493134; cv=none; b=gkxcY7DN7Gld88b8Q/ArxcbbLqTqfkJM0TJ78qkxjHiQL6K9RTXpnXadmCzbmrzDzUBbFZtfMu/CPP87XUy90nn/Z4W5th/RApPP/43xYCnWapEyvLSvqZYuBdqSIUUBArFHllm9PZkVnCdrlhYNUsKYBRqJTAh2FqZ77iU+xcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788493134; c=relaxed/simple;
	bh=MzTgqA17iMk2K+B0mqd7CZPOPUOPY7LTZ/v+YklNFkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DBTY1mIZn67hQ7VyjVlNYKIpUu1JIKIWxepsiLfOewH1DA998sBG6nkLHa5JDZkUpnj3hoKOJORQIV8O16PJcKntw51oBF4GId7UPCqZmJqDiVh7nL+QW4d7Gk+YCTNRUiRahIw6jOMdLjnBtGSfUrNyqPasHBin0TV1BoUV8r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dJLZ2JiQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ax/YQlSz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dJLZ2JiQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ax/YQlSz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 749DA1400114;
	Thu,  3 Sep 2026 23:38:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 23:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788493131; x=1788579531; bh=9OxE96Q5VG
	Je5VNlPOv9cJt6XX+JoI3GI8dNC7e3suw=; b=dJLZ2JiQ9JaG7/eDMFHQk3unMg
	dpB1EcVi7Wy9N8u6z1+xMtRwTZpJxSLRtQs7D9Mrqd9LXHhxrJioKBThqhkCJrkK
	Mx7l9HrgtpFl6/QbRstjC4tprBfMV1Fz+x1wtJq5Q503yHkY5zcs+mCkXctY3t+C
	JQwp7XHHzyCu75+9c8dTpTidpbJd8ETV0tLzAQ5DiPDK8pw0McTyVfv1eIyRFlto
	+tmxhoCSV66TbseAwOJh9VgkHgY+n/pJ3AzwCFKHFbcReg1T2omHwD4BVTUhDcfB
	Q0e8suNjL7FO/iIgHcDnxQQujNSWa/taHJTriv3z+7bW5IoaqQhsjHD1vj0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788493131; x=1788579531; bh=9OxE96Q5VGJe5VNlPOv9cJt6XX+JoI3GI8d
	NC7e3suw=; b=ax/YQlSz3v631oLTsRTcW3Se+J359ITRIAEeMwvGmPBNN49svqV
	2Fqqj1IGdKFfe5dptWZC8TdRk3nDDuXLz1vcOxKL9pcqxsw6OP48qM3VK8LrzQoB
	yfVoGIhRY7Md3EoKvA5yP8pAfPIa+fUsGb92u0RP8pn6jdI+BHhME3W2SvbVasGU
	jfPMTyq26RF0FcHJTn1WH0GhmaGBCUMJM9WdZ6JKdS1s5UhKH/b0pKTiCaVd9F2P
	tDVg2Qz69LKw4xRWDypN0WbUsLSQslasEZl38BIWMxMs+AcFD6rl59gHBcIkYuxs
	qmRKjkjzWRAy00DmSzirZeFnwWdsmSVFA8Q==
X-ME-Sender: <xms:Sj2aaqVvcectiiHuzrQ5UNHRNENs3vmKOLuRXAGXf45-JWcq8MMsaw>
    <xme:Sj2aapKnaqpIQXoymGD7tVSa7MWcHYmC885gQ5_u013eXhz_KFduURHtL1CW8ytSH
    7lTO3DzyXu7lpGLE6-MV2zKeeLoeu-kHh9YS7pVi6EM1Yg0xndKNCc>
X-ME-Received: <xmr:Sj2aaiBarP-urmNNzTNEjwDEDXdeaIjHeOwZfwj31XfGtMibjnwOU-TaAY8hPVNy19wJ6mB-7KOrcq9RxTVZI-MvuQgGbKgXGw>
X-ME-Proxy-Cause: dmFkZTFRbd6QK2p3CKt1yKObr9lDncPdnX+n/HHdAs3bDdDmYcWDm5plAF6/50ZLGiUsoG
    ECHBJnkhh3lHOuUYEPfZeP0yo2A5RvpktRv+323NPL6mVo1M0Ez+sHBj90LviGoI7wcCWV
    GKHT2x/WTa0XsuVV+kIRzfYE9uB2RbRBrpjjorEP3BwHBQ7zMvZA4Za40P/lWarh3isavJ
    MNzNo8jtFq3+gyUrp4V11K8VnHyvYVZ7we+AJ6QoPuogs+Bl/uiSXlPq0XzhvJ6D0cQnAS
    tvLjQz7uJ7BJ4kB5f0NAVwIYXN3De4euyZuGlrhymmzLEa3Gp+2iujZgY1K2i5oVanyDJi
    fGSQaQ0MQHZiL5v8csgfdUlhnBVC75c/p/wu3V/zeC/yk8eFQe6h8sweP2DdEmmlm3KKhx
    MujFNqSJXfwjvzLuLOiDnDUTB35ACryrKH5iU7MDY9LpaK8UuFhlhHVrBWGIQI+Bed0hPo
    kgTci1KY4uDPrTAGcUWPIAnqFXcinD1SRvx4EDb8SVLRUb0iECCTZyGW/KYBIDj04qxqrR
    ZFminebhV74eW0KL5MID+6JluRkX/0QR0t/wQcjJ1z12NnZ4Z+MaSlH5CDIO48cPAfkKpp
    e2oyZtSrckCsWgUdeo56/sQgvzQYp4Vqsd4gcSuw4TRZrSf7SJYbF0oqMxmA
X-ME-Proxy: <xmx:Sz2aahfVZ5iD4URcStDM-XymNCERxfcT1fDX825iiNoh81k1QgY_8Q>
    <xmx:Sz2aap2UXBLPEbCKtBj5INaD7NRKQy54OZfM0JrpiZybroo_kC0HuA>
    <xmx:Sz2aaggLTjc0WHBmj6EnLcy9IwsaXHTMc6wg3VBLV4j1PlPk16Mjdw>
    <xmx:Sz2aaqneio6JWA0ykvjgX4K_TXWH_0tT5xVISF6S2EhjICMFA3EG_w>
    <xmx:Sz2aahKIhgJXintarujK-6KHONAlLCgplCjOYMPBpFNmWeOIDerswx2n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 23:38:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 6/6] fast-import: use early_scan_options() for
 --allow-unsafe-features
In-Reply-To: <20260902161047.476753-7-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 2 Sep 2026 18:10:47 +0200")
References: <20260902161047.476753-1-christian.couder@gmail.com>
	<20260902161047.476753-7-christian.couder@gmail.com>
Date: Thu, 03 Sep 2026 20:38:49 -0700
Message-ID: <xmqqwlt18z3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> The "feature" lines at the start of the stream are processed before the
> command line options are parsed, so cmd_fast_import() scans its
> arguments early to find out if `--allow-unsafe-features` was given.
>
> That scan doesn't know which options take their value as a separate
> argument, and it stops at the first argument that doesn't start with a
> dash. So it disagrees with parse_options(), which accepts values
> separated from their option by a space, for a command line like
> "--depth 5 --allow-unsafe-features": the scan stops at "5" and never
> sees the option, so unsafe "feature" commands from the stream are
> refused even though the option was given.

Well explained.

> @@ -4218,23 +4235,20 @@ int cmd_fast_import(int argc,
>  	 * line to override stream data). But we must do an early parse of any
>  	 * command-line options that impact how we interpret the feature lines.
>  	 *
> +	 * NEEDSWORK: This scan only matches the exact
> +	 * "--allow-unsafe-features" spelling, while parse_options() below
> +	 * also accepts unambiguous abbreviations, so the two disagree for
> +	 * a command line like "--allow-unsafe": parse_options() accepts
> +	 * the option, but this scan doesn't see it, so unsafe features
> +	 * from the stream are still refused. This errs on the safe side.
>  	 */
> -	for (int i = 1; i < argc; i++) {
> -		const char *arg = argv[i];
> -		if (*arg != '-' || !strcmp(arg, "--"))
> -			break;
> -		if (!strcmp(arg, "--allow-unsafe-features"))
> -			state.allow_unsafe_features = 1;
> -	}

This is the ad-hoc one that does not know --depth takes a value
after it.

> +	early = early_scan_options_from_options(fast_import_options,
> +						early_wanted);
> +	early_scan_options(argc - 1, argv + 1, early,
> +			   EARLY_SCAN_STOP_AT_DASHDASH |
> +			   EARLY_SCAN_STOP_AT_NON_OPTION,
> +			   option_parse_early_allow_unsafe, &state);
> +	free(early);

Interesting.  This one now "knows" enough to skip what comes after
"--depth" that takes an option ;-)  And it is perfectly fine if we
skip over "--depth hello" to find "--allow-unsafe", as such a "oops
we require number but hello is not a number" will be caught by the
real parser anyway.

Nicely done.
