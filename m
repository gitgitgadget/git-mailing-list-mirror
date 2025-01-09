Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2C21B908
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434754; cv=none; b=a2W0eIWSWnHJRE3SWa09zmuLX5RA2GZmZsrU8vJzcOm2OWCYQ7/cuqvQnOPvE0LQ2j1mrqgj7pnXhXiFRyuqJgZG1EIwxJHh87m0oiGnX9fTmc0YNlZMnEwWxAZXt+v1UEI9k+xWMUy8Qg95ODtmib0keWdd9usU2v0GFgsceZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434754; c=relaxed/simple;
	bh=ZHI7C89rGbopt/7+b3c+bg+elXrLcjM5qZpawIWj58M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smykR5V42jKcBKxOt7Jw2AYDbc162RpBhzmIAwtNqTpwKIPnpwzNB3YPKIVVBMF2SPdspDFN2/lBG3Ibqu3jGH/cKsPWwgThe1B8nNyM1rwnXq7uAIIavup9dZZW/2FXztdwivKQq8n20UYvvtabxbqV7JNPHueCL7Vd0I7z6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kHardW3Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=arqSbOON; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kHardW3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="arqSbOON"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 597AD138012D;
	Thu,  9 Jan 2025 09:59:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 09 Jan 2025 09:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736434751; x=1736521151; bh=y1LSiREyZA
	fEkzsGexzoKSbA+xdskZ1+jmgsOVigjTY=; b=kHardW3YTVR9WlLAYKgYVXdOJf
	qeEa5vo2wGTux0YztcVfRYhRk2wED60xhFPd5bMSEbGxvOdrTcoTOLenaBSVjz0E
	iWkPU7KrmhhqFjWTnfGlckzvwzmJ4Wf4VN1uYKAAJJ8/J0a4SxvXhlxL73Fvt++D
	HgxwV83xDcYXkyrD8aUSk7iqjobFtWGllCzgmyosMVN9l4f9U69lUiimSZQgKiqX
	DIm1psdZ7IwLjpJhog2uRBEuWgu4orSPALgD7waZYQxvo6Z9isuE16wkCfsCMihV
	M+BqAAhCYxiUsZ6px6gLZloQOSKRs1fLQv7MpmIPkFueF6HFBqMXCNpRMJ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736434751; x=1736521151; bh=y1LSiREyZAfEkzsGexzoKSbA+xdskZ1+jmg
	sOVigjTY=; b=arqSbOON1/OJvPGfT42f+/VrBnCOhwUi+prVB54llS1VblnCPE8
	pgxh/lcVgcRsU+9QgfLXm7oVN+hy+yUD+8KZfbC885/z1TV+fFp9nOqqCQZUdPje
	H7TRQBeYyzW9eiEPH6mXosEljiZn5laUSH41yWy1oqUmJB4LbbsKWVKyRQHgrrd3
	qwg3XdfHFrU9W97Z7Qq9CMtzts+P/X9LmNpk1WbuZKONMqu78+XpQrVucAf01DEr
	bR4hccH/6P+KfmVxGkWX+Tq2JURImf5k5smK0s6yGMKuEPjpSojF3+5uxXaNjvLM
	Hbki9/ToYbWbVg736qqaZM9fPw8H6tIMlmA==
X-ME-Sender: <xms:PuR_Z-90ogN9pK7nAc-VVp1NliV7ZEa2kJYT7Eevqe4OexsKtkh-Rg>
    <xme:PuR_Z-ufhNcJIi35tkYhiuYLQ38cfAZKcRjj9pWuJt0XqDzKOdHaDiN7eJy-UPhqg
    mt-dz6bjH6779Ga2Q>
X-ME-Received: <xmr:PuR_Z0CRKRmkf5AmFlZ9hf11PkrXy17rPBHuj2MCPDYM5VphNPAnSeABzLemnC5RU8dmXCsPwN3c-zkslDVYbg_bLYK24X1es4o6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PuR_Z2fEFbvyciGGWz08WShvPnK4kELvojZBVmerl6QHtWjpoTKXBw>
    <xmx:PuR_ZzPu8NNOdsU4aHksx9kLyifz0m_vYiSpNA0Hvq8w6tY54Aw-ug>
    <xmx:PuR_ZwnagQWY5HVUT05t7Q3j9t5dtDndQvOjAQVQzQpbUg4wfMKayQ>
    <xmx:PuR_Z1t9F0OBnpk0zxqBCM_5rUpwPDfmRSVJmGDEx5dkPmQKXFsHMg>
    <xmx:P-R_Z-243fYLNZ5Xas-7jLiMdqQO2t6JwcMP1l5iBesGLU3_ulbY4_V8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 09:59:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
In-Reply-To: <20250109-b4-pks-blame-truncate-hash-length-v2-1-589c81a6ddb0@pks.im>
	(Patrick Steinhardt's message of "Thu, 09 Jan 2025 12:48:22 +0100")
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
	<20250109-b4-pks-blame-truncate-hash-length-v2-1-589c81a6ddb0@pks.im>
Date: Thu, 09 Jan 2025 06:59:08 -0800
Message-ID: <xmqqldvkkp8j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 867032e4c16878ffd56df8a73162b89ca4bd2694..f92e487bed22eec576a4716f2e654cb61efb9903 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -505,7 +505,10 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int

Mental note: the "hex" in question that is used later is defined as

	char hex[GIT_MAX_HEXSZ + 1];

at the top of this scope.

>  			length--;
>  			putchar('?');
>  		}
> -		fwrite(hex, 1, length, stdout);
> +
> +		if (length > GIT_MAX_HEXSZ)
> +			length = GIT_MAX_HEXSZ;
> +		printf("%.*s", (int)length, hex);

This is not wrong per-se, but leaves a funny aftertaste after
reading it, especially if the reader knows the original *bug* was
about showing past the end of the string in "hex".  The question is
"what if the current hash function produces shorter than MAX_HEXSZ?"

The updated code is correct only because it reinstates the use of
printf() so the "length" being longer than the string itself no
longer matters, and the only requirement on "length" is not to
read beyond the end of hex[] array.  So feeding the length of the
array as the limit is not wrong, even though it may be feeding a
limit that is larger than the string stored in the array.

An obvious alternative would have been to base the limit on the
value of strlen(hex) and then we may even keep using fwrite(); then
we do not have worry about "what if MAX_HEXSZ is larger than the
current hash function?" and nonsense like that (I personally prefer
what is being reviewed much better; please do not take this "obvious
alternative" as a suggestion).

Limiting the "length" here does improve the resulting code, relative
to v1 iteration.  This printf is about showing the hexstring and we
are making sure we do not read past the end of the array that holds
the string, and doing it here means we do not have to worry about
leading prefix characters about boundary etc.  Very good
improvement.

Thanks.
