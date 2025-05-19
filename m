Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9DD266B5C
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639085; cv=none; b=JlsTmkW9oq3VaC2JpLY3NoMAY8gz371Cn1gP4dBbY5qe89lUWI9u71DnGFIBTjLcJGRsU23XpLSJeZ5yriBXq4uXwfqwEH/Dfz9DDEerQXX80FEG3Cy03o2NkIPdYfslUIJC4oPutArvx7p6l1yqxpTeT/WQ+YgWrxGb0eGI34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639085; c=relaxed/simple;
	bh=p1I35b3Beacjdr2/cWKUp4bzh2LqF6syUEPPeEsFWJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFwmXUmvOsEMLIWKZ8Qdi2InI0qxWXrdHtQF5FfPMvZaoqDMPfMHEua32enGBEABl28lfCm1ZzMn9IGg+o8+G0odPnJqhs/Y2gCPtL07+rpbtbBHbA5meoipuY7D3TXUbUy8loiZj8wOKk6XptnoEUDnceg3NsSY3EkFrmmg8Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U1bv9y9S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vqSrSwL5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U1bv9y9S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vqSrSwL5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC3D925400EC;
	Mon, 19 May 2025 03:18:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 May 2025 03:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747639082; x=1747725482; bh=oUihNUy+2M
	+B4AQdmQBDf6KxQbtUy7rvtBPOvPrVqBU=; b=U1bv9y9SGWVxLiSN0b0RFj+oY2
	/JagFnIfi2nFLnaEcDJLeeHydcCoAk95gdQ/REOD8Rk2NUScO8NXZaDQLnOBMd+m
	fHmh4xiRQpW5n04UtldyQ8GR6z3Ph2B00n6R83CRAx1YuvGT++wdDd2r1jZXKXlX
	z/O72gZ9MHY5LvvGN6uv6LSSM3DJDOSvVMZ8QOWGKuzR3xTpP5KVFluSwdIzBokt
	ARGvtwLwdmUQiL2ZqnX1XknDiVc4rALcVZK6jPBGrayp2s/aLQqlLAkFunjNLELI
	MLdEEQWGePpk9VjlqVVcltm1HOCEmwUiGwuFI8LzM4QxpnlWenn52fGzo1OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747639082; x=1747725482; bh=oUihNUy+2M+B4AQdmQBDf6KxQbtUy7rvtBP
	OvPrVqBU=; b=vqSrSwL53ElIgR/oiCTaYXH+dCIJwErjOkagvfqznBrx7GC4IuN
	GcsdpmnKpvrdLVyR2WHhd5+tE1MigiBQxYsd2lkvWBEAPen5cKipu9T10egE36mu
	IGu/gWj3zcaC7EqDZ/zP3REtac6i2Q4j1eUSlMo/pJTiuFxYPH+y24kJOMXfCo1J
	RRbtN3GJz37s/utjV/Vp2yTystlOM+lpl5t/hJwqkolJjLdB+WZBDU4D2W3bbEJi
	n5KzxFeymZvUoOGrd52c692DXICkXVxwPSdaygR5SEVTlD4CqEUoBr5CpaAxqwe2
	EF7Fd6OB37PJ19/qZkfO5kSXSvY9M8H5aZQ==
X-ME-Sender: <xms:KtsqaArUZ9Pw9g-sz1BQW-Kp8qExe71m0XJlMQL2z1aYE9xzcyv8tw>
    <xme:KtsqaGpg5LgGNJ1c1r9VMRx8SFkeASugwSGpmGgf_dR-ae3PQynqRY1-G7RxVg8mv
    rM64rqD38jw67UA0w>
X-ME-Received: <xmr:KtsqaFOh9KzWqNQGYY0MvjOMNP8FdTekUDQrdZ16Obp7sWvDF1VQ8eZbvDhF8BqnYnUBdOTw6i7-K3zl-2ji-sWtpjGlYuCbaBFy7byWsjR7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KtsqaH6ugGTigC1sejsfejm3Spl7fPqjYk8a5d-7rC9yobGRq-CIyA>
    <xmx:KtsqaP5D-8NnMBQ774bpI60s2zV8jFmdMvqZ4DKJpsyQM9gKKnGLvA>
    <xmx:KtsqaHjDIKRFwFdlZeAfb8Xp7JrdEfrMF0KeAO6TDj7_3xt9GApyUQ>
    <xmx:KtsqaJ6bzgbQeJmloRZoasePSXM3o-eb6385SK6W_mdVZdQPfrfB0A>
    <xmx:KtsqaKW0GmWimymbrM0dSYmX-8MuzVH-QTRI4JxyOv1-GypbzZ5CwHtn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 03:18:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35eea157 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 07:18:01 +0000 (UTC)
Date: Mon, 19 May 2025 09:18:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] string-list: return index directly when inserting
 an existing element
Message-ID: <aCrbKI_c5Bma8ZDQ@pks.im>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDW8CcWeq8T9hp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDW8CcWeq8T9hp@ArchLinux>

On Sun, May 18, 2025 at 11:57:15PM +0800, shejialuo wrote:
> When inserting an existing element, "add_entry" would convert "index"
> value to "-1-index" to indicate the caller that this element is in the
> list already.
> 
> However, in "string_list_insert", we would simply convert this to the
> original positive index without any further action. Let's directly
> return the index as we don't care about whether the element is in the
> list by using "add_entry".
> 
> In the future, if we want to let "add_entry" tell the caller, we may add
> "int *exact_match" parameter to "add_entry" instead of converting the
> index to negative to indicate.
> 
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  string-list.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/string-list.c b/string-list.c
> index 8540c29bc9..171cef5dbb 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -40,14 +40,13 @@ static int get_entry_index(const struct string_list *list, const char *string,
>  	return right;
>  }
>  
> -/* returns -1-index if already exists */
>  static int add_entry(struct string_list *list, const char *string)
>  {
>  	int exact_match = 0;
>  	int index = get_entry_index(list, string, &exact_match);
>  
>  	if (exact_match)
> -		return -1 - index;
> +		return index;
>  
>  	ALLOC_GROW(list->items, list->nr+1, list->alloc);
>  	if (index < list->nr)

Okay, let's assume that "index == 2" here and we have an exact match.
We'd thus return `-1 - 2 == -3`.

> @@ -65,9 +64,6 @@ struct string_list_item *string_list_insert(struct string_list *list, const char
>  {
>  	int index = add_entry(list, string);
>  
> -	if (index < 0)
> -		index = -1 - index;
> -
>  	return list->items + index;
>  }

So we'd now realize that `index < 0` and thus calculate `-1 - -3 == 2`,
which is the original index indeed. So this is a nice simplification
that retains the original behaviour indeed.

I think we could simplify the code even further by inlining
`get_entry_index()` now that `string_list_insert()` is a trivial wrapper
around it. But I'll leave it up to you whether we want to do it or not.

Patrick
