Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F57261C
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146193; cv=none; b=JmC+CMl5KTCotEXokIHsDfKKjtkM5t+GCEZGuKeA7yVaLEekTk7gakfEVYS7SYtKN2lsJRkulC5098dA0MO+J4G09bHz8ohtk636gtVmf1FWqIG8LWaPhZeRe7Ohem2PBPQy+d3t68Mfz8HYkFJ0yIOLufDOegV9QSc8z1ZSopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146193; c=relaxed/simple;
	bh=dSCuccWUg7CPFWzYNWkeF7kSaRuAtghMwpdzNQVMs3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sr/0W+xfybvT84AXVCLjPzxNhuYnAmVtwTMyaY8XH4DemqCUHL+E55rMWS9zIM0RGnJvvnl4LR+2666g5eQIqi6R98iRyX9ZxmHlydeyXaRZWp7um+CeHA3II1ZLH2TP3RdkJ1jSumfr/v9np1tEdoJjtymw4HDuTj1/MaU/y7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vNX7qkVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQSCq/nI; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vNX7qkVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQSCq/nI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C4707A0141;
	Tue,  3 Feb 2026 14:16:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 03 Feb 2026 14:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770146190; x=1770232590; bh=NdJQY+pfbe
	97GAkwReFwXmFySI2u2tSpndjhiJNF/SQ=; b=vNX7qkVR2lCMWnTD8dXxmL2Yw1
	6352Zo1xb4fo6Hkjec3MHZ4W+WJ4x5bg2B/g+q4CPlwLiuawutnEvBJ7G6CxmPu8
	g26nzBl8Gv4JtRKUTquVUe2KH9+kMOPDzrGHwj/IHmxS64giQNzfghcb9Pc1gG5l
	mJPIkkX6nmCX2KYDhrjC2B3/PmglRTFVlibWtkXuKGr8w9lZr5muwfaDLjWYhx+k
	bsLzgBAp1fKZU0rRBQqkvrik/5OMq9iAZUYFgxDDfL7yOcMK0jYTeA3SjPxV5+dj
	LwzM/mVKofsseRhufD6h2nt4kUQMw/swHfZZHoj8wQaHHbumbItpzWr7Sonw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770146190; x=1770232590; bh=NdJQY+pfbe97GAkwReFwXmFySI2u2tSpndj
	hiJNF/SQ=; b=dQSCq/nIoru7lc+LgU6uv+xesOHoFl1X6Oow8lts4CP3OtKdmZF
	/jlTj7g2qgUwfu0yU8pmtQhwdZAx+7WzurzPzxbtZJaX+KpNMteX0jaX5H5KhIq3
	yMGc8YUufHGxWFSyi7bT9ss337G3UraUQvqfQtmlgOLzmBTyBp5DnmdZRedBlxJ1
	EFSQ8Cr3KdDmGhsnc/QSo//hNzfFVMsZw0hySu2haxVc0qbDkQTbm0qFmDNEbv1s
	0SzmfnmLWhwpaodCZvKEWz5klXqyNVqTIuccY90sqLMSu3DQp5Fua5P6ZolBuSC6
	A1PKWX/yeqwm5p9n/pRdzn0qAA7mK6Zkzvg==
X-ME-Sender: <xms:jUmCaTGMG7Hfi79ro_Bnc2PjOmEJAnHB_u5Fm9ygaWY3XX50mqWvlg>
    <xme:jUmCaXV3CUe8NcP3FV7E8wVjd0VMo-YO1UfP_qZqFzpaTHoYvHHNpOm4Z20jYk5FI
    nK4umYeZTKd2m-_I3JKQ00M_lRYP5L0FaG7ywerXyK-M0hplEyfDQ>
X-ME-Received: <xmr:jUmCaaIIIcQzRajBdvfupqZ3nmEHfVjj7rHBMUAaaVtIrE6MvDtuVIySIbtqyUb_HfsVAGOZOz632uMCQ1DAlE8H__ur0-PnEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseif
    vggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jUmCaf9GSnpDIngPWcdpz_QWhbExBJXDmDRBxplFpL-5jyfd86AThg>
    <xmx:jUmCaVKKvg_XM6lDuNWKiml_21JPtRm1-kn0MSmzbEqJSTbcpm1IUA>
    <xmx:jUmCacnelNJNCniIYhLvw0Vi886WbHj_48mp_sNWtYfLyH7eI00Whw>
    <xmx:jUmCaROFwqCDvS1MJRqkuJgM7PsQogupojKef_ZUzbKC25-xPPqUtA>
    <xmx:jkmCaQVept3l__75cZxW4oYF8mybuheFGsYnrWyJbw0DXsXI5nKpb555>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 14:16:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  l.s.r@web.de
Subject: Re: [PATCH] cocci: extend MEMZERO_ARRAY() rules
In-Reply-To: <20260203102908.749954-1-toon@iotcl.com> (Toon Claes's message of
	"Tue, 3 Feb 2026 11:29:03 +0100")
References: <20260203102908.749954-1-toon@iotcl.com>
Date: Tue, 03 Feb 2026 11:16:28 -0800
Message-ID: <xmqqjywtskmr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Recently the MEMZERO_ARRAY() macro was introduced. In that commit also
> coccinelle rules were added to capture cases that can be converted to
> use that macro.
>
> Later a few more cases were manually converted to use the macro, but
> coccinelle didn't capture those. Extend the rules to capture those as
> well.
>
> In various cases the code could be further beautified by removing
> parentheses which are no longer needed. Modify the coccinelle rules to
> optimize those as well and fix them.
>
> During conversion indentation also used spaces where tabs should be
> used, fix that in one go.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  contrib/coccinelle/array.cocci | 36 ++++++++++++++++++++++++++++------
>  diffcore-delta.c               |  2 +-
>  ewah/bitmap.c                  |  4 ++--
>  3 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.cocci
> index d306f6a21e..e71baea00b 100644
> --- a/contrib/coccinelle/array.cocci
> +++ b/contrib/coccinelle/array.cocci
> @@ -107,9 +107,32 @@ type T;
>  T *ptr;
>  expression n;
>  @@
> -- memset(ptr, \( 0x0 \| 0 \), n * \( sizeof(T)
> --                                 \| sizeof(*ptr)
> --                                 \) )
> +- memset(ptr, \( 0 \| '\0' \), \( (n) \| n \) * \( sizeof(T)
> +-                                               \| sizeof(ptr[...])
> +-                                               \| sizeof(*ptr)
> +-                                               \) )

It is kind-a surprising that (n) with and without parentheses must
be presented for the conversion to happen, while the tool clearly
understands that 0 and 0x0 are equivalent ...

> ++ MEMZERO_ARRAY(ptr, n)
> +
> +@@
> +type T;
> +T *ptr;
> +expression n;
> +@@
> +- memset(ptr, \( 0 \| '\0' \), \( sizeof(T)
> +-                              \| sizeof(ptr[...])
> +-                              \| sizeof(*ptr)
> +-                              \) * \( (n) \| n \) )

... and yet the tool does not understand the equivalence between
'\0' and 0, nor (A * B) and (B * A).  Puzzling, but OK.

And the pattern, with *ptr  substituted to ptr[], repeats.

> diff --git a/diffcore-delta.c b/diffcore-delta.c
> index 2de9e9ccff..2b7db39983 100644
> --- a/diffcore-delta.c
> +++ b/diffcore-delta.c
> @@ -135,7 +135,7 @@ static struct spanhash_top *hash_chars(struct repository *r,
>  			      st_mult(sizeof(struct spanhash), (size_t)1 << i)));
>  	hash->alloc_log2 = i;
>  	hash->free = INITIAL_FREE(i);
> -	MEMZERO_ARRAY(hash->data, ((size_t)1 << i));
> +	MEMZERO_ARRAY(hash->data, (size_t)1 << i);
>
>  	n = 0;
>  	accum1 = accum2 = 0;
> diff --git a/ewah/bitmap.c b/ewah/bitmap.c
> index bf878bf876..c378e0ab78 100644
> --- a/ewah/bitmap.c
> +++ b/ewah/bitmap.c
> @@ -46,7 +46,7 @@ static void bitmap_grow(struct bitmap *self, size_t word_alloc)
>  {
>  	size_t old_size = self->word_alloc;
>  	ALLOC_GROW(self->words, word_alloc, self->word_alloc);
> -	MEMZERO_ARRAY(self->words + old_size, (self->word_alloc - old_size));
> +	MEMZERO_ARRAY(self->words + old_size, self->word_alloc - old_size);
>  }
>
>  void bitmap_set(struct bitmap *self, size_t pos)
> @@ -192,7 +192,7 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
>  		self->word_alloc = other_final;
>  		REALLOC_ARRAY(self->words, self->word_alloc);
>  		MEMZERO_ARRAY(self->words + original_size,
> -		              (self->word_alloc - original_size));
> +			      self->word_alloc - original_size);
>  	}
>
>  	ewah_iterator_init(&it, other);

OK.  These do look easier to follow without extra parentheses.

Will queue.  Thanks.
