Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B391E5B63
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769208; cv=none; b=c1rWoVUMCw6oRCTpZtWwUx8Nuvu0kbzhCO5tkfxgT3djds9td1FQx0LgAbFTFLyv40MbrjZV+/DxJwGu8dSKFc6iHtJfJJmj8aXOlrNBGWfckdJkTg/ocZos3/6F8+Fz1WME1hMJbam/zR9YRxyyuUVxfNGcB06C8Mwv2EwE5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769208; c=relaxed/simple;
	bh=v27jYgt7ctaYc88w+C0Ehil2E3DGfUdSbFNg53g7SjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar/KEexYaZ7AWHW+VZlQ4INpVECjnb66cPvlN91MUHB30mSGATAV0u/RU7tMoL1r7f6UA9vEfP0qp6ELNzslZLP6Ck2YJGTknBp/HOUjE0XY6p/mxzFlfWD3P9rCnEyZGJ70ZnjyoZDwOH3SJvC+iWyVPu1JeKRrkJ4xiUVujwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H2bqv48l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ogzVVZuu; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H2bqv48l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ogzVVZuu"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id AB1C91D00075;
	Mon, 10 Nov 2025 05:06:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Nov 2025 05:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762769204; x=1762855604; bh=p5LZQdaH+B
	1DjPxV+4VVYLfKZH/Hca2EQaPJ5I/Y7nw=; b=H2bqv48lONvlclQ+JS8a2uKi/7
	HbOd0ANDzU9HSSU7EfmvZgndt7QJX7ad+FZKpU4WuZNr9QaOCVMP1I1GsAWvyBsh
	AG2OZ9MSlYSxYDx8jdHB1YYBVTTxrkiuRncFcshbRBvFhLBniQda3dkFeMI/t8ca
	Q7iQa51i1reVNnM3ZHFPItcChPNnw4ye4/kjaxDU70QKyIRRw2Jlai1rCow1Ll4z
	lXb5R9bVRJBYNLLjlzEyUh8xbuNeYB9Q5sCouYdpyniCufwAa5vqolM0jUFymvRF
	2Sxa8MO8YpZlv9gnkfOcISKAmBdItyxJl6lZT8yZLYmeB5PhNNRmOUnwpZwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762769204; x=1762855604; bh=p5LZQdaH+B1DjPxV+4VVYLfKZH/Hca2EQaP
	J5I/Y7nw=; b=ogzVVZuu/vOgss2Py9vgzxKrSeebCCvGFYI/GvbGmMcvRiSuwIZ
	S71nn5v/xV5Jyx/f/HA/E3ymuhUc8h1jTU8jqLTaHj/3S570DMgdqfqKaUdeaUME
	wEHpxCFx2IlDSQof0VJN/twFBcVfoB4qRqbtS7SwO+49Y77yiS/QjsZD5IsNcb1G
	E/3j9Ud0LZA1OW0pNtGsp00kwaWwKMMqJfOXH2JeCIASI9UzXpEsaPliXRWp46fy
	uyVbTTQGStba2fPMkLH5ZkljnCJIUQEQlKjkEQ+3U/B5ywvhwNppoCRyOp6Wo85a
	VEq/OogXZGwRF4/X5VVUm50AuXed/GjNrwQ==
X-ME-Sender: <xms:NLkRaV-WbLMHhMpoI3b4atyp5R7LnMAVeWIIYW7dudcgyl5nsHCOPg>
    <xme:NLkRafv_fM456aEq_j9eDH7ddqQIakVwP4_oqjcdqj1tq3jfuO5zzFE3muxKm6FpF
    VqcRlciuAyRXFT3W1t5TDEKJhPNvLmShyID1OXpBv2zGmECIq-w>
X-ME-Received: <xmr:NLkRaQp24RL8PwjKqT7NSNAzQGLaW8Xy2gVuYG4wkTZV4UWyzzm0gXc6ev3gvRhC9tXrx8nyUmQvHbM8jYrau3DP2Czs25sEEC90JRy6gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NLkRaUmHHj8XkCYPfcmSPQObesl6UvoarExr_GvrgPvoIKCxWTgYgA>
    <xmx:NLkRacytnTwXz-uQEatDqBnIc2aaau86kmSi4XoWup8VcAuFZnLngA>
    <xmx:NLkRaUkz8DZ5oB2d6fkw2JYsYNwgBkVp5C-BkIwMsNHt8RIbvAwvHA>
    <xmx:NLkRadceOqNvfbtVKizAWQiYA40PCAkn-QHn5vy3BgHAKH7y-nPnLA>
    <xmx:NLkRaRVAv7fu7TuPuHdiLibJdmMwSgtBTVwUKYn-WA8fpQ8_n0cAobOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 05:06:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ae1179e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 10 Nov 2025 10:06:42 +0000 (UTC)
Date: Mon, 10 Nov 2025 11:06:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 05/12] diff: refactor output of incomplete line
Message-ID: <aRG5KeoZg1Q1y8DE@pks.im>
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251105213052.1499224-1-gitster@pobox.com>
 <20251105213052.1499224-6-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105213052.1499224-6-gitster@pobox.com>

On Wed, Nov 05, 2025 at 01:30:45PM -0800, Junio C Hamano wrote:
> Create a helper function that reacts to "\ No newline at the end of
> file" in preparation for unifying the incomplete line handling in
> the code path that handles xdiff output and the code path that
> bypasses xdiff and produces complete rewrite patch.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index e73320dfb1..d388d318e4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1379,6 +1379,10 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  		emit_line(o, "", "", line, len);
>  		break;
>  	case DIFF_SYMBOL_CONTEXT_INCOMPLETE:
> +		set = diff_get_color_opt(o, DIFF_CONTEXT);
> +		reset = diff_get_color_opt(o, DIFF_RESET);
> +		emit_line(o, set, reset, line, len);
> +		break;
>  	case DIFF_SYMBOL_CONTEXT_MARKER:
>  		context = diff_get_color_opt(o, DIFF_CONTEXT);
>  		reset = diff_get_color_opt(o, DIFF_RESET);

I found it a bit confusing that we use `set`/`reset` here instead of
`context`/`reset` as before. It doesn't make any difference as these are
local variables anyway, but it might make sense to explain why you chose
to use different variables.

Honestly, this whole hunk is somewhat confusing in the first place. It
doesn't seem to connect with the description in any way, as it's a no-op
change and we don't even use the newly introduced function.

Patrick
