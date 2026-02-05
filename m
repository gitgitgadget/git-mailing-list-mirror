Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB1283FE2
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294086; cv=none; b=qVPoGxySmndVVccn6JZYxP2drngiPB6OR1ZQgVta+kQKnsplAdoNmvdDYPtjWp66uB94EZEBwnDhTbtpoQx4J+HFMHcSbUO+u955ivz1SBIQKcrO3x82P9dGLBM5+7vF4loZeWZ83FkA6AXNYE3VlS5n9N3z6GwgeX+EhRi/vkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294086; c=relaxed/simple;
	bh=MLvG52Bb57Hp9zYDAA/pifKMeIUEn/WX7iIVuNZ6tOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT8YgoF4E05KzoR/ffIk1b+Wneqbdl1RTs3WDk5po0qPnn27LNZK/gC3GRJquZHvJXT6tBUddzyYLnecfI2gHoRutIslTX4whiZ+NGItoRJUbgrVZY7Sm/soOuLjget5P45wuc2PdN6/YAd8O9Qx6j01RAj37S59fX/i+bwZxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RUIdqGYt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V8cydYj+; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RUIdqGYt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V8cydYj+"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 582CA1D0017E;
	Thu,  5 Feb 2026 07:21:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 05 Feb 2026 07:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770294085; x=1770380485; bh=6glOp0pC1r
	lD6gQyObgXlrMFGTtpUQk67/WbFknpbOc=; b=RUIdqGYtiVg09W2D4/Cnm6sEI6
	0MMKUH37dS8M0mgRtE9cwtYOoaIvihl/JPUKb93dyM0MVBFvX8ty3yYmTX0x78mD
	G2vismb81URBF5uhdAFWn1PGDPLpQdMMYbYy7taDJbzIlmY+N6SzlRxbLSIfwQly
	TSmSCjgJmZPdbwloBDDB99omnNnMTZ6XVPnXCGmnCEe5hQXdzMXLWO6Lh0VdXyXP
	i8nF0FLl9JvYk1kFB2BYOoclIhTRSsqCoEOeshem7jCikGiRT+TKcRvrIld2pJN4
	QgohbvvsjUpNB9yGQ7ydk+UBGcpZMMYrj1lkJyvAGuUDxyjiYqg4EJMYmqtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770294085; x=1770380485; bh=6glOp0pC1rlD6gQyObgXlrMFGTtpUQk67/W
	bFknpbOc=; b=V8cydYj+jgf8BMedg6mEifXnQ34qlZcbn7Wz6n0TQtZrWPXOt2v
	B7WpZKyQGHwJCvRI6ZMReXHBPU4ild49NnUmwYbQbSXGKXpdIVM2OIkB1kyIF8kI
	L+dvB5jeyBqNF4AD+ogPlHDNPWgio+bASe94Kf08yxdRE4Z0/7ZRg5SQjmHIX48u
	nbJu1nbShKZI1dnrQzqD7Bec0Gn8exmuy0FVCYmnILbAdSNj7SpRTj309BgVm6H0
	KEZpuo7LMpydAkOpnJUoKnyaqoiqOKvY8+AX5rOlsuZlN5bP7yNdtjKo5b+A9agA
	wcAuuGi+ZQWpvjaSQCA+WXyjoNK8aKaogfw==
X-ME-Sender: <xms:RIuEaYsYJ3myuvW-NEm4RWklAmMf9Frn-yZzggy6DRSH1wT72ourtQ>
    <xme:RIuEabf0abj5C4sMVWdZZIjQhtrNLOhOffww2oSJc1LbQxeNWTOu1LUTeWHAXStH_
    W77Oe-9-lPujrTbLtCvhpVAG23pQsg1evnr05m6x_c7UK07y9Mv4mg>
X-ME-Received: <xmr:RIuEaRaS9jVl366qiwPZ67Y6_DZ2_9FwELNp1O2kL8rwXny3WdeALiU-Hv-fgDbVzx-8E0n2wWdofY4aVmJV8lTRmID9mtEWMeMY7xYTqg10tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RIuEaWVAXmnQMvAZZ_KvC911AtArIySYudWEtA0bPKcc1iRJUIUzHA>
    <xmx:RIuEabim3mccKGQb-YbaRMN8vMIAMYtLr34pPmgPSxfKmWJ2a4H4yw>
    <xmx:RIuEacU3ziJ5Gm6WPzX_W7hlxV4h2jNtiVfvJdSkdQW8VTt4Q1qD5Q>
    <xmx:RIuEaaNvGTPaIoM-BpNdF-ALS9vdeyUIYrhanN8iYBnATJ0F74EuJw>
    <xmx:RYuEaUFIoieI_OzKOpIZxvvg8MTr8m9vcYBBF1PzYIluu-2HLgucykdW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 07:21:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44568843 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Feb 2026 12:21:22 +0000 (UTC)
Date: Thu, 5 Feb 2026 13:21:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] whitespace: symbolic links usually lack LF at the end
Message-ID: <aYSLP1LqBiMwur3O@pks.im>
References: <xmqqecn0nqyt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecn0nqyt.fsf@gitster.g>

On Wed, Feb 04, 2026 at 01:23:06PM -0800, Junio C Hamano wrote:
> diff --git a/apply.c b/apply.c
> index 3de4aa4d2e..581aafb8be 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2193,6 +2193,11 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
>  		patch->ws_rule = whitespace_rule(state->repo->index,
>  						 patch->old_name);
>  
> +	/* being an incomplete line is the norm for a symbolic link */
> +	if ((patch->old_mode && S_ISLNK(patch->old_mode)) ||
> +	    (patch->new_mode && S_ISLNK(patch->new_mode)))
> +		patch->ws_rule &= ~WS_INCOMPLETE_LINE;
> +
>  	patchsize = parse_single_patch(state,
>  				       buffer + offset + hdrsize,
>  				       size - offset - hdrsize,

Hm. Wouldn't that mean that we disable this check for both sides of a
diff if either of them is a symlink? That's typically fine, but if the
diff also contains a mode change it might not be.

I'd suggest that we only disable this check in case either:

  - One side doesn't exist, the other is a symbolic link.

  - Both sides are a symbolic link.

Another question is whether we support symref targets that end in a
newline. I guess the answer is going to be some form of "yes", and in
that case we could of course loose some information. But honestly, this
is so much of an edge case that I don't really worry about it too much.

Thanks!

Patrick
