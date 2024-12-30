Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270F81A23B7
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735569658; cv=none; b=Px0xFtAhCOqi3cyVa5LlcHBh24CbvG9J+CYmUbzPHqgrYKt98dpjeAV1drhZCbY6V1swEumSuyPdJz9AR//6WzPzAliPKDdXOa0o/UMTg1LKQXtgln24QmFk6iLvL5s72+mClfpKrvjcR1q2N3nxCXcHoyZkSfQoJYAt7MR1SmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735569658; c=relaxed/simple;
	bh=URljtszt6Jm3VQzQFN0gBRdysMBaEgaUD94ATqC4f5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SiL51NzZ1Ij4iQVsbNn+pCGv3Q1VpxZsTERW4TUnn9WuEAvgVcS9Ln0clGu1hsrZw2Kq2vAyiPu7RG4W3jvVdgc9k+4iqy3SRsuatVTAlEfNptYrHMlrRe9BHHd30emVC2fTgvIPLyGeQHXEx4lOC71wRWHFQvBJ2fvaIU11Dis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SzAkP2jR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mKY9wAE+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SzAkP2jR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mKY9wAE+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 325D911401DD;
	Mon, 30 Dec 2024 09:40:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 30 Dec 2024 09:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735569655; x=1735656055; bh=iaPyT5kp8h
	MZDe7xD36oaQrZpj50phhnoXgL1POFeuo=; b=SzAkP2jR+vETGex3Jsn8ddAEfm
	FaXgLGaEB3gEfuROf6YUfAFstTAy795OBH/b0MIbJqPGwO76qbQwvXS6gQqoof/6
	aR9Mdd5gYdSZHH8hAyXgJGuh0RiFFVNZ2yEJk4UNtd8LB8JyPXfDR2vRPeNblDCl
	B8KlcEs9GSmxOn8pNzosTEcjye3tWj5SkS/WGVfFcFiOSUaoHhxbWgIaSaui+NgL
	OD/2iVHvHGQLWbAjY2rwDHqTRkPCVBWtqs66BHOCMcsFnp/H9zaMy7OfPah+DgaD
	zY5IzBMUVXWMlAHnMRXgGyhG9IXGlp5M5speyiW/1E67dJ1eHcVtCmxUPGgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735569655; x=1735656055; bh=iaPyT5kp8hMZDe7xD36oaQrZpj50phhnoXg
	L1POFeuo=; b=mKY9wAE+TockK0Kz5NoEX0m8fUqqiOrbLzDqCXjiDDCAfP/zvbi
	GlMuWGoA5NeFhUXOh1qoa1u0KEMqDAmpW3VSHkfA2Fs+2IEOvFEY1OI2gq2MeWE6
	vSIuiKdgjSDYo9gug8l6ZKk8lag3DderEQzCmQQCKHZ3RCj9CzFfFIbWKZXg0W9d
	LjSSLr1hubJVcOrRTjAEH9JtypzM4riMhOcyf+pYdJ5bhxPx0anaFBBDwUm8oA8R
	gtNgYp7ynVPukzDcy4shTDkXYEXITruiynRH8KFpsknleiFYpRE0XhWpSvmEtQvY
	J3bs8aerBq++/3D9WdX4hlLBBVBVk7PdP+Q==
X-ME-Sender: <xms:9rByZ7JOucmPHIW2TqtJyJFDv7rLgc86G37YA32VUjcYmTBDg-MYiA>
    <xme:9rByZ_KJqJBNfpWI6Ep6V5RNeMO7eUyzdjnDXuoJ6YyhB-mkvr7ZN-6QmvJwDsALF
    yp4RquqS4Dio4FM-Q>
X-ME-Received: <xmr:9rByZzuAKgJZtTnBq0iGf123mcE1xGTyYeEICobivf419EyDDy5X4IgYJWPH6HupSgt70ssZ_HqXnudoD6zLRnjeZCbR5ThWJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:97ByZ0YHlcAQS4Stqgl7Thuyub2-YG4CLTzQQGRRBXbfKsMCe2S1aw>
    <xmx:97ByZybByIjDs2osFvdQjjfpOtAvWVAwU0KeKA6oRB1QFLt1NqI-FA>
    <xmx:97ByZ4D98B7FCNi2b--TIEdy5iy8GuMHaBLTCImid3d8DDdJBehGtw>
    <xmx:97ByZwaB-tRCysFu2sWLSTLiNoYh4xhsft9GWn3zGs86zIT2h6WE1Q>
    <xmx:97ByZ5y1VtN-3o8CEaxCRcDvvCnvr_zuzV_qufueJqFeCLVfOj4HY1qG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:40:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH] object-file: fix race in object collision check
In-Reply-To: <20241230-b4-pks-object-file-racy-collision-check-v1-1-11571294e60a@pks.im>
	(Patrick Steinhardt's message of "Mon, 30 Dec 2024 11:32:23 +0100")
References: <20241230-b4-pks-object-file-racy-collision-check-v1-1-11571294e60a@pks.im>
Date: Mon, 30 Dec 2024 06:40:53 -0800
Message-ID: <xmqqy0zxz11m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> By definition, two files cannot collide with each other when one of them
> has been removed. We can thus trivially fix the issue by ignoring ENOENT
> when opening either of the files we're about to check for collision.

Thanks for digging it down to the cause.

It is more like even if these two files collided (i.e. have the same
name based on what the hash function says, with different contents),
when one of them has been removed, we have no way to check if the
collision is benign, and even if it were not, we cannot do anything
about it, isn't it?

I do like the simplicity of the solution.  I wonder given bad enough
race, we could fall into a case where both files are missing?

Thanks, will queue.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> this patch is the follow-up for [1], where I've mentioned a couple of CI
> flakes that happen rather regularly. As it turns out, this race was a
> real bug hiding in the newly nitroduced object collision check in case
> one of the files got unlinked while performing the check.
>
> Thanks!
>
> Patrick
>
> [1]: <Z2-2dbYVuuLxpNmK@pks.im>
> ---
>  object-file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 5b792b3dd42cecde43a1b18abc164fd368cbcd69..f84dcd2f2a7b88716ab47bc00ee7a605a82e8d21 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1978,13 +1978,15 @@ static int check_collision(const char *filename_a, const char *filename_b)
>  
>  	fd_a = open(filename_a, O_RDONLY);
>  	if (fd_a < 0) {
> -		ret = error_errno(_("unable to open %s"), filename_a);
> +		if (errno != ENOENT)
> +			ret = error_errno(_("unable to open %s"), filename_a);
>  		goto out;
>  	}
>  
>  	fd_b = open(filename_b, O_RDONLY);
>  	if (fd_b < 0) {
> -		ret = error_errno(_("unable to open %s"), filename_b);
> +		if (errno != ENOENT)
> +			ret = error_errno(_("unable to open %s"), filename_b);
>  		goto out;
>  	}
>  
>
> ---
> base-commit: 306ab352f4e98f6809ce52fc4e5d63fb947d0635
> change-id: 20241230-b4-pks-object-file-racy-collision-check-62a8d1588116
