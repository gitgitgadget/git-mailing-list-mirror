Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76032D3756
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364493; cv=none; b=BCM9gkxl7J2hgSAegWehx05Z5gmqjfbOwLLmNeuMolJrJqlvGKQchXdabYqL1Tj0LCBjXmptdL7jez8CNuuzb/82OJTKYZ622Ed7W1iBs+ZAT/r3YoGugOuL2XWQoVPx7qsJBpSW0bN1oyKWBfGpHuPOT6a65EudS0T/fHvDJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364493; c=relaxed/simple;
	bh=B3oGnqL5SfTVPxc9AIsG/fzsbosuOec2rgBnoiaWnqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQkS/Jh0oVUaHmFZKeZuHPYJv2nMaTtmkQopuwn4TYYQ8dBYvXpU8Ldo75obin1yaqNFeWwCE75tvWR8bRAySrmanDokG74ory2Mimyf8roGixjpEYmYwdkQNgDdxCv8xfuuBgtdMfCZqbEgDDnF3HZ8X1pJ10K+4jJ9agclWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nSMYOU6y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WtAd59U7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nSMYOU6y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WtAd59U7"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9D6F7A014B;
	Mon,  8 Sep 2025 16:47:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 08 Sep 2025 16:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757364479; x=1757450879; bh=HWDxkKl6E+
	lHV01e9chkJZ/ZzdVQEZKMXZjPfkr1tDo=; b=nSMYOU6yT2RvMZGXz8jFFy+PkN
	pOCDoFlVAEy2BggKU5I8zN1q12LIrFCRKHfcIW5ue6joJVAg6qtSKX7srrJI9AYR
	N/vo+5Zgj80z4SE1YCJ3s/lSHFpGdOmb+O9WO4ELwBAnRyI4pqUqPPwKJj6H5R14
	VtMztF6+zjfRErwbiYlqyQADS0fJInHo9Hr+dK6YExvGCkvKTeOcPXSySmxoOCYS
	KMGktiVCnpI1f39ArcR6KauAduY95lwu6sLeUOYLOXE+oC7uQGhC1qr5uNnXSUul
	c9adX3QGC8IFdHIHE2LXesAcCaxWWLnYc2PFgPc04imcKB7cS/AeFK9rYfjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757364479; x=1757450879; bh=HWDxkKl6E+lHV01e9chkJZ/ZzdVQEZKMXZj
	Pfkr1tDo=; b=WtAd59U7ghJI0Z8MUB7PHajWXMKgPkn/v5EkAX1AzZ7rP+T4GIF
	tB9AGc3hw0WqtYXmbD66XdGrsyImhDpTG5WDcZf5BKLhgJwPk50XDtdck1WbQ/QG
	tOwp2+iRcR6FGMroSHqpyINnaDf0z6hQnC8tc0Ep4i/tHcddXiWRKqXvdAq8zyJM
	N+qffFsaNcDn9Lf6Y4a3sNfDvmoNcbIKwNsrcfEvgeKXNNbU0I01Ml5KiTSh+W5h
	OvjOI+NLOa0KbGpiPskcHJrlwKBmMPso/gNAulLPT5dI+qf2PB7z46kuwAxMgroX
	oxOZuAo6mCUPKTyqICfAOpn2GMGHmzFaQDg==
X-ME-Sender: <xms:_0C_aCdXH259jveMYGk_QRZuS4PTRkgmYT8kTjywbJ8XeVww-GdxYw>
    <xme:_0C_aEqAXH7y6CI1sacqh76KVx-0Rl2y4xyx44nnSKUFIukxqefBWaXPQPgqqq7kd
    5fxm0iCf19uYupYqQ>
X-ME-Received: <xmr:_0C_aD-LyjzvuIoI5QFoLrO9wzAQ_AK8xfaYTyaySUOPHhRzZd_VbsEtdMaBmkV7XHAJLG_QO3HQXxKFZpaMGKNuqOihC50970T-J0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpth
    htohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:_0C_aAez4UGwjmLeOy-buZGaeuDh2A_F1lI50ddgaPpVPXxnh2MNqw>
    <xmx:_0C_aNKilX_Y9bZNaSYG_4RoT6L7Q_ARMedVdy4lEAtHNX4tsLXJFA>
    <xmx:_0C_aAh2nwYx1ULOiBg1WiYBWV8HeY4t7u_kqlALgqtpNnE7R0CcMg>
    <xmx:_0C_aLR1HtRoTEPcPcB1iA7bYcUEIfcoGeH8t6kN-9s69OWyM8FSXg>
    <xmx:_0C_aA1PThRm-sRGFyWpL78_8FSll15DcJe157AudU2DU_kQ0C3vpj9V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 16:47:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Eric
 Sunshine <sunshine@sunshineco.com>,  peff@peff.net
Subject: Re: [PATCH v3 3/8] git: allow alias-shadowing deprecated builtins
In-Reply-To: <eec01cbac16596c5e117843ae86956e1f66ec097.1757345711.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 8 Sep 2025
	17:36:14 +0200")
References: <cover.1756480827.git.code@khaugsbakk.name>
	<cover.1757345711.git.code@khaugsbakk.name>
	<eec01cbac16596c5e117843ae86956e1f66ec097.1757345711.git.code@khaugsbakk.name>
Date: Mon, 08 Sep 2025 13:47:57 -0700
Message-ID: <xmqqcy80wu0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> +static int is_deprecated_command(const char *cmd)
> +{
> +	return !strcmp(cmd, "whatchanged") ||
> +	       !strcmp(cmd, "pack-redundant");
> +}

This is somewhat a shame as you introduced the DEPRECATED bit to
annotate entries in "struct cmd_struct commands[]" array.  Shouldn't
this be moved to git.c and taught to consult that array instead?

