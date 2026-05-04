Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036E1A6813
	for <git@vger.kernel.org>; Mon,  4 May 2026 01:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777857185; cv=none; b=BqOjtM1mtd39tTltc52hT0OKqM9rwrwNtCKg9zO/uKyDD9+IdBHjPZUMHYsArUbMhrjrqK+ubHb5sLR0loVnptNsuB7GhRbVnKHrzITX3TEDMRbe0BBzEG1W6TzJIWR4GxCugEI1hiPEveLbKWCE/OfKL+ozZLVoq7ouxUFI7jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777857185; c=relaxed/simple;
	bh=dCENWBIfYcIGfT5lOQBEwsUMAddiMYz+lBg5iFyrUoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YhxgXymaDiPmVRyBkPT2nALS7c5PhDNG5YHCQjFIWx1XGI1YHLk2f4AdYRIikrWTqbX2Og6n6AL4hhLkBE6nDIc+X97l+URjs3UWNiznrGj/X5PDHMKiiBntVBr4nLdSnjjyLAqFsGAqS+fkOX/0M8veYKOcuscX72aHZGl1QuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HBWs1K0J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LV3+a6CB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HBWs1K0J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LV3+a6CB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C60D81D0000E;
	Sun,  3 May 2026 21:13:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 03 May 2026 21:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777857183;
	 x=1777943583; bh=H5Dme+QMIToEcAhU+zE8lFmybpArt4ArMR6hKUWG6Nw=; b=
	HBWs1K0JIlVfMrMWnNtyLaPxr63g/F/au40bHp1WTUAMlrkP5G11Troe0b8Ucywi
	SA8x2cWxcLdqawz06gF4kCLQwMs2/duL3aGxz8m9rvKukBw8AJOo4AY8GzRqiJTG
	czH4YNVgM0KpQSDZk/DCpQfcp+QhmLmiBE8WwOfe+FCgac5MwnN8bytHhILs7KfJ
	JfbNU3ZcKjGKya+Nk9MzQtn8TKAbnzU6TKjMStqOJM87RlC5EV8pbm+f7wZfq1Xy
	qVgIQ4Pe04ecFrZ5a8vfu/BYal9IpbTwwViRmFO4lwENP8cyCS1O7x1YmSelodX1
	DRAcwyw6uxaQW/sqetEmwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777857183; x=
	1777943583; bh=H5Dme+QMIToEcAhU+zE8lFmybpArt4ArMR6hKUWG6Nw=; b=L
	V3+a6CB+P+TglhMXOoLV70GG9OA4fyEaysnMgQSB3rnfSQbGmKrcrz0sN1LOLU6w
	TS4qMoEdQkMooMM4Ds4z7Fo+b+RW9rBAvPiuRZb7aY/qa8cMiWAyP8DizUXUr8O7
	8NlM47sv3KD/DgzNks4UeKoXuZf6Gxxkh8HFtAoQwvvPpHY0oEo0s4iwG25od5Uh
	kUQO2vXQ1xAKtI2P/IWUcB8sJMb8477qgIBtlUfvsiznB1c7syFNRK7RUgF1sj6P
	5pBhRElZYxPmNJ9aiixWAFA7Rc26zU9lENn5BXXHtmLUYOV6niVUch8czyXs7/pk
	CaGRoWIIScN4VkQFvOnGQ==
X-ME-Sender: <xms:n_L3aY6zHYo9CH9nCH9GK7MNL2iEC16a4G7KeXXlLpFchKh0tBdxKA>
    <xme:n_L3aXsV_wGm7HmrJ_PiUSxLvTSRJ-rlARbdgUobiakf1-4cEfmSRfF7Jp7PleGdY
    dYJgU8OgoVb-uEMF0dtQa-wANZCSMHRYq0zo6daEB3EdyOu4-nr>
X-ME-Received: <xmr:n_L3aR7djStbLyKf-rnr_xNQEMyKtzl-VYAlUxQRMgS7dXNcZwFlFjvkjEQh3YEfCy2KHsvXZC2eRb_j2g8kFe2UGd2pbFBALw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:n_L3aaVnTippCdUM6mKU7QcPPxkiwWaNveSLBfg-GhTLZFgvC4IAvg>
    <xmx:n_L3ab9yh56r07XklGPYoY_ViJmjmFDro3K3mepDgDdQfv9wHV89jg>
    <xmx:n_L3aelbBLY1pSuQZTjg6q7iJCWPXelbIvjKaNEJVFVwLO222BYIEQ>
    <xmx:n_L3aRULTdYTWryVeDUdcCMtADS_vcJiTOQho7wYUfA4sBpeKyRdEA>
    <xmx:n_L3aZ34bVhRfv5ktLH4zl_4AhX1Hm19Y03IThueKbZ21RQCZsB3qo33>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 21:13:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  GIT Mailing-list
 <git@vger.kernel.org>
Subject: Re: [PATCH] name-rev: fix an 'may be used uninitialized' error
In-Reply-To: <e74a8fd8-0617-46a8-8bef-a454d51a99c1@ramsayjones.plus.com>
	(Ramsay Jones's message of "Sun, 3 May 2026 16:16:38 +0100")
References: <e74a8fd8-0617-46a8-8bef-a454d51a99c1@ramsayjones.plus.com>
Date: Mon, 04 May 2026 10:13:01 +0900
Message-ID: <xmqqv7d4ou3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Today's seen branch fails to build (with DEVELOPER=1), like so:
>
>       CC builtin/name-rev.o
>   builtin/name-rev.c: In function ‘cmd_format_rev’:
>   builtin/name-rev.c:885:28: error: ‘commit’ may be used uninitialized [-Werror=maybe-uninitialized]
>     885 |                         if (!commit) {
>         |                            ^
>   builtin/name-rev.c:867:40: note: ‘commit’ was declared here
>     867 |                         struct commit *commit;
>         |                                        ^~~~~~
>   cc1: all warnings being treated as errors
>   make: *** [Makefile:2932: builtin/name-rev.o] Error 1
> ...
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index b941e93834..5b7f7a00e5 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -882,6 +882,8 @@ int cmd_format_rev(int argc,
>  			peeled = deref_tag(the_repository, object, scratch_buf.buf, 0);
>  			if (peeled && peeled->type == OBJ_COMMIT)
>  				commit = (struct commit *)peeled;
> +			else
> +				commit = NULL;
>  			if (!commit) {
>  				fprintf(stderr, "Could not get commit for %s. Skipping.\n",
>  					*argv);

Why not

			if (peeled && peeled->type == OBJ_COMMIT) {
				commit = (struct commit *)peeled;
			} else {
				fprintf(stderr, "... skipping ...");
				continue;
			}

			get_format_rev(commit, &format_pp, &scratch);

or even

			if (!peeled || peeled->type != OBJ_COMMIT) {
				fprintf(stderr, "... skipping ...");
				continue;
			}

			get_format_rev((struct commit *)peeled->type,
					&format_pp, &scratch);

and dropping the variable "struct commit *commit" altogether?


