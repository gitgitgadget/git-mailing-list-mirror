Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435D1991C9
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752270049; cv=none; b=EnRzbCF+XnGETiIBACqVPXljlKafdFrA4A/k8vE0cpFQcKJ/CZGR3TruYv3J/fvVpTty0p0PPHi4tfC23fFXqTRZZr6K+ArNjSfbf2CFSx7JQ4/P9LlbCjNK8+AAmwt0Plm+NMOTJdbg/D+b9c+vk2edzB/mHbtqyvs7l9QxzRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752270049; c=relaxed/simple;
	bh=hDDv6CRk3gkj6ybZ4TogUS8aOkIgK0hRrDQVe18GywQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UyP+h6OjMQ4w9ghcQPwH+41cCu3v0MWYedNS3/aq6ZXmSKlWRtgpU2wmWJk47IlLFWx2p7PtRTbj/ik1gdDDMoFjuuD68+g+jDwo4dk34ChfJ3bf7tRw+oCYTFq1xGQR0HG1enprnFugDneUu9IcFvlM15OKiO33NW9LwB03n5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KTlBL6UC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mtBxsgaT; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KTlBL6UC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mtBxsgaT"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 02D341D002A9;
	Fri, 11 Jul 2025 17:40:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 17:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752270046; x=1752356446; bh=LpYXsea8VQ
	f7HCT1l55l5+7C4UJBZrOeRtSt38NI38E=; b=KTlBL6UCJFs2e4DfcywJSzuDWM
	UsTnTvKfV1SxAdyt7A4l9/xju0KcQxDiIHh7gE/IN5R5hM1KtpB6z/ndllCYQ0/I
	kLxiTnAZICpXFQTfSbSh/4IyO4uqC4HSuJX1snf+MZA3Z712ZBByIPKRlg+0PE0U
	cZCOoWBihvEiTQ0NWsT6jlySiUOhxXAH+4DLDUZLP/6M8oeToOJyQJiGh+YrcXXV
	zHIFYVLeo7Vy91GC93EAzmxnMVvCqK6DHqdFLNEIqYBbjGE7ecS6rju1xrcZn79S
	C+FFoLM1DwWHBQvxKjJSpFPBq6BsldK4GxooWrEchX8jD7hOTngCi3EHBUOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752270046; x=1752356446; bh=LpYXsea8VQf7HCT1l55l5+7C4UJBZrOeRtS
	t38NI38E=; b=mtBxsgaT0NWUa9MESvTt5PQDEvPES+nJlSIls/xhMFZJsQxZYlS
	ftPqYT4hqz+gN/eibWSkm4KS4SYRFSK9FMWucUpgYha0lIt7Vvyd+uz8YpbAonxG
	otAkygi0ApICwj2qf2UniceBvZRZsOfBizROKuW5tZdxGV6yaU1Lnt9EdUW0Ni6m
	Zqm+7j/vWDJeCQe1BsaFhYodphNXdKSE8Cj7uy4uJuDzG4tfJ+FWuA5LuurZkYGw
	wT7NyCzRU4uFCZ9UAH5APfxO9pwitBk7gHLqd5rGPnPupcxusxvx4XUtYpi8t+Ku
	1yxTHqvcqLUYR2Se82tNg+igpKuSmGmKV3w==
X-ME-Sender: <xms:3oRxaPZViXYp7g0WHwY89RVItYiToXx1gYiYkG8npvpENnC-muA_XA>
    <xme:3oRxaBqm-qKmQLrA4oXwTu9LTJFjfvIHfnpAQlNWa4ExD-geLh2YhsrUxNnanUhxm
    kDWWEB3Ctt7HVWsgA>
X-ME-Received: <xmr:3oRxaLaYtirzy1GIqO3NzsQqxzcLuQmpZHvXBfs6P6TKoe5MfYOPBg0waKPJ9Jb3DWmU2huRF5xLNIY5K2GZm94fG6r6VhocC3DJeS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3oRxaBQFHENziwr5frsmHjdK_XOPzSSKsPf255NmIh7xKJfJ634eQA>
    <xmx:3oRxaK6if9C1vSOBJNl7j-9yQdppY7TpN4Z_vlajbdW71_ro6baUZw>
    <xmx:3oRxaOyhu7zAFsIgsZjUgbNAFwJ5asJr_Tw0bLI2161YPxt1K6V-QA>
    <xmx:3oRxaBS6HECoOWC4HjjrDD5JItGw27XbpAYNVLz6G8jHRlAAMyE0Tw>
    <xmx:3oRxaCT_184bKway_FNT55do5l9EsalgB9DkVHVpB9ia3mn0DoXA0K71>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 17:40:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] tag: allow idempotent "git tag" without "--force"
In-Reply-To: <dt5ruadvr7lmhsbypmb6yili5cookfx5btw4gzfeui7ehxxajv@ziael4udbbcy>
	(Justin Tobler's message of "Fri, 11 Jul 2025 15:57:00 -0500")
References: <xmqqzfefodje.fsf@gitster.g> <xmqqv7nyzgp7.fsf@gitster.g>
	<dt5ruadvr7lmhsbypmb6yili5cookfx5btw4gzfeui7ehxxajv@ziael4udbbcy>
Date: Fri, 11 Jul 2025 14:40:44 -0700
Message-ID: <xmqqcya6z9r7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> For example push the newly created tag:
>
>   git tag T O && git push --tags

The above is not quite a scalable workflow and is not recommendable,
though.  What if you are publishing to more than one place, and/or
sometimes some of them are not reachable?  You want to push out your
tag not because you newly created it, but because you know some
remotes may not have it for whatever reason.  "I just created one"
is a crude approximate for the latter.  "Last time I created one, it
somehow failed to push out" (so I have to try again) needs to be
considered.

Having said that, ever since I invented "push --follow-tags", I
rarely push tags out just for the sake of pushing them out.  Only
when the real contents that matter are pushed out, tags that point
at them would follow.

> To me atleast, the feedback of knowing whether tag was created seems a bit more
> interesting. I also don't feel super strongly though.

I do not fell strongly one way or anothre, either.  Discarding the
topic is easier than keeping it for me, so let me mark it for trash
bin.

Thanks.
