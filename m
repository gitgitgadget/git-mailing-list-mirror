Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC9241C8C
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398331; cv=none; b=aqaaS23MqlpYvMjTFongmHQO/s6oJBcoXTvQbYCDuCRI3YF9uOtmwBp/SDq3S/lIdFFTfVB5WmyzMz51mp2CGjgayrXKU1dZwB8UQyIFrhH2MwZ+4QV8J4xcSrufr93ntqna1koBpBrzJQ6bbZaPnLeyBvHGQzKqA32uOHAQGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398331; c=relaxed/simple;
	bh=MgC5jpm2DAQzJgcA3prBBC2PaPobU/emIJJwHVvWNc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MWcN0OzzGYSFpb5HPutJKNhhgJTroYdYAlnjCDe9GwuA76jciXu3/zV3k/fHd6VHV6kXC7QWikmzayTm7JI5Nmdh+uRS+agdD+3Ss/Uk2KGmUPYIXmrMKyod+Pp+7oVNstoneiJ4/sVLCh8g0r85AP40dcfEjBNGz2o4doU9pSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IV2VgI3H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vbVkQnKT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IV2VgI3H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vbVkQnKT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 75DC1EC00E3;
	Fri,  6 Feb 2026 12:18:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Feb 2026 12:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770398330; x=1770484730; bh=YBhp8kjSZx
	oAQBA0yQ/WHZPHi0iu8RkH9eEebDhX3Y4=; b=IV2VgI3Hsw/Xcuq877j2w9V4fE
	Tk9WyUFQNkWDOcmBp70wugYlccVtSDlO8dyXdZvUWd9thKU0mmwesPsFFuoII8AX
	i0GPWz7nqopTV6MSQ1vqAu2EYV0i8+RUpx3Fe89JCP0sGNrfy85QBA620eneA0Af
	P9I8Ivx1UrCqb+GgwJZwbmjd+5LFNxQ8BoqPPQ+OfA+LUSaXneuZ8IICuqGZJDhR
	PBuqEq5xkJ6KKbS/NQLbMj+6/4TJexZWMZzXF3inAeR9AiXwnPibeZKBYXj+uIe+
	mFoDROBH0ix2XWMh97pA6A5xSa0ot5FgQ0QuSMJj7+UimR9aPpWd9R0v3hQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770398330; x=1770484730; bh=YBhp8kjSZxoAQBA0yQ/WHZPHi0iu8RkH9eE
	ebDhX3Y4=; b=vbVkQnKTYvPEwk7gdclHm9mZNFuMei2W1ZPAGQSQlPy1pwvfjwe
	1moOV7/kpH1iFN5EDvWbuhhBdnkLWyjeH0U0doh08Tdx+PuSbG26RfvamD+8UQoc
	TJWpP1Ja4k41Rn8pjFK82knZeLo2JJ1cH+zQUxyXuAm6/5D+A5EOADSQwhzD8lhe
	4cLL3YvVGd3qBjCTOfp2eQSIrrMQc0nA5S2e/dFv7Oj3fHjK3q0x5MCTiKiUNgGP
	ZDcmsDlXvzN0ZTdZ8fbB3LCurIZA4eWnwomDFXcfUXA2HamZnDe+/fCXxjUy++4u
	5M0rNle+td/DUdaVLX1+xdACHACkxHjgvTw==
X-ME-Sender: <xms:eiKGaeHSCArxwSkrvL3q69TbIEr6OXeyqqDrGvhgrM82_WhkFepK6w>
    <xme:eiKGaWPW0NOE0roz4h8iK5I7TlOV9sLRw3IwPcwIjCG_KSQLuAVK08_4WvA4fuHWr
    1Gx-3mOcwNkmQa1I6dMeLMeP3e-c48PscdUHTtryDI2rfIRe2EH-g>
X-ME-Received: <xmr:eiKGaQfN3vCC0X_ZARE67oNuoYlaaENDo4L8VSOJ38op1JZAUkX_ANGmQ6qkrir1EiG4P_wtxVkR1TUtzzVwK86wFBAQVSv9Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eiKGaTvAJlVZd6Uo2vsk_LLiLQx8m2OhaZ0CudDLTQmeAMKTZeNKAA>
    <xmx:eiKGaRmYrqe81znKxhuqguUszo-JG8i2EP9bFP-iMf5w-_dDj-QbJA>
    <xmx:eiKGaVySBSszy3cI8ZATG9kM0GqRs35NyoyWoyZPFyiOICsb5HxJhw>
    <xmx:eiKGaTNB512OC1V8-If1AwGeXhbQGccmy67_CzKFczQqijXanM38Ow>
    <xmx:eiKGaS-aBgFdllIlabdOyFtHn1ZnMwQOM25l6febPdiBIWp22nCzVugQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 12:18:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 2/4] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
In-Reply-To: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-2-1e050c3d6a50@pks.im>
	(Patrick Steinhardt's message of "Fri, 06 Feb 2026 08:49:57 +0100")
References: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
	<20260206-b4-pks-fix-for-each-ref-in-misuse-v3-2-1e050c3d6a50@pks.im>
Date: Fri, 06 Feb 2026 09:18:48 -0800
Message-ID: <xmqq343dhjt3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> @@ -3328,15 +3328,26 @@ void for_each_preferred_bitmap_tip(struct repository *repo,
>  {
>  	struct string_list_item *item;
>  	const struct string_list *preferred_tips;
> +	struct strbuf buf = STRBUF_INIT;
>  
>  	preferred_tips = bitmap_preferred_tips(repo);
>  	if (!preferred_tips)
>  		return;
>  
>  	for_each_string_list_item(item, preferred_tips) {
> +		const char *pattern = item->string;
> +
> +		if (!ends_with(pattern, "/")) {
> +			strbuf_reset(&buf);
> +			strbuf_addf(&buf, "%s/", pattern);
> +			pattern = buf.buf;
> +		}
> +

I briefly wondered if a possible alternative solution is to update
bitmap_preferred_tips() that reads the configuration so that it
gives the callers a string-list with "corrected" strings.  If it can
have many other callers, such an approach would force everybody to
adopt the same worldview, i.e., the configuration is meant to specify
hierarchy prefixes and never individual refs.

But when I noticed that nobody bothers to release resources held by
preferred_Tips, I realized that the above implementation is far
simpler and much better.  This iterator is the only caller of the
file-scope static bitmap_preferred_tips() helper, and what the
helper returns is a borrowed piece of string_list that is owned by
the config subsystem, so such a change will force us to make a copy
and then release the copy in the caller.

So, I think the above change is much better than such an alternative.

Thanks.
