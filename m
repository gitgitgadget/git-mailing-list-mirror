Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7C18027
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773014693; cv=none; b=Y/Lfms0EgsnN7XGgDG+u10KTuVXgb4uuNSmT893he0YY7PhKmBzxz4tdUKy43vgbU1Z1GOzQAQ4/WR0B1zlOm5Ae4g9CVAWYiXc3IGQP2fD5I5YcA/oI+Kfbe1MYmFgLUUfTgQbY2yxlPqkfkfSdNd9YXVXqsf6rtBxVbgu6fnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773014693; c=relaxed/simple;
	bh=Pf+2+H+q1Nv/8Zm+Z9+XYTVlyQQZ7wiWIEbczilgMpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h6FzHF9R/K/nMSz4rR7SDMF37zFIyGjEBtqAW+REu/ovUhQKoJuyf9vvIaCEGu5MiPfed70q/fqEzFHTfqhZaIHz20CnWVx+5xC2tuXb29cMqjADtPpyXJxbmhcevVwdac7yqdH9j1XMXvFTOdwDWFyhokJmOD3w9q9saenn+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TMpoJm+I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sm49zHMo; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TMpoJm+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sm49zHMo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C81B67A013B;
	Sun,  8 Mar 2026 20:04:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 08 Mar 2026 20:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773014691; x=1773101091; bh=BUk053woQo
	AaVmPG2Bn1oYz3RdldeTN0ac9DgTaR6ys=; b=TMpoJm+IbJUoHBPnrnjzDNkrdK
	cywFKenBPi/GAsD1u52//qUidquEB+L0giEaxyMCmdsHklcMoo/Yx5SmNsHucaz8
	TqMcZY9Fx+jMvj8DVzUnEHZVjR3tonNAIZ/8iCR7v1fQQ7dMaJ/vLzl5A8VTuwE8
	8j5kwnXDsZUIs05HD8DCtpkXgxGZGAGBX9Bg4qc3FFq6Lp0aYCQ8b4TBorjDc6pp
	mgo7xXcXT5n+/H69RaGfVsrNpnlPMkKaZCSJTJ5UtXGbWwPp7qa8treRICq1tFSJ
	ouuLEVJsZ1ePtZiNLYB2PCbzDYN2dN2DMORKDMVcXl+aMEJaNVl/1qNYvOTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773014691; x=1773101091; bh=BUk053woQoAaVmPG2Bn1oYz3RdldeTN0ac9
	DgTaR6ys=; b=Sm49zHMor+HRw5fknfVCRqmOZVr/UaM7+SJtmmL53gK9G8G3diY
	9nCpTWFWnKgzfxA5eOAZRUbcpM437y4joJXyd8jBVkpJ5ZtM5BWvp+M3RpVQsQAu
	tekZF/TkwcgmVxFR7m1faH3LVZeWGrqb0VePLwI61WVZ6s9lL+pOTpiuD6M3t06V
	gffQZycxnKtNBbnQNy175MpJeOsDFmaK4Khj8h5mRsV0swRPeoOEtM8tseKlrTca
	aq2Yn+p1e9c8T3ay0ToU/cqmL4ZCjgqoffAw+c0jvkoybSMpkgd9/+G6EjSX5qOz
	B1dUZlTWLYo4nJQlYhazmENigwZEKTvwV1Q==
X-ME-Sender: <xms:ow6uaV3THbQKjI9kuMSDpFlogmBrdHXEWMgm0QRcSz_X4-UbYcv2Rw>
    <xme:ow6uaTiEJq6_NDYCtZ6UFP9Kelm5gBFlQ-pouu6T_ay7M_zUoHAuDCT9_kGCunz84
    A99RxhhjtorH328Du5iY3Dj8nS9cqncIiP6p3ziVb76mcnerjNyOcQ>
X-ME-Received: <xmr:ow6uaTSkTmm0Bye8ZVg9IM_Mdlc4qAGcKh5w8DxJBcCG1U1ErBdNbI-A99W8h63MTMwiuB8kQ1p164rNwpFzvjfLaV9OArKUOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeefleessggr
    rhhrohhithdrshhhpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ow6uacglvd6jrH39iLa0Bowp7QSpBq03cQzPQxHkgsQ5A_14iYOczA>
    <xmx:ow6uab5BPHV8tsVoCADPKp7U-gtjLDauAyIfsch_z7HnRRWGn5ZrWw>
    <xmx:ow6uaRAzcndomuAlzMKzZVEUuKoMK-73vt9ZRnuI8lp8u7_XT03JNA>
    <xmx:ow6uaaYnE9bwZmMKo8cg-eazP8s65H3ZmMlOfPhiazvY6XUZZGXaDg>
    <xmx:ow6uaSdUp-BCUUOrhN8SMB8deXZ9wz42Rto3pgR5Eb0lv264zcwTTnGS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 20:04:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] parseopt: autocorrect mistyped subcommands
In-Reply-To: <SY0P300MB08010BFD00AA7C73503D8B92CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Sun, 8 Mar 2026 21:17:23 +0900")
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB08010BFD00AA7C73503D8B92CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Sun, 08 Mar 2026 17:04:49 -0700
Message-ID: <xmqqo6kx98bi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> +static const char *autocorrect_subcmd(const char *cmd,
> +				      struct string_list *cmds)
> +{
> +	struct autocorr autocorr = { 0 };
> +
> +	autocorr_resolve(&autocorr);
> +
> +	if (autocorr.mode == AUTOCORR_NEVER ||
> +	    autocorr.mode == AUTOCORR_HINTONLY)
> +		return NULL;
> +
> +	unsigned int min = -1;
> +	unsigned int ties = 0;
> +	struct string_list_item *cand;
> +	struct string_list_item *best = NULL;

CodingGuidelines: -Wdeclaration-after-statement is here.

Using "-1" as "the maximum value this unsigned type can represent"
is somewhat misleading.  Can't we avoid that?

