Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4772222AB
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462290; cv=none; b=NxPTbQnJxjpH8FuhVPKmcSq4J1HmAWhjg3BQ5XuVXg89wk4tCWKaetpRCjTey6bzXCdN2ShSV4gG2P5n59wGo76tA0LAVo5CslwpJ8BVMs+wPVrClKh9eUFFql4i97J5IVYhD8otP6zLrTRfqVoz8DKfwmniWqdgoPYr9tbLLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462290; c=relaxed/simple;
	bh=1IjrTqfT/Nt1ULm4rGdgFBq2PjhHmfJtTQVA8QDTmVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho06r7ZQ/N//VyYCfp7IxFeCyE6QKkaVtjdAP0veUr9LHHAusoQmWwTEG2a5hYr8jUmMfei9xOZOt+Si9R2rClXBtJs0D4Rx14yLTmU51Sg++GTdnt7iQCWrPe3qPrgfLEei+K6MDsxeWHB3GB8yujCk4uDIBkA5vuys4+2PVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D+OG0jrE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tcq25H7/; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D+OG0jrE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tcq25H7/"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 573F82540192;
	Thu, 20 Mar 2025 05:18:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 05:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742462288;
	 x=1742548688; bh=1W7Ahl3NLuEqojwbTGeRuzHhNh6vjgWrSseflZ/x5dM=; b=
	D+OG0jrEsi7BtWznfCyMKR2J03EhTImUhEZYc2jY4zXM1Z3WG0JgcC4QUvCB6HRL
	pc3p4nRCkY8UvhmO5eQTYBbin+91cPB6ihx2Wd3WAWCvkRtoY9XBJy/JAB4Mhf/2
	EZeDoUCGozVqTUYfqC6ozrZ1kkIPCzu+hx4f1b5hJZXA1BT9NHr+RmO89cNWUm4j
	0b8jcXbALSnpD8dzpPj65KxEFYQU7begVn+Gf2/3mX4VkhNFm2sFRBSq406DTVdY
	HcVSLjlqIcPqZhwA+3CCwURjpeX5ewXAd6Z0zzkq6o3PPrB/cjszY2P2AFVJRLvg
	A5AGK7/IGHAYSDenssTTEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742462288; x=
	1742548688; bh=1W7Ahl3NLuEqojwbTGeRuzHhNh6vjgWrSseflZ/x5dM=; b=t
	cq25H7/l0QFwiICm0beYedtYEhfIZJwH3zdstUmnCk+ciKkU70Ae/4x/oUuUm4ZH
	ux2z21C3Y/xrHS879fkZu3rW4gl76SWiRU8NHHsMRiq1aXkGQds2yXK8DyS0GWae
	o+wpj9VO+CarTlKfJ6dIOlv6jfy1Fuw0NmCkB5xQeCQpVQlixsHABAKwunihrDa4
	H/LZd7dzHjfQs4TMblR1quzMR04qewdzZWJmpu7A583e21uIzC1nCmA/1W4IIK7+
	S7kvRjyzS/r9h/2EbMNNRv2qmjjmJnylNNz6z75v/QgBs2P7DJkzHqUvyYbZ1wXz
	cVnzO22MpZ7i5R8vUggKA==
X-ME-Sender: <xms:UN3bZxRaIO-UlqH3r5I3KVdif1i_6t47H-W0NeBtWPT4Ac8Gqy0sYQ>
    <xme:UN3bZ6xuGoyERhW1O9RWrQzI_-3ocL8EzCsk645Kk01PtVz5eNwlM7FqXHB7rl15m
    vFNanwDpm9N_6gOsQ>
X-ME-Received: <xmr:UN3bZ23_n4x6JJjMJ09ZQYuFMUF2VwKHI182ILGX5cRnqO3onzS3frObVHhiyO5IYTqwhmY61t1LP-DqAvnG4OEIgTgTJ5CkR563YUZ6e45m1MU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinhdrrghgrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UN3bZ5Ab--Im7Rt4fbU_pK2vxDuqvjaxtTAdaKVYJEIyh8lGmMl_Jw>
    <xmx:UN3bZ6jgscT0_Vg_e6QS2tAKYFG_Fkyb8nF6cfRT6BM5nU49bjW0MA>
    <xmx:UN3bZ9ozWtuCLatXn8-hHyzpTXau-eJ8FpjMGoVdiDPPvFKTIA1Oaw>
    <xmx:UN3bZ1iBk7sQLwGQkRW4NlTMn9OJAHjkecQONPIjVYSs1xPQOrDSgA>
    <xmx:UN3bZ9taiWLO9r1HMS8NLuTooC-gaoaTnTWlg6UvRIK2QfrDVUaj1WTB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:18:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 062d39fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:18:07 +0000 (UTC)
Date: Thu, 20 Mar 2025 10:18:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/8] pretty: after padding, reset padding info
Message-ID: <Z9vdTmVbIJLa9PGO@pks.im>
References: <cover.1742367347.git.martin.agren@gmail.com>
 <e34ae37982e76179aee780c70b48aaaf959a307b.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e34ae37982e76179aee780c70b48aaaf959a307b.1742367347.git.martin.agren@gmail.com>

On Wed, Mar 19, 2025 at 08:23:38AM +0100, Martin Ågren wrote:
> After handling a padding directive ("%<" or "%>"), we leave the `struct
> padding_args` in a halfway state. We modify it a bit as we apply the
> padding/truncation so that by the time we're done, it can't be in quite
> as many states as when we started. Still, we don't fully restore it to
> its default, no-action state.
> 
> "%<" and "%>" should only affect the next placeholder, but leaving a bit
> of state around doesn't make it obvious that we don't spill any of it
> into our handling of later placeholders. The previous commit closed off
> a way of populating only half the `struct padding_args`, thereby fixing
> a bug that *also* relied on then having the other half contain this kind
> of lingering data.
> 
> After that fix, I haven't figured out a way to provoke a bug using just
> this here half of the issue. Still, after handling padding, let's drop
> all remnants of the previous "%<" or "%>".
> 
> Unlike the bug fixed in the previous commit, this could have some
> realistic chance of regressing something for someone if they've actually
> been using such state leftovers (knowingly or not). Still, it seems
> worthwhile to try to tighten this.

Yeah, I agree. It's very surprising that we retain only a subset of
state, and that does feel like a bug to me.

> This change to pretty.c would have been sufficient to make the test
> added in the previous commit pass. Belt and suspenders.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  pretty.c                      | 2 ++
>  t/t4205-log-pretty-formats.sh | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/pretty.c b/pretty.c
> index a4fa052f8b..f53e77ed86 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1893,6 +1893,8 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
>  	}
>  	strbuf_release(&local_sb);
>  	c->pad.flush_type = no_flush;
> +	c->pad.truncate = trunc_none;
> +	c->pad.padding = 0;
>  	return total_consumed;
>  }

This is using the same default values now as you started to use in the
preceding commit. It might make sense to introduce a macro or function
to initialize the structure so that we don't duplicate initialization.

Patrick
