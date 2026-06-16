Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8B477E34
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627788; cv=none; b=ggwi0VtjDza311l55YbxiGmNRm51nS6XIygO+Xr7FgtuBxvNVDz+19VKaPkapNIGooNZn22dMOVzwKfst/uQfqRLAQC7XkE7+bX0tAUd7iDstKrdoBJVYW4M75FHoxww5bl7n3ANOym53wiVIu5dn44X5LC5tsoV729p4LPdGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627788; c=relaxed/simple;
	bh=WP0roA25Kos+S443cmc3A05p15mL78HOmVuh2DxuqR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lhLePywOUz3Gr+bDs20AP3Q73teAMrOR81VETZO8ppJKCbZsiE+xkYO82R/xnDiIUkAgmjmhQWMK7qRbesWWNQWyUiT7Ae+ZOO5Q2lIud88TfAqGyES8Y9mIkWNbzI8fJ1Vodf/JZDFFNw8ALdP4kzzsZ3GtYnKvEP4SZNaZb/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kFvYq00h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHxHqbpK; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kFvYq00h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHxHqbpK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D2BC37A01BB;
	Tue, 16 Jun 2026 12:36:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 16 Jun 2026 12:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781627785; x=1781714185; bh=KFl7PkDd+X
	fy4xoYo4IbjehtIJl5TijqR6kohkMsPUA=; b=kFvYq00h89+Tma+dDgrJObp0sq
	ME6IzCQpZk/U00UTXBNAbYbLMRN+Zw8qlXtpDPfblDMOLZ5ELcxFshsom58YGznY
	1EJ0GpX6OebTm7DUjQmL6Hu1HfEhI2yOq/+Rh7Q7oR1FDI0iHzJlt1hJN49HeX01
	JH+1JjfOs1ulBO9QTQmCqd2FHFcYY5GypYHXvNPSwZQV3Bt9TVjiAKY3zKm1CMkk
	Fs9W2zXnQ43n9rwMucIVxzQRSJRZ1V3HOb1CqrUTd1kf8H9uve6/KKI98Alerc+l
	K1L+stij5oUERj3YP/dUDnIBtJU+91w6+O9UMy2r4j8/l5EEkSH73jjJlCIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781627785; x=1781714185; bh=KFl7PkDd+Xfy4xoYo4IbjehtIJl5TijqR6k
	ohkMsPUA=; b=iHxHqbpK7XtyyLci8+pIwv1dCrciI+UNCB+o6W9nS5Dab4rn0Lo
	WJ0cuqHE/KyQdiEUbqWD3lm/gG9qstSkvoosK9ng0D5W9OLnfuws+psHKZsXU9G7
	iAm5gXZN7DLXIC+ghb2UtG9Yd1iGibojZiJvfvldCqvSRFY+6THupItCmEqqUuTg
	Nu91CwpvJtQu7yPP5q483dy6Hty/SdYK5rwg2jvmbkWekS11gANkcwP4A/dU3ofQ
	HQLLCr5wQ8vwG28Zd+o/1a+cTy3tIBi8VnhBsR+Xr8O24zHbVjPX/DxEtX3e2hR5
	AqiBRShKVl7MZ533k5ix0eZAN5IW6wQGzQg==
X-ME-Sender: <xms:iXsxalefOaA1r7SdsNtmqjiElXPKNq_jrDt1OUjp39RkYhEbdZigkQ>
    <xme:iXsxakw_k4ZLGdxgHQJNcILmubEbj91YN_fxa35LGSNcIuIjQuuhwrTEEhwDLJpGN
    4wmfSj--clgJcbqg6Ad-zy4Oc4LfwcEPEfGXJMN9OKuIbr9GS1g>
X-ME-Received: <xmr:iXsxatzRKiCyPl_rw0y6dvEdP-HoQwiH8gcdIU01AdxtWIGB8G8bZZCUnDGLnDnhTOVAyMG_S6XwIb9k6A7VIg_2G93gWgo3Ze7K>
X-ME-Proxy-Cause: dmFkZTEScsD8TtTv/E1GhQaxqM0xF5nz/DfU7Mzm9jXCdRzHSwDQhreJbsDW8LlOd6NiU7
    o/N9SxJhyevC+1zhXVWWdFdiDaAPDMbrNG5Cgn1tVRyhWmd8zv3chpN5m7P88/6vlHzHfW
    ACTy+213oTMtaCyok045I8ucVMzkv5HHUotfIK/gfRGqRA4ASA2Fpn0t/oYY1AhkAFO5WH
    LbM75nEO2MyabbNlNy7dX8wh1aAdPs4wMIVd0CzgfdsJ4t31kuZ8lyZjSLlXlbIPnq5IJl
    QuiDvgxR9myb93WbrDj8Jmp/nMWnO5TuV2KoXFyoMECQuqxPG2KKWIFXoUEMyfi7IY95N2
    IAJsYhNX9m0UbDPKYG34o1n8l/LPThVq184WKGjG41JI4tbwbMudCWUbIjGq/h5ZaYr7F4
    niLYYssR2Ab1Bdg3vMHsQBMuAIHfXOM1+vPH6ppXBkuc1mewEpb+yW/JnsYtkgGIAxbXVL
    krvF+N1nKNnJe6+oZgJMgUbFU+IEXOLZF2Ezw4KeMwABxiolUrTudBrCRPVHXRuv5ShrZa
    nReCNt3TXU1JX7O/oXfW87CDgN/UN3O8VpY0SzF2AWdT5WBepVmt4k361u8LvN44SOmHjP
    67SacHVAbkunNBuLFV15Q5HwoD6q+mDzZA1pKUzzH77w0JSTiQWVQHykd+tA
X-ME-Proxy: <xmx:iXsxalbUlZTcBdz79LcRYxrZ20gpeMeBfbLJQCRjM00U_O2Kj_yTkw>
    <xmx:iXsxam26cf1k20ffJptfngpqAS2MWkeNfMMeS4SZYxrpqugLKKw65Q>
    <xmx:iXsxavfM0MvJCtu8h1d3h9p6yO68Pa_odh1uFiEBEuztITGD53JX1w>
    <xmx:iXsxarJQsQL02q3DOhGawlw0Jcb6Kr1Id0W0AdJuVVI4Qu0OENrblw>
    <xmx:iXsxatnPLCs140xmNKCSe-8_QfukAi7ejvacQueQ10z2qgzi-lJTZTlv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 12:36:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,
  ayu.chandekar@gmail.com,  chandrapratap3519@gmail.com,
  christian.couder@gmail.com,  jltobler@gmail.com,  karthik.188@gmail.com,
  peff@peff.net,  phillip.wood@dunelm.org.uk,  siddharthasthana31@gmail.com
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
In-Reply-To: <CAN5EUNR-o_sLzeWuy7M9UMFHBKxSuytNd=4p2svtFuv40E8vZg@mail.gmail.com>
	(Pablo Sabater's message of "Tue, 16 Jun 2026 15:06:43 +0200")
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
	<20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
	<20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
	<xmqqo6hdepgy.fsf@gitster.g>
	<CAN5EUNQ193QyOeTLdu9aXzDeBhFpg38YYBbOLhZLgcg3qfd=uA@mail.gmail.com>
	<xmqqzf0vbyj8.fsf@gitster.g>
	<CAN5EUNR-o_sLzeWuy7M9UMFHBKxSuytNd=4p2svtFuv40E8vZg@mail.gmail.com>
Date: Tue, 16 Jun 2026 09:36:23 -0700
Message-ID: <xmqq8q8e4f3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Back to the test:
>
>   * 41_octopus
>   | * 43_B
>   |  \
>   |   * 43_A
>   | * 42_B
>   | * 42_A
>   * 41_B
>   * 41_A
>
> 43_A is rendered on the second column (first column is active by the
> 41_* branch) and gets indented to the third one. With commit-graph it
> would be on the first and get indented to the second, making it the
> same as more general tests above in "t4218", it is an edge case but
> shows that indentation works correctly independently where the visual
> root is.

Sounds good.
