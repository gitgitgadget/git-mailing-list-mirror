Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F29443
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764381691; cv=none; b=ki0S7IYYl+VkQsr4jyFDPVobykwoZ0UdXk5zJb+q0sQ3XhccZUF+EtymNtJyTG3ZmxAoTcVTfgxiYMOB4osGQcmy3I/0LIvJ7PRyLWq6WHMYxOE1FIdU2d9iB4EauBha8xFfIjqlHPaUG+vBpkrRiiwiNGeyDpZeWuaa9jeU/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764381691; c=relaxed/simple;
	bh=uhB4Oqn6q1/DAUOPdDo6PsyHZK6s3Rk2AbDzXlkuH9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MkoYBQsCpAXeMkeNuU873GoE6YRfFqj0AkvmA2QaW/JIVO9fYl5KhPUpYF3yf8GTXtMHPC9RzHrpuCSiqEKirmVJWTQlUDec5zEM1yte3696oEB/uuMXSWaawTVGxLZ6krSOlrXkErwxNioXjbBChS540RYylcBnPv/u4CQqBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b2UJqIWu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sawp1AvW; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b2UJqIWu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sawp1AvW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C9991D0088B;
	Fri, 28 Nov 2025 21:01:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 28 Nov 2025 21:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764381686; x=1764468086; bh=1lzoVzJaZ7
	HEheH7z5TDd+O3Pp/4b9juDMTuBw+ajik=; b=b2UJqIWuwzLXGp6ORL9pP8fx0a
	Zc2Zhru6jQLh4SdoOYm2OXCwcVj5LRLEq592GGVONbhQYy25DrSnQD8jqgeN+5y/
	VuJFZp9T9Q452ss6eVpZo4O/hj1hCgCczrud9jcGkCrlIjFifDg9i2mxfA35Mfhl
	BLHLhENRiHDqfyDtvfa7D8BRpinR5p0EVpw/8qcQl5rGYWqhenq5IPEF7H4c10YX
	Wie98188ayXndZHT4VQGk+YjX8IGpQLowqU7scKHkH6lQnkBhXrVtZSJ7WZX2COR
	MXbwvr/eaFNCeqXLE8Bxwcgd4/I6OK2gww2K6EDmsyaXAmxKp5ZKVh/3Z9Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764381686; x=1764468086; bh=1lzoVzJaZ7HEheH7z5TDd+O3Pp/4b9juDMT
	uBw+ajik=; b=Sawp1AvWHuAk1PaEAr4A5zvwcodjdlTuVFALPszzByrRI06qcr7
	hcjiQT8zRULxTvPXnxQdjWdTNhzoZTD9/bgw8VaiOxixCV5EHUcSZsEjACWB9M9H
	IuIMpxFZKEjx4YjvuaT5ykG7+01Qy8j0lrSyK/wDGYPAuoOe0Uaq0TZsS9IiCNkP
	YHlmsnUGCHn81aBSfTHU1bG3/3L5uVxavetLHSkadVwxqN1vvPQhAt+O1ALVz9NA
	2IbMGTWXQ3ijtjFnoy9DtqEmdXLKeyvDOITRUMczZ+ANYuLdHThPXiS/Wjov75Vp
	zkVV4bkH+2OdmY/Vnrpy79Mx9nJ6ju1jJ8A==
X-ME-Sender: <xms:9lMqaaSXlPKgAmUun7HO7s17UMgvFUJq_52Hlbko1whqAEMqi7CYYw>
    <xme:9lMqaTcqI8RbBagsxNGaN0pF0AQklzzhP1duFVHOIAprjx1RtBhwFv7XvioPgFLFf
    hhqb2p4m05esQwsIGoOiIfKsJqezomNZueEF1uc83W9l-GnRJtdad8>
X-ME-Received: <xmr:9lMqaRq-XQD0iq-O42aKmBj_9r64meLp8KJjnkyynyWfRYB1DrW7aMjkrTbf4NIn6Dxr3SQUaKy6AAB2tjlX7RMfK0b47M8fdsQr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheduvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnuggvrhhskhes
    mhhithdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9lMqac-8mhCZ8ZAi_EB2vrFhfUyfFKnaZsQm9e5uItmfbcm_u9891w>
    <xmx:9lMqaVctzg5iAGF2EWKDHHVPkE9vJayfc3lIhwBkgkTcAl-v2TR4UA>
    <xmx:9lMqaeKW6VejF863ot5XqxfvKFDsNbYj3sr16wkbs3Hk2RY637vdbQ>
    <xmx:9lMqadjAZG4xI2afQjioP8203QEd5FJdPpLXbzEmY01ClmsIkVLHzQ>
    <xmx:9lMqacX5SeO-UMK9nsvOtHF7Ayv9kK1NggU_V3JsVwDeTKKktfh5NhEX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 21:01:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] last-modified: fix bug caused by inproper initialized
 memory
In-Reply-To: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com> (Toon
	Claes's message of "Fri, 28 Nov 2025 17:37:13 +0100")
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
Date: Fri, 28 Nov 2025 18:01:24 -0800
Message-ID: <xmqq8qfpioln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> git-last-modified(1) uses a scratch bitmap to keep track of paths that
> have been changed between commits. To avoid reallocating a bitmap on
> each call of process_parent(), the scratch bitmap is kept and reused.
> Although, it seems an incorrect length is passed to memset(3).
>
> `struct bitmap` uses `eword_t` to for internal storage. This type is
> typedef'd to uint64_t. To fully zero the memory used by the bitmap,
> multiply the length (saved in `struct bitmap::word_alloc`) by the size
> of `eword_t`.
>
> Reported-by: Anders Kaseorg <andersk@mit.edu>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
> It was reported [1] the tests in t8020 fail on s390x. After some
> research, it seems it was related to s390x being big-endian. Well,
> actually, not really. Using big-endian simply uncovered the problem in
> test.
>
> [1]: https://lore.kernel.org/git/4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu/
> ---
>  builtin/last-modified.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This dates back to v2.52.0~4 and is clearly a maint material.

Thanks for finding and fixing.

>
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index b0ecbdc540..cc5fd2e795 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -327,7 +327,7 @@ static void process_parent(struct last_modified *lm,
>  	if (!(parent->object.flags & PARENT1))
>  		active_paths_free(lm, parent);
>  
> -	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc);
> +	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc * sizeof(eword_t));
>  	diff_queue_clear(&diff_queued_diff);
>  }
>  
>
> ---
> base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
> change-id: 20251126-toon-big-endian-ci-fe62bb361974
