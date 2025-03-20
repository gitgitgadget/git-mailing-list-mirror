Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F711F09B7
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462282; cv=none; b=mUEEN/xNl06nHxTg50dKoCrImCHoGlClybmzr4FAu8B+vmfI7bpC0AATyl1rR1bAUDnQkBGYOqbzLW4eWXiMdRHC29NHkyw08rCWKZERBUO4ePKfxYWUHq2CDiDXnWUGDzsS5Qs+S9BlTD11bjkVgbaUf+eYJq+Iz+EPpsWSM0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462282; c=relaxed/simple;
	bh=FZ5nrGPva10aodY0jqOPo/ZJVI7WJigQ3mM9U0YxfXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IA7FOCijLXQU1t6dp30JSRZByxtnB+aR9y8g0LP2lLOZ2Mt2cPiT/GkkzuX8FzwDIxCkwOdWb87O+BnXsVGAndDp/qjHe3TxvfcYWEMlReZHd1EqYJnOGTmvfPF+9Jk0pHW5Z7qBVNaZvN3BAi8UKeJRQyhmXjLltSvUaNBHNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K2s2lgCZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXzi8or6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K2s2lgCZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXzi8or6"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C0EC1114018D;
	Thu, 20 Mar 2025 05:17:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 20 Mar 2025 05:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742462279;
	 x=1742548679; bh=7CD5fbWjFzReMzc+ITeyNnPVEkbh1CZDUyiPNmA/NF4=; b=
	K2s2lgCZNTx6OM4z487LI1HJ7yKfmqG2XurpXdV7eXwWJqQarChp/G3rv8HyR9Gb
	FTHAUY2ERs5SgqqqJAacNJAtivIrtm8JJ4+YWGUC2PX0j7lqIAkfK8IY4vhCZD+B
	y7meY9S9RKBHN8EAdmXm1I94ndlztOeizf5LOflUukQkuq4DILz2yADVU+T+8F4I
	FmbAs6eAo+vPAsv8myDUna+8zQVFZDdXv7pHQMlPfTAvOKY/FmkLD0KgGZrmsZpQ
	6uRdd3ti9ogi/Wb1cB8h1EQFRi+Gry3UfRcrTRNm+tScpaRfy9sqbzdiQtvR6SlW
	TIuwnvq0YHikR1R5TzNxXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742462279; x=
	1742548679; bh=7CD5fbWjFzReMzc+ITeyNnPVEkbh1CZDUyiPNmA/NF4=; b=P
	Xzi8or6zkwL1KYSgZcvcnA5U9c4IbRdXK4qnno7uUTHD9H5Rp/3/8tPS4UYhh8AD
	ey/1eh87kVtmOGMukwqo6y/Gkd28ub8g3GmX8HcP0gcMHCmxa+R6/uZmlKc1H1o9
	kUA3R9/REpyN51wqNXUAadUQZewGiTUoS6Iz1GmM+jKqShQtoE/bOUAPxQlZuzeA
	QEB9ZGUEwDGFD0I/sv3o4u6mS83EQmPznHomZTXieGxTvalr5FmyZgg/xvljHdP1
	MEGkdYJy5QUPgEQDaqNFo3ZZrPJ6tOuQimVgD8E/ktypddRPxV/d5dT2TNI5qwCX
	RVRggazNzMLK/Dvhvv9VA==
X-ME-Sender: <xms:R93bZxWWHoJkWpXPc-f3qEkr1LKDCfaWoqCD8iPY_ovP0Tz0In4_3g>
    <xme:R93bZxnhLrvBlEeLZhJaNXOKsrhwHNb-U5l24b_yy6Ih6K8xvzsSEVtRo92PyiNqz
    yVWqQdS8izAhZL7Ag>
X-ME-Received: <xmr:R93bZ9alnvlUwgRnF0SkZlAcVeqFop5lc9h3DigJrrF_qr01iQdAaG1-weVavs-BmD3zoShPFSwwo85cOZdXRuNvNX43w9Qv3AZPgginsTmqgu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinhdrrghgrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:R93bZ0VMtovVKTxhwyaG07W3cakJA1Bu4rJqd1lyQshjO08NQhW0Zw>
    <xmx:R93bZ7k7BKcSbQIID2G4pJcVTyKN3-rmBQuhxiSN89LCwpzjEAxUXg>
    <xmx:R93bZxdA6Oe9EgiD_hmnVkB2mYCqdpQfapzFllKCKJbaP2PDkVEakg>
    <xmx:R93bZ1GFSeEGCx5htj1IUsmXkrb_Bd8tooIXCSLdqsbgNb1Z9vwDLg>
    <xmx:R93bZ5jxuZbqxrsLOu2TgLEvsKnFBek5lPN_ehdNOzzaORuIIFE4KMpV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:17:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bfb25319 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:17:57 +0000 (UTC)
Date: Thu, 20 Mar 2025 10:17:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] pretty: simplify if-else to reduce code duplication
Message-ID: <Z9vdQPtmUiuobOP6@pks.im>
References: <cover.1742367347.git.martin.agren@gmail.com>
 <5f787ddac2d80391feadb8cf6be379fc8e58652f.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f787ddac2d80391feadb8cf6be379fc8e58652f.1742367347.git.martin.agren@gmail.com>

On Wed, Mar 19, 2025 at 08:23:35AM +0100, Martin Ågren wrote:
> First we look for "auto,", then we try "always,", then we fall back to

Nit: we typically have the body carry enough context so that it makes
sense even without reading the commit subject.

> the default, which is to do exactly the same thing as we do for "auto,".
> The amount of code duplication isn't huge, but still: reading this code
> carefully requires spending at least *some* time on making sure the two
> blocks of code are indeed identical.
> 
> Rearrange the checks so that we end with the default case,
> opportunistically consuming the "auto," which may or may not be there.
> 
> In the "always," case, we don't actually *do* anything, so if we were
> into golfing, we'd just write the whole thing as a single
> 
>   if (!skip_prefix(begin, "always,", &begin)) {
>     ...
>   }
> 
> If we ever learn something new besides "always," and "auto," we'd need
> to pull things apart again. Plus we still need somewhere to place the
> comment. Let's focus on code de-duplication rather than golfing for now.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  pretty.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/pretty.c b/pretty.c
> index a4e5fc5c50..6a4264dd01 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1076,13 +1076,11 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
>  		if (!end)
>  			return 0;
>  
> -		if (skip_prefix(begin, "auto,", &begin)) {
> -			if (!want_color(c->pretty_ctx->color))
> -				return end - placeholder + 1;
> -		} else if (skip_prefix(begin, "always,", &begin)) {
> +		if (skip_prefix(begin, "always,", &begin)) {
>  			/* nothing to do; we do not respect want_color at all */
>  		} else {
>  			/* the default is the same as "auto" */
> +			skip_prefix(begin, "auto,", &begin);
>  			if (!want_color(c->pretty_ctx->color))
>  				return end - placeholder + 1;
>  		}

Okay, this change should lead to the same results as before indeed. As
you mention it does require us to be more careful if we ever were to
introduce another option here. But I still think it's fine to simplify
the code like this.

Patrick
