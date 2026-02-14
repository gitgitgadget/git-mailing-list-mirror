Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2F7262E
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 00:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771029771; cv=none; b=JvnfCAeIC6u/tM7T6FEr4BhI7iiFzv3mhJOhTBhnH4qUHu+yFkg8sH/lfji2ec4gGbngAUQkdRMkWxrYq8c8/CvtifnhHtcbF/H2X99pSl4uo6mTrAGb4r0lAbt14LfuSYJzgx7NMosEXYK42SUGxyQ481nPopj1R3QNpoFuLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771029771; c=relaxed/simple;
	bh=1ze+zwTJcXsLNBS1ApJ/A25V88uaKIcMd7PU3HdT+1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CgcBNhbBd7SYLaGme9TGx1ci0xi9+7DdWPJgKeTXQgLmpxDaeLDh58X6p7m5dktnExkrwQcCXgOkjTe2zijmHUZu4vWb8vHYsiWkSd7ShTHo9Y8iyUe8DBTD7wKNXrH5QcG0I0SWOQoCv9mHnTTK65oedOB2Jpx9ZkrK7UjAaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qois08ox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rlHcKYdU; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qois08ox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rlHcKYdU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7EAB01D0008A;
	Fri, 13 Feb 2026 19:42:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 13 Feb 2026 19:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771029768; x=1771116168; bh=66fl5eBU45
	OwMASKsuyL9MuVHz4uVV0yroLVNA3blRY=; b=Qois08oxpud66SqyRadYdwbgxF
	R9T5PR5kvC5lH84tcxnGe7zt44juNedvpaei0gPh6zq0zJI7U31Rg3YmeRv4cUcN
	YgfztwXMtGvuuf6eAND/BBqWAnae5fVSOoM8SzZjqNg6JJDmAgmsVtC/U+IvB94B
	vjZ3BKbwBl91dV36i+dP3AMAw+JyIovCCGQcH1s8+gKBlW65h0uKAhWIHqrsMLZi
	cgTPY+vkQWX5vCLwYhVk48P13p3AidlCZ/8c4Zkvq+qOEav5ZcQR3z3W67MYmh/C
	F6glC1oqU6WDbt9EeCkQk6S9KOLrcyVhMSyR2+X4W9KxSQhAautRREkVtTFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771029768; x=1771116168; bh=66fl5eBU45OwMASKsuyL9MuVHz4uVV0yroL
	VNA3blRY=; b=rlHcKYdUbkZ79gj2a/ow9nYquLiSJgAvHDqoBgzYmC3H1EPupsJ
	e2LWIf8tYAn073fQNNghrHL96rRUTXkqIrZVzB/ccwCC3MFdNVW+pksoZZ5UUCB2
	zQRUpRvHiwABL1tXkd6FRf6Upa+epvBUK5bL9fgOp3kAHL09itb3BC/PDXOCdxaM
	7f+vs7c7QajV1KB0s6itOa9n4ZsRLyeLL3YW8fegLGTwjamArzJBvGVu5wyckIFF
	/5CDHWL9JmxDXreF0z3c8D6PoVh653zU90mjc/dj+ol1l6vLSMJe/puTozQH2my2
	zTViTQgi8R4957lGR++P/GAgvlBZj/zdIqA==
X-ME-Sender: <xms:B8WPaflhwf6pXlv5zEkNLcAWv6u7jEcP7xyA4YQJ6Nm_hTv6oEzV8w>
    <xme:B8WPaVZNnKgpURVIcrgiY1QC3xlpa9Hn4p64HF1M0Rk_0UCqeGw0Dxu8_HX2vPV8-
    VnnjfIOFuAtgfEnmE62qDUOwpY_gqOCdI_W4Tm9CHzRu6jiHz23vXs>
X-ME-Received: <xmr:B8WPaZQGbp4sA1_z-nOxvm6HiEzUtjPzj1OZPOvFWZ8sx1gnTDmAP5ZjOgBp27bFpzQmKgqCzVnxzjm-AvqNU9IjMO1KDikR_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CMWPaXt6vsQa62cBzXgIDqoPz1xcGTL5mqa0i094Ggla5JZON3v1AA>
    <xmx:CMWPaTHYCPwNvAMzh8gjJwt5VzomR56zxJi4egMwpoJWdK4WTjyEKA>
    <xmx:CMWPaQzJzR68FmlZYztaikGD7Y-q4qCajW8ejeqvdQf-DR3jamsfxw>
    <xmx:CMWPaV1eVojbhGiLIpy86ftrjvYvnvl75PoJEYoQ6cSm63MSIE_hZw>
    <xmx:CMWPaWgH9B6LtKWmVihixMJ4TjS7eqHZLy47ap6VW-poC38bUDBzmZew>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 19:42:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Phillip Wood <phillip.wood123@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,
  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 04/13] config: format int64s gently
In-Reply-To: <2bca4d231686e33ea9d4d85b10fcffd60a63ad46.1771026918.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Fri, 13 Feb 2026
	23:55:09 +0000")
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<2bca4d231686e33ea9d4d85b10fcffd60a63ad46.1771026918.git.gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 16:42:46 -0800
Message-ID: <xmqq8qcwi29l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int format_config_int64(struct strbuf *buf,
> +			       const char *key_,
> +			       const char *value_,
> +			       const struct key_value_info *kvi,
> +			       int gently)
> +{
> +	int64_t v = 0;
> +	if (gently) {
> +		if (git_parse_int64(value_, &v))
> +			return -1;
> +	} else {
> +		/* may die() */
> +		v = git_config_int64(key_, value_ ? value_ : "", kvi);
> +	}
> +
> +	strbuf_addf(buf, "%"PRId64, v);
> +	return 0;
> +}

This establishes the pattern the next handful of patches follow.  We
already have in parse.c helpers that we can use for the gentler
parsing, and otherwise we'd use git_config_*() that the caller of
these new helpers were using originally.

I'd have preferred to have the blank line moved to the gap between
the decl and the first statement, i.e.,

> +{
> +	int64_t v = 0;
> +
> +	if (gently) {
> +		if (git_parse_int64(value_, &v))
> +			return -1;
> +	} else {
> +		/* may die() */
> +		v = git_config_int64(key_, value_ ? value_ : "", kvi);
> +	}
> +	strbuf_addf(buf, "%"PRId64, v);
> +	return 0;
> +}

These "format X gently" steps look very good.
