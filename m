Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F74B21CC51
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188096; cv=none; b=DCkIIO6otUOilxvGs+wErLGoBaTqwc0M59isKNJxivyBwcVT7BIQ7iCFboh51dVY3y6LHZprWDU1hSCKHpykzhR6eIX7ClhYnxL1bwIkjz+y08a4Vat1pHT/XPLBblhKcD1UiCJMPuIa5hZ0rDwHo5et8OIygTxxEwNwZrZZgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188096; c=relaxed/simple;
	bh=Mc7g7CgNafdfNVq6PTn1FEfLkXAXG3NGK3N3VDt6t9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS5UGb9qXsVKOU2WMGAATz/oZeTJ39sjnYqf21jNH7usDw1dBR2PaXxuXRGsuxCXz+ZQYc26HW0FWN/45mlFIPyqZkW21OuDIFI6+vkV23Gz8+XcWoaSCgS9VtRqwhdSYTmAwdZpReSpgz8mdNAwc8xaobkoy6mKnrbbhC7N2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Izm+HZ2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P4PwmpMG; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Izm+HZ2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4PwmpMG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D2C1EC019D;
	Mon, 29 Sep 2025 19:21:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 29 Sep 2025 19:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759188093; x=1759274493; bh=wAKEm5wr5c
	STiAY4OSrkyTCRSFPXROa9x9q9GuoYpSg=; b=Izm+HZ2X9pCAMYNNK56SqHmX9d
	9KA240N72SubqafiLhsixjoNUG7U8jRVFF422PoyJqRJIMIwf5twrWRsciy0M2dc
	XRIAuIKmpZk0aaeDpy5ZnDh2Wm6SPBJ+mT9JzXdy8zQcvFEtGYDXkF5C7T09lZsK
	RqWvft+8l/e+7+ob1oi3xLyfCtLgw7J8DmLcEjP5uUpjfY9k7c3O2x2s8Wdr/+ny
	TDME5VhFPK5WTkb8tarpxgfesd1epwKBFzghkj1uQjMAejTfAhe+FF8DAQhfi+r+
	3xqgi5ALF9tjP3UIlqJNh4OS995bxoNc3SxFVd6x6rb4nz3OY/CsXF2hI3Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759188093; x=1759274493; bh=wAKEm5wr5cSTiAY4OSrkyTCRSFPXROa9x9q
	9GuoYpSg=; b=P4PwmpMGU/qTJLDBN6LOOZMRnsEvDSvVDw0v9jD87w9u8lcg/f1
	ZqQpOgs9/mZnqWLYl4UdpGUP5x4FD/WzgVIgAC0tndPRiaYMYDIfFZORFG0hDOz4
	FqXMOY2qVt2MfFQNn1R2uyrBMG/xnDLs6AFLizfflbrZ/Kz0UpkB1h5Xda6aKyiU
	JGXZLKmLlq9RQOhQgMjUuCwNrd0Dbi8d0sHVdz0jZbyvvaytlx+LYUPmrc/OyBG/
	9wVDfu1SBQbwFhDJiHgFi455o9j3YrzUWP95ukft8NhdxY1+aDqOVhIwjYEmE0Mg
	flHdP2njLjDdg1Ec33XXOglCon3iHCFERxQ==
X-ME-Sender: <xms:fRTbaFailPUXRRSfbF3DshsZLpre9-EPcDnZfudWzA75xum-d2fYeg>
    <xme:fRTbaAGk20zzT0bTGrlxz4ap0bQnYV9Ca8aYEFl_LC5L6hnYUExQ1s8QQ2caSJ0dn
    mGWRT02GgwmeQ2wlIg3-DeEv-CIb-LcaE3TRe5rlu0swCSj8LQPrg>
X-ME-Received: <xmr:fRTbaBwVjWbTMano2mXRCBSMIWESFAX29qh0NAEDLMoxrhudVnKXIYbWy4DJlQL29YxgM9OX0NiymcjOcsNVz5Kqvbo0rFsl8Z207eEPrKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fRTbaKmUxgxoUfHBcJTXT_5kWl_XuQ7WO45saMzcMvXaJH8Sve9K6w>
    <xmx:fRTbaCnxXtpdEZXZsJp--MON19PM_n4Z0Nox6RmI03Pie6qsB5PNHg>
    <xmx:fRTbaEyjE7aszj0CKRlreQl6F4PtLXGXxocLNUIhExQ0HYZBrJaSKg>
    <xmx:fRTbaPpFK6tIR7we4JO8Zj5M9ltw5_8FOJTW3IteRClRLg2QPIG0dA>
    <xmx:fRTbaA1dqJ9FP7YrICR4hQqvywCf68kINui3yo9h_zRDPVeqe84coHpc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 19:21:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 236acfa7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 23:21:31 +0000 (UTC)
Date: Tue, 30 Sep 2025 01:21:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 12/49] builtin/repack.c: pass both pack_objects args to
 repack_config
Message-ID: <aNsUeH2HudfxIQsx@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <75386eed60c80a52c42720e4918853ff05c5584c.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75386eed60c80a52c42720e4918853ff05c5584c.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:07:56PM -0400, Taylor Blau wrote:
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 6dfcb3327e..af6de8d77a 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1260,6 +1266,7 @@ int cmd_repack(int argc,
>  	size_t midx_pack_names_nr = 0;
>  
>  	/* variables to be filled by option parsing */
> +	struct repack_config_ctx config_ctx;
>  	int delete_redundant = 0;
>  	const char *unpack_unreachable = NULL;
>  	int keep_unreachable = 0;
> @@ -1343,7 +1350,11 @@ int cmd_repack(int argc,
>  
>  	list_objects_filter_init(&po_args.filter_options);
>  
> -	repo_config(repo, repack_config, &cruft_po_args);
> +	memset(&config_ctx, 0, sizeof(config_ctx));
> +	config_ctx.po_args = &po_args;
> +	config_ctx.cruft_po_args = &cruft_po_args;
> +
> +	repo_config(repo, repack_config, &config_ctx);

Nit: same comment here as on a previous commit, we could use a
designated initializer here.

Patrick
